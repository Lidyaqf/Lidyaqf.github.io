<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
<meta name="theme-color" content="{{ theme.android_chrome_color }}">
<meta name="generator" content="Hexo {{ hexo_version }}">
<style>
    .contain {
      position: relative;
      width: 100%;
      height: 50px;
      background: #f0f0f0;
      overflow: hidden;
    }
  
    .danmaku {
      position: absolute;
      white-space: nowrap;
      top: 50%;
      transform: translateY(-50%);
      font-size: 14px;
      color: #333;
      animation: moveLeft 15s linear forwards;
    }
  
    .danmaku.paused {
      animation-play-state: paused;
    }
  
    @keyframes moveLeft {
      from {
        left: 100%;
      }
      to {
        left: -100%;
      }
    }
  </style>


{%- if theme.favicon.apple_touch_icon %}
  <link rel="apple-touch-icon" sizes="180x180" href="{{ url_for(theme.favicon.apple_touch_icon) }}">
{%- endif %}
{%- if theme.favicon.medium %}
  <link rel="icon" type="image/png" sizes="32x32" href="{{ url_for(theme.favicon.medium) }}">
{%- endif %}
{%- if theme.favicon.small %}
  <link rel="icon" type="image/png" sizes="16x16" href="{{ url_for(theme.favicon.small) }}">
{%- endif %}
{%- if theme.favicon.safari_pinned_tab %}
  <link rel="mask-icon" href="{{ url_for(theme.favicon.safari_pinned_tab) }}" color="{{ theme.android_chrome_color }}">
{%- endif %}
{%- if theme.favicon.android_manifest %}
  <link rel="manifest" href="{{ url_for(theme.favicon.android_manifest) }}">
{%- endif %}
{%- if theme.favicon.ms_browserconfig %}
  <meta name="msapplication-config" content="{{ url_for(theme.favicon.ms_browserconfig) }}">
{%- endif %}

{%- if theme.disable_baidu_transformation %}
  <meta http-equiv="Cache-Control" content="no-transform">
  <meta http-equiv="Cache-Control" content="no-siteapp">
{%- endif %}
{%- if theme.google_site_verification %}
  <meta name="google-site-verification" content="{{ theme.google_site_verification }}">
{%- endif %}
{%- if theme.bing_site_verification %}
  <meta name="msvalidate.01" content="{{ theme.bing_site_verification }}">
{%- endif %}
{%- if theme.yandex_site_verification %}
  <meta name="yandex-verification" content="{{ theme.yandex_site_verification }}">
{%- endif %}
{%- if theme.baidu_site_verification %}
  <meta name="baidu-site-verification" content="{{ theme.baidu_site_verification }}">
{%- endif %}
<meta name="baidu_union_verify" content="4c95743ab0ae1a7dcfbc5c20c004854b">

<link rel="stylesheet" href="{{ url_for(theme.css) }}/main.css">

{{ next_font() }}

{%- set font_awesome_uri = theme.vendors.fontawesome or next_vendors('font-awesome/css/all.min.css') %}
<link rel="stylesheet" href="{{ font_awesome_uri }}">

{%- if theme.fancybox %}
  {%- set fancybox_css_uri = theme.vendors.fancybox_css or next_vendors('//cdn.jsdelivr.net/gh/fancyapps/fancybox@3/dist/jquery.fancybox.min.css') %}
  <link rel="stylesheet" href="{{ fancybox_css_uri }}">
{%- endif %}



{%- if theme.pace.enable %}
  {%- set pace_css_uri = theme.vendors.pace_css or next_vendors('pace/pace-theme-' + theme.pace.theme + '.min.css') %}
  {%- set pace_js_uri = theme.vendors.pace or next_vendors('pace/pace.min.js') %}
  <link rel="stylesheet" href="{{ pace_css_uri }}">
  <script src="{{ pace_js_uri }}"></script>
{%- endif %}

{{ next_config() }}




{#   <div class="contain" id="danmakuContainer"></div>
  
  <script>
  const messages = [
      '如果对喜欢的东西无法放弃，就来一次逆光飞翔',
      '你以为你什么都不会，等你失去了所有的依靠，就什么都会了',
      '世间有四种东西无法挽回：说出去的话、射出去的箭、流逝的时间，还有错过的机会',
      '做你害怕的事，然后你会发现，不过如此',
      '要怎么说呢，要承认生活里失望和错序是正常的，欢喜与顺遂才是意外',
      '人不是因为年老而停止了游戏，而是因为停止了游戏才变老的',
      '认真玩耍',
      '这个世界上既没有侥幸，也没有童话故事，更没有坐享其成',
      '生气的原因不在于别人做了什么，而在于我怎么看待对方及其行为',
      '是什么曾经拯救过你，你最好就用它来更好地拯救这个世界',
      '美国小说家海明威给“不道德”下的定义是：“事后觉得不好的任何事情',
      '有些花注定会被吹散在天涯，但也说不定很久后就被吹落在同一处天涯',
      '哪有那么多的久别重逢，只不过是有人用心良苦罢了',
      '找出你最擅长的事情，然后持之以恒、乐此不疲地去把它做好',
      '海洋是天空的玩笑，星星都在海里摇',
      '哪里会有什么终身有效的标准答案呢',
      '我会陪你一起老去，在你看不到的地方',
      '如果跟我道别之后你能过得更好，那么我真心实意给你我全部的祝愿',
      '没有跌宕起伏的人生，过着多没意思',
      '两个人在一起最好的状态，应该是一场相互的成全和彼此的仰视，而非没有原则地迁就和将理想掐死',
      '我慢慢地、慢慢地了解到，所谓父女母子一场，只不过意味着，你和他们的缘分就是今生今世不断地目送他的背影渐行渐远',
      '尼采的话：“那没能杀死我的，会让我更强壮',
      '“曾经是”也是一种“是”，甚至更为确定',
      '你原先以为的“目的”未必是这件事真正的“目的”',
      '生活需要一些格格不入',
      '给你20次投资机会，用完就没有',
      '如果你的目标是让核心概念成为自身应用知识的一部分，唯一的办法就是反复实践',
      '不能哭，眼泪会冻住',
      '在你看不到的角落，多的是你不知道的事',
      '也许你不是最发光的那一个，但是也照到了该照亮的地方',
      '谦卑和感恩是解决一切问题的万灵丹',
      '三毛曾说：“等待和犹豫是这个世界上最无情的杀手。”',
      '我们的思想总是在过去和未来，但我们的身体和呼吸却永远是在当下的',
      '让人倾家荡产的旅行才是最最好的一种投资',
      '有时想到人生尽头，若孟婆汤也是塑料饮料瓶包装的那种，拧开瓶盖，“谢谢参与”和“再来一次”，真不知道哪个更可怕',
      '上帝让右手成为右手，就是对右手最高的奖赏；同理，上帝让善人成为善人，也就是对善人的最高奖赏',
      '《大学》云：知止而后有定，定而后能静，静而后能安，安而后能虑，虑而后能得',
      '这世界上缺的不是完美的人，而是从心底给出的正义、真心、无畏和同情',
      '健忘是一种超能力，会让我们耿耿于怀的心事转眼就忘掉，才得以继续乐观地面对我们崭新的一天',
      '世间情动，不过盛夏白瓷梅子汤，碎冰碰壁当啷响。不负对方就好，不负此生很难',
      '同时间赛跑，与病魔较量',
      '运动是解压的方式，好像有些人觉得炒菜解压一样',
      '生活中不可能一直绿灯通行,得感谢红灯的警示和黄灯的缓冲',
      '当你觉得自己不行的时候，你就去走一下人行横道线，这样你就变成了一个行人'
  ];
  
  let messageQueue = [...messages];
  const danmakuContainer = document.getElementById('danmakuContainer');
  
  function addDanmaku(text) {
      const danmaku = document.createElement('div');
      danmaku.className = 'danmaku';
      danmaku.innerText = text;
      danmaku.style.color = getRandomColor();
      danmaku.style.zIndex = Math.floor(Math.random() * 10);
  
      danmaku.addEventListener('mouseover', () => {
          danmaku.classList.add('paused');
      });
      danmaku.addEventListener('mouseout', () => {
          danmaku.classList.remove('paused');
      });
  
      danmakuContainer.appendChild(danmaku);
  
      // 动画结束后自动移除，避免堆积
      danmaku.addEventListener('animationend', () => {
          danmakuContainer.removeChild(danmaku);
      });
  }
  
let currentIndex = 0;

function getNextMessage() {
    if (messageQueue.length === 0) {
        messageQueue = [...messages];
    }
    const message = messageQueue[currentIndex];
    currentIndex++;
    if (currentIndex >= messageQueue.length) {
        currentIndex = 0; // 走完一遍，从头开始
    }
    return message;
}

  function getRandomColor() {
      const letters = '0123456789ABCDEF';
      let color = '#';
      for (let i = 0; i < 6; i++) {
          color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
  }
  
  setInterval(() => {
      const randomMessage = getNextMessage();
      addDanmaku(randomMessage);
  }, 4000); // 每隔3秒一条，防止重叠
  </script>
  #}
