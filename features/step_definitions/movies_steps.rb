
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/^I assign "([^"]*)" as the director for "([^"]*)"$/) do |director, movie_title|
  movie = Movie.find_by(title: movie_title)
  visit edit_movie_path(movie)
  fill_in 'Director', with: director
  #save_and_open_page
  click_button 'Update Movie Info'
end

When(/^I press "([^"]*)"$/) do |button|
  click_button button
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |title, director|
  movie = Movie.find_by(title: movie_title)
  expect(movie.director).to eq(director)
end

Given(/^I am on the details page for "([^"]*)"$/) do |title|
  movie = Movie.find_by(title: title)
  visit movie_path(movie)
end

When(/^I follow "Find Movies With Same Director"$/) do
  click_link "Find Movies With Same Director"
end

Then(/^I should be on the Similar Movies page for "([^"]*)"$/) do |title|
  movie = Movie.find_by(title: title)
  expect(current_path).to eq(similar_movies_path(movie))
end

Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should not see "([^"]*)"$/) do |content|
  expect(page).to have_no_content(content)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then(/^I should be on the home page$/) do
  expect(current_path).to eq(root_path)
end

When(/^I click on "Edit"$/) do
  click_link 'Edit'
end

When(/^I fill in "Director" with "([^"]*)"$/) do |director_name|
  fill_in 'movie[director]', with: director_name
end

Then(/^the director of "([^"]*)" shoud be "([^"]*)"$/) do |movie_title, director|
  movie = Movie.find_by(title: movie_title)
  expect(movie.director).to eq(director)
end
