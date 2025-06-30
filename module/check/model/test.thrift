include 'account.thrift'
include 'activity.thrift'
include 'app.thrift'
include 'app_review.thrift'
include 'bytedance.thrift'
include 'check_run.thrift'
include 'comment.thrift'
include 'common.thrift'
include 'frontier.thrift'
include 'instance.thrift'
include 'lfs.thrift'
include 'merge_queue.thrift'
include 'merge_request.thrift'
include 'namespace.thrift'
include 'notification.thrift'
include 'ops.thrift'
include 'owner.thrift'
include 'protected_branch.thrift'
include 'protected_tag.thrift'
include 'release.thrift'
include 'repository.thrift'
include 'review.thrift'
include 'route.thrift'
include 'search.thrift'
include 'settings.thrift'
include 'timeline.thrift'
include 'vcs.thrift'
include 'webhook.thrift'
include 'webhook_event.thrift'
include 'work_item.thrift'
include "attention.thrift"
include 'label.thrift'
include "viewgraph.thrift"
// not used by this file, only used for bam
include 'vecode_http.thrift'
// not used by this file, only included for code generation
include 'event.thrift'
include 'frontier_event.thrift'


// bam thrift idl spec: https://bytedance.feishu.cn/wiki/wikcnBevBcZqVc0bbuFr0JLr92d
//   api.get: get请求，值为http path，uri的语法与gin一致
//   api.post: post请求，值为http path，uri的语法与gin一致 (vecode请求暂时都是post)
//   api.put: put请求，值为http path，uri的语法与gin一致
//   api.delete: delete请求，值为http path，uri的语法与gin一致
//   api.patch: patch请求，值为http path，uri的语法与gin一致
//   api.serializer: Request body序列化方式，对应content-type header，默认为json，枚举值支持：
//      json(application/json)
//      form(application/x-www-form-urlencoded)
//      pb(application/x-protobuf)
//      muti-form(multipart/form-data)
//   api.resp_serializer: Response body序列化方式，与api.serializer类似
//   api.api_level: 接口等级，Value 为0-4 之间取值，https://bytedance.feishu.cn/wiki/wikcnmmGyjem7KIERj6KiOcXoWD
//   api.category: 接口分类，根据该分类自动生成到doc文档的目录里。支持/分隔的多级目录，在bam上会按这个分类进行展示

// method上的元数据通过 vecode.meta 定义
// 每个method只支持唯一的vecode.meta，各个value用逗号隔开，中间不要有空格，也不要有多余的引号，示例：vecode.meta='read,dgit,frontier,cluster=default'
// 解析逻辑：tools/idlmetagen/main.go 各个meta字段于生成文件字段的定义关系直接读这个工具的代码吧
// 目标文件位置：util/idlmeta/idlmeta_gen.go
// 当前支持的元数据类型：见util/idlmeta/idlmeta_gen.go:ActionMeta (ServiceName比较特殊，不是在vecode.meta中定义，而是看method定义在哪个service中)
//   read: 是否是读请求，对写请求直接省略
//   dgit: 是否是dgit专用的请求，非dgit接口直接省略
//   frontier: 是否是frontier专用的请求，非frontier接口直接省略
//   cluster=xxx: 部署在哪个集群，默认default
//   script: 是否是一次性脚本(这部分谨慎增加，现有的也会在将来清除掉)
//   openapi: 是否是openapi，非openapi接口直接省略，非内部服务&前端调用非openapi会报错


service RepositoryService {
    /** 创建仓库 */
    repository.RepositoryResponse CreateRepository(1: repository.CreateRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/CreateRepository', api.category='repository', api.api_level='1'),
    /** 根据id获取仓库 */
    repository.RepositoryResponse GetRepository(1: repository.GetRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/GetRepository', api.category='repository', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo:read'),
    /** 更新仓库信息与设置 */
    repository.UpdateRepositoryResponse UpdateRepository(1: repository.UpdateRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/UpdateRepository', api.category='repository', api.api_level='1', vecode.meta='openapi', vecode.scope='repo:write'),
    /** 删除仓库 */
    repository.DeleteRepositoryResponse DeleteRepository(1: repository.DeleteRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/DeleteRepository', api.category='repository', api.api_level='1'),
    /** 恢复被删除的仓库 */
    repository.RestoreRepositoryResponse RestoreRepository(1: repository.RestoreRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/RestoreRepository', api.category='repository', api.api_level='1'),
    /** 归档仓库 */
    repository.ArchiveRepositoryResponse ArchiveRepository(1: repository.ArchiveRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/ArchiveRepository', api.category='repository', api.api_level='1'),
    /** 恢复被归档的仓库 */
    repository.UnarchiveRepositoryResponse UnarchiveRepository(1: repository.UnarchiveRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/UnarchiveRepository', api.category='repository', api.api_level='1'),
    /** 获取仓库列表 */
    repository.ListRepositoriesResponse ListRepositories(1: repository.ListRepositoriesRequest req) throws (1: common.Error err) (
        api.post = '/ListRepositories', api.category='repository', api.api_level='1', vecode.meta='read'),
    /** gitignore模板列表 */
    repository.ListGitignoreTemplatesResponse ListGitignoreTemplates(1: repository.ListGitignoreTemplatesRequest req) throws (1: common.Error err) (
        api.post = '/ListGitignoreTemplates', api.category='repository', api.api_level='1', vecode.meta='read'),
    /** 初始化仓库 */
    repository.InitRepositoryResponse InitRepository(1: repository.InitRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/InitRepository', api.category='repository', api.api_level='1'),
    /** 迁移仓库到另一个仓库空间 */
    repository.TransferRepositoryResponse TransferRepository(1: repository.TransferRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/TransferRepository', api.category='repository', api.api_level='1'),
    /** 收藏仓库 */
    repository.StarRepositoryResponse StarRepository(1: repository.StarRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/StarRepository', api.category='repository', api.api_level='1'),
    /** 取消收藏仓库 */
    repository.UnstarRepositoryResponse UnstarRepository(1: repository.UnstarRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/UnstarRepository', api.category='repository', api.api_level='1'),
    /** 触发仓库统计分析*/
    repository.TriggerRepositoryStatTaskResponse TriggerRepositoryStatTask(1: repository.TriggerRepositoryStatTaskRequest req) throws (1: common.Error err) (
        api.post = '/TriggerRepositoryStatTask', api.category='repository', api.api_level='1'),
    /** 置顶仓库 */
    repository.PinRepositoryResponse PinRepository(1: repository.PinRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/PinRepository', api.category='repository', api.api_level='1'),
    /** 取消置顶仓库 */
    repository.UnpinRepositoryResponse UnpinRepository(1: repository.UnpinRepositoryRequest req) throws (1: common.Error err) (
        api.post = '/UnpinRepository', api.category='repository', api.api_level='1'),
    /** 获取置顶仓库列表 */
    repository.ListPinnedRepositoriesResponse ListPinnedRepositories(1: repository.ListPinnedRepositoriesRequest req) throws (1: common.Error err) (
        api.post = '/ListPinnedRepositories', api.category='repository', api.api_level='1', vecode.meta='read'),
    /** 修改置顶仓库列表 */
    repository.UpdatePinnedRepositoriesResponse UpdatePinnedRepositories(1: repository.UpdatePinnedRepositoriesRequest req) throws (1: common.Error err) (
        api.post = '/UpdatePinnedRepositories', api.category='repository', api.api_level='1'),
    /** 获取仓库的 features 列表 */
    repository.ListRepositoryFeaturesResponse ListRepositoryFeatures(1: repository.ListRepositoryFeaturesRequest req) throws (1: common.Error err) (
        api.post = '/ListRepositoryFeatures', api.category='repository', api.api_level='1', vecode.meta='read'),
    /** 搜索仓库的 topics 列表 */
    repository.SearchRepositoryTopicsResponse SearchRepositoryTopics(1: repository.SearchRepositoryTopicsRequest req) throws (1: common.Error err) (
        api.post = '/SearchRepositoryTopics', api.category='repository', api.api_level='1', vecode.meta='read'),
}

service VCSService {
    vcs.DGitCheckPermissionResponse DGitCheckPermission(1: vcs.DGitCheckPermissionRequest req) throws (1: common.Error err) (
        api.post = '/DGitCheckPermission', api.category='vcs', api.api_level='0', vecode.meta='read,dgit'),
    /** TODO: Deprecated */
    vcs.DGitAuthByPublicKeyResponse DGitAuthByPublicKey(1: vcs.DGitAuthByPublicKeyRequest req) throws (1: common.Error err) (
        api.post = '/DGitAuthByPublicKey', api.category='vcs', api.api_level='0', vecode.meta='read,dgit'),
    vcs.DGitPreReceiveResponse DGitPreReceive(1: vcs.DGitPreReceiveRequest req) throws (1: common.Error err) (
        api.post = '/DGitPreReceive', api.category='vcs', api.api_level='0', vecode.meta='read,dgit'),
    vcs.DGitPostReceiveResponse DGitPostReceive(1: vcs.DGitPostReceiveRequest req) throws (1: common.Error err) (
        api.post = '/DGitPostReceive', api.category='vcs', api.api_level='0', vecode.meta='dgit'),
    vcs.DGitProcReceiveResponse DGitProcReceive(1: vcs.DGitProcReceiveRequest req) throws (1: common.Error err) (
        api.post = '/DGitProcReceive', api.category='vcs', api.api_level='0', vecode.meta='dgit'),
    /** Get overview of the Git Repository.*/
    vcs.GetGitRepoResponse GetGitRepo(1: vcs.GetGitRepoRequest req) throws (1: common.Error err) (
        api.post = '/GetGitRepo', api.category='vcs', api.api_level='0', vecode.meta='read'),
    /** Get the default branch of the Git repository, which may be empty.*/
    vcs.GetDefaultBranchResponse GetDefaultBranch(1: vcs.GetDefaultBranchRequest req) throws (1: common.Error err) (
        api.post = '/GetDefaultBranch', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get the README files of the given path.*/
    vcs.GetREADMEFileResponse GetREADMEFile(1: vcs.GetREADMEFileRequest req) throws (1: common.Error err) (
        api.post = '/GetREADMEFile', api.category='vcs', api.api_level='0', vecode.meta='read'),
    /** Search or list branches.*/
    vcs.ListBranchesResponse ListBranches(1: vcs.ListBranchesRequest req) throws (1: common.Error err) (
        api.post = '/ListBranches', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get branch by name.*/
    vcs.GetBranchResponse GetBranch(1: vcs.GetBranchRequest req) throws (1: common.Error err) (
        api.post = '/GetBranch', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Search or list tags.*/
    vcs.ListTagsResponse ListTags(1: vcs.ListTagsRequest req) throws (1: common.Error err) (
        api.post = '/ListTags', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get tag by name.*/
    vcs.GetTagResponse GetTag(1: vcs.GetTagRequest req) throws (1: common.Error err) (
        api.post = '/GetTag', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Create tag. */
    vcs.CreateTagResponse CreateTag(1: vcs.CreateTagRequest req) throws (1: common.Error err) (
        api.post = '/CreateTag', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Delete tag. */
    vcs.DeleteTagResponse DeleteTag(1: vcs.DeleteTagRequest req) throws (1: common.Error err) (
        api.post = '/DeleteTag', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Get file by path.*/
    vcs.GetFileResponse GetFile(1: vcs.GetFileRequest req) throws (1: common.Error err) (
        api.post = '/GetFile', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List directory entries by path.*/
    vcs.ListDirectoryEntriesResponse ListDirectoryEntries(1: vcs.ListDirectoryEntriesRequest req) throws (1: common.Error err) (
        api.post = '/ListDirectoryEntries', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get a list of files by paths.*/
    vcs.ListFilesResponse ListFiles(1: vcs.ListFilesRequest req) throws (1: common.Error err) (
        api.post = '/ListFiles', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get a list of filepaths.*/
    vcs.ListFilePathsResponse ListFilePaths(1: vcs.ListFilePathsRequest req) throws (1: common.Error err) (
        api.post = '/ListFilePaths', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get commit by revision.*/
    vcs.GetCommitResponse GetCommit(1: vcs.GetCommitRequest req) throws (1: common.Error err) (
        api.post = '/GetCommit', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get commit network.*/
    vcs.GetCommitNetworkResponse GetCommitNetwork(1: vcs.GetCommitNetworkRequest req) throws (1: common.Error err) (
        api.post = '/GetCommitNetwork', api.category='vcs', api.api_level='1', vecode.meta='read', vecode.scope='repo.content:read'),
    /** List commits history.*/
    vcs.ListCommitsResponse ListCommits(1: vcs.ListCommitsRequest req) throws (1: common.Error err) (
        api.post = '/ListCommits', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List diff files info of the given two commits.*/
    vcs.ListDiffFilesResponse ListDiffFiles(1: vcs.ListDiffFilesRequest req) throws (1: common.Error err) (
        api.post = '/ListDiffFiles', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List diff files contents of the given two commits.*/
    vcs.ListDiffFileContentsResponse ListDiffFileContents(1: vcs.ListDiffFileContentsRequest req) throws (1: common.Error err) (
        api.post = '/ListDiffFileContents', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List diff commits between the given two commits.*/
    vcs.ListDiffCommitsResponse ListDiffCommits(1: vcs.ListDiffCommitsRequest req) throws (1: common.Error err) (
        api.post = '/ListDiffCommits', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List range diff files info of the given two ranges.*/
    vcs.ListRangeDiffFilesResponse ListRangeDiffFiles(1: vcs.ListRangeDiffFilesRequest req) throws (1: common.Error err) (
        api.post = '/ListRangeDiffFiles', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** List range diff files contents of the given two ranges.*/
    vcs.ListRangeDiffFileContentsResponse ListRangeDiffFileContents(1: vcs.ListRangeDiffFileContentsRequest req) throws (1: common.Error err) (
        api.post = '/ListRangeDiffFileContents', api.category='vcs', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Get blame of the given line range.*/
    vcs.GetBlameResponse GetBlame(1: vcs.GetBlameRequest req) throws (1: common.Error err) (
        api.post = '/GetBlame', api.category='vcs', api.api_level='1', vecode.meta='read,openapi'),
    /** Get the last commit which modified the file path.*/
    vcs.ListPathLastCommitsResponse ListPathLastCommits(1: vcs.ListPathLastCommitsRequest req) throws (1: common.Error err) (
        api.post = '/ListPathLastCommits', api.category='vcs', api.api_level='1', vecode.meta='read'),
    /** Create a branch from the existed commit/branch/tag.*/
    vcs.CreateBranchResponse CreateBranch(1: vcs.CreateBranchRequest req) throws (1: common.Error err) (
        api.post = '/CreateBranch', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Delete the branch by name.*/
    vcs.DeleteBranchResponse DeleteBranch(1: vcs.DeleteBranchRequest req) throws (1: common.Error err) (
        api.post = '/DeleteBranch', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Delete branches by type. */
    vcs.DeleteBranchesResponse DeleteBranches(1: vcs.DeleteBranchesRequest req) throws (1: common.Error err) (
        api.post = '/DeleteBranches', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Count the ahead and behind commis between the two commits.*/
    vcs.CountDivergingCommitsResponse CountDivergingCommits(1: vcs.CountDivergingCommitsRequest req) throws (1: common.Error err) (
        api.post = '/CountDivergingCommits', api.category='vcs', api.api_level='1', vecode.meta='read,openapi', vecode.scope='repo.content:read'),
    /** Create a commit with multiple files and actions. eg: `create`, `update`, `delete`, `move`, `chmod`, `create_dir` */
    vcs.CreateCommitResponse CreateCommit(1: vcs.CreateCommitRequest req) throws (1: common.Error err) (
        api.post = '/CreateCommit', api.category='vcs', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.content:write'),
    /** Cherry pick a commit to target branch */
    vcs.CherryPickResponse CherryPick(1: vcs.CherryPickRequest req) throws (1: common.Error err) (
        api.post = '/CherryPick', api.category='vcs', api.api_level='1'),
    /** Revert a commit to target branch */
    vcs.RevertResponse Revert(1: vcs.RevertRequest req) throws (1: common.Error err) (
        api.post = '/Revert', api.category='vcs', api.api_level='1'),
    /** Rebase the source branch of the merge request to its target branch */
    vcs.RebaseResponse Rebase(1: vcs.RebaseRequest req) throws (1: common.Error err) (
        api.post = '/Rebase', api.category='vcs', api.api_level='1' vecode.meta='openapi', vecode.scope='repo.content:write'),
}

service ReleaseService {
    release.ListReleasesResponse ListReleases(1: release.ListReleasesRequest req) throws (1: common.Error err) (
        api.post = '/ListReleases', api.category='release', api.api_level='0', vecode.meta='read'),
    release.GetReleaseResponse GetRelease(1: release.GetReleaseRequest req) throws (1: common.Error err) (
        api.post = '/GetRelease', api.category='release', api.api_level='0', vecode.meta='read'),
    release.CreateReleaseResponse CreateRelease(1: release.CreateReleaseRequest req) throws (1: common.Error err) (
        api.post = '/CreateRelease', api.category='release', api.api_level='0'),
    release.UpdateReleaseResponse UpdateRelease(1: release.UpdateReleaseRequest req) throws (1: common.Error err) (
        api.post = '/UpdateRelease', api.category='release', api.api_level='0'),
    release.DeleteReleaseResponse DeleteRelease(1: release.DeleteReleaseRequest req) throws (1: common.Error err) (
        api.post = '/DeleteRelease', api.category='release', api.api_level='0'),
}

service MergeRequestService {
    merge_request.CreateMergeRequestResponse CreateMergeRequest(1: merge_request.CreateMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/CreateMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.GetMergeRequestResponse GetMergeRequest(1: merge_request.GetMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    merge_request.BatchGetMergeRequestsResponse BatchGetMergeRequests(1: merge_request.BatchGetMergeRequestsRequest req) throws (1: common.Error err) (
        api.post = '/BatchGetMergeRequests', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    merge_request.CloseMergeRequestResponse CloseMergeRequest(1: merge_request.CloseMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/CloseMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.ReopenMergeRequestResponse ReopenMergeRequest(1: merge_request.ReopenMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/ReopenMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.UpdateMergeRequestResponse UpdateMergeRequest(1: merge_request.UpdateMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/UpdateMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.BatchUpdateMergeRequestsResponse BatchUpdateMergeRequests(1: merge_request.BatchUpdateMergeRequestsRequest req) throws (1: common.Error err) (
        api.post = '/BatchUpdateMergeRequests', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.MergeMergeRequestResponse MergeMergeRequest(1: merge_request.MergeMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/MergeMergeRequest', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    merge_request.GetMergeRequestMergeabilityResponse GetMergeRequestMergeability(1: merge_request.GetMergeRequestMergeabilityRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestMergeability', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    merge_request.GetMergeRequestMergeabilityDetailResponse GetMergeRequestMergeabilityDetail(1: merge_request.GetMergeRequestMergeabilityDetailRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestMergeabilityDetail', api.category='merge_request', api.api_level='0', vecode.meta='read', vecode.scope='repo.merge_request:read'),
    merge_request.ListRepoMergeRequestsResponse ListRepoMergeRequests(1: merge_request.ListRepoMergeRequestsRequest req) throws (1: common.Error err) (
        api.post = '/ListRepoMergeRequests', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    merge_request.GetRepoMergeRequestsCountResponse GetRepoMergeRequestsCount(1: merge_request.GetRepoMergeRequestsCountRequest req) throws (1: common.Error err) (
        api.post = '/GetRepoMergeRequestsCount', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    merge_request.ListStackMergeRequestsResponse ListStackMergeRequests(1: merge_request.ListStackMergeRequestsRequest req) throws (1: common.Error err) (
        api.post = '/ListStackMergeRequests', api.category='merge_request', api.api_level='0', vecode.meta='read'),
    /** 对于每个分支，返回其作为源分支使用的 open 的 merge request */
    merge_request.MListOpenMergeRequestsBySourceBranchesResponse MListOpenMergeRequestsBySourceBranches(1: merge_request.MListOpenMergeRequestsBySourceBranchesRequest req) throws (1: common.Error err) (
        api.post = '/MListOpenMergeRequestsBySourceBranches', api.category='merge_request', api.api_level='0', vecode.meta='read'),

    merge_request.ListMergeRequestBypassesResponse ListMergeRequestBypasses(1: merge_request.ListMergeRequestBypassesRequest req) throws (1: common.Error err) (
        api.post = '/ListMergeRequestBypasses', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request.bypass:read'),
    merge_request.CreateMergeRequestBypassesResponse CreateMergeRequestBypasses(1: merge_request.CreateMergeRequestBypassesRequest req) throws (1: common.Error err) (
        api.post = '/CreateMergeRequestBypasses', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request.bypass:write'),
    merge_request.GetMergeRequestSettingResponse GetMergeRequestSetting(1: merge_request.GetMergeRequestSettingRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestSetting', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),

    /** List merge request templates.*/
    merge_request.ListMergeRequestTemplatesResponse ListMergeRequestTemplates(1: merge_request.ListMergeRequestTemplatesRequest req) throws (1: common.Error err) (
        api.post = '/ListMergeRequestTemplates', api.category='vcs', api.api_level='0', vecode.meta='read'),
    /** Get merge request template by name.*/
    merge_request.GetMergeRequestTemplateResponse GetMergeRequestTemplate(1: merge_request.GetMergeRequestTemplateRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestTemplate', api.category='vcs', api.api_level='0', vecode.meta='read'),

    /** List merge request conflict infos.*/
    merge_request.ListMergeRequestConflictsResponse ListMergeRequestConflicts(1: merge_request.ListMergeRequestConflictsRequest req) throws (1: common.Error err) (
        api.post = '/ListMergeRequestConflicts', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    /** Get merge request conflict info.*/
    merge_request.GetMergeRequestConflictResponse GetMergeRequestConflict(1: merge_request.GetMergeRequestConflictRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestConflict', api.category='merge_request', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    /** Resolve merge request conflict.*/
    merge_request.ResolveMergeRequestConflictsResponse ResolveMergeRequestConflicts(1: merge_request.ResolveMergeRequestConflictsRequest req) throws (1: common.Error err) (
        api.post = '/ResolveMergeRequestConflicts', api.category='merge_request', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    /** Check current can resolve merge request conflict in ui.*/
    merge_request.CanResolveMergeRequestConflictsInUIResponse CanResolveMergeRequestConflictsInUI(1: merge_request.CanResolveMergeRequestConflictsInUIRequest req) throws (1: common.Error err) (
        api.post = '/CanResolveMergeRequestConflictsInUI', api.category='merge_request', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request:read'),
}

service CommentService {
    comment.CreateDraftCommentResponse CreateDraftComment(1: comment.CreateDraftCommentRequest req) throws (1: common.Error err) (
        api.post = '/CreateDraftComment', api.category='comment', api.api_level='0'),
    comment.UpdateDraftCommentResponse UpdateDraftComment(1: comment.UpdateDraftCommentRequest req) throws (1: common.Error err) (
        api.post = '/UpdateDraftComment', api.category='comment', api.api_level='0'),
    comment.PublishDraftCommentsResponse PublishDraftComments(1: comment.PublishDraftCommentsRequest req) throws (1: common.Error err) (
        api.post = '/PublishDraftComments', api.category='comment', api.api_level='0'),
    /** Delete current user's specified draft*/
    comment.DeleteDraftCommentResponse DeleteDraftComment(1: comment.DeleteDraftCommentRequest req) throws (1: common.Error err) (
        api.post = '/DeleteDraftComment', api.category='comment', api.api_level='0'),
    /** Delete all current user's drafts of the commentable object*/
    comment.DeleteDraftCommentsResponse DeleteDraftComments(1: comment.DeleteDraftCommentsRequest req) throws (1: common.Error err) (
        api.post = '/DeleteDraftComments', api.category='comment', api.api_level='0'),

    comment.CreateCommentResponse CreateComment(1: comment.CreateCommentRequest req) throws (1: common.Error err) (
        api.post = '/CreateComment', api.category='comment', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.comment:write'),
    comment.UpdateCommentResponse UpdateComment(1: comment.UpdateCommentRequest req) throws (1: common.Error err) (
        api.post = '/UpdateComment', api.category='comment', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.comment:write'),
    comment.DeleteCommentResponse DeleteComment(1: comment.DeleteCommentRequest req) throws (1: common.Error err) (
        api.post = '/DeleteComment', api.category='comment', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.comment:write'),
    comment.GetCommentResponse GetComment(1: comment.GetCommentRequest req) throws (1: common.Error err) (
        api.post = '/GetComment', api.category='comment', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.comment:read'),

    comment.UpdateThreadResponse UpdateThread(1: comment.UpdateThreadRequest req) throws (1: common.Error err) (
        api.post = '/UpdateThread', api.category='comment', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.comment:write'),
    comment.ListThreadsResponse ListThreads(1: comment.ListThreadsRequest req) throws (1: common.Error err) (
        api.post = '/ListThreads', api.category='comment', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.comment:read'),
    comment.GetThreadResponse GetThread(1: comment.GetThreadRequest req) throws (1: common.Error err) (
        api.post = '/GetThread', api.category='comment', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.comment:read'),
    comment.MGetThreadsCountsResponse MGetThreadsCounts(1: comment.MGetThreadsCountsRequest req) throws (1: common.Error err) (
        api.post = '/MGetThreadsCounts', api.category='comment', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.comment:read'),
    comment.MGetThreadsResponse MGetThreads(1: comment.MGetThreadsRequest req) throws (1: common.Error err) (
        api.post = '/MGetThreads', api.category='comment', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.comment:read'),
    comment.CreateCommentReactionResponse CreateCommentReaction(1: comment.CreateCommentReactionRequest req) throws (1: common.Error err) (
        api.post = '/CreateCommentReaction', api.category='comment', api.api_level='2'),
    comment.DeleteCommentReactionResponse DeleteCommentReaction(1: comment.DeleteCommentReactionRequest req) throws (1: common.Error err) (
        api.post = '/DeleteCommentReaction', api.category='comment', api.api_level='2'),
    comment.ApplySuggestionsResponse ApplySuggestions(1: comment.ApplySuggestionsRequest req) throws (1: common.Error err) (
        api.post = '/ApplySuggestions', api.category='comment', api.api_level='2'),
}

service NamespaceService {
    /** 创建仓库空间*/
    namespace.CreateNamespaceResponse CreateNamespace(1: namespace.CreateNamespaceRequest req) throws (1: common.Error err) (
        api.post = '/CreateNamespace', api.category='namespace', api.api_level='1'),
    /** 获取仓库空间详情*/
    namespace.GetNamespaceResponse GetNamespace(1: namespace.GetNamespaceRequest req) throws (1: common.Error err) (
        api.post = '/GetNamespace', api.category='namespace', api.api_level='1', vecode.meta='read'),
    /** 获取当前租户下所有仓库空间的列表，不返回详情，只返回名称列表，给前端下拉列表用*/
    namespace.ListAllNamespacesResponse ListAllNamespaces(1: namespace.ListAllNamespacesRequest req) throws (1: common.Error err) (
        api.post = '/ListAllNamespaces', api.category='namespace', api.api_level='1', vecode.meta='read'),
    /** 获取特定仓库空间的所有子空间, ParentId如果为空表示查询顶层代码组*/
    namespace.ListNamespacesResponse ListNamespaces(1: namespace.ListNamespacesRequest req) throws (1: common.Error err) (
        api.post = '/ListNamespaces', api.category='namespace', api.api_level='1', vecode.meta='read'),
    /** 更新仓库空间信息*/
    namespace.UpdateNamespaceResponse UpdateNamespace(1: namespace.UpdateNamespaceRequest req) throws (1: common.Error err) (
        api.post = '/UpdateNamespace', api.category='namespace', api.api_level='1'),
    /** 删除仓库空间*/
    namespace.DeleteNamespaceResponse DeleteNamespace(1: namespace.DeleteNamespaceRequest req) throws (1: common.Error err) (
        api.post = '/DeleteNamespace', api.category='namespace', api.api_level='1'),
    /** 迁移仓库空间*/
    namespace.TransferNamespaceResponse TransferNamespace(1: namespace.TransferNamespaceRequest req) throws (1: common.Error err) (
        api.post = '/TransferNamespace', api.category='namespace', api.api_level='1'),
}

// For activities of the merge request.
service TimelineService {
    timeline.ListEventsResponse ListTimelineEvents(1: timeline.ListEventsRequest req) throws (1: common.Error err) (
        api.post = '/ListTimelineEvents', api.category='timeline', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
}

// For activities of the user and repository.
service ActivityService {
    activity.ListUserActivitiesResponse ListUserActivities(1: activity.ListUserActivitiesRequest req) throws (1: common.Error err) (
        api.post = '/ListUserActivities', api.category='activity', api.api_level='1'),
    activity.ListRepoActivitiesResponse ListRepoActivities(1: activity.ListRepoActivitiesRequest req) throws (1: common.Error err) (
        api.post = '/ListRepoActivities', api.category='activity', api.api_level='1'),
    activity.CountUserActivitiesByDateResponse CountUserActivitiesByDate(1: activity.CountUserActivitiesByDateRequest req) throws (1: common.Error err) (
        api.post = '/CountUserActivitiesByDate', api.category='activity', api.api_level='1'),
}

service ProtectedBranchService {
    protected_branch.CreateProtectedBranchResponse CreateProtectedBranch(1: protected_branch.CreateProtectedBranchRequest req) throws (1: common.Error err) (
        api.post='/CreateProtectedBranch', api.category='protected_branch', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_branch:write'),
    protected_branch.DeleteProtectedBranchResponse DeleteProtectedBranch(1: protected_branch.DeleteProtectedBranchRequest req) throws (1: common.Error err) (
        api.post='/DeleteProtectedBranch', api.category='protected_branch', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_branch:write'),
    protected_branch.UpdateProtectedBranchResponse UpdateProtectedBranch(1: protected_branch.UpdateProtectedBranchRequest req) throws (1: common.Error err) (
        api.post='/UpdateProtectedBranch', api.category='protected_branch', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_branch:write'),
    protected_branch.GetProtectedBranchResponse GetProtectedBranch(1: protected_branch.GetProtectedBranchRequest req) throws (1: common.Error err) (
        api.post='/GetProtectedBranch', api.category='protected_branch', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.protected_branch:read'),
    protected_branch.CheckBranchPermissionResponse CheckBranchPermission(1: protected_branch.CheckBranchPermissionRequest req) throws (1: common.Error err) (
        api.post='/CheckBranchPermission', api.category='protected_branch', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.protected_branch:read'),
    protected_branch.ListProtectedBranchesResponse ListProtectedBranches(1: protected_branch.ListProtectedBranchesRequest req) throws (1: common.Error err) (
        api.post='/ListProtectedBranches', api.category='protected_branch', api.api_level='1', vecode.meta='read,openapi', vecode.scope='repo.protected_branch:read'),
    protected_branch.MListProtectedBranchesByBranchNamesResponse MListProtectedBranches(1: protected_branch.MListProtectedBranchesByBranchNamesRequest req) throws (1: common.Error err) (
        api.post='/MListProtectedBranches', api.category='protected_branch', api.api_level='1', vecode.meta='read'),
}

service ProtectedTagService {
    protected_tag.CreateProtectedTagResponse CreateProtectedTag(1: protected_tag.CreateProtectedTagRequest req) throws (1: common.Error err) (
        api.post='/CreateProtectedTag', api.category='protected_tag', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_tag:write'),
    protected_tag.DeleteProtectedTagResponse DeleteProtectedTag(1: protected_tag.DeleteProtectedTagRequest req) throws (1: common.Error err) (
        api.post='/DeleteProtectedTag', api.category='protected_tag', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_tag:write'),
    protected_tag.UpdateProtectedTagResponse UpdateProtectedTag(1: protected_tag.UpdateProtectedTagRequest req) throws (1: common.Error err) (
        api.post='/UpdateProtectedTag', api.category='protected_tag', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.protected_tag:write'),
    protected_tag.GetProtectedTagResponse GetProtectedTag(1: protected_tag.GetProtectedTagRequest req) throws (1: common.Error err) (
        api.post='/GetProtectedTag', api.category='protected_tag', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.protected_tag:read'),
    protected_tag.ListProtectedTagsResponse ListProtectedTags(1: protected_tag.ListProtectedTagsRequest req) throws (1: common.Error err) (
        api.post='/ListProtectedTags', api.category='protected_tag', api.api_level='1', vecode.meta='read'),
    protected_tag.MListProtectedTagsByTagNamesResponse MListProtectedTags(1: protected_tag.MListProtectedTagsByTagNamesRequest req) throws (1: common.Error err) (
        api.post='/MListProtectedTags', api.category='protected_tag', api.api_level='1', vecode.meta='read'),
}

service AccountService {
    /** 获取当前用户信息*/
    account.GetUserResponse GetUser(1: account.GetUserRequest req) throws (1: common.Error err) (
        api.post = '/GetUser', api.category='account', api.api_level='0', vecode.meta='read'),
    /** 搜索用户 */
    account.ListUsersResponse ListUsers(1: account.ListUsersRequest req) throws (1: common.Error err) (
        api.post = '/ListUsers', api.category='account', api.api_level='0', vecode.meta='read'),
    /** 更新用户信息*/
    account.UpdateUserResponse UpdateUser(1: account.UpdateUserRequest req) throws (1: common.Error err) (
        api.post = '/UpdateUser', api.category='account', api.api_level='2'),
    /** 临时接口：根据iam user id 获取 user id */
    account.GetIAMUserResponse GetIAMUser(1: account.GetIAMUserRequest req) throws (1: common.Error err) (
        api.post = '/GetIAMUser', api.category='account', api.api_level='3', vecode.meta='read'),

    /** 给当前用户添加邮箱*/
    account.CreateEmailResponse CreateEmail(1: account.CreateEmailRequest req) throws (1: common.Error err) (
        api.post = '/CreateEmail', api.category='account', api.api_level='2'),
    /** 获取当前用户绑定的邮箱列表*/
    account.ListEmailsResponse ListEmails(1: account.ListEmailsRequest req) throws (1: common.Error err) (
        api.post = '/ListEmails', api.category='account', api.api_level='2', vecode.meta='read'),
    /** 删除邮箱*/
    account.DeleteEmailResponse DeleteEmail(1: account.DeleteEmailRequest req) throws (1: common.Error err) (
        api.post = '/DeleteEmail', api.category='account', api.api_level='2'),

    /** 重置 HTTP 密码 */
    account.ResetHTTPPasswordResponse ResetHTTPPassword(1: account.ResetHTTPPasswordRequest req) throws (1: common.Error err) (
        api.post = '/ResetHTTPPassword', api.category='account', api.api_level='2'),

    /** 新增ssh key*/
    account.CreateSSHPublicKeyResponse CreateSSHPublicKey(1: account.CreateSSHPublicKeyRequest req) throws (1: common.Error err) (
        api.post = '/CreateSSHPublicKey', api.category='account', api.api_level='2'),
    /** 获取当前用户的ssh key列表*/
    account.ListSSHPublicKeysResponse ListSSHPublicKeys(1: account.ListSSHPublicKeysRequest req) throws (1: common.Error err) (
        api.post = '/ListSSHPublicKeys', api.category='account', api.api_level='2', vecode.meta='read'),
    /** 删除ssh key*/
    account.DeleteSSHPublicKeyResponse DeleteSSHPublicKey(1: account.DeleteSSHPublicKeyRequest req) throws (1: common.Error err) (
        api.post = '/DeleteSSHPublicKey', api.category='account', api.api_level='2'),

    /** 获取当前用户的 jwt */
    account.GetCurrentUserJWTResponse GetCurrentUserJWT(1: account.GetCurrentUserJWTRequest req) throws (1: common.Error err) (
        api.post = '/GetCurrentUserJWT', api.category='account', api.api_level='0', vecode.meta='read'),

    account.GetLastBranchPushResponse GetLastBranchPush(1: account.GetLastBranchPushRequest req) throws (1: common.Error err) (
        api.post = '/GetLastBranchPush', api.category='account', api.api_level='2', vecode.meta='read'),

    /** 获取用户统计数据 */
    account.GetUserStatisticsResponse GetUserStatistics(1: account.GetUserStatisticsRequest req) throws (1: common.Error err) (
        api.post='/GetUserStatistics', api.category='account', api.api_level='0', vecode.meta='read'),
}

service ReviewService {
    review.ListReviewersResponse ListReviewers(1: review.ListReviewersRequest req) throws (1: common.Error err) (
        api.post = '/ListReviewers', api.category='review', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request.review:read'),
    review.UpdateReviewersResponse UpdateReviewers(1: review.UpdateReviewersRequest req) throws (1: common.Error err) (
        api.post = '/UpdateReviewers', api.category='review', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request.review:write'),
    review.CreateReviewResponse CreateReview(1: review.CreateReviewRequest req) throws (1: common.Error err) (
        api.post = '/CreateReview', api.category='review', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.merge_request.review:write'),
    review.GetReviewStatusResponse GetReviewStatus(1: review.GetReviewStatusRequest req) throws (1: common.Error err) (
        api.post = '/GetReviewStatus', api.category='review', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_request.review:read'),
    /** 获取 mr 创建页需展示的 review 设置*/
    review.PreviewReviewSettingResponse PreviewReviewSetting(1: review.PreviewReviewSettingRequest req) throws (1: common.Error err) (
        api.post = '/PreviewReviewSetting', api.category='review', api.api_level='0', vecode.meta='read'),
    review.MarkMergeRequestFileAsViewedResponse MarkMergeRequestFileAsViewed(1: review.MarkMergeRequestFileAsViewedRequest req) throws (1: common.Error err) (
        api.post = '/MarkMergeRequestFileAsViewed', api.category='review', api.api_level='1'),
    review.MarkMergeRequestFileAsUnviewedResponse MarkMergeRequestFileAsUnviewed(1: review.MarkMergeRequestFileAsUnviewedRequest req) throws (1: common.Error err) (
        api.post = '/MarkMergeRequestFileAsUnviewed', api.category='review', api.api_level='1'),
    review.ListViewedMergeRequestFilesResponse ListViewedMergeRequestFiles(1: review.ListViewedMergeRequestFilesRequest req) throws (1: common.Error err) (
        api.post = '/ListViewedMergeRequestFiles', api.category='review', api.api_level='1', vecode.meta='read'),
    review.ListSuggestedReviewersResponse ListSuggestedReviewers(1: review.ListSuggestedReviewersRequest req) throws (1: common.Error err) (
        api.post = '/ListSuggestedReviewers', api.category='review', api.api_level='1', vecode.meta='read'),
    review.ListSuggestedReviewersForPreviewResponse ListSuggestedReviewersForPreview(1: review.ListSuggestedReviewersForPreviewRequest req) throws (1: common.Error err) (
        api.post = '/ListSuggestedReviewersForPreview', api.category='review', api.api_level='1', vecode.meta='read'),
    review.FilterOwnedFilePathsResponse FilterOwnedFilePaths(1: review.FilterOwnedFilePathsRequest req) throws (1: common.Error err) (
        api.post = '/FilterOwnedFilePaths', api.category='review', api.api_level='0', vecode.meta='read'),
}

service AttentionService {
    attention.UpdateAttentionSetResponse UpdateAttentionSet(1: attention.UpdateAttentionSetRequest req) throws (1: common.Error err) (
        api.post = '/UpdateAttentionSet', api.category='attention_set', api.api_level='2'),
}

service SettingsService {
    settings.ListWebhookSettingsResponse ListWebhookSettings(1: settings.ListWebhookSettingsRequest req) throws (1: common.Error err) (
        api.post = '/ListWebhookSettings', api.category='settings', api.api_level='1', vecode.meta='read'),
    settings.GetWebhookResponse GetWebhook(1: settings.GetWebhookRequest req) throws (1: common.Error err) (
        api.post = '/GetWebhook', api.category='settings', api.api_level='1', vecode.meta='read'),
    settings.CreateWebhookResponse CreateWebhook(1: settings.CreateWebhookRequest req) throws (1: common.Error err) (
        api.post = '/CreateWebhook', api.category='settings', api.api_level='1'),
    settings.UpdateWebhookResponse UpdateWebhook(1: settings.UpdateWebhookRequest req) throws (1: common.Error err) (
        api.post = '/UpdateWebhook', api.category='settings', api.api_level='1'),
    settings.DeleteWebhookResponse DeleteWebhook(1: settings.DeleteWebhookRequest req) throws (1: common.Error err) (
        api.post = '/DeleteWebhook', api.category='settings', api.api_level='1'),
    /** 重新enable一个被禁用的webhook */
    settings.EnableWebhookResponse EnableWebhook(1: settings.EnableWebhookRequest req) throws (1: common.Error err) (
        api.post = '/EnableWebhook', api.category='settings', api.api_level='1'),

    settings.InstallAppResponse InstallApp(1: settings.InstallAppRequest req) throws (1: common.Error err) (
        api.post = '/InstallApp', api.category='settings', api.api_level='1', vecode.meta='openapi', vecode.scope='repo:configure'),
    settings.UninstallAppResponse UninstallApp(1: settings.UninstallAppRequest req) throws (1: common.Error err) (
        api.post = '/UninstallApp', api.category='settings', api.api_level='1', vecode.meta='openapi', vecode.scope='repo:configure'),
    settings.ListInstalledAppsResponse ListInstalledApps(1: settings.ListInstalledAppsRequest req) throws (1: common.Error err) (
        api.post = '/ListInstalledApps', api.category='settings', api.api_level='1', vecode.meta='openapi,read', vecode.scope='repo:configure'),
}

service WebhookService {
    /** 获取当前webhook的recent deliveries列表 */
    webhook.ListWebhookLogsResponse ListWebhookLogs(1: webhook.ListWebhookLogsRequest req) throws (1: common.Error err) (
        api.post = '/ListWebhookLogs', api.category='webhook', api.api_level='1', vecode.meta='read'),
    /** 获取某次事件的详情 */
    webhook.GetWebhookLogResponse GetWebhookLog(1: webhook.GetWebhookLogRequest req) throws (1: common.Error err) (
        api.post = '/GetWebhookLog', api.category='webhook', api.api_level='1', vecode.meta='read'),
    /** 重新发送事件 */
    webhook.ResendWebhookEventResponse ResendWebhookEvent(1: webhook.ResendWebhookEventRequest req) throws (1: common.Error err) (
        api.post = '/ResendWebhookEvent', api.category='webhook', api.api_level='1'),
}

service AppService {
    app.CreateAppResponse CreateApp(1: app.CreateAppRequest req) throws (1: common.Error err) (
        api.post = '/CreateApp', api.category='app', api.api_level='1'),
    app.UpdateAppResponse UpdateApp(1: app.UpdateAppRequest req) throws (1: common.Error err) (
        api.post = '/UpdateApp', api.category='app', api.api_level='1'),
    app.GetAppResponse GetApp(1: app.GetAppRequest req) throws (1: common.Error err) (
        api.post = '/GetApp', api.category='app', api.api_level='1', vecode.meta='read'),
    app.ListAppsResponse ListApps(1: app.ListAppsRequest req) throws (1: common.Error err) (
        api.post = '/ListApps', api.category='app', api.api_level='1', vecode.meta='read'),
    app.DeleteAppResponse DeleteApp(1: app.DeleteAppRequest req) throws (1: common.Error err) (
        api.post = '/DeleteApp', api.category='app', api.api_level='1'),
}

service AppReviewService {
    app_review.UpdateAppReviewRulesResponse UpdateAppReviewRules(1: app_review.UpdateAppReviewRulesRequest req) throws (1: common.Error err) (
        api.post = '/UpdateAppReviewRules', api.category='app_review', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request.review.rule:write'),
    app_review.CreateAppReviewResetsResponse CreateAppReviewResets(1: app_review.CreateAppReviewResetsRequest req) throws (1: common.Error err) (
        api.post = '/CreateAppReviewResets', api.category='app_review', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request.review.reset:write'),
    app_review.UpdateUserRelatedFilePathsForAppResponse UpdateUserRelatedFilePathsForApp(1: app_review.UpdateUserRelatedFilePathsForAppRequest req) throws (1: common.Error err) (
        api.post = '/UpdateUserRelatedFilePathsForApp', api.category='app_review', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request.review.user_related_file:write'),
}

service CheckRunService {
    check_run.CreateCheckRunResponse CreateCheckRun(1: check_run.CreateCheckRunRequest req) throws (1: common.Error err) (
        api.post = '/CreateCheckRun', api.category='check_run', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.check:write'),
    check_run.UpdateCheckRunResponse UpdateCheckRun(1: check_run.UpdateCheckRunRequest req) throws (1: common.Error err) (
        api.post = '/UpdateCheckRun', api.category='check_run', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.check:write'),
    check_run.GetCheckRunResponse GetCheckRun(1: check_run.GetCheckRunRequest req) throws (1: common.Error err) (
        api.post = '/GetCheckRun', api.category='check_run', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.check:read'),
    check_run.ListCheckRunsResponse ListCheckRuns(1: check_run.ListCheckRunsRequest req) throws (1: common.Error err) (
        api.post = '/ListCheckRuns', api.category='check_run', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.check:read'),
    check_run.OperateCheckRunResponse OperateCheckRun(1: check_run.OperateCheckRunRequest req) throws (1: common.Error err) (
        api.post = '/OperateCheckRun', api.category='check_run', api.api_level='0', vecode.meta='openapi', vecode.scope='repo.check:write'),
    check_run.MGetCommitCheckStatusesResponse MGetCommitCheckStatuses(1: check_run.MGetCommitCheckStatusesRequest req) throws (1: common.Error err) (
        api.post = '/MGetCommitCheckStatuses', api.category='check_run', api.api_level='0'),
}

service InstanceService {
    instance.SyncInstanceResponse SyncInstance(1: instance.SyncInstanceRequest req) throws (1: common.Error err) (
        api.post = '/SyncInstance', api.category='instance', api.api_level='3'),
}

service RouteService {
    /** 基于 path 识别命名空间、仓库名、分支、文件路径 */
    route.ExtractPathResponse ExtractPath(1: route.ExtractPathRequest req) throws (1: common.Error err) (
        api.post = '/ExtractPath', api.category='route', api.api_level='2'),
}

service WorkItemService {
    work_item.SearchWorkItemsResponse SearchWorkItems(1: work_item.SearchWorkItemsRequest req) throws (1: common.Error err) (
        api.post = '/SearchWorkItems', api.category='workitem', api.api_level='2', vecode.meta='read'),
    work_item.ListWorkItemLinksResponse ListWorkItemLinks(1: work_item.ListWorkItemLinksRequest req) throws (1: common.Error err) (
        api.post = '/ListWorkItemLinks', api.category='workitem', api.api_level='2', vecode.meta='read,openapi', vecode.scope='repo.merge_request:read'),
    work_item.ExtractWorkItemsResponse ExtractWorkItems(1: work_item.ExtractWorkItemsRequest req) throws (1: common.Error err) (
        api.post = '/ExtractWorkItems', api.category='workitem', api.api_level='2', vecode.meta='read'),
    work_item.CreateWorkItemLinksResponse CreateWorkItemLinks(1: work_item.CreateWorkItemLinksRequest req) throws (1: common.Error err) (
        api.post = '/CreateWorkItemLinks', api.category='workitem', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
    work_item.DeleteWorkItemLinksResponse DeleteWorkItemLinks(1: work_item.DeleteWorkItemLinksRequest req) throws (1: common.Error err) (
        api.post = '/DeleteWorkItemLinks', api.category='workitem', api.api_level='1', vecode.meta='openapi', vecode.scope='repo.merge_request:write'),
}

service MergeQueueService {
    merge_queue.EnqueueMergeRequestResponse EnqueueMergeRequest(1: merge_queue.EnqueueMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/EnqueueMergeRequest', api.category='merge_queue', api.api_level='0', vecode.meta='openapi', vecode.scope='repo:write'),
    merge_queue.DequeueMergeRequestResponse DequeueMergeRequest(1: merge_queue.DequeueMergeRequestRequest req) throws (1: common.Error err) (
        api.post = '/DequeueMergeRequest', api.category='merge_queue', api.api_level='0', vecode.meta='openapi', vecode.scope='repo:write'),
    merge_queue.GetMergeQueueResponse GetMergeQueue(1: merge_queue.GetMergeQueueRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeQueue', api.category='merge_queue', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_queue:read'),
    merge_queue.GetMergeRequestCurrentQueueEntryResponse GetMergeRequestCurrentQueueEntry(1: merge_queue.GetMergeRequestCurrentQueueEntryRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeRequestCurrentQueueEntry', api.category='merge_queue', api.api_level='0', vecode.meta='read'),
    merge_queue.ListMergeRequestQueueEntriesResponse ListMergeRequestQueueEntries(1: merge_queue.ListMergeRequestQueueEntriesRequest req) throws (1: common.Error err) (
        api.post = '/ListMergeRequestQueueEntries', api.category='merge_queue', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_queue:read'),
    merge_queue.ListMergeQueueEntriesResponse ListMergeQueueEntries(1: merge_queue.ListMergeQueueEntriesRequest req) throws (1: common.Error err) (
        api.post = '/ListMergeQueueHistoryEntries', api.category='merge_queue', api.api_level='0', vecode.meta='read,openapi', vecode.scope='repo.merge_queue:read'),
    merge_queue.JumpMergeQueueResponse JumpMergeQueue(1: merge_queue.JumpMergeQueueRequest req) throws (1: common.Error err) (
        api.post = '/JumpMergeQueue', api.category='merge_queue', api.api_level='0'),
    merge_queue.GetMergeQueueSettingResponse GetMergeQueueSetting(1: merge_queue.GetMergeQueueSettingRequest req) throws (1: common.Error err) (
        api.post = '/GetMergeQueueSetting', api.category='merge_queue', api.api_level='0', vecode.meta='read'),
    merge_queue.MCountMergeQueueEntriesResponse MCountMergeQueueEntries(1: merge_queue.MCountMergeQueueEntriesRequest req) throws (1: common.Error err) (
        api.post = '/MCountMergeQueueEntries', api.category='merge_queue', api.api_level='0', vecode.meta='read'),
}

service OwnerService {
    owner.ListFileCodeOwnersResponse ListFileCodeOwners(1: owner.ListFileCodeOwnersRequest req) throws (1: common.Error err) (
        api.post = '/ListFileCodeOwners', api.category='owner', api.api_level='2', vecode.meta='read'),
}

service NotificationService {
    notification.CountNotificationsResponse CountNotifications(1: notification.CountNotificationsRequest req) throws (1: common.Error err) (
        api.post = '/CountNotifications', api.category='notification', api.api_level='0', vecode.meta='read'),
    notification.ListNotificationsResponse ListNotifications(1: notification.ListNotificationsRequest req) throws (1: common.Error err) (
        api.post = '/ListNotifications', api.category='notification', api.api_level='0', vecode.meta='read'),
    notification.MarkNotificationsAsReadResponse MarkNotificationsAsRead(1: notification.MarkNotificationsAsReadRequest req) throws (1: common.Error err) (
        api.post = '/MarkNotificationsAsRead', api.category='notification', api.api_level='0'),
    notification.GetNotificationSettingResponse GetNotificationSetting(1: notification.GetNotificationSettingRequest req) throws (1: common.Error err) (
        api.post = '/GetNotificationSetting', api.category='notification', api.api_level='1'),
    notification.UpdateNotificationSettingResponse UpdateNotificationSetting(1: notification.UpdateNotificationSettingRequest req) throws (1: common.Error err) (
        api.post = '/UpdateNotificationSetting', api.category='notification', api.api_level='1'),
}

service FrontierService {
    /** 作为BackService需要实现的RPC */
    frontier.SendMessageResponse  SendMessage(1: frontier.SendMessageRequest req) (
        vecode.meta='frontier'),
    frontier.PullMessagesResponse PullMessages(1: frontier.PullMessagesRequest req) (
        vecode.meta='frontier'),
    frontier.SendEventResponse    SendEvent(1: frontier.SendEventRequest req) (
        vecode.meta='frontier'),
    frontier.AuthResponse         Auth(1: frontier.AuthRequest req) (
        vecode.meta='read,frontier'),
    frontier.ACKMessageResponse   ACKMessage(1: frontier.ACKMessageRequest req) (
        vecode.meta='frontier'),
    oneway void Upstream(1: frontier.SendMessageRequest req) (
        vecode.meta='frontier'),
    /** 后端生成AccessKey返回给前端用于建连 */
    frontier.GetFrontierAccessKeyResponse GetFrontierAccessKey(1: frontier.GetFrontierAccessKeyRequest req) throws (1: common.Error err) (
        api.post = '/GetFrontierAccessKey', api.category='frontier', api.api_level='1', vecode.meta='read'),
}

service OpsService {
    ops.GetCacheInfoResponse GetCacheInfo(1: ops.GetCacheInfoRequest req) (
        api.post='/GetCacheInfo', api.category='ops', api.api_level='0', vecode.meta='cluster=ops'),
    ops.DeleteCacheResponse DeleteCache(1: ops.DeleteCacheRequest req) (
        api.post='/DeleteCache', api.category='ops', api.api_level='0', vecode.meta='cluster=ops'),
    /** 运维脚本，仅允许admin用户(非app)手动执行 */
    ops.CleanBypassDataResponse CleanBypassData(1: ops.CleanBypassDataRequest req) (
        api.post='/CleanBypassData', api.category='ops', api.api_level='0', vecode.meta='cluster=ops,script'),
    ops.CleanDuplicateActivityDataResponse CleanDuplicateActivityData(1: ops.CleanDuplicateActivityDataRequest req) (
        api.post='/CleanDuplicateActivityData', api.category='ops', api.api_level='0', vecode.meta='cluster=ops,script'),
}

service LFSService {
    lfs.ListLFSFileLocksResponse ListLFSFileLocks(1: lfs.ListLFSFileLocksRequest req) (
        api.post='/ListLFSFileLocks', api.category='lfs', api.api_level='0', vecode.meta='read,dgit'),
    lfs.ListLFSFileLocksForVerificationResponse ListLFSFileLocksForVerification(1: lfs.ListLFSFileLocksForVerificationRequest req) (
        api.post='/ListLFSFileLocksForVerification', api.category='lfs', api.api_level='0', vecode.meta='read,dgit'),
    lfs.CreateLFSFileLockResponse CreateLFSFileLock(1: lfs.CreateLFSFileLockRequest req) (
        api.post='/CreateLFSFileLock', api.category='lfs', api.api_level='0', vecode.meta='dgit'),
    lfs.DeleteLFSFileLockResponse DeleteLFSFileLock(1: lfs.DeleteLFSFileLockRequest req) (
        api.post='/DeleteLFSFileLock', api.category='lfs', api.api_level='0', vecode.meta='dgit'),
    lfs.LFSSSHAuthenticateResponse LFSSSHAuthenticate(1: lfs.LFSSSHAuthenticateRequest req) (
        api.post='/LFSSSHAuthenticate', api.category='lfs', api.api_level='0', vecode.meta='read,dgit'),
    lfs.BatchGetLFSObjectTransferEndpointsResponse BatchGetLFSObjectTransferEndpoints(1: lfs.BatchGetLFSObjectTransferEndpointsRequest req) (
        api.post='/BatchGetLFSObjectTransferEndpoints', api.category='lfs', api.api_level='0', vecode.meta='dgit'),
}

service SearchService {
    search.SearchUsersResponse SearchUsers(1: search.SearchUsersRequest req) throws (1: common.Error err) (
        api.post='/SearchUsers', api.category='search', api.api_level='1', vecode.meta='read'),
    search.SearchMergeRequestsResponse SearchMergeRequests(1: search.SearchMergeRequestsRequest req) throws (1: common.Error err) (
        api.post='/SearchMergeRequests', api.category='search', api.api_level='1', vecode.meta='read'),
}

service ViewGraphService {
    viewgraph.InitMergeRequestViewsResponse InitMergeRequestViews(1: viewgraph.InitMergeRequestViewsRequest req) throws (1: common.Error err) (
        api.post='/InitMergeRequestViews', api.category='viewgraph', api.api_level='1'),
    viewgraph.CreateMergeRequestViewResponse CreateMergeRequestView(1: viewgraph.CreateMergeRequestViewRequest req) throws (1: common.Error err) (
        api.post='/CreateMergeRequestView', api.category='viewgraph', api.api_level='1'),
    viewgraph.UpdateMergeRequestViewResponse UpdateMergeRequestView(1: viewgraph.UpdateMergeRequestViewRequest req) throws (1: common.Error err) (
        api.post='/UpdateMergeRequestView', api.category='viewgraph', api.api_level='1'),
    viewgraph.UpdateMergeRequestViewsOrderResponse UpdateMergeRequestViewsOrder(1: viewgraph.UpdateMergeRequestViewsOrderRequest req) throws (1: common.Error err) (
        api.post='/UpdateMergeRequestViewsOrder', api.category='viewgraph', api.api_level='1'),
    viewgraph.DeleteMergeRequestViewResponse DeleteMergeRequestView(1: viewgraph.DeleteMergeRequestViewRequest req) throws (1: common.Error err) (
        api.post='/DeleteMergeRequestView', api.category='viewgraph', api.api_level='1'),
    viewgraph.ListMergeRequestViewsResponse ListMergeRequestViews(1: viewgraph.ListMergeRequestViewsRequest req) throws (1: common.Error err) (
        api.post='/ListMergeRequestViews', api.category='viewgraph', api.api_level='1', vecode.meta='read'),
    viewgraph.MCountMergeRequestsByViewsResponse MCountMergeRequestsByViews(1: viewgraph.MCountMergeRequestsByViewsRequest req) throws (1: common.Error err) (
        api.post='/MCountMergeRequestsByViews', api.category='viewgraph', api.api_level='1', vecode.meta='read'),
}

service BytedanceService {
    /** 获取用户有权限访问的部门列表 */
    bytedance.ListUserDepartmentsResponse ListUserDepartments(1: bytedance.ListUserDepartmentsRequest req) throws (1: common.Error err) (
        api.post='/ListUserDepartments', api.category='bytedance', api.api_level='1', vecode.meta='read'),

    /** 为 App 生成用户身份的 jwt */
    bytedance.SignUserJWTResponse SignUserJWT(1: bytedance.SignUserJWTRequest req) throws (1: common.Error err) (
        api.post = '/SignUserJWT', api.category='account', api.api_level='0', vecode.meta='openapi', vecode.scope='user.jwt:write'),
}

service LabelService {
    label.ListLabelsResponse ListLabels(1: label.ListLabelsRequest req) throws (1: common.Error err) (
        api.post='/ListLabels', api.category='label', api.api_level='1', vecode.meta='read'),
    label.CreateLabelResponse CreateLabel(1: label.CreateLabelRequest req) throws (1: common.Error err) (
        api.post='/CreateLabel', api.category='label', api.api_level='1'),
    label.UpdateLabelResponse UpdateLabel(1: label.UpdateLabelRequest req) throws (1: common.Error err) (
        api.post='/UpdateLabel', api.category='label', api.api_level='1'),
    label.UpdateLabelPriorityResponse UpdateLabelPriority(1: label.UpdateLabelPriorityRequest req) throws (1: common.Error err) (
        api.post='/UpdateLabelPriority', api.category='label', api.api_level='1'),
    label.DeleteLabelResponse DeleteLabel(1: label.DeleteLabelRequest req) throws (1: common.Error err) (
        api.post='/DeleteLabel', api.category='label', api.api_level='1'),
    label.UpdateMergeRequestLabelsResponse UpdateMergeRequestLabels(1: label.UpdateMergeRequestLabelsRequest req) throws (1: common.Error err) (
        api.post='/UpdateMergeRequestLabels', api.category='label', api.api_level='1'),
}
