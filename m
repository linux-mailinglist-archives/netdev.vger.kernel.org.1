Return-Path: <netdev+bounces-292373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PxRBLkaF2ov4gcAu9opvQ
	(envelope-from <netdev+bounces-292373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D215E7B60
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8980301B17A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137D383C97;
	Wed, 27 May 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2ke7Gt4i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191B236453;
	Wed, 27 May 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899060; cv=none; b=rL2aT6R4nTKWi6E7DodbUdtdzeCAAQGcrpMAe/pL0/CNFNw8ddCGaevGHLKLfN+mD3qmdDxOFlKFM8Jnu1VFyEdK14l8Q9l5Vnff0kodYalLjAqDUbZHSsN/6bBHgUNS3xdGFns82kSMeup1oJZkcXmdIvXenUu3I+/WQkyhoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899060; c=relaxed/simple;
	bh=TFrgGO/XiuqqZZfDayEw9SkerkHu4wjjlqv+8Q2Tfzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNLeGJRdUpBejVfkZmuStP5TuvZCyqpm9Vuk8jy3w64kQpkWFzrGemR7/2j/YEr5brcbgS1BXFEV/dwidaiqy8GzF5FlxSDy3eFEabnw5lhBQc0vOXYySAnuJYp1JHSX84Z7gZPEBIr3kkpM4i+VcILfLeJnzPCIhG3ZLdB365k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2ke7Gt4i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UhnV0yrEXFfGpI62KLDZ9bmC/Fur2JQYbbwMnScnudk=; b=2ke7Gt4iErhpJaP9YSMiaJbEyk
	GSU05eOGoc7qU/1bkRT8rGjaZv5VhSH2hxpt9076iWrsvVenj33cO4WmfX92/VDug9VK9UZlfaHkF
	J6UmhdvzSyX+GTmd4UkmlDP8I3F2vsHnEOAIJhc62S4WJZG3WGkgZ/TaJnTjE/zAYET8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSH30-004mAM-5O; Wed, 27 May 2026 18:23:58 +0200
Date: Wed, 27 May 2026 18:23:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83822: Add optional external PHY clock
Message-ID: <48b4b96b-c815-40d0-98ae-0c5fbdde0c9e@lunn.ch>
References: <20260527153903.216104-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527153903.216104-1-wahrenst@gmx.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292373-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80D215E7B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> @@ -203,6 +204,7 @@ struct dp83822_private {
>  	u8 cfg_dac_minus;
>  	u8 cfg_dac_plus;
>  	struct ethtool_wolinfo wol;
> +	struct clk *clk;
>  	bool set_gpio2_clk_out;
>  	u32 gpio2_clk_out;
>  	bool led_pin_enable[DP83822_MAX_LED_PINS];
> @@ -984,13 +986,19 @@ static int dp83822_attach_mdi_port(struct phy_device *phydev,
>  
>  static int dp8382x_probe(struct phy_device *phydev)
>  {
> +	struct device *dev = &phydev->mdio.dev;
>  	struct dp83822_private *dp83822;
>  
> -	dp83822 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
> +	dp83822 = devm_kzalloc(dev, sizeof(*dp83822),
>  			       GFP_KERNEL);

Logically, these two changes have nothing to do with clocks. So they
should be in a different patch.

>  	if (!dp83822)
>  		return -ENOMEM;
>  
> +	dp83822->clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(dp83822->clk))
> +		return dev_err_probe(dev, PTR_ERR(dp83822->clk),
> +				     "Failed to request ref clock\n");

There is no use of dp83822->clk other than here. So there is no need
to store it in the private structure. You can use a local variable.

    Andrew

---
pw-bot: cr

