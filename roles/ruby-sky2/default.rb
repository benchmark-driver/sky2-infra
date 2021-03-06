# You need to put deploy key for github.com:benchmark-driver/sky2-result on ruby-sky2.
# Updating known_hosts is not automated as well.
#
# Run `sudo loginctl enable-linger k0kubun` too.
# Also you should reboot to make sure `cpufreq-info -p` becomes performance.

execute 'mount -a' do
  action :nothing
end

remote_file '/etc/fstab' do
  mode '644'
  owner 'root'
  group 'root'
  notifies :run, 'execute[mount -a]', :immediately
end

directory '/mnt' do
  mode '777'
  owner 'root'
  group 'root'
end

include_recipe 'rbenv'
include_recipe 'ssh-config'

openssl_version = '1.0.2r'
execute "install openssl-#{openssl_version}" do
  command <<-EOS
    cd /tmp
    wget https://www.openssl.org/source/openssl-#{openssl_version}.tar.gz
    tar xvzf openssl-#{openssl_version}.tar.gz
    cd openssl-#{openssl_version}
    CFLAGS=-fPIC ./config shared --prefix=/home/k0kubun/openssl-#{openssl_version}
    make -j4
    make install
  EOS
  user 'k0kubun'
  not_if "test -d /home/k0kubun/openssl-#{openssl_version}"
end

[
  '2.0.0-p648',
  '2.1.10',
  '2.2.10',
  '2.3.8',
].each do |version|
  configure_opts = "--with-openssl-dir=/home/k0kubun/openssl-#{openssl_version}"
  execute "env RUBY_CONFIGURE_OPTS='#{configure_opts}' /home/k0kubun/.rbenv/bin/rbenv install #{version}" do
    user 'k0kubun'
    not_if "test -d /home/k0kubun/.rbenv/versions/#{version}"
  end
end

[
  '2.4.6',
  '2.5.5',
  '2.6.3',
].each do |version|
  execute "/home/k0kubun/.rbenv/bin/rbenv install #{version}" do
    user 'k0kubun'
    not_if "test -d /home/k0kubun/.rbenv/versions/#{version}"
  end
end

remote_file '/home/k0kubun/.bashrc' do
  mode '644'
  owner 'k0kubun'
  group 'k0kubun'
end

remote_file '/home/k0kubun/.gitconfig' do
  mode '644'
  owner 'k0kubun'
  group 'k0kubun'
end

remote_file '/etc/crontab' do
  mode '644'
  owner 'root'
  group 'root'
end

package 'cpufrequtils'

service 'cpufrequtils' do
  action [:start, :enable]
end

service 'ondemand' do
  action [:stop, :disable]
end

remote_file '/etc/default/cpufrequtils' do
  mode '644'
  owner 'root'
  group 'root'
  notifies :restart, 'service[cpufrequtils]'
end

execute 'git clone https://github.com/benchmark-driver/sky2-bench /home/k0kubun/sky2-bench' do
  user 'k0kubun'
  not_if 'test -d /home/k0kubun/sky2-bench'
end

execute 'git clone https://github.com/benchmark-driver/sky2-result /home/k0kubun/sky2-bench/sky2-result' do
  user 'k0kubun'
  not_if 'test -d /home/k0kubun/sky2-bench/sky2-result'
end

execute 'git clone https://github.com/ruby/ruby /home/k0kubun/ruby' do
  user 'k0kubun'
  not_if 'test -d /home/k0kubun/ruby'
end

%w[
  /home/k0kubun/.config
  /home/k0kubun/.config/systemd
  /home/k0kubun/.config/systemd/user
  /home/k0kubun/.config/systemd/user/timers.target.wants
].each do |dir|
  directory dir do
    mode '755'
    owner 'k0kubun'
    group 'k0kubun'
  end
end

remote_file '/lib/systemd/system/sky2-bench.service' do
  mode '600'
  owner 'root'
  group 'root'
end

remote_file '/lib/systemd/system/sky2-bench.timer' do
  mode '600'
  owner 'root'
  group 'root'
end

link '/etc/systemd/system/timers.target.wants/sky2-bench.timer' do
  to '/lib/systemd/system/sky2-bench.timer'
end
