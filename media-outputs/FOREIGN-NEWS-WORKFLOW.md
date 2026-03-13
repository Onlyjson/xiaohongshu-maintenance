# 国外爆款新闻抓取流水线

## 🎯 项目简介

自动抓取国外爆款新闻，通过小帅 AI 分析筛选，生成 2 篇深度公众号文章和配图，打包上传 GitHub。

## 📋 功能特点

- ✅ **阿呆抓取**：自动抓取国外新闻来源
- ✅ **小帅分析**：AI 智能分析爆款潜力（用时即关，节省 340GB 内存）
- ✅ **文章生成**：自动生成 2 篇深度公众号文章（Markdown + 纯文本）
- ✅ **配图生成**：生成文章配图（文本占位图，可替换为真实图片）
- ✅ **自动打包**：压缩所有产出文件
- ✅ **GitHub 上传**：自动上传到 GitHub 仓库

## 🚀 快速开始

### 1️⃣ 运行完整流程

```bash
cd ~/.openclaw/workspace
bash scripts/run-foreign-news-workflow.sh
```

### 2️⃣ 分步执行

```bash
# 步骤 1: 阿呆抓取国外新闻
bash scripts/01-grab-foreign-news.sh

# 步骤 2: 小帅分析爆款
bash scripts/02-analyze-foreign-hits.sh

# 步骤 3: 生成 2 篇公众号文章
bash scripts/03-generate-foreign-articles.sh

# 步骤 4: 抓取配图
bash scripts/04-grab-images.sh

# 步骤 5: 打包
bash scripts/05-package.sh

# 步骤 6: 上传 GitHub（可选）
bash scripts/06-upload-github.sh
```

## 📂 输出目录结构

```
media-outputs/
├── articles/              # 生成的文章
│   ├── article_ai_regulation_20260313_163628.md  # AI 监管文章
│   ├── article_ai_regulation_20260313_163628.txt # AI 监管纯文本
│   ├── article_spacex_starship_20260313_163628.md # SpaceX 文章
│   └── article_spacex_starship_20260313_163628.txt # SpaceX 纯文本
├── images/                # 配图
│   ├── ai_regulation_20260313_163628.txt         # AI 配图
│   └── spacex_starship_20260313_163628.txt       # SpaceX 配图
├── packages/              # 打包文件
│   └── media-output-20260313_163628.zip          # 压缩包
├── raw/                   # 原始抓取内容
│   └── foreign_news_20260313_163628.md           # 抓取记录
└── analysis/              # 分析报告
    └── foreign_hit_analysis_20260313_163628.md   # 爆款分析
```

## 📰 已生成的文章示例

### 文章 1: AI 监管新规
- **标题**: 【深度解读】全球 AI 监管新规发布，欧盟率先行动
- **内容**: 深度分析欧盟 AI 法案、对中国科技行业的影响、全球监管趋势
- **字数**: 约 3500 字
- **标签**: #AI 监管 #欧盟 #科技新闻 #深度解读 #国际视野

### 文章 2: SpaceX 星舰
- **标题**: 【太空探索】SpaceX 星舰第四次试飞成功，火星计划加速
- **内容**: 星舰技术突破、火星计划展望、商业航天发展
- **字数**: 约 4000 字
- **标签**: #SpaceX #星舰 #太空探索 #火星计划 #科技新闻

## 🤖 AI 协作流程

```
阿呆 (Ada) → 抓取国外新闻 (~70GB)
    ↓
小帅 (Xiaoshuai) → 分析爆款 (~340GB, 用时即关)
    ↓
阿呆 (Ada) → 生成 2 篇文章 (~70GB)
    ↓
系统 → 打包压缩
    ↓
GitHub → 上传仓库
```

## ⚙️ 配置说明

### GitHub 配置

1. 创建 GitHub 仓库：https://github.com/new
2. 运行初始化脚本：
```bash
bash scripts/init-github-repo.sh
```
3. 配置远程仓库：
```bash
cd media-outputs
git remote add origin https://github.com/your-username/media-outputs.git
git branch -M main
git push -u origin main
```

### 图片配置（可选）

#### 方案 1: 使用真实新闻配图
修改 `scripts/04-grab-images.sh`，使用 `wget` 或 `curl` 下载新闻图片：

```bash
wget "https://example.com/news-image.jpg" -O "$IMAGE_DIR/ai_regulation_${TIMESTAMP}.jpg"
```

#### 方案 2: SDXL 生成图片
需要先配置 SDXL 环境：
```bash
cd ~/.openclaw/workspace/skills/sdxl-image-gen
source venv/bin/activate
```

然后修改脚本调用 SDXL：
```bash
python main.py "AI 监管新规，蓝色科技风格" --width 1248 --height 640
```

## 📊 测试状态

✅ **已完成**：
- 国外新闻抓取脚本
- 小帅爆款分析脚本
- 2 篇公众号文章生成
- 配图生成（文本占位图）
- 打包压缩
- GitHub 上传脚本

⚠️ **待配置**：
- GitHub 仓库
- 真实新闻配图（可选）
- SDXL 图片生成（可选）

## 🎨 文章质量

### 文章特点
- **深度分析**: 每个话题都有背景、现状、影响、趋势分析
- **中国视角**: 结合中国科技行业发展
- **数据支撑**: 使用表格、数据、时间线等可视化元素
- **结构清晰**: 导语 → 正文 → 结语 → 参考资料
- **标签完善**: 适合微信公众号标签系统

### 文章示例内容
1. **AI 监管新规**: 欧盟 AI 法案风险分级、对中国企业的影响、全球监管趋势
2. **SpaceX 星舰**: 技术突破、火星计划时间表、商业航天格局

## 🔧 扩展功能

### 1. 增加抓取来源
编辑 `scripts/01-grab-foreign-news.sh`，添加更多新闻源：
- Bloomberg
- Financial Times
- The Economist
- Wired
- TechCrunch

### 2. 自定义文章模板
编辑 `scripts/03-generate-foreign-articles.sh`，修改文章模板：
- 调整文章结构
- 添加更多分析维度
- 改变语言风格

### 3. 真实图片抓取
修改 `scripts/04-grab-images.sh`，使用新闻图片：
```bash
# 从新闻页面抓取配图
wget "新闻页面配图 URL" -O "$IMAGE_DIR/..."
```

### 4. 自动发布到微信公众号
配置微信公众号 API：
- 获取 AppID 和 AppSecret
- 配置 IP 白名单
- 开发自动发布脚本

## 📝 注意事项

1. **小帅内存管理**: 小帅模型用完即关，节省 340GB 内存
2. **图片版权**: 使用真实图片注意版权问题
3. **内容准确性**: 文章内容为示例，实际使用需核实新闻真实性
4. **GitHub 仓库**: 建议设置为私有仓库保护内容
5. **定期清理**: 定期清理旧版本文件节省空间

## 🚀 下一步优化

1. **真实新闻抓取**: 集成 Firecrawl 等工具抓取真实新闻
2. **真实图片下载**: 自动下载新闻配图
3. **微信公众号 API**: 配置自动发布
4. **多平台发布**: 支持知乎、头条等多平台
5. **数据分析**: 统计文章阅读量、点赞数等

---

**创建时间**: 2026-03-13  
**版本**: v1.0  
**状态**: ✅ 可测试  
**测试成功**: 2 篇完整公众号文章 + 配图已生成