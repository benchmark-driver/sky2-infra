# You need to put deploy key for github.com:benchmark-driver/skybench on ruby-sky2.
# Updating known_hosts is not automated as well.

include_recipe 'rbenv'
include_recipe 'ssh'

%w[
  2.0.0-p648
  2.1.10
  2.2.10
  2.3.8
  2.4.6
  2.5.5
  2.6.3
].each do |version|
  execute "/home/k0kubun/.rbenv/bin/rbenv install #{version}" do
    not_if "test -d /home/k0kubun/.rbenv/versions/#{version}"
  end
end

# remote_file '/home/k0kubun/.bashrc' do
#   mode '644'
#   owner 'k0kubun'
#   group 'k0kubun'
# end

# remote_file '/home/k0kubun/.gitconfig' do
#   mode '644'
#   owner 'k0kubun'
#   group 'k0kubun'
# end

# execute 'git clone --recursive git@github.com:benchmark-driver/skybench /home/k0kubun/skybench' do
#   not_if 'test -d /home/k0kubun/skybench'
# end

# %w[
#   /home/k0kubun/.config
#   /home/k0kubun/.config/systemd
#   /home/k0kubun/.config/systemd/user
#   /home/k0kubun/.config/systemd/user/timers.target.wants
# ].each do |dir|
#   directory dir do
#     mode '755'
#     owner 'k0kubun'
#     group 'k0kubun'
#   end
# end

# remote_file '/home/k0kubun/.config/systemd/user/skybench.service' do
#   mode '600'
#   owner 'k0kubun'
#   group 'k0kubun'
# end

# remote_file '/home/k0kubun/.config/systemd/user/skybench.timer' do
#   mode '600'
#   owner 'k0kubun'
#   group 'k0kubun'
# end

# link '/home/k0kubun/.config/systemd/user/timers.target.wants/skybench.timer' do
#   to '/home/k0kubun/.config/systemd/user/skybench.timer'
# end
