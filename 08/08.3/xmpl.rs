use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    let i: i32 = 1;
    let zaehler = Arc::new(Mutex::new(i));

    { //Hier beginnt ein neuer Geltungsbereich
        println!(
            "Die Variable i hat zu Beginn den Wert: {}",
            zaehler.lock().unwrap() //Mutex wird gelocked
        );
    } //Hier endet der Geltungsbereich und die Mutex wird automatisch freigegeben

    let zaehler_clone = zaehler.clone();

    let thread = thread::spawn(move || {
        let mut i_thread = zaehler_clone.lock().unwrap();
        *i_thread += 1; //i_thread verhält sich wie eine mutable reference. Zaehler i wird um 1 erhöht.
        println!("Die Variable i hat im Thread den Wert: {}", i_thread);
    });

    thread.join().unwrap();

    {
        let mut i_main = zaehler.lock().unwrap();
        *i_main += 1; //Zaehler i wird um 1 erhöht
    }

    println!(
        "Die Variable i hat am Ende den Wert: {}",
        zaehler.lock().unwrap()
    );
}