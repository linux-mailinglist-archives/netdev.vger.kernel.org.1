Return-Path: <netdev+bounces-222584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B40B54EA4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC681BC4685
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5E30E0E4;
	Fri, 12 Sep 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nEJY4alO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60D30DEB1;
	Fri, 12 Sep 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681820; cv=none; b=dFQ6snYqGZeKP/8FPLspSr/GgYbcm5Ah8rh4J+T81IdmZFbjBK558b2XvXZUjGKADrI8tvcVPMSYED0YUl2NsMDhtG/wiK3NglesTe82XZO1zq6iRfK9oozULthL5p8nz4BY7q6hdSGWr+QUCFQa4SoK5kD7U5TrVq6kBVm23uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681820; c=relaxed/simple;
	bh=isdneW0AQMXzchNHlRx5M+1r0f48Vgl2dv/b+Q9CID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcYJfNWWhv1DWaIZEwuc27GspR02oQh6I2GeSgVkhlUbAuGbw2868WW9swm17RcBRhkJ9CQ5jADEvTh9F7aArNLWJKMefUpAZLp17YqMrSylOEtKO9h7LoRMqOcfZTLKetCD6XJqCTFphT+dBzy8JudTjMOYWKrd41HUocgre+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nEJY4alO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rUkbo4gs9EL6YjDDNBllsKMR1qK9GCz5ZHIWIO83/I0=; b=nEJY4alO1BTuBTDh/ZSyG2pxCU
	Okaqs4ynK0JVqI0eSkVv5lmIN/JrRbn4n1aWYywBmUkcl2OWWRXI3RJYpgO5KDFwRdfQrrN8EJMrM
	K34R4sxa3ToAGvplZJC4OO4kzj5G1xfG4iTflWBQfzTQ0OSMCpy8zUlif0Jwkj4YkCNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ux3KX-008D1Y-9j; Fri, 12 Sep 2025 14:56:45 +0200
Date: Fri, 12 Sep 2025 14:56:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <ae9f7bb0-aef3-4c53-91a3-6631fea6c734@lunn.ch>
References: <20250912024620.4032846-1-mmyangfl@gmail.com>
 <20250912024620.4032846-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912024620.4032846-4-mmyangfl@gmail.com>

> +static void yt921x_reg_mdio_verify(u32 reg, u16 val, bool lo)
> +{
> +	const char *desc;
> +
> +	switch (val) {
> +	case 0xfade:
> +		desc = "which is likely from a non-existent register";
> +		break;
> +	case 0xdead:
> +		desc = "which is likely a data race condition";
> +		break;

Where did these two values come from? Are they documented in the datasheet?

> +	default:
> +		return;
> +	}
> +
> +	/* Skip registers which are likely to have any valid values */
> +	switch (reg) {
> +	case YT921X_MAC_ADDR_HI2:
> +	case YT921X_MAC_ADDR_LO4:
> +	case YT921X_FDB_OUT0:
> +	case YT921X_FDB_OUT1:
> +		return;
> +	}
> +
> +	pr_warn("%s: Read 0x%x at 0x%x %s32, %s; "
> +		"consider reporting a bug if this happens again\n",
> +		__func__, val, reg, lo ? "lo" : "hi", desc);

You probably have a warning from checkpatch about pr_warn. Ideally you
want to give an indication which device has triggered this, making use
of a struct device. You might want to include that in context.

> +static int
> +yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
> +{
> +	if ((u16)val != val)
> +		dev_err(dev,
> +			"%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
> +			__func__, port, reg, val);
> +	*valp = (u16)val;
> +	return 0;

You don't treat this as an error, you don't return -EIO or -EPROTO etc.
So maybe this should be dev_info() or dev_dbg().

> +static int
> +yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
> +{
> +	struct yt921x_priv *priv = mbus->priv;
> +	int res;
> +
> +	if (port >= YT921X_PORT_NUM)
> +		return 0;

-ENODEV.

> +yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
> +{
> +	struct device *dev = to_device(priv);
> +	struct mii_bus *mbus;
> +	int res;
> +
> +	if (!mnp)
> +		res = devm_mdiobus_register(dev, mbus);
> +	else
> +		res = devm_of_mdiobus_register(dev, mbus, mnp);

You can call devm_of_mdiobus_register() with a NULL pointer for the
OF, and it will do the correct thing.

> +static int yt921x_extif_wait(struct yt921x_priv *priv)
> +{
> +	u32 val;
> +	int res;
> +
> +	res = yt921x_reg_read(priv, YT921X_EXT_MBUS_OP, &val);
> +	if (res)
> +		return res;
> +	if ((val & YT921X_MBUS_OP_START) != 0) {
> +		res = read_poll_timeout(yt921x_reg_read, res,
> +					(val & YT921X_MBUS_OP_START) == 0,
> +					YT921X_POLL_SLEEP_US,
> +					YT921X_POLL_TIMEOUT_US,
> +					true, priv, YT921X_EXT_MBUS_OP, &val);
> +		if (res)
> +			return res;
> +	}
> +
> +	return 0;

In mv88e6xxx, we have the generic mv88e6xxx_wait_mask() and on top of
that mv88e6xxx_wait_bit(). That allows us to have register specific
wait functions as one liners. Please consider something similar.

> +static int yt921x_mib_read(struct yt921x_priv *priv, int port, void *data)
> +{

As far as i can see, data is always a pointer to struct
yt921x_mib_raw. I would be better to not have the void in the middle.
It also makes it clearer what assumption you are making about the
layout of that structure.

> +	unsigned char *buf = data;
> +	int res = 0;
> +
> +	for (size_t i = 0; i < sizeof(struct yt921x_mib_raw);
> +	     i += sizeof(u32)) {
> +		res = yt921x_reg_read(priv, YT921X_MIBn_DATA0(port) + i,
> +				      (u32 *)&buf[i]);
> +		if (res)
> +			break;
> +	}
> +	return res;
> +}
> +
> +static void yt921x_poll_mib(struct work_struct *work)
> +{
> +	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
> +						    mib_read.work);
> +	struct yt921x_priv *priv = (void *)(pp - pp->index) -
> +				   offsetof(struct yt921x_priv, ports);

Can you make container_of() work for this?

> +	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
> +	struct device *dev = to_device(priv);
> +	struct yt921x_mib *mib = &pp->mib;
> +	struct yt921x_mib_raw raw;
> +	int port = pp->index;
> +	int res;
> +
> +	yt921x_reg_lock(priv);
> +	res = yt921x_mib_read(priv, port, &raw);
> +	yt921x_reg_unlock(priv);
> +
> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);
> +		delay *= 4;
> +		goto end;
> +	}
> +
> +	spin_lock(&pp->stats_lock);
> +
> +	/* Handle overflow of 32bit MIBs */
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +		u32 *rawp = (u32 *)((u8 *)&raw + desc->offset);
> +		u64 *valp = &((u64 *)mib)[i];
> +		u64 newval;
> +
> +		if (desc->size > 1) {
> +			newval = ((u64)rawp[0] << 32) | rawp[1];
> +		} else {
> +			newval = (*valp & ~(u64)U32_MAX) | *rawp;
> +			if (*rawp < (u32)*valp)
> +				newval += (u64)1 << 32;
> +		}

There are way too many casts here. Think about your types, and how you
can remove some of these casts. In general, casts are bad, and should
be avoided where possible.

> +static void
> +yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *mib = &pp->mib;
> +	size_t j;
> +
> +	spin_lock(&pp->stats_lock);
> +
> +	j = 0;
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +
> +		if (!desc->unstructured)
> +			continue;
> +
> +		data[j] = ((u64 *)mib)[i];
> +		j++;
> +	}
>

ethtool APIs are called in a context where you can block. So it would
be good to updated the statistics first before copying them. You just
need to think about your locking in case the worker is running.

> +static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
> +{
> +	int cnt;
> +
> +	if (sset != ETH_SS_STATS)
> +		return 0;
> +
> +	cnt = 0;

Please do the zeroing above when you declare the local variable.

> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +
> +		if (desc->unstructured)
> +			cnt++;
> +	}
> +
> +	return cnt;
> +}

> +static int
> +yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
> +{

> +	/* Enable / disable port EEE */
> +	res = yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
> +				     YT921X_EEE_CTRL_ENn(port), enable);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
> +				     YT921X_EEE_VAL_DATA, enable);

How do these two different registers differ? Why are there two of
them? Maybe add a comment to explain this.

> +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +
> +	return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) != 0;

What does the strapping actually tell you?

> +static int
> +yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
> +			   struct dsa_mall_mirror_tc_entry *mirror,
> +			   bool ingress, struct netlink_ext_ack *extack)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 ctrl;
> +	u32 val;
> +	int res;
> +
> +	yt921x_reg_lock(priv);
> +	do {
> +		u32 srcs;
> +		u32 dst;
> +
> +		if (ingress)
> +			srcs = YT921X_MIRROR_IGR_PORTn(port);
> +		else
> +			srcs = YT921X_MIRROR_EGR_PORTn(port);
> +		dst = YT921X_MIRROR_PORT(mirror->to_local_port);
> +
> +		res = yt921x_reg_read(priv, YT921X_MIRROR, &val);
> +		if (res)
> +			break;
> +
> +		/* other mirror tasks & different dst port -> conflict */
> +		if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
> +				    YT921X_MIRROR_IGR_PORTS_M)) != 0 &&
> +		    (val & YT921X_MIRROR_PORT_M) != dst) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Sniffer port is already configured,"
> +					   " delete existing rules & retry");
> +			res = -EBUSY;
> +			break;
> +		}
> +
> +		ctrl = val & ~YT921X_MIRROR_PORT_M;
> +		ctrl |= srcs;
> +		ctrl |= dst;
> +
> +		if (ctrl != val)
> +			res = yt921x_reg_write(priv, YT921X_MIRROR, ctrl);
> +	} while (0);

What does a while (0) loop bring you here?


    Andrew

---
pw-bot: cr

