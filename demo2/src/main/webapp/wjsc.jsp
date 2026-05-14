<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文件上传</title>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
    }
    
    .upload-container {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        padding: 40px;
        width: 100%;
        max-width: 500px;
    }
    
    .upload-header {
        text-align: center;
        margin-bottom: 30px;
    }
    
    .upload-header h2 {
        color: #333;
        font-size: 24px;
        margin-bottom: 8px;
    }
    
    .upload-header p {
        color: #666;
        font-size: 14px;
    }
    
    .upload-area {
        border: 2px dashed #ddd;
        border-radius: 12px;
        padding: 40px 20px;
        text-align: center;
        transition: all 0.3s ease;
        cursor: pointer;
        background: #fafafa;
    }
    
    .upload-area:hover,
    .upload-area.dragover {
        border-color: #667eea;
        background: #f0f4ff;
    }
    
    .upload-area.dragover {
        transform: scale(1.02);
    }
    
    .upload-icon {
        font-size: 48px;
        margin-bottom: 16px;
    }
    
    .upload-text {
        color: #666;
        font-size: 16px;
        margin-bottom: 8px;
    }
    
    .upload-hint {
        color: #999;
        font-size: 12px;
    }
    
    .upload-hint span {
        color: #667eea;
        text-decoration: underline;
    }
    
    #fileInput {
        display: none;
    }
    
    .file-info {
        margin-top: 20px;
        padding: 16px;
        background: #f8f9fa;
        border-radius: 8px;
        display: none;
    }
    
    .file-info.show {
        display: block;
    }
    
    .file-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 8px 0;
        border-bottom: 1px solid #eee;
    }
    
    .file-row:last-child {
        border-bottom: none;
    }
    
    .file-label {
        color: #999;
        font-size: 14px;
    }
    
    .file-value {
        color: #333;
        font-size: 14px;
        font-weight: 500;
        max-width: 200px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    .upload-btn {
        width: 100%;
        margin-top: 24px;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .upload-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    }
    
    .upload-btn:active {
        transform: translateY(0);
    }
    
    .upload-btn:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none;
    }
    
    .progress-container {
        margin-top: 20px;
        display: none;
    }
    
    .progress-container.show {
        display: block;
    }
    
    .progress-bar {
        height: 8px;
        background: #eee;
        border-radius: 4px;
        overflow: hidden;
    }
    
    .progress-fill {
        height: 100%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        width: 0%;
        transition: width 0.3s ease;
        border-radius: 4px;
    }
    
    .progress-text {
        text-align: center;
        margin-top: 8px;
        color: #666;
        font-size: 14px;
    }
    
    .error-message {
        margin-top: 16px;
        padding: 12px;
        background: #fff5f5;
        border: 1px solid #ffccc7;
        border-radius: 8px;
        color: #ff4d4f;
        font-size: 14px;
        display: none;
    }
    
    .error-message.show {
        display: block;
    }
    
    .success-message {
        margin-top: 16px;
        padding: 12px;
        background: #f6ffed;
        border: 1px solid #b7eb8f;
        border-radius: 8px;
        color: #52c41a;
        font-size: 14px;
        display: none;
    }
    
    .success-message.show {
        display: block;
    }
</style>
</head>
<body>
    <div class="upload-container">
        <div class="upload-header">
            <h2>文件上传</h2>
            <p>支持拖拽上传或点击选择文件</p>
        </div>
        
        <form id="uploadForm" action="UploadServlet" method="post" enctype="multipart/form-data">
            <div class="upload-area" id="uploadArea">
                <div class="upload-icon"></div>
                <div class="upload-text">点击或拖拽文件到此处</div>
                <div class="upload-hint">支持 JPG、PNG、PDF 等格式，最大 <span>50MB</span></div>
                <input type="file" name="file" id="fileInput" accept="image/*,.pdf,.doc,.docx">
            </div>
            
            <div class="file-info" id="fileInfo">
                <div class="file-row">
                    <span class="file-label">文件名：</span>
                    <span class="file-value" id="fileName">-</span>
                </div>
                <div class="file-row">
                    <span class="file-label">文件大小：</span>
                    <span class="file-value" id="fileSize">-</span>
                </div>
                <div class="file-row">
                    <span class="file-label">文件类型：</span>
                    <span class="file-value" id="fileType">-</span>
                </div>
            </div>
            
            <button type="submit" class="upload-btn" id="uploadBtn" disabled>上传文件</button>
            
            <div class="progress-container" id="progressContainer">
                <div class="progress-bar">
                    <div class="progress-fill" id="progressFill"></div>
                </div>
                <div class="progress-text" id="progressText">正在上传...</div>
            </div>
            
            <div class="error-message" id="errorMessage"></div>
            <div class="success-message" id="successMessage"></div>
        </form>
    </div>
    
    <script type="text/javascript">
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const fileInfo = document.getElementById('fileInfo');
        const fileName = document.getElementById('fileName');
        const fileSize = document.getElementById('fileSize');
        const fileType = document.getElementById('fileType');
        const uploadBtn = document.getElementById('uploadBtn');
        const uploadForm = document.getElementById('uploadForm');
        const progressContainer = document.getElementById('progressContainer');
        const progressFill = document.getElementById('progressFill');
        const progressText = document.getElementById('progressText');
        const errorMessage = document.getElementById('errorMessage');
        const successMessage = document.getElementById('successMessage');
        
        const MAX_FILE_SIZE = 50 * 1024 * 1024;
        
        function showError(msg) {
            errorMessage.textContent = msg;
            errorMessage.classList.add('show');
            successMessage.classList.remove('show');
        }
        
        function hideError() {
            errorMessage.classList.remove('show');
        }
        
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
        
        function handleFile(file) {
            if (!file) return;
            
            if (file.size > MAX_FILE_SIZE) {
                showError('文件大小超过限制（最大50MB）');
                return;
            }
            
            hideError();
            
            fileName.textContent = file.name;
            fileSize.textContent = formatFileSize(file.size);
            fileType.textContent = file.type || '未知类型';
            
            fileInfo.classList.add('show');
            uploadBtn.disabled = false;
        }
        
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });
        
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });
        
        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });
        
        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                handleFile(files[0]);
            }
        });
        
        fileInput.addEventListener('change', (e) => {
            const files = e.target.files;
            if (files.length > 0) {
                handleFile(files[0]);
            }
        });
        
        uploadForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const file = fileInput.files[0];
            if (!file) {
                showError('请先选择文件');
                return;
            }
            
            uploadBtn.disabled = true;
            progressContainer.classList.add('show');
            hideError();
            
            const xhr = new XMLHttpRequest();
            const formData = new FormData(uploadForm);
            
            xhr.upload.addEventListener('progress', (e) => {
                if (e.lengthComputable) {
                    const percent = (e.loaded / e.total) * 100;
                    progressFill.style.width = percent + '%';
                    progressText.textContent = '正在上传：' + Math.round(percent) + '%';
                }
            });
            
            xhr.addEventListener('load', () => {
                if (xhr.status === 200) {
                    progressText.textContent = '上传完成！';
                    successMessage.textContent = '文件上传成功！';
                    successMessage.classList.add('show');
                    
                    setTimeout(() => {
                        window.location.href = 'wjsc.jsp';
                    }, 2000);
                } else {
                    showError('上传失败，请重试');
                    progressText.textContent = '上传失败';
                    uploadBtn.disabled = false;
                }
            });
            
            xhr.addEventListener('error', () => {
                showError('网络错误，请重试');
                progressText.textContent = '上传失败';
                uploadBtn.disabled = false;
            });
            
            xhr.open('POST', 'UploadServlet');
            xhr.send(formData);
        });
    </script>
</body>
</html>