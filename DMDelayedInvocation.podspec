Pod::Spec.new do |s|
  s.name = "DMDelayedInvocation"
  s.version = "0.1"
  s.summary = "Suspended methods call"
  s.description = <<-DESC
                   * Suspended methods call with posibility to cancel already scheduled
                   DESC
  s.homepage = "https://github.com/andrewgubanov/DMDelayedInvocation/"
  s.license = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author = { "Hyper" => "andrew.gubanov@icloud.com" }
  s.platform = :ios, '7.0'
  s.source = {
    :git => 'https://github.com/andrewgubanov/DMDelayedInvocation.git',
    :tag => s.version.to_s
  }
  s.source_files = '*.{h,m}'
  s.frameworks = 'Foundation'
  s.requires_arc = true
end
