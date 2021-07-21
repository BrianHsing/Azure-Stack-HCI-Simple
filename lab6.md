# Lab6 - 在 Azure Stack HCI 叢集上建立磁碟區

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

- 在磁片區清單中，選取開啟 Volume01，在頁面頂端，選取 [ 開啟]。 這會啟動 Windows Admin Center 中 的 [檔案 ] 工具。