import pandas as pd
from zenrows import ZenRowsClient

client = ZenRowsClient("c8a0e7928f44b1aee66bc82de5746dd1c6aac70c")


def clean_price(price):
    price = price.replace("Rp", "").replace(",", "").replace(
        ".", "").replace("jt", "e6").replace("rb", "e3")
    if price == '-':
        price = 0
    elif "-" in price:
        price = price.split(" - ")[0]
    return float(price)


def clean_sell_count(value):
    if type(value) == int:
        return value
    value = ''.join(value.split(" ")).replace(
        ',', '.').replace(' ', '')
    if value.endswith('rb'):
        return int(float(value.split('rb')[0]) * 1000)
    else:
        return int(value)


class blibli:
    def scrap(self, keyword):

        encoded_keyword = keyword.replace(' ', '%20')
        data = []
        index = 0
        for i in range(1, 6):
            url = f'https://www.blibli.com/backend/search/products?page={i}&start={index}&searchTerm={
                encoded_keyword}&intent=true&merchantSearch=true&multiCategory=true&customUrl=&&channelId=web&showFacet=false&userIdentifier=657116261.U.8638455162799837.1712462870&isMobileBCA=false&isJual=false'

            r = client.get(url).json()

            rows = r['data']['products']
            if len(rows) == 0:
                break
            for item in rows:
                product_name = item['name']
                product_price = '0'
                if 'price' in item:
                    product_price = item['price']['offerPriceDisplay']
                product_shop_name = item['merchantName']
                product_location = item['location']
                product_rating = item['review']['absoluteRating'] if item['review']['absoluteRating'] else 0
                product_sell = 0
                if 'soldRangeCount' in item:
                    product_sell = item['soldRangeCount']['id']
                marketplace = "blibli"
                product_image = "-"
                product_url = f"https://blibli.com{item['url']}"
                data.append((product_name, product_price, product_rating, product_sell,
                            product_location, product_shop_name, product_image, product_url, marketplace))

                index += 1

        df = pd.DataFrame(data, columns=[
            'product name', 'product price', 'product rating', 'product sell count', 'product location', 'product shop name', 'product image', 'product url', 'marketplace'])

        df = df.drop_duplicates(subset=['product name'])
        df.reset_index(drop=True, inplace=True)

        df['product price'] = df['product price'].apply(
            lambda x: clean_price(x))
        df['product sell count'] = df['product sell count'].apply(
            lambda x: clean_sell_count(x))
        print("blibli done")
        return df


if __name__ == "__main__":
    scrap = blibli()
    # keyword = input("Masukkan keyword produk yang ingin dicari : ")
    df = scrap.scrap('boneka')
    print(df)
