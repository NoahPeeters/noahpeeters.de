bundle exec jekyll build

cd _site
python -m SimpleHTTPServer 8080&
cd ..

node .generate-derived-files.js
kill $!
