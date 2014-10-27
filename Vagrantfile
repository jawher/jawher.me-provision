VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.hostname = "blog"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      host: "blog"
    }
    ansible.playbook = "ansible/playbook.yml"
    ansible.extra_vars = {
      frontal_port: "8080",
      blog_url: "jawher.you",
      blogb_loc: "/build-blog",
      blogb_url: "tools.jawher.you",
      blogb_port: "9090",
      blogb_user: "djo",
      blogb_pwd: "djo"
    }
    # ansible.raw_arguments = ["-vvvvv"]

  end
end
