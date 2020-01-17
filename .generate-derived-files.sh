bundle exec jekyll build

cd _site
python -m SimpleHTTPServer 48080&
cd ..

sleep 1
node .generate-derived-files.js
kill $!
