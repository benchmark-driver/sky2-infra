include_recipe 'rbenv'

%w[
  2.0.0-p648
  2.1.10
  2.2.9
  2.3.6
  2.4.3
  2.5.0
].each do |version|
  execute "/home/k0kubun/.rbenv/bin/rbenv install #{version}" do
    not_if "test -d /home/k0kubun/.rbenv/versions/#{version}"
  end
end

remote_file '/home/k0kubun/.bashrc' do
  mode '644'
  owner 'k0kubun'
  group 'k0kubun'
end
