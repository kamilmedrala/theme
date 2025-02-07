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
<div class="ps_currencyselector cursor-pointer float-right text-center relative m-4 tablet-narrow:my-1 mx-2 tablet-narrow:mx-0 flex-auto">
  <div class="currency-selector dropdown ttdropdown js-dropdown">
    <span id="currency-selector-label" class="hidden">{l s='Currency:' d='Shop.Theme.Global'}</span>
    <button data-target="#" data-toggle="dropdown" class="hidden-sm-down" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Currency dropdown' d='Shop.Theme.Global'}">
      <span class="expand-more _gray-darker">{$current_currency.iso_code}</span>
      <i class="material-icons expand-more">
        <svg xmlns="http://www.w3.org/2000/svg" height="13px" viewBox="0 0 24 24" width="24px" fill="#888"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6-6-6 1.41-1.41z"/></svg>
      </i>
      <i class="material-icons expand-less">
        <svg xmlns="http://www.w3.org/2000/svg" height="13px" viewBox="0 0 24 24" width="24px" fill="#888"><path d="M0 0h24v24H0z" fill="none"/><path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/></svg>
      </i>
    </button>
    <ul class="dropdown-menu hidden-sm-down" aria-labelledby="currency-selector-label">
      {foreach from=$currencies item=currency}
        <li {if $currency.current} class="current" {/if}>
          <a title="{$currency.name}" rel="nofollow" href="{$currency.url}" class="dropdown-item">{$currency.iso_code}</a>
        </li>
      {/foreach}
    </ul>
    <select class="link hidden-md-up appearance-none w-full tablet-narrow:w-auto" aria-labelledby="currency-selector-label">
      {foreach from=$currencies item=currency}
        <option value="{$currency.url}"{if $currency.current} selected="selected"{/if}>{$currency.iso_code}</option>
      {/foreach}
    </select>
  </div>
</div>

<div class="hidden tablet-narrow:block float-right border-l border-gray-light m-auto h-6 my-4"></div>
