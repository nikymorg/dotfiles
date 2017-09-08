require 'rake'

task default: :install

desc 'install dotfiles'
task :install do
  backup_files
  setup_profile
  setup_gitignore

  Dir['./bash/*'].each do |file|
    next if %w[Rakefile Readme.md].include?(file)
    source_file(file)
  end
end

desc 'uninstall dotfiles'
task :uninstall do
  unlink_file('bash_profile')
  unlink_file('gitignore')
  restore_backups
end

def setup_profile
  unlink_file('bash_profile')
  link_file('bash_profile')
end

def setup_gitignore
  unlink_file('gitignore_global')
  link_file('gitignore_global')
  system %Q{git config --global core.excludesfile ~/.gitignore_global}
end

def backup_files
  puts "backing up bash profile and global gitignore"
  system %Q{mv ~/.bash_profile{,.bak}}
  system %Q{mv ~/.gitignore_global{,.bak}}
end

def unlink_file(file)
  puts "unlinking ~/.#{file}"
  system %Q{unlink "$HOME/.#{file}"}
end
  
def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def source_file(file)
  puts "sourcing ~/.#{file}"
  system %Q{[ -r "#{file}" ] && [ -f "#{file}" ] && source "#{file}"}
end

def remove_dotfiles
  puts "removing dotfiles"
  system %Q{rm -rf ~/dotfiles}
end

def restore_backups
  puts "restoring backup bash profile and gitignore"
  system %Q{mv ~/.bash_profile{.bak,}}
  system %Q{mv ~/.gitignore{.bak,}}
end