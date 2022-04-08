# Este script no es mio y no encuentro el nombre del autor.

# Cambiar los siguientes parámetros
$strRemoteForest = "<nombre_de_dominio>"
$strRemoteAdmin = "<nombre_de_la_cuenta_de_administrador>"
$strRemoteAdminPassword = "<password>"
$remoteContext = New-Object -TypeName "System.DirectoryServices.ActiveDirectory.DirectoryContext" -ArgumentList @( "Forest", $strRemoteForest, $strRemoteAdmin, $strRemoteAdminPassword)
try {
        $remoteForest = [System.DirectoryServices.ActiveDirectory.Forest]::getForest($remoteContext)
        #Write-Host "GetRemoteForest: Succeeded for domain $($remoteForest)"
    }
catch {
        Write-Warning "GetRemoteForest: Failed:`n`tError: $($($_.Exception).Message)"
    }
Write-Host "Connected to Remote forest: $($remoteForest.Name)"
$localforest=[System.DirectoryServices.ActiveDirectory.Forest]::getCurrentForest()
Write-Host "Connected to Local forest: $($localforest.Name)"
try {
        $localForest.CreateTrustRelationship($remoteForest,"<Disabled/Inbound/Outbound/Bidirectional>") # Escoger uno según convenga
        Write-Host "CreateTrustRelationship: Succeeded for domain $($remoteForest)"
    }
catch {
        Write-Warning "CreateTrustRelationship: Failed for domain $($remoteForest)`n`tError: $($($_.Exception).Message)"
    }