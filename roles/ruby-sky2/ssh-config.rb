directory '/home/k0kubun/.ssh' do
  mode '700'
  owner 'k0kubun'
  group 'k0kubun'
end

remote_file '/home/k0kubun/.ssh/config' do
  mode '600'
  owner 'k0kubun'
  group 'k0kubun'
end
