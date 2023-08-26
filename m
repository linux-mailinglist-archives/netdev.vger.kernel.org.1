Return-Path: <netdev+bounces-30872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBE7896EC
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210211C209A8
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BCEDDC5;
	Sat, 26 Aug 2023 13:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940CD314
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 13:36:53 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B92110
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 06:36:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so2817703e87.3
        for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693057009; x=1693661809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VkMa5W6uY3fSZYkhCX3GMktDqjJzGb0eTy0nnjALzA=;
        b=VUfosENc6y/n5gCCAAAV0zZo9DYMBol7CZSu70vmZ8hUuszuGjKhgjIZCU3gtz1iTv
         FkO531+MIkQf60yH9909064vmM6yWSrvW3nCxwbiGGViKxnwg3fiIU0oQq/t6wHEVS/K
         5sS0xpIrNmYc1DGhp9K4Iq6EqLKKwwJEFIWno6iZv9/iOqfZZJZCw3Tv5T9R7l9EReWD
         E5K5mlAS7ZNVpWRcyqxl094bjusJa6PeYZH8WN+DveFayodNCFeUW3kWAZXMII9HMY9o
         Aa1i/Ki6lxWyGRg6AI98e16s7EJa1lvek+iSRGz/wfElDGOAKazfFOh1HSDuJbz9r3s4
         uNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693057009; x=1693661809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VkMa5W6uY3fSZYkhCX3GMktDqjJzGb0eTy0nnjALzA=;
        b=K9JnakJRQUucEYuYoACzOdfEc4th/MZhTVlC+AtctP0HDRGwJ0xy0ONgnd1mma/qKj
         bYQtgGARQZo737QK5gQd46hT0Lb/MOekhI65xDkEpHvuzS4nf8s/3Z/cXl4xEOK6pxeH
         XQwsNKctlFGmDijUZWZ8hUFrvSouERjqmWuME8LiblgQVx75vQ2IeayjX7mjtUn8tx3u
         2gY5evQy3JZgKXbQKJyntB2AlMbPnru70e9KwppUrQWI71IsS7iaS2kWtBvU41olH0aN
         alV5e11+O2DSWTSDSqjSVjdYw+C6Td4CLZpHf/OqdoNmasw10dZs4+3u+NZszeSWKpM9
         1exg==
X-Gm-Message-State: AOJu0Yw2u1us8MJC3QhLM6eV2U7/K58OpH4SYvye1Fj168R3i9XA/nz8
	Wo518gjIocYgQYCGxMr63rI=
X-Google-Smtp-Source: AGHT+IECrT/f4YU7eGYMT2JKLqncJPJWUk/GN3HdGnXoaiZGZEg51ifpGDI4TjkBwNtKbaT99ZyWtw==
X-Received: by 2002:a05:6512:b22:b0:4fe:df2:b82d with SMTP id w34-20020a0565120b2200b004fe0df2b82dmr15910554lfu.37.1693057009281;
        Sat, 26 Aug 2023 06:36:49 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id c3-20020ac24143000000b004ff8631d6c0sm709430lfi.278.2023.08.26.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 06:36:48 -0700 (PDT)
Date: Sat, 26 Aug 2023 16:36:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/10] net: stmmac: move xgmac specific phylink
 caps to dwxgmac2 core
Message-ID: <m6wo7hsk2wy2sgwjxlj37u5zg3iba7ecgjrvmhvkw7kdm7o6j7@ggcag6ziyk4c>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
 <E1qZAXd-005pUP-JL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qZAXd-005pUP-JL@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:38:29PM +0100, Russell King (Oracle) wrote:
> Move the xgmac specific phylink capabilities to the dwxgmac2 support
> core.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 10 ++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 34e1b0c3f346..f352be269deb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
>  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
>  }
>  

> +static void xgmac_phylink_get_caps(struct stmmac_priv *priv)

Also after splitting this method up into DW XGMAC v2.x and DW XLGMAC
v2.x specific functions please preserve the local naming convention:
use dwxgmac2_ and dwxlgmac2_ prefixes.

-Serge(y)

> +{
> +	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
> +						 MAC_10000FD | MAC_25000FD |
> +						 MAC_40000FD | MAC_50000FD |
> +						 MAC_100000FD;
> +}
> +
>  static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
>  {
>  	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
> @@ -1490,6 +1498,7 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
>  
>  const struct stmmac_ops dwxgmac210_ops = {
>  	.core_init = dwxgmac2_core_init,
> +	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxgmac2_rx_queue_enable,
> @@ -1551,6 +1560,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
>  
>  const struct stmmac_ops dwxlgmac2_ops = {
>  	.core_init = dwxgmac2_core_init,
> +	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0b02845e7e9d..5cf8304564c6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1227,16 +1227,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  	/* Get the MAC specific capabilities */
>  	stmmac_mac_phylink_get_caps(priv);
>  
> -	if (priv->plat->has_xgmac) {
> -		priv->phylink_config.mac_capabilities |= MAC_2500FD;
> -		priv->phylink_config.mac_capabilities |= MAC_5000FD;
> -		priv->phylink_config.mac_capabilities |= MAC_10000FD;
> -		priv->phylink_config.mac_capabilities |= MAC_25000FD;
> -		priv->phylink_config.mac_capabilities |= MAC_40000FD;
> -		priv->phylink_config.mac_capabilities |= MAC_50000FD;
> -		priv->phylink_config.mac_capabilities |= MAC_100000FD;
> -	}
> -
>  	/* Half-Duplex can only work with single queue */
>  	if (priv->plat->tx_queues_to_use > 1)
>  		priv->phylink_config.mac_capabilities &=
> -- 
> 2.30.2
> 
> 

