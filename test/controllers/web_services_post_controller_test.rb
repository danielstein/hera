require 'test_helper'
require 'time'

class WebServicesPostControllerTest < ActionController::TestCase

	test "should post" do
		500.times do |n|
			tmp = equipment(:"equip_#{n}")
		
			if(tmp.is_there)
				is_there = "1";
			else
				is_there = "0";
			end

			if(tmp.creation_date.day.to_i <= 9) then
				day = "0" + tmp.creation_date.day.to_s
			else
				day = tmp.creation_date.day.to_s
			end

			if(tmp.creation_date.month.to_i <= 9) then
				month = "0" + tmp.creation_date.month.to_s
			else
				month = tmp.creation_date.month.to_s
			end

			if(tmp.creation_date.hour.to_i <= 9) then
				hour = "0" + tmp.creation_date.hour.to_s
			else
				hour = tmp.creation_date.hour.to_s
			end

			if(tmp.creation_date.min.to_i <= 9) then
				min = "0" + tmp.creation_date.min.to_s
			else
				min = tmp.creation_date.min.to_s
			end

			if(tmp.creation_date.sec.to_i <= 9) then
				sec = "0" + tmp.creation_date.sec.to_s
			else
				sec = tmp.creation_date.sec.to_s
			end

			date = day + "-" + month + "-" + tmp.creation_date.year.to_s + "_" + hour + "-" + min + "-" + sec
			
			begin
				post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => date, :tipo => tmp.equip_type.id, :existe => is_there
			rescue Exception => e
				puts "Exception error"
				puts e
			end

			assert_response :success
			equip = Equipment.where(:building_id => tmp.building.idAtlas, :name => tmp.name, :creation_date => tmp.creation_date , :equip_type_id => tmp.equip_type.id, :is_there => is_there).first
			assert_nil assigns(:equipment), "Nothing saved in the database"
			assert_not_nil equip, "Equipment not found. (building: #{tmp.building.idAtlas} , name: #{tmp.name}, creation: #{tmp.creation_date}, type_id: #{tmp.equip_type.id}, is_there: #{is_there})"
		end   
	end

	test "should not post" do
		t = Time.now
		n = rand(t.to_f) % 500

		tmp = equipment(:"equip_#{n}")
		
		if(tmp.is_there)
			is_there = "1";
		else
			is_there = "0";
		end

		if(tmp.creation_date.day.to_i <= 9) then
			day = "0" + tmp.creation_date.day.to_s
		else
			day = tmp.creation_date.day.to_s
		end

		if(tmp.creation_date.month.to_i <= 9) then
			month = "0" + tmp.creation_date.month.to_s
		else
			month = tmp.creation_date.month.to_s
		end

		if(tmp.creation_date.hour.to_i <= 9) then
			hour = "0" + tmp.creation_date.hour.to_s
		else
			hour = tmp.creation_date.hour.to_s
		end

		if(tmp.creation_date.min.to_i <= 9) then
			min = "0" + tmp.creation_date.min.to_s
		else
			min = tmp.creation_date.min.to_s
		end

		if(tmp.creation_date.sec.to_i <= 9) then
			sec = "0" + tmp.creation_date.sec.to_s
		else
			sec = tmp.creation_date.sec.to_s
		end

		date = day + "-" + month + "-" + tmp.creation_date.year.to_s + "_" + hour + "-" + min + "-" + sec
		

		#missing parameters...
		#missing 1 param at a time
		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => date, :tipo => tmp.equip_type.id
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment) #nothing was saved

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => date, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment) #nothing was saved

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment) #nothing was saved

		begin
			post :web_post, :idP => tmp.building.idAtlas, :data => date, :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment) #nothing was saved

		begin
			post :web_post, :desc => tmp.name, :data => date, :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment) #nothing was saved

		#wrong values for parameters...

		#building does not exist
		begin
			post :web_post, :idP => "3018", :desc => tmp.name, :data => date, :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment)

		#date is invalid
		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "32-07-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where day > 31"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "00-07-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where day < 01"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-00-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where month < 01"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-13-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where month > 12"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-11-1933_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where year is before 1934"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-11-1991_24-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where hour > 23"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-11-1991_11-60-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where minute > 59"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "11-11-1991_11-00-60", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Cannot save date where minute > 59"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "31-02-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "You must be careful in February!"

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "31-03-1991_11-11-11", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "April has only 30 days..."

		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => "20-03-2100_10-10-10", :tipo => tmp.equip_type.id, :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Equipment cannot be created in future!"


		#Type doesn't exists
		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => date, :tipo => "000000000", :existe => is_there
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Equipment type does not exists"

		#wrong is_there
		begin
			post :web_post, :idP => tmp.building.idAtlas, :desc => tmp.name, :data => date, :tipo => tmp.equip_type.id, :existe => "3"
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_nil assigns(:equipment), "Accepting wrong parameter for is_there"

	end

end
