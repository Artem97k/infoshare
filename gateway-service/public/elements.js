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
    <option value="a">Article</option>
    <option value="s">Series</option>
    <option value="p">People</option>
  </select><br>
  <input type="text" id="search_query">
  <input type="submit" id="search_submit" class="submit_b" value="Search">
</form>`;

const profile_page = `
<div class="profile_page">
  <p id="name"></p>
  <p id="surname"></p>
  <p id="email"></p>
  <p id="bio"></p>
  <a id="profile_edit"></a>
</div>`;

const pe_form = `
<form id="pe_form">
  Name<br>
  <input type="text" id="name">
  Surname<br>
  <input type="text" id="surname">
  Email<br>
  <input type="text" id="email">
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