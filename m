Return-Path: <netdev+bounces-34350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1927A35EA
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3411C20953
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76D4A2A;
	Sun, 17 Sep 2023 14:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC884406
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 14:42:20 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F3131;
	Sun, 17 Sep 2023 07:42:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so3039181fa.0;
        Sun, 17 Sep 2023 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694961737; x=1695566537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8OnI6u0cEOFTJYu1llDUXyx2auo+am+q/WLsax6FAQ=;
        b=FZwN3YyZRLSlAgpK5TcZPlN1bxBBldJCcKy2oRdyjcz52ZRmQ6ZfoTPjtw7pMrl6ob
         1Atm0yGvWWPtBIzFI1iwm+eoYfT+Zv7LgSyb22RnGXT8VXJkVnA1MX2PsF6h1aQlPWMH
         x+JnxOtIqnHebAuXkhi7kNakdfkvrl17rcMUHqfvvWEwKlYzdGBo4WnK5xV5Vh5KkrGN
         kGUD9oaq0iAfi2dywldi96rkIS+3G/iYaYrfZfMgm1UyRRaelEwBigT1DPRpN9nokhaF
         2XogNTjexsECiHSS4daDMSU66XvM2sgtDyGT5xIQGufKx+1a0IqHR5UBfvNfkY3j5UEE
         /z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694961737; x=1695566537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8OnI6u0cEOFTJYu1llDUXyx2auo+am+q/WLsax6FAQ=;
        b=lmalaHpiGPgDDRTjMuG2K5bwllm8NRX3YmBie2x4pkWc2lMUAdAQGTD5OIWLXIiIJ/
         vzIL+S0zIn12/Py8NVH+heyhO+tbrKFn3C4hq1IspbdR0Ms0tGKyJZ26Q/kAwouNqzF5
         jAJj27XmvazfROlBB4SipOfrjg+ENNcnuM4ZEgSteXgvkA3eGVz118I8CA0tniCxBNHU
         eCcUzwBtoQdG4RzlBoOrmtr6pZPLkFWcWtjPGwuYUPvpSddMcqZ45Mn3toirzFPUT9LB
         6tSSyKECj/U5/l8q0QgsuWPdIA0xclrIlBnkmp62IQEGtnawjagjwMTKY+1uyIo3MW+o
         dK3A==
X-Gm-Message-State: AOJu0YzTDtTEHAmqE6eEbvPBfGVu7smD/P+DuLkNg8f3eJVohSZoLNAv
	zhPOMdrwLSYpwkKgtV8smy4=
X-Google-Smtp-Source: AGHT+IGCwEla40TgXmbfl+4SNqk+BjMa1n4H5XAPcLrxUPNV78F+jE9Mq3MjRLIpRqip9g6ySlXEyA==
X-Received: by 2002:a05:651c:1245:b0:2c0:d44:6162 with SMTP id h5-20020a05651c124500b002c00d446162mr250029ljh.12.1694961736917;
        Sun, 17 Sep 2023 07:42:16 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-246-155-gprs.simobil.net. [46.123.246.155])
        by smtp.gmail.com with ESMTPSA id gz2-20020a170906f2c200b009ae05f9eab3sm624439ejb.65.2023.09.17.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 07:42:16 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH net-next v2 18/23] net: stmmac: dwmac-sun8i: use
 devm_stmmac_probe_config_dt()
Date: Sun, 17 Sep 2023 16:42:12 +0200
Message-ID: <2701959.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230916075829.1560-19-jszhang@kernel.org>
References:
 <20230916075829.1560-1-jszhang@kernel.org>
 <20230916075829.1560-19-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne sobota, 16. september 2023 ob 09:58:24 CEST je Jisheng Zhang napisal(a):
> Simplify the driver's probe() function by using the devres
> variant of stmmac_probe_config_dt().
> 
> The calling of stmmac_pltfr_remove() now needs to be switched to
> stmmac_pltfr_remove_no_dt().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c index
> 01e77368eef1..63a7e5e53d7b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -1224,7 +1224,7 @@ static int sun8i_dwmac_probe(struct platform_device
> *pdev) if (ret)
>  		return -EINVAL;
> 
> -	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
>  	if (IS_ERR(plat_dat))
>  		return PTR_ERR(plat_dat);
> 
> @@ -1244,7 +1244,7 @@ static int sun8i_dwmac_probe(struct platform_device
> *pdev)
> 
>  	ret = sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
>  	if (ret)
> -		goto dwmac_deconfig;
> +		return ret;
> 
>  	ret = sun8i_dwmac_init(pdev, plat_dat->bsp_priv);
>  	if (ret)
> @@ -1295,8 +1295,6 @@ static int sun8i_dwmac_probe(struct platform_device
> *pdev) sun8i_dwmac_exit(pdev, gmac);
>  dwmac_syscon:
>  	sun8i_dwmac_unset_syscon(gmac);
> -dwmac_deconfig:
> -	stmmac_remove_config_dt(pdev, plat_dat);
> 
>  	return ret;
>  }
> @@ -1314,7 +1312,7 @@ static void sun8i_dwmac_remove(struct platform_device
> *pdev) clk_put(gmac->ephy_clk);
>  	}
> 
> -	stmmac_pltfr_remove(pdev);
> +	stmmac_pltfr_remove_no_dt(pdev);
>  	sun8i_dwmac_unset_syscon(gmac);
>  }





