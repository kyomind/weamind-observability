# WeaMind Observability CHANGELOG 維護指南

## 🤖 AI 助理重要指示

**當用戶要求更新 CHANGELOG 或版本時，AI 助理必須：**

1. **遵循標準發布流程**，確保不遺漏任何步驟
2. **使用 Git 指令進行版本管理**，這是一個簡單的 Docker 監控專案

---

## 📋 標準發布流程

### 步驟 1：檢查狀態
```bash
git log --oneline $(git describe --tags --abbrev=0)..HEAD 2>/dev/null || git log --oneline
```
- 查看自上次版本以來的變更
- 如果沒有版本標籤，顯示所有 commits

```bash
git status
```
- 確認工作目錄乾淨
- 檢查當前分支

### 步驟 2：收集變更資料
```bash
# 查看詳細的 commit 資訊
git log --oneline --no-merges $(git describe --tags --abbrev=0)..HEAD 2>/dev/null || git log --oneline --no-merges

# 查看變更的檔案統計
git diff --stat $(git describe --tags --abbrev=0)..HEAD 2>/dev/null || git diff --stat HEAD~10..HEAD
```

### 步驟 3：生成 CHANGELOG 內容
使用 Copilot Chat：
<CHANGELOG content>
根據以下 git commits 為 WeaMind Observability 產生 CHANGELOG 內容：
[手動貼上 commits]

要求：
- 繁體中文、Keep a Changelog 格式、面向 DevOps 工程師、突出監控價值
- **版本類型區分**：
  - Major/Minor 版本 (x.Y.z / X.y.z)：內容豐富，詳細描述新功能和改進
  - Patch 版本 (x.y.Z)：內容簡潔，專注關鍵修正和小幅改進
- **忽略非功能性變更**：
  - C-Spell 字典更新或排除規則
  - 文件格式調整、錯字修正
  - GitHub Actions 小調整
  - 程式碼註解或變數重命名
  這些變更不應出現在 CHANGELOG 中
</CHANGELOG content>

### 步驟 4：手動發布版本
```bash
# 1. 創建或更新 CHANGELOG.md
# 2. 提交變更
git add CHANGELOG.md
git commit -m "Update CHANGELOG for v0.1.0"

# 3. 建立版本標籤
git tag v0.1.0

# 4. 推送到遠端
git push origin main --tags
```
- 提交 CHANGELOG.md 變更
- 建立 git tag (格式: v0.1.0)
- 推送到遠端倉庫，觸發 GitHub Actions
- GitHub Actions 會自動建立 Release

---

## 📝 CHANGELOG 內容規範

### 版本格式
```markdown
## [版本號] - YYYY-MM-DD
```

### 變更分類（優先順序）
1. **新增 (Added)** - 新功能、新特性
2. **修正 (Fixed)** - 錯誤修復、安全性修正
3. **改進 (Changed)** - 既有功能改進、效能優化

### 撰寫原則
- **面向 DevOps 工程師**：使用 DevOps 和監控領域的專業術語，但保持清晰易懂
- **突出監控價值**：說明功能對系統監控、可觀測性的實際好處
- **簡潔明瞭**：每項變更一行描述，重點功能用 **粗體**
- **版本類型區分**：
  - **Major/Minor 版本 (x.Y.z / X.y.z)**：內容豐富，詳細描述新功能和改進，可包含多個類別
  - **Patch 版本 (x.y.Z)**：內容簡潔，專注關鍵修正和小幅改進，通常只有 1-2 個關鍵項目
- **嚴格篩選 commits**：
  - ✅ 包含：新監控功能、錯誤修復、儀表板改進、警報規則更新、Docker 配置優化
  - ❌ 排除：C-Spell 規則、文件微調、GitHub Actions 調整、重構或格式化

### 內容範例
```markdown
## [0.2.0] - 2025-10-03 (Minor 版本範例)

### 新增
- **應用層監控**: 新增自定義 metrics 收集，支援業務指標監控
- **AlertManager 整合**: 建立完整的告警通知機制，支援 Slack 和 Email 通知

### 修正
- 修復 Prometheus 配置錯誤導致的 scrape 失敗問題
- 改善 Grafana 儀表板在小螢幕裝置上的顯示效果

### 改進
- 優化 Docker Compose 配置，縮短服務啟動時間 30%
- 更新 Node Exporter 設定，增加系統監控覆蓋範圍

## [0.2.1] - 2025-10-04 (Patch 版本範例)

### 修正
- **🔧 Prometheus 配置**: 修正 scrape_interval 設定，提升 metrics 收集穩定性

## [0.1.0] - 2025-10-01 (首次發布範例)

### 新增
- **� 完整監控堆疊**: Prometheus + Grafana + AlertManager + Node Exporter 一鍵部署
- **📊 核心儀表板**: 系統概覽和應用效能監控儀表板
- **🔔 智慧告警**: 3 個核心告警規則，涵蓋系統和應用層監控
```

---

## 🛠️ 實用 Git 指令

### 版本管理指令
```bash
# 查看版本歷史
git tag --sort=-version:refname      # 依版本號排序顯示標籤
git log --tags --simplify-by-decoration --pretty="format:%ai %d" # 版本時間線

# 收集變更資訊
git log --oneline --no-merges LAST_TAG..HEAD    # 自上次版本的 commits
git log --oneline --merges LAST_TAG..HEAD       # PR 合併記錄
git diff --stat LAST_TAG..HEAD                  # 檔案變更統計
git diff --name-only LAST_TAG..HEAD             # 變更檔案清單

# 版本發布
git add CHANGELOG.md                             # 加入變更記錄
git commit -m "Update CHANGELOG for v0.1.0"     # 提交變更
git tag v0.1.0                                  # 建立版本標籤
git push origin main --tags                     # 推送所有變更和標籤

# 檢查發布狀態
git log --oneline -1                             # 查看最新 commit
git describe --tags                              # 查看當前版本描述
```

### GitHub Release 自動化
專案使用 GitHub Actions 自動化 Release：
- 推送 tag 時自動觸發 `.github/workflows/auto-release.yml`
- 自動生成 Release Notes
- 包含完整的 git 歷史記錄

### Copilot Chat 範本

#### 生成監控功能版本
```
為 WeaMind Observability v0.2.0 產生 CHANGELOG，重點關注：
- Prometheus 監控配置
- Grafana 儀表板功能
- AlertManager 告警機制
- Docker Compose 部署改進
- Node Exporter 系統監控

版本類型：Minor 版本（內容豐富）
要求：簡潔明瞭，面向 DevOps 工程師，突出監控價值。
忽略：C-Spell、文件更新、GitHub Actions 調整等非功能性變更。
```

#### 生成 Patch 版本
```
為 WeaMind Observability v0.2.1 產生 CHANGELOG（Patch 版本）：
[貼上 commits]

要求：
- 內容簡潔，通常 1-2 個關鍵項目即可
- 專注重要修正或小幅改進
- 避免過度包裝細瑣變更
- 嚴格忽略 C-Spell、文件微調、CI 調整等
```

#### 優化既有內容
```
優化這段 CHANGELOG 內容，讓它更吸引 DevOps 工程師：
[貼上現有內容]

優化方向：突出監控價值、強調可觀測性改進、加入技術細節、保持專業準確性
```

---

## ✅ 發布檢查清單

### 手動發布流程檢查
- [ ] 確認工作目錄乾淨 (`git status`)
- [ ] 檢查自上次版本的變更 (`git log --oneline LAST_TAG..HEAD`)
- [ ] 使用 Copilot Chat 生成內容並完善 CHANGELOG.md
- [ ] 提交 CHANGELOG.md (`git add CHANGELOG.md && git commit -m "Update CHANGELOG for vX.Y.Z"`)
- [ ] 建立版本標籤 (`git tag vX.Y.Z`)
- [ ] 推送到遠端 (`git push origin main --tags`)
- [ ] 確認 GitHub Actions 成功建立 Release

### 內容品質檢查
- [ ] 使用繁體中文且語調一致
- [ ] 重要功能用粗體突出
- [ ] 強調監控和可觀測性價值
- [ ] 版本號格式正確 (vX.Y.Z)

---

## 🎯 專案定位要點

記住 WeaMind Observability 是一個**開源監控解決方案**，CHANGELOG 面向 DevOps 工程師和系統管理員。

### 常用 Emoji
- 🚀 新功能發布
- 📊 儀表板相關
- 🔔 告警相關
- � Docker 相關
- � 配置改進
- �🔒 安全性
- � 效能改進
- � 監控精準度

---

## 📚 快速參考

### 基本指令
```bash
git log --oneline $(git describe --tags --abbrev=0)..HEAD    # 查看新變更
git add CHANGELOG.md && git commit -m "Update CHANGELOG"     # 提交 CHANGELOG
git tag vX.Y.Z && git push origin main --tags               # 發布版本
```
