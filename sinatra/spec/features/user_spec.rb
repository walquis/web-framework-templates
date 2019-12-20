describe "User" do

  context "when in admin group" do
    it 'shows the logged in index page' do
      get '/', {}, header_with_login('dduck')
      expect(last_response.body).to match('Logged in as')
    end
  end

end
