$GenericsFolder = "~\dev\Generic"
$surnames = import-csv -path "$($GenericsFolder)\FamilyNames.txt" -Header "item"    #1..1000
$males = import-csv -path "$($GenericsFolder)\givenNames-m.txt" -Header "item"       #1..1000
$females = import-csv -path "$($GenericsFolder)\givenNames-f.txt" -Header "item"     #1..1000
$states = import-csv -path "$($GenericsFolder)\states.txt" -Header "item"      #1..59
$streets = import-csv -path "$($GenericsFolder)\Streets.txt" -Header "item"     # 1..20
$avenues = import-csv -path "$($GenericsFolder)\streetTypes.txt" -Header "item" #1..170
$cities = import-csv -path "$($GenericsFolder)\cities_and_communities.txt" -Header "item" # 1..89

function Get-RandomSurname {
    $r = Get-Random -Minimum 0 -Maximum 999; 
    return $surnames[$r].item.trim()
}

function Get-RandomMale {
    $r = Get-Random -Minimum 0 -Maximum 999; 
    return $males[$r].item.trim()
}

function Get-RandomFemale {
    $r = Get-Random -Minimum 0 -Maximum 999; 
    return $females[$r].item.trim()
}

function New-RandomName {
    $FullName = ""
    $LastName = Get-RandomSurname
    if ((Get-Random -Minimum 0 -Maximum 999) % 2 -eq 0){
        $FullName = "{0} {1}" -f (Get-RandomFemale).trim(),$LastName.trim()
    } else {
        $FullName = "{0} {1}" -f (Get-RandomMale).trim(),$LastName.trim()
    }
    return $FullName
}

function New-RandomUser {
    $UserInfo = @{
        name = ""
        username = ""
    }
    $UserInfo.name = New-RandomName
    $UsernameText = $UserInfo.name.Substring(0,1) + ($UserInfo.name -split ' ')[1] + (get-random -Minimum 1 -Maximum 1000)
    $UserInfo.username = $UsernameText.ToLower()
    return $UserInfo
}

function New-RandomStreetAddress {
    $r1 = Get-Random -Minimum 0 -Maximum 10000;
    $r2 = Get-Random -Minimum 0 -Maximum 20;
    $r3 = Get-Random -Minimum 0 -Maximum 169;
    $StreetAddress = $r1.ToString() + " " + $streets[$r2].item.ToString().trim() + " " + $avenues[$r3].item.trim()
    return $StreetAddress
}

function New-RandomMailingAddress {
    $Add1 = New-RandomStreetAddress
    $Add2 = $cities[(Get-Random -min 0 -max 89)].item.ToString().trim() + ", " + $states[(Get-Random -min 0 -max 59)].item.ToString().trim()
    $MailAddy = $Add1 + ", " + $Add2
    return $MailAddy
}