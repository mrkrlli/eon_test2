describe 'purchase/subscribe.html.erb' do
  it 'displays the stripe form with proper action and url' do
    render

    expect(rendered).to have_css("form[action='#{purchase_process_path}'][method='post']")
  end
end
