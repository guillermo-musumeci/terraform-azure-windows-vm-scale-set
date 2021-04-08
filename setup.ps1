Start-Transcript -Path 'C:/terraform-log.txt' -append;
$VerbosePreference = 'Continue';
$InformationPreference = 'Continue';
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force;
Install-Module -Name Az -Repository PSGallery -Force;
Stop-Transcript;