desc 'Run stylelint'
task :stylelint do
  sh 'stylelint app/assets/**/*.scss --scss syntax'
end
