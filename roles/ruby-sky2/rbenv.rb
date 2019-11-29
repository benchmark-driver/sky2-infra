execute 'git clone https://github.com/rbenv/rbenv /mnt/rbenv' do
  not_if 'test -d /mnt/rbenv'
end

link '/home/k0kubun/.rbenv' do
  to '/mnt/rbenv'
end

execute 'git clone https://github.com/rbenv/ruby-build /home/k0kubun/.rbenv/plugins/ruby-build' do
  not_if 'test -d /home/k0kubun/.rbenv/plugins/ruby-build'
end

execute 'git clone https://github.com/rbenv/rbenv-each /home/k0kubun/.rbenv/plugins/rbenv-each' do
  not_if 'test -d /home/k0kubun/.rbenv/plugins/rbenv-each'
end
