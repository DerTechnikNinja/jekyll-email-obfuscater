module Jekyll
    class EmailObfuscatorTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @noScript = "E-Mail cannot be displayed. Please enable JavaScript!"
            @cls = ""
            if text.include? 'class'
                text, @cls = text.split("class:") 
                text = text.strip()
                @cls = @cls.strip()
            end
            @name, second = text.split("\@")
            @name = text
            res = Array.new
            @random = rand(15) + 1
            @name.each_byte do |c|
                res.append(c ^ @random)
            end
            @name = res
        end
    
        def render(context)
            "<script type='text/javascript'>\n" \
            "\tcrypti = #{@name};\n" \
            "\tres = '';\n" \
            "\tfor (i = 0; i !== crypti.length; i++) {\n" \
            "\t\tres += String.fromCharCode(crypti[i]^parseInt('#{@random}'));\n" \
            "\t}\n" \
            "\tdocument.write('<a href=\"mailto:' + res + '\">' + '<i class= ' + '\"#{@cls}\"' + '></i></a>');\n" \
    	"</script>\n" \
    	"<noscript>#{@noScript}</noscript>"
        end
    end
end
Liquid::Template.register_tag('email', Jekyll::EmailObfuscatorTag)
