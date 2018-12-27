Pod::Spec.new do |s|
  s.name             = 'XcodeEditIssue36'
  s.version          = '0.1.0'
  s.summary          = 'XcodeEditIssue36'
  s.homepage         = 'https://github.com/till0xff/XcodeEditIssue36'
  s.license          = { :type => 'MIT' }
  s.author           = { 's.erokhin' => 'till0xff@gmail.com' }
  s.source           = { :git => 'https://github.com/till0xff/XcodeEditIssue36.git', :tag => s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'

  s.source_files = "#{s.name}/Sources/**/*.{swift,h,m}"
  s.resources = "#{s.name}/Resources/*.{xcassets,strings,storyboard,xib}"

  s.dependency 'R.swift', '~> 5.0.0'

  s.prepare_command = "touch #{s.name}/Sources/R.generated.swift"


  r_swift_output = "$PODS_TARGET_SRCROOT/#{s.name}/Sources/R.generated.swift"
  r_swift_script = %{
    expanded_path = File.expand_path(`echo "#{r_swift_output}"`).strip
    exec("\\"$PODS_ROOT/R.swift/rswift\\" generate \\"\#{expanded_path}\\"")
  }

  s.script_phases = [
    {
      :name => 'R.swift',
      :shell_path => '/usr/bin/ruby',
      :script => r_swift_script,
      :execution_position => :before_compile,
      :input_files => ['$TEMP_DIR/rswift-lastrun'],
      :output_files => [r_swift_output]
    }
  ]
end
