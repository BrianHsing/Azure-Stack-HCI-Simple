# Lab2 - 佈署 Azure Stack HCI OS

本篇主要是說明 Hyper-V 安裝 Azure Stack HCI OS 的操作步驟，主要是要設定伺服器名稱、靜態 IP 位址<br>

## 安裝 Azure Stack HCI OS

- 透過手動部署安裝，開啟虛擬機器啟動 Azure Stack HCI 安裝精靈，選擇要安裝或接受預設語言設定的語言，然後選取[下一步]<br>
- 選取[自訂：只安裝較新版本的 Azure Stack HCI] (advanced)<br>
- 確認您要安裝作業系統磁碟機位置，然後選取[下一步]<br>
- [Installing Azure Stack HCI] 頁面等待安裝<br>
- 在登入作業系統之前變更使用者的密碼，然後按 enter，進入伺服器設定工作畫面<br>
- 更改伺服器名稱為 AzSHCI-node1 / AzSHCI-node2，輸入 1，並且輸入名稱後，選擇 Y 重新開機<br>
- 輸入 7 進入 Remote Desktop，選擇