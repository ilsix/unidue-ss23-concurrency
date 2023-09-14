fn f_to_c(temp_f: f32) -> f32 {
	let tempc: f32 = (temp_f - 32.0) * (5.0 / 9.0);
	return tempc;
}

fn ggt(zahl_1: i32, zahl_2: i32) -> i32 {
	let mut a: i32 = zahl_1;
	let mut b: i32 = zahl_2;
	if a == b {
		return b;
	} else {
		while b != 0 {
			if a > b {
				a = a - b;
			} else {
				b = b - a
			}
		}
		return a;

	}
	return 0;
}

fn buchstabe_in_zeichenkette(zeichenkette: &str, c: char) -> i32 {
	// TODO ergänzen Sie hier Ihre Lösung von Teilaufgabe c.
	let mut cnt: i32 = 0;
	for ch in zeichenkette.chars() {
		if ch == c {
			cnt = cnt + 1;
		}
	}
	return cnt;
}

fn main() {

	let temp_f: f32 = 50.0;
	println!("{} Grad Fahrenheit sind {} Grad Celsius.",temp_f, f_to_c(temp_f));

	let zahl_1: i32 = 250;
	let zahl_2: i32 = 120;
	println!("Der ggT von {} und {} ist {}.", zahl_1, zahl_2, ggt(zahl_1, zahl_2));

	let s: &str = "Universität Duisburg-Essen";
	let c = 's';

	println!("In der Zeichenkette \"{}\" kommt der Buchstabe '{}' genau {} mal vor.", s, c, buchstabe_in_zeichenkette(s, c));
}