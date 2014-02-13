require 'net/http'
require 'rexml/text'
require "rexml/document"
require 'pg'
require 'rest-client'
require 'nokogiri'
include REXML

class WebServicesGetController < ApplicationController


  #retorna uma lista de perguntas para um dado tipo de equipamento.
  def get_checklist
    equip_type = if EquipType.exists?(params[:equip_type]) then EquipType.find(params[:equip_type]) else nil end
    checklist = if equip_type then equip_type.checklist_items else nil end
    message = Hash.new
    message["message"] = if checklist then "success" else "error" end
    if checklist then
      checklist.to_enum.with_index(1).each do |i, index|
        #puts i.question
        message.merge!({i.id => i.question})
      end
     end
     #puts message
     render json: message

  end

  #retorna o nome do prédio dado o seu idAtlas
  def get_building_name
    buildingName = Building.where(:idAtlas => params[:idAtlas]).first.name if Building.exists?(:idAtlas => params[:idAtlas])
    message = Hash.new
    message["message"] = "#{buildingName.blank? ? "error": "sucesso" }"
    message["buildingName"] = buildingName.to_s
    render json: message
  end

end