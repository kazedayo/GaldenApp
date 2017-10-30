var iconList = [
                { "id": "[369]", "url": "http://hkgalden.com/face/hkg/369.gif" },
                { "id": "#adore#", "url": "http://hkgalden.com/face/hkg/adore.gif" },
                { "id": "#yup#", "url": "http://hkgalden.com/face/hkg/agree.gif" },
                { "id": "O:-)", "url": "https://hkgalden.com/face/hkg/angel.gif" },
                { "id": ":-[", "url": "http://hkgalden.com/face/hkg/angry.gif" },
                { "id": "#ass#", "url": "http://hkgalden.com/face/hkg/ass.gif" },
                { "id": "[banghead]", "url": "http://hkgalden.com/face/hkg/banghead.gif" },
                { "id": ":D", "url": "http://hkgalden.com/face/hkg/biggrin.gif" },
                { "id": "[bomb]", "url": "http://hkgalden.com/face/hkg/bomb.gif" },
                { "id": "[bouncer]", "url": "http://hkgalden.com/face/hkg/bouncer.gif" },
                { "id": "[bouncy]", "url": "http://hkgalden.com/face/hkg/bouncy.gif" },
                { "id": "#bye#", "url": "http://hkgalden.com/face/hkg/bye.gif" },
                { "id": "[censored]", "url": "http://hkgalden.com/face/hkg/censored.gif" },
                { "id": "#cn#", "url": "http://hkgalden.com/face/hkg/chicken.gif" },
                { "id": ":o)", "url": "http://hkgalden.com/face/hkg/clown.gif" },
                { "id": ":~(", "url": "http://hkgalden.com/face/hkg/cry.gif" },
                { "id": "xx(", "url": "http://hkgalden.com/face/hkg/dead.gif" },
                { "id": ":-]", "url": "http://hkgalden.com/face/hkg/devil.gif" },
                { "id": "#ng#", "url": "http://hkgalden.com/face/hkg/donno.gif" },
                { "id": "#fire#", "url": "http://hkgalden.com/face/hkg/fire.gif" },
                { "id": "[flowerface]", "url": "http://hkgalden.com/face/hkg/flowerface.gif" },
                { "id": ":-(", "url": "http://hkgalden.com/face/hkg/frown.gif" },
                { "id": "fuck", "url": "http://hkgalden.com/face/hkg/fuck.gif" },
                { "id": "@_@", "url": "http://hkgalden.com/face/hkg/@.gif" },
                { "id": "#good#", "url": "http://hkgalden.com/face/hkg/good.gif" },
                { "id": "#hehe#", "url": "http://hkgalden.com/face/hkg/hehe.gif" },
                { "id": "#hoho#", "url": "http://hkgalden.com/face/hkg/hoho.gif" },
                { "id": "#kill2#", "url": "http://hkgalden.com/face/hkg/kill2.gif" },
                { "id": "#kill#", "url": "http://hkgalden.com/face/hkg/kill.gif" },
                { "id": "^3^", "url": "http://hkgalden.com/face/hkg/kiss.gif" },
                { "id": "#love#", "url": "http://hkgalden.com/face/hkg/love.gif" },
                { "id": "#no#", "url": "http://hkgalden.com/face/hkg/no.gif" },
                { "id": "[offtopic]", "url": "http://hkgalden.com/face/hkg/offtopic.gif" },
                { "id": ":O", "url": "http://hkgalden.com/face/hkg/oh.gif" },
                { "id": "[photo]", "url": "http://hkgalden.com/face/hkg/photo.gif" },
                { "id": "[shocking]", "url": "http://hkgalden.com/face/hkg/shocking.gif" },
                { "id": "[slick]", "url": "http://hkgalden.com/face/hkg/slick.gif" },
                { "id": ":)", "url": "http://hkgalden.com/face/hkg/smile.gif" },
                { "id": "[sosad]", "url": "http://hkgalden.com/face/hkg/sosad.gif" },
                { "id": "#oh#", "url": "http://hkgalden.com/face/hkg/surprise.gif" },
                { "id": ":P", "url": "http://hkgalden.com/face/hkg/tongue.gif" },
                { "id": ";-)", "url": "http://hkgalden.com/face/hkg/wink.gif" },
                { "id": "???", "url": "http://hkgalden.com/face/hkg/wonder2.gif" },
                { "id": "?_?", "url": "http://hkgalden.com/face/hkg/wonder.gif" },
                { "id": "[yipes]", "url": "http://hkgalden.com/face/hkg/yipes.gif" },
                { "id": "Z_Z", "url": "http://hkgalden.com/face/hkg/z.gif" },
                { "id": "#lol#", "url": "http://hkgalden.com/face/hkg/lol.gif" },
                ];

var iconRegexCodeList = [];
var iconCodeUrlList = [];
var iconUrlList = [];

RegExp.escape = function(text) {
    return text.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
};
for (var i = 0, len = iconList.length; i < len; i++) {
    iconRegexCodeList.push(RegExp.escape(iconList[i].id));
    iconCodeUrlList[iconList[i].id] = iconList[i].url;
    iconUrlList.push(iconList[i].url);
}

var iconCodeRegex = new RegExp("(" + iconRegexCodeList.join("|") + ")", "gi");

var colorCodeStartRegex = new RegExp("\\[#([a-fA-F0-9]{6})\\]", "gi");
var colorCodeEndRegex = new RegExp("\\[\\/#[a-fA-F0-9]{6}\\]", "gi");

var parseBBcodeColor = function (bbcode) {
    var afterStart = bbcode.replace(colorCodeStartRegex,
                                    function (match, colorCode, text, offset) {
                                    return '[color=' + colorCode + ']';
                                    }
                                    );
    
    var afterEnd = afterStart.replace(colorCodeEndRegex,
                                      function (match, colorCode, text, offset) {
                                      return '[/color]';
                                      }
                                      );
    return afterEnd;
};

var parseIcon = function (bbcode) {
    return bbcode.replace(iconCodeRegex,
                          function (match, iconCode, offset) {
                          return '[img]' + iconCodeUrlList[iconCode] + '[/img]';
                          }
                          );
};


function convertBBCodeToHTML(source) {
    source = parseIcon(parseBBcodeColor(source))
    var htmlResult = XBBCODE.process({text: source,removeMisalignedTags: false,addInLineBreaks: true});
    
    //consoleLog(htmlResult.html);
    
    handleConvertedBBCode(htmlResult.html);
}
