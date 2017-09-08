require 'rake'

task default: :install

desc 'install dotfiles'
task :install do
  backup_files
  link_file('bash_profile')
  link_file('gitignore_global')

  Dir['./bash/*'].each do |file|
    next if %w[Rakefile Readme.md].include?(file)
    source_file(file)
  end
end

def link_file(file)
  puts "linking #{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def backup_files
  puts "backing up bash profile and global gitignore"
  system %Q{mv $HOME/.bash_profile{,.bak}}
  system %Q{mv $HOME/.gitignore_global{,.bak}}
end
  
def source_file(file)
  puts "sourcing #{file}"
  system %Q{[ -r "#{file}" ] && [ -f "#{file}" ] && source "#{file}"}
end
