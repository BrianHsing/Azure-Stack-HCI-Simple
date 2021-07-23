#建立虛擬網路交換器
New-VMSwitch -Name "vSwitch" -SwitchType Internal
$adapter = Get-NetAdapter -Name "vEthernet (vSwitch)"
New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex $adapter.InterfaceIndex
New-NetNat -Name "InternalNat" -InternalIPInterfaceAddressPrefix 192.168.0.0/24

#掛載資料磁碟
Get-Disk | Where partitionstyle -eq 'raw' | `
Initialize-Disk -PartitionStyle GPT  -PassThru | `
New-Partition -AssignDriveLetter -UseMaximumSize | `
Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" -Confirm:$false

# 啟用 Hyper-V VM 巢狀虛擬化
Set-VMProcessor -VMName AzSHCI-node1 -ExposeVirtualizationExtensions $true

# CMD 更改 AzSHCI 網路卡設定靜態IP、DNS
netsh interface ip set address "Ethernet 4" static 192.168.0.14 255.255.255.0 192.168.0.1
netsh interface ip set dnsserver "Ethernet 4" static 192.168.0.4

# CMD 更改 AzSHCI 網路卡設定靜態IP、DNS
Get-PhysicalDisk | Set-PhysicalDisk -MediaType ssd