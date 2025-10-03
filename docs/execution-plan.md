# WeaMind V2.0 可觀測性實踐執行計畫書

**專案期間**：20 個工作日
**工作模式**：每日 2 小時，總計 40 小時
**專案目標**：建立完整的 WeaMind 可觀測性解決方案
**GitHub 專案**：weamind-observability（開源）

## 驗收標準總覽

### 核心交付物
- ✅ **Prometheus Metrics（7個核心指標）**
  - 系統層（3個）：CPU使用率、可用記憶體、Disk I/O
  - 應用層（4個）：HTTP請求總數、API回應時間、錯誤請求總數、天氣查詢次數

- ✅ **Grafana Dashboard（2個）**
  - System Overview（CPU/Memory/Disk 監控）
  - Application Performance（API metrics + Top 5 查詢縣市）

**工作項目**：
- 撰寫技術分享文章「WeaMind 可觀測性實踐 - 從 0 到 1 的最小實作」
- 建立完整的 Quick Start 部署指南
- 錄製 Demo 影片（可選）
- 最終專案檢查與總結

**交付物**：
- 技術分享文章（3000-5000 字）
- Quick Start 部署指南
- Demo 影片（15 分鐘）
- 專案最終總結報告

**驗收標準**：
- 技術文章結構完整，包含技術細節與實作心得
- 專案文件可讓新手快速上手
- GitHub 專案展示效果良好
- 所有核心驗收標準達成術文件撰寫
**目標**：撰寫完整的技術文件與使用指南

**工作項目**：
- 撰寫 Dashboard 使用指南
- 建立指標解釋文件
- 撰寫部署與維護文件
- 建立故障排除指南
- 整理專案 README.md

**交付物**：
- `docs/dashboard-guide.md`
- `docs/metrics-reference.md`
- `docs/deployment-guide.md`
- `docs/troubleshooting.md`
- 更新後的 README.md

**驗收標準**：
- 文件內容完整清晰，包含截圖與範例
- 可作為新手入門指南
- README.md 包含快速啟動說明設定
- 優化 Grafana Dashboard 查詢

**交付物**：
- 效能優化報告
- 調整後的配置檔案
- 資源使用監控

**驗收標準**：
- 監控系統資源使用 < 系統總資源的 20%
- Prometheus 查詢回應時間 < 2 秒
- Grafana Dashboard 載入時間 < 3 秒op 5 查詢縣市）

- ✅ **AlertManager 告警規則（3條）**
  - CPU > 80% 持續 1分鐘
  - Memory > 70%
  - API 回應時間 > 3秒

- ✅ **技術文件實作**：Prometheus + Grafana + AlertManager（Docker Compose 部署）
- ✅ **技術文章**：1篇技術分享文章「WeaMind 可觀測性實踐 - 從 0 到 1 的最小實作」

## 第一階段：專案初始化與環境準備（第1-3天）

## 第1天 - 專案架構規劃與 GitHub 建立
**目標**：建立專案基礎架構與開源專案

**工作項目**：
- 建立 GitHub Repository `weamind-observability`
- 設計專案目錄結構
- 撰寫 README.md 架構說明
- 建立 .env.example 環境變數範本
- 初始化 docker-compose.yml 框架

**交付物**：
```
weamind-observability/
├── README.md                    # 專案說明與快速啟動指南
├── docker-compose.yml          # 容器編排配置（框架）
├── .env.example                 # 環境變數範例
└── docs/                        # 文件目錄
    └── architecture.md          # 架構設計文件
```

**驗收標準**：
- GitHub Repository 建立完成並公開
- README.md 包含架構圖與快速啟動說明
- 專案結構清晰，符合開源專案規範

## 第2天 - Docker Compose 基礎配置
**目標**：完成核心監控元件的容器配置

**工作項目**：
- 配置 Prometheus 容器（基礎設定）
- 配置 Grafana 容器（基礎設定）
- 配置 AlertManager 容器（基礎設定）
- 配置 Node Exporter 容器（系統指標收集）
- 建立基礎 volumes 配置

**交付物**：
```
├── docker-compose.yml          # 完整 4 個容器配置
├── prometheus/
│   └── prometheus.yml          # Prometheus 基礎配置
├── grafana/
│   └── provisioning/           # Grafana 自動配置目錄
└── alertmanager/
    └── alertmanager.yml        # AlertManager 基礎配置
```

**驗收標準**：
- `docker-compose up -d` 可成功啟動 4 個容器
- 所有服務健康檢查通過
- 可透過瀏覽器存取 Prometheus (9090)、Grafana (3000)、AlertManager (9093)

## 第3天 - 基礎連線與測試
**目標**：確保所有元件間的基礎連線正常

**工作項目**：
- 測試 Prometheus 能成功抓取 Node Exporter 指標
- 在 Grafana 中手動配置 Prometheus 資料源
- 測試 AlertManager 基礎功能
- 建立簡單的測試指標查詢

**交付物**：
- Prometheus targets 顯示 UP 狀態
- Grafana 可成功連接 Prometheus
- 基礎系統指標可在 Prometheus 中查詢到

**驗收標準**：
- Prometheus UI 中 Node Exporter target 狀態為 UP
- Grafana 中可查詢到基本系統指標（如 CPU、Memory）
- AlertManager 介面正常顯示

## 第二階段：WeaMind 應用整合（第4-8天）

## 第4天 - WeaMind Metrics 端點開發
**目標**：在 WeaMind 應用中新增 /metrics 端點

**工作項目**：
- 在 WeaMind FastAPI 應用中安裝 prometheus_client
- 實作基礎 HTTP 請求計數器
- 實作 API 回應時間直方圖
- 實作錯誤請求計數器
- 測試 /metrics 端點輸出

**交付物**：
- WeaMind 應用的 /metrics 端點正常運作
- 4個應用層指標正確輸出：
  - `http_requests_total`
  - `http_request_duration_seconds`
  - `http_errors_total`
  - `weather_queries_total`

**驗收標準**：
- 訪問 `http://weamind-domain/metrics` 返回 Prometheus 格式指標
- 指標包含適當的 labels（method, endpoint, status_code 等）

## 第5天 - WeaMind 業務指標實作
**目標**：實作天氣查詢相關的業務指標

**工作項目**：
- 實作天氣查詢次數計數器（按縣市分類）
- 實作 LINE Bot 訊息處理指標
- 實作快取命中率指標（Redis）
- 實作資料庫查詢時間指標（PostgreSQL）

**交付物**：
- 天氣查詢指標：`weather_queries_total{city="台北市"}`
- LINE Bot 指標：`line_messages_total{type="text|quick_reply"}`
- 快取指標：`cache_hit_rate`
- 資料庫指標：`db_query_duration_seconds`

**驗收標準**：
- 執行天氣查詢後，指標正確累加
- 指標包含有意義的 labels 便於後續分析

## 第6天 - Prometheus 抓取配置
**目標**：配置 Prometheus 抓取 WeaMind 應用指標

**工作項目**：
- 更新 prometheus.yml 配置檔
- 新增 WeaMind 應用為抓取目標
- 配置抓取頻率與超時設定
- 測試指標抓取是否正常

**交付物**：
```yaml
# prometheus/prometheus.yml
scrape_configs:
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']

  - job_name: 'weamind'
    static_configs:
      - targets: ['your-weamind-domain:port']
    scrape_interval: 15s
    metrics_path: /metrics
```

**驗收標準**：
- Prometheus targets 頁面顯示 WeaMind 為 UP 狀態
- 可在 Prometheus 中查詢到所有 7 個核心指標
- 指標資料持續更新

## 第7天 - 指標驗證與調整
**目標**：驗證所有指標收集正確並進行調整

**工作項目**：
- 測試所有 7 個核心指標的資料正確性
- 調整指標的 labels 和命名規範
- 驗證指標的時間序列資料
- 修復發現的問題

**交付物**：
- 系統層指標驗證報告
- 應用層指標驗證報告
- 指標修正清單

**驗收標準**：
- 所有 7 個指標在 Prometheus 中可正常查詢
- 指標資料符合預期邏輯（CPU 使用率 0-100%、請求數遞增等）
- 指標命名符合 Prometheus 最佳實踐

## 第8天 - 指標效能優化
**目標**：優化指標收集的效能影響

**工作項目**：
- 評估指標收集對 WeaMind 應用效能的影響
- 調整指標收集頻率
- 優化高頻指標的實作方式
- 建立指標收集的最佳實踐文件

**交付物**：
- 效能影響評估報告
- 優化後的指標實作
- 最佳實踐文件

**驗收標準**：
- WeaMind 應用回應時間增加 < 5%
- 指標收集不影響正常業務功能
- 指標精確度與效能達到平衡

## 第三階段：Grafana 儀表板開發（第9-11天）

## 第9天 - Grafana 資料源自動配置
**目標**：實作 Grafana 的自動化配置

**工作項目**：
- 建立 Grafana provisioning 配置
- 自動配置 Prometheus 資料源
- 設定 Grafana 基礎參數（admin 密碼、plugin 等）
- 測試自動配置功能

**交付物**：
```
grafana/
└── provisioning/
    ├── datasources/
    │   └── prometheus.yml      # 自動配置 Prometheus 資料源
    └── dashboards/
        └── dashboard.yml       # dashboard provider 配置
```

**驗收標準**：
- 重啟 Grafana 容器後自動載入 Prometheus 資料源
- 無需手動配置即可使用資料源查詢指標

## 第10天 - System Overview Dashboard 開發
**目標**：開發系統層監控儀表板

**工作項目**：
- 設計 System Overview Dashboard 布局
- 建立 CPU 使用率面板（時間序列圖）
- 建立記憶體使用面板（gauge + 時間序列）
- 建立磁碟 I/O 面板
- 建立系統負載面板

**交付物**：
- `grafana/provisioning/dashboards/system-overview.json`
- 包含 4-6 個核心系統指標面板
- 適當的閾值警告設定

**驗收標準**：
- Dashboard 自動載入到 Grafana
- 所有面板正確顯示即時系統指標
- 視覺化效果清晰易讀

## 第11天 - Application Performance Dashboard 開發
**目標**：開發應用層監控儀表板

**工作項目**：
- 設計 Application Performance Dashboard 布局
- 建立 HTTP 請求量面板（時間序列圖）
- 建立 API 回應時間面板（直方圖）
- 建立錯誤率面板（gauge）
- 建立天氣查詢統計面板

**交付物**：
- `grafana/provisioning/dashboards/application-performance.json`
- 包含核心業務指標面板
- Top 5 查詢縣市排行榜

**驗收標準**：
- Dashboard 顯示即時應用效能指標
- Top 5 查詢縣市排行榜正確顯示
- 錯誤率計算準確

## 第12天 - AlertManager 基礎配置
**目標**：配置 AlertManager 的基礎告警功能

**工作項目**：
- 建立 AlertManager 配置檔
- 配置告警通知通道（email/webhook）
- 設定告警路由規則
- 測試基礎告警功能

**交付物**：
```
alertmanager/
├── alertmanager.yml           # 主配置檔
└── templates/
    └── alert-template.tmpl    # 告警訊息範本
```

**驗收標準**：
- AlertManager 可成功發送測試告警
- 告警訊息格式清晰易讀
- 通知通道配置正確

## 第13天 - Prometheus 告警規則開發
**目標**：實作 3 條核心告警規則

**工作項目**：
- 實作 CPU 使用率告警（> 80% 持續 1分鐘）
- 實作記憶體使用率告警（> 70%）
- 實作 API 回應時間告警（> 3秒）
- 配置告警規則檔案

**交付物**：
```yaml
# prometheus/rules/alerts.yml
groups:
  - name: system_alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 1m

      - alert: HighMemoryUsage
        expr: (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 70

      - alert: SlowAPIResponse
        expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 3
```

**驗收標準**：
- 3 條告警規則語法正確
- 可在 Prometheus UI 中看到告警規則
- 告警條件符合業務需求

## 第14天 - 告警測試與調整
**目標**：測試告警觸發機制並調整參數

**工作項目**：
- 建立告警測試腳本
- 模擬高 CPU、高記憶體、慢 API 回應情境
- 驗證告警觸發與恢復機制
- 調整告警閥值與持續時間

**交付物**：
- 告警測試腳本
- 告警測試報告
- 調整後的告警規則

**驗收標準**：
- 所有 3 條告警可正確觸發
- 告警恢復機制正常
- 告警訊息包含足夠的診斷資訊

## 第四階段：AlertManager 告警系統（第12-15天）

## 第15天 - 告警優化與文件
**目標**：優化告警機制並撰寫運維文件

**工作項目**：
- 優化告警訊息內容
- 設定告警分組與靜音規則
- 撰寫告警處理流程文件
- 建立告警歷史分析

**交付物**：
- 優化的告警配置
- `docs/alerting-guide.md`
- 告警處理 Runbook

**驗收標準**：
- 告警訊息包含處理建議
- 告警分組減少通知干擾
- 運維文件完整實用

## 第16天 - 整體系統測試
**目標**：對整個可觀測性系統進行端到端測試

**工作項目**：
- 執行完整的系統測試流程
- 驗證監控 -> 告警 -> 排查的完整流程
- 測試系統在高負載下的表現
- 記錄測試結果與問題

**交付物**：
- 系統測試報告
- 端到端測試腳本
- 問題修復清單

**驗收標準**：
- 監控系統可穩定運行 24 小時
- 告警機制在負載測試中正確觸發
- 所有元件整合無誤

## 第17天 - 效能優化與調整
**目標**：優化整個監控系統的效能與資源使用

**工作項目**：
- 分析各元件的資源使用情況
- 優化 Prometheus 的儲存與查詢效能
- 調整 scrape 間隔與 retention 設定
- 優化 Grafana Dashboard 查詢

**交付物**：
- 效能優化報告
- 調整後的配置檔案
- 資源使用監控

**驗收標準**：
- 監控系統資源使用 < 系統總資源的 20%
- Prometheus 查詢回應時間 < 2 秒
- Grafana Dashboard 載入時間 < 3 秒

## 第18天 - 整合測試總結
**目標**：完成系統測試並準備文件化工作

**工作項目**：
- 總結所有測試結果與問題
- 驗證核心驗收標準達成情況
- 建立部署測試檢查清單
- 準備文件撰寫素材

**交付物**：
- 最終測試報告
- 核心功能驗證清單
- 部署檢查清單
- 文件化素材準備

**驗收標準**：
- 7 個核心指標正常收集
- 2 個 Grafana Dashboard 可正常顯示
- 3 條告警規則可正確觸發
- Docker Compose 一鍵部署成功

## 第五階段：整合測試與優化（第16-18天）

## 第19天 - Dashboard 文件與技術文件撰寫
**目標**：撰寫完整的技術文件與使用指南

**工作項目**：
- 撰寫 Dashboard 使用指南
- 建立指標解釋文件
- 撰寫部署與維護文件
- 建立故障排除指南
- 整理專案 README.md
- 記錄測試結果與問題

**交付物**：
- 系統測試報告
- 端到端測試腳本
- 問題修復清單

**驗收標準**：
- 監控系統可穩定運行 24 小時
- 告警機制在負載測試中正確觸發
- 所有元件整合無誤

## 第20天 - 技術文章撰寫與專案總結
**目標**：完成 BIP 文章撰寫與專案最終總結

**工作項目**：
- 撰寫 BIP 文章「WeaMind 可觀測性實踐 - 從 0 到 1 的最小實作」
- 建立完整的 Quick Start 部署指南
- 錄製 Demo 影片（可選）
- 最終專案檢查與總結

**交付物**：
- BIP 文章（3000-5000 字）
- Quick Start 部署指南
- Demo 影片（15 分鐘）
- 專案最終總結報告

**驗收標準**：
- BIP 文章結構完整，包含技術細節與心得
- 專案文件可讓新手快速上手
- GitHub 專案展示效果良好
- 所有核心驗收標準達成

---

## 風險管控與應變計畫

### 時程風險
- **風險**：技術難點導致進度延遲
- **應變**：在中期進行檢討，必要時調整範圍

### 技術風險
- **風險**：WeaMind 應用整合困難
- **應變**：優先確保 Node Exporter 系統監控，應用監控可降級

### 品質風險
- **風險**：Dashboard 或告警效果不佳
- **應變**：專注核心功能，放棄進階美化

### 停損原則
**在預定時程內無條件完成**，不管完成度如何，整理現有成果並撰寫總結文章。

---

## 專案成功指標

### 最低驗收標準（必達）
- ✅ 7 個核心指標正常收集
- ✅ 2 個 Grafana Dashboard 可正常顯示
- ✅ 3 條告警規則可正確觸發
- ✅ Docker Compose 一鍵部署成功

### 理想目標（盡力達成）
- ✅ 完整的部署與維護文件
- ✅ 技術分享文章發布
- ✅ Demo 影片錄製
- ✅ 效能優化與最佳實踐

### 展示價值（技術加分）
- ✅ GitHub 專案完整開源
- ✅ 端到端監控解決方案
- ✅ 實際生產環境運行經驗
- ✅ 技術寫作與知識分享能力