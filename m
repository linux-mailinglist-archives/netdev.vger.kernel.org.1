Return-Path: <netdev+bounces-289548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QETNAw+fDGpZkAUAu9opvQ
	(envelope-from <netdev+bounces-289548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02E58322A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5969830EF991
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A4376A04;
	Tue, 19 May 2026 17:28:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A733B6D3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211705; cv=none; b=p/CVniSH8vZKWfiV3PhKWFCkJFP3zhbOlq517GhG04jfeiCWlXP0XmpEefRxySAiiV581TTHv61DDEpbM6acpuwCan26zLveUW2pEmEc/G4FVkbTNrMJjbe9PoatDkui/lCKosqicv6hPd5h/hw3sERsnCchEG5EkXoWhlwpwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211705; c=relaxed/simple;
	bh=a3F75uLX4+9mRo6IF5InpXEjt/2dx2nxE79jJXgpL6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrOzwuNeCsyW0h1cJfUGQGd53hRpk1anRXbKyalrhN1WvdyyGPJDRkgO4K19p2wqRTTqSKLvwOwwHLNj7ISmdLfnHyRbpY9a+BcL0aAbu1zC9J5KqEXr58VFM5RfRiZcPYBmO3o5fbkZoNhHZHpwhC+h6W06Fce1Solke+fpDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOEd-000000001Y5-2F1V;
	Tue, 19 May 2026 17:28:03 +0000
Date: Tue, 19 May 2026 18:27:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <agydm8V25M-jy5o6@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-4-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TAGGED_FROM(0.00)[bounces-289548-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makrotopia.org:mid,gmx.de:email]
X-Rspamd-Queue-Id: 7A02E58322A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:57:41PM +0200, Markus Stockhausen wrote:
> Each Realtek SOC series has different number of MDIO ports.

I don't think the term "MDIO ports" describes it well.

I'd say "switch ports", also because RTL9300_NUM_PORTS includes ports
used for SFP+ cages which aren't going to be (directly) associated
with any MDIO-connected PHY at all.

> Make this configurable by adding a property to the info
> structure. Switch the existing usage of MAX_PORTS to this
> new property where needed.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 140e6ac51e2b..4533c2f68cab 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -49,9 +49,11 @@
>  #define MAX_SMI_ADDR	0x1f
>  
>  #define RTL9300_NUM_BUSES		4
> +#define RTL9300_NUM_PORTS		28
>  
>  struct rtl_mdio_info {
>  	u8 num_buses;
> +	u8 num_ports;
>  };
>  
>  struct rtl_mdio_priv {
> @@ -78,7 +80,7 @@ static int rtl_mdio_phy_to_port(struct mii_bus *bus, int phy_id)
>  
>  	priv = chan->priv;
>  
> -	for_each_set_bit(i, priv->valid_ports, MAX_PORTS)
> +	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports)
>  		if (priv->smi_bus[i] == chan->mdio_bus &&
>  		    priv->smi_addr[i] == phy_id)
>  			return i;
> @@ -323,7 +325,7 @@ static int rtl9300_mdiobus_init(struct rtl_mdio_priv *priv)
>  	int i, err;
>  
>  	/* Associate the port with the SMI interface and PHY */
> -	for_each_set_bit(i, priv->valid_ports, MAX_PORTS) {
> +	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports) {
>  		int pos;
>  
>  		pos = (i % 6) * 5;
> @@ -444,7 +446,7 @@ static int rtl_mdiobus_map_ports(struct device *dev)
>  		if (err)
>  			return err;
>  
> -		if (pn >= MAX_PORTS)
> +		if (pn >= priv->info->num_ports)
>  			return dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);
>  
>  		if (test_bit(pn, priv->valid_ports))
> @@ -509,6 +511,7 @@ static int rtl_mdiobus_probe(struct platform_device *pdev)
>  
>  static const struct rtl_mdio_info rtl9300_mdio_info = {
>  	.num_buses = RTL9300_NUM_BUSES,
> +	.num_ports = RTL9300_NUM_PORTS,
>  };
>  
>  static const struct of_device_id rtl_mdio_ids[] = {
> -- 
> 2.54.0
> 

