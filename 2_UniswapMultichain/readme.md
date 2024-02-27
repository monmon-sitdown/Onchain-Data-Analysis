# 2023年におけるUniswapのマルチチェーンでのパフォーマンス
The dashboard can be found in https://dune.com/syu24059/uniswap-2023-multichain-analysis

## はじめに
このダッシュボードでは、Uniswap 上での主要なブロックチェーン（Arbitrum、Ethereum、Optimism、Polygonなど）のパフォーマンスデータについて分析しています。報告書には取引量、アクティブユーザー数、新規ユーザーの増加数、日次取引データ，流動性プールの数、およびバリュー・ロック（TVL）総額などの指標が含まれています。

## データソース
このダッシュボードではDuneが提供しているSpellBook（スペルブック）を使っています。各ブロックチェーン上のUniswapのデータを収集し、SQLクエリで分析しました。

## データ分析
![Fig1](/2_UniswapMultichain/img/fig1.png "Fig.1  The information of trade amount, trade count and active user on Uniswap.")
![Fig2](/2_UniswapMultichain/img/fig2.png "Fig.2  The comparison of trade information among multi chains.")
2024年1月時点で、Uniswap上の総取引額は486.52億ドル、総取引量は175.14百万で、総アクティブユーザー数は6.43百万人でした。そのうち、Ethereumチェーンは取引総額の75%を占め、次いで16.5%の取引総額を占めるArbitrumチェーンが続き、その後にPolygonやOptimismなどのチェーンが続きます。取引量に関しても、Ethereumチェーンが圧倒的なトップで、44%の取引量を占め、Arbitrum、Polygon、Optimismなどがそれに続きますが、それぞれ10%以上のシェアを持っています。取引者の数に関しても、依然としてEthereumチェーン上のユーザーが約半数を占めており、Arbitrum、Polygon、Optimismはそれぞれ15%前後の割合を占めています。Uniswap取引所全体では、イーサリアムチェーンが主要な地位を占め、同様に、Arbitrum、Polygon、Optimismもそれぞれ市場の一部を占めています。

![Fig3](/2_UniswapMultichain/img/fig3.png "Fig.3  The daily trade information on multi chains.")
Uniswapの取引所における各チェーンの毎日の取引状況を分析します。Ethereumと他のチェーンの取引総額には著しい差異が見られますが、取引量の差は2023年上半期にはそれほど顕著ではありませんでした。取引総額においてETHが7割以上を占めている一方、取引量においては4〜5割程度にとどまっています。これは、Ethereumが他のチェーンに比べてドル換算価値が高いためである可能性があります。ただし、毎日の取引量とユーザー数に関しては、Ethereumも圧倒的な差を持っています。この差は、ある日の急激な取引量やユーザー数の増加ではなく、ほぼ1年を通じて一貫しています。このことから、EthereumがUniswap取引所で依然として最も主流で安定した暗号通貨であることが示唆されます。累積取引総額、累積取引回数、および累積ユーザー数のグラフからは、依然としてEthereum、Arbitrum、Polygon、およびOptimismといったいくつかのチェーンが上位に位置していることが明らかになります。

![Fig5](/2_UniswapMultichain/img/fig5.png "Fig.5 The daily user information on four main chains on uniswap.")
前の分析でわかったUniswapのトレーディングボリュームランキング上位4つのチェーン（Ethereum、Arbitrum、Polygon、Optimism）を選択し、さらなる観察を行います。それぞれのチェーンの毎日の新規ユーザー数、アクティブユーザー数、既存ユーザー数を分析します。Ethereum、Arbitrum、Optimismの場合、アクティブユーザー数と既存ユーザー数がほぼ同じであることが分かります。一方、Polygonでは、一定の期間内にアクティブユーザー数が既存ユーザー数を明らかに上回る傾向が見られます。この時点での新規ユーザーも積極的に取引に参加していることが示されています。また、各チェーンでの新規ユーザーと既存ユーザーの割合を見ると、Ethereumでは新規ユーザーの割合が既存ユーザーよりもはるかに少ないことが分かります。これは、Ethereumチェーン自体のユーザーベースが非常に大きいためかもしれません。また、Ethereumの新規ユーザーは年間を通じて安定しており、他の3つのチェーンでは新規ユーザーの割合が明らかに多く、外部環境や市場の影響を受けやすく、これらのチェーンはまだ成長の余地があり、ユーザーベースが小さいことを示しています。

![Fig6](/2_UniswapMultichain/img/fig6.png "Fig.6 New pool Comparison between Ethereum, Arbitrum, Polygon, and Optimism.")
2023年の新規流動性プールのデータを分析すると、Ethereum、Arbitrum、Polygonの各プールの増加率は約30％であり、Optimismの増加率は6％程度であることがわかります。Optimismの増加率が他のプールに比べて低いのは、Optimismのリリースが比較的遅かったためである可能性があります。また、日次のデータを見ると、通常の増加傾向とは異なり、Optimismプールがある日に非常に急激な増加を示していることがわかります。この日付は2023年8月18日であり、この日にOptimismチェーン上でExactly Protocolがハッキングされました。この事件により、ハッカーは700万ドル以上の利益を得ました。この異常な増加はおそらくこの事件と関連していると考えられます。

![Fig7](/2_UniswapMultichain/img/fig7.png "Fig.7Total value locked comparison between four chains.")
上図は、TVLの状況を表しています。

### TVL(Total Value Locked)
Total Value Locked（TVL）はDeFi（分散型金融）領域の重要な概念であり、さまざまな分散型金融プロトコルでロックされた総価値を測定するために使用されます。簡単に言えば、TVLはDeFiプラットフォームにおいてユーザーがロックしたデジタル資産の総価値を表します。
DeFiプラットフォームには通常、貸借プロトコル、流動性マイニングプロトコル、分散型取引所などが含まれます。ユーザーはこれらのプロトコルにデジタル資産（例：暗号通貨）を預け入れ、流動性の提供、貸借、取引などのさまざまな金融活動を行うことができます。TVLは、これらすべてのプロトコルにおける総価値を示し、DeFi市場の規模と活動レベルを反映しています。
TVLの増加は通常、DeFi市場の発展と成長の指標の1つと見なされます。なぜなら、これはユーザーがDeFiプロトコルを信頼し、採用している程度を示すからです。ただし、TVL自体はユーザー数や活動レベルを表すものではないことに注意する必要があります。同じユーザーが複数のプロトコルに資金を預けている場合があるため、TVLの増加が必ずしもユーザー数の増加を意味しない場合があります。

上図によると、Uniswap上の総TVLは21.9億米ドルです。その内訳は、ETHチェーンが83.6％を占め、次いでArbitrumチェーンが11.8％です。また、流動性プールのTVLのパフォーマンスを見ると、WBTCとWETHの流動性プールが圧倒的な地位を占めており、その後にはUSDC-WETH、DAI-USDC、WETH-USDTなどの主要な交換プールが続きます。取引所の流動性は依然としてBTC、ETH、USDC、USDTなどの主要な暗号通貨に大きく集中していることがわかります。

### サマリー
2024年1月時点のUniswapの状況は、総取引額が486.52億ドル、総取引量が175.14百万、総活動ユーザー数が6.43百万人でした。Ethereumが取引総額の75%を占め、次いで16.5%を占めるArbitrumチェーンが続き、その後にはPolygonやOptimismなどのチェーンが続きます。Ethereum,は取引量の44%を占め、Arbitrum、Polygon、Optimismはそれぞれ10%以上のシェアを持っています。また、Uniswap全体では、Ethereum,が主要地位を占め、Arbitrum、Polygon、Optimismも一定の市場占有率を維持しています。 Uniswapの取引所での各チェーンの毎日の取引状況を詳細に分析すると、Ethereum,と他のチェーンの取引総額には著しい差が見られますが、取引量の差は2023年上半期にはそれほど顕著ではありませんでした。各チェーンの新規ユーザー数、アクティブユーザー数、既存ユーザー数の比較から、ETHがUniswapで依然として主流で安定した暗号通貨であることが示唆されます。新規流動性プールのデータ分析からは、Optimismチェーン上での事件の影響も見られました。 UniswapのTVLの分析からは、BTC、ETH、USDC、USDTなどの主要な暗号通貨に流動性が集中していることがわかります。

The dashboard can be found in https://dune.com/syu24059/uniswap-2023-multichain-analysis


