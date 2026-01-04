Return-Path: <netdev+bounces-246824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E46CF1655
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9D6630038E8
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B931A7FD;
	Sun,  4 Jan 2026 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RViUD9RE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3D2D8768;
	Sun,  4 Jan 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767564398; cv=none; b=fVxKGwqp7LhYx9uJGg0gr9+go7zZlU9gkOpwvULPSBien1pt1FzdRAgv3LDT968+Y76nhkmsq9fNL0IfAVll37QEz02r9mEacEOY89GLP70PDHLxotovQzyqC8BYi3D2hXghKEBNbuicIrui+GLnefXXsCnJ2pQ3EF4ajNXkBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767564398; c=relaxed/simple;
	bh=mqgRNTc0LEmCSLQdVPke4eJV3O0ZaVRaOXUZCCYHDXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTUBQz/jhjB+Oh4roBEwADTTK+/vwATYY+yy0QeSNcz2v6iF9PgdJrWDQOi27qSmCF06ULELrdOMsA6h3iaOvhFuylRwQM8RMyzkHfFPYnD5xIwYmqR8dw48jBMTVpDBnlZDI9LrD8eJuwqjoL6Y31WeIriDrwp4qOpt549UKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RViUD9RE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o4saqg3MsDvVwVlHbYLVDIgv6+EBIz46IQlEo5mgal8=; b=RViUD9REQCAlbhy39Ejs4UkfIQ
	ekxKJUgzC4dEw/lAoWqwKNA0j+05u15gfm+azZOK+VuUKuCCdHO2pgxHTVa1RQaK0/cFxKxX0Q4tC
	itASnidH+fXno4TvSx6Wz16VHA7GXnaOHWRYs91/1+PeFgCODuw5gxHYEpkr9HDJHEuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcWF2-001PHY-KZ; Sun, 04 Jan 2026 23:06:28 +0100
Date: Sun, 4 Jan 2026 23:06:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: replace printk() with netdev_info()
 in rio_probe1()
Message-ID: <d5b585f3-eb84-4c72-9bdb-80721eb412a7@lunn.ch>
References: <20260104111849.10790-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104111849.10790-2-yyyynoom@gmail.com>

On Sun, Jan 04, 2026 at 08:18:50PM +0900, Yeounsu Moon wrote:
> Replace rio_probe1() printk(KERN_INFO) messages with netdev_info().
> 
> Log rx_timeout on a separate line since netdev_info() prefixes each
> message and the multi-line formatting looks broken otherwise.
> 
> No functional change intended.
> 
> Tested-on: D-Link DGE 550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index 846d58c769ea..b2af6399c3e8 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -279,18 +279,15 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	card_idx++;
>  
> -	printk (KERN_INFO "%s: %s, %pM, IRQ %d\n",
> -		dev->name, np->name, dev->dev_addr, irq);
> +	netdev_info(dev, "%s, %pM, IRQ %d", np->name, dev->dev_addr, irq);
>  	if (tx_coalesce > 1)
> -		printk(KERN_INFO "tx_coalesce:\t%d packets\n",
> -				tx_coalesce);
> -	if (np->coalesce)
> -		printk(KERN_INFO
> -		       "rx_coalesce:\t%d packets\n"
> -		       "rx_timeout: \t%d ns\n",
> -				np->rx_coalesce, np->rx_timeout*640);
> +		netdev_info(dev, "tx_coalesce:\t%d packets", tx_coalesce);
> +	if (np->coalesce) {
> +		netdev_info(dev, "rx_coalesce:\t%d packets", np->rx_coalesce);
> +		netdev_info(dev, "rx_timeout: \t%d ns", np->rx_timeout * 640);
> +	}
>  	if (np->vlan)
> -		printk(KERN_INFO "vlan(id):\t%d\n", np->vlan);
> +		netdev_info(dev, "vlan(id):\t%d", np->vlan);
>  	return 0;

This looks like a valid transformation, but drivers are not really
meant to spam the kernel log like this. So i would actually change
them to netdev_dbg() and add a comment in the commit message.

     Andrew

