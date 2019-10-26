## ROFL ACCOUNT GENERATOR


### Installation ###
- intall Ruby		>>> https://rubyinstaller.org/downloads/
- dwld chromedriver	>>> https://sites.google.com/a/chromium.org/chromedriver/downloads
	trus taro di folder chromedriver
- intall depency nya    >>> gem install selenium-webdriver
- intall depency nya    >>> gem install fif


### Prepare ###
- siapkan email yahoo
- ubah ke mode clasic di pengaturan
- email yahoo sdh ada basename(nama dasar)
- email yg unread dijadikan read/pindahkan dlu
	jd kalo mail rofl msk nanti cmn ada 1 yg unread
- pastikan inbox email setidaknya ada 1 emal

### Setup ###
- buka "idro_rofl.rb" dgn notepad/notepad++
- times = 2					>>> ganti 2 untuk membuat brp byk sekali jalan
- passIdRO = 'xpswdIdRO'	>>> ganti xpswdIdRO untuk password semua id yg akan di buat
- userMail = 'xuserMail'	>>> ganti xuserMail dgn username email yahoo
- mainMail = 'yahoo.com'	>>> ganti yahoo.com dgn domain email (yahoo.com/yahoo.co.id)
- passMail = 'xpswdMail'	>>> ganti xpswdMail dgn password email yahoo
- basename = 'xbasename'	>>> ganti xbasename dgn basename email "sebelumnya km buat dlu" (letaknya basename-auto@yahoo.com)

- userIdRO =  4.times.map {syllables[rand(syllables.length)]}.join
	>>> ganti angka 4 untuk panjang id (krn table per suku kata jd minimal=3, maximal=6)
- Update sylabel jika di perlukan

### Usage ###

jalankan 
```
idro_rofl.rb
```

## License
[APACHE v2](https://www.apache.org/licenses/LICENSE-2.0.txt)