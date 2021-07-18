# Lab1 - 建立 Azure 虛擬機器模擬內部佈署環境

- 下載 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1)或複製下方 Powershell 指令<br>
	- 此命令會建立 Standard_E16s_v3 的虛擬機器、虛擬網路 172.16.0.0/16、子網路 172.16.1.0/24、區域建立在東南亞，作業系統為 Windows Server 2019 Datacenter<br>
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
 - 下載 Azure-Migrate-Basic.ps1<br>
	- 此命令會建立移轉後虛擬機器的虛擬網路、公用 IP、網路安全性群組，後續會在移轉流程中使用<br>
 - 使用 Single-Hyper-V.ps1 佈署 Hyper-V Server <br> 
	- 啟用 CloudShell<br>
    - 輸入`Connect-AzAccount` 登入<br>
	- 上傳 Single-Hyper-V.ps1<br>
	  ![GITHUB](https://github.com/BrianHsing/Azure-Migrate/blob/master/hyper-v/image/cloudshell-uploadps1.PNG "cloudshell-uploadps1")
	  ![GITHUB](https://github.com/BrianHsing/Azure-Migrate/blob/master/hyper-v/image/upload-success.PNG "upload-succsess")
	- 輸入並執行 `./Single-Hyper-V.ps1` <br>