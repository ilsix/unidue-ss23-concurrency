use std::thread;
use std::sync::Arc;
use std::sync::Mutex;

struct Konto {
    kontostand: i32
}

fn einzahlen(k_ref: &Arc<Mutex<Konto>>, g: i32) {
    let mut k = k_ref.lock().unwrap();
    k.kontostand = k.kontostand + g;
}

fn abheben(k_ref: &Arc<Mutex<Konto>>, g: i32) {
    let mut k = k_ref.lock().unwrap();
    k.kontostand = k.kontostand - g;
}

fn ueberweisungen(kt: Arc<Mutex<Konto>>) {
    for _ in 0..100 {
        einzahlen(&kt, 1);
    }

    for _ in 0..100 {
        abheben(&kt, 1);
    }
}

fn main() {
    let mut mein_konto: Arc<Mutex<Konto>> = Arc::new(Mutex::new(Konto{ kontostand: 0 }));

    println!("Kontostand vorher: {}", mein_konto.lock().unwrap().kontostand);
    
    let n = 50;
    let mut alle_uberw = vec![];

    for _ in 0..n {
        let mein_konto_clone = mein_konto.clone();
        let t1 = std::thread::spawn(|| { ueberweisungen(mein_konto_clone) });
        alle_uberw.push(t1);
    }

    for uberw in alle_uberw {
        uberw.join().unwrap();
    }

    println!("Kontostand nachher: {}", mein_konto.lock().unwrap().kontostand);
}