#!/bin/bash

echo "=== 儿童识字小报生成系统 - 快速启动 ==="

# 检查Docker是否已安装
if ! command -v docker &> /dev/null; then
    echo "错误: 请先安装Docker"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "错误: 请先安装Docker Compose"
    exit 1
fi

# 检查环境变量文件
if [ ! -f .env ]; then
    echo "创建环境变量文件..."
    cp .env.example .env
    echo "请编辑 .env 文件并填入必要的API密钥"
    echo "特别是以下配置项："
    echo "- NANO_BANANA_API_KEY: Nano Banana Pro API密钥"
    echo "- LLM_API_KEY: LLM API密钥（如OpenAI）"
    echo ""
    read -p "按回车键继续..."
fi

# 创建必要的目录
echo "创建必要的目录..."
mkdir -p backend/data backend/uploads

# 启动Redis（如果尚未运行）
echo "启动Redis..."
docker run -d --name literacy_redis -p 6379:6379 redis:7-alpine 2>/dev/null || true

# 安装后端依赖
echo "安装后端依赖..."
cd backend
npm install

# 安装前端依赖
echo "安装前端依赖..."
cd ../frontend
npm install

# 返回根目录
cd ..

echo ""
echo "=== 启动说明 ==="
echo "1. 确保 Redis 正在运行（端口6379）"
echo "2. 启动后端服务："
echo "   cd backend && npm run dev"
echo ""
echo "3. 启动前端服务（新终端）："
echo "   cd frontend && npm start"
echo ""
echo "或者使用Docker Compose："
echo "   docker-compose up --build"
echo ""
echo "访问地址："
echo "- 前端: http://localhost:3000"
echo "- 后端API: http://localhost:5000"