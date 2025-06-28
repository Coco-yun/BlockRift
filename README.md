
# 逆水寒官方贴吧项目

一个基于 Flask + MySQL 的简易贴吧系统，支持用户登录、帖子发布与浏览等核心功能。


## 环境要求  
- **Python**：3.7 及以上版本  
- **数据库**：MySQL 5.5+（或兼容版本如 MariaDB）  
- **框架**：Flask 及相关依赖  


## 部署步骤  

### 1. 克隆仓库  
```bash
git clone https://github.com/your-username/BlockRift.git  
cd BlockRift  
```  


### 2. 安装依赖  
建议使用虚拟环境隔离依赖（可选但推荐）：  
```bash
# 创建虚拟环境（Windows/Linux/Mac 通用命令）  
python -m venv venv  

# 激活虚拟环境  
# Windows  
venv\Scripts\activate  
# Linux/Mac  
source venv/bin/activate  

# 安装依赖  
pip install -r requirements.txt  
```  

**`requirements.txt` 内容**：  
```  
flask==2.0.1  
mysql-connector-python==8.0.26  
Werkzeug==2.0.1  
```  


### 3. 初始化数据库  
#### （1）创建数据库与表  
登录 MySQL 终端，执行以下 SQL 语句：  
```sql  
-- 创建数据库  
CREATE DATABASE tieba;  
USE tieba;  

-- 创建用户表（存储登录信息）  
CREATE TABLE yonghu (  
    id INT AUTO_INCREMENT PRIMARY KEY,  
    telphoneNum VARCHAR(20) NOT NULL UNIQUE,  -- 手机号（登录账号）  
    pwd VARCHAR(100) NOT NULL  -- 密码（明文/哈希值，生产环境需哈希）  
);  

-- 创建帖子表（存储帖子内容）  
CREATE TABLE posts (  
    id INT AUTO_INCREMENT PRIMARY KEY,  
    post_title VARCHAR(100) NOT NULL,  -- 帖子标题  
    post_author VARCHAR(50) NOT NULL,  -- 发帖人  
    post_content TEXT NOT NULL,  -- 帖子内容  
    post_time DATETIME NOT NULL  -- 发帖时间  
);  
```  

#### （2）添加测试数据（可选）  
如需快速测试，可插入模拟数据：  
```sql  
-- 测试用户  
INSERT INTO yonghu (telphoneNum, pwd) VALUES  
('13550247412', '123456'),  
('13998745621', '654321');  

-- 测试帖子  
INSERT INTO posts (post_title, post_author, post_content, post_time) VALUES  
('【测试】首次发帖', '测试用户', '这是一条测试内容', '2025-06-18 10:00:00');  
```  


### 4. 配置数据库连接  
修改项目根目录的 `app.py` 文件，确保数据库参数与实际环境一致：  
```python  
def get_db_connection():  
    return mysql.connector.connect(  
        host='localhost',    # 数据库地址（默认本地）  
        user='root',         # 数据库用户名  
        password='123456',   # 数据库密码（替换为实际密码）  
        database='tieba'     # 数据库名（需与步骤3一致）  
    )  
```  


### 5. 启动应用  
```bash  
python app.py  
```  
访问 `http://127.0.0.1:5000` 即可打开 **登录页面**。  


## 核心功能  

### 1. 用户登录  
- 支持 **手机号登录**（前端自动验证格式：11位数字，以 `13-9` 开头）。  
- 后端校验账号密码与数据库匹配，成功后跳转至 **主页面**。  


### 2. 帖子管理  
- **浏览帖子**：按发布时间 **倒序排列**，展示最新内容。  
- **发布帖子**：填写标题、内容即可发布（需登录）。  
- **点赞功能**：模拟实现（需扩展后端接口完成真实交互）。  


### 3. API 接口说明  
| 端点                  | 方法   | 功能                     | 请求参数                              | 返回值示例                     |  
|-----------------------|--------|--------------------------|---------------------------------------|--------------------------------|  
| `/login`              | `POST` | 用户登录验证             | `{account: 手机号, pwd: 密码}`         | `{success: true, username: "13550247412"}` |  
| `/posts`              | `GET`  | 获取帖子列表             | 无                                    | `[{id: 1, post_title: "测试帖"...}]` |  
| `/posts`              | `POST` | 发布新帖子               | `{post_title, post_author, post_content, post_time}` | `{success: true, message: "发布成功"}` |  
| `/posts/like/<post_id>` | `POST` | 帖子点赞（模拟）         | 路径参数 `post_id`（如 `/posts/like/1`） | `{success: true}`              |  
| `/get_user`           | `GET`  | 获取当前登录用户信息     | 无                                    | `{username: "13550247412"}` 或 `{error: "未登录"}` |  


## 技术栈  
- **前端**：HTML5 + CSS3 + 原生 JavaScript（无框架，轻量实现）。  
- **后端**：Python + Flask（快速搭建 API 接口）。  
- **数据库**：MySQL（存储用户与帖子数据）。  
- **部署**：本地开发环境（可扩展至 Docker 或云服务器）。  



## 贡献指南  
1. **Fork 仓库**：点击 GitHub 仓库右上角 `Fork`，复制到个人账号。  
2. **创建分支**：  
   ```bash  
   git checkout -b feature/your-feature  
   ```  
3. **提交修改**：  
   ```bash  
   git commit -am "Add new feature: xxx"  
   ```  
4. **推送分支**：  
   ```bash  
   git push origin feature/your-feature  
   ```  
5. **发起 PR**：在 GitHub 中提交 Pull Request，描述功能细节。  


## 生产环境注意事项  
1. **密码安全**：开发环境用明文密码，生产需通过 `werkzeug.security` 哈希加密。  
2. **配置优化**：数据库连接信息建议通过 **环境变量** 注入（如 `.env` 文件），避免硬编码。  
3. **部署加固**：关闭 Flask 调试模式（`debug=False`），使用 Gunicorn 或 Nginx 作为 WSGI 服务器。
