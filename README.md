# 透過 Azure VM 巢狀虛擬化實作 Azure-Stack-HCI
 Azure Stack HCI 是一種超融合式基礎結構 (HCI) 叢集解決方案，可以整合內部部署基礎結構與雲端服務的混合式環境中裝載虛擬化 Windows 和 Linux 工作負載及其儲存體，Azure 混合式服務提供雲端式監視、Site Recovery 和虛擬機器 (VM) 備份等服務來增加叢集功能的完整性，Azure Stack HCI 使用 Windows Admin Center 來統一集中管理叢集。<br>

 以正式環境來說，您可以從 OEM 購買的裸機伺服器或已預先安裝 Azure Stack HCI 作業系統的[驗證伺服器](https://hcicatalog.azurewebsites.net/)來進行佈署。但如果您目前手邊沒有設備可以操作，其實可以建立  Azure 虛擬機器，選擇 Dv3、Ev3 等支援巢狀虛擬化的規格，透過 Hyper-V 來體驗 Azure Stack HCI 的佈署及管理操作。<br>
 
 本篇主要分為兩大主軸，第一是透過 Azure VM 巢狀虛擬化來模擬內部佈署的 Azure Stack HCI 叢集環境，第二則是透過 Azure Arc 來實現對雲端與內部佈署提供一致的治理與管理，Azure Arc 主要能夠在雲端介面管理虛擬機器、Kubernetes 叢集和資料庫，就像是在 Azure 中執行一樣，使用熟悉的 Azure 介面進行管理。<br>

 您大約需要花費 ?? 分鐘完成此 Lab，預計花費 $$ 元，透過手把手教學您將學會：<br>
 - 學會在 Azure 模擬內部部署 Azure Stack HCI 環境<br>
 - 學會操作 Windows Admin Center 來管理您的 Azure Stack HCI 叢集<br>
 - 學會 Azure Arc 與 Azure Stack HCI 整合設定、更新與監控<br>
 - 學會啟用額外的 Azure 混合式服務<br>

## 環境架構說明
 - 您要使用本篇實戰演練需要：<br>
   - Azure 訂用帳戶、Azure 訂用帳戶擁有者權限<br>
   - 有基本的 Powershell 使用經驗<br>
 - 需要使用 Azure 虛擬機器巢狀虛擬化來模擬，稍後可以遵循 Lab 透過撰寫好的 ps1 檔直接執行佈署，或者您也可以直接建立<br>
 - Azure 虛擬機器建立完成後，主要會在 Hyper-V 中建立 4 台虛擬機器<br>
   - 第一台角色負責網域控制站 (hci.lab) 與 DHCP Server<br>
   - 第二台角色負責 Windows Admin Center 閘道作為後續管理 Azure Stack HCI 統一管理介面<br>
   - 另外兩台角色為 Azure Stack HCI 主機，這兩台主機特別要注意的是，必須要啟用巢狀虛擬化以及 MAC Address Spoofing，才能順利地在 Azure Stack HCI 叢集上建立虛擬機器以及在第二層虛擬網路交換器之間順利地路由。<br>
 ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/AzSHCI-architech.png)<br>

## 實戰演練

- [Lab1 - 建立 Azure 虛擬機器模擬內部佈署環境](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab1.md)<br>
- [Lab2 - 佈署 ADDS、WAC 虛擬機器](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab2.md)<br>
- [Lab3 - 佈署 Azure Stack HCI OS](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab3.md)<br>
- [Lab4 - 使用 Windows Admin Center 建立 Azure Stack HCI 叢集](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab4.md)<br>
- [Lab5 - 使用 Azure Storage account 設定雲端見證](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab5.md)<br>
- [Lab6 - 在 Azure Stack HCI 叢集上建立磁碟區](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab6.md)<br>
- [Lab7 - 在 Azure Stack HCI 叢集上建立虛擬機器](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab7.md)<br>
- [Lab8 - Azure Arc 與 Azure Stack HCI 整合設定、更新與監控](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab8.md)<br>
- [Lab9 - 啟用額外的 Azure 混合式服務來增強叢集功能](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab9.md)<br>