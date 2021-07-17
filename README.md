# 透過 Azure VM 巢狀虛擬化實作 Azure-Stack-HCI
 Azure Stack HCI 是一種超融合式基礎結構 (HCI) 叢集解決方案，可以整合內部部署基礎結構與雲端服務的混合式環境中裝載虛擬化 Windows 和 Linux 工作負載及其儲存體，Azure 混合式服務提供雲端式監視、Site Recovery 和虛擬機器 (VM) 備份等服務來增加叢集功能的完整性，Azure Stack HCI 使用 Windows Admin Center 來統一集中管理叢集。<br>

 以正式環境來說，您可以從 OEM 購買的裸機伺服器或已預先安裝 Azure Stack HCI 作業系統的[驗證伺服器](https://hcicatalog.azurewebsites.net/)來進行佈署。但如果您目前手邊沒有設備可以操作，其實可以建立  Azure 虛擬機器，選擇 Dv3、Ev3 等支援巢狀虛擬化的規格，透過 Hyper-V 來體驗 Azure Stack HCI 的佈署及管理操作。<br>
 
 本篇主要分為兩大主軸，第一是透過 Azure VM 巢狀虛擬化來模擬內部佈署的 Azure Stack HCI 叢集環境，第二則是透過 Azure Arc 來實現對雲端與內部佈署提供一致的治理與管理，Azure Arc 主要能夠在雲端介面管理虛擬機器、Kubernetes 叢集和資料庫，就像是在 Azure 中執行一樣，使用熟悉的 Azure 介面進行管理。<br>

 您大約需要花費 ?? 分鐘完成此 Lab，預計花費 $$ 元，透過手把手教學您將學會：<br>
 - 學會在 Azure 模擬內部部署 Azure Stack HCI 環境<br>
 - 學會操作 Windows Admin Center 來管理您的 Azure Stack HCI 叢集<br>
 - 學會 Azure Arc 與 Azure Stack HCI 整合設定與監控<br>
 - 學會啟用額外的 Azure 混合式服務<br>

## 環境架構說明
 - 您要使用本篇實戰演練需要：<br>
   - Azure 訂用帳戶、Azure 訂用帳戶擁有者權限<br>
   - 有基本的 Powershell 使用經驗<br>
 - 本篇需要使用 Azure VM 巢狀虛擬化來模擬