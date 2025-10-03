# WeaMind Observability Project Instructions

## Project Overview
WeaMind Observability is an open-source monitoring solution designed as a complete observability practice project for WeaMind weather query services. This project provides a Prometheus + Grafana + AlertManager monitoring stack, implementing comprehensive monitoring from system to application layers.

## Architecture
- **Monitoring Stack**: Prometheus (metrics collection) + Grafana (visualization) + AlertManager (alerting) + Node Exporter (system metrics)
- **Containerized Deployment**: Docker Compose one-click deployment for all monitoring components
- **Metrics System**: 7 core metrics (3 system-level + 4 application-level)
- **Dashboards**: 2 core dashboards (System Overview + Application Performance)
- **Alerting System**: 3 core alerting rules
- **Documentation System**: Complete deployment, usage, and maintenance documentation

## Technology Stack
- **Container Technology**: Docker, Docker Compose
- **Monitoring Tools**: Prometheus, Grafana, AlertManager, Node Exporter
- **Configuration Management**: YAML configuration files
- **Documentation Tools**: Markdown technical documentation
- **Version Control**: Git, GitHub (open source project)

## Coding Standards
1. **Configuration File Standards**: All YAML configurations use 2-space indentation
2. **Documentation Writing**: Use Markdown format with clear code examples and screenshots
3. **Container Naming**: Use clear service names (prometheus, grafana, alertmanager, node-exporter)

### Naming Conventions
- **Configuration Files**: Use descriptive filenames (prometheus.yml, grafana-datasource.yml)
- **Dashboard Files**: Use kebab-case (system-overview.json, application-performance.json)
- **Docker Services**: Use hyphen separation (node-exporter, alert-manager)
- **Git Branches**: Use feature branches for new features or bug fixes. e.g. `feature/location-settings`(noun)

### Git Commit Messages
- **Natural English**: Use clear, descriptive English sentences
- **Examples**:
  - "Update CHANGELOG for v0.1.3"
  - "Enhance GitHub Actions release with full git history"
  - "Add location settings feature"

## References
- Architecture: `docs/Architecture.md` (high-level overview of the system architecture)
- Todo: `docs/Todo.md` (includes completed and pending tasks)
- Directory structure: `docs/Tree.md`
- PRD documents: `prd/` (internal only)
- Makefile: `Makefile` (project-specific shortcuts and preferred commands)
- CLI Best Practices: `.github/prompts/cli-best-practices.prompt.md` (guidelines for using terminal tools effectively)
- CHANGELOG Guide: `.github/prompts/changelog.prompt.md` (comprehensive guide for maintaining version history with AI assistance)

## Core Development Commands
**Important**: This project uses Docker Compose for containerized deployment and YAML for configuration management.

- **Deploy**: `docker compose up -d` start complete monitoring stack
- **Stop**: `docker compose down` stop all services
- **Rebuild**: `docker compose up --build -d` rebuild and start services
- **View Logs**: `docker compose logs -f [service_name]` view service logs
- **Health Check**: `docker compose ps` check all service status

## Monitoring Stack Access
- **Prometheus**: http://localhost:9090 (metrics collection and querying)
- **Grafana**: http://localhost:3000 (visualization dashboards)
- **AlertManager**: http://localhost:9093 (alert management)
- **Node Exporter**: http://localhost:9100/metrics (system metrics endpoint)

## Configuration Management
- **Prometheus**: `prometheus/prometheus.yml` (scrape configuration)
- **Grafana**: `grafana/provisioning/` (automatic configuration)
- **AlertManager**: `alertmanager/alertmanager.yml` (alert configuration)
- **Docker Compose**: `docker-compose.yml` (service orchestration)
