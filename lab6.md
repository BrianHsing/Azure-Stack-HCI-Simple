# Lab6 - 在 Azure Stack HCI 叢集上建立磁碟區與虛擬機器

此 Lab 僅建立 2 個主機節點，所以也只能建立雙向鏡像<br>

## 建立雙向鏡像磁片區

- 在 Windows Admin Center 中，連線到叢集，然後從左欄 Storage 功能列中選擇 Volumes，在右邊頁籤中，選擇 Iventory<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor1.png "stor1")<br>
- 點選 Create 按鈕，輸入 volume name、還有預計建立的磁片空間大小，因為選擇 Two-way mirror，所以占用的空間會以 2 倍計算，也可以開啟其他選項功能，例如重復資料刪除和壓縮、完整性總和檢查碼或 BitLocker 加密，完成後點選 Create 按鈕<br>
  - 建立 Volume01 10 GB，主要用於放置作業系統映像檔<br>
  - 建立 Volume02 100 GB，主要用於放置虛擬機器<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor2.png "stor2")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor3.png "stor3")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor4.png "stor4")<br>

## 開啟磁片區並新增映像檔

- 在磁片區清單中，選取開啟 Volume01，在頁面頂端，選取 open。 這會啟動 Windows Admin Center 中 的 Files & file sharing 工具，在這裡上傳映像檔<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor5.png "stor5")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/stor7.png "stor7")<br>


## 建立虛擬機器

- 在 Windows Admin Center 中，然後從左欄 Compute 功能列中選擇 Virtual machines，並在右邊點選 Add -> New<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm1.png "vm1")<br>
- 輸入虛擬機器名稱，選擇您想將虛擬機器放在哪個主機節點，並且選擇 Path 為剛剛所建立的 Volume02，處理器與記憶體分別給予 2 vCPU 與 4 GB RAM<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm2.png "vm2")<br>
- virtual switch 選擇之前所建立的 ConvergedSwitch，並建立 40 GB 的虛擬磁碟，最後在選擇剛剛所上傳的映像檔安裝作業系統，之後按下 Create，等待建立<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm3.png "vm3")<br>
- 在按照上述步驟再建立一台 VM2<br>
- 如果您想要設定這兩台虛擬機器不要被分配在同一台主機集區，可以點選右上角齒輪，點選左邊的功能表下方，選擇 Affinity rules 設定規則，點選 Create rule<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm4.png "vm4")<br>
- 輸入規則名稱，規則類型選擇 Apart (different servers)，下方依序選擇 vm1、vm2，完成後點選 Create rule<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm5.png "vm5")<br>
- 返回 Virtual machines 頁面，就可以看到 vm1、vm2 已經預設被分配到兩台主集節點上了<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/vm6.png "vm6")<br>
