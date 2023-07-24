Return-Path: <netdev+bounces-20378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA275F396
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864B72814E6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1184C8F;
	Mon, 24 Jul 2023 10:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E815B9
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:40:39 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763DE7D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E+0A3tHhR2iPvLG0SloVh59oDSaQvqrdwSbyC7fXGtc=; b=godSPV78Mhm2NRN4TKx+BEOfe/
	fyNTHqlnhAFOL/TiyzE3apI4N191yJ1ZcHj9CrkerspZLmFw9PTSx7S8D4emWSKRJqibAw43kUZAB
	VOj7/tCjzzXElIBhIZxFweP5mIobvvbK/Jdspk/Oeopb35t7AJi9Z3q1X9M8wuyqh4kKlYloUhblH
	Qhk4ns4lqj9fc788LNwoRQ6XZfIohUJxNjeVjzSpiwhcvSFvMujRP3JmWzCzb8CP/sZdq0BYtQ5sq
	0BuyIe0dceiq2I5wx+28TkwQWKBH7BDE9smNqJtX8RyYhW4RfzQ7uISv0FrAq0c84m457vBVf7yMR
	DD/+zoUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51818)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNsz7-0008Ko-1J;
	Mon, 24 Jul 2023 11:40:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNsz6-0000jH-JU; Mon, 24 Jul 2023 11:40:12 +0100
Date: Mon, 24 Jul 2023 11:40:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 5/7] net: txgbe: support switching mode to
 1000BASE-X and SGMII
Message-ID: <ZL5VDJeoRYy37LY/@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-6-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:23:39PM +0800, Jiawen Wu wrote:
> @@ -185,6 +186,8 @@ static void txgbe_mac_link_up(struct phylink_config *config,
>  	struct wx *wx = netdev_priv(to_net_dev(config->dev));
>  	u32 txcfg, wdg;
>  
> +	txgbe_enable_sec_tx_path(wx);
> +
>  	txcfg = rd32(wx, WX_MAC_TX_CFG);
>  	txcfg &= ~WX_MAC_TX_CFG_SPEED_MASK;
>  
> @@ -210,8 +213,20 @@ static void txgbe_mac_link_up(struct phylink_config *config,
>  	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
>  }
>  
> +static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct wx *wx = netdev_priv(to_net_dev(config->dev));
> +
> +	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
> +	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
> +
> +	return txgbe_disable_sec_tx_path(wx);

Is there a reason why the sec_tx_path is enabled/disabled asymmetrically?

I would expect the transmit path to be disabled in mac_link_down() and
re-enabled in mac_link_up().

Alternatively, if it just needs to be disabled for reconfiguration,
I would expect it to be disabled in mac_prepare() and re-enabled in
mac_finish().

The disable in mac_prepare() and enable in mac_link_up() just looks
rather strange, because it isn't symmetrical.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

