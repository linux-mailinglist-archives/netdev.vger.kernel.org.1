Return-Path: <netdev+bounces-163938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D2BA2C1F5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC32F3ABC2B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF21DFE12;
	Fri,  7 Feb 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e96sY7yN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C911DFE13;
	Fri,  7 Feb 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929258; cv=none; b=NDTmnDmIeLSvYCuFBL51FcsuYQVqzIqa5OoU/nKjrT4Y7xcJKQ5vZgPQBFS/a21QQj5uOoWgY/EGvxPqe25Uyq9c+yE2RioHZpQpj/C1vw8b4OuYXv1nux3MeRi9YWablXIRJlUL7JMeAY/gRBXIvKrR9ue3RhT6NO7m/MzyI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929258; c=relaxed/simple;
	bh=Pyd5SRnUMie88L9jistkzWSmfq632eo/gk+zpEzj8sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyokjEvJN9SGeqlgzF1y+JoIGEQSYvOfbL9NlLbCvTMbGA1d6O68TivhDZczZ4Igtdl98sGVjX1DAy3qi2r5I7O1ubEqJFdU85uV0z4vd5kqPFklVSc0UFgZBT+zoJAqX5dXpPuqXL/BzEdsd6RmZK0p++cYkAmHOS9xTgMwuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e96sY7yN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qBgyeIjdQTZseichl9jEZRFND0lwQNXK1CbUo+ClCAs=; b=e96sY7yNrcMjl83QkNaI2XuE+v
	6l06BTe+APtFmOkaSax+Cy5/7Trd0BDPm5XzBm2b0fImCKAQ3MUwa+4pKCNJAS0BaobsLxLRjpupk
	9iugw+9MRbReEBEJmWRlnp9nuec+r7eJb2aKNY0+aN3q5Prv1+pHeVpIm/5U126iS4GcjDtVEfX7d
	3gYJbif29jjZ5PEOgjN94xh7S4xTxWHC3enKCiv0Myoy8Dp46JmXm8SqduQrAj9L/NvbunZJUpRLB
	BBtuAhGqC9DiCz5nb4TDZFqFPotcJ0XmEs5t2Fw4vBubGUcw4inuVg+y4INpUuMHJ8fkiRuNRo+1y
	djBxDXHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47734)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgMvt-0005Vs-2p;
	Fri, 07 Feb 2025 11:54:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgMvr-0004QH-05;
	Fri, 07 Feb 2025 11:54:03 +0000
Date: Fri, 7 Feb 2025 11:54:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Byungho An <bh74.an@samsung.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: sxgbe: rework EEE handling based on
 PHY negotiation
Message-ID: <Z6X0WsUaRw-P-QVt@shell.armlinux.org.uk>
References: <20250207105610.1875327-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207105610.1875327-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

A more in-depth review...

On Fri, Feb 07, 2025 at 11:56:10AM +0100, Oleksij Rempel wrote:
> @@ -228,7 +212,7 @@ static void sxgbe_get_ethtool_stats(struct net_device *dev,
>  	int i;
>  	char *p;
>  
> -	if (priv->eee_enabled) {
> +	if (dev->phydev->eee_active) {
>  		int val = phy_get_eee_err(dev->phydev);
>  
>  		if (val)

Why should the EEE error statistic be dependent on whether EEE has been
negotiated? (I think a follow-up patch addressing this would be
appropriate.)

> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 12c8396b6942..8a385c92a6d1 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> @@ -87,7 +87,7 @@ static void sxgbe_enable_eee_mode(const struct sxgbe_priv_data *priv)
>  		priv->hw->mac->set_eee_mode(priv->ioaddr);
>  }
>  
> -void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv)
> +static void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv)
>  {
>  	/* Exit and disable EEE in case of we are in LPI state. */
>  	priv->hw->mac->reset_eee_mode(priv->ioaddr);

Looking at this function, I think it's buggy and needs fixing prior to
this patch.

This function calls ->reset_eee_mode(), then synchronously deletes the
timer.

However, if the timer is running and fires after ->reset_eee_mode()
has been called, and tx_path_in_lpi_mode is false, then
sxgbe_eee_ctrl_timer() will execute, calling sxgbe_enable_eee_mode().
This will then call set_eee_mode().

In other words, this function is racy if not already called with
tx_path_in_lpi_mode set true - and there are paths in this driver that
does happen (just like in stmmac which I've been fixing - I suspect
one or other driver copied the code since the structure and member
names are identical.)

I would suggest deleting the timer as the very first thing, much like
what I did in:

	net: stmmac: delete software timer before disabling LPI

In fact, given the similarity with stmmac, it's probably worth looking
through my stmmac EEE cleanup patch series, and deciding which of those
changes also apply to sxgbe.

... and given this, I ask again: should there be a generic
software-timer EEE implementation so we're not having to patch multiple
drivers for the same bug(s).

> @@ -110,52 +110,25 @@ static void sxgbe_eee_ctrl_timer(struct timer_list *t)
>  	mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
>  }
>  
> -/**
> - * sxgbe_eee_init
> - * @priv: private device pointer
> - * Description:
> - *  If the EEE support has been enabled while configuring the driver,
> - *  if the GMAC actually supports the EEE (from the HW cap reg) and the
> - *  phy can also manage EEE, so enable the LPI state and start the timer
> - *  to verify if the tx path can enter in LPI state.
> - */
> -bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
> +static void sxgbe_eee_adjust(struct sxgbe_priv_data *priv)
>  {
> -	struct net_device *ndev = priv->dev;
> -	bool ret = false;
> +	struct phy_device *phydev = priv->dev->phydev;
>  
> -	/* MAC core supports the EEE feature. */
> -	if (priv->hw_cap.eee) {
> -		/* Check if the PHY supports EEE */
> -		if (phy_init_eee(ndev->phydev, true))
> -			return false;
> +	if (!priv->hw_cap.eee)
> +		return;
>  
> -		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
> -		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
> +	if (phydev->enable_tx_lpi) {
>  		add_timer(&priv->eee_ctrl_timer);
> -
>  		priv->hw->mac->set_eee_timer(priv->ioaddr,
>  					     SXGBE_DEFAULT_LPI_TIMER,
> -					     priv->tx_lpi_timer);
> -
> -		pr_info("Energy-Efficient Ethernet initialized\n");
> -
> -		ret = true;
> +					     phydev->eee_cfg.tx_lpi_timer);
> +		priv->eee_enabled = true;
> +	} else {
> +		sxgbe_disable_eee_mode(priv);
> +		priv->eee_enabled = false;

Given what sxgbe_tx_all_clean() does, we need priv->eee_enabled set
false and visible to sxgbe_tx_all_clean() before calling
sxgbe_disable_eee_mode(), otherwise sxgbe_tx_all_clean() may race and
add the eee_ctrl_timer back after sxgbe_disable_eee_mode() has
removed it.

> @@ -802,7 +785,7 @@ static void sxgbe_tx_all_clean(struct sxgbe_priv_data * const priv)
>  		sxgbe_tx_queue_clean(tqueue);
>  	}
>  
> -	if ((priv->eee_enabled) && (!priv->tx_path_in_lpi_mode)) {
> +	if (priv->eee_enabled && !priv->tx_path_in_lpi_mode) {
>  		sxgbe_enable_eee_mode(priv);
>  		mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));

As noted above, this can race with sxgbe_disable_eee_mode().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

