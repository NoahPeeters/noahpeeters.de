bundle exec jekyll build
(cd _site && python -m SimpleHTTPServer)&
node .generate-derived-files.js
kill $!
