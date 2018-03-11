Pod::Spec.new do |s|
  s.name = 'PeerKit'
  s.version = '5.0.0'
  s.summary = 'Swift framework for building Multipeer Connectivity apps'
  s.authors = { 'Jeff Kereakoglow' => 'jkereako@users.noreply.github.com' }
  s.license = 'MIT'
  s.homepage = 'https://github.com/jkereako/PeerKit'
  s.social_media_url = 'https://twitter.com/jkereako'
  s.source = {
    git: 'https://github.com/jkereako/PeerKit.git',
    tag: s.version
  }
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.11'
  s.source_files = 'PeerKit/*.swift'
  s.requires_arc = true
end
