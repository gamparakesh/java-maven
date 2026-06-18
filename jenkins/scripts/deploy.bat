@echo off
:: ==========================================
:: SIMPLE DEPLOYMENT SCRIPT
:: ==========================================

:: 1. Define your Source and Destination paths
set "SOURCE_DIR=C:\ProgramData\Jenkins\.jenkins\workspace\simple-java-maven-project\target\"
set "DEST_DIR=C:\Leela\Jenkins\"

echo Starting deployment...
echo Copying files from: %SOURCE_DIR%
echo Copying files to:   %DEST_DIR%
echo ------------------------------------------

:: 2. Create the destination directory if it doesn't exist
if not exist "%DEST_DIR%" (
    echo Destination folder doesn't exist. Creating it...
    mkdir "%DEST_DIR%"
)

:: 3. Copy the files
:: /S = Copies directories and subdirectories (except empty ones)
:: /E = Copies any subdirectories, even if they are empty
:: /Y = Suppresses prompting to confirm you want to overwrite an existing file
:: /I = If destination does not exist and copying more than one file, assumes that destination must be a directory
xcopy "%SOURCE_DIR%\my-app-1.0-SNAPSHOT.jar" "%DEST_DIR%\" /S /E /Y /I

:: 4. Check if the copy operation was successful
if %ERRORLEVEL% EQU 0 (
    echo ------------------------------------------
    echo Deployment completed successfully!
    echo ------------------------------------------
) else (
    echo ------------------------------------------
    echo ERROR: Deployment failed during file copy.
    echo ------------------------------------------
)

:: Execute the Java file within the copied JAR
echo Starting Java application...
echo ------------------------------------------

cd /d "%DEST_DIR%"

:: Option A: If your JAR has a Main-Class defined in its manifest (Standard)
java -jar "%JAR_NAME%"

:: Option B: If you need to run a specific class file within the JAR manually, 
:: uncomment the line below and replace 'com.example.MainClass' with your actual package path:
:: java -cp "%JAR_NAME%" com.example.MainClass

echo ------------------------------------------
echo Application execution finished.
echo ==========================================
