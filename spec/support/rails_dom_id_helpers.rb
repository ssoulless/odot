module RailsDomIdHelper
	def dom_id_for model
		["#", ActionView::RecordIdentifier.dom_id(model)].join
	end
end