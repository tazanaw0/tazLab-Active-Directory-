﻿Import-Module ActiveDirectory
#Set our AD Organizational Unit (OU)
$ou = "OU=After-School Care,DC=tazlab,DC=local"

#Set a default password for all new users
$defaultPassword = "P@wn!8l!" 

#Define number of users created 
$numberOfUsers = 20

#Loop to create random users, stops running when i > number of users (20)
for ($i = 1; $i -le $numberOfUsers; $i++) {
    #Define array of first and last names 
    $firstNames = @("Jim", "Alice", "Bob", "Robert", "Karen", "Michael", "Laura") 
    $lastNames = @("Lahey", "Jones", "Mendoza", "Williams", "Evans", "Garcia", "Solomon")

    #Randomly select first and last name from defined arrays
    $firstName = $firstNames | Get-Random 
    $lastName = $lastNames | Get-Random

    #Define variable to grab first letter of the first name 
    $firstInitial = $firstName.Substring(0,1)

    #Create a username using the first andlast name
    $username = "$firstInitial.$lastName"

    #Combine randomly selected first and last names for full name 
    $fullName = "$firstName $lastName"


    #Creates the user in Active Directory
    New-AdUser '
        -Name $fullName '
        -SamAccountName $username '
        -UserPrincipalName "$username@tazlab.local" '  
        -Path $ou '
        -AccountPassword (ConvertTo-SecureString $defaultPassword -AsPlainText -Force) ' 
        -Enabled $true #Enables activation upon creation 
      

        Write-Host "created user: $username" #Prints string to console confirming user creation

}