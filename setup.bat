@echo off

echo "Copying .env.example to .env..."
if not exist .env (
    copy .env.example .env
    echo "File .env created."
) else (
    echo "File .env already exists, skipping copy."
)

echo "Installing PHP dependencies..."
call composer install --no-interaction
if errorlevel 1 (
    echo "Composer installation failed."
    exit /b
)

echo "Installing frontend dependencies..."
call npm install
if errorlevel 1 (
    echo "NPM installation failed."
    exit /b
)

echo "Building frontend assets..."
call npm run build
if errorlevel 1 (
    echo "Building frontend assets failed."
    exit /b
)

echo "Generating application key..."
call php artisan key:generate
if errorlevel 1 (
    echo "Generating application key failed."
    exit /b
)

echo "Setup complete! You can now run the application using - start.bat"
pause