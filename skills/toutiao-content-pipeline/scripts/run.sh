#!/bin/bash
# toutiao-content-pipeline - 今日头条爆款内容生成流水线
# 产出：文件夹包含 docx 文件和标签管理说明

set -e

VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$SCRIPT_DIR/workspace"
OUTPUT_DIR="$WORKSPACE_DIR/output"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_help() {
    cat << EOF
今日头条爆款内容生成流水线 v${VERSION}

用法：bash skills/toutiao-content-pipeline/scripts/run.sh [命令] [选项]

命令:
  init                      初始化工作区
  generate <topic>          根据主题生成内容
  batch <file>              批量生成
  clean                     清理工作区
  help                      显示帮助

示例:
  bash skills/toutiao-content-pipeline/scripts/run.sh generate "春季养生"
EOF
}

init_workspace() {
    print_info "正在初始化工作区..."
    mkdir -p "$OUTPUT_DIR"
    print_success "工作区初始化完成！"
}

generate_title() {
    local topic="$1"
    local titles=(
        "【重磅】${topic}，90% 的人都不知道！"
        "${topic} 的 5 个真相，第 3 个太意外了！"
        "为什么 ${topic} 突然火了？原因找到了！"
        "${topic} 全攻略：从入门到精通"
        "深度解析 ${topic}：未来趋势预测"
    )
    echo "${titles[$RANDOM % ${#titles[@]}]}"
}

generate_summary() {
    local topic="$1"
    cat << EOF
本文深度解析${topic}，包含核心要点、实战技巧和未来趋势。
适合所有对${topic}感兴趣的朋友，3 分钟快速掌握精髓！
EOF
}

generate_tags_md() {
    local article_name="$1"
    local category="$2"
    local tags="$3"
    
    cat > "$OUTPUT_DIR/$article_name/tags.md" << EOF
# ${article_name} - 标签管理说明

## 📋 基础信息
- **文章名称**: ${article_name}
- **分类**: ${category}
- **生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

## 🏷️ 推荐标签

### 主标签（必选）
$(echo "$tags" | head -n 3 | sed 's/^/- /')

### 辅助标签（可选）
$(echo "$tags" | tail -n +4 | sed 's/^/- /')

## 📊 标签使用策略

### 头条发布建议
1. **主标签**：放在文章开头或标题附近
2. **辅助标签**：放在文章末尾
3. **标签数量**：3-5 个为宜

## 🔍 SEO 优化建议

### 黄金时间**: 7-9 点、12-13 点、19-22 点
### 最佳日期**: 周二、周三、周四

## 📈 数据追踪
- 阅读量、点赞数、评论数、分享数、涨粉数

---
*标签管理说明自动生成*
EOF
    print_success "标签管理说明已生成：$OUTPUT_DIR/$article_name/tags.md"
}

generate_metadata() {
    local article_name="$1"
    local title="$2"
    local category="$3"
    local tags="$4"
    
    cat > "$OUTPUT_DIR/$article_name/metadata.json" << EOF
{
  "article_name": "$article_name",
  "title": "$title",
  "category": "$category",
  "tags": $(echo "$tags" | tr ' ' '\n' | sed 's/^/"/;s/$/"/' | tr '\n' ',' | sed 's/,$//'),
  "generated_at": "$(date -Iseconds)"
}
EOF
}

generate_article() {
    local topic="$1"
    local article_name=$(echo "$topic" | tr ' ' '_' | tr -cd 'a-zA-Z0-9_' | head -c 30)
    local safe_name=$(echo "$article_name" | sed 's/[^a-zA-Z0-9_-]/_/g')
    
    [ -z "$safe_name" ] && safe_name="article_$(date +%s)"
    
    print_info "正在生成文章：$topic..."
    
    local title=$(generate_title "$topic")
    local summary=$(generate_summary "$topic")
    local category="technology"
    local tags="#健康 #${topic} #养生 #生活 #指南"
    
    mkdir -p "$OUTPUT_DIR/$safe_name"
    
    cat > "$OUTPUT_DIR/$safe_name/article.md" << EOF
# $title

## 引言
$summary

## 核心内容

### 1. 背景分析
${topic} 是当前的热点话题，引起了广泛关注。本文将深入分析其背后的原因、发展趋势和实际应用。

### 2. 核心要点
- **要点一**: 深入了解 ${topic} 的基本概念
- **要点二**: 分析 ${topic} 的核心价值
- **要点三**: 探讨 ${topic} 的实际应用场景
- **要点四**: 预测 ${topic} 的未来发展方向
- **要点五**: 提供 ${topic} 的实用建议

### 3. 案例分析
通过实际案例，展示 ${topic} 在现实中的应用效果。

## 总结
${topic} 作为一个重要的话题，值得我们深入研究和关注。希望本文能为大家提供一些有价值的参考。

---
**Tags**: $tags
**Category**: $category
EOF
    
    generate_tags_md "$safe_name" "$category" "$tags"
    generate_metadata "$safe_name" "$title" "$category" "$tags"
    
    # 转换为 docx
    if command -v pandoc &> /dev/null; then
        pandoc "$OUTPUT_DIR/$safe_name/article.md" -o "$OUTPUT_DIR/$safe_name/article.docx" 2>/dev/null && \
            print_success "docx 文件已生成：$OUTPUT_DIR/$safe_name/article.docx" || \
            print_warning "docx 转换失败"
    else
        print_warning "pandoc 未安装，跳过 docx 转换"
    fi
    
    print_success "文章生成完成！"
    print_info "输出目录：$OUTPUT_DIR/$safe_name"
    print_info "包含文件：article.md, article.docx, tags.md, metadata.json"
}

batch_generate() {
    local file="$1"
    [ ! -f "$file" ] && { print_error "文件不存在：$file"; exit 1; }
    
    print_info "正在批量生成文章..."
    local count=0
    while IFS= read -r topic || [ -n "$topic" ]; do
        [ -z "$topic" ] && continue
        ((count++))
        print_info "[$count] 生成：$topic"
        generate_article "$topic"
    done < "$file"
    print_success "批量生成完成！共生成 $count 篇文章"
}

clean_workspace() {
    print_warning "确定要清理工作区吗？"
    read -p "删除所有生成的文件？(y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && { rm -rf "$OUTPUT_DIR"; print_success "工作区已清理"; }
}

main() {
    [ $# -eq 0 ] && { show_help; exit 0; }
    
    local command="$1"
    shift
    
    case "$command" in
        init) init_workspace ;;
        generate) [ -z "$1" ] && { print_error "请提供主题"; exit 1; }; generate_article "$1" ;;
        batch) [ -z "$1" ] && { print_error "请提供主题文件"; exit 1; }; batch_generate "$1" ;;
        clean) clean_workspace ;;
        help|--help|-h) show_help ;;
        *) print_error "未知命令：$command"; show_help; exit 1 ;;
    esac
}

main "$@"