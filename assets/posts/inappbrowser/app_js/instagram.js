/* --------------------
DISCLAIMER: 

The code below was generated through https://inappbrowser.com
which basically overrides many of the standard JavaScript functions to get alerted
whenever the host iOS app runs JavaScript commands. The code below is not complete.
For example, having "[object HTMLScriptElement]" would mean an object, of the type
HTMLScriptElement is being used. However, there are no further insights on those.

Also, there might be more JavaScript code that is being run, through
https://developer.apple.com/documentation/webkit/wkcontentworld, which can't be detected
by this tool.

The code below is for educational purposes only, and does not reflect a 100% accurate
representation of the JavaScript code that is being run.

This file was generated on 2022-08-17
*/



HTMLDocument.addEventListener('selectionchange', function () { window.webkit.messageHandlers.fb_getSelectionScriptMessageHandler.postMessage(getSelectedText()); })

HTMLDocument.getElementById('iab-pcm-sdk')
HTMLDocument.createElement('script')
[object HTMLScriptElement].src = 'https://connect.facebook.net/en_US/pcm.js';
[object HTMLScriptElement].type = 'text/javascript'
[object HTMLScriptElement].id = 'iab-pcm-sdk'
HTMLDocument.getElementsByTagName('script')
[object HTMLCollection]['0']

window.addEventListener('click', function (){var l=arguments;n||(e.apply(this,l),n=!0,setTimeout(function(){n=!1},t))}

window.addEventListener('focusin', function (){var l=arguments;n||(e.apply(this,l),n=!0,setTimeout(function(){n=!1},t))}

window.addEventListener('message', function I(e){try{const t=JSON.parse(e.data),n=(t.callbackID,t.resultJSON),o=(t.resultStatus,t.functionName);"syncAllPaymentFieldsInRootForIABIOSAutofill"===o?l.findPaymentFieldsInAllFramesForIABIOS():"setPaymentAutofillValueInAllFramesForIABIOS"===o&&l.setPaymentAutofillValueInAllFramesForIABIOS(n)}catch(e){}}, false

HTMLDocument.getElementsByTagName('iframe')
