# Workflow Example for Simulink Cache and Jenkins

[![View <File Exchange Title> on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/####-file-exchange-title)  
<!-- Replace this with the proper URL to the File Exchange link-->


This repository contains a Simulink® project and a few utility scripts, which highlight an Agile development workflow using Jenkins™, Git™, and Simulink® cache files.


This workflow has three major steps:
1. Team members commit design changes to Git™ .
2. Jenkins pulls design changes from Git™ , runs simulations to test them, and archives the Simulink® cache files in the Jenkins build archive.
3. Team members sync the latest design changes from Git™  and the associated cache files from the build archive, and then run system simulations using the cache files.

![Workflow Diagram](https://www.mathworks.com/company/newsletters/articles/agile-model-based-design-accelerating-simulink-simulations-in-continuous-integration-workflows/_jcr_content/mainParsys/image_0_copy_copy_95.adapt.1200.medium.jpg/1576851787792.jpg)

## Important References

We used the following articles to create this example.

1. [Continuous Integration for Verification of Simulink® Models](https://www.mathworks.com/company/newsletters/articles/continuous-integration-for-verification-of-simulink-models.html#configure_jenkins)
discusses setting up and configuring a MATLAB® project to work with Jenkins™ and GitLab® and also covers using Continuous Integration with Simulink®.
2. [Agile Model-Based Design: Accelerating Simulink® Simulations in Continuous Integration Workflows](https://www.mathworks.com/company/newsletters/articles/agile-model-based-design-accelerating-simulink-simulations-in-continuous-integration-workflows.html)
goes over this workflow and best practices in more detail.

## Requirements

Release R2021a

## MathWorks Products 

(http://www.mathworks.com)

* MATLAB
* Simulink
* Stateflow
* Aerospace Toolbox
* Aerospace Blockset
* Simulink 3D Animation
* Embedded Coder

## Notes

- We installed and configured Jenkins as recommended by the above-mentioned articles. In particular, we changed the Jenkins configuration for workspace and builds directory in the `config.xml` file to 

  ```
  <workspaceDir>L:\JenkinsProj\${ITEM_FULL_NAME}\workspace</workspaceDir>
  <buildsDir>L:\JenkinsProj\${ITEM_FULL_NAME}\builds</buildsDir>
  ```

- In this example, we keep track of the Simulink® cache files corresponding to each Jenkins build using a SQLite database.

- We use the scripts in ```ci_tools``` to access this database and the build archive to retrieve the Simulink® cache files into the project's cache folder.

- The script ```getJenkinsDir.m``` contains a hard-coded path to the Jenkins directory in the shared drive.

- Additionally, we use the script ```syncSLXCForCurrentHash.m``` to sync Simulink® cache files from the build archive.
![Sync Files Image](sync_img.png)

## License

The license for Workflow Example for Simulink Cache and Jenkins is available in the [license.txt](license.txt) file in this repository.

## Community Support
[MATLAB Central](https://www.mathworks.com/matlabcentral)

Copyright 2021 The MathWorks, Inc.