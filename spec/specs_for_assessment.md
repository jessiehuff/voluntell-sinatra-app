# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)--used Volunteer, Opportunity, Success_Story
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts), volunteer has_many opportunities and success_stories. Both opportunities and success_stories belong_to a volunteer
- [x] Include user accounts- volunteers sign in and login in
- [x] Ensure that users can't modify content created by other users- only the owner of an opportunity or story can edit or delete it
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying- opportunities and success_stories can be created, read, updated, and destroyed
- [x] Include user input validations- makes sure inputs aren't empty, requires specific fields
- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
