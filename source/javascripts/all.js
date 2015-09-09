//= require_tree .

var mobileNav = document.querySelector(".js-mobile-nav");

mobileNav.addEventListener("click", clickToggle, false);

function clickToggle(event){
  var toggleLink = this;
  var target = document.querySelector("." + toggleLink.getAttribute("data-target"));
  var targetActiveClass = getActiveClass(target);
  var activeClass = getActiveClass(toggleLink);
  toggleLink.classList.toggle(activeClass);
  target.classList.toggle(targetActiveClass);
}

function getActiveClass(selector){
  return selector.classList[0] + "--active";
}

hljs.initHighlightingOnLoad();
