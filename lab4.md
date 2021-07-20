# Lab4 - 使用 Windows Admin Center 建立 Azure Stack HCI 叢集

Azure Stack HCI 叢集佈署精靈分為 5 個部分，分別為：<br>
1. 開始：此步驟為系統引導您確定現有設備已符合所有必要條件、新增伺服器節點、安裝所需的功能<br>
2. 網路：指派並設定網路介面卡，並為每部伺服器建立虛擬交換器<br>
3. 叢集：驗證叢集的設定是否正確<br>
4. 儲存體：設定儲存空間直接存取 (S2D)<br>
5. SDN (option)：可讓您在資料中心集中設定及管理網路和網路服務<br>

## 開始使用

此步驟為系統引導您確定現有設備已符合所有必要條件、新增伺服器節點、安裝所需的功能<br>

- 開啟瀏覽器 (推薦使用 Microsoft Edge)，輸入 https://wac.hci.lab，並且使用網域管理員身分登入<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster1.png "cluster1")<br>
- 點選新增，並在 Server Clusters 功能視窗中選擇 Create new<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster2.png "cluster2")<br>
- Cluster Type 選擇 Azure Stack HCI，server locations 選擇 All Servers in on site，如果您想在不同分公司也佈署一座叢集，讓兩個分公司間的叢集互相備援，您可以選擇 Servers in two sites，無論您選擇哪種類型，節點上限都是 16 個 node，單一個 site 下限為 2 個 node<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster3.png "cluster3")<br>
- 檢查佈署先決條件，確認後選擇下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster4.png "cluster4")<br>
- 新增 Azure Stack HCI 主機，輸入管理者帳號密碼 Administrator / (密碼自行定義)，並且輸入 2 台主機 IP 位址，分別為 192.168.0.11 與 192.168.0.21<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster5.png "cluster5")<br>
- 將兩台主機加入網域，輸入網域名稱 hci.lab，並且輸入網域帳號密碼，在這個步驟也將主機名稱分別改為 AzSHCI-node1 (192.168.0.11)、AzSHCI-node2 (192.168.0.21)，完成後點選 Apply changes，成功後點選下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster6.png "cluster6")<br>
- 安裝必要功能，此步驟如果稍早沒有啟用 Hyper-V VM 巢狀虛擬化，會造成 Hyper-V 無法成功安裝<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster7.png "cluster7")<br>
- 安裝作業系統更新，完成後選擇下一步<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster8.png "cluster8")<br>
- 因為此 Lab 使用 Azure VM 來做環境模擬，所以無法偵測硬體更新，這部分點選 Skip 即可<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/cluster9.png "cluster9")<br>
- 最後重新啟動兩台 Azure Stack HCI 主機，完成後前往下個階段網路設定<br>
  
## 網路