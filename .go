package agent

import (
	"context"
	"fmt"
	"time"

	"code.byted.org/vecode/vecode/api/kitex/kitex_gen/agent"
	"code.byted.org/vecode/vecode/api/kitex/kitex_gen/copilot"
	"code.byted.org/vecode/vecode/api/kitex/kitex_gen/vecode"
)

var _ vecode.AgentService = (*Handler)(nil)

type Handler struct{}

func (h *Handler) CompleteChat(ctx context.Context, req *agent.CompleteChatRequest, stream vecode.AgentService_CompleteChatServer) (err error) {
	// Mock implementation: send some test data to the stream

	// 1. Send partial message events (simulating streaming response)
	messages := []string{
		"你好！我是一个 AI 助手。",
		"我可以帮助你处理代码相关的问题。",
		"请告诉我你需要什么帮助？",
	}

	for i, msg := range messages {
		isLast := i == len(messages)-1

		// Create partial message event
		partialEvent := &copilot.Event{
			Type:      copilot.EventTypePartialMessage,
			Id:        fmt.Sprintf("partial_%d", i+1),
			CreatedAt: time.Now().Format(time.RFC3339),
			Detail: &copilot.EventDetail{
				PartialMessage: &copilot.PartialMessageEvent{
					Message: &copilot.Message{
						Id:   fmt.Sprintf("msg_%d", i+1),
						Role: copilot.RoleAgent,
						Parts: []*copilot.Part{
							{
								Text: &copilot.TextPart{
									Text: msg,
								},
							},
						},
					},
					LastChunk: isLast,
				},
			},
		}

		response := &agent.CompleteChatResponse{
			Event: partialEvent,
		}

		if err := stream.Send(ctx, response); err != nil {
			return fmt.Errorf("failed to send partial message: %w", err)
		}

		// Add small delay to simulate streaming
		time.Sleep(100 * time.Millisecond)
	}

	// 2. Send full message event
	fullEvent := &copilot.Event{
		Type:      copilot.EventTypeFullMessage,
		Id:        "full_1",
		CreatedAt: time.Now().Format(time.RFC3339),
		Detail: &copilot.EventDetail{
			FullMessage: &copilot.FullMessageEvent{
				Message: &copilot.Message{
					Id:   "msg_complete",
					Role: copilot.RoleAgent,
					Parts: []*copilot.Part{
						{
							Text: &copilot.TextPart{
								Text: "你好！我是一个 AI 助手。我可以帮助你处理代码相关的问题。请告诉我你需要什么帮助？",
							},
						},
					},
				},
			},
		},
	}

	fullResponse := &agent.CompleteChatResponse{
		Event: fullEvent,
	}

	if err := stream.Send(ctx, fullResponse); err != nil {
		return fmt.Errorf("failed to send full message: %w", err)
	}

	// 3. Send task status update (completion)
	statusEvent := &copilot.Event{
		Type:      copilot.EventTypeTaskStatusUpdate,
		Id:        "status_1",
		CreatedAt: time.Now().Format(time.RFC3339),
		Detail: &copilot.EventDetail{
			TaskStatusUpdate: &copilot.TaskStatusUpdateEvent{
				Status: copilot.TaskStatusCompleted,
				Final:  true,
			},
		},
	}

	statusResponse := &agent.CompleteChatResponse{
		Event: statusEvent,
	}

	if err := stream.Send(ctx, statusResponse); err != nil {
		return fmt.Errorf("failed to send status update: %w", err)
	}

	return nil
}
