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
  - 選擇左邊的功能表下方，點選設定。在 Azure Stack HCI 功能欄中，選擇 Azure Stack HCI registration，點選右邊 Register<br>
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
