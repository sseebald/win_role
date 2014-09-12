class role::win_web_server {
 
  if $osfamily == 'windows' {   
    include dotnet
    include chocolatey
    include profile::windows_baseline
    include profile::iis
    include cmsapp
  }

}
