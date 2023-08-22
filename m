Return-Path: <netdev+bounces-29604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4828783FE4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6647C2808DD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9821BB3F;
	Tue, 22 Aug 2023 11:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C49440
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:46:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598CCD9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=npsFYkwN/id6A7uDdZP0YXNUUCPKgvunt/3UBBybHhY=; b=JkunwSrYUJpFu3mWdDd0HfRQXL
	M3Lba55CA9ZUedjVwL/jpZhh83aPXgYDfPvbEKmQIDD9e1ildSb0pJtc4HWVHC56LnlggEpdTCBQz
	uu7/ieqV8WisJTKgikAnHrvCgomIsVfQ/BLGy4/FJWkfkgEbgzP51WeFsc4sYcgn7q+EuYEc2oJVo
	kMPHpNusYQMXjIkB8iFP4Ok8pi2QvWlEGaVahK/+X7Skl0z4ICB0DKsLyRXjWSAWaDWYI7C6mi3PH
	VN8AIum6QiBPa9TF+Gf/rKqD3CJjFAmIv3yGTNDadzhiih6mvxIZqJZc11+H49NQpKplmA2zfPwIK
	9dGmxfLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qYPoo-0001Lh-19;
	Tue, 22 Aug 2023 12:45:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qYPol-0005la-7Y; Tue, 22 Aug 2023 12:45:03 +0100
Date: Tue, 22 Aug 2023 12:45:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	guyinggang@loongson.cn, siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v4 11/11] net: stmmac: dwmac-loongson: Add GNET support
Message-ID: <ZOSfv9CcKRRC2kS/@shell.armlinux.org.uk>
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
 <e83b526e0ee0f90ba0e645efec405de957c28bcb.1692696115.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83b526e0ee0f90ba0e645efec405de957c28bcb.1692696115.git.chenfeiyang@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 05:41:19PM +0800, Feiyang Chen wrote:
> @@ -192,6 +192,86 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.config = loongson_gmac_config,
>  };
>  
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed)
> +{

What tree are these patches against? They don't look like the net-next
tree, since net-next has changed the prototype for the fix_mac_speed
method. Also, it would be good for it to be called
"loongson_gnet_fix_mac_speed" so that grepping for "fix_mac_speed"
finds not only the callsite but also the method definitions too.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a98bcd797720..fa4d7b90c5fa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1242,7 +1242,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  	}
>  
>  	/* Half-Duplex can only work with single queue */
> -	if (priv->plat->tx_queues_to_use > 1)
> +	if (priv->plat->tx_queues_to_use > 1 ||
> +	    FIELD_GET(DWEGMAC_DISABLE_HALF_DUPLEX, priv->plat->dwegmac_flags))
>  		priv->phylink_config.mac_capabilities &=
>  			~(MAC_10HD | MAC_100HD | MAC_1000HD);

There have been a number of shortcomings of stmmac's setup of the
phylink MAC capabilities recently, and I think it's getting to the
point where we need someone to bite the bullet and do something
about it.

Constantly extending conditions such as the above doesn't make a
lot of sense.

In patch 9, you've added:

+       priv->phylink_config.mac_capabilities = MAC_10 | MAC_100;
+       if (!FIELD_GET(DWEGMAC_DISABLE_FLOW_CONTROL, priv->plat->dwegmac_flags))
+               priv->phylink_config.mac_capabilities |=
+                       MAC_ASYM_PAUSE | MAC_SYM_PAUSE;

The only two capabilities that are unconditional are MAC_10FD and
MAC_100FD. Everything else is conditional on something.

I'm thinking two things:

1) the stmmac platform implementations should be responsible for
   initialising priv->phylink_config.mac_capabilities

2) phylink may need a function:
   phylink_set_max_speed(struct phylink_config *config, u32 max_speed);
   which does similar to phy_set_max_speed(), but operates on
   mac_capabilities. This can then be used after calling the platform
   setup of priv->phylink_config.mac_capabilities to limit the
   speed. I'm not entirely sure that this is required though. I don't
   think it's required for dwmac-intel, but would possibly be needed
   for stmmac_platform since there's a "max-speed" property in DT.

What I'm basically saying is... let's not make the setup of
mac_capabilities any more convoluted than it already is by adding
new flags which only exist to set or clear other bits.

Also, let's try to stick to positive logic where possible!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

