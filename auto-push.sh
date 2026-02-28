#!/bin/bash

# ====== 配置区域 ======
REPO_DIR="/.atcdata/tokens"
BRANCH="main"
LOG_FILE="/.atcdata/tokens/auto_push.log"
# =======================

cd $REPO_DIR || exit 1

# 拉取最新代码，避免冲突
git pull origin $BRANCH >> $LOG_FILE 2>&1

# 检查是否有变更
if [[ -n $(git status --porcelain) ]]; then
    echo "Changes detected at $(date)" >> $LOG_FILE
    
    git add .
    git commit -m "Auto update at $(date '+%Y-%m-%d %H:%M:%S')" >> $LOG_FILE 2>&1
    git push origin $BRANCH >> $LOG_FILE 2>&1
    
    echo "Push completed." >> $LOG_FILE
else
    echo "No changes at $(date)" >> $LOG_FILE
fi
