# Azure Resource Manager Template

This repo contains an Azure Resource Manager template to deploy YugaByte DB cluster on Azure cloud. This is an automated deployment that can deploy a multi-region YugabyteDB cluster to azure. The deployed YugabyteDB cluster gets hosted on 3 nodes residing in 3 separate public subnets and create a universe among them. This repo is ideal to get you running a YugaByte cluster in a few steps.

# Usage

## Deploying From Azure Cloud Shell 
[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/)
  - First clone this repo.
    ```
    $ git clone https://github.com/YugaByte/azure-resource-manager.git
    ```
  - Change current directory to cloned git repo directory
  - Use Azure CLI command to create deployments <br/> 
    ```
    $ az group deployment create --resource-group <Your-Azure-Resource-Group> --template-file ResourceGroup.json --parameters ClusterName='<Your-Cluster-Name>' SSH_USER='<Your-SSH-USER>' YB-Version='1.3.0.0' SSH_keypair='<Your-SSH-USER-PublicKey>'
    ```
  - Once the deployment creation is complete, you can describe it as shown below.
    ```
    $ az group deployment show -g <Your-Azure-Resource-Group> -n <YOur-Deployment-Name> --query properties.outputs
    ```
    In the output, you will get the YugaByte DB admin URL, JDBC URL, YSQL, YCQL and YEDIS connection string. You can use YugaByte admin URL to access admin portal.

## Deploying From Azure Portal
 - Clone this repo locally.
     ```
     $ git clone https://github.com/YugaByte/azure-resource-manager.git
     ```
  - First create a resource group, to create a new resource group, select Resource groups from the [Azure portal](https://portal.azure.com/).
  - Under newly created Resource groups, select Add.
  - In opened marketplace search for Template deployment (deploy using custom templates) and click on create.
  - Now click on `Build your own template in the editor`.
  - Click `Load file` button in specify template section and upload the `yugabyte_deployment.json` file from cloned repo. 
  -  Click on the `Save` button at the bottom of the window.
  -  Now provide the required details.
  -  Once details are provided, then check the Terms and Condition checkbox and click on the `Purchase` button. 
  -  Once deployments get compleated, you can access the YugaByte DB admin from URL you get in the deployment output section.