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
  change_dir
  remove_file('bash_profile')
  remove_file('gitignore_global')
end

def setup_profile
  unlink_file('bash_profile')
  link_file('bash_profile')
end

def setup_gitignore
  unlink_file('gitignore_global')
  link_file('gitignore_global')
  system %Q{git config --global core.excludesfile $HOME/.gitignore_global}
end

def backup_files
  puts "backing up bash profile and global gitignore"
  system %Q{mv $HOME/.bash_profile{,.bak}}
  system %Q{mv $HOME/.gitignore_global{,.bak}}
end

def unlink_file(file)
  if File.exist?("$HOME/.#{file}")
    puts "unlinking $HOME/.#{file}"
    system %Q{unlink "$HOME/.#{file}"}
  end
end
  
def link_file(file)
  puts "linking $HOME/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def source_file(file)
  puts "sourcing$HOME~/.#{file}"
  system %Q{[ -r "#{file}" ] && [ -f "#{file}" ] && source "#{file}"}
end

def remove_dotfiles
  puts "removing dotfiles"
  system %Q{rm -rf $HOME/.dotfiles}
end

def restore_backup(file)
  if File.exist?("$HOME/.#{file}.bak")
    puts "restoring backup #{file}"
    system %Q{mv "$HOME/.#{file}{.bak,}"}
  end
end

def remove_file(file)
  unlink_file(file)
  restore_backup(file)
end

def change_dir
  system %Q{cd $HOME/.dotfiles}
end