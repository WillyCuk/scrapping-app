import requests
import pandas as pd


def clean_rating(value):
    value = value.split(" ")[0]
    if value.endswith('K'):
        return int(float(value[:-1]) * 1000)
    else:
        return float(value)


def clean_sell_count(value):
    value = value.split(" ")[0]
    if value.endswith('K'):
        return int(float(value[:-1]) * 1000)
    else:
        return int(value)


class lazada:
    def scrap(self, keyword):

        data = []
        dash_keyword = keyword.replace(' ', '-')
        encoded_keyword = keyword.replace(' ', '%20')
        for index in range(1, 11):
            url = f'https://www.lazada.co.id/tag/{
                dash_keyword}/?ajax=true&catalog_redirect_tag=true&page={index}&q={encoded_keyword}&spm=a2o4j.searchlist.search.d_go.31aca7b4jqqjDB'

            try:
                r = requests.get(url=url, headers={
                    'Accept-Language':
                    'en-US,en;q=0.9',
                    'Accept': 'application/json, text/plain, */*', 'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0',
                    'Cookie': '__wpkreporterwid_=ce29f0be-7b6e-43fd-87eb-8806b8fd6957; hng=ID|id-ID|IDR|360; hng.sig=to18pG508Hzz7EPB_okhuQu8kDUP3TDmLlnu4IbIOY8; t_fv=1719345464293; t_uid=tucdrCfQV3Qs5Lx6nee0tT4lxciBWBAG; cna=OA8CH8rxHgMCASREmnzpCwpO; lwrid=AgGQUPnFgTBgeTTgWT%2BnX38RnKtX; lzd_cid=6c93318b-1f2d-4e16-aeb1-5bc9ef378494; EGG_SESS=S_Gs1wHo9OvRHCMp98md7AjL2NZ5DKTXdfwNpyo__IH1j5WcoghlSEmURD7M0uSWuKFoOwyVW0DQFumt-3Awa6qTW0o-UfJIXu7W3I5tu_EfrOxg9C7N_uuyQeolW2uuR5QsAmKSgO-qjkwVWUU3Tzq5_crZPdUfhKC1mt8l0qc=; t_sid=dh6rxcBAaA0FPCIkcYWQWTZr4TarKPRd; utm_channel=NA; _m_h5_tk=aa2792068ef03383d901ebc46b03c8bb_1719749164331; _m_h5_tk_enc=cde3badb580000f358a5875c107674f6; lzd_sid=136d3fadf357a31aa5760424a7990320; _tb_token_=13ee65551fde; xlly_s=1; isg=BK-vc-q_FaegYREIouxMUq6yPsO5VAN20FB_dME8S54lEM8SySSTxq3GkhguQdvu; tfstk=fFqs_Am_8CA_QueIiVBEVo7VuZofL5sP5KMYE-KwHcn9MIe-TmWMuNDjcXNm_qUNiWGbg8Bi0craOdqQNn-NsN2vcmoAa_SP4RvimmCzXrXApfD0pjHkLX8uImmATp-AzgwgNig9pGiAdDHjHnnvXqBBJxcpXxKtHBBInXhxDxhtpJHiFhhxT-JShNGgC91t3Uf9jjetOnN0AA36SRhBDnEQeVGJ4XtvDkMTKy4sy3_qwzcZzjNdYhibpxNIzP1WfSwYEr3QcCBawWUbMv4hGEG7kRzuk26OXJis12MZ5KTtfrFgcV46nT2KXW4oZVQhtvZa4qGoRBCTLJGtPrNNtnhaPJFIzkRe40UuOog-2g8D4b9FbE9IrnMIa96BoEzWquMtKC6A9VHnC2WCdCUmWvDIa96BoE0tKAGFd9OTo; epssw=4*mmCciP4TRmVhsnixmmNU7dPuyZFud8FmKKLnkmDmGcxmmg050OU6So8nm8mmpr7Drn7fPmEjGHbl1r7r1ZeZWhlDqvTgnri6dYMr1nOne7Poa8HgAcJFaGhWmG3Krr_Wm1rwLG7r7rrrFme5fK1sFmm678Pm1rTWmBG-T59pZmCe_r_OaAhGZPCGakLZ9APCHmSVdk2ncB2Vl_9sBCZ29JDSM65ni7kZ5QiCQF2c'
                })

                r_json = r.json()
                r.raise_for_status()  # Raise an exception for 4xx or 5xx status codes

                # Attempt to parse response as JSON

                rows = r_json['mods']['listItems']

                for item in rows:
                    product_name = item['name']
                    product_price = item['price']
                    product_shop_name = item['sellerName']
                    product_location = item['location']
                    product_rating = item['ratingScore'][:
                                                         3] if item['ratingScore'] else '0'
                    product_sell = '0'
                    if 'itemSoldCntShow' in item:
                        product_sell = item['itemSoldCntShow']
                    product_image = item['image']
                    product_url = item['itemUrl']
                    marketplace = 'lazada'

                    data.append((product_name, product_price, product_rating, product_sell,
                                product_location, product_shop_name, product_image, product_url, marketplace))

            except requests.exceptions.RequestException as err:
                print(f"An error occurred while requesting page {
                      index}: {err}")
                continue  # Skip to the next iteration of the loop

            except (KeyError, IndexError) as err:
                print(f"An error occurred while processing page {
                      index}: {err}")
                continue  # Skip to the next iteration of the loop

        df = pd.DataFrame(data, columns=[
            'product name', 'product price', 'product rating', 'product sell count', 'product location', 'product shop name', 'product image', 'product url', 'marketplace'])

        df = df.drop_duplicates(subset=['product name'])
        df.reset_index(drop=True, inplace=True)

        df['product rating'] = df['product rating'].apply(
            lambda x: clean_rating(x))

        df['product sell count'] = df['product sell count'].apply(
            lambda x: clean_sell_count(x))

        df['product price'] = df['product price'].apply(
            lambda x: int(float(x)))
        print("lazada done")
        return df


if __name__ == '__main__':
    lzd = lazada()
    # keyword = input("Masukkan keyword : ")
    print(lzd.scrap("babi"))
