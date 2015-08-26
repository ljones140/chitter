require 'spec_helper'

feature 'creating peeps' do

  scenario 'I can not peep when not logged in' do

    visit '/peeps'
    expect(page).not_to have_content('enter peep')
    expect(page).to have_content('you must be logged in to peep')
  end

  scenario ' I can peep when logged in' do

    time = Time.local(2015, 8, 16, 18, 0)
    Timecop.freeze(time)

    user = create(:user)
    sign_in_as(user)
    visit '/peeps'
    expect(page).not_to have_content('you must be logged in to peep')
    fill_in 'peep_body', with: 'this is a peep'
    click_button 'peep!'
      expect(page). to have_content ('this is a peep')
      expect(page). to have_content ("#{user.user_name}")
      expect(page).to have_content ("18:00 16/08/2015")
  end

  scenario 'view all peeps by time decending' do

    peep = create(:peep)
    peep_second = create(:peep_second)
    user = create(:user)
    peeps = [peep, peep_second].map do |peep_post|
      peep_post.user_id = user.id
      peep_post.save
      peep_post
    end

    visit '/peeps'
    peeps.each { |peep_post| expect(page).to have_content(peep_post.body) }
    expect(peep_second.body).to appear_before(peep.body)
  end

  scenario 'home redirects to peeps' do
    visit '/'
    expect(current_path).to eq('/peeps')
  end
end

