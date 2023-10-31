#Import required modules
Import-Module ActiveDirectory

#Prompt user for CSV file path
$filepath = Read-Host -Prompt "Enter Path of CSV (It shouldn't contain any headers & formatted as FirstName,LastName,UserName,Email,Title,OU,Password,SAM)"

# Import the file into a variable
$users = Import-Csv $filepath -Delimiter ";"

#Loop through each row and gather information
ForEach ($user in $users) {

    #Gather the user's information
    $fname = $user.FirstName
    $lname = $user.LastName
    $uname = $user.Username
    $email = $user.Email
    $jtitle = $user.Title
    $OUpath = $user.'Organizational Unit'
    $pass = $user.Password
    $SAM = $user.SAM
    $securePassword = ConvertTo-SecureString $pass -AsPlainText -Force
   
   #Create new AD user for each user in CSV file
    New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -UserPrincipalName $uname -SamAccountName $SAM -Path $OUpath -AccountPassword $securePassword -PasswordNeverExpires $true -Enabled $true -EmailAddress $email

    # Add further code below if required
}