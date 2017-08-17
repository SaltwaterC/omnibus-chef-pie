desc 'Install vagrant-scp'
task :setup do
  sh 'vagrant plugin install vagrant-scp'
end

desc 'vagrant up'
task :up do
  sh 'vagrant up'
end

desc 'vagrant provision'
task :provision do
  sh 'vagrant provision'
end

desc 'Clean the build environment - does not remove artefacts'
task :clean do
  sh 'vagrant destroy -f'
  rm_rf '.vagrant'
  rm_f Dir['*.log']
end

desc 'scp build artefact from Vagrant box to host machine'
task :fetch do
  sh 'vagrant scp ":*.deb" .'
end
