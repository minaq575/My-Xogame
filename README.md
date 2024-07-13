
# Xo Game
<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/cb3be3c7-d8e9-42fb-b13c-2e44252136bd" width="100"/>
</div>
This project creates the game "XO" on the Flutterplatform written in Dart language.

## Table of Contents
 - [Setup and Run the program](#setup-and-run-the-program)
 - [Show changes from Chrome to applications](#show-changes-from-chrome-to-applications)
 - [Design Program](#design-program)
 -  [Algorithm](#algorithm)
 - [Technologies](#technologies)
 
## Setup and Run the program

1. ติดตั้ง **[Setup Flutter](https://flutter.io/setup/)**
2. Clone  git
 ```git clone https://github.com/minaq575/My-Xogame.git```
3. Install dependencies
	  ```flutter pub get```
4. Run the program 
	```flutter run -d chrome```
	
## Show changes from Chrome to applications
 
![2024-07-13-16-39-33](https://github.com/user-attachments/assets/3c004292-2ed1-4b4f-8b09-5e0fced38d20)

## Design Program
Overview of the flowchart work process

<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/5955aae5-6fff-40e0-bf31-38e917cd8d77"/>
</div>

## Algorithm
**Input name**
<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/d2505419-0e43-44df-9fe2-a359b340df91"/>
</div>

When entering the game page, players must enter their name. If not, an error message will appear when the start button is pressed. If they press OK They'll go to the Yes, enter a name step, and when they're done. Press the start button. To go to the main game page, the name will be displayed after the word player. End.

#

**Select grid**
<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/2c0d0822-b1db-4e27-a884-3ca9fb8c86a0"/>
</div>

When entering the main game page You will need to decide whether to choose a grid size or not. If no, you can start playing in the section showing the default size 3*3, but if yes is selected, enter the desired numbers 3-9. Once selected, press the button. Set the grid size. The size will update and display the grid size.

#

**Check the gaps and Check wins or nobody wins**

<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/a1a553a6-b944-40f9-a76a-5776e97c28c9"/>
</div>

When starting to play the game The player clicks play in the grid and input O. To display O in the table, AI will automatically click and input X to display X in the table. When playing is finished, the system will check for gaps if there are no gaps. It will display the message nobody wins! End. If there are spaces, go towards yes. Check the row, check the column, check the main diaginals, check the secondary diaginals, see if it's O or X. Is the sequence complete or are there still gaps?
If no, go back and check again. If yes, go to check if it's a win or not. If no, it will show nobody wins! But if yes, it will show the message Player (O or X ) Wins! End.

#

**View history**

<div id="header" align="center">
  <img src="https://github.com/user-attachments/assets/8828d8e4-6956-43ec-ab72-219b796a5131"/>
</div>
When players and AI place O or X in the grid, update the game history. Let the player decide whether to view the history. If not, the game ends. If yes, press a button to enter the history screen. The history screen shows the game data for X and O.



## Technologies

 - [Flutter v3.22.2](https://flutter.dev/) 
 - [Dart v3.4.3](https://dart.dev/)
 - [DevTools v2.34.3](https://docs.flutter.dev/tools/devtools/release-notes)
 -  [Android Studio v2022.2](https://developer.android.com/studio?gad_source=1&gclid=CjwKCAjwy8i0BhAkEiwAdFaeGC8xODpdSFdPv-eRvl8l14HpYDhnF_LhplHA27AwJl6JJrmXzXrYXhoCPnEQAvD_BwE&gclsrc=aw.ds&hl=th)
 - [Android SDK v 34.0.0](https://developer.android.com/tools/releases/build-tools)
 - [VS Code v1.91.1](https://code.visualstudio.com/)
 - [Visual Studio Community  2022 v.17.10.3](https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-notes#17103--visual-studio-2022-version-17103)
 #
 **Thank you.**
 Napassorn Kemkrathok
