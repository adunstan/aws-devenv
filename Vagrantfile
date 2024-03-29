


# Workaround https://github.com/mitchellh/vagrant-aws/issues/566
class Hash
  def slice(*keep_keys)
    h = {}
    keep_keys.each { |key| h[key] = fetch(key) if has_key?(key) }
    h
  end unless Hash.method_defined?(:slice)
  def except(*less_keys)
    slice(*keys - less_keys)
  end unless Hash.method_defined?(:except)
end

# get the user's real name, strip off extension fields
require 'etc'
myname=Etc.getpwuid().gecos.sub(/,.*/,"")

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'aws'
ENV['ARGS'] ||= ''

subnetId=""
securityGroupId=""

# settings needs at least subnetId and securityGroupId

# AWS_PROFILE, KEY and REGION need to be set in myenv
# myenv also contains AMI names

AWS_PROFILE=""
KEY=""
REGION=""

load ('myenv')

# the load/require mechanism seems a bit(!) fragile, this is more reliable
eval (File.read('settings'))

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true;
  config.vm.network "public_network", auto_config: false


  # for default user names see
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html
  
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

    aws.region = REGION

    aws.aws_profile = AWS_PROFILE
    
    aws.associate_public_ip = true

  end


  ["windows","windows-1","windows-2","windows-3"].each do |machine|


    # to avoid running the script provisioners, do
    # vagrant up --provision-with file [windows|ubuntu|centos]

    config.vm.define machine do |windows|

      windows.vm.communicator = "winrm"
      windows.winrm.username = "Administrator"

      # windows.vm.provision :shell, path: "security-setup.ps1"

      windows.vm.provision "file", source: "windows-uploads",
                           destination: 'c:\vfiles'
      # e.g. ARGS=NOMSVC vagrant up ... or ARGS=NOMSYS2 vagrant up ...
      windows.vm.provision :shell, path: "windows-provision.ps1",
                           args: ENV['ARGS'].split

      windows.vm.provider "aws" do |aws, override|
        override.winrm.password = :aws # won't matter except for Windows
        aws.ami = WIN_AMI
        aws.region_config REGION, :ami => WIN_AMI
        # Enable WinRM on the instance
        aws.user_data = File.read("windows-userdata")
        aws.tags = { "Name" => myname + " windows dev" ,
                     "Owner" => myname }
      end
    end
  end
  
  config.vm.define "windows-bare" do |windows|

    windows.vm.communicator = "winrm"
    windows.winrm.username = "Administrator"

    # windows.vm.provision :shell, path: "security-setup.ps1"

    windows.vm.provision "file", source: "windows-uploads",
                         destination: 'c:\vfiles'
#    windows.vm.provision "shell", inline: <<-SHELL
#
#       Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#
#       SHELL
#    windows.vm.provision :shell, path: "windows-provision-bare.ps1"
    windows.vm.provision :shell, path: "newprov.ps1"
    
    windows.vm.provider "aws" do |aws, override|
      override.winrm.password = :aws # won't matter except for Windows
      aws.ami = WIN_AMI
      aws.region_config REGION, :ami => WIN_AMI
      # Enable WinRM on the instance
      aws.user_data = File.read("windows-userdata")
      aws.tags = { "Name" => myname + " windows dev" ,
                   "Owner" => myname }
    end
  end
  
  config.vm.define "ubuntu" do |ubuntu|

    ubuntu.ssh.username = "ubuntu"
    
    ubuntu.vm.provision :shell, path: "security-setup.sh"

    ubuntu.vm.provision "file", source: "ubuntu-uploads",
                         destination: '/home/ubuntu/vfiles'
    ubuntu.vm.provision :shell, path: "ubuntu-provision.sh"

    ubuntu.vm.provider "aws" do |aws, override|
      aws.ami = UBUNTU_AMI
      aws.region_config REGION, :ami => UBUNTU_AMI
      aws.tags = { "Name" => myname + " ubuntu dev" ,
                   "Owner" => myname }
    end
  end

  config.vm.define "fbsd12" do |fbsd12|

    fbsd12.ssh.username = "ec2-user"
    fbsd12.ssh.shell = "sh"

    # no curl/sudo on FBSD -- XXX fixme
    # fbsd12.vm.provision :shell, path: "security-setup.sh"

#    fbsd12.vm.provision "file", source: "fbsd-uploads",
#                         destination: '/home/fbsd12/vfiles'
    fbsd12.vm.provision :shell, :path => "fbsd12-provision.sh",
                        privileged: false

    fbsd12.vm.provider "aws" do |aws, override|
      override.ssh.username = "ec2-user"
      override.ssh.shell = "sh"
      aws.ami = FBSD_AMI
      aws.region_config REGION, :ami => FBSD_AMI
      aws.tags = { "Name" => myname + " fbsd12 dev" ,
                   "Owner" => myname }
    end
  end

  config.vm.define "centos" do |centos|

    centos.ssh.username = "centos"
    
    centos.vm.provision :shell, path: "security-setup.sh"

    centos.vm.provision "file", source: "centos-uploads",
                        destination: '/home/centos/vfiles'
    centos.vm.provision :shell, path: "centos-provision.sh"

    centos.vm.provider "aws" do |aws, override|
      aws.ami = CENTOS_AMI
      aws.region_config REGION, :ami => CENTOS_AMI
      aws.tags = { "Name" => myname + " centos dev" ,
                   "Owner" => myname }
    end
  end

  
end
