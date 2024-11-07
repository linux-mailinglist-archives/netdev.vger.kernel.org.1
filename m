Return-Path: <netdev+bounces-142975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3BD9C0D39
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C026B2135D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C8212D19;
	Thu,  7 Nov 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qtfJnzid"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF77192B7F;
	Thu,  7 Nov 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001750; cv=none; b=KFcGl03KNOuVmnWWyAIHUET8BGzoQwjSaAnluIanlxMJoVp1dlG9IXDDw5ky6HaFkI1Bx9CYPcTbfAP0xuIgRuHyA8jeXNL30s+NvZ1P/djOW0EgnNyLOA/qFKQ5dZaG/9EBkE39PWgXgmpFcjXaZ5mObh58bKgNyUaQbFwIz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001750; c=relaxed/simple;
	bh=38vQEQVyuXFw54GkfZ6p3fF+Zaprs/+eOPTRxOzT3LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgoRI7R/DEH+iRg7ejPGSkM8oy3M0cYMVBzIoKIBgkBId2F4nr4tTv9fwrNHkfKBkPUJze0p5RDBCFB0EXWkuKiwST5Gm0oQR5uwLroX0FGVYa9sG8BDLbdZYoWxZafHZMpmBnj0QKpse7qUIMjPnMaRLj826oau+l9qdYKEOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qtfJnzid; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JxlI633Vi9SiSAjqeqLcQKh/Kt9yzivuoR6FozTYQ8E=; b=qtfJnzid187QTXDBwyB7nSHuY6
	aa/6phVBaR+76CjQyFyPbpvNpVG4Ea6GvTrHvlYAxFA/iYLqBnNcDD0QngVsgQOjt9y0ORHyEFStO
	Wh/BdRGJvv1Vo6Z3pfPYP3wbK5jNOC1rCi9qsPY281dvdiWbD2GtBgqeTLPCUwzvfCdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96cv-00CUVr-0A; Thu, 07 Nov 2024 18:49:01 +0100
Date: Thu, 7 Nov 2024 18:49:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 4/7] net: freescale: ucc_geth: Fix WOL
 configuration
Message-ID: <83151aa4-62e9-4be9-ae64-a728be004dae@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-5-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:51PM +0100, Maxime Chevallier wrote:
> The get/set_wol ethtool ops rely on querying the PHY for its WoL
> capabilities, checking for the presence of a PHY and a PHY interrupts
> isn't enough. Address that by cleaning up the WoL configuration
> sequence.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  .../net/ethernet/freescale/ucc_geth_ethtool.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> index fb5254d7d1ba..2a085f8f34b2 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
> @@ -346,26 +346,37 @@ static void uec_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  	struct ucc_geth_private *ugeth = netdev_priv(netdev);
>  	struct phy_device *phydev = netdev->phydev;
>  
> -	if (phydev && phydev->irq)
> -		wol->supported |= WAKE_PHY;
> +	wol->supported = 0;
> +	wol->wolopts = 0;
> +
> +	if (phydev)
> +		phy_ethtool_get_wol(phydev, wol);
> +
>  	if (qe_alive_during_sleep())
>  		wol->supported |= WAKE_MAGIC;

So get WoL will return whatever methods the PHY supports, plus
WAKE_MAGIC is added because i assume the MAC can do that. So depending
on the PHY, it could be the full list:

#define WAKE_PHY		(1 << 0)
#define WAKE_UCAST		(1 << 1)
#define WAKE_MCAST		(1 << 2)
#define WAKE_BCAST		(1 << 3)
#define WAKE_ARP		(1 << 4)
#define WAKE_MAGIC		(1 << 5)
#define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */
#define WAKE_FILTER		(1 << 7)

>  
> -	wol->wolopts = ugeth->wol_en;
> +	wol->wolopts |= ugeth->wol_en;
>  }
>  
>  static int uec_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  {
>  	struct ucc_geth_private *ugeth = netdev_priv(netdev);
>  	struct phy_device *phydev = netdev->phydev;
> +	int ret = 0;
>  
>  	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
>  		return -EINVAL;
> -	else if (wol->wolopts & WAKE_PHY && (!phydev || !phydev->irq))
> +	else if ((wol->wolopts & WAKE_PHY) && !phydev)
>  		return -EINVAL;
>  	else if (wol->wolopts & WAKE_MAGIC && !qe_alive_during_sleep())
>  		return -EINVAL;
>  
> +	if (wol->wolopts & WAKE_PHY)
> +		ret = phy_ethtool_set_wol(phydev, wol);

Here, the code only calls into the PHY for WAKE_PHY, when in fact the
PHY could be handling WAKE_UCAST, WAKE_MCAST, WAKE_ARP etc.

So these conditions are wrong. It could we be that X years ago when
this code was added only WAKE_PHY and WAKE_MAGIC existed?

	Andrew


