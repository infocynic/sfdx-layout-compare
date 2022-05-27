$basePath = Join-Path . (Join-Path 'force-app' (Join-Path main default))
    #powershell 5 standard with Windows 10 doesn't do multiple paths
$outputPath = Join-Path . layoutAnalysis
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Error -Message "Node not found. Check your path or install node and try again."
}

if (-not (Test-Path $outputPath))  { 
    New-Item -ItemType Directory $outputPath > $null
}



$objectMdPath = Join-Path $basePath objects
if (Test-Path $objectMdPath) {
    Get-ChildItem $objectMdPath | ForEach-Object {
        $objName = $_.Name;
		$fieldPath = Join-Path $objectMdPath (Join-Path $objName fields)
		if (Test-Path $fieldPath) {
			#you might have metadata for an object's fields but not its layouts. 
			#a future enhancement might do this inside the previous loop, only outputting 
			#fields if there were layouts; that would eliminate this if check
			$objPath = Join-Path $outputPath $objName
			if (-not (Test-Path $objPath))  { 
				New-Item -ItemType Directory $objPath > $null
			}
        
            Get-ChildItem $fieldPath | ForEach-Object {
				$fileName = Join-Path $outputPath "000 ${objName} Field Names.txt"
                $_.Name.Substring(0, $_.Name.IndexOf('.')) >> $fileName
            }
        } else {
            Write-Warning -Message "Field metadata for $objName not found. Continuing with next object."
        }
    }
}

exit 0