class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :salesforce_id, default: "N/A"
			t.string :auto_id, default: "N/A"
			t.string :company, default: "N/A"
			t.string :ip_address, default: "N/A"
			t.string :operating_system, default: "N/A"
			t.string :browser, default: "N/A"
			t.string :screen_resolution, default: "N/A"
			t.string :window_size, default: "N/A"
			t.string :download_speed, default: "N/A"
			t.string :flash_version, default: "N/A"
			t.string :audio_formats, default: "N/A"
			t.string :video_formats, default: "N/A"
			t.string :proxy, default: "N/A"
			t.boolean :javascript, default: false
			t.boolean :cookies
			t.boolean :mobile
			t.boolean :html5_support
			t.boolean :css3_support
			t.text :user_agent
			t.text :plugins

			t.timestamps
		end
	end
end
