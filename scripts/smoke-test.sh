
for i in {1..10}; do
    if curl -s http://localhost:8080 | grep -o '<title>.*</title>'; then
    echo "App is UP"
    exit 0
    fi
    echo "Waiting for app..."
    sleep 5
done
echo "App failed to start"
exit 1