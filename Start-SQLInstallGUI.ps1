#==============================================================================================
# XAML Code - Imported from Visual Studio Express WPF Application
#==============================================================================================
Add-Type -AssemblyName presentationframework
[xml]$XAML = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="OS Details" Height="306" Width="525" WindowStartupLocation="CenterScreen" WindowStyle='None' ResizeMode='NoResize'>
    <Grid Margin="0,0,-0.2,0.2">
        <TextBox HorizontalAlignment="Center" Height="23" TextWrapping="Wrap" Text="Operating System Details" VerticalAlignment="Top" Width="525" Margin="0,-1,-0.2,0" TextAlignment="Center" Foreground="White" Background="Black"/>
        <Label Content="Hostname" HorizontalAlignment="Left" Margin="0,27,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="Operating System Name" HorizontalAlignment="Left" Margin="0,62,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="Available Memory" HorizontalAlignment="Left" Margin="0,97,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="OS Architecture" HorizontalAlignment="Left" Margin="0,132,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="Windows Directory" HorizontalAlignment="Left" Margin="0,167,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="Windows Version" HorizontalAlignment="Left" Margin="0,202,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <Label Content="System Drive" HorizontalAlignment="Left" Margin="0,237,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="Black" Foreground="White"/>
        <TextBox Name="txtHostName" HorizontalAlignment="Left" Height="30" Margin="175,27,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtOSName" HorizontalAlignment="Left" Height="30" Margin="175,62,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtAvailableMemory" HorizontalAlignment="Left" Height="30" Margin="175,97,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtOSArchitecture" HorizontalAlignment="Left" Height="30" Margin="175,132,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtWindowsDirectory" HorizontalAlignment="Left" Height="30" Margin="175,167,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtWindowsVersion" HorizontalAlignment="Left" Height="30" Margin="175,202,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtSystemDrive" HorizontalAlignment="Left" Height="30" Margin="175,236,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <Button x:Name="btnExit" Content="Exit" HorizontalAlignment="Left" Margin="0,272,0,0" VerticalAlignment="Top" Width="170" Height="24" BorderThickness="0"/>
        <Button x:Name="btnOK" Content="OK" HorizontalAlignment="Left" Margin="175,272,0,0" VerticalAlignment="Top" Width="170" Height="24" BorderThickness="0"/>
        <Button x:Name="btnReset" Content="Reset" HorizontalAlignment="Left" Margin="348,272,0,0" VerticalAlignment="Top" Width="170" Height="24" BorderThickness="0"/>
    </Grid>
</Window>
'@
#Read XAML
$reader=(New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $xaml) 
try   {
      $Form=[Windows.Markup.XamlReader]::Load( $reader )
      }
catch {
      Write-Eror -message 'Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered.'
      exit
    }

#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
$xaml.SelectNodes('//*[@Name]') | ForEach-Object { Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name) }
#===========================================================================
# Add events to Form Objects
#===========================================================================
$btnExit.Add_Click({$form.Close()})


#===========================================================================
# Stores WMI values in WMI Object from Win32_Operating System Class
#===========================================================================
$oWMIOS = Get-WmiObject -Class win32_OperatingSystem

#===========================================================================
# Links WMI Object Values to XAML Form Fields
#===========================================================================
$txtHostName.Text = $oWMIOS.PSComputerName

#Formats and displays OS name
$aOSName = $oWMIOS.name.Split('|')
$txtOSName.Text = $aOSName[0]

#Formats and displays available memory
$sAvailableMemory = [math]::round($oWMIOS.freephysicalmemory/1000,0)
$sAvailableMemory = "$sAvailableMemory MB"
$txtAvailableMemory.Text = $sAvailableMemory

#Displays OS Architecture
$txtOSArchitecture.Text = $oWMIOS.OSArchitecture

#Displays Windows Directory
$txtWindowsDirectory.Text = $oWMIOS.WindowsDirectory

#Displays Version
$txtWindowsVersion.Text = $oWMIOS.Version

#Displays System Drive
$txtSystemDrive.Text = $oWMIOS.SystemDrive

#===========================================================================
# Shows the form
#===========================================================================
$null = $Form.ShowDialog()