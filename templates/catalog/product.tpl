{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file=$layout}

{block name='head_seo' prepend}
  <link rel="canonical" href="{$product.canonical_url}">
{/block}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta property="og:url" content="{$urls.current_url}">
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:site_name" content="{$shop.name}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:image" content="{$product.cover.large.url}">
  <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
  <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
  <meta property="product:price:amount" content="{$product.price_amount}">
  <meta property="product:price:currency" content="{$currency.iso_code}">
  {if $product.show_price}
		<meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
		<meta property="product:pretax_price:currency" content="{$currency.iso_code}">
		<meta property="product:price:amount" content="{$product.price_amount}">
		<meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='content'}

  <section id="main" itemscope itemtype="https://schema.org/Product">
    <meta itemprop="url" content="{$product.url}">
      <div class="col-md-5 pb-left-column">
        {block name='page_content_container'}
          <section class="page-content" id="content">
            {block name='page_content'}
			<!-- @todo: use include file='catalog/_partials/product-flags.tpl'} -->
              {block name='product_flags'}
                <ul class="product-flags">
                  {foreach from=$product.flags item=flag}
                    <li class="product-flag {$flag.type}">{$flag.label}</li>
                  {/foreach}
                </ul>
              {/block}

              {block name='product_cover_thumbnails'}
                {include file='catalog/_partials/product-cover-thumbnails.tpl'}
              {/block}
              <div class="scroll-box-arrows">
                <i class="material-icons left">keyboard_arrow_left</i>
                <i class="material-icons right">keyboard_arrow_right</i>
              </div>

            {/block}
          </section>
        {/block}
        </div>
        <div class="col-md-7 pb-right-column">    
          {block name='page_header_container'}
            {block name='page_header'}
              <h1 class="h1 tt-producttitle" itemprop="name">{block name='page_title'}{$product.name}{/block}</h1>
            {/block}
          {/block}
	
		  	{block name='product_comment'}
				{capture name='displayTtProductExtra'}{hook h='displayTtProductExtra'}{/capture}
				{if $smarty.capture.displayTtProductExtra}
				{$smarty.capture.displayTtProductExtra nofilter}
				{/if}
			{/block}

          {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block}

          <div class="product-information">
            {block name='product_description_short'}
              <div id="product-description-short-{$product.id}" itemprop="description">{$product.description_short nofilter}</div>
            {/block}

            {if $product.is_customizable && count($product.customizations.fields)}
              {block name='product_customization'}
                {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
              {/block}
            {/if}

            <div class="product-actions">

            {* LOYALTY PROGRAM - > GET DATA FROM POPUP TO ADD TO CART
              {if Configuration::get('PSHOW_LP_PRODUCT_EXCHANGE')}

                          <button data-id_product="3" data-id-product-attribute="576" class="btn btn-primary exchangeButton" type="button">Exchange</button>

                            <div id="exchangePanel" class="modal fade" role="dialog">
                              <div class="modal-dialog">
                                  <div class="modal-content">
                                      <div class="modal-body">
                                          <button type="button" class="close" data-dismiss="modal">×</button>
                                          <h3 class="modal-title">Exchange panel</h3>
                                          <div style="display: none" id="voucherError" class="alert alert-danger"></div>
                                          <div id="productDetails">
                                              <h3>Are you sure, you want get this product?</h3>
                                              <div id="exConfirmation"></div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                            </div>

                            <script>

                              document.addEventListener("DOMContentLoaded", function(event) { 
                                jQuery(document).on('click', '.exchangeButton', function () {
                                  let button = jQuery(this);
                                  jQuery(this).addClass('disabled');
                                  setTimeout(function () {
                                      jQuery.ajax({
                                          url: "/module/pshowloyaltyprogram/exchange",
                                          data: {
                                              ajaxAction: 'doExchange',
                                              idProduct: button.data('id_product'),
                                          },
                                          type: 'post',
                                          success: function (data) {
                                              jQuery('#exConfirmation').html(data);
                                              debugger;
                                              jQuery('#exConfirmation').insertAfter('<a href="/module/pshowloyaltyprogram/exchange?ajax=true&action=confirmExchange&idProduct=217&&id_product_ex=3"> NAGRODA ZA PUNKTY </a>')
                                              jQuery('#exchangePanel').modal('show');
                                              button.removeClass('disabled');
                                          },
                                      });
                                  }, 20);
                                });
                              });
                            </script>
                          {/if}
                *}
            

              {block name='product_buy'}
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">

                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}

                  {block name='product_pack'}
                    {if $packItems}
                      <section class="product-pack">
                        <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
                        {foreach from=$packItems item="product_pack"}
                          {block name='product_miniature'}
                            {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                          {/block}
                        {/foreach}
                    </section>
                    {/if}
                  {/block}

                  {block name='product_discounts'}
                    {include file='catalog/_partials/product-discounts.tpl'}
                  {/block}

                  {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                  {/block}

                  {block name='product_additional_info'}
                        {include file='catalog/_partials/product-additional-info.tpl'}
                  {/block}
                  {* Input to refresh product HTML removed, block kept for compatibility with themes *}
					        {block name='product_refresh'}{/block}

                </form>
              {/block}
            </div>

            {block name='hook_display_reassurance'}
              {hook h='displayReassurance'}
            {/block}
           
        </div>
      </div>
	  <div class="ttproductpagetab">
	    {block name='product_tabs'}
              <div class="tabs">
                <ul class="nav nav-tabs" role="tablist">
                  {if $product.description}
                    <li class="nav-item">
                       <a
                         class="nav-link{if $product.description} active{/if}"
                         data-toggle="tab"
                         href="#description"
                         role="tab"
                         aria-controls="description"
                         {if $product.description} aria-selected="true"{/if}><h3 class="tab-title">{l s='Description' d='Shop.Theme.Catalog'}</h3></a>
                    </li>
                  {/if}
                  <li class="nav-item">
                    <a
                      class="nav-link{if !$product.description} active{/if}"
                      data-toggle="tab"
                      href="#product-details"
                      role="tab"
                      aria-controls="product-details"
                      {if !$product.description} aria-selected="true"{/if}><h3 class="tab-title">{l s='Product Details' d='Shop.Theme.Catalog'}</h3></a>
                  </li>
                  {if $product.attachments}
                    <li class="nav-item">
                      <a
                        class="nav-link"
                        data-toggle="tab"
                        href="#attachments"
                        role="tab"
                        aria-controls="attachments"><h3 class="tab-title">{l s='Attachments' d='Shop.Theme.Catalog'}</h3></a>
                    </li>
                  {/if}
                  {foreach from=$product.extraContent item=extra key=extraKey}
                    <li class="nav-item">
                      <a
                        class="nav-link"
                        data-toggle="tab"
                        href="#extra-{$extraKey}"
                        role="tab"
                        aria-controls="extra-{$extraKey}"><h3 class="tab-title">{$extra.title}</h3></a>
                    </li>
                  {/foreach}
				{block name='product_comment_tab'}
					{capture name='displayTtProductTab'}{hook h='displayTtProductTab'}{/capture}
						{if $smarty.capture.displayTtProductTab}
						{$smarty.capture.displayTtProductTab nofilter}
					{/if}
				{/block}
                </ul>

                <div class="tab-content" id="tab-content">
                 <div class="tab-pane fade in{if $product.description} active{/if}" id="description" role="tabpanel">
                   {block name='product_description'}
                     <div class="product-description">{$product.description nofilter}</div>
                   {/block}
                 </div>

                 {block name='product_details'}
                   {include file='catalog/_partials/product-details.tpl'}
                 {/block}

                 {block name='product_attachments'}
                   {if $product.attachments}
                    <div class="tab-pane fade in" id="attachments" role="tabpanel">
                       <section class="product-attachments">
                         <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
                         {foreach from=$product.attachments item=attachment}
                           <div class="attachment">
                             <h4><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h4>
                             <p>{$attachment.description}</p
                             ><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                               {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                             </a>
                           </div>
                         {/foreach}
                       </section>
                     </div>
                   {/if}
                 {/block}

                 {foreach from=$product.extraContent item=extra key=extraKey}
                 <div class="tab-pane fade in {$extra.attr.class}" id="extra-{$extraKey}" role="tabpanel" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
                   {$extra.content nofilter}
                 </div>
                 {/foreach}
				 {block name='product_comment_tab_content'}
					{capture name='displayTtProductTabContent'}{hook h='displayTtProductTabContent'}{/capture}
					{if $smarty.capture.displayTtProductTabContent}
						{$smarty.capture.displayTtProductTabContent nofilter}
					{/if}
				{/block}
              </div>  
            </div>
          {/block}
		  </div>
	
    {block name='product_accessories'}
      {if $accessories}
        <section class="product-accessories clearfix">
			{assign var="tt_cnt" value="1"}
			{assign var="tt_total" value="0"}
			{foreach from=$accessories item="product_accessory"}
				{$tt_total = $tt_total+1}
			{/foreach}
		<div class="tt-titletab">
          <h3 class="tt-title">{l s='You might also like' d='Shop.Theme.Catalog'}</h3>
		</div>
		{if $tt_total > 5}
			<div class="customNavigation">
				<a class="btn prev accessories_prev">{l s='Prev' d='Modules.accessories.Shop'}</a>
				<a class="btn next accessories_next">{l s='Next' d='Modules.accessories.Shop'}</a>
			</div>
  		  {/if}
		  <div class="row">
          <div class="products">
            {foreach from=$accessories item="product_accessory"}
              {block name='product_miniature'}
                {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
              {/block}
            {/foreach}
          </div>
		  </div>
        </section>
      {/if}
    {/block}

    {block name='product_footer'}
      {hook h='displayFooterProduct' product=$product category=$category}
    {/block}

    {block name='product_images_modal'}
      {include file='catalog/_partials/product-images-modal.tpl'}
    {/block}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}
  </section>
<style>.product-description img{
	float:none!important;
}</style>
{/block}
