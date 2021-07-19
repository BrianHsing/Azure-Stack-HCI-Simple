# Lab3 - 佈署 Azure Stack HCI OS

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
- 啟用遠端桌面，輸入 7 進入 Remote Desktop，選擇 E 啟用，然後選擇 1 僅允許來自執行含有網路層級驗證之遠端桌面的電腦進行連線<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci10.png "azshci13")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci10.png "azshci14")<br>
- 透過 CMD 更改網路設定，輸入 15 進入 command line<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci15.png "azshci15")<br>
- 輸入 `netsh interface ipv4 show config`，可以看到目前擁有網路卡介面的名稱<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/azshci16.png "azshci16")<br>
- 依序更改靜態 IP、DNS Server<br>
  - AzSHCI-node1<br>
  ````
  netsh interface ip set address "Ethernet" static 192.168.0.11 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet" static 192.168.0.4

  netsh interface ip set address "Ethernet 2" static 192.168.0.12 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet 2" static 192.168.0.4

  netsh interface ip set address "Ethernet 2" static 192.168.0.13 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet 2" static 192.168.0.4
  ````
  - AzSHCI-node2<br>
  ````
  netsh interface ip set address "Ethernet" static 192.168.0.21 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet" static 192.168.0.4

  netsh interface ip set address "Ethernet 2" static 192.168.0.22 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet 2" static 192.168.0.4

  netsh interface ip set address "Ethernet 2" static 192.168.0.23 255.255.255.0 192.168.0.1
  netsh interface ip set dnsserver "Ethernet 2" static 192.168.0.4
  ````

  前往[Lab4 - 使用 Windows Admin Center 建立 Azure Stack HCI 叢集](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab3.md)<br>