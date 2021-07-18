# Lab1 - 建立 Azure 虛擬機器模擬內部佈署環境

- 下載 [AzSHCI-Hyper-V.ps1](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/AzSHCI-Hyper-V.ps1)<br>
	- 此命令會建立 Standard_E16s_v3 的虛擬機器、虛擬網路 172.16.0.0/16、子網路 172.16.1.0/24、區域建立在東南亞，作業系統為 Windows Server 2019 Datacenter<br>
	- 使用者登入帳號 hciadmin，使用者密碼 hciadmin@1234<br>
    ````
    
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