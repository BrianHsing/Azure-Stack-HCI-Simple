# Lab2 - 佈署 ADDS、WAC 虛擬機器

## ADDS、WAC 安裝作業系統
- 開啟虛擬機器啟動 Windows Server 2019 安裝精靈，選擇要安裝或接受預設語言設定的語言，然後選取下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win1.png "win1")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win2.png "win2")<br>
- 選擇 Windows Server 2019 Standard 桌面體驗<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win3.png "win3")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win4.png "win4")<br>
- 選取[自訂：只安裝 Windows] (advanced)<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win5.png "win5")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win6.png "win6")<br>
- [Installing Windows] 頁面等待安裝<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win7.png "win7")<br>
- 設定系統管理員密碼後，進入作業系統<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win8.png "win8")<br>
- 更改主機名稱 ADDS / WAC 後，重新啟動虛擬機器<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win9.png "win9")<br>
- 設定網路卡靜態 IP 與 DNS<br>
  - ADDS IP 設定為 192.168.0.4<br>
  - WAC IP 設定為 192.168.0.5<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/win10.png "win10")<br>

## ADDS 虛擬機器安裝 AD DS、DHCP 角色

- 安裝 AD DS、DHCP 角色<br>
  - 開啟伺服器管理員，選擇新增角色與功能<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds1.png "adds1")<br>
  - Before you Begin、Installation Type、Server Selection，都直接點選下一步<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds2.png "adds2")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds3.png "adds3")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds4.png "adds4")<br>
  - Select Server roles 這個頁面中，選擇 Active Directory Domain Services、DHCP Server，後續就直接點選下一步，直到選擇 Install<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds5.png "adds5")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds6.png "adds6")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds7.png "adds7")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds8.png "adds8")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds9.png "adds9")<br>
- 將此伺服器升級成網域控制站<br>
  - 點選 Promote this server to a domain controller<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds10.png "adds10")<br>
  - 選擇 Add a new forest，Root domain name 輸入 hci.lab<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds11.png "adds11")<br>
  - 輸入 DSRM 密碼後，後續均選擇下一步直到按下 Install 按鈕執行安裝，完成安裝後會重新開機<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds12.png "adds12")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds13.png "adds13")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds14.png "adds14")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds15.png "adds15")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/adds16.png "adds16")<br>

- 設定 DHCP Server<br>
  - 使用系統管理員登入 hci\Administrator<br>
  - 開啟伺服器管理員，點選 Complete DHCP configuration，並且都直接選擇下一步直到 close 按鈕結束<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp1.png "dhcp1")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp2.png "dhcp2")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp3.png "dhcp3")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp4.png "dhcp4")<br>
  - 開啟 Menu 展開 Windows Administrative Tools，選擇 DHCP<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp5.png "dhcp5")<br>
  - 展開 adds.hci.lab，選擇 New Scope<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp6.png "dhcp6")<br>
  - 看到 New Scope 精靈後，點選下一步<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp7.png "dhcp7")<br>
  - 輸入 Scope 名稱<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp8.png "dhcp8")<br>
  - 輸入派發 IP 位址範圍<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp9.png "dhcp9")<br>
  - 此階段不會設定排除，這部分可以直接選擇下一步<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp10.png "dhcp10")<br>
  - 這個步驟會讓您 DHCP 租約時間，此階段不會更動，請選擇下一步<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp11.png "dhcp11")<br>
  - 點選下一步<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp12.png "dhcp12")<br>
  - 設定 Default Gateway 192.168.0.1<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp13.png "dhcp13")<br>
  - 後續步驟無須變更，均選擇下一步，直到按下 Finish 完成<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp13.png "dhcp13")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp14.png "dhcp14")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp15.png "dhcp15")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp16.png "dhcp16")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/dhcp17.png "dhcp17")<br>
## WAC 虛擬主機安裝 Windows Admin Center Gateway

- 將 WAC 加入網域 hci.lab 後，重新開機<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac1.png "wac1")<br>
- 使用 hci\Administrator 登入<br>
- 點選 Windows Admin Center Setup，勾選 I accept these terms 後，點選下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac2.png "wac2")<br>
- 選擇傳送診斷資料給 Microsoft 給微軟，選擇下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac3.png "wac3")<br>
- 選擇是否使用 Microsoft Update 後，選擇下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac4.png "wac4")<br>
- 看完安裝情境說明後，點選下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac5.png "wac5")<br>
- 這裡預設不變，直接選擇下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac5-5.png "wac5-5")<br>
- 這裡會產生自我簽署憑證，效期為 60 天，點選安裝<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac6.png "wac6")<br>
- 完成後，請先安裝 Microsoft Edge，再透過連結開啟 Windows Admin Center，開啟時請使用網域管理員登入<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac7.png "wac7")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac8.png "wac8")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/wac9.png "wac9")<br>

前往[Lab3 - 佈署 Azure Stack HCI OS](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab3.md)<br>