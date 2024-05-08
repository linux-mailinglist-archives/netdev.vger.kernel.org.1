Return-Path: <netdev+bounces-94545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3918BFD0C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68707281474
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21183CBE;
	Wed,  8 May 2024 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rABXu5Gc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963B83CBA
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170894; cv=none; b=TjZbZ8Dg+vzkz1WFZnwSofD4PuMMCGFa3sl/86ZzUeYLI0p5TwFNcHv7yeIeg2evRjq5FLkkbittll3ZXIvBUqhTjAlTdKfpI5qu57JFp0KVrLUKotrLCYUdIm3b+Rlb6FOn6D1uJFDSB3SvgZO+rGS6/Cz6T4EI93s8fQd4iCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170894; c=relaxed/simple;
	bh=l+IWure0cwUgaCJZ72oeeWqRuOJdecIr23gE1ahOiQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa/lTM6hFdsa7e0hTJApU0TZh0NeXCc+5FwNXLsixlCcW8WHVNy1xoyOaaWJGOPKC80vv+CzmxCJ1F5Wxnov86lxyVO1kRecFG/atFf7LroN8ReXoLd0oLXjq7AKMw3LOVYYPKya7F0zY0fdSxtrN8KUMqQOVcQqxDL0/vcrUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rABXu5Gc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KcTLCCnEzVX8LVp5wO4FJqgHlHo+PpVzy2kPZudyaSc=; b=rABXu5Gcrw35no7uTyhuILYk9B
	R9n6TSrS/TGV7y0N3SAH/2QoF9RePMeQEZKvfGUcAkpFUrqvri6+swQKSOg6Yg7J6AHRzwirfk7O+
	t8fcRW1Y/bMkDvUY3osttjlAJ38oc5LhXcugoytvR1AZGEWq9jNmkUjp8XVxqdfUAcuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4gIb-00Ewnt-Uu; Wed, 08 May 2024 14:21:29 +0200
Date: Wed, 8 May 2024 14:21:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
	horms@kernel.org
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
Message-ID: <7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
 <20240501230552.53185-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501230552.53185-7-fujita.tomonori@gmail.com>

On Thu, May 02, 2024 at 08:05:52AM +0900, FUJITA Tomonori wrote:
> This patch adds supports for multiple PHY hardware with PHYLIB. The
> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
> 
> For now, the PCI ID table of this driver enables adapters using only
> QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
> Edimax EN-9320 10G adapter.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/ethernet/tehuti/Kconfig    |  1 +
>  drivers/net/ethernet/tehuti/Makefile   |  2 +-
>  drivers/net/ethernet/tehuti/tn40.c     | 34 ++++++++++---
>  drivers/net/ethernet/tehuti/tn40.h     |  7 +++
>  drivers/net/ethernet/tehuti/tn40_phy.c | 67 ++++++++++++++++++++++++++
>  5 files changed, 104 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
> 
> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> index 4198fd59e42e..6ad5d37eb0e4 100644
> --- a/drivers/net/ethernet/tehuti/Kconfig
> +++ b/drivers/net/ethernet/tehuti/Kconfig
> @@ -27,6 +27,7 @@ config TEHUTI_TN40
>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>  	depends on PCI
>  	select FW_LOADER
> +	select PHYLINK
>  	help
>  	  This driver supports 10G Ethernet adapters using Tehuti Networks
>  	  TN40xx chips. Currently, adapters with Applied Micro Circuits
> diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/tehuti/Makefile
> index 7a0fe586a243..0d4f4d63a65c 100644
> --- a/drivers/net/ethernet/tehuti/Makefile
> +++ b/drivers/net/ethernet/tehuti/Makefile
> @@ -5,5 +5,5 @@
>  
>  obj-$(CONFIG_TEHUTI) += tehuti.o
>  
> -tn40xx-y := tn40.o tn40_mdio.o
> +tn40xx-y := tn40.o tn40_mdio.o tn40_phy.o
>  obj-$(CONFIG_TEHUTI_TN40) += tn40xx.o
> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index db1f781b8063..bf9c00513a0c 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -7,6 +7,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/phylink.h>
>  
>  #include "tn40.h"
>  
> @@ -1185,21 +1186,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
>  	u32 link = tn40_read_reg(priv,
>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>  	if (!link) {
> -		if (netif_carrier_ok(priv->ndev) && priv->link)
> +		if (netif_carrier_ok(priv->ndev) && priv->link) {
>  			netif_stop_queue(priv->ndev);
> +			phylink_mac_change(priv->phylink, false);
> +		}

What exactly does link_changed mean?

The normal use case for calling phylink_mac_change() is that you have
received an interrupt from something like the PCS, or the PHY. The MAC
driver itself cannot fully evaluate if the link is up because there
can be multiple parts in that decision. Is the SFP reporting LOS? Does
the PCS SERDES have sync, etc. So all you do is forward the interrupt
to phylink. phylink will then look at everything it knows about and
decide the state of the link, and maybe call one of the callbacks
indicating the link is now up/down.

>  		priv->link = 0;
>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>  			/* MAC reset */
>  			tn40_set_link_speed(priv, 0);
> +			tn40_set_link_speed(priv, priv->speed);
>  			priv->link_loop_cnt = 0;

This should move into the link_down callback.

> -	if (!netif_carrier_ok(priv->ndev) && !link)
> +	if (!netif_carrier_ok(priv->ndev) && !link) {
>  		netif_wake_queue(priv->ndev);

and this should be in the link_up callback.
> +static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
> +			 unsigned int mode, phy_interface_t interface,
> +			 int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct tn40_priv *priv = container_of(config, struct tn40_priv,
> +					      phylink_config);
> +
> +	priv->speed = speed;

This is where you should take any actions needed to make the MAC send
packets, at the correct rate.

> +}
> +
> +static void tn40_link_down(struct phylink_config *config, unsigned int mode,
> +			   phy_interface_t interface)
> +{

And here you should stop the MAC sending packets.

> +}

> +
> +static void tn40_mac_config(struct phylink_config *config, unsigned int mode,
> +			    const struct phylink_link_state *state)
> +{

I know at the moment you only support 10G. When you add support for
1G, this is where you will need to configure the MAC to swap between
the different modes. phylink will tell you which mode to use,
10GBaseX, 1000BaseX, SGMII, etc. You might want to move the existing
code for 10GBaseX here.

For the next version, please also Cc: Russell King, the phylink
Maintainer.

    Andrew

