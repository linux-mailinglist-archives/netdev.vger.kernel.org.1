Return-Path: <netdev+bounces-175359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592AA655DF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F373B4B08
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3612459E3;
	Mon, 17 Mar 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqwiPJhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A9241693;
	Mon, 17 Mar 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225866; cv=none; b=e7btnApv+ibzoqUmkfU+rfoWymtSnpKF06GdzPENnZJlZahsCCLvwhV7Xbd3nTdZaWoL1/yl8RxpuATbj1ndWs4xmtEpF8DnPn1rqdR2ETG9Q5czn1GiltYhz1X/zJ2YD1vABTsqo+B39v4wup1+ne0qntFCFMBu/5NnnYI24gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225866; c=relaxed/simple;
	bh=Vmb7OHXLeLFxxatKpV27HQCu9e0wYpkMX0Lb5PFR1D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1yu8bqWDrqKg9dxx2Bf4WZwXJCT350qapvIMGbFVh8XsHEfGP1QOYVms3H02kuOrENTgGBtaYp5nkoKOqXaFPOQ+uSsx/xV3oSdcXTXIBOSwkNZCL5D23LfxtCCA0Zc+zPJAB1X/OPbY8BFozTX7jg7SKE752lY2HoaQa2LzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqwiPJhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25872C4CEE3;
	Mon, 17 Mar 2025 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742225865;
	bh=Vmb7OHXLeLFxxatKpV27HQCu9e0wYpkMX0Lb5PFR1D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqwiPJhpnhXrXAoNMXX88djXM7y7+q7giDpCdggqlEH5K55GCJTCkUh4iPEa6pNm1
	 qdKgsuQVYVZ9Ik+Odi4mm/Q61kfNEAv88j8Sv9FGra4OEgXuBQ0G3qP2Paljzl03k0
	 TslkHxCxYskRnHKunwi+iIJ1PQBSMKI0EucAMi1eVUrFzn2m1RbIPQX1OhoxrY45Q5
	 Cb6K081b1UjSB+W5mtLVSilJa0grUpltvD4vsT8zdIzvh6g/eeDQtZNh1OHzzcY3fi
	 H4XseTUg39DQEM4T+fHh1Gjdde5Ztm0kIUOBBR4wNURUeDM9gzKy5g8uX/jfQmvlHs
	 ad/6liK2MQKZw==
Date: Mon, 17 Mar 2025 15:36:11 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v3 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <20250317153611.GB688833@kernel.org>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
 <20250310115737.784047-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115737.784047-2-o.rempel@pengutronix.de>

On Mon, Mar 10, 2025 at 12:57:31PM +0100, Oleksij Rempel wrote:

...

> +static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
> +{
>  	struct phy_device *phydev;
> +	int ret;

nit: not strictly related to this patch as the problem already existed,
     but ret is set but otherwise unused in this function. Perhaps
     it can be removed at some point?

     Flagged by W=1 builds.

> +	u32 buf;
>  
>  	phydev = phy_find_first(dev->mdiobus);
>  	if (!phydev) {
> -		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> -		if (IS_ERR(phydev)) {
> -			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
> -			return NULL;
> -		}
> -		netdev_dbg(dev->net, "Registered FIXED PHY\n");
> -		dev->interface = PHY_INTERFACE_MODE_RGMII;
> +		netdev_dbg(dev->net, "PHY Not Found!! Forcing RGMII configuration\n");
>  		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
>  					MAC_RGMII_ID_TXC_DELAY_EN_);
>  		ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);

...

> @@ -4256,13 +4281,13 @@ static void lan78xx_delayedwork(struct work_struct *work)
>  		}
>  	}
>  
> -	if (test_bit(EVENT_LINK_RESET, &dev->flags)) {
> +	if (test_bit(EVENT_PHY_INT_ACK, &dev->flags)) {
>  		int ret = 0;
>  
> -		clear_bit(EVENT_LINK_RESET, &dev->flags);
> -		if (lan78xx_link_reset(dev) < 0) {
> -			netdev_info(dev->net, "link reset failed (%d)\n",
> -				    ret);
> +		clear_bit(EVENT_PHY_INT_ACK, &dev->flags);
> +		if (lan78xx_phy_int_ack(dev) < 0) {
> +			netdev_info(dev->net, "PHY INT ack failed (%pe)\n",
> +				    ERR_PTR(ret));

nit: ret is always 0 here. So I'm unsure both why it is useful to include
     in the error message, and why ERR_PTR() is being used.

     Flagged by Smatch.

>  		}
>  	}
>  

...

