# Lab5 - Azure Stack HCI 叢集初始設定

Azure Stack HCI 必須在安裝後的30天內依據 Azure Online Services 條款進行註冊，這個 Lab 主要是說明如何向 Azure 註冊 Azure Stack HCI 叢集，並啟用進行監視、支援、計費和混合式服務<br>
- 先決條件<br>
  - 擁有任何類型的現有訂用帳戶<br>
  - 註冊叢集的帳號必須具有下列 Azure 許可權<br>
    - Register a resource provider<br>
    - Create/Get/Delete Azure resources and resource groups<br>
  - 建議您直接使用擁有 Azure AD Global admin 與 Azure Subscription Owner 帳號來進行登入，可以節省一些時間<br>

## 更新 Windows Admin Center 延伸模組

無論是想要佈署 AKS on HCI 或傳統 Windows Server 內建的角色服務，您都可以在這邊查看是否有更新可以下載<br>

- 點選 WAC 管理頁面右上角齒輪，並且在左欄 Gateway 功能列中選擇 Extension，在這裡您可以將您需要的模組更新至最新版本<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update14.png "update14")<br>

## 使用 Windows Admin Center 向 Azure 註冊 Azure Stack HCI 叢集


- 註冊 Windows Admin Center<br>
  - 選擇左邊的功能表下方，點選 Setting。在 Azure Stack HCI 功能欄中，選擇 Azure Stack HCI registration，點選右邊 Register<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register1.png "register1")<br>
  - 點選右邊紅框中 Copy 按鈕，並且點選 3. Enter the code，開啟登入網頁，輸入 code 並且使用具有符合權限的帳號登入<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register2.png "register2")<br>
  - 完成登入後，回到 WAC 管理頁面，選擇對應的 Tenant ID，並且選擇 Create new Azure AD application，最後點選 Connect<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register3.png "register3")<br>
  - 完成後，選擇 Sign in 按鈕，授予相關權限要求<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register4.png "register4")<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register5.png "register5")<br>
  - 將註冊的 Azure Stack HCI 服務選擇要放在哪個資源群組以及區域，完成後點選 register<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register6.png "register6")<br>
  - 如果您使用的是 21H2 版本，則可以看到下方可以讓您勾選啟用 Azure Arc 的選項<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI-Simple/blob/main/image/register6-1.png "register6-1")<br>
  - 出現 CredSSP 詢問視窗後，一樣是選擇 Yes 按鈕，後續需要幾分鐘的時間來進行註冊<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register7.png "register7")<br>
  - 註冊成功後，即可看到註冊相關資訊與連線同步時間<br>
  ![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/register8.png "register8")<br>

# 設定叢集雲端見證

因為本篇 Lab 只使用兩個節點，所以需要使用見證，來避免點失敗時無法選擇存活的節點，仲裁見證支援 3 種類型，本篇會使用雲端見證來作為叢集的仲裁<br>

- 開啟 Azure 入口網站，新增 Storage accounts (操作步驟省略)，新增完成後，請在 Storage accounts 頁面中的 Security + networking 功能欄位下，選擇 Access keys，複製 Storage account name 與 key1，稍後會使用到<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/witness1.png "witness1")<br>
- 選擇左邊的功能表下方，點選 Setting。在 Cluster 功能欄中，選擇 Witness，點選右邊 Witness typer 下拉是選單，選擇 Cloud witness，並且填入 Azure Storage account name 與 Azure Storage account key，完成後按下 Save 按鈕<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/witness2.png "witness2")<br>
- 完成後可以觀察到 Witness resource status 顯示 Online<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/witness3.png "witness3")<br>


## 啟用 Azure Arc 整合

未來叢集中的每一部伺服器預設都會 Azure Arc 啟用，但如果是較早註冊的叢集，則是透過圖形化介面一鍵啟用<br>
如果您使用 `21H2` 的版本，則不需要特別設定，完成註冊後即可看到叢集節點出現 Azure Arc 整合的 Azure Stack HCI<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc4.png "arc4")<br>
也可以透過在主集節點執行 PowerShell 指令 `Get-AzureStackHCIArcIntegration`，查詢自動啟用狀態<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc5.png "arc5")<br>


- 在 Windows Admin Center 的 All connections 頁面，選擇主機節點<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc1.png "arc1")<br>
- 在左邊功能列選擇 Azure Hybrid center，在右邊的頁面就可以看到 Azure Arc，然後點選 Set up 按鈕，右邊會出現 Set up Azure Arc 視窗，選擇您的訂用帳戶與資源群組後，再次點選 Set up<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc2.png "arc2")<br>
- 完成後即可在 Azure 上看到主機節點資訊，並且進行更新、配置等管理<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc3.png "arc3")<br>

## 啟用 Azure Monitor 監控叢集

此功能會設定健全狀況服務和 Log Analytics，與自動安裝 MMA<br>

- 在 WAC 管理頁面中，在左欄 Tools 功能列表，選擇 Azure Monitor，可以看到右邊 2 台主機節點狀態顯示 Disconnected。點選上方 Onboard cluster 後，會出現 Set up Azure Monitor 視窗，選擇訂用帳戶、資源群組、並且新增 Log analytics workspace 來儲存記錄檔，完成後點選 Set up 完成設定<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/monitor1.png "monitor1")<br>
- 完成後就可以看到 2 台主機節點狀態顯示為 Connected，並且現在您可以為 Azure Stack HCI 叢集設定規則警示<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/monitor2.png "monitor2")<br>

## 啟用叢集感知更新並且進行更新

叢集感知更新 (CAU) 是 Microsoft 的預設叢集協調器，可讓您透過 Windows Admin Center 中的整合式更新體驗或透過 PowerShell 命令手動執行更新。<br>

- 在 WAC 管理頁面中，在左欄 Tools 功能列表，選擇 Updates，點選 Add Cluster-Aware-Updating role<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update1.png "update1")<br>
- 完成新增後，可以看到頁面所有主機節點的可用更新項目，請點選 Intall 按鈕<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update2.png "update2")<br>
- 忽略 hardware updates 檢查，點選Next: Install<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update3.png "update3")<br>
- 再次點選 Install 正式進行安裝，會需要等待幾分鐘時間<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update4.png "update4")<br>
 > **Tips.更新的項目會依據當時下載的版本有所差異** <br>

## 啟用 Azure 更新管理

此步驟一鍵會協助將 Azure Arc 啟用的伺服器上架至 Azure 自動化中更新管理<br>
 
- 在 Windows Admin Center 的 All connections 頁面，選擇主機節點<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/arc1.png "arc1")<br>
- 在左邊功能列選擇 Azure Hybrid center，在右邊的頁面就可以看到 Azure Update Management，然後點選 Set up 按鈕，右邊會出現 Set up Azure Update Management 視窗，選擇您的訂用帳戶與資源群組後，選擇稍早新增的 Log analytics workspace，並且新增 Azure Automation account，選擇同樣的訂用帳戶，再次點選 Set up<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/updatemgmt.png "updatemgmt")<br>
- 完成後就可以在 Azure Arc 服務上直接管理主機節點的更新狀況，並且可以直接透過 Azure 入口網站排定更新時程<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update16.png "update16")<br>

## 啟用 Azure Site Recovery

此步驟一鍵設定災難復原設定保護，簡化在伺服器或叢集上複寫虛擬機器的佈署<br>

- 在 Windows Admin Center 中，然後從左欄 Compute 功能列中選擇 Virtual machines，選擇您要的虛擬機器後，點選管理，點選使用 Azure Site Recovery 複製<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/asr4.png "asr4")<br>
- 在右邊視窗選擇資源群組、復原保存庫後，點選設定<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/asr3.png "asr3")<br>
- 到 Azure 入口網站點選您所選的復原保存庫，在功能列選取已複寫的項目，點選下拉式選單複寫按鈕，選擇 Hyper-V 機器到 Azure<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/asr8.png "asr8")<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/asr9.png "asr9")<br>

## 加入預覽通道 (option)

加入 Azure Stack HCI 版 preview，可以提前體驗新功能，升級成 21H2 版本獲得最新功能
<br>

- 確定您的主機作業系統版本號碼更新至 17784.1737 以上版本<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update5.png "update5")<br>
- 選擇左邊的功能表下方，點選 Setting。在 Azure Stack HCI 功能欄中，選擇 Join the preview，點選右邊 Get started<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update6.png "update6")<br>
- 後續會跳出僅為評估與測試的警示視窗，勾選 Got it 後，點選 Join the preview channel<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update7.png "update7")<br>
- 完成後可以看到兩個主機節點顯示 Ready<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update8.png "update8")<br>
- 在 WAC 管理頁面中，在左欄 Tools 功能列表，選擇 Updates，等待檢查後，可以看到更新項目中顯示 version 21H2，點選 Install 進行升級<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update9.png "update9")<br>
- 在升級之前，系統會進行檢查，確認主機節點符合升級條件，檢查後發現有些錯誤，可以點選 Detail 下載報告，查看報告發現系統建議我們執行 Update-ClusterFunctionalLevel，系統認為我們安裝版本不一致，不過我們確定安裝的作業系統版本是一致的，所以先忽略此警告，點選 Next:Install<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update10.png "update10")<br>
- 勾選 Update the cluster funtional level to enable new features 後，點選 Install 按鈕，需要等待一些時間<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update12.png "update12")<br>
- 完成更新後就可以在 Servers Inventory 看到 OS 版本號碼已經更新成 21H2 的版本<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update13.png "update13")<br>

## 關閉 CredSSP

- 完成基本設定後，請到主機節點點選 disable CredSSP<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/disablecredssp.png "disablecredssp")<br>


前往[Lab6 - 在 Azure Stack HCI 叢集上建立磁碟區](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/lab6.md)<br>