use chrono;
use chrono::prelude::*;


fn main() {
    assert_eq!(Local::today(), Local::now().date());
    assert_eq!(Local::today().weekday(), Weekday::Sun);

    Season::from_date_strings("March 20", "June 20")
    let dt = Date::parse_from_str("14-07-2017", "%d-%m-%Y").unwrap();
    println!("{}", dt.format("%Y-%m-%d"));

    let today = Local::today();
}

struct Season {
    description: String,
    start: Date<chrono::Local>,
    end: Date<chrono::Local>,
}



impl Season {

    fn from_date_strings(start: str, end: str) -> Season{
        Season{
            start: NaiveTime,
            end: day
        }
    }

    fn from_day(day: chrono::Date<chrono::Local>) -> Season {
        Season{
            start: day,
            end: day
        }
    }

    fn matches(&self, date: chrono::Date<chrono::Local>) -> bool {
        date >= self.start && date <= self.end
    }

    // fn load_all() -> [Season] {
    //     [
    //         Season::from_month(3),
    //         Season::from_month(6),
    //         Season::from_month(9),
    //         Season::from_month(12)
    //     ]
    // }
}

