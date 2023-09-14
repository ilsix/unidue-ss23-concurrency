struct Konto {
	kontostand: i32
}

fn einzahlen(k: &mut Konto, g: i32) {
	k.kontostand += g;
}

fn abheben(k: &mut Konto, g: i32) {
	k.kontostand -= g;
}

fn ueberweisungen(kt: &mut Konto) {
	// Es wird 100 mal 1 Euro eingezahlt
	for _ in 0..100 {
		einzahlen(kt, 1);
	}

	// Es wird 100 mal 1 Euro wieder abgehoben
	for _ in 0..100 {
		abheben(kt, 1);
	}
}

fn main() {
	// Wir erstellen ein neues Konto ohne Guthaben
	let mut mein_konto = Konto{ kontostand: 0 };
	println!("Kontostand vorher: {}", mein_konto.kontostand);
	
	// Wir simulieren 50 mal jeweils 200 Ueberweisungsvorgänge
	let n = 50;
	for _ in 0..n {
		ueberweisungen(&mut mein_konto)
	}

	println!("Kontostand nachher: {}", mein_konto.kontostand);
}