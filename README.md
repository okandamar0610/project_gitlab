![Installation](https://blog.terraforge.io/02/terraform_gitlab.png)

This project we installed GitLab server using Terraform , on a CentOS 7 only for testing purpose.

In order to Terraform deploy resources , you need to deside :
- what cloud provider are you going to use. 
- Set credentials with proper permissions.

When you start builing infrastracture using Terraform, you begin writing configuration files create all your resources. 
We create a VPC and all other components that you can use is following:

- 3 private, 3 public  subnets
- Public subnets attached to IGW. 

- Private subnets attached to NG. 

- Configure Route tables

- Create Public and private keys

- Add Security groups and open nessasarly ports

- Create Variables and tags

- Create instance

- Creating S3 bucket

- SSH to instance Install GitLab server using "remote-exec" defined in null.resource file. 

We choose AWS for provider and it's in the provider.tf file.
Terraform needs to initialize with provider AWS.

`provider.tf`

![](https://user-images.githubusercontent.com/63433671/85265268-a6088a80-b437-11ea-83eb-2fd1b413ce00.png)

 Run:    

`terraform init`
 
 
 



![init](https://user-images.githubusercontent.com/63433671/85368690-58e8ef00-b4f1-11ea-96a6-adb26848e723.png)



 
 Once Terraform initialized with cloud provider, same time it will download plugin for you.  it's time to run terraform plan command and see what resources will be created. 

 Run: 
 
 ` terraform plan -var-file devtf.vars`
 
 <img width="834" alt="Screen Shot 2020-06-25 at 5 21 31 PM" src="https://user-images.githubusercontent.com/63433671/85801467-8956a600-b708-11ea-84fa-1ac36e9ce66a.png">
<img width="925" alt="Screen Shot 2020-06-25 at 5 21 49 PM" src="https://user-images.githubusercontent.com/63433671/85801479-8f4c8700-b708-11ea-96ea-79071aca0b67.png">

 


This is expected Infrastructure Architecture .





![Hybrid Cloud Architecture (3)](https://user-images.githubusercontent.com/63433671/85800404-85c21f80-b706-11ea-9879-d03b70c200b1.png)


If you are happy with plan, It's time to deploy your resources with terraform apply command.

Run: 

`terraform apply  -var-file dev.tfvars` 



<img width="778" alt="Screen Shot 2020-06-23 at 1 51 53 AM" src="https://user-images.githubusercontent.com/63433671/85370333-22f93a00-b4f4-11ea-9eeb-7e287c40ce08.png">









![](https://user-images.githubusercontent.com/63433671/85369068-04923f00-b4f2-11ea-9799-42e8287d9401.png)

![](https://user-images.githubusercontent.com/63433671/85369086-0a882000-b4f2-11ea-952c-60701aad341f.png)



Once installation is succesfully completed you will see the GitLab Logo on your terminal. 


<img width="944" alt="Screen Shot 2020-06-24 at 10 44 24 PM" src="https://user-images.githubusercontent.com/63433671/85800545-c9b52480-b706-11ea-98af-01042926ee94.png">



The last step is Configure GitLab through the Web Interface.
Now that you have configured the GitLab URL you can start with the initial configuration through the GitLab web interface.

The first time you access the web interface you’ll be prompted to set the password for the administrative account.

![](https://lh4.googleusercontent.com/T_ghSl23B95b7RhzjjbEP-UJNOTk4ktopW8UpeqpMsZZ9kqS-A8RsaK7CmSZF5ZNLVqx_E96w8wLC2HOMEldy9GEpI7kgpWePAzcfqeu)

Enter a secure password and click on the Change your password button when you are finished.

You will be redirected to the login page:

![](https://linuxize.com/post/how-to-install-and-configure-gitlab-on-centos-7/gitlab-login-page.jpg?ezimgfmt=ng:webp/ngcb26)

The default administrative account username is root. Later in this tutorial, we will show you how to change the username.

Username: root
Password: [the password you have set]
Enter the login credentials, click the Sign in button and you will be redirected to the GitLab Welcome page.

Welcome to GitLab!

å![](https://linuxize.com/post/how-to-install-and-configure-gitlab-on-centos-7/gitlab-welcome-page.jpg?ezimgfmt=ng:webp/ngcb26)

