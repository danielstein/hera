require 'test_helper'
require 'time'

class WebServicesGetControllerTest < ActionController::TestCase

	test "should get checklist" do

		24.times do |n|
			tmp = equip_types(:"equip_type_#{n}")

			begin
				get :get_checklist, :equip_type => tmp.id
			rescue Exception => e
				assert_nil e, e.to_s
			end

			checklist = ChecklistItem.where(:equip_type_id => tmp.id)

			assert_response :success

			begin
				resp = JSON.parse(@response.body)
			rescue Exception => e
				assert_nil e, "Not a JSON response: #{e}"
			end

			items = []

			checklist.each do |item|
				items.append(item)
			end

			i = 0
			resp.each do |resp_id, resp_question|
				if(i == 0)
					assert_equal "message", resp_id, "Wrong output value"
					assert_equal "success", resp_question, "Not succeending for valid checklist"
				else
					assert_equal items[i-1].id.to_s, resp_id, "Invalid value (Maybe different sequence?)"
					assert_equal items[i-1].question.to_s, resp_question, "Invalid value (Maybe different sequence?)"
				end
				
				i = i + 1
			end
		end
	end

	test "should not get checklist" do
		
		#try to get with a invalid id...
		begin
			get :get_checklist, :equip_type => "0000000"
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_response :success

		begin
			resp = JSON.parse(@response.body)
		rescue Exception => e
			assert_nil e, "Not a JSON response: #{e}"
		end

		i = 0
		resp.each do |resp_id, resp_question|
			if(i == 0)
				assert_equal "message", resp_id, "Wrong value"
				assert_equal "error", resp_question, "Succeending for invalid checklist"
			else
				assert_nil resp_id, "Something when should have nothing: #{resp_id}"
				assert_nil resp_question, "Something when should have nothing: #{resp_question}"
			end
			
			i = i + 1
		end		

	end

	test "should get building name" do

		456.times do |n|
			tmp = buildings(:"building_#{n}")
			
			begin
				get :get_building_name, :idAtlas => tmp.idAtlas
			rescue Exception => e
				assert_nil e, e.to_s
			end

			assert_response :success

			begin
				resp = JSON.parse(@response.body)
			rescue Exception => e
				assert_nil e, "Not a JSON response: #{e}"
			end

			i = 0
			resp.each do |resp_id, resp_answer|
				if(i == 0)
					assert_equal "message", resp_id, "Wrong value"
					assert_equal "sucesso", resp_answer, "Wrong value"
				else
					assert_equal "buildingName", resp_id, "Wrong value"
					assert_equal tmp.name.to_s, resp_answer, "Invalid building name"
				end
			
				i = i + 1
			end
		end

	end

	test "should not get building name" do
		
		#try to get with a invalid id...
		begin
			get :get_building_name, :idAtlas => "0000000"
		rescue Exception => e
			assert_nil e, e.to_s
		end

		assert_response :success

		begin
			resp = JSON.parse(@response.body)
		rescue Exception => e
			assert_nil e, "Not a JSON response: #{e}"
		end

		i = 0
		resp.each do |resp_id, resp_answer|
			if(i == 0)
				assert_equal "message", resp_id, "Wrong value"
				assert_equal "error", resp_answer, "Wrong value"
			else
				assert_nil resp_id, "Something when should have nothing: #{resp_id}"
				assert_nil resp_answer, "Something when should have nothing: #{resp_answer}"
			end
		
			i = i + 1
		end
	end




end
