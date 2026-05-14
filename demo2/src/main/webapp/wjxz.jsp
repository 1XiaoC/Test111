<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文件下载</title>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif;
        min-height: 100vh;
        padding: 40px 20px;
    }
    
    .download-container {
        max-width: 800px;
        margin: 0 auto;
    }
    
    .download-header {
        text-align: center;
        margin-bottom: 40px;
        color: #fff;
    }
    
    .download-header h2 {
        font-size: 32px;
        margin-bottom: 8px;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }
    
    .download-header p {
        font-size: 16px;
        opacity: 0.9;
    }
    
    .file-card {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        padding: 24px;
        margin-bottom: 20px;
        transition: all 0.3s ease;
    }
    
    .file-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
    }
    
    .file-row {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .file-icon {
        width: 80px;
        height: 80px;
        border-radius: 12px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 40px;
        flex-shrink: 0;
    }
    
    .file-icon.image {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    
    .file-icon.pdf {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
    }
    
    .file-icon.doc {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    }
    
    .file-icon.other {
        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
    }
    
    .file-preview {
        width: 80px;
        height: 80px;
        border-radius: 12px;
        object-fit: cover;
        flex-shrink: 0;
    }
    
    .file-info {
        flex: 1;
        min-width: 0;
    }
    
    .file-info h3 {
        color: #333;
        font-size: 18px;
        margin-bottom: 8px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    .file-meta {
        display: flex;
        gap: 20px;
        font-size: 14px;
        color: #666;
    }
    
    .file-meta span {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .file-actions {
        display: flex;
        gap: 12px;
        flex-shrink: 0;
    }
    
    .btn {
        padding: 10px 24px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
    }
    
    .btn-download {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        color: #fff;
    }
    
    .btn-download:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(17, 153, 142, 0.4);
    }
    
    .btn-preview {
        background: #f8f9fa;
        color: #666;
        border: 1px solid #e9ecef;
    }
    
    .btn-preview:hover {
        background: #e9ecef;
    }
    
    .btn-preview:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
    
    .empty-state {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 16px;
        padding: 60px 40px;
        text-align: center;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
    }
    
    .empty-icon {
        font-size: 64px;
        margin-bottom: 16px;
        opacity: 0.5;
    }
    
    .empty-title {
        font-size: 20px;
        color: #333;
        margin-bottom: 8px;
    }
    
    .empty-desc {
        color: #666;
        font-size: 14px;
        margin-bottom: 24px;
    }
    
    .btn-upload {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        padding: 12px 32px;
        font-size: 16px;
    }
    
    .btn-upload:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    }
    
    .stats-bar {
        display: flex;
        justify-content: center;
        gap: 40px;
        margin-bottom: 30px;
    }
    
    .stat-item {
        text-align: center;
        color: #fff;
    }
    
    .stat-value {
        font-size: 28px;
        font-weight: 700;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }
    
    .stat-label {
        font-size: 14px;
        opacity: 0.9;
        margin-top: 4px;
    }
    
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.8);
        justify-content: center;
        align-items: center;
        z-index: 1000;
        padding: 20px;
    }
    
    .modal-overlay.show {
        display: flex;
    }
    
    .modal-content {
        background: #fff;
        border-radius: 16px;
        max-width: 90%;
        max-height: 90vh;
        overflow: hidden;
        position: relative;
    }
    
    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 24px;
        border-bottom: 1px solid #eee;
    }
    
    .modal-title {
        font-size: 18px;
        color: #333;
    }
    
    .modal-close {
        width: 32px;
        height: 32px;
        border: none;
        background: #f5f5f5;
        border-radius: 50%;
        font-size: 20px;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        color: #666;
    }
    
    .modal-close:hover {
        background: #eee;
    }
    
    .modal-body {
        padding: 16px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .preview-image {
        max-width: 100%;
        max-height: 70vh;
        object-fit: contain;
        border-radius: 8px;
    }
    
    @media (max-width: 600px) {
        .file-row {
            flex-direction: column;
            text-align: center;
        }
        
        .file-meta {
            justify-content: center;
        }
        
        .file-actions {
            margin-top: 16px;
        }
        
        .stats-bar {
            gap: 20px;
        }
    }
</style>
</head>
<body>
    <div class="download-container">
        <div class="download-header">
            <h2>文件下载</h2>
            <p>查看和下载已上传的文件</p>
        </div>
        
        <%
            String filesPath = application.getRealPath("/FILES");
            File filesDir = new File(filesPath);
            File[] files = filesDir.listFiles();
            
            int fileCount = 0;
            long totalSize = 0;
            
            if (files != null) {
                fileCount = files.length;
                for (File f : files) {
                    if (f.isFile()) {
                        totalSize += f.length();
                    }
                }
            }
        %>
        
        <div class="stats-bar">
            <div class="stat-item">
                <div class="stat-value"><%= fileCount %></div>
                <div class="stat-label">文件数量</div>
            </div>
            <div class="stat-item">
                <div class="stat-value"><%= formatSize(totalSize) %></div>
                <div class="stat-label">总大小</div>
            </div>
        </div>
        
        <%
            if (files == null || files.length == 0) {
        %>
                <div class="empty-state">
                    <div class="empty-icon"></div>
                    <div class="empty-title">暂无文件</div>
                    <div class="empty-desc">还没有上传任何文件，点击下方按钮上传文件</div>
                    <a href="wjsc.jsp" class="btn btn-upload">去上传文件</a>
                </div>
        <%
            } else {
                for (File file : files) {
                    if (file.isFile()) {
                        String fileName = file.getName();
                        String fileExtension = getFileExtension(fileName);
                        long fileSize = file.length();
                        long lastModified = file.lastModified();
                        String formattedDate = formatDate(lastModified);
                        
                        boolean isImage = isImageFile(fileExtension);
                        String fileIconClass = getFileIconClass(fileExtension);
                        String fileIcon = getFileIcon(fileExtension);
        %>
                <div class="file-card">
                    <div class="file-row">
                        <% if (isImage) { %>
                            <img src="FILES/<%= fileName %>" alt="<%= fileName %>" class="file-preview">
                        <% } else { %>
                            <div class="file-icon <%= fileIconClass %>"><%= fileIcon %></div>
                        <% } %>
                        
                        <div class="file-info">
                            <h3><%= fileName %></h3>
                            <div class="file-meta">
                                <span><%= formatSize(fileSize) %></span>
                                <span><%= formattedDate %></span>
                            </div>
                        </div>
                        
                        <div class="file-actions">
                            <% if (isImage) { %>
                                <button class="btn btn-preview" onclick="previewImage('<%= fileName %>')">👁 预览</button>
                            <% } %>
                            <a href="download1.jsp?filename=<%= fileName %>" class="btn btn-download">⬇ 下载</a>
                        </div>
                    </div>
                </div>
        <%
                    }
                }
            }
        %>
    </div>
    
    <div class="modal-overlay" id="previewModal">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="previewTitle">图片预览</span>
                <button class="modal-close" onclick="closePreview()">×</button>
            </div>
            <div class="modal-body">
                <img src="" alt="预览图片" class="preview-image" id="previewImage">
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        function previewImage(fileName) {
            const modal = document.getElementById('previewModal');
            const image = document.getElementById('previewImage');
            const title = document.getElementById('previewTitle');
            
            image.src = 'FILES/' + encodeURIComponent(fileName);
            title.textContent = fileName;
            modal.classList.add('show');
        }
        
        function closePreview() {
            const modal = document.getElementById('previewModal');
            modal.classList.remove('show');
        }
        
        document.getElementById('previewModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closePreview();
            }
        });
        
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closePreview();
            }
        });
    </script>
    
    <%!
        private String formatSize(long bytes) {
            if (bytes == 0) return "0 B";
            final String[] units = {"B", "KB", "MB", "GB"};
            int unitIndex = (int) (Math.log(bytes) / Math.log(1024));
            return String.format("%.2f %s", bytes / Math.pow(1024, unitIndex), units[unitIndex]);
        }
        
        private String formatDate(long timestamp) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            return sdf.format(new Date(timestamp));
        }
        
        private String getFileExtension(String fileName) {
            int dotIndex = fileName.lastIndexOf('.');
            return (dotIndex > 0) ? fileName.substring(dotIndex + 1).toLowerCase() : "";
        }
        
        private boolean isImageFile(String extension) {
            return extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp");
        }
        
        private String getFileIconClass(String extension) {
            if (isImageFile(extension)) return "image";
            if (extension.equals("pdf")) return "pdf";
            if (extension.equals("doc") || extension.equals("docx")) return "doc";
            return "other";
        }
        
        private String getFileIcon(String extension) {
            if (isImageFile(extension)) return "🖼";
            if (extension.equals("pdf")) return "📕";
            if (extension.equals("doc") || extension.equals("docx")) return "📘";
            return "📄";
        }
    %>
</body>
</html>