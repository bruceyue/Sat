class HomeController < ApplicationController

  caches_page :index, :aboutus, :coolsite

  def index
  end

  def aboutus
  end

  def coolsite
  	@ror_sites = Site.where(is_active: true, stype: 'ror')
  	@sf_sites = Site.where(is_active: true, stype: 'sf')
  end
end
