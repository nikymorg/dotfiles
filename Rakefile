require 'rake'

task default: :install

desc 'install dotfiles'
task :install do
  link_file('bash_profile')
  link_file('gitignore_global')
  link_file('vimrc')
  source_directory('./bash')
end

def link_file(file)
  backup_file(file)
  puts "linking #{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def backup_file(file)
  puts "backing up #{file}"
  system %Q{mv $HOME/."#{file}"{,.bak}}
end

def source_file(file)
  puts "sourcing #{file}"
  system %Q{[ -r "#{file}" ] && [ -f "#{file}" ] && source "#{file}"}
end

def source_directory(dir)
  Dir["#{dir}/*"].each { |file| source_file(file) }
end
