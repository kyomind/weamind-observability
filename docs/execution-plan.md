# WeaMind V2.0 可觀測性實踐執行計畫書

**專案期間**：15 個工作日
**工作模式**：每日 2 小時，總計 30 小時
**專案目標**：建立完整的 WeaMind 可觀測性解決方案
**GitHub 專案**：weamind-observability（開源）

## 驗收標準總覽

### 核心交付物
- ✅ **Prometheus Metrics（6 個核心指標）**
  - 系統層（3 個）：CPU 使用率、可用記憶體、Disk I/O
  - 應用層（3 個）：HTTP 請求總數、API 回應時間、天氣查詢次數

- ✅ **Grafana Dashboard（2 個）**
  - System Overview（CPU/Memory/Disk 監控）
  - Application Performance（API metrics）

- ✅ **Alertmanager 告警規則（3 條）**
  - CPU > 80% 持續 1 分鐘
  - Memory > 70%
  - API 回應時間 > 3 秒

- ✅ **Docker Compose 一鍵部署**：完整的 Prometheus + Grafana + Alertmanager 監控堆疊

**驗收標準**：
- 所有監控組件正常運行
- Docker Compose 一鍵部署成功
- 6 個核心指標正常收集
- 2 個 Dashboard 正確顯示
- 3 條告警規則可正確觸發

## 第一階段：專案初始化與環境準備

## 第 1 天 - 專案架構規劃與 GitHub 建立
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

## 第 2 天 - Docker Compose 基礎配置
**目標**：完成核心監控元件的容器配置

**工作項目**：
- 配置 Prometheus 容器（基礎設定）
- 配置 Grafana 容器（基礎設定）
- 配置 Alertmanager 容器（基礎設定）
- 配置 Node Exporter 容器（系統指標收集）
- 建立基礎 volumes 配置
- 完成 Grafana provisioning（自動化資料源與 dashboards provider）

**交付物**：
```
├── docker-compose.yml          # 完整 4 個容器配置
├── prometheus/
│   └── prometheus.yml          # Prometheus 基礎配置
├── grafana/
│   └── provisioning/           # Grafana 自動配置目錄（本日一次到位）
│       ├── datasources/
│       │   └── prometheus.yml  # 自動配置 Prometheus 資料源
│       └── dashboards/
│           └── dashboard.yml   # dashboards provider（自動載入 JSON）
└── alertmanager/
  └── alertmanager.yml        # Alertmanager 基礎配置
```

**驗收標準**：
- `docker compose up -d` 可成功啟動 4 個容器
- 所有服務健康檢查通過
- 可透過瀏覽器存取 Prometheus (9090)、Grafana (3000)、Alertmanager (9093)
- 重新啟動 Grafana 後，Prometheus 資料源自動就緒（無須手動設定）

## 第 3 天 - 基礎連線與測試
**目標**：確保所有元件間的基礎連線正常

**工作項目**：
- 測試 Prometheus 能成功抓取 Node Exporter 指標
- 驗證第 2 天的 Grafana provisioning 是否自動載入資料源成功
- 在 Grafana 中以現成資料源執行基本查詢（CPU、記憶體）
- 測試 Alertmanager 基礎功能
- 建立簡單的測試指標查詢

**交付物**：
- Prometheus targets 顯示 UP 狀態
- Grafana 可成功連接 Prometheus（由 provisioning 自動配置）
- 基礎系統指標可在 Prometheus 中查詢到

**驗收標準**：
- Prometheus UI 中 Node Exporter target 狀態為 UP
- Grafana 中可查詢到基本系統指標（如 CPU、Memory），且無需手動設定資料源
- Alertmanager 介面正常顯示

## 第二階段：WeaMind 應用整合

## 第 4 天 - WeaMind Metrics 端點開發
**目標**：在 WeaMind 應用中新增 /metrics 端點

**工作項目**：
- 在 WeaMind FastAPI 應用中安裝 prometheus_client
- 實作基礎 HTTP 請求計數器
- 實作 API 回應時間直方圖（自訂 buckets，覆蓋 >=3s，例如：0.1, 0.3, 0.5, 1, 2, 3, 5, 8）
- 測試 /metrics 端點輸出

**交付物**：
- WeaMind 應用的 /metrics 端點正常運作
- 3 個應用層指標正確輸出：
  - `http_requests_total`
  - `http_request_duration_seconds`
  - `weather_queries_total`

**驗收標準**：
- 訪問 `http://weamind-domain/metrics` 返回 Prometheus 格式指標
- 指標包含適當的 labels（method, endpoint, status_code 等）

## 第 5 天 - WeaMind 業務指標實作
**目標**：實作天氣查詢相關的業務指標

**工作項目**：
- 實作天氣查詢次數計數器（按縣市分類）
- （選配/Phase 2）LINE Bot 訊息處理指標

**交付物**：
- 天氣查詢指標：`weather_queries_total{city="台北市"}`
- （選配）LINE Bot 指標：`line_messages_total`

**驗收標準**：
- 執行天氣查詢後，指標正確累加
- 指標包含有意義的 labels 便於後續分析；LINE Bot 指標不納入核心驗收

## 第 6 天 - Prometheus 抓取配置
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
- 可在 Prometheus 中查詢到所有 6 個核心指標
- 指標資料持續更新

## 第 7 天 - 指標驗證與調整
**目標**：驗證所有指標收集正確並進行調整

**工作項目**：
- 測試所有 6 個核心指標的資料正確性
- 調整指標的 labels 和命名規範
- 驗證指標的時間序列資料
- 修復發現的問題

**交付物**：
- 指標驗收清單（勾選紀錄）：涵蓋 6 個核心指標的可查詢性與資料合理性
- 指標修正清單（必要時）

**驗收標準**：
- 所有 6 個指標在 Prometheus 中可正常查詢
- 指標資料符合預期邏輯（CPU 使用率 0-100%、請求數遞增等）
- 指標命名符合 Prometheus 最佳實踐

## 第三階段：Grafana 儀表板開發

## 第 8 天 - Grafana 自動化驗證與優化
**目標**：驗證並完善 Grafana 的自動化配置（第 2 天已完成基礎 provisioning）

**工作項目**：
- 驗證 dashboards provider 自動載入 JSON 正常
- 新增/調整必要的 dashboard 變數與資料源引用
- 設定 Grafana 基礎參數（admin 密碼、必要 plugin）

**交付物**：
```
grafana/
└── provisioning/
  ├── datasources/
  │   └── prometheus.yml      # 已於第 2 天建立
  └── dashboards/
    └── dashboard.yml       # 自動載入 provider（本日驗證/微調）
```

**驗收標準**：
- 重啟 Grafana 容器後自動載入資料源與 dashboard
- 無需手動配置即可使用資料源查詢指標

## 第 9 天 - System Overview Dashboard 開發
**目標**：開發系統層監控儀表板

**工作項目**：
- 採用社群 Node Exporter 模板為基底，做最小化調整
- 核心面板優先：CPU 使用率、可用記憶體、檔案系統使用率
- 其他面板（磁碟 I/O、系統負載）可列為後續增補

**交付物**：
- `grafana/provisioning/dashboards/system-overview.json`
- 至少 3 個核心系統指標面板（CPU/Memory/Filesystem）
- 適當的閾值警告設定（可先簡化）
 - 註：核心交付物含 Disk I/O 指標；初版先以上述 3 面板完成驗收，Disk I/O 面板列為後續增補（避免初期過度客製）。

**驗收標準**：
- Dashboard 自動載入到 Grafana
- 所有面板正確顯示即時系統指標
- 視覺化效果清晰易讀

## 第 10 天 - Application Performance Dashboard 開發
**目標**：開發應用層監控儀表板

**工作項目**：
- 設計 Application Performance Dashboard 布局（精簡版）
- 建立 HTTP 請求量面板（時間序列圖）
- 建立 API p95 回應時間面板（直方圖/折線）
- 建立錯誤率面板（gauge 或單值，透過 PromQL 計算）
- 建立天氣查詢統計面板（總量或按城市）

**交付物**：
- `grafana/provisioning/dashboards/application-performance.json`
- 包含 3–4 個核心業務指標面板（QPS、p95、error rate、weather queries）

**驗收標準**：
- Dashboard 顯示即時應用效能指標
- 錯誤率透過 PromQL 查詢準確計算

## 第四階段：告警系統實作

## 第 11 天 - Alertmanager 基礎配置
**目標**：配置 Alertmanager 的基礎告警功能

**工作項目**：
- 建立 Alertmanager 配置檔
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
- Alertmanager 可成功發送測試告警
- 告警訊息格式清晰易讀
- 通知通道配置正確

## 第 12 天 - Prometheus 告警規則開發
**目標**：實作 3 條核心告警規則

**工作項目**：
- 實作 CPU 使用率告警（> 80% 持續 1 分鐘）
- 實作記憶體使用率告警（> 70%）
- 實作 API 回應時間告警（> 3 秒）
- 配置告警規則檔案
- 進行人工觸發驗證（製造高 CPU/記憶體、模擬慢 API）並記錄觀察

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
- 告警條件符合業務需求，且已完成一次人工觸發與恢復驗證

## 第 13 天 - 告警測試與調整
**目標**：測試告警觸發機制並調整參數

**工作項目**：
- 手動驗證告警觸發與恢復機制
- 根據測試結果微調告警閥值與持續時間

**交付物**：
- 告警測試紀錄（簡要）
- 調整後的告警規則

**驗收標準**：
- 所有 3 條告警可正確觸發
- 告警恢復機制正常
- 告警訊息包含足夠的診斷資訊

## 第五階段：系統優化與文件化

## 第 14 天 - 監控系統整合測試
**目標**：確保整個監控系統穩定運行

**工作項目**：
- 設定基線：Prometheus retention、scrape_interval；Grafana 自動刷新頻率
- 執行基本端到端檢核（targets、dashboards、alerts）

**交付物**：
- 基線設定清單與調整後配置
- 基本端到端檢核紀錄

**驗收標準**：
- 監控系統穩定運行，targets 均為 UP
- 主要查詢/面板回應時間穩定

## 第 15 天 - 技術文件與最終整合
**目標**：完成核心文件撰寫與專案最終整合

**工作項目**：
- 更新專案 README.md 與 Quick Start 指南
- 驗證核心驗收標準達成情況
- 最終專案檢查與總結

**交付物**：
- 更新後的 README.md（含 Quick Start）
- 核心功能驗證清單
- 專案最終總結（簡要）

**驗收標準**：
- 6 個核心指標正常收集
- 2 個 Grafana Dashboard 可正常顯示
- 3 條告警規則可正確觸發
- Docker Compose 一鍵部署成功
- 所有核心驗收標準達成

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
**在預定時程內無條件完成**，不管完成度如何，整理現有成果並總結技術實作經驗。

---

## 專案成功指標

### 最低驗收標準（必達）
- ✅ 6 個核心指標正常收集
- ✅ 2 個 Grafana Dashboard 可正常顯示
- ✅ 3 條告警規則可正確觸發
- ✅ Docker Compose 一鍵部署成功

### 理想目標（盡力達成）
- ✅ 完整的部署與維護文件
- ✅ 效能優化與最佳實踐
- ✅ 自動化部署腳本與配置管理
- ✅ 完整的監控指標與告警系統

### 展示價值（技術加分）
- ✅ GitHub 專案完整開源
- ✅ 端到端監控解決方案
- ✅ 實際生產環境運行經驗
- ✅ 可擴展的監控架構設計