# Lab1 - 建立 Azure 虛擬機器模擬內部佈署環境

## 透過 Cloud Shell 匯入 ps1 建立 Azure 虛擬機器
- 下載 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1)或複製下方 Powershell 指令<br>
	- 此命令會建立 Standard_E16s_v3 的虛擬機器、虛擬網路 172.16.0.0/16、子網路 172.16.1.0/24、區域建立在東南亞，作業系統為 Windows Server 2019 Datacenter、透過延伸模組建立 Hyper-V 服務<br>
	- 使用者登入帳號 hciadmin，使用者密碼 hciadmin@1234<br>
    ````
    $resourceGroup = "AzSHCI-infra"
    $location = "Southeast Asia"
    $vmName = "AzSHCI-Infra"
    $vmSize = "Standard_E16s_v3"

    #建立資源群組AzSHCI
    New-AzResourceGroup -Name $resourceGroup -Location $location

    #建立虛擬網路
    $virtualNetwork = New-AzVirtualNetwork `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -Name $vmName-Vnet `
    -AddressPrefix 172.16.0.0/16 `
    $subnetWorkload = Add-AzVirtualNetworkSubnetConfig `
    -Name Workload-Subnet `
    -AddressPrefix 172.16.1.0/24 `
    -VirtualNetwork $virtualNetwork
    $virtualNetwork | Set-AzVirtualNetwork

    #建立使用者帳號密碼憑證
    $User = "hciadmin"
    $PWord = ConvertTo-SecureString -String "hciadmin@1234" -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

    #建立虛擬網路
    $virtualNetwork = Get-AzVirtualNetwork -Name $vmName-Vnet -ResourceGroupName $resourceGroup 
    $pip = New-AzPublicIpAddress -ResourceGroupName $resourceGroup -Location $location -Name $vmName-pip -AllocationMethod Static -Sku Standard
    $nsgRule = New-AzNetworkSecurityRuleConfig -Name AllowRDPInbound -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $vmName-nsg -SecurityRules $nsgRule
    $nic = New-AzNetworkInterface -Name $vmName-Nic -ResourceGroupName $resourceGroup -Location $location `
    -SubnetId $virtualNetwork.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id
    
    #建立虛擬機器設定檔
    $vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize | `
    Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential $Credential | `
    Set-AzVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version latest | `
    Add-AzVMNetworkInterface -Id $nic.Id

    # 建立虛擬機器
    New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig

    # 建立資料磁碟並且掛載
    $vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName
    $diskConfig = New-AzDiskConfig -Location $location -CreateOption Empty -DiskSizeGB 256 -Tier P15 -SkuName Premium_LRS
    $dataDisk = New-AzDisk -ResourceGroupName $resourceGroup -DiskName datadisk -Disk $diskConfig
    $vm = Add-AzVMDataDisk -VM $vm -Name datadisk -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1
    Update-AzVM -ResourceGroupName $resourceGroup -VM $vm

    # 透過延伸模組安裝 Hyper-V
    $PublicSettings = '{"commandToExecute":"powershell Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart"}'
    Set-AzVMExtension -ExtensionName "HyperV" -ResourceGroupName $resourceGroup -VMName $vmName `
    -Publisher "Microsoft.Compute" -ExtensionType "CustomScriptExtension" -TypeHandlerVersion 1.4 `
    -SettingString $PublicSettings -Location $location
    
    ````
 - 使用 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1) 佈署 <br> 
	- 如果您之前沒有使用過 Cloudshell<br>
      - 請點選 Powershell <br>
      ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell1.png "CloudShell1")<br>
      - 點選建立儲存體<br>
      ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell2.png "CloudShell2")<br>
    - 啟用 CloudShell<br>
	![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell3.png "CloudShell3")<br>
    - 輸入`Connect-AzAccount -UseDeviceAuthentication` 登入，上傳 AzSHCI-Hyper-V.ps1<br>
	![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/CloudShell4.png "CloudShell4")<br>
	- 輸入並執行 `./AzSHCI-Hyper-V.ps1` <br>