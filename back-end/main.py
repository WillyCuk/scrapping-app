from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
from marketplace import api_blibli as sb
from marketplace import api_bukalapak as bk
from marketplace import api_lazada as lz
from marketplace import api_tokopedia as tk
from marketplace import filter_data as fd
import logging

app = Flask(__name__)
CORS(app)  # This will allow all origins, methods, and headers

# Initialize all scraping classes
blibli_scrap = sb.blibli()
bukalapak_scrap = bk.bukalapak()
lazada_scrap = lz.lazada()
tokopedia_scrap = tk.tokopedia()
filter = fd.filteringData()

# Configure logging
logging.basicConfig(level=logging.ERROR,
                    format='%(asctime)s - %(levelname)s - %(message)s')


def scrap_data(keyword):
    dataframes = []

    # Scrape Blibli
    try:
        df_blibli = blibli_scrap.scrap(keyword)
        dataframes.append(df_blibli)
    except Exception as e:
        logging.error(f"Error scraping Blibli: {e}")

    # Scrape Lazada
    try:
        df_lazada = lazada_scrap.scrap(keyword)
        dataframes.append(df_lazada)
    except Exception as e:
        logging.error(f"Error scraping Lazada: {e}")

    # Scrape Bukalapak
    try:
        df_bukalapak = bukalapak_scrap.scrap(keyword)
        dataframes.append(df_bukalapak)
    except Exception as e:
        logging.error(f"Error scraping Bukalapak: {e}")

    # Scrape Tokopedia
    try:
        df_tokopedia = tokopedia_scrap.scrap(keyword)
        dataframes.append(df_tokopedia)
    except Exception as e:
        logging.error(f"Error scraping Tokopedia: {e}")

    # Concatenate all successful scrapes
    if dataframes:
        df = pd.concat(dataframes, ignore_index=True)
        df = filter.filter_data(df, keyword)
        return df
    else:
        raise Exception("No data could be scraped from any marketplace")


@app.route('/api/scrape', methods=['GET'])
def scrape():
    keyword = request.args.get('keyword', default='', type=str)
    if not keyword:
        return jsonify({"error": "Keyword not provided"}), 400
    try:
        df = scrap_data(keyword)
        json_compatible_item_data = df.to_dict(orient='records')
        return jsonify(json_compatible_item_data)
    except Exception as e:
        logging.error(f"Error during scraping process: {e}")
        return jsonify({"error": "An error occurred during the scraping process"}), 500


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8000)
