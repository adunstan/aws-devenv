
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'aws'

subnetId=""
securityGroupId=""

# settings needs at least subnetId and securityGroupId

# profile needs to be set in myenv, KEY can be overridden there
# myenv also contains AMI names

AWS_PROFILE=""
KEY = 'ad-devenv'

load ('myenv')

# the load/require mechanism seems a bit(!) fragile, this is more reliable
eval (File.read('settings'))

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.vm.synced_folder ".", "/vagrant", disabled: true;
  
  config.vm.provider :aws do |aws, override|

    # private_key_path needed to decrypt the password
    override.ssh.private_key_path = ENV['HOME'] + '/.ssh/' + KEY + '.pem'

    # keypair name corresponding to private_key_path
    aws.keypair_name = KEY

    # 80 gb root device, should be enough to work with
    aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1',
                                  'Ebs.VolumeSize' => 80 }]
    
    aws.instance_type = "t3.large"

    aws.security_groups = [ securityGroupId ]
    aws.subnet_id = subnetId 

    aws.region = 'us-west-2'

    aws.aws_profile = AWS_PROFILE
    
    aws.associate_public_ip = true

  end


  # to avoid running the script provisioners, do
  # vagrant up --provision-with file [windows|ubuntu|centos]

  config.vm.define "windows" do |windows|

    windows.vm.communicator = "winrm"
    windows.winrm.username = "Administrator"

    windows.vm.provision "file", source: "windows-uploads",
                         destination: 'c:\vfiles'
    windows.vm.provision :shell, path: "windows-provision.ps1"
    
    windows.vm.provider "aws" do |aws, override|
      override.winrm.password = :aws # won't matter except for Windows
      aws.region_config "us-west-2", :ami => WIN_AMI
      # Enable WinRM on the instance
      aws.user_data = File.read("windows-userdata")
      aws.tags = { "Name" => "andrew windows dev" ,
                   "Owner" => "Andrew Dunstan" }
    end
  end
  
  config.vm.define "ubuntu" do |ubuntu|

    ubuntu.ssh.username = "ubuntu"
    
    ubuntu.vm.provision "file", source: "ubuntu-uploads",
                         destination: '/home/ubuntu/vfiles'
    ubuntu.vm.provision :shell, path: "ubuntu-provision.sh"

    ubuntu.vm.provider "aws" do |aws, override|
      aws.region_config "us-west-2", :ami => UBUNTU_AMI
      aws.tags = { "Name" => "andrew ubuntu dev" ,
                   "Owner" => "Andrew Dunstan" }
    end
  end

  config.vm.define "centos" do |centos|

    centos.ssh.username = "centos"
    
    centos.vm.provision "file", source: "centos-uploads",
                        destination: '/home/centos/vfiles'
    centos.vm.provision :shell, path: "centos-provision.sh"

    centos.vm.provider "aws" do |aws, override|
      aws.region_config "us-west-2", :ami => CENTOS_AMI
      aws.tags = { "Name" => "andrew centos dev" ,
                   "Owner" => "Andrew Dunstan" }
    end
  end

  
end
