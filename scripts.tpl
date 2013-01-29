{literal}

<!-- include jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>


<script type="text/javascript">
  SyntaxHighlighter.all();
</script>


<script type="text/javascript">
$('img').each(function(){
    src = ($(this).attr('src'));
    $(this).wrap($('<a class="imglink"></a>').attr('href', src));
});
</script>

<!--identify external links --> 
<script type="text/javascript">
$(document).ready(function () {
   $('a').filter(function () {
       return !this.href.match(/^mailto\:/) 
              && (this.hostname != location.hostname); 
   }).addClass('external');
});
</script>


{/literal}