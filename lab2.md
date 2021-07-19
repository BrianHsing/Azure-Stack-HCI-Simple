# Lab2 - 佈署 Azure Stack HCI OS

本篇主要是說明 Hyper-V 安裝 Azure Stack HCI OS 的操作步驟，主要是要設定伺服器名稱、靜態 IP 位址<br>

## 安裝 Azure Stack HCI OS

- 透過手動部署安裝，開啟虛擬機器啟動 Azure Stack HCI 安裝精靈，選擇要安裝或接受預設語言設定的語言，然後選取下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci1.png "azshci1")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci2.png "azshci2")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci3.png "azshci3")<br>
- 選取[自訂：只安裝較新版本的 Azure Stack HCI] (advanced)<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci4.png "azshci4")<br>
- 確認您要安裝作業系統磁碟機位置，然後選取下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci5.png "azshci5")<br>
- [Installing Azure Stack HCI] 頁面等待安裝<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci6.png "azshci6")<br>
- 在登入作業系統之前變更使用者的密碼，然後按 enter，進入伺服器設定工作畫面<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci7.png "azshci7")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci8.png "azshci8")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci9.png "azshci9")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci10.png "azshci10")<br>
- 輸入 7 進入 Remote Desktop，選擇 E 啟用，然後選擇 1 僅允許來自執行含有網路層級驗證之遠端桌面的電腦進行連線<br>
- 