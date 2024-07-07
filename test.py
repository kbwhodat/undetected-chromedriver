import undetected_chromedriver as uc
import os
import json
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
import time

def gen_driver():
    try:
        chrome_options = uc.ChromeOptions()
        user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
        # chrome_options.add_argument('--headless')
        chrome_options.add_argument("--start-maximized")
        chrome_options.add_argument("--window-size=1920,1080")
        chrome_options.add_argument(f"--user-agent={user_agent}")
        chrome_options.add_experimental_option("prefs", {
            "profile.default_content_setting_values.popups": 1,  # Allow pop-ups
        })


        driver = uc.Chrome(options=chrome_options, driver_executable_path='/tmp/chromedriver')
        return driver
    except Exception as e:
        print("Error in Driver: ",e)

def title_changes(driver, old_title):
    return driver.title != old_title

def main():
    driver = gen_driver()  # Initialize the driver using your function
    try:
        time.sleep(1)
        location = "cookies.json"

        driver.execute_script("window.open('https://en.rarbg-official.com/episodes/true-detective-2014-season-4-episode-1','_blank');")

        time.sleep(2)
        driver.switch_to.window(driver.window_handles[1])

        WebDriverWait(driver, 10).until(EC.url_to_be('https://en.rarbg-official.com/episodes/true-detective-2014-season-4-episode-1'))
        time.sleep(2)

        # time.sleep(60)
        # with open(location, 'w') as filehandler:
        #     json.dump(driver.get_cookies(), filehandler, indent=4)
            


        # if os.path.isfile(location):
        #     with open(location, 'rb') as cookiesfiles:
        #         cookies = pickle.load(cookiesfiles)
        #         for cookie in cookies:
        #             print(cookie)
        #             driver.add_cookie(cookie)

        print(driver.page_source)

    except Exception as e:
        print("Error in Driver: ",e)

def convert_pickle_to_json(pickle_file, json_file):
    with open(pickle_file, 'rb') as pf:
        cookies = pickle.load(pf)
    with open(json_file, 'w') as jf:
        json.dump(cookies, jf, indent=4)

if __name__ == "__main__":
    main()

