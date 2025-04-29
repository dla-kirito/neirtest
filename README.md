<div class="tab-container">
  <input type="radio" name="tabs" id="tab1" checked>
  <label for="tab1">Tab 1</label>
  <input type="radio" name="tabs" id="tab2">
  <label for="tab2">Tab 2</label>
  
  <div class="tab-content" id="content1">
    ### Tab 1 内容
    这里是 Tab 1 的内容，可以包含 **Markdown** 格式的文本。
  </div>
  <div class="tab-content" id="content2">
    ### Tab 2 内容
    这里是 Tab 2 的内容，支持图片、列表等：
    - 列表项 1
    - 列表项 2
  </div>
</div>

<style>
.tab-container {
  overflow: hidden;
}
.tab-container input {
  display: none;
}
.tab-container label {
  display: inline-block;
  padding: 10px 20px;
  cursor: pointer;
  background: #f1f1f1;
  border-bottom: 2px solid transparent;
}
.tab-container input:checked + label {
  background: #fff;
  border-bottom: 2px solid #007bff;
}
.tab-content {
  display: none;
  padding: 20px;
  border: 1px solid #ddd;
}
#tab1:checked ~ #content1,
#tab2:checked ~ #content2 {
  display: block;
}
</style>
