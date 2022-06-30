// See https://aka.ms/new-console-template for more information
//Console.WriteLine("Hello, World!");

void askQuestions()
{
    Console.WriteLine("Hi there! Please enter your followed by your partner's zodiac signs below to " +
        "find out if you are compatible or not!");
    String self = Console.ReadLine();
    String partner = Console.ReadLine();
    coupleCompatibility(self, partner);
}
void coupleCompatibility(String selfSign, String partnerSign)
{
    if(selfSign.ToLower() == "cancer")
    {
        if (partnerSign.ToLower() == "gemini")
        {
            Console.WriteLine("Congratualations! You are Compatible with your partner!");
        } else {
            Console.WriteLine("oh no! Its time to look for a new partner! :( \n Hint: try looking for a Gemini!");
        }
    }

    if( selfSign.ToLower() == "aries")
    {
        if(partnerSign.ToLower() == "sagitarius")
        {
            Console.WriteLine("Congratualations! You are Compatible with your partner!");
        }
        else
        {
            Console.WriteLine("oh no! Its time to look for a new partner! :(\n Hint: try looking for a Sagitarius!");
        }
    }

    if(selfSign.ToLower() == "virgo")
    {
        if (partnerSign.ToLower() == "scorpio")
        {
            Console.WriteLine("Congratualations! You are Compatible with your partner!");
        }
        else
        {
            Console.WriteLine("oh no! Its time to look for a new partner! :(  \n Hint: try looking for a Scorpio!");
        }
    }

    if(selfSign.ToLower() == "capricorn")
    {
        if (partnerSign.ToLower() == "leo")
        {
            Console.WriteLine("Congratualations! You are Compatible with your partner!");
        }
        else
        {
            Console.WriteLine("oh no! Its time to look for a new partner! :( \n Hint: try looking for a LEO!");
        }
    }
}

askQuestions();
