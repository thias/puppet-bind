require 'spec_helper'

describe 'bind::server::file' do
	let (:params) {{
		:title => 'example.com',
		:source => 'puppet:///modules/bind/named.empty'
	}}
end