task default: [:tempdirs, :dotvim, :dotfiles, :vundle, :bundles]

task :tempdirs do
  puts 'Creating backup dirs...'

  tmp_dir = File.join(ENV['HOME'], '/.vimbackup')
  Dir.mkdir tmp_dir unless File.directory? tmp_dir
end

task :dotvim do
  vimdir = File.join(ENV['HOME'], '.vim')
  if File.directory? vimdir
    puts "'#{vimdir}' already exists, nothing changed!"
  else
    FileUtils.ln_s File.dirname(__FILE__), vimdir
  end
end

task :dotfiles do
  puts 'Sourcing dot files...'

  %w(vimrc gvimrc).each do |file|
    dotfile = File.join(ENV['HOME'], ".#{file}")
    if File.exist? dotfile
      puts "'#{dotfile}' already exists, nothing changed!"
    else
      File.open(dotfile, 'w') { |df| df.write "source ~/.vim/#{file}" }
    end
  end
end

task :vundle do
  bundledir = File.join(ENV['HOME'], '/.vim/bundle')

  FileUtils.mkdir_p bundledir unless File.directory? bundledir

  unless File.directory? File.join(bundledir, '/vundle')
    Dir.chdir bundledir
    sh 'git clone https://github.com/gmarik/vundle', verbose: false
  end
end

task :bundles do
  puts 'Installing bundles...'

  sh 'vim +BundleInstall +qall', verbose: false
end

task :purge do
  puts 'Purging config files...'

  %w(.vimrc .gvimrc .vim .vimbackup .viminfo).each do |f|
    file = File.join(ENV['HOME'], f)
    FileUtils.rm_r file
    puts "#{file} deleted!"
  end
end

task :commandt do
  puts 'Compiling Command-T C extension... '

  Dir.chdir(File.join(ENV['HOME'], '/.vim/bundle/command-t/ruby/command-t')) do
    sh 'ruby extconf.rb >/dev/null 2>&1', verbose: false
    sh 'make clean && make >/dev/null 2>&1', verbose: false
  end
end
