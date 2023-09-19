Return-Path: <netdev+bounces-34897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298A7A5C3D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15771C20DAD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015338DFC;
	Tue, 19 Sep 2023 08:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588830F96
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:14:50 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF5FB
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:14:49 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qiVsO-0004jH-01;
	Tue, 19 Sep 2023 08:14:32 +0000
Date: Tue, 19 Sep 2023 09:14:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 5/9] net: dsa: mt7530: Convert to platform
 remove callback returning void
Message-ID: <ZQlYXybKPSEew2w1@makrotopia.org>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918191916.1299418-6-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 09:19:12PM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mt7530-mmio.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index 0a6a2fe34e64..b74a230a3f13 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -63,15 +63,12 @@ mt7988_probe(struct platform_device *pdev)
>  	return dsa_register_switch(priv->ds);
>  }
>  
> -static int
> -mt7988_remove(struct platform_device *pdev)
> +static void mt7988_remove(struct platform_device *pdev)
>  {
>  	struct mt7530_priv *priv = platform_get_drvdata(pdev);
>  
>  	if (priv)
>  		mt7530_remove_common(priv);
> -
> -	return 0;
>  }
>  
>  static void mt7988_shutdown(struct platform_device *pdev)
> @@ -88,7 +85,7 @@ static void mt7988_shutdown(struct platform_device *pdev)
>  
>  static struct platform_driver mt7988_platform_driver = {
>  	.probe  = mt7988_probe,
> -	.remove = mt7988_remove,
> +	.remove_new = mt7988_remove,
>  	.shutdown = mt7988_shutdown,
>  	.driver = {
>  		.name = "mt7530-mmio",
> -- 
> 2.40.1
> 
> 

