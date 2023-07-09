$userspath = "C:\Users\fuada\Downloads\LUsers.csv"
$users  = Import-Csv $userspath
foreach ($user in $users){
$displayname = $user.DisplayName
$userprincipalname = $user.userprincipalname
$password = $user.password
$mailnickname = $user.MailNickname


$passwordprofile = New-object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile 
$PasswordProfile.Password = $password
$passwordprofile.ForceChangePasswordNextLogin = $true



New-azureaduser -DisplayName $displayname -UserPrincipalName $userprincipalname -passwordprofile $passwordprofile -MailNickName $mailNickname -AccountEnabled $true

$licenseassignment = get-mgsubscribedsku -all | where skupartnumber -eq 'SPE_E3'
Set-mguserlicense -userID $userprincipalname -addlicenses @{SKUID = $licenseassignment.SkuId} 

}