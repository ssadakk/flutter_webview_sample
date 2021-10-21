/*!
*  @date 2019/10/22
*  @file selvy.js
*  @author SELVAS AI
*
*  Copyright (c) 2019 SELVAS AI Inc. All rights reserved.
*/

  function move(id) {
    var offset = $("#" + id).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
  }

  function select(id) {
    $('#' + id).tab('show');
  }

  function include(id) {
    $("#" + id).load("/common/" + id + ".html");
  }

  function goto(hash) {
    var hashes = hash.split('&');
    var url = hashes[0];
    var command = hashes[1];

    if (command) {
      var commands = command.split('-');
      var cmd = commands[0];
      var option = commands[1];

      if (cmd === "tab") {
        $('.nav-tabs a[href="#' + option + '"]').tab('show');
      } else if (cmd === "select") {
        select(option);
      } else if (cmd === "scroll") {
        // nothing to do
      }
    }

    if (url) {
      move(url.split('#')[1]);
    }
  }

  // for backward event of browser
  function locationHashChanged() {
    if (window.location.hash) {
      goto(window.location.hash);
    }
  }

  window.onhashchange = locationHashChanged;

  $('#sidebar_menu a').on('click', function (e) {
    $(this).tab('show');
  });

  $(document).ready(function(event) {
    if (window.location.hash) {
      goto(window.location.hash);
    }
  });
