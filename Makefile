# mini Makefile to automatize tasks

GAE_ROOT="/home/jerome/opt/gae/google_appengine"

help:
	@echo "$$ make server"
	@echo "\tRun the developement server"
	@echo "$$ make deploy"
	@echo "\tDeploy the application on google AppEngine"
	@echo "$$ make help"
	@echo "\tDisplay inline help"

server:
	$(GAE_ROOT)/dev_appserver.py .


docs:
	dox	--title "html5-RockPaperScissors"		\
		--desc "RockPaperScissors on WebSocket"		\
		contrib/rockPaperScissors/main.js		\
		> contrib/rockPaperScissors/doc.html

minify:
	closurec --js easyWebSocket.js --js_output_file easyWebSocket.min.js

deploy	: minify deployGhPage deployAppEngine 

deployAppEngine:
	$(GAE_ROOT)/appcfg.py update .

deployGhPage:
	rm -rf /tmp/EasyWebsocketGhPages	
	(cd /tmp && git clone git@github.com:jeromeetienne/EasyWebsocket.git EasyWebsocketGhPages)
	(cd /tmp/EasyWebsocketGhPages && git checkout gh-pages)
	cp -a *.html *.js CNAME ./web ./example ./contrib /tmp/EasyWebsocketGhPages
	(cd /tmp/EasyWebsocketGhPages && git add . && git commit -a -m "Another deployement" && git push origin gh-pages)
	#rm -rf /tmp/EasyWebsocketGhPages
