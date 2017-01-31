# jekyll-email-obfuscator

this is a simple email obfuscator for [jekyll](https://jekyllrb.com/). The email will be xor'ed with a random char. The browser then needs to reverse the xor function in JavaScript. This can only protect from bots without JavaScript support.

## Usage

use the following code instead of a plain email address

```
{% email test@example.com %}
```

## Installation

place the `email_obfuscator.rb` into your `_plugins` folder

## The result

the result will look like this:

example: `foo@bar.com`

```HTML
<script type="text/javascript">
        var crypti = 'nggHjiz&kge(';
        var res = '';
        for (i = 0; i !== crypti.length; i++){
                res += String.fromCharCode(crypti.charCodeAt(i) ^ parseInt('8'));
        }
        document.write('<a href="mailto:' + res + '">' + res + ' </a>');
</script>
<noscript>E-Mail cannot be displayed. Please enable JavaScript!</noscript>
```

## Licence

see [LICENSE](LICENSE)
