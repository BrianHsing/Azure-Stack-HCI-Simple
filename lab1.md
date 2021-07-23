# Lab1 - 建立 Azure 虛擬機器模擬內部佈署環境

## 透過 Cloud Shell 匯入 ps1 建立 Azure 虛擬機器
- 下載 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1)<br>
	- 此命令會建立 Standard_E16s_v3 的虛擬機器、虛擬網路 172.16.0.0/16、子網路 172.16.1.0/24、區域建立在東南亞，作業系統為 Windows Server 2019 Datacenter、透過延伸模組建立 Hyper-V 服務、掛載 1TB 資料磁碟<br>
	- 使用者登入帳號 hciadmin，使用者密碼 yCM41YJm<br>
  - 使用 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1) 佈署 <br> 
	- 如果您之前沒有使用過 Cloudshell<br>
      - 請點選 Powershell <br>
      ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell1.png "CloudShell1")<br>
      - 點選建立儲存體<br>
      ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell2.png "CloudShell2")<br>
    - 啟用 CloudShell<br>
	![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell3.png "CloudShell3")<br>
    - 上傳 AzSHCI-Hyper-V.ps1<br>
	  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell4.png "CloudShell4")<br>
	- 輸入並執行 `./AzSHCI-Hyper-V.ps1` <br>

## 設定 Hyper-V 與建立虛擬機器

- 安裝前置作業<br>
  - 下載 Windows Server 2019 評估版<br>
    https://www.microsoft.com/zh-tw/evalcenter/evaluate-windows-server-2019<br>
    ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell6.png "CloudShell6")<br>
  - 下載 Azure Stack HCI & Windows admin Center <br>
    https://azure.microsoft.com/zh-tw/products/azure-stack/hci/hci-download/<br>
  - 提供一下必要資訊後，請下載 Azure Stack HCI & Windows admin Center <br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell5.png "CloudShell5")<br>
  - 使用`系統管理員身分`開啟 AzSHCI 的 Windows PowerShell ISE<br>
  - 建立虛擬網路交換器<br>
  ````
    #建立虛擬網路交換器
    New-VMSwitch -Name "vSwitch" -SwitchType Internal
    $adapter = Get-NetAdapter -Name "vEthernet (vSwitch)"
    New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex $adapter.InterfaceIndex
    New-NetNat -Name "InternalNat" -InternalIPInterfaceAddressPrefix 192.168.0.0/24
  ````
  - 掛載資料磁碟<br>
  ````
    #掛載資料磁碟
    Get-Disk | Where partitionstyle -eq 'raw' | `
    Initialize-Disk -PartitionStyle GPT  -PassThru | `
    New-Partition -AssignDriveLetter -UseMaximumSize | `
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" -Confirm:$false
  ````
  - 更改 Hyper-V 虛擬機器與虛擬硬碟路徑，更改至資料磁碟中<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v1.png "hyper-v1")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v2.png "hyper-v2")<br>
  - 建立 4 台虛擬主機角色<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v12.png "hyper-v12")<br>
    - ADDS 負責網域控制站、DHCP Server<br>
      - 2 vCPU、4096 MB RAM<br>
    - WAC 負責 Windows Admin Center 匣道<br>
      - 2 vCPU、4096 MB RAM<br>
    - AzSHCI-node1 / AzSHCI-node2 主機<br>
      - 4 vCPU、32768 MB RAM<br>
      - 掛載 2 個 128 GB VHD<br>
        - 選擇 SCSI Controller，點選 Hard Drive，點選 Add<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v4.png "hyper-v4")<br>
        - 點選 New<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v5.png "hyper-v5")<br>
        - 進入到新增虛擬硬碟精靈，點選下一步<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v6.png "hyper-v6")<br>
        - 預設選擇為 VHDX，選點下一步<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v7.png "hyper-v7")<br>
        - 選擇 Fixed size 初始化固定大小的虛擬磁碟<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v8.png "hyper-v8")<br>
        - 輸入硬碟名稱，例如 node1-ssd1、node1-ssd2、node2-ssd1、node2-ssd2，點選下一步<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v9.png "hyper-v9")<br>
        - 預設容量為 127 GB，點選下一步<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v10.png "hyper-v10")<br>
        - 點選 Finish，並等待硬碟建立<br>
        ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v11.png "hyper-v11")<br>
      - 3 個 Network Adapter，均與 vSwitch 連接，每張網開均需要開啟 Mac Address Spoofing<br>
      ````
      # 也可以透過 Powershell 指令直接改所有網卡設定
      Get-VMNetworkAdapter -VMName AzSHCI-node1 | Set-VMNetworkAdapter -MacAddressSpoofing On
      Get-VMNetworkAdapter -VMName AzSHCI-node2 | Set-VMNetworkAdapter -MacAddressSpoofing On
      ````
      ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/hyper-v3.png "hyper-v3")<br>

  - 啟用 Hyper-V VM 巢狀虛擬化<br>
  ````
    # 啟用 Hyper-V VM 巢狀虛擬化
    Set-VMProcessor -VMName AzSHCI-node1 -ExposeVirtualizationExtensions $true
    Set-VMProcessor -VMName AzSHCI-node2 -ExposeVirtualizationExtensions $true
  ````
  前往[Lab2 - 佈署 ADDS、WAC 虛擬機器](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab2.md)<br>