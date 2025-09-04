# FutuOpenD Docker 容器

这是一个用于运行 FutuOpenD（富途开放平台交易接口）的 Docker 容器项目。FutuOpenD 是富途证券提供的开放API服务，允许用户通过编程方式进行股票交易和数据获取。

## 功能特性

- 🐳 Docker 容器化部署 FutuOpenD
- 🔐 支持环境变量配置登录凭据
- 📱 支持手机验证码输入
- 🚀 一键构建、运行和管理
- 🔧 简化的命令行工具

## 系统要求

- Docker
- Make (可选，用于简化命令)

## 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/robber5/docker-futuopend
cd my-docker-futuopend
```

### 2. 配置登录信息
编辑 `Makefile` 中的登录凭据（或使用环境变量）：
```makefile
LOGIN_ACCOUNT ?= 你的富途账号
LOGIN_PWD ?= 你的密码
```

### 3. 构建 Docker 镜像
```bash
make build
```

### 4. 运行容器
```bash
make run
```

### 5. 输入验证码（如需要）
当系统提示需要验证码时：
```bash
make verify_code CODE=123456
```
将 `123456` 替换为您收到的实际验证码。

## 详细使用说明

### 可用命令

| 命令 | 描述 |
|------|------|
| `make build` | 构建 Docker 镜像 |
| `make run` | 运行 FutuOpenD 容器 |
| `make verify_code CODE=<验证码>` | 输入手机验证码 |
| `make stop` | 停止运行中的容器 |
| `make clean` | 清理容器和镜像 |

### 环境变量

您可以通过环境变量覆盖默认配置：

```bash
# 设置登录账号和密码
export LOGIN_ACCOUNT=你的账号
export LOGIN_PWD=你的密码

# 运行容器
make run
```

### 端口映射

- **11111**: FutuOpenD API 端口，用于客户端连接
- **22222**: Telnet 控制端口（容器内部使用）

## 服务配置

FutuOpenD 服务配置：
- API 监听地址: `0.0.0.0:11111` (允许外部连接)
- Telnet 控制端口: `127.0.0.1:22222` (仅限容器内部)
- FutuOpenD 版本: `9.3.5308`

## 文件说明

```
├── Dockerfile          # Docker 镜像构建文件
├── Makefile            # 便捷命令集合
├── opendctl.sh         # 验证码输入脚本
└── README.md          # 项目说明文档
```

## 使用场景

1. **程序化交易**: 通过 FutuOpenD API 进行自动化交易
2. **数据获取**: 获取实时股票行情和历史数据
3. **策略回测**: 结合历史数据进行交易策略测试
4. **开发环境**: 为量化交易应用提供稳定的接口服务

## 注意事项

⚠️ **重要提示**:
- 请确保您的富途账号已经开通了 OpenAPI 权限
- 首次登录可能需要手机验证码验证
- 请妥善保管您的登录凭据，不要将其提交到公共代码库
- 建议使用环境变量而不是硬编码的方式配置敏感信息

## 故障排除

### 常见问题

1. **容器启动失败**
   - 检查 Docker 是否正常运行
   - 验证登录凭据是否正确

2. **验证码输入失败**
   - 确保容器正在运行
   - 检查验证码是否输入正确
   - 验证码有时效性，请及时输入

3. **API 连接问题**
   - 确认端口 11111 没有被其他程序占用
   - 检查防火墙设置

### 日志查看

查看容器运行日志：
```bash
docker logs futuopend
```

查看容器状态：
```bash
docker ps -a
```

## 开发与贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目。

## 许可证

本项目仅供学习和研究使用。请遵守富途证券的服务条款和相关法律法规。

## 相关链接

- [富途开放平台](https://openapi.futunn.com/)
- [FutuOpenD 文档](https://futunnopen.github.io/futu-api-doc/)
- [Docker 官方文档](https://docs.docker.com/)
