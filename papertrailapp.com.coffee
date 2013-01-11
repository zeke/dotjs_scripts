$('#heroku-header, #heroku-subheader').css
  display: 'none'

url = "https://s3.amazonaws.com/assets.heroku.com/hook/hook.js"

_s = document.createElement('script')
_s.src = url
_s.onload = ->  
  console.log 'onload'
document.getElementsByTagName('body')[0].appendChild(_s)