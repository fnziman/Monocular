# Monocular
Monocular is an MVC framework inspired by Rails. It includes a ControllerBase class which acts similar to a Rails Controller, and a Route class which similarly loads HTML views.

## Features & Implementation
### Router
The router class enables the user to specify which controller and view to be used depending on the specified HTTP method and url.

### ControllerBase
All controllers in Monocular inherit from ControllerBase. ControllerBase gives them the following methods:
1. ```redirect_to(url)``` redirects the user to the specified url
2. ```render(template_name)``` finds the correct file to be rendered, and passes the file along to ```render_content```
3. ```render_content(content, content-type)``` first checks whether a response has already been made, and then continues to set the response type and content of the response. Additionally, calls ```session``` and ```flash```
4. ```session``` creates a session cookie and writes appropriate data to the cookie
5. ```flash``` creates a flash cookie. A flash cookie can either be a flash or a flash.now. Flash persists for the current and next request, while flash.now only persists for the current request

## Example

1. GitClone https://github.com/fnziman/Monocular
2. ```bundle install```
3. ```bundle exec ruby show.rb```
4. Visit http://localhost:3000/shows
5. Enter some of your favorite shows and how you would rate them
