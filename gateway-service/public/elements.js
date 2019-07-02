const su_form = `
<form id="su_form">
  Login:<br>
  <input type="text" id="login"><br>
  Password:<br>
  <input type="password"id="password"><br>
  Password confirmation:
  <input type="password"id="password2"><br>
  <p style="display: inline; color: red;"id="info_display"></p>
  <input type="submit" id="signup_submit" class="submit_b" value="Sign up">
 </form>`;

const si_form = `
<form id="si_form">
  Login:<br>
  <input type="text" id="login"><br>
  Password:<br>
  <input type="password"id="password"><br>
  <p style="display: inline;"id="info_display"></p>
  <input type="submit" id="signin_submit" class="submit_b" value="Sign in">
</form>`;

const cr_page = `
<div class="content">
<a class="tile" id="ar_create">Article</a><a class="tile" id="sr_create">Series</a>
</div>`;

const search_form = `
<form id="search_form">
  Search:
  <select>
    <option value="profile">People</option>
    <option value="series">Series</option>
    <option value="article">Article</option>
  </select><br>
  <input type="text" id="search_query">
  <p style="display: inline;"id="info_display"></p>
  <input type="submit" id="search_submit" class="submit_b" value="Search">
</form>`;

const profile_page = `
<div class="profile_page">
  <p><b>Name:</b></p>
  <p id="name"></p>
  <p><b>Surname:</b></p>
  <p id="surname"></p>
  <p><b>Email:</b></p>
  <p id="email"></p>
  <p><b>Bio:</b></p>
  <p id="bio"></p>
  <p style="display: inline;"id="info_display"></p>
</div>`;

const pe_form = `
<form id="pe_form">
  Name<br>
  <input type="text" id="name">
  Surname<br>
  <input type="text" id="surname">
  Email<br>
  <input type="email" id="email">
  Bio<br>
  <input type="text" id="bio"><br>
  <p style="display: inline;"id="info_display"></p>
  <input type="submit" id="profile_edit_submit" class="submit_b" value="Save changes">
</form>`;

const categories = [ 
  "Lorem", 
  "Ipsum", 
  "Dolor", 
  "Sit amet", 
  "Amet", 
  "Consectetur",
];

const search_result_page = `
<table id="search_display">
</table>`;

const ar_create_form = `
<form id="ar_create_form" style="width: 100%; margin-top: 10%;">
  Article name<br>
  <input type="text" id="name">
  Content<br>
  <textarea rows="20" style="width: 100%; resize: none;" id="content"></textarea>
  <p style="display: inline;"id="info_display"></p>
  <input type="submit" id="article_create_submit" class="submit_b" value="Create">
</form>`;

const article_page = `
<div class="article_page">
  <p><b>Name:</b></p>
  <p id="name"></p>
  <p><b>Content:</b></p>
  <p id="content"></p>
  <p style="display: inline;"id="info_display"></p>
</div>`;
