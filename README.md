# AzureAutomation

### What is Azure Automation?

Azure Automation is a way to automate cloud management tasks within Windows Azure.  You can leverage an extensive gallery of Azure Runbooks - or write your own.  Azure Powershell commands can be accessed in order to integrate with many of the services you already use inside of Azure.  


### What's it cost?

There are two pricing tiers for Azure Automation

* Free
  * 500 minutes of job runtime
* Basic
  * $0.002 / minute

### Types of Runbooks

#### PowerShell Workflow

These are the original runbooks available in Azure Automation.  These runbooks take full advantage of Windows Workflow Foundation and offer parallel execution, checkpoints, and suspend and resume capabilities.  This makes PowerShell Workflow ideal for tasks that aren't dependent upon one another (for example, starting up a number of Virtual Machines), as the tasks can run in parallel and take up less processing time.  The  downfall to PowerShell Workflow is that it is syntactically different than the PowerShell many of us (myself included) - meaning we have to learn something new - and possibly rewrite PowerShell scripts we are already using in order to leverage it.  

#### PowerShell

This is a relatively recent add to Azure Automation (announced September 15th, 2015) that allows for native PowerShell to be run in Azure Automation.

#### Hybrid Worker

Full details of Hybrid Workers are probably outside of the scope of this conversation, but what you should know about them is that the runbooks are stored in Azure Automation, then delivered to one or more on-premises machines where they run.  This allows you to take advantage of Azure Automation to access resources inside of your datacenter that they probably otherwise didn't have access to.  

### Assets

Assets consists are items within your Automation account that can be shared across runbooks - including variables, modules, and credentials just to name a few.  

### Authentication

In order to access your resources within Azure, your runbook will need to authenticate with your Azure Account.  There are two ways this can be done:

1. Certificate
2. Azure Active Directory

As a whole, Microsoft is pushing users away from using certificates and towards Azure Active Directory and Service Principals, so that is the approach we are going to take in this presentation.  

### Accessing Runbooks Programmatically

There are two ways runbooks can be run programmatically.

1. Webhooks
2. Azure SDK (Microsoft.WindowsAzure.Management.Automation nuget package)
