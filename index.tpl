{config_load file='templates/constants.conf'}

{capture name="ROOT" assign="ROOT"}{if $smarty.server.SERVER_PORT == 80}http://{$smarty.server.SERVER_NAME}/{#ROOT_DIR#}{else}http://{$smarty.server.SERVER_NAME}:{$smarty.server.SERVER_PORT}/{#ROOT_DIR#}{/if}{/capture}


{include file="header.tpl" title="Autonomic Computing in Practice"}

{include file="content/{$page}.md" title="iCasa Simulator" assign="article"}


<div class="main-container">
    <div class="main wrapper clearfix">
      

      {$article|markdown}

      {if isset($section) }
      <aside>
        <h3>In the same section</h3>
        {include file="content/section-{$section}.md" assign="section"}
        {$section|markdown}
      </aside>
      {/if}

<!--    <div class="push"></div>  -->
    </div> <!-- #main -->
</div> <!-- #main-container -->

{include file="footer.tpl"}
