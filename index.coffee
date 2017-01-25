rest = require('restler')
exec = require('child_process').exec

uri = ['https://solutionsbyoquinn.com/agilefant']
say = require('say.js').dev

issue = (cmd) ->
  exec cmd, (error, stdout, stderr) ->
    say "[CMD OUTPUT]", stdout
  
validate = ->
  rest.get(uri[0]).on 'complete', (data, response) ->
    say "[SERVER HEALTH]", response.statusCode
    if response.statusCode != 200
      say "you should restart the server with a bash call"
      issue "/etc/init.d/apache2 stop && /etc/init.d/apache2 start && /etc/init.d/tomcat7 stop && /etc/init.d/tomcat7 start"
      setTimeout validate, 60000
    else
      setTimeout validate, 10000 
    return
  return 

validate()
