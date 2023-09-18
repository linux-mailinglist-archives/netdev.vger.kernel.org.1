Return-Path: <netdev+bounces-34708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96C7A531B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A935281FD2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A527723;
	Mon, 18 Sep 2023 19:28:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0733DF
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:27:59 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2295B10E;
	Mon, 18 Sep 2023 12:27:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502fdfeb1d9so4091533e87.2;
        Mon, 18 Sep 2023 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695065275; x=1695670075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUNA23giNsy9yXBhE6+Kf6gNULsVNoBVOIJ8OFSJNNc=;
        b=cWVOHtCHFyHDOe6XeSopEQ2U/XYbsMqT4sb+3BDpQIh6ZKwF+YXySse9GDNu/DwgcV
         6Bi1HWtBWddmNbjCabWwvz8AdiP1kidwRlsLtB9DLskixdATD192pIlbz+CLAWlq9aIY
         Y+lBN5yDwmS+rHtAo0H7iCPlBIRJWYhGNp3COLsGXe0er58bzfmDOCBX+skWpvo4x4gQ
         Pch/0Ie809SmvNlEXJNEk2icMYhSMKrODsrxLGJQTFr5Ig6sc5R/RD4hUuzk4fwzWq8Y
         kMYz3nP4HiaEmctUjsKNJW4sCv2E2PPHaUL8lBKzO0ygh6x0ekf7vA0sURzIBTJRkYmc
         6m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695065275; x=1695670075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUNA23giNsy9yXBhE6+Kf6gNULsVNoBVOIJ8OFSJNNc=;
        b=NKb/H+p2meMsfSbPw2nZRCbRjx36KZtUzzkpo7fXXwpi527CapCp8qZs/Fp/yTRsI0
         HRRmy+cUXGoCuzeM1bnNIVE9pDmwK+HthucYwmzqT8OeD9uS/4GckpZYwxmD9MyIcwgL
         lpiVFghrbkzd5vhYPP0nHEEEGjbpMCelp7koLeF/lynw5x9+2glGp/nLN3tj24a/tqlY
         2F3yp7aPq7g3J0CJD8TZQLvirSirK3cO7koziEnBomw8nXU5fiHXLxmnZtBgnws1GZRj
         ZYguv+zK9qNbGnj3A6DwCk6lIWmDfUimeR/YcxOqKSRZmjmfwt+rwbO2udTVEWz8HMdv
         MC5Q==
X-Gm-Message-State: AOJu0Yx80+0CoHAoNZQbTQJmvUFa+JD4gkBVjbecZ5u8Vawtnsp6gwAe
	/d/Kk4IwhVT1+UmQgvnUdiw=
X-Google-Smtp-Source: AGHT+IHj4oSlgl2LSDqV5ANHoqz74jHZgqunRahPHglIvps97t3ij8W0vmwiuA1EgpsdIxEnzqZXEg==
X-Received: by 2002:a05:6512:962:b0:501:c3ee:62ec with SMTP id v2-20020a056512096200b00501c3ee62ecmr7844316lft.12.1695065275122;
        Mon, 18 Sep 2023 12:27:55 -0700 (PDT)
Received: from mobilestation ([85.140.3.118])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25936000000b005009920b6afsm1941264lfi.9.2023.09.18.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:27:54 -0700 (PDT)
Date: Mon, 18 Sep 2023 22:27:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 01/23] net: stmmac: dwmac-anarion: use
 devm_stmmac_probe_config_dt()
Message-ID: <3zzbxnzkhlucscfx5h4h6k3lyhqln2nwmcsgb3dvzn6xqkhhdw@nrpekwfahkua>
References: <20230916075829.1560-1-jszhang@kernel.org>
 <20230916075829.1560-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916075829.1560-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 03:58:07PM +0800, Jisheng Zhang wrote:
> Simplify the driver's probe() function by using the devres
> variant of stmmac_probe_config_dt().
> 
> The remove_new() callback now needs to be switched to
> stmmac_pltfr_remove_no_dt().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> index 58a7f08e8d78..0df3a2ad0986 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
> @@ -115,7 +115,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(gmac))
>  		return PTR_ERR(gmac);
>  
> -	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
>  	if (IS_ERR(plat_dat))
>  		return PTR_ERR(plat_dat);
>  
> @@ -124,13 +124,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
>  	anarion_gmac_init(pdev, gmac);
>  	plat_dat->bsp_priv = gmac;
>  
> -	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> -	if (ret) {
> -		stmmac_remove_config_dt(pdev, plat_dat);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);

Just a general note, IMO it's better from maintainability point of
view to use the pattern:

	ret = func();
	if (ret)
		return ret;

	return 0;

Thus should you need to add any functions call after or before the
func() method invocation with possible clean-up-on-error code the
change patch will look a bit simpler and more readable.

-Serge(y)

>  }
>  
>  static const struct of_device_id anarion_dwmac_match[] = {
> @@ -141,7 +135,7 @@ MODULE_DEVICE_TABLE(of, anarion_dwmac_match);
>  
>  static struct platform_driver anarion_dwmac_driver = {
>  	.probe  = anarion_dwmac_probe,
> -	.remove_new = stmmac_pltfr_remove,
> +	.remove_new = stmmac_pltfr_remove_no_dt,
>  	.driver = {
>  		.name           = "anarion-dwmac",
>  		.pm		= &stmmac_pltfr_pm_ops,
> -- 
> 2.40.1
> 
> 

