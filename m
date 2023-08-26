Return-Path: <netdev+bounces-30871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760D7896E9
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D86281883
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE3DDC1;
	Sat, 26 Aug 2023 13:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EFCA58
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 13:32:21 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9554D2114
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 06:32:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500b3f7f336so196720e87.1
        for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693056739; x=1693661539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkJ7s8OrsLy9BfgJwAFkbNy+c764NK4QgxuZUl0LtFo=;
        b=bUcLauVa3UalyuzHJnik09YWrDw/DeI+/Ao3YFhMPPx9zWGHjn71E0vHNj2inQe6WO
         r26MvoC7HE+ISnOssAMaHidPPi0j8ZsPrAAoB39t0tjH4jGZ4qngR0p/QMqosPvwID3t
         +Z+bb1rHxw6RByu6rw2yCKU6hF5Wo+KZuO6+3D2Gteo7zLjCIwDdYsuALuSKU+oGDd3y
         RssbsMa1FYxf7oq2/S7afqVVWhWgE0KuMhE3rHf/U5xnjZvLI3gqp7cu0gEaPiu5TJhl
         2O7rav7xd339Vd2pGMA2xga+2HkTuPucLKF24jjjVxzQnBxeSfbcytPHsQG7F87Ddq9C
         n4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693056739; x=1693661539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkJ7s8OrsLy9BfgJwAFkbNy+c764NK4QgxuZUl0LtFo=;
        b=aWG81rJGaB+K8pIkUUUZ5674x742S74ZuvU9xz3pg1/rb24Fp40lqIF5snbMTVqb8j
         F7AD2mJbTjzYOJmpefqXPD5il6b6GyWyz9VqlI47B0tnbLEpmA0l+txgmCl8jQ1GsSUJ
         MweNt6sODCFRzDJuXN19u9/xQnfyZEGYfBXXcU08IrAfyeLGzE3tM+nWG5GxPNwBW46O
         6pcxNl5NLZHJatM7u2gLNqP+4UZFPxxvjUT8ghedpTU+V5U/AJ4m2emqVMU7GJMUUk1b
         IfNU6OeRzQhNHzagqzvrz91yQKi6VR+JsPwv/eP9EpetWPO72cSHpa5uladfdxzLySoS
         pAVg==
X-Gm-Message-State: AOJu0Yw7z0woxvj/N8sVR5DrM7q5XxQbW81BvqXZsol4D5ThawmqjvuF
	CLxPb91sX2KG0GlYEgq+gP4=
X-Google-Smtp-Source: AGHT+IER9+Ix/5U4zo/mvxWZ8NAT0EXTNAoaCbHNthqYpZAi1xLAQEQ/2uTxn94TPquRaZnTHv7tdA==
X-Received: by 2002:a05:6512:1042:b0:4fe:d0f:1f1e with SMTP id c2-20020a056512104200b004fe0d0f1f1emr18744343lfb.25.1693056738553;
        Sat, 26 Aug 2023 06:32:18 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004fe39f31dc7sm715616lfq.294.2023.08.26.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 06:32:17 -0700 (PDT)
Date: Sat, 26 Aug 2023 16:32:15 +0300
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
Message-ID: <rpwsyyjdzeixx3f7o3pxeslyff7yc3fuutm436ygjggoyiwjcb@7s3skg627mid>
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

This doesn't look correct. DW XGMAC doesn't support 25/40/50/100Gbps
speeds.

>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxgmac2_rx_queue_enable,
> @@ -1551,6 +1560,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
>  
>  const struct stmmac_ops dwxlgmac2_ops = {
>  	.core_init = dwxgmac2_core_init,

> +	.phylink_get_caps = xgmac_phylink_get_caps,

This is ok.

-Serge(y)

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

