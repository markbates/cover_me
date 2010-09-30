namespace :cover_me do
  
  task :report do
    require 'cover_me'
    CoverMe.complete!
  end
  
end

task :test do
  Rake::Task['cover_me:report'].invoke
end

task :spec do
  Rake::Task['cover_me:report'].invoke
end