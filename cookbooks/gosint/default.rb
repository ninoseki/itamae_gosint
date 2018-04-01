execute "sudo apt-get update"
"mongodb php7.0-fpm nginx git".split.each do |name|
  package name
end

remote_file "/etc/nginx/sites-available/default"

execute "create a user" do
  command "sudo useradd -m gosint"
  not_if "test -e /home/gosint"
end

execute "wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz" do
  user "gosint"
  cwd "/home/gosint"
  not_if "test -e /home/gosint/go"
end

execute "tar zxvf go1.8.linux-amd64.tar.gz" do
  user "gosint"
  cwd "/home/gosint"
  not_if "test -e /home/gosint/go1.8.linux-amd64.tar.gz"
end

remote_file "/home/gosint/.bash_profile" do
  owner "gosint"
end

execute "mkdir /home/gosint/projects" do
  user "gosint"
  not_if "test -e /home/gosint/projects"
end

execute "/bin/bash -lc 'go get github.com/tools/godep; go install github.com/tools/godep'" do
  user "gosint"
  cwd "/home/gosint/projects"
  not_if "test -e /home/gosint/projects/pkg/linux_amd64/github.com/tools/godep"
end

git "/home/gosint/projects/src/GOSINT" do
  user "gosint"
  repository "https://github.com/ciscocsirt/GOSINT"
end

execute "/bin/bash -lc 'godep get; godep go build -o gosint; chmod +x gosint'" do
  user "gosint"
  cwd "/home/gosint/projects/src/GOSINT"
  not_if "test -e /home/gosint/projects/src/GOSINT/gosint"
end
