## Group Details
- Atienza, Jonas
- Iloso, Jazmin Joy 
- Natividad, Aira Nicole
- Taag, Kristoffer Laurence

## Program Description: COVID-19 Monitoring App
- Mobile application designed to track and monitor the health status of users in relation to COVID-19. 
- The app consists of three main views: User's View, Admin's View, and Entrance Monitor's View.
- In the User's View, users can sign in using their authentication credentials and enter their health status to generate a building pass.
- If a user exhibit symptoms such as feverloss of taste, or loss of smell, they will not be allowed entry, and a QR code will not be generated for them.
- Users who have had face-to-face encounters or contact with a confirmed COVID-19 case will be placed under monitoring.
- Users can also edit or delete their health entries, but these changes need to be approved by the admin.
- The Admin's View allows administrators to sign in using their authentication credentials and perform administrative tasks.
- The Entrance Monitor's View is specifically designed for entrance monitors responsible for verifying users' health statuses before allowing them entry.


## Installation Guide
- Download the file
- Go to the root of the file directory
- Enter cd [project]
- Run flutter build apk --split-per-abi

## How to Use
- Sign up as User/Admin/Entrance monitor
- Log in
- If user: Add/Edit/Delete entry for the day
- If admin: You can view, edit and search all or specific users, and can also approve/reject requests from users.
- If monitor: You can view, edit and search student logs
