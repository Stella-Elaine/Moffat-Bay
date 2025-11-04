# a minimal landing page to test deploy
cat > src/main/webapp/index.jsp <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Moffat Bay Lodge</title>
  <link rel="stylesheet" href="styles/main.css"/>
</head>
<body>
  <h1>Moffat Bay Lodge</h1>
  <p>Deployment smoke test OK.</p>
  <img src="photos/sample.jpg" alt="sample" style="max-width:200px;">
  <script src="scripts/app.js"></script>
</body>
</html>
EOF

touch src/main/webapp/styles/main.css
touch src/main/webapp/scripts/app.js
touch src/main/webapp/photos/.gitkeep
