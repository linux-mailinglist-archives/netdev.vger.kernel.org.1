Return-Path: <netdev+bounces-212283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4CB1EEEB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9CD3B4385
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D891F4E4F;
	Fri,  8 Aug 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E0RqPGAw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E51D54E9;
	Fri,  8 Aug 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681625; cv=none; b=L/na/DxSa9PaPPzxOGPMOjTEqN/OBjD+IsxcRsmxy84yy3WPPKzcNfx2mOluYeXT1ty6nWodqOzXGFoT+x5EMa39Cuv+UpnO4SvB30CYvGwMtreTwJF70VJUVLpoXsENZGD0/NAf73WpKvXEyRZtdeC+4l4KdcP95NFrpwWJg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681625; c=relaxed/simple;
	bh=el2FtYqCrTCV63FfOD1L58zNVbVozdpvuChc+NR7Ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYO/mksxQM1s4Qb1hjKqkBiH0vZtNv7+9qc5DHBeuOZ/v8BWq6U9CQ94d2xMkrM6m5ZNDNTJqkMUYqVwUgyTasC1/sLcAzB6M2nW9Ga7x3Yt32sE3epyXMYhyfXEP8sC2/WmzCFLyTzYqYGBn3CR4keqJa4DUvF8rsTUJETr57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E0RqPGAw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1NJfgZ+g7v5e9Nw2W+8C5WCoA+7dzzlfg+dN2ZlcMWE=; b=E0RqPGAwrMXtN7VNqKxQtZEtjP
	hRXP324dAes13H7XukQFRc672vKwJ5TBMA2l2UgD3ETRBPTGzJL6KDp7SO4dISothTMi5jp6o6ZE0
	IChlO/evgb6cgcA30Dc1ygEYBEK7H0eqKIkGIhLEyI9OtsvZ4dQR6wzKShbohjIeG/40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ukSqM-00452g-Dj; Fri, 08 Aug 2025 21:33:34 +0200
Date: Fri, 8 Aug 2025 21:33:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: dsa: yt921x: Add support for Motorcomm YT921x
Message-ID: <1105b364-0e4b-4b32-8fbb-17bcbe2b2e20@lunn.ch>
References: <20250808173808.273774-1-mmyangfl@gmail.com>
 <20250808173808.273774-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808173808.273774-3-mmyangfl@gmail.com>

> +#undef dev_dbg
> +#define dev_dbg dev_info

Things like this should not be in a driver submitted to mainline.  It
is also just as easy to add #define DEBUG to the first line of the
file and recomplie to get _dbg() prints working.

> +
> +/******** hardware definitions ********/
> +
> +#define YT921X_SMI_SWITCHIDf		GENMASK(3, 2)
> +#define  YT921X_SMI_SWITCHIDv(x)		FIELD_PREP(YT921X_SMI_SWITCHIDf, (x))
> +#define YT921X_SMI_ADf			BIT(1)
> +#define  YT921X_SMI_ADDRv			0
> +#define  YT921X_SMI_DATAv			YT921X_SMI_ADf
> +#define YT921X_SMI_RWf			BIT(0)
> +#define  YT921X_SMI_WRITEv			0
> +#define  YT921X_SMI_READv			YT921X_SMI_RWf

More of these lower case postfixes.

Documentation/process/coding-style.rst says:

  Encoding the type of a function into the name (so-called Hungarian
  notation) is asinine - the compiler knows the types anyway and can
  check those, and it only confuses the programmer.

This looks like a form of Hungarian notation. Please don't do that.

> +struct yt921x_chip_info {
> +	const char *name;
> +	u16 id;
> +	u8 mode;
> +	u8 extmode;
> +	u16 intif_mask;
> +	u16 extif_mask;
> +};
> +
> +static const struct yt921x_chip_info yt921x_chip_infos[] = {
> +	{ "YT9215SC", 0x9002, 1, 0, GENMASK(4, 0),   BIT(8) | BIT(9), },
> +	{ "YT9215S",  0x9002, 2, 0, GENMASK(4, 0),   BIT(8),          },
> +	{ "YT9215RB", 0x9002, 3, 0, GENMASK(4, 0),   BIT(8) | BIT(9), },
> +	{ "YT9214NB", 0x9002, 3, 2, BIT(1) | BIT(3), BIT(8) | BIT(9), },
> +	{ "YT9213NB", 0x9002, 3, 3, BIT(1) | BIT(3), BIT(9),          },
> +	{ "YT9218N",  0x9001, 0, 0, GENMASK(7, 0),   0,               },
> +	{ "YT9218MB", 0x9001, 1, 0, GENMASK(7, 0),   BIT(8) | BIT(9), },

Please add a few more #defines. e.g. what does mode = 1 mean? A
#define with a good name can explain that.

#define EXTERNAL_IF_PORT_8 BIT(8)
#define EXTERNAL_IF_PORT_9 BIT(9)

etc.

> +static int
> +__yt921x_smi_read(struct yt921x_priv *priv, u32 reg, u32 *valp)

Try to avoid using __ symbols. They are supposed to be used by the
compiler.

> +static int yt921x_smi_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	int res;
> +
> +	res = yt921x_smi_acquire(priv);
> +	if (unlikely(res != 0))

SMI operations are not fast path. Don't use unlikely(). A typical DSA
driver never touches actual Ethernet frames, so there is no need for
this anywhere in this code.

> +static int yt921x_dsa_setup(struct dsa_switch *ds)
> +{
> +	/* Always register one mdio bus for the internal/default mdio bus. This
> +	 * maybe represented in the device tree, but is optional.
> +	 */
> +	child = of_get_child_by_name(np, "mdio");
> +	res = yt921x_mbus_int_init(priv, child);
> +	of_node_put(child);
> +	if (unlikely(res != 0))
> +		return res;
> +	ds->user_mii_bus = priv->mbus_int;
> +
> +	/* Walk the device tree, and see if there are any other nodes which say
> +	 * they are compatible with the external mdio bus.
> +	 */
> +	priv->mbus_ext = NULL;
> +	for_each_available_child_of_node(np, child) {
> +		if (!of_device_is_compatible(child,
> +					     "motorcomm,yt921x-mdio-external"))
> +			continue;
> +
> +		res = yt921x_mbus_ext_init(priv, child);
> +		if (unlikely(res != 0)) {
> +			of_node_put(child);
> +			return res;
> +		}
> +		break;

Please add a device tree binding. It needs to be the first patch of
the series, and you need to Cc: the device tree Maintainers.


    Andrew

---
pw-bot: cr

