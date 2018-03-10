function Select-FolderDialog 
{
  param([String]$Description="Select Folder", 
        [String]$RootFolder="Desktop")   

  $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
  $objForm.Rootfolder = $RootFolder
  $objForm.Description = $Description
  $Show = $objForm.ShowDialog()
  if ($Show -eq "OK")
  {
     $SourcePath.Items.Add($objForm.SelectedPath)
  }
}

Select-FolderDialog('Select Folder', $path)