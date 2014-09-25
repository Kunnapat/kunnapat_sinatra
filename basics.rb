#Kunnapat Rungruangsatien 5631216321
#Patchara Vanthongkam 5631285621

require 'sinatra'
require 'timezone'

get '/'  do
	erb :form
end

post '/city' do
	input_city_name = params[:input]
	time_zones = Timezone::Zone.names
	
	begin
	if (input_city_name.include?" ")
		multi_word = input_city_name.split(' ')
		first_word = multi_word[0]
		second_word = multi_word[1]
		city = time_zones.find{ |e| /#{first_word}_#{second_word}/ =~ e}
	else  
		city = time_zones.find{ |e| /#{input_city_name}/ =~ e}
	end
	
	timezone = Timezone::Zone.new :zone => city
	show_time = timezone.time Time.now
	time = show_time.to_s.split(' ')
	real_time = time[1]
	hours = real_time[0,2].to_i
	morning_hours = real_time[0,2]
	mins = real_time[2..4]

	if hours>12&&hours<=23
		afternoon = (hours-12).to_s + mins
		"The current time in #{input_city_name} is 
		#{afternoon} PM"
	else 
		 morning = morning_hours + mins
	 	"The current time in #{input_city_name} is  #{morning} AM"
	end
	rescue
		"Invalid city"
	end


end

