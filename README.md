# AzureAutomation

### What is Azure Automation?

Azure Automation is a way to automate cloud management tasks within Windows Azure.  You can leverage an extensive gallery of Azure Runbooks - or write your own.  Azure Powershell commands can be accessed in order to integrate with many of the services you already use inside of Azure.  


### What's it cost?

There are two pricing tiers for Azure Automation

* Free
  * 500 minutes of job runtime (monthly)
* Basic
  * $0.002 / minute

### Types of Runbooks

#### PowerShell Workflow

These are the original runbooks available in Azure Automation.  These runbooks take full advantage of Windows Workflow Foundation and offer parallel execution, checkpoints, and suspend and resume capabilities.  This makes PowerShell Workflow ideal for tasks that aren't dependent upon one another (for example, starting up a number of Virtual Machines), as the tasks can run in parallel and take up less processing time.  The  downfall to PowerShell Workflow is that there are differences from the PowerShell Scripting that many of us (myself included) are used to writing.  Another minor disadvantage to Workflow is that the runbook must be compiled before starting, which can take a bit longer.  

Examples of differences include the inability to use positional parameters, as well as deserialized objects.  Because objects are deserialized in PowerShell workflow, you can view the properties of them, however you cannot execute methods on the objects.  In order to execute methods on objects, they must be run using an InlineScript command.  This command is available in order to run commands as traditional PowerShell instead of Workflow.

#### PowerShell

This is a relatively recent add to Azure Automation (announced September 15th, 2015) that allows for native PowerShell to be run in Azure Automation.  One of the major disadvantages to using PowerShell however is that they cannot be used on a Hybrid Worker.  

#### Hybrid Worker

Full details of Hybrid Workers are probably outside of the scope of this conversation, but what you should know about them is that the runbooks are stored in Azure Automation, then delivered to one or more on-premises machines where they run.  This allows you to take advantage of Azure Automation to access resources inside of your datacenter to which it probably otherwise wouldn't have access.  

#### Child Runbooks

Runbooks also have the ability to invoke child runbooks.  Child runbooks can be invoked with inline execution, causing the child to be run within the same job as the parent, or using a cmdlet - which causes a new Azure Automation Job to be started.  When using inline execution, runbooks can only invoke child runbooks of the same time (Workflow -> workflow, PowerShell -> PowerShell).

#### Choosing an option

Personally, the choice comes down to what our starting point is.  If you have a library of existing existing PowerShell that you are migrating, PowerShell runbooks are probably your best choice.  If you are starting from scratch, Workflow runbooks offer a number of powerful features that may make them a better choice.  If you have the need to access on-premises resources, Workflow runbooks are your only choice.

*Example - Build a Basic Workflow Runbook that writes out some text but doesn't yet access any Azure Resources*

### Authentication

In order to access your resources within Azure, your runbook will need to authenticate with your Azure Account.  There are two ways this can be done:

1. Certificate
2. Azure Active Directory

As a whole, Microsoft is pushing users away from using certificates and towards Azure Active Directory and Service Principals, so that is the approach we are going to take in this presentation.

*Example - Add Authentication into this runbook and access an Azure Resource*

### Assets

Assets consists are items within your Automation account that can be shared across runbooks - including variables, modules, and credentials just to name a few.  

*Example Move Credentials to Credential Asset, Add a variable to do something, create module to do something*

### Accessing Runbooks Programmatically

There are two ways runbooks can be run programmatically.

1. Webhooks
2. Azure SDK (Microsoft.WindowsAzure.Management.Automation nuget package)

Webhooks are my prefered way of programmatically starting runbooks.  Using a simple POST request with JSON data, we can execute from virtually any other system.  The biggest downfall to this method is the manner in which the JSON values have to be read within the runbook - which is different from the parameters that it will already be taking. 

*Demo starting a runbook using Postman - show job running and out output*

*Demo scheduling a runbook - Azure Scheduler*

*Walkthrough Rackspace use case*
