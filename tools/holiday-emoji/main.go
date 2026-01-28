package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	now := time.Now()
	month := int(now.Month())
	day := now.Day()

	emoji := getHolidayEmoji(month, day)
	fmt.Print(emoji)
}

func getHolidayEmoji(month, day int) string {
	// New Year's week (Dec 26 - Jan 1)
	if (month == 12 && day >= 26) || (month == 1 && day == 1) {
		return pick("🎉", "🍾", "🎆", "🕛", "🎊")
	}

	// Valentine's week (Feb 8-14)
	if month == 2 && day >= 8 && day <= 14 {
		return pick("💘", "❤️", "💝", "🌹", "💌")
	}

	// St. Patrick's Day (Mar 17)
	if month == 3 && day == 17 {
		return "☘️"
	}

	// Independence Day week (Jun 28 - Jul 4)
	if (month == 6 && day >= 28) || (month == 7 && day <= 4) {
		return pick("🇺🇸", "🎆", "🗽", "🦅", "🎉")
	}

	// Halloween week (Oct 25-31)
	if month == 10 && day >= 25 && day <= 31 {
		return pick("🎃", "👻", "🦇")
	}

	// Thanksgiving week (4th Thursday of November, and week before)
	if month == 11 {
		thanksgivingDay := thanksgivingDate(time.Now().Year())
		if day >= thanksgivingDay-6 && day <= thanksgivingDay {
			return pick("🦃", "🌽", "🥧", "🍂", "🍗")
		}
	}

	// Christmas month (Dec 1-25)
	if month == 12 && day >= 1 && day <= 25 {
		return pick("🎄", "🎅", "🤶", "🦌", "⛄", "🔔", "🎁", "🧣")
	}

	// Seasons
	switch month {
	case 12, 1, 2: // Winter
		return pick("❄️", "⛄", "🧣")
	case 3, 4, 5: // Spring
		return pick("🌸", "🌼", "🦋")
	case 6, 7, 8: // Summer
		return pick("☀️", "🏖️", "🍦")
	case 9, 10, 11: // Fall
		return pick("🍂", "🍁", "🍎", "🌾")
	}

	return "🌟"
}

func thanksgivingDate(year int) int {
	// Find first day of November
	nov1 := time.Date(year, time.November, 1, 0, 0, 0, 0, time.UTC)
	weekday := int(nov1.Weekday())

	// Find first Thursday (weekday 4)
	firstThursday := 1 + (4 - weekday + 7) % 7

	// Fourth Thursday
	return firstThursday + 21
}

func pick(options ...string) string {
	return options[rand.Intn(len(options))]
}
