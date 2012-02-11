task :install => [:tempdirs, :dotfiles, :vundle, :bundles, :commandt]

task :tempdirs do
  puts "Creating backup dirs..."
  tmp_dir = ENV['HOME'] + "/.vimbackup"
  if not File::directory? tmp_dir
    Dir::mkdir tmp_dir
  end
end

task :dotfiles do
  puts "Linking dot files..."
  %w[vimrc gvimrc vimbundles.vim].each do |file|
    linked_file = File::join(ENV['HOME'], ".#{file.chomp(File::extname(file))}")
    if File::exist? linked_file
      puts "'#{linked_file}' already exists, nothing changed!"
    else
      begin
        FileUtils::ln_s File::join(File::dirname(__FILE__), file), linked_file
      rescue
        puts "Oops, something's gone wrong... please check '#{linked_file}' file"
      end
    end
  end
end

task :vundle do
  bundle_dir = ENV['HOME'] + "/.vim/bundle"
  if not File::directory? bundle_dir
    FileUtils::mkdir_p bundle_dir
  end

  if not File::directory? bundle_dir + "/vundle"
    Dir::chdir bundle_dir
    verbose false
    sh "git clone https://github.com/gmarik/vundle"
  end
end

task :bundles do
  puts "Installing bundles..."
  verbose false
  sh "vim -u ~/.vimbundles +BundleInstall +qall"
end

task :update do
  puts "Updating bundles..."
  verbose false
  sh "vim -u ~/.vimbundles +BundleInstall! +qall"
end

task :clean do
  puts "Cleaning up bundles..."
  verbose false
  sh "vim -u ~/.vimbundles +BundleClean! +qall"
end

task :commandt do
  puts "Compiling Command-T C extension... "
  Dir::chdir(ENV['HOME'] + "/.vim/bundle/command-t/ruby/command-t") do
    verbose false
    sh "ruby extconf.rb >/dev/null 2>&1"
    sh "make clean && make >/dev/null 2>&1"
  end
end
