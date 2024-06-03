#Overview: 
Our app is a digital coaching app that uses mathematical analysis to provide tennis players accurate and timely feedback on their movement.
Our application needs the ML Kit provided by Google which detects a player’s pose and digitalises the player, that is, it provides us with the coordinate of the player’s arm position, shoulder position, etc., in time. And we aim to develop an algorithm that analyses and compares the data obtained from these players with professional players. And hence give them detailed feedback on their movement. The final application will be able to take in the video of the player and automatically give feedback.

#Target Level of Achievement: 
Apollo 11

#Motivation:
Tennis is getting more and more popular these days. Most of the time, people just play with friends for fun rather than hiring a coach for training since it is often inconvenient and expensive. However, playing tennis without professional guidance can easily lead to injuries due to improper usage of strength, over-usage of wrist, etc. Hence, we hope to develop an application that can give players technical advice on adjusting and improving their movements. 

#Aim:
We aim to develop an app in which tennis players can receive professional feedback on how to improve their movements simply by uploading a video of them hitting. It enables players to conveniently receive professional advice whenever they are playing. What’s more, our application also aims to help player determine which style suits them best by comparing their movement with famous tennis athletes. 

#Technical Proof of Concept:
Go to our project’s Github page: 
https://github.com/YosieSYX/TennisPro_Orbital
In the Code dropdown menu, click on: Open with Xcode. 
After opened it with Xcode, Go to Project -> Build settings -> Build Options -> User script sandboxing, set it to yes. 
Click on Product -> Destination -> Show All Destinations. Then chose (Rosetta) simulator
Now you can simulate our app! 


#Timeline & Development plan(project log):
5.13-5.19
Pick up necessary skills: learn Xcode, Swift Language(storyboard,swift and swiftUI),  Github, Firebase, basic software engineering knowledge,basic database knowledge.
(Both, 3 hours each day)
Design project poster.
(Both, 0.5 hours each day)
5.20-5.26
-Yuexi: Setup Github, Install necessary MLkit Pods, setting up coding environment.  (2 hours each day)
Difficulties faced: Pods was too big to upload onto Github immediately. Had to install bfs(large file storage) to upload.

-Qingru: Create a user login and register system in Storyboard language and link firebase to store users’ data. （3 hours each day)

-Both:participate in mission control 2, learn Github and software engineer basic.(total 4 hour)
5.27-6.2
-Yuexi: Read through the documentation for ML kit. Learned to use the API. Created Welcome Page in SwiftUI. Update project poster. (around 2 hours each day) 

-Yang qingru: Decide to switch from storyboard to swiftUI for UI development and redo log in and sign up creation.(average 1.5 hours each day), and set up the tools and environment to push the project to github.(total 2 hour)

-Both:Identify project’s features, design the system, create a development plan,document our work.(average 0.5 hour each day). Mission control 3 (total 2 hour)

Milestone1: Learn and gain necessary skill sets. Set up coding environment, Create Welcome Page, User Register and Login Interface. Set up and link data base. 

6.3-6.16
Frontend: Setup video upload interface and database. 
Backend: Develop movement analysis algorithm, identify key positions such as racket position before hitting the ball, elbow position when hitting the ball, etc. 
6.17-6.23
Set up view history of progress feature. 
6.24-6.30
Publish app for others to test. 
Receive feedback and optimise. 
Milestone2: Finish the movement analysis and view history of progress feature. Publish app, Perform first round of user testing. 

7.1-7.10
Design interface for display the rating of the player. 
Develop algorithm for giving rating to the player. 
7.11-7.18
Second round of user testing. 
Finalise Documentation of application. 
7.18-7.25
Improve accuracy of algorithm. 
Beautify the interface. 
Milestone3: Finish Additional Feature: rating system. Perform testing and optimise application,



#Features:
Welcome Page, Signup and Login: 
Welcome Page: 
Sign up and Login page: 
New users can create an account by typing in their first name, last name, email and password. 
Afterwards,they will have a record in our system and they may just login using their email and password. 
Implementation:
1. Use SwiftUI to design the user interface in Xcode.
2.Then create a new project  in firebase. 
3. To bind the firebase project with the Xcode project :Enter Xcode bundle identifier in firebase project setting. Download and drag firebase GoogleService.info file into Xcode project.
4. Add relevant package dependencies in Xcode.
5.Add  code “firebase.configure() “and “import Firebase core”  
6.Firebase project and Xcode project is successfully connected

Video Upload:
After logging in, users can either upload their existing videos or they can upload their new videos. 
Implementation: 

Video Analysis
        After the user uploaded their video, the system will first convert the video into coordinates and then analyse it with the algorithm that we designed. 
          Users will be given statistics on overall how well they played, the speed of their ball, etc. And they will be given advice on their movements such as: elbow position, wrist position when hitting the ball. 

History of progress
Uploaded video and its grading report can be saved and be revisited at a later time. Once you click the “view history of progress”button, all the past uploaded videos will be displayed in chronological order and you can view them easily.

Rating system
Based on our analysis of the user’s movement and statistics, we will give users a rating of how well they performed based on NTRP rating system for user’s reference. 

#Tech Stack:
Language: Swift
Xcode: main platform for developing the app.
Github: For collaboration using the push and pull requests as well as version control. 
Firebase: For storing user data: their login information and the video they uploaded. 

#Use case:
Actor: user
Scenario: view history of progress
1.login to your account
2.click view history of progress button 
3. Past upload ,labelled with the time it was generated, are displayed in a chronological order
4.choose the specific analysis you want to view
5. The past analysis(grading report), along with corresponding video are displayed 

Actor: user 
Scenario: generate new analysis(grading report)
Login to your account
Click on “+” button
The app requests access to your camera or photo library .
User grants the app access to camera or photo library
User choose the video he/she wants to upload 
The video is uploaded into the app
The app analysis the video and generate a new report, which include grade and advice for improvement  
The app automatically add the new report into your history of progress



