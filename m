Return-Path: <netdev+bounces-232933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB71C09FAE
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD171890BFC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC72E2679;
	Sat, 25 Oct 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fTxVjdRA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF1E1C22;
	Sat, 25 Oct 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761424590; cv=none; b=MtgNxQWwUz9d31nfgkhp4MLbKFKKUJmRRsyoOjLgR4GHivrALuiGp8ii/LjvU1RdHhcD8gAx1MfhKKMkHHBj38b0qZtBcK3m9lv5WDRn2zP2oVw4uLhXaygwBVq2RIIm+brLmLEA9fc6IzlDGtW063oKCNqXlFFxj9sMZzHkMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761424590; c=relaxed/simple;
	bh=LouDdHQATE+e9wPl0AZYMugy2rVWvR4HPfXrhjlW9EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUufj8ucpsnrvmA6NruZTTySs/KOoJnGRQFuX9NLbdBxGc7iWIvloF/YEuvARkOuvPXDQINXvTJVZsmS2VCQ4pH3mODyWdxIzar586uFAFZe0QBxESZAdESzBSrBsSqsZJBmdXMWr3/1jY2XYRtxXYUhr4CVr/P3HbfOHJS88lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fTxVjdRA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fFb8a4MiQzJjJNDBUT9PdXXwC4utxv2vDZJA5zBqRTg=; b=fTxVjdRABNw94iQ5qsgAUSOe0Z
	lggkW4Q1HlDvl+ZCNtZDZmxmJ+/3tTd2rzw/xUEn3N+JdQp6UYuj9hm4StBZmzw9TndQbJ/BfgrBe
	pq1R5qOSaOq566qLKoY2LEEe0zytQmx38TbAmhhjHeZYbeFBgK8/hpjCSMGzoFIB/94sf8PBZou9a
	Noi49bH2TVsBceWtsssjU5Wv8CNTjji2Iyu8nnZWvety2VIFVGpWzI5ZotjLIFRxX4OByl6NlXihY
	LT9ZgGqHFYdfls4sgDl32n2comvEL2wgWBCIhO7xpBeJqlwltytD/MMGhHGr++302FztABLBhln8r
	CMmlP9NA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44906)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCkzs-000000000Ns-3tE4;
	Sat, 25 Oct 2025 21:36:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCkzr-000000003zc-1IOQ;
	Sat, 25 Oct 2025 21:36:19 +0100
Date: Sat, 25 Oct 2025 21:36:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] net: airoha: add phylink support for GDM1
Message-ID: <aP00w4CQdeX9GIJA@shell.armlinux.org.uk>
References: <20251023145850.28459-1-ansuelsmth@gmail.com>
 <20251023145850.28459-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023145850.28459-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 23, 2025 at 04:58:49PM +0200, Christian Marangi wrote:
> In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> that is an INTERNAL port for the Embedded Switch.
> 
> Add all the phylink start/stop and fill in the MAC capabilities and the
> internal interface as the supported interface.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/Kconfig      |  1 +
>  drivers/net/ethernet/airoha/airoha_eth.c | 77 +++++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h |  3 +
>  3 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> index ad3ce501e7a5..3c74438bc8a0 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -2,6 +2,7 @@
>  config NET_VENDOR_AIROHA
>  	bool "Airoha devices"
>  	depends on ARCH_AIROHA || COMPILE_TEST
> +	select PHYLIB

This looks wrong if you're using phylink.

>  	help
>  	  If you have a Airoha SoC with ethernet, say Y.
>  
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index ce6d13b10e27..deba909104bb 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
>  	struct airoha_gdm_port *port = netdev_priv(dev);
>  	struct airoha_qdma *qdma = port->qdma;
>  
> +	phylink_start(port->phylink);
> +
>  	netif_tx_start_all_queues(dev);
>  	err = airoha_set_vip_for_gdm_port(port, true);
>  	if (err)

phylink_start() _can_ bring the carrier up immediately. Is the netdev
ready to start operating at the point phylink_start() has been called?
This error handling suggests the answer is "no", and the lack of
phylink_stop() in the error path is also a red flag.

> @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
>  		}
>  	}
>  
> +	phylink_stop(port->phylink);
> +
>  	return 0;
>  }
>  
> @@ -2813,6 +2817,18 @@ static const struct ethtool_ops airoha_ethtool_ops = {
>  	.get_link		= ethtool_op_get_link,
>  };
>  
> +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> +			phy_interface_t interface)

I'd write this as:

static struct phylink_pcs *
airoha_phylink_mac_select_pcs(struct phylink_config *config,
			      phy_interface_t interface)

but:

> +{
> +	return NULL;
> +}

Not sure what the point of this is, as this will be the effect if
this function is not provided.

> +
> +static void airoha_mac_config(struct phylink_config *config,
> +			      unsigned int mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
>  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
>  {
>  	int i;
> @@ -2857,6 +2873,57 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
>  	return false;
>  }
>  
> +static void airoha_mac_link_up(struct phylink_config *config,
> +			       struct phy_device *phy, unsigned int mode,
> +			       phy_interface_t interface, int speed,
> +			       int duplex, bool tx_pause, bool rx_pause)
> +{
> +}
> +
> +static void airoha_mac_link_down(struct phylink_config *config,
> +				 unsigned int mode, phy_interface_t interface)
> +{
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops = {
> +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> +	.mac_config = airoha_mac_config,
> +	.mac_link_up = airoha_mac_link_up,
> +	.mac_link_down = airoha_mac_link_down,
> +};

All the called methods are entirely empty, meaning that anything that
phylink reports may not reflect what is going on with the device.

Is there a plan to implement these methods?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

