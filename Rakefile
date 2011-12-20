task :default => [:tmp_dirs, :dot_files, :vundle, :bundles, :command_t]

task :tmp_dirs do
  puts "Creating backup dirs... "
  tmp_dir = ENV['HOME'] + "/.vimbackup"
  if not FileTest::directory? tmp_dir
    Dir::mkdir tmp_dir
  end
end

task :dot_files do
  puts "Linking dot files... "
  %w[vimrc vimbundles].each do |script|
    dot_file = File.join(ENV['HOME'], ".#{script}")
    if not File.exist? dot_file
      ln_s File.join(File.dirname(__FILE__), script), dot_file
    else
      puts "\"#{dot_file}\" already exists! Nothing changed."
    end
  end
end

task :vundle do
  tmp_dir = ENV['HOME'] + "/.vim/bundle"
  if not FileTest::directory? tmp_dir
    Dir::mkdir tmp_dir
    Dir.chdir tmp_dir
    verbose(false)
    sh "git clone https://github.com/gmarik/vundle"
  end
end

task :bundles do
  puts "Installing bundles... "
  verbose(false)
  sh "vim -u ~/.vimbundles +BundleInstall +qall"
end

task :update do
  puts "Updating bundles... "
  verbose(false)
  sh "vim -u ~/.vimbundles +BundleInstall! +qall"
end

task :command_t do
  puts "Compiling Command-T C extension... "
  Dir.chdir ENV['HOME'] + "/.vim/bundle/command-t/ruby/command-t" do
    verbose(false)
    mute_sh_output = ">/dev/null 2>&1"
    sh "ruby extconf.rb #{mute_sh_output}"
    sh "make clean && make #{mute_sh_output}"
  end
end
