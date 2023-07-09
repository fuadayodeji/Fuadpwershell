Connect-AzureAD
Connect-MGGraph

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

$licenseassignment = get-mgsubscribedsku -all | where-object  skupartnumber -eq 'SPE_E3'
$addlicenses = @({SKUID = $licenseassignment.SkuId})
Set-MgUserLicense -userID $userprincipalname -addlicenses $addlicenses -passwordprofile $password -RemoveLicenses @()

}

#$e3Sku = Get-MgSubscribedSku -All | Where-object SkuPartNumber -eq 'SPE_E3' 
#Set-MgUserLicense -UserId "david@faradaf.com" -AddLicenses @{SkuId = $e3Sku.SkuId} -RemoveLicenses @()