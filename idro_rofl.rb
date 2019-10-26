require 'selenium-webdriver'

times = 200
passIdRO = ''

userMail = ''
mainMail = ''
passMail = ''
basename = ''

counter = 0
try_count = 0
syllables = ['a',  'i',  'u',  'e',  'o',
			'ka', 'ki', 'ku', 'ke', 'ko',
			'ga', 'gi', 'gu', 'ge', 'go',
			'wa', 'wi',       'we', 'wo']

def security(driver)
	security_text = driver.find_element(:xpath,"//form[contains(@id,'register-form')]/div/span/b").text
	security_text = security_text.delete! '+'
	security_queryA = security_text.split(/\W+/).first
	security_queryB = security_text.split(/\W+/).last
	hruf_angk = {'satu'=>1,'dua'=>2,'tiga'=>3,'empat'=>4,'lima'=>5,'enam'=>6,'tujuh'=>7,'delapan'=>8,'sembilan'=>9,'sepuluh'=>10,'sebelas'=>11,'duabelas'=>12,'tigabelas'=>13,'empatbelas'=>14,'limabelas'=>15,'enambelas'=>16,'tujuhbelas'=>17,'delapanbelas'=>18,'sembilanbelas'=>19}
	angk_hruf = Hash[hruf_angk.map{ |k,v| [v,k] }]
	security_queryA = hruf_angk[security_queryA]
	security_queryB = hruf_angk[security_queryB]
	sum_queryAB = security_queryA+security_queryB
	security_answer = angk_hruf[sum_queryAB]
end

Selenium::WebDriver::Chrome.driver_path = "./chromedriver/chromedriver.exe"
driver = Selenium::WebDriver.for :chrome, switches: %w[--window-position=300,10]

# email login
driver.navigate.to 'https://login.yahoo.com/'
Selenium::WebDriver::Wait.new(:timeout => 50).until {driver.page_source.include? "Next"}
driver.find_element(:name,'username').send_keys "#{userMail}@#{mainMail}\n"
Selenium::WebDriver::Wait.new(:timeout => 100).until {driver.page_source.include? "Hello #{userMail}@#{mainMail}"}
driver.find_element(:name,'password').send_keys "#{passMail}\n"
sleep 1

while(counter < times)
	try_count += 1
	puts "\n[Try: #{try_count}] Attempting to create: #{counter}/#{times} account"
	
	
	
	
	
	
	







	userIdRO = 5.times.map {syllables[rand(syllables.length)]}.join

	driver.navigate.to 'https://mail.yahoo.com/b/settings/accounts?.src=ym&reason=myc&editMode=ADD_DEA'
	Selenium::WebDriver::Wait.new(:timeout => 20).until {driver.page_source.include? "Yahoo Mail"}
	driver.find_element(:name,'deaSuffix').send_keys "#{userIdRO}\n"
	newEmail = "#{basename}-#{userIdRO}@#{mainMail}"
	puts "\n[Try: #{try_count}] New email: #{newEmail}"
	sleep 3
	driver.navigate.to 'https://gnjoy.id/member/register'
	Selenium::WebDriver::Wait.new(:timeout => 20).until {driver.find_element(:id,'gravity-member')}
	

	signup_status = false
	while !signup_status
		gender = rand(1..2)
		security_answer = security(driver)

		driver.find_element(:name,'uname').send_keys "#{userIdRO}"
		driver.find_element(:name,'password').send_keys "#{passIdRO}"
		driver.find_element(:name,'passwordcon').send_keys "#{passIdRO}"
		driver.find_element(:xpath,"//input[contains(@name,'jk')][contains(@value,'#{gender}')]").click
		driver.find_element(:name,'email').send_keys "#{newEmail}"
		driver.find_element(:name,'emailkonfirmasi').send_keys "#{newEmail}"
		driver.find_element(:name,'security').send_keys "#{security_answer}"
		driver.find_element(:name,'eula').click
		driver.find_element(:xpath,"//button[contains(@type,'submit')]").click
		# sleep 5
		Selenium::WebDriver::Wait.new(:timeout => 20).until {driver.find_element(:id,'gravity-member')}
		if driver.current_url == "https://gnjoy.id/member/register"
			puts "[Try: #{try_count}] Account already used: #{userIdRO}"
			newName = 1.times.map {syllables[rand(syllables.length)]}.join
			userIdRO = "#{userIdRO}_#{newName}"
			try_count += 1
			driver.navigate.refresh
		else
			puts "[Try: #{try_count}] Sign up used: #{userIdRO}"
			signup_status = true
		end
	end

	count = 0
	validate_status = false
	while !validate_status
		driver.navigate.to 'https://mg.mail.yahoo.com/neo/b/launch'
		count += 1
		sleep 1
		if driver.page_source.include? '(1 belum dibaca)'
			puts "[Try: #{try_count}] Email Try: #{count}"
			validate_status = true
		elsif count == 20
			puts "[Try: #{try_count}] Email failed!"
			File.open("failed.txt", 'a') do |file|
				file.puts "Email\t#{userIdRO}\t\t#{newEmail}"
			end
			try_count += 1
			sleep 1
			break
		end
	end




	if validate_status

		driver.find_element(:xpath,"//tr[contains(@class,'i_6UHk A_6EqO m_Z14vXdP I4_ZnMI27 u_b')]").click
		sleep 2
		mail_text = driver.find_element(:xpath,"//div[contains(@class,'d_3zJDR P_1Izyn')]/div/div").attribute('innerHTML')
		mail_text = mail_text.gsub(/[<">]/,"\n")
		validate_link = mail_text.scan(/(https?:\/\/[\S]+)/).first
		driver.navigate.to "#{validate_link[0]}"
		Selenium::WebDriver::Wait.new(:timeout => 20).until {driver.page_source.include? "Verifikasi ID"}
		
		driver.find_element(:xpath,"//button[contains(@type,'submit')]").click
		Selenium::WebDriver::Wait.new(:timeout => 20).until {driver.page_source.include? "Login"}
	end




	if driver.page_source.include? 'Selamat ID kamu sudah teraktivasi'
		puts "[Try: #{try_count}] Account Created: #{userIdRO}"
		File.open("accounts.txt", 'a') do |file|
			file.puts "#{userIdRO}\t\t\t#{passIdRO}\t\t\t#{newEmail}"
		end
		counter += 1
	else
		puts "[Try: #{try_count}] Verification failed!"
		File.open("failed.txt", 'a') do |file|
			file.puts "Verif\t#{userIdRO}\t\t#{newEmail}\t\t#{validate_link[0]}"
		end
		try_count += 1
	end
	sleep 1
end

puts "[Try: #{try_count}] Finished Create: #{counter}/#{times} account"