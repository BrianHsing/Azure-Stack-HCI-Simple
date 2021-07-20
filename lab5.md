# Lab5 - Azure Stack HCI 叢集基本設置

Azure Stack HCI 必須在安裝後的30天內依據 Azure Online Services 條款進行註冊，這個 Lab 主要是說明如何向 Azure 註冊 Azure Stack HCI 叢集，並啟用進行監視、支援、計費和混合式服務<br>
- 先決條件<br>
  - 擁有任何類型的現有訂用帳戶<br>
  - 註冊叢集的帳號必須具有下列 Azure 許可權<br>
    - Register a resource provider<br>
    - Create/Get/Delete Azure resources and resource groups<br>
  - 建議您直接使用擁有 Azure AD Global admin 與 Azure Subscription Owner 帳號來進行登入，可以節省一些時間<br>

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

## 加入預覽通道

加入 Azure Stack HCI 版 preview，可以提前體驗新功能，升級成 21H2 版本有以下好處：<br>
- 從 Azure 入口網站監視叢集<br>
- 使用 Gpu 搭配叢集 Vm<br>
- 動態 CPU 相容性模式<br>
- 儲存體精簡布建<br>
- 網路 ATC<br>
- 可調整的儲存體修復速度<br>
- 支援 AMD 處理器上的嵌套虛擬化<br>
- 核心軟重新開機<br>

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
- 在升級之前，系統會進行檢查，確認主機節點符合升級條件，檢查後發現有些錯誤，可以點選 Detail 下載報告<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update10.png "update10")<br>
- 查看報告發現系統建議我們執行 Update-ClusterFunctionalLevel，將所有主機節點統一作業系統版本<br>
![GITHUB](https://github.com/BrianHsing/Azure-Stack-HCI/blob/main/image/update10.png "update11")<br>
