Return-Path: <netdev+bounces-149368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A869E54BA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69345281C3C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAF214A85;
	Thu,  5 Dec 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HDJ8zCgy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188812144DA;
	Thu,  5 Dec 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399865; cv=none; b=iYUniFCvlnmdYCCwballVnC4OJMBEOecOPf5Q3UPwddFM9JgSkd0oYRZFudseqTd8Togz81cy69YCr4ooNYfPBJlI63fiW4689U2HcP6Gj8+9iEzAUdbMwJvQ7XD8221z+DTrbMWErgkusl0g8g+zbfeLsBziyU34hz4TqTY4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399865; c=relaxed/simple;
	bh=+uiBcJiIvel2kfDiIF6PoRyVCcJAncU1koeRrW4tKYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi88RgkAvYzugy4SlkQ1M4CW8bB5FPsEhDCBTCF0W+pzBRJ6IV0+/HlEgzHSQFSk/V3NA5DjUGo/rmUtz2bNBViZ1hrV+QiztmKKI6Ns+uC92oQQDwCkccx5URYl5s5Wu3VeBIXiRT9qOq4LwXZVbynLbB0fZ3Fm6oGsjM9GL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HDJ8zCgy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u3j+c7LSNTbe1vga4y2dI4ayqeRK1+Ql+dyKFyyjVKY=; b=HDJ8zCgynUY+cvvYB3PAxPlpSl
	58GyjAU/TxterkcR0xzihZqh94mUd5iq+9iM8iZCK5Xo9W3XitSxiBy1NSysMhICMg67a4yuXs9SZ
	G0KBMKobNRN9iql2GcMOZo4NnNZyTd5vOrCRBaWUqrmqVVqAV31itz3fww7WD/E4cekfSP3ELI1Bj
	LUTmWrU6fzyz3edveASKq0vcgZqyZbrinqmAHEG6ZClBKQruSyZYQ1VKjFRb8gkPKsXqRFB+8uI0C
	OiYNLV8lxCg8E6cmIzr08ieaBlV24C23nE3t7o4aWQuN6fCOBRJr1XDbg5pRY+DxA5ox5jGPz7yoI
	uHnq0J+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46374)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAUA-0004hb-34;
	Thu, 05 Dec 2024 11:57:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAU9-0006WN-15;
	Thu, 05 Dec 2024 11:57:33 +0000
Date: Thu, 5 Dec 2024 11:57:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <Z1GVLf0RaYCP060b@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 08:56:15AM +0100, Oleksij Rempel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/linux/phy.h     | 10 ++++++++++
>  net/ethtool/linkstate.c | 25 ++++++++++++++++++++++---
>  net/ethtool/stats.c     | 19 +++++++++++++++++++
>  3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 563c46205685..523195c724b5 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1090,6 +1090,16 @@ struct phy_driver {
>  	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
>  
>  	/* Get statistics from the PHY using ethtool */
> +	/**
> +	 * @get_phy_stats: Get well known statistics.
> +	 * @get_link_stats: Get well known link statistics.
> +	 * The input structure is not zero-initialized and the implementation
> +	 * must only set statistics which are actually collected by the device.

Eh what? This states to me that the structure is not initialised, but
drivers should not write to all members unless they support the
statistic.

Doesn't this mean we end up returning uninitialised data to userspace?
If the structure is not initialised, how does core code know which
statistics the driver has set to avoid returning uninitialised data?

Also, one comment per function pointer please.

> +	 */
> +	void (*get_phy_stats)(struct phy_device *dev,
> +			      struct ethtool_eth_phy_stats *eth_stats);
> +	void (*get_link_stats)(struct phy_device *dev,
> +			       struct ethtool_link_ext_stats *link_stats);
>  	/** @get_sset_count: Number of statistic counters */
>  	int (*get_sset_count)(struct phy_device *dev);
>  	/** @get_strings: Names of the statistic counters */
> diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> index 34d76e87847d..8d3a38cc3d48 100644
> --- a/net/ethtool/linkstate.c
> +++ b/net/ethtool/linkstate.c
> @@ -94,6 +94,27 @@ static int linkstate_get_link_ext_state(struct net_device *dev,
>  	return 0;
>  }
>  
> +static void
> +ethtool_get_phydev_stats(struct net_device *dev,
> +			 struct linkstate_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev)
> +		return;
> +
> +	if (dev->phydev)
> +		data->link_stats.link_down_events =
> +			READ_ONCE(dev->phydev->link_down_events);
> +
> +	if (!phydev->drv || !phydev->drv->get_link_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_link_stats(phydev, &data->link_stats);
> +	mutex_unlock(&phydev->lock);

I don't like the idea of code outside of phylib fiddling around with
phy_device members. Please make the bulk of this a function in phylib,
and then do:

	if (phydev)
		phy_ethtool_get_stats(phydev, &data->link_stats);

However, at that point it's probably not worth having the separate
function, and it might as well be placed in linkstate_prepare_data().

> +}
> +
>  static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>  				  struct ethnl_reply_data *reply_base,
>  				  const struct genl_info *info)
> @@ -127,9 +148,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>  			   sizeof(data->link_stats) / 8);
>  
>  	if (req_base->flags & ETHTOOL_FLAG_STATS) {
> -		if (dev->phydev)
> -			data->link_stats.link_down_events =
> -				READ_ONCE(dev->phydev->link_down_events);
> +		ethtool_get_phydev_stats(dev, data);
>  
>  		if (dev->ethtool_ops->get_link_ext_stats)
>  			dev->ethtool_ops->get_link_ext_stats(dev,
> diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
> index 912f0c4fff2f..cf802b1cda6f 100644
> --- a/net/ethtool/stats.c
> +++ b/net/ethtool/stats.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <linux/phy.h>
> +
>  #include "netlink.h"
>  #include "common.h"
>  #include "bitset.h"
> @@ -112,6 +114,19 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
>  	return 0;
>  }
>  
> +static void
> +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
> +	mutex_unlock(&phydev->lock);

Ditto.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

