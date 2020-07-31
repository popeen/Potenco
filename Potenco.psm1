#TODO, documentation
#TODO, Verify that it works within module, it is verified to work as normal function
function Invoke-ElevateIfNeeded{
    param(
        [ValidateSet("AllSigned", "Bypass", "Default", "RemoteSigned", "Restricted")]
        [String]
        $ExecutionPolicy = "Default"
    )
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    $isElevated = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    if(-not $isElevated){
        Start-Process powershell -Verb runAs -ArgumentList "-ExecutionPolicy $ExecutionPolicy -File $PSCommandPath"
        break
    }
}
