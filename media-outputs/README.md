# 自媒体流水线使用指南

## 🚀 快速开始

### 1️⃣ 初始化环境

```bash
# 创建输出目录
bash scripts/init-output-directories.sh

# 初始化 GitHub 仓库（可选）
bash scripts/init-github-repo.sh
```

### 2️⃣ 配置 GitHub（可选）

编辑 `scripts/config.env` 或手动设置：

```bash
export GITHUB_USERNAME="your-username"
export GITHUB_TOKEN="your-github-token"
export GITHUB_REPO_NAME="media-outputs"
```

### 3️⃣ 执行完整流程

```bash
# 一键执行所有步骤
bash scripts/run-full-workflow.sh
```

### 4️⃣ 分步执行

```bash
# 步骤 1: 阿呆抓取内容
bash scripts/01-grab-content.sh

# 步骤 2: 小帅分析爆款
bash scripts/02-analyze-hits.sh

# 步骤 3: 生成文章
bash scripts/03-generate-article.sh

# 步骤 4: 生成配图（需要 SDXL 环境）
bash scripts/04-generate-image.sh

# 步骤 5: 打包
bash scripts/05-package.sh

# 步骤 6: 上传 GitHub
bash scripts/06-upload-github.sh
```

## 📂 输出目录结构

```
media-outputs/
├── articles/        # 生成的文章
│   ├── article_20260313_162911.md
│   └── article_20260313_162911.txt
├── images/          # 生成的图片
├── packages/        # 打包文件
│   └── media-output-20260313_162917.zip
├── raw/             # 原始抓取内容
│   └── grab_content_20260313_162834.md
└── analysis/        # 爆款分析报告
    └── hit_analysis_20260313_162909.md
```

## 🔧 配置说明

### GitHub 配置

1. 访问 https://github.com/new 创建新仓库
2. 仓库名：`media-outputs`
3. 运行初始化脚本：
```bash
bash scripts/init-github-repo.sh
```
4. 配置远程仓库：
```bash
cd media-outputs
git remote add origin https://github.com/your-username/media-outputs.git
git branch -M main
git push -u origin main
```

### SDXL 图片生成

需要配置 SDXL 环境：

```bash
cd ~/.openclaw/workspace/skills/sdxl-image-gen
source venv/bin/activate
```

## 🤖 AI 协作流程

### 小项目（本流水线）
```
阿呆 → 抓取内容（70GB）
小帅 → 分析爆款（340GB，用时即关）
阿呆 → 生成文章（70GB）
```

### 内存管理
- **阿呆**：日常抓取，常驻 ~70GB
- **小帅**：爆款分析，按需启动 ~340GB
- **用完即关**：释放内存

## 📊 测试状态

✅ **已完成**：
- 目录结构初始化
- 阿呆抓取内容
- 小帅分析爆款
- 文章生成
- 打包压缩
- GitHub 上传脚本

⚠️ **待配置**：
- GitHub 仓库
- SDXL 图片生成环境

## 🎯 下一步

1. **配置 GitHub**：
   ```bash
   bash scripts/init-github-repo.sh
   ```

2. **测试 SDXL**（可选）：
   ```bash
   cd ~/.openclaw/workspace/skills/sdxl-image-gen
   source venv/bin/activate
   python main.py "测试图片" --width 1248 --height 640
   ```

3. **完整测试**：
   ```bash
   bash scripts/run-full-workflow.sh
   ```

## 📝 注意事项

- 微信公众号需要配置 IP 白名单才能自动发布
- 当前版本为手动打包版本
- 建议定期清理旧版本文件
- 小帅模型用完记得关闭（脚本自动处理）

---

**创建时间**: 2026-03-13  
**版本**: v1.0  
**状态**: ✅ 可测试