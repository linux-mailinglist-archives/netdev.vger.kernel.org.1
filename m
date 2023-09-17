Return-Path: <netdev+bounces-34366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68D7A3E6E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 00:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2C21C209BC
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3BF505;
	Sun, 17 Sep 2023 22:26:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DACC7469
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 22:26:00 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC9129
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 15:25:59 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBFEB3F66D
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1694989556;
	bh=I9MD/frOYatXvnTs5iG7mBs2PH8/IlXgMFq6W02dlmo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NmQRKRhi0LohoPlWsC0Tzix0+bVD7BtHqObbtgxvQ/+GycprG3wYcIoMLZqE8AiqF
	 k5oIzFDC0M+zXmVKJWGViVC+ZbXccz+sQRfqlMvdMRGxfWXdaP0Fnntn7DSfyDO1o6
	 kqziQ/bOoIBUcT8160q880Hhkv07Dzz4A/pEicwM7CzSajWc2c5jZ9XL3znRlpk+LS
	 U4Fwf/Ua60DpxiL0kyS1OmwQyA2r0/LoSPa1QKIP2TMa2dNm371Pia9Bohv/JrKTKu
	 o38QfEE+s1bYz57xAULK0IN0heugS3zHgR2H8Nsi/LwLzSbkHkIIz9SizYX5aIebp2
	 de38Fzd7zSxTw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-412eee4b64cso47692861cf.1
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 15:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694989555; x=1695594355;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9MD/frOYatXvnTs5iG7mBs2PH8/IlXgMFq6W02dlmo=;
        b=Qd44AAdyQW+vGRQ8TSBC0hFZEcJSkEFJ5kGqybjC8nRQHJu3oeybXE4OKhmuQBSNxi
         9L+YNxbivWL7Vif240sNllwLqjRdPNcJvPLFmZLd/JBf0HzseAgqO2NM/mrXmtQqFnUz
         U/lRbnNbYRDBA+zZjzqlYDSonK8YiL/phoY9sqKLC8Pgkycg5Imifq5BhT422CHL1phB
         I1JjoOL7HtjKEHOZffue6jgPGQGiYfEXNEvVywuC4Yg6t9G41H217eHqiqnwXikMYR2m
         SyUtazSW3w+Oodj0T+MhiZScCJQG2QAXssKc32CL6Z5gzu++aHtEqUFUYdX3VNJmURzT
         w7wQ==
X-Gm-Message-State: AOJu0Yy15NnCm+VCNUnaM/M5siLN5JbTySaOHZuuCOAXiD6kBwDBibWQ
	Ncg+b8u2XTF6in96Ai/KNZA24cxDdxEPDxX8xXRNK5E4KjdEwlPTbzivuxdeQ81B/8jujmu8FCy
	/gtRGTEkIcyAVLed4OCHxHzaKKYkUXXbnMvqhtYaxDzjRTrm+2A==
X-Received: by 2002:ac8:7f91:0:b0:416:db70:2653 with SMTP id z17-20020ac87f91000000b00416db702653mr8876095qtj.38.1694989555288;
        Sun, 17 Sep 2023 15:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFezqxmfqtGhS2FxPCsYpubnTNK6tACbhkhYR/40Y08aycFwHOLWJhOoCYZSF3ud4i1i0EL+r/CXjLeOYzof7Y=
X-Received: by 2002:ac8:7f91:0:b0:416:db70:2653 with SMTP id
 z17-20020ac87f91000000b00416db702653mr8876059qtj.38.1694989554976; Sun, 17
 Sep 2023 15:25:54 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 Sep 2023 15:25:54 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230916075829.1560-1-jszhang@kernel.org>
References: <20230916075829.1560-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 17 Sep 2023 15:25:54 -0700
Message-ID: <CAJM55Z-_yq3DrOC2KxQf8j5y_iDD7ejEReP4XajUz74iVp02LQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/22] convert to devm_stmmac_probe_config_dt
To: Jisheng Zhang <jszhang@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
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
	Thierry Reding <thierry.reding@gmail.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Russell King <linux@armlinux.org.uk>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jisheng Zhang wrote:
> Russell pointed out there's a new devm_stmmac_probe_config_dt()
> helper now when reviewing my starfive gmac error handling patch[1].
> After greping the code, this nice helper was introduced by Bartosz in
> [2], I think it's time to convert all dwmac users to this helper and
> finally complete the TODO in [2] "but once all users of the old
> stmmac_pltfr_remove() are converted to the devres helper, it will be
> renamed back to stmmac_pltfr_remove() and the no_dt function removed."

Thanks for doing this.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>
> Link: https://lore.kernel.org/netdev/ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk/ [1]
> Link: https://lore.kernel.org/all/20230623100417.93592-1-brgl@bgdev.pl/  [2]
>
> Since v1:
>  - rebase on new net-next
>  - add make stmmac_{probe|remove}_config_dt static as suggested by Russell.
>
> Jisheng Zhang (23):
>   net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-dwc-qos-eth: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-generic: use devm_stmmac_pltfr_probe()
>   net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-ingenic: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-mediatek: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-meson: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sti: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-stm32: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
>   net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
>   net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove
>   net: stmmac: make stmmac_{probe|remove}_config_dt static
>
>  .../ethernet/stmicro/stmmac/dwmac-anarion.c   | 10 +--
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 15 +---
>  .../ethernet/stmicro/stmmac/dwmac-generic.c   | 15 +---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 13 ++--
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++------
>  .../stmicro/stmmac/dwmac-intel-plat.c         | 25 +++----
>  .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   | 27 +++----
>  .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 19 ++---
>  .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  6 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-meson.c | 25 ++-----
>  .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 53 +++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 14 ++--
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 16 ++---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 10 +--
>  .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 14 ++--
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 17 ++---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 23 +++---
>  .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 10 ++-
>  .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 18 ++---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 70 ++++++-------------
>  .../ethernet/stmicro/stmmac/stmmac_platform.h |  5 --
>  22 files changed, 127 insertions(+), 317 deletions(-)
>
> --
> 2.40.1

