# 儿童识字小报生成系统 - 启动指南

## 快速启动

### Windows用户

1. 双击运行 `quick-start.bat`
2. 按照提示完成环境配置
3. 启动服务

### Mac/Linux用户

1. 在终端运行：
```bash
chmod +x quick-start.sh
./quick-start.sh
```

## 手动启动步骤

### 1. 环境准备

- Node.js 16+
- Redis
- Git

### 2. 安装依赖

```bash
# 后端
cd backend
npm install

# 前端
cd ../frontend
npm install
```

### 3. 配置环境变量

复制 `.env.example` 到 `.env` 并填入必要的API密钥：

```env
# 必填
NANO_BANANA_API_KEY=your-nano-banana-api-key
LLM_API_KEY=your-llm-api-key

# 可选
LLM_API_ENDPOINT=https://api.openai.com/v1/chat/completions
```

### 4. 启动Redis

```bash
# 使用Docker
docker run -d -p 6379:6379 redis:7-alpine

# 或使用本地Redis
redis-server
```

### 5. 启动服务

#### 方式一：分别启动

```bash
# 终端1：启动后端
cd backend
npm run dev

# 终端2：启动前端
cd frontend
npm start
```

#### 方式二：使用Docker Compose

```bash
# 构建并启动所有服务
docker-compose up --build

# 后台运行
docker-compose up -d
```

## 访问地址

- 前端应用: http://localhost:3000
- 后端API: http://localhost:5000
- API文档: http://localhost:5000/api/v1

## 常见问题

### 1. Redis连接失败

确保Redis正在运行：
```bash
docker ps | grep redis
```

### 2. API密钥配置错误

检查 `.env` 文件中的API密钥是否正确。

### 3. 端口被占用

修改 `docker-compose.yml` 或 `.env` 中的端口配置。

### 4. 前端无法连接后端

检查后端是否正常运行，以及CORS配置是否正确。

## 开发模式

### 后端开发模式

```bash
cd backend
npm run dev  # 使用nodemon自动重启
```

### 前端开发模式

```bash
cd frontend
npm start  # 热重载
```

## 生产部署

### 使用Docker

```bash
# 构建生产镜像
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

### 手动部署

1. 构建应用：
```bash
# 后端
cd backend && npm run build

# 前端
cd frontend && npm run build
```

2. 使用PM2管理后端进程：
```bash
pm2 start backend/dist/index.js --name literacy-backend
```

3. 使用Nginx提供前端静态文件服务。

## 健康检查

- 后端健康检查: http://localhost:5000/health
- Redis连接: `redis-cli ping`