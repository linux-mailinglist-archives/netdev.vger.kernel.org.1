Return-Path: <netdev+bounces-255825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBwZBi17gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC59BCAD2C
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B745C3006118
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10269358D16;
	Mon,  2 Feb 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr69ueu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CC356A06
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027817; cv=none; b=Pwk/nB4pAc9SbGy/qCM81ZHSLhdijF8NJoa3fFFHfwFHZEEVk27W3hJROdZ6ADNLPcgpN96lsHn6zjwcjEPqcaBYSi2B1orkui35sbAHQvhKUNKKwAiJhGZaA9zzpFVEqcYIB6d5d7oKQoQE2lOj0+Jo3EBQiggmDyCtoagE43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027817; c=relaxed/simple;
	bh=yZKu5kyu+Y4qjYCpL3UVacgWKR092iRWkVpIUVasDGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN4q8OYPD3X0p+9CHzys1XZcIze32Q+gw3qHEXkVJmq2o6HV1SL4+AgvgiLNsJThHBV0cYldinCUy6tLrsMKDv8F9IjSsZEFym0PYXZaHLg3FHoSrFgd94MtfI2Yqu9ONMLPLEq1afn1k7RZm1h2PXXex+BtO69v8Q8hL2Qhbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr69ueu+; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbb061a08so259276f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027810; x=1770632610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhkDvPLczPIxCfyQo+iGbeFS0X9vklDWW87NQiGpokY=;
        b=Lr69ueu+t7juxzU4sRUlDh4/Kb+XA7FoUMSpLAkuBB3QNSK7cjRkevvwbUl2hKIgw6
         8evx7ukbLnkx4eSjtQxtTetmt/wn6YMnVIjzXNWindpEwcOHhUV358nenJfHr8Mil4P/
         AcY9DFFyn7HnCXRQsNiKIY26SDqVQ2VDwk5kjhrEjcmVyfqvFPaXJjroG2nrLfQwsnyX
         BiLDZVyOTeay8T/7YImmaitW90rDBGF4aR+sbEURvTVwNMn7Em81l26jPPbFIMNX02wM
         KrYjI0yZwNQcWx6BxInWjJkoI6mCTtxNe+++QJ/zFjryw+LAQcUT1Q4yPGRhBScK2UoO
         Df2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027810; x=1770632610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhkDvPLczPIxCfyQo+iGbeFS0X9vklDWW87NQiGpokY=;
        b=FXguvVC+R4Z/gJs66U8VFvrTktULpdO7dlM8Js1chTtED6VKCTb6ZqZTKNFm4wOoaa
         MArC6jyfawnu1sEROv2Q49nSWg8+13SKIRmjaTMEhOb8LNvUbWkV+BllvbRodqHrS+2a
         zKcf7ZuOuwW4AUvun4hQ2G8vr+U/Aky5TbP/nrHvBOw23lp0WreJKJhf6aJ1NzkNsTBr
         0QuB0ohATuYvfGSYlQ/AQvcosAueUpi7gsZinSfoJpP0FPIwEIHNP1NdfHM+bUf2TdNg
         LtcLO1GNA1JJGB7fRBfxoJcfN21sO0yzq2ojAVV18Z/F7WwzoiyDK6PoL3Q93zsqAB8S
         IpRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhQKc2UI6lGAcLEhQtjYxdiOV/mzudQYx49kSV5rhXLbfsw/I3CdokInndUsF/6UIgw45lPEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdcpWSFlliMTRh9VeI/Kwg8x6CB6YIf9JJY7XokgX7HWc1Oxu
	1CcVdUdUHtDepynmMj1FTE9TEmYRP9WwtTIdA+deS+EvYzvmUCTCq6+I
X-Gm-Gg: AZuq6aJ0G4h+3SdLiZm21qzDVTfHXf2/yiC/ad0wzdnWr3zeamAav0rD773IiW+81Di
	0pzJZNj3qKFz11I6eOsdDT/y5e9BJ6KUj6PukhxOUkLewSNig8xQMTRsFYsT9G2hW1e1zRvDgk8
	RqlhRjEThW9NCaVOZDtgCV7iTVJvqhaHAaRnqKmv1S1dSlXr0IqJtAY8eJzFUIs2iSZU3++IseJ
	D1i6U08npvG2e2q0QbVyYJFDN1DEe+mjg/1C/LlUS6ByO1DemtfgHPtYbPNY2HpkAA+tMi0dgs3
	EnhxWBQRjZ4giHoGXZNSbeQ+aX01uzJVrWeZrqBPgzROnvLQNGbuvndPY9qVTqbrBLv97dOjriM
	a5NVYyuf3VSz8lbNSuF2Fkcu1at1PsMoMDiPt/M4/XarOKd43jmvevvHtThA63sjtqdME3PXmrr
	5B9GgCfJ5k6nSdKQ==
X-Received: by 2002:a05:600c:45c5:b0:47e:e20e:bbbc with SMTP id 5b1f17b1804b1-482db45dc21mr93687435e9.1.1770027810144;
        Mon, 02 Feb 2026 02:23:30 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm43376688f8f.36.2026.02.02.02.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:23:29 -0800 (PST)
Date: Mon, 2 Feb 2026 12:23:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v12 4/4] net: dsa: add basic initial driver for MxL862xx
 switches
Message-ID: <20260202102326.vz5qhg6wzzje553v@skbuf>
References: <cover.1769908155.git.daniel@makrotopia.org>
 <c5895811389aed7f426ed9c9461e8ac0e8017da1.1769908155.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5895811389aed7f426ed9c9461e8ac0e8017da1.1769908155.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255825-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC59BCAD2C
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 02:25:13AM +0000, Daniel Golle wrote:
> Add very basic DSA driver for MaxLinear's MxL862xx switches.
> 
> In contrast to previous MaxLinear switches the MxL862xx has a built-in
> processor that runs a sophisticated firmware based on Zephyr RTOS.
> Interaction between the host and the switch hence is organized using a
> software API of that firmware rather than accessing hardware registers
> directly.
> 
> Add descriptions of the most basic firmware API calls to access the
> built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
> setting up the CPU port.
> 
> Implement a very basic DSA driver using that API which is sufficient to
> get packets flowing between the user ports and the CPU port.
> 
> The firmware offers all features one would expect from a modern switch
> hardware, they are going to be added one by one in follow-up patch
> series.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v12:
>  * list switch variants in Kconfig starting with dash ('-')
>  * remove the __packed attribute on structs which are
>    naturally packed according to C rules (ie. one other struct
>    with only a single byte-aligned member)
>  * log error in mxl862xx_port_disable()
>  * introduce !NULL check for return value of dsa_to_port() in
>    mxl862xx_add_single_port_bridge
>  * check cpu_dp being non-NULL before dereferencing dp->cpu_dp
>  * use non-racy and deterministic name for MII bus
>  * skip ports without cpu_dp assigned in mxl862xx_setup_cpu_bridge()
>    to avoid potential NULL-pointer dereference
>  * call dev_set_drvdata() only after dsa_register_switch() has been
>    successfully completed

I have nothing else to comment except to request you to undo some of the
changes requested by AI review. Sorry I didn't have time to comment on v11.

> +static int mxl862xx_add_single_port_bridge(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mxl862xx_bridge_alloc br_alloc = {};
> +	int ret;
> +
> +	if (!dp)
> +		return -ENODEV;

I'm sorry, I can't accept code that fears its own shadow. Some people,
when they see a defensive NULL check think there is a valid reason
behind it and will try to see what that reason is.

If dsa_to_port() would have possibly returned NULL, mxl862xx_port_setup() ->
dsa_is_cpu_port(), which _is_ implemented using dsa_to_port(), would
have already crashed the kernel and this test here would have been too
little, too late.

But the kernel doesn't crash there, because calling dsa_to_port() is
safe for these arguments, and this test is simply logically inconsistent
with previous unconditional in this call path.

> +
> +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> +		return ret;
> +	}
> +
> +	br_port_cfg.bridge_id = br_alloc.bridge_id;
> +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> +	br_port_cfg.src_mac_learning_disable = true;
> +	br_port_cfg.vlan_src_mac_vid_enable = false;
> +	br_port_cfg.vlan_dst_mac_vid_enable = false;
> +	if (dp->cpu_dp)
> +		br_port_cfg.bridge_port_map[0] = cpu_to_le16(BIT(dp->cpu_dp->index));
> +
> +	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> +}
> +
> +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct device *dev = ds->dev;
> +	struct device_node *mdio_np;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->priv = priv;
> +	ds->user_mii_bus = bus;
> +	bus->name = KBUILD_MODNAME "-mii";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
> +	bus->read_c45 = mxl862xx_phy_read_c45_mii_bus;
> +	bus->write_c45 = mxl862xx_phy_write_c45_mii_bus;
> +	bus->read = mxl862xx_phy_read_mii_bus;
> +	bus->write = mxl862xx_phy_write_mii_bus;
> +	bus->parent = dev;
> +	bus->phy_mask = ~ds->phys_mii_mask;
> +
> +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> +	if (!mdio_np)
> +		return -ENODEV;

As per the dt-bindings patch, the "mdio" child node is not required.
But here it is.

> +
> +	ret = devm_of_mdiobus_register(dev, bus, mdio_np);
> +	of_node_put(mdio_np);
> +
> +	return ret;
> +}
> +
> +static int mxl862xx_wait_ready(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_sys_fw_image_version ver = {};
> +	unsigned long start = jiffies, timeout;
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_cfg cfg = {};
> +	int ret;
> +
> +	timeout = start + msecs_to_jiffies(MXL862XX_READY_TIMEOUT_MS);
> +	msleep(2000); /* it always takes at least 2 seconds */
> +	do {
> +		ret = MXL862XX_API_READ_QUIET(priv, SYS_MISC_FW_VERSION, ver);
> +		if (ret || !ver.iv_major)
> +			goto not_ready_yet;
> +
> +		/* being able to perform CFGGET indicates that
> +		 * the firmware is ready
> +		 */
> +		ret = MXL862XX_API_READ_QUIET(priv,
> +					      MXL862XX_COMMON_CFGGET,
> +					      cfg);
> +		if (ret)
> +			goto not_ready_yet;
> +
> +		dev_info(ds->dev, "switch ready after %ums, firmware %u.%u.%u (build %u)\n",
> +			 jiffies_to_msecs(jiffies - start),
> +			 ver.iv_major, ver.iv_minor,
> +			 le16_to_cpu(ver.iv_revision),
> +			 le32_to_cpu(ver.iv_build_num));
> +		return 0;
> +
> +not_ready_yet:
> +		msleep(MXL862XX_READY_POLL_MS);
> +	} while (time_before(jiffies, timeout));
> +
> +	dev_err(ds->dev, "switch not responding after reset\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int mxl862xx_setup_cpu_bridge(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct mxl862xx_priv *priv = ds->priv;
> +	u16 bridge_port_map = 0;
> +	struct dsa_port *dp;
> +
> +	/* CPU port bridge setup */
> +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> +
> +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> +	br_port_cfg.src_mac_learning_disable = false;
> +	br_port_cfg.vlan_src_mac_vid_enable = true;
> +	br_port_cfg.vlan_dst_mac_vid_enable = true;
> +
> +	/* include all assigned user ports in the CPU portmap */
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (!dp->cpu_dp)
> +			continue;

All user ports are given a valid non-NULL dp->cpu_dp pointer. I strongly
oppose introducing FUD in the code. If there are valid reasons behind
this I'm all ears, but there aren't.

> +
> +		if (dp->cpu_dp->index != port)
> +			continue;
> +
> +		bridge_port_map |= BIT(dp->index);
> +	}
> +	br_port_cfg.bridge_port_map[0] |= cpu_to_le16(bridge_port_map);
> +
> +	return MXL862XX_API_WRITE(priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> +}
> +
> +static int mxl862xx_setup(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret;
> +
> +	ret = mxl862xx_reset(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_wait_ready(ds);
> +	if (ret)
> +		return ret;
> +
> +	return mxl862xx_setup_mdio(ds);
> +}
> +
> +static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	bool is_cpu_port = dsa_is_cpu_port(ds, port);
> +	int ret;
> +
> +	/* disable port and flush MAC entries */
> +	ret = mxl862xx_port_state(ds, port, false);
> +	if (ret)
> +		return ret;
> +
> +	mxl862xx_port_fast_age(ds, port);
> +
> +	/* skip setup for unused and DSA ports */
> +	if (dsa_is_unused_port(ds, port) ||
> +	    dsa_is_dsa_port(ds, port))
> +		return 0;

Each of dsa_is_cpu_port(), dsa_is_unused_port(), dsa_is_dsa_port() are
implemented using dsa_to_port(), and that loops over dst->ports in order
to find "dp" just to return dp->index.

OTOH if you call dsa_to_port() only once, we have dsa_port_is_cpu(),
dsa_port_is_unused(), dsa_port_is_dsa() which can be called on that and
have lower complexity. Please do that.

You do _not_ need to test whether dsa_to_port() returns NULL, if "ds"
and "port" were passed to you by DSA in the context of a DSA callback.
Any exception to this rule will be explicitly noted in the documentation.

> +
> +	/* configure tag protocol */
> +	ret = mxl862xx_configure_sp_tag_proto(ds, port, is_cpu_port);
> +	if (ret)
> +		return ret;
> +
> +	/* assign CTP port IDs */
> +	ret = mxl862xx_configure_ctp_port(ds, port, port,
> +					  is_cpu_port ? 32 - port : 1);
> +	if (ret)
> +		return ret;
> +
> +	if (is_cpu_port)
> +		/* assign user ports to CPU port bridge */
> +		return mxl862xx_setup_cpu_bridge(ds, port);
> +
> +	/* setup single-port bridge for user ports */
> +	return mxl862xx_add_single_port_bridge(ds, port);
> +}
> +
> +static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +				      struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> +				   MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  config->supported_interfaces);
> +}
> +
> +static const struct dsa_switch_ops mxl862xx_switch_ops = {
> +	.get_tag_protocol = mxl862xx_get_tag_protocol,
> +	.setup = mxl862xx_setup,
> +	.port_setup = mxl862xx_port_setup,
> +	.phylink_get_caps = mxl862xx_phylink_get_caps,
> +	.port_enable = mxl862xx_port_enable,
> +	.port_disable = mxl862xx_port_disable,
> +	.port_fast_age = mxl862xx_port_fast_age,
> +};
> +
> +static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> +					unsigned int mode,
> +					const struct phylink_link_state *state)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
> +					   unsigned int mode,
> +					   phy_interface_t interface)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
> +					 struct phy_device *phydev,
> +					 unsigned int mode,
> +					 phy_interface_t interface,
> +					 int speed, int duplex,
> +					 bool tx_pause, bool rx_pause)
> +{
> +}
> +
> +static const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
> +	.mac_config = mxl862xx_phylink_mac_config,
> +	.mac_link_down = mxl862xx_phylink_mac_link_down,
> +	.mac_link_up = mxl862xx_phylink_mac_link_up,
> +};
> +
> +static int mxl862xx_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct mxl862xx_priv *priv;
> +	struct dsa_switch *ds;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mdiodev = mdiodev;
> +
> +	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
> +	if (!ds)
> +		return -ENOMEM;
> +
> +	priv->ds = ds;
> +	ds->dev = dev;
> +	ds->priv = priv;
> +	ds->ops = &mxl862xx_switch_ops;
> +	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
> +	ds->num_ports = MXL862XX_MAX_PORTS;
> +
> +	ret = dsa_register_switch(ds);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(dev, ds);

There is no point in doing this, calling dev_set_drvdata() before and
then simply "return dsa_register_switch()" is perfectly fine. You also
won't need the "ret" variable.

> +
> +	return 0;
> +}
> +
> +static void mxl862xx_remove(struct mdio_device *mdiodev)
> +{
> +	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
> +
> +	if (!ds)
> +		return;
> +
> +	dsa_unregister_switch(ds);
> +}
> +
> +static void mxl862xx_shutdown(struct mdio_device *mdiodev)
> +{
> +	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
> +
> +	if (!ds)
> +		return;
> +
> +	dsa_switch_shutdown(ds);
> +
> +	dev_set_drvdata(&mdiodev->dev, NULL);
> +}
> +
> +static const struct of_device_id mxl862xx_of_match[] = {
> +	{ .compatible = "maxlinear,mxl86282" },
> +	{ .compatible = "maxlinear,mxl86252" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxl862xx_of_match);
> +
> +static struct mdio_driver mxl862xx_driver = {
> +	.probe  = mxl862xx_probe,
> +	.remove = mxl862xx_remove,
> +	.shutdown = mxl862xx_shutdown,
> +	.mdiodrv.driver = {
> +		.name = "mxl862xx",
> +		.of_match_table = mxl862xx_of_match,
> +	},
> +};
> +
> +mdio_module_driver(mxl862xx_driver);
> +
> +MODULE_DESCRIPTION("Driver for MaxLinear MxL862xx switch family");
> +MODULE_LICENSE("GPL");

