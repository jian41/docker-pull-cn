#!/bin/bash

# 1. 检查是否提供了参数
if [ -z "$1" ]; then
    echo "❌ 错误：请提供要拉取的源镜像名称作为第一个参数。"
    echo "用法: $0 <SOURCE_IMAGE>"
    echo "示例: $0 ubuntu:latest"
    exit 1
fi

# 2. 定义变量
SOURCE_IMAGE="$1" # 第一个参数 ($1) 作为源镜像
TARGET_IMAGE_NAME="my-custom-image"
TARGET_IMAGE_TAG="v1.0"
NEW_IMAGE="${TARGET_IMAGE_NAME}:${TARGET_IMAGE_TAG}"

echo "--- 📋 脚本配置 ---"
echo "源镜像 (Source Image): ${SOURCE_IMAGE}"
echo "目标镜像别名 (New Tag): ${NEW_IMAGE}"
echo "----------------------"

# 3. 执行 docker pull 拉取镜像
echo "--- 🚀 正在执行 docker pull 拉取镜像：${SOURCE_IMAGE} ---"
docker pull "${SOURCE_IMAGE}"

# 检查 docker pull 是否成功
if [ $? -ne 0 ]; then
    echo "❌ 错误：docker pull 命令执行失败。脚本终止。"
    exit 1
fi

# 4. 执行 docker tag 修改名称（打标签）
echo "--- 🏷️ 正在执行 docker tag 修改名称/打标签 ---"
echo "将 ${SOURCE_IMAGE} 标记为 ${NEW_IMAGE}"
# 语法：docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag "${SOURCE_IMAGE}" "${NEW_IMAGE}"

# 检查 docker tag 是否成功
if [ $? -ne 0 ]; then
    echo "❌ 错误：docker tag 命令执行失败。脚本终止。"
    exit 1
fi

# 5. 完成并验证
echo "--- ✅ 脚本执行成功 ---"
echo "已拉取镜像：${SOURCE_IMAGE}"
echo "已创建新标签/别名：${NEW_IMAGE}"
echo "您可以通过 'docker images' 命令查看所有镜像。"
