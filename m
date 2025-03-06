Return-Path: <netdev+bounces-172349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF96A544DB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62963A4B6B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBAA2046B1;
	Thu,  6 Mar 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QgCkjePB"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599318DB05
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249743; cv=none; b=Z/F3sFyM5wF0zQGaK6UfL6HhMoTbT5TwGgcK5c/Rk+4K8OyW2y87ErvgXjOYovjV3K25HP0AuU2No+IwTe3AVNrq8mblE8lnh4Vh10+3BtsVTeDIyWgwgnqDZ9EWM61ivpe0HTfDutKodatjrcbhxdUHL6KUbFU9JnnwTY0bFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249743; c=relaxed/simple;
	bh=jQiuKmTVOLPCDevGoVKKqxh6D3jLGITRYu7gxxYO60o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3+pU7A0EPdKLoRx+F/IO9f8E+vhT0hdyD7n1iO2SuPqN9yDz9Qy8tI54ixY+995U12kPext8v/uq3gRJTSCPwDuDLl7Ll3mQJHqOBfYOw+tAPalTycafALZ+gz/xZBqhDPmwXhnB82BQvCrfG/bZh1EP1YDcTbzOuSxHKFA8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QgCkjePB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 284A044537;
	Thu,  6 Mar 2025 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741249739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLaGdp8YbDuKJDS27qr7DpF30lE39Y2UTMae3idzC+k=;
	b=QgCkjePBKvLNC63g9kZ5aWfuy70/ftJqqY7atcr7qEA2lv4rKFNJbjUByT/KLZptwsScbU
	J5AyCoEa/nSAgpbu/XxmJUJHKkWE7Vw2rVX0mePVVfDOQAeuiYobvqs4VOTW7EZTymPpz/
	G5DuKRw0kKlJ+qPr0Z+Ak9DJnK10JT3czoUGqBPjaaXBMHsqMDlI45haZ9yFLdaMYGWhn/
	h8iLuwQgVulxGTUGO8GBJohSvnddf+Mns//HDwvFzh6XlvO8v8BUlamYtpAMt3MxYX03eR
	BG5NcsU0pjcG2pUVpfI5IuVW9JQlL0+mhJNT+5zBegg6g1JMw462WDdstbAXAA==
Date: Thu, 6 Mar 2025 09:28:57 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "Lad,  Prabhakar" <prabhakar.csengg@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew@lunn.ch>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: phylink: add functions to
 block/unblock rx clock stop
Message-ID: <20250306092857.5cafd6d4@fedora.home>
In-Reply-To: <E1tpt2t-005UNB-MC@rmk-PC.armlinux.org.uk>
References: <Z8iRM8Q9Sb-y3fR_@shell.armlinux.org.uk>
	<E1tpt2t-005UNB-MC@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepjhhonhgrthhhrghnhhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthhrvgguihhnghesnhhvihgui
 hgrrdgtohhmpdhrtghpthhtohepphhrrggshhgrkhgrrhdrtghsvghnghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 05 Mar 2025 18:00:39 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Some MACs require the PHY receive clock to be running to complete setup
> actions. This may fail if the PHY has negotiated EEE, the MAC supports
> receive clock stop, and the link has entered LPI state. Provide a pair
> of APIs that MAC drivers can use to temporarily block the PHY disabling
> the receive clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I only have comments on the implementation, see below :)

> ---
>  drivers/net/phy/phylink.c | 50 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  3 +++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a3b186ab3854..8f93b597d019 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -88,6 +88,7 @@ struct phylink {
>  	bool mac_enable_tx_lpi;
>  	bool mac_tx_clk_stop;
>  	u32 mac_tx_lpi_timer;
> +	u8 mac_rx_clk_stop_blocked;
>  
>  	struct sfp_bus *sfp_bus;
>  	bool sfp_may_have_phy;
> @@ -2592,6 +2593,55 @@ void phylink_stop(struct phylink *pl)
>  }
>  EXPORT_SYMBOL_GPL(phylink_stop);
>  
> +
> +void phylink_rx_clk_stop_block(struct phylink *pl)
> +{
> +	ASSERT_RTNL();
> +
> +	if (pl->mac_rx_clk_stop_blocked == U8_MAX) {
> +		phylink_warn(pl, "%s called too many times - ignoring\n",
> +			     __func__);
> +		dump_stack();
> +		return;
> +	}
> +
> +	/* Disable PHY receive clock stop if this is the first time this
> +	 * function has been called and clock-stop was previously enabled.
> +	 */
> +	if (pl->mac_rx_clk_stop_blocked++ == 0 &&
> +	    pl->mac_supports_eee_ops && pl->phydev)
> +	    pl->config->eee_rx_clk_stop_enable)

Looks like there's an extra closing ')' here

> +		phy_eee_rx_clock_stop(pl->phydev, false);
> +}

Do you need an EXPORT_SYMBOL_GPL here as this will be used by MAC
drivers?

> +
> +/**
> + * phylink_rx_clk_stop_unblock() - unblock PHY ability to stop receive clock
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * All calls to phylink_rx_clk_stop_block() must be balanced with a
> + * corresponding call to phylink_rx_clk_stop_unblock() to restore the PHYs
> + * clock stop ability.
> + */
> +void phylink_rx_clk_stop_unblock(struct phylink *pl)
> +{
> +	ASSERT_RTNL();
> +
> +	if (pl->mac_rx_clk_stop_blocked == 0) {
> +		phylink_warn(pl, "%s called too many times - ignoring\n",
> +			     __func__);
> +		dump_stack();
> +		return;
> +	}
> +
> +	/* Re-enable PHY receive clock stop if the number of unblocks matches
> +	 * the number of calls to the block function above.
> +	 */
> +	if (--pl->mac_rx_clk_stop_blocked == 0 &&
> +	    pl->mac_supports_eee_ops && pl->phydev &&
> +	    pl->config->eee_rx_clk_stop_enable)
> +		phy_eee_rx_clock_stop(pl->phydev, true);
> +}

Same for the EXPORT_SYMBOL_GPL

Thanks,

Maxime

