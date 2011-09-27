# encoding: UTF-8

Newsly.setup do |config|
	config.test_data = { 
		"kund" => { 
			"namn" 				 	=> 	"Kim Fransman",
			"foretagsnamn"	=>  "Kims Firma",
			"fornamn" 			=>	"Kim",
			"efternamn" 		=>  "Fransman",
			"idnummer" 			=>  "3",
			"epost" 				=>	"kimpa@mail.se", 
			"mobil" 				=>	"098765",
			"losenord" 			=>  "09876ysad",
			"typ" 					=>  "Person",
			"agent" 				=> 	{"namn" =>  "Niklas"},
			"gata" 					=> 	"Valthornsvägen",
			"telefon" 			=> 	"085999999",
			"ort" 					=> 	"Ösmo",
			"postnummer" 		=>	"14856"},
		"el" => {
			"bindningstid" 			=>  "2012-01-01",
			"forbrukning" 			=>  "2000",
			"anlaggnings_id" 		=>  "300",
			"omrades_id" 				=>	"300",
			"nuvarand_el_lev" 	=>  "God EL",
			"nuvarande_nat_lev" =>	"Nynäshamns Energie",
			"agent" 						=>	{"namn" => "Niklas L"},
			"valt_avtal" 				=>	"Rörligt",
			"total_pris" 				=>	"200",
			"pris" 							=>	"100",
			"paslag" 						=>	"12",
			"moms" 							=>	"25",
			"gata" 							=>	"Valthornsvägen 7A",
			"ort" 							=>	"Nynäshamn",
			"postnummer" 				=>	"14950"},
		"newsletter" => {
			"body" => "Hej {{kund.namn}}. Detta är ett nyhetsbrev från Baraspara."
		}
	}
end

Newsly.define_newsletter_receipient_group :newsletter_resources do
	Customer.select('customers.*').includes([:address, :agent]).where(:canceled_at => nil).find_each(:batch_size => 1000)
end