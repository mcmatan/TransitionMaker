Pod::Spec.new do |s|

s.name              = 'TransitionMaker'
s.version           = '0.1.0'
s.summary           = 'TransitionMaker'
s.homepage          = 'https://github.com/mcmatan/TransitionMaker'
s.ios.deployment_target = '8.0'
s.platform = :ios, '8.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Matan'
}
s.source            = {
:git => 'https://github.com/MichaelTzach/TransitionMaker.git', :tag => s.version.to_s }
s.framework = "UIKit"
s.source_files      = 'TransitionMaker/**/*.swift' , 'Vendor/**/*.swift', 'Resource/**/*.swift', 'TransitionMaker/**/*.swift'
s.requires_arc      = true

end

