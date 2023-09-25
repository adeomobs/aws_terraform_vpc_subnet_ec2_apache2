# aws_terraform_vpc_subnet_ec2_apache2
Terraform scripts to provision Ec2 instance to run Apache2 in created vpc and required resources


This Terraform script provisions the following resources with these parameters set. It can also be used as a Module. Values can be changed in variables.tf file to configure as required for your application.

VPC: VPC created with set cidr block. Required Attribute is cidr block

PUBLIC SUBNET: A public subnet in the created vpc  referenced using the vpc ID, automatic public ip on launch has been been given a value of true, you can also set the value of availability zone in the variables.tf file and cidr block. Required attributes include: VPC ID, Map Public IP on Launch, Availability Zone, cidr block

PRIVATE SUBNET Also configured to the created vpc, cidr block and availability zone values to be changed as required in variabels.tf file. Required Attributes Include: cidr block and Availabiity Zone

INTERNET GATEWAY- Required resource to allow traffic into the VPC created. VPC referenced using the VPC ID. Required Attributes include: VPC ID

ROUTE TABLE: Helps send packets around the VPC, Subntes and Internet. it references the VPC using the VPC ID and sets the route using the cidr block and Internet Gateway ID Created. Required Attributes include: VPC ID, cidr block and Internet Gateway ID

ROUTE TABLE ASSOCIATION: Required to attach the Route Table to the Subnet that allows data packets sent in and out of the Subnet. Required attributes include Route Table ID and the Subnet ID

SECURITY GROUP - Security group for your ec2 instance to allow http traffic from any ip and ssh connection from any ip. Required attributes include: VPC ID, ingress key pair values for http traffic (80) and ssh connection(22), egress to allow communciation out of the vpc

EC2 INSTANCE - Creates the Ec2 instance with the resources already created. Required Atributes include: ami, instance type, key_name, tenancy, subnet-id, vpc_security_group_ids.

OUTPUT - Output is set in our outut.tf file to output the public ip address of the instance we can run on our browser and view.

USERDATA - This allows to run commands in the instance after the instance has been provisioned. In this case we are installing and starting Apache2 to run on our instance.


NOTE: The Route Table is used for both Public and Private Subnet. Also please create a keypair to connect to your ec2 instance so you can ssh into your instance. Keypair name would be required in your ec2 instance configuration
