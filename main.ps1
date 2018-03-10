
$path = 'C:\Users\mail\GIT\SQLInstallGUI'
$xaml = Get-Content -Path $Path\main.xaml
$Win = [Windows.Markup.XamlReader]::Parse($XAML)

$sourcePath = $Win.FindName("listBox_file")
$button = $Win.FindName("button_choose")
$button.Add_Click({Select-FolderDialog('Select Folder', $path)})

Add-Type -Assembly System.Windows.forms

$Win.ShowDialog()