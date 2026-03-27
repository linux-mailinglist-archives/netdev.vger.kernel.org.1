Return-Path: <netdev+bounces-272523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCR4GRhzxmkCKgUAu9opvQ
	(envelope-from <netdev+bounces-272523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:07:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FC343F5E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82F9301A285
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77D3932D8;
	Fri, 27 Mar 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eC1el5+U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382A392831;
	Fri, 27 Mar 2026 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613270; cv=none; b=b+Wno5ATcv7Aa2frTOZvMJe+ee7REEXciFclIa808nb5LE6LN0xPW3wOPVQf9akRQhkJk0hEEf//ofIGbhChn0uwXgfhbJu/EBXltVWh5DWXPRWBV+DrG3v7asFtpk8lSxSzH9NExjzmpBTkiqbKOoZrfqLIuuJjuLM2Qae8gxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613270; c=relaxed/simple;
	bh=hfafqGCDLzTeZwNk6hc3gNMtutqPWA8E6v950QI89eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIDucGgDz9rSvqT6X0et0X/84tDpSkYn+gdewIIkAzgj9BApEZL+VkOHOE2eK8o4nCYuuwN8ON7LCnEHZFug+HrnYPutQAKxcyiaCP6eAJovKXoz5MrAbcexafJiflOEOEZN6tkM5vXDYjwOU9uxFDElQvCaikzrx8OAZgkYAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eC1el5+U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QPQctMA0qGtnb0TPGRMl+iOaLSMRN2wp1qfAH8tHmF8=; b=eC1el5+Uw34Rmrs5qh4DuolSBw
	z12fpbHUweWNbq1jVROqXBNfqKjofEv8fGaZWn2Ktpl8Ijc3jf+1jMePrnnPf8cPs4H1LVp3D8QIP
	y2rDVeXhj8u/++W/0qU6QeVA66ylac/13VQqKXAatpoDwGWNyP+FT3NgzGvzj95og2J0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w65yY-00DeRA-Gz; Fri, 27 Mar 2026 13:07:42 +0100
Date: Fri, 27 Mar 2026 13:07:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <e6d91e11-fe19-48c0-886f-e1c0c92b094d@lunn.ch>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204413.3317584-5-joey@tinyisr.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272523-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F09FC343F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 39fb8ead16b5..d07fc8dfe228 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -70,6 +70,13 @@ config NET_DSA_MV88E6060
>  	  This enables support for the Marvell 88E6060 ethernet switch
>  	  chip.
>  
> +config NET_DSA_MT7628
> +	tristate "MT7628 Embedded ethernet switch support"

Please could you make this fit the pattern other devices have.

MediaTek MT7628 Embedded ethernet switch support

would be better. And please put it before MT7530. The sorting in
drivers/net/dsa/Kconfig is not great, but we should not make it worse.

> diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> index f5a463b87ec2..22da6b680f29 100644
> --- a/drivers/net/dsa/Makefile
> +++ b/drivers/net/dsa/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx-core.o
>  obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
>  obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
>  obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
> +obj-$(CONFIG_NET_DSA_MT7628) += mt7628.o

This is also sorted, so should be inserted earlier.

> +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> +		return -ETIMEDOUT;

Return the error code regmap_read_poll_timeout() or regmap_write()
returned.

> +static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum, u16 dat)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				       5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_WT_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				       5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "write failed. MDIO timeout?\n");
> +		return -ETIMEDOUT;

Same here. And in general, always return the error code, if there is
one, don't make one up.

> +static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct device_node *mdio;
> +	struct mii_bus *bus;
> +	int ret = 0;
> +
> +	mdio = of_get_child_by_name(ds->dev->of_node, "mdio");
> +	if (mdio && !of_device_is_available(mdio))
> +		goto out_put_node;

of_get_available_child_by_name() ?

	Andrew

