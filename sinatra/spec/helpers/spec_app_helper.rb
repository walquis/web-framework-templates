module SpecAppHelper
  def header_with_login login
    { 'HTTP_SSO_USER' => login }
  end
end
