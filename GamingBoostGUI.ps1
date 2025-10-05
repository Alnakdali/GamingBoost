Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Gaming Boost"
$form.Size = New-Object System.Drawing.Size(400, 400)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Optimize your PC for Gaming & Streaming"
$label.Size = New-Object System.Drawing.Size(380, 30)
$label.Location = New-Object System.Drawing.Point(10,10)
$form.Controls.Add($label)

# Game Mode
$btnGameMode = New-Object System.Windows.Forms.Button
$btnGameMode.Text = "Enable Game Mode"
$btnGameMode.Size = New-Object System.Drawing.Size(150,40)
$btnGameMode.Location = New-Object System.Drawing.Point(120,50)
$btnGameMode.Add_Click({
    Start-Process "ms-settings:gaming-gamemode"
    [System.Windows.Forms.MessageBox]::Show("Game Mode Enabled!")
})
$form.Controls.Add($btnGameMode)

# Clean System Temp & Cache
$btnClean = New-Object System.Windows.Forms.Button
$btnClean.Text = "Clean System & Cache"
$btnClean.Size = New-Object System.Drawing.Size(150,40)
$btnClean.Location = New-Object System.Drawing.Point(120,100)
$btnClean.Add_Click({
    # Temp Windows
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    # Temp User Cache
    $cachePaths = @("$env:LOCALAPPDATA\Temp", "$env:LOCALAPPDATA\Microsoft\Windows\INetCache")
    foreach ($p in $cachePaths) {
        Remove-Item -Path "$p\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
    [System.Windows.Forms.MessageBox]::Show("System & Cache cleaned!")
})
$form.Controls.Add($btnClean)

# Optimize UI
$btnUI = New-Object System.Windows.Forms.Button
$btnUI.Text = "Optimize UI"
$btnUI.Size = New-Object System.Drawing.Size(150,40)
$btnUI.Location = New-Object System.Drawing.Point(120,150)
$btnUI.Add_Click({
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
    [System.Windows.Forms.MessageBox]::Show("UI Optimized!")
})
$form.Controls.Add($btnUI)

# Clean RAM
$btnRAM = New-Object System.Windows.Forms.Button
$btnRAM.Text = "Clean RAM"
$btnRAM.Size = New-Object System.Drawing.Size(150,40)
$btnRAM.Location = New-Object System.Drawing.Point(120,200)
$btnRAM.Add_Click({
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    [System.GC]::Collect()
    [System.Windows.Forms.MessageBox]::Show("RAM cleaned successfully!")
})
$form.Controls.Add($btnRAM)

# Exit
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Exit"
$btnExit.Size = New-Object System.Drawing.Size(150,40)
$btnExit.Location = New-Object System.Drawing.Point(120,300)
$btnExit.Add_Click({$form.Close()})
$form.Controls.Add($btnExit)

$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
