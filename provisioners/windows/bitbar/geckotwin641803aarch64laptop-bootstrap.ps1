<#
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
#>

function Write-Log {
  param (
    [string] $message,
    [string] $severity = 'INFO',
    [string] $source = 'BootStrap',
    [string] $logName = 'Application'
  )
  if (!([Diagnostics.EventLog]::Exists($logName)) -or !([Diagnostics.EventLog]::SourceExists($source))) {
    New-EventLog -LogName $logName -Source $source
  }
  switch ($severity) {
    'DEBUG' {
      $entryType = 'SuccessAudit'
      $eventId = 2
      break
    }
    'WARN' {
      $entryType = 'Warning'
      $eventId = 3
      break
    }
    'ERROR' {
      $entryType = 'Error'
      $eventId = 4
      break
    }
    default {
      $entryType = 'Information'
      $eventId = 1
      break
    }
  }
  Write-EventLog -LogName $logName -Source $source -EntryType $entryType -Category 0 -EventID $eventId -Message $message
  if ([Environment]::UserInteractive) {
    $fc = @{ 'Information' = 'White'; 'Error' = 'Red'; 'Warning' = 'DarkYellow'; 'SuccessAudit' = 'DarkGray' }[$entryType]
    Write-Host  -object $message -ForegroundColor $fc
  }
}
function Setup-Logging {
  param (
    [string] $ext_src = "https://s3-us-west-2.amazonaws.com/ronin-puppet-package-repo/Windows/prerequisites",
    [string] $local_dir = "$env:systemdrive\BootStrap",
    [string] $nxlog_msi = "nxlog-ce-2.10.2150.msi",
    [string] $nxlog_conf = "nxlog.conf",
    [string] $nxlog_pem  = "papertrail-bundle.pem",
    [string] $nxlog_dir   = "$env:systemdrive\Program Files (x86)\nxlog"

  )
  begin {
    Write-Log -message ('{0} :: begin - {1:o}' -f $($MyInvocation.MyCommand.Name), (Get-Date).ToUniversalTime()) -severity 'DEBUG'
  }
  process {
    New-Item -ItemType Directory -Force -Path $local_dir

    Invoke-WebRequest  $ext_src/$nxlog_msi -outfile $local_dir\$nxlog_msi -UseBasicParsing
    msiexec /i $local_dir\$nxlog_msi /passive
    while (!(Test-Path "$nxlog_dir\conf\")) { Start-Sleep 10 }
    Invoke-WebRequest  $ext_src/$nxlog_conf -outfile "$nxlog_dir\conf\$nxlog_conf" -UseBasicParsing
    while (!(Test-Path "$nxlog_dir\conf\")) { Start-Sleep 10 }
    Invoke-WebRequest  $ext_src/$nxlog_pem -outfile "$nxlog_dir\cert\$nxlog_pem" -UseBasicParsing
    Restart-Service -Name nxlog -force
  }
  end {
    Write-Log -message ('{0} :: end - {1:o}' -f $($MyInvocation.MyCommand.Name), (Get-Date).ToUniversalTime()) -severity 'DEBUG'
  }
}
function InstallRoninModule {
  param (
    [string] $src_Organisation,
    [string] $src_Repository,
    [string] $src_Revision,
    [string] $moduleName,
    [string] $local_dir = "$env:systemdrive\BootStrap",
    [string] $filename = ('{0}.psm1' -f $moduleName),
    [string] $module_name = ($moduleName).replace(".pms1",""),
    [string] $modulesPath = ('{0}\Modules\{1}' -f $pshome, $moduleName),
    [string] $bootstrap_module = "$modulesPath\bootstrap",
    [string] $moduleUrl = ('https://raw.githubusercontent.com/{0}/{1}/{2}/provisioners/windows/modules/{3}' -f $src_Organisation, $src_Repository, $src_Revision, $filename)
  )
  begin {
    Write-Log -message ('{0} :: begin - {1:o}' -f $($MyInvocation.MyCommand.Name), (Get-Date).ToUniversalTime()) -severity 'DEBUG'
  }
  process {
    mkdir $bootstrap_module  -ErrorAction SilentlyContinue
    Invoke-WebRequest $moduleUrl -OutFile "$bootstrap_module\\$filename" -UseBasicParsing
    Get-Content -Encoding UTF8 "$bootstrap_module\\$filename" | Out-File -Encoding Unicode "$modulesPath\\$filename"
    Import-Module -Name $moduleName
    }
  end {
    Write-Log -message ('{0} :: end - {1:o}' -f $($MyInvocation.MyCommand.Name), (Get-Date).ToUniversalTime()) -severity 'DEBUG'
  }
}
$workerType = 'gecko-t-win64-1803-aarch64-laptop'
$src_Organisation = 'markcor'
$src_Repository = 'ronin_puppet'
$src_Revision = 'yogas'
$image_provisioner = 'bitbar'
$max_boots = 200

$stage = $env:bootstrap_stage

If($stage -eq $null) {
    Setup-Logging
    InstallRoninModule -moduleName common-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    InstallRoninModule -moduleName arm64-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    write-host Bootstrap-schtasks -workerType $workerType -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision -image_provisioner $image_provisioner
    ARM64-Set-Options -workerType $workerType -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision -image_provisioner $image_provisioner
    ARM64-Install-Prerequ
    write-host shutdown @('-r', '-t', '0', '-c', 'Reboot; Prerequisites in place, logging setup, and env:variables are set', '-f', '-d', '4:5')
}
If (($stage -eq 'setup') -or ($stage -eq 'inprogress')){
    InstallRoninModule -moduleName common-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    InstallRoninModule -moduleName arm64-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    write-host Ronin-PreRun
    write-host Bootstrap-Puppet
}
If ($stage -eq 'complete') {
    InstallRoninModule -moduleName common-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    InstallRoninModule -moduleName arm64-bootstrap -src_Organisation $src_Organisation -src_Repository $src_Repository -src_Revision $src_Revision
    write-host Start-Restore
}