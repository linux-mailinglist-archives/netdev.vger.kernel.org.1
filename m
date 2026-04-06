Return-Path: <netdev+bounces-275528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id adSAAUdd02nihgcAu9opvQ
	(envelope-from <netdev+bounces-275528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B53A1F14
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C80713005EA9
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC8735DA67;
	Mon,  6 Apr 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="nlqCpZUQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OtBZbDzi"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DB3563CD
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459649; cv=none; b=Vzf5C24qWMrw+Qp/oluruNDLFwnH5REpQif/zo2Qops3XOxm2ivOdX8MKPCJNhCUyikz5WgHGCCnUtEsjhaosq81l61/s54FCHYo6WusBl45QE0qqU791gMuIs4iyHr9TOqz6zk0B1ciuFx8DG32+OYGesj5uL5ukhRDVrPpYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459649; c=relaxed/simple;
	bh=XZXf+BC2fZAXVWWqUtbsllSZYBhzeKTg8A6Z6OJ6x1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZzMHiFnNUYW3iLzkD21/uxdPU4MlIKzFaAnIwELgy9D3PGL/efJmptKR48kye9JzYOvZJgf1apAQUwUkYJxcn6crwA5tW6Lc6e3qNILKLfjMYGNF9J6IK+K01DyMSFan7DvbMU8zAVOPIdp1v3vVKPK4Q1LuALYujiZURVu0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=nlqCpZUQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OtBZbDzi; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=nlqCpZUQDTomTOiz4N6KJaaYrMgax9s7ZyXCs/lhzA2XNmHeChe4mU4Qlqc/Wvg8uFrOZAaW7b2/8GPCJePYvc+3mzcWNn5KLPq3NzQwt+GKY00TvsOmg3C8wq4MB+BoAE693tt7nlAy5ugHWmPA6SilbcGKr6MlJRhd4t96908a1vfNCIYso4AyzYBWfBOtEgosAZmnTyi1W9uF1LGp5u5z/kGHaZr1CdctdUEuIIZ49tNF/ccPR87HjJi985dJm4QEPCv+BT93+eOmh7z3gTsvBphxg33CGSWapSBsP0EylkY4YmTOg0etTt3+L/UteFOmvOYrB3St2llzO1dI8g==; s=purelymail2; d=tinyisr.com; v=1; bh=XZXf+BC2fZAXVWWqUtbsllSZYBhzeKTg8A6Z6OJ6x1c=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=OtBZbDziQ8kVsKkrTDN6VXORRhRM37Y9ZJWqKvUcYTU06zGuK7waYj8ehkgLl7MAYG7A3C6//4fv1yd1EvWDair7V1Br4L5qFk0Ojyo9wzLoq8jF0pGh/+KMS1ovQNBnyjJKyZTNvkqSpdhXuBHS36slZHa3WIdBZWBBs9fBage4mlR+g5aLz1gx4fXYJWMLCULaRSb0kWmy8xMHkMdLYtvUg0UOZve5qO1Pzd/Yz2IJzKrJdS6pM5WtPAOFxI0aK9gu+OR+7J5zgcpZ0Rs6382CICv19G1avJiaIVA36tZ18oeZiG0uLk7jCvYkrRs2DD3VNUBZteoZu012Y0AJRQ==; s=purelymail2; d=purelymail.com; v=1; bh=XZXf+BC2fZAXVWWqUtbsllSZYBhzeKTg8A6Z6OJ6x1c=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 718368386;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Apr 2026 07:13:51 +0000 (UTC)
Date: Mon, 6 Apr 2026 10:13:40 +0300
From: Joris Vaisvila <joey@tinyisr.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, andrew@lunn.ch, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <adNXzrGhLwFeFtI8@archlinux>
References: <20260330184017.766200-5-joey@tinyisr.com>
 <20260402033103.911409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402033103.911409-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: 4B5B53A1F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub, thank you for the review.

On Wed, Apr 01, 2026 at 08:31:03PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: initial support for MT7628 embedded switch
> 
> Add support for the MT7628 embedded switch.
> The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
> port that is internally attached to the SoCs CPU MAC and serves as the
> CPU port.
> 
> > diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> > --- a/drivers/net/dsa/Kconfig
> > +++ b/drivers/net/dsa/Kconfig
> > @@ -28,6 +28,14 @@ source "drivers/net/dsa/hirschmann/Kconfig"
> >  
> >  source "drivers/net/dsa/lantiq/Kconfig"
> >  
> > +config NET_DSA_MT7628
> > +	tristate "MediaTek MT7628 Embedded Ethernet switch support"
> > +	select NET_DSA_TAG_MT7628
> > +	select MEDIATEK_FE_SOC_PHY
> 
> Does this configuration need to select NET_DSA_TAG_8021Q?
> 
> The driver relies on the tag_8021q mechanism for switch port isolation. If
> the kernel is configured without NET_DSA_TAG_8021Q, dsa_tag_8021q_register()
> will return -EOPNOTSUPP, causing the switch to boot with broken port
> isolation.
> 

tag_8021q.o is in DSA core, there's no option to enable or disable it.

> [ ... ]
> > +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> > +{
> > +	struct mt7628_esw *esw = bus->priv;
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> > +				       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> > +				       5000);
> 
> Will this polling logic cause an MDIO timeout?
> 
> If RD_DONE is a completion status bit that remains 1 after a successful
> operation, this first poll will wait indefinitely for the bit to become 0.
> 
> If RD_DONE is an active-low busy bit, the second poll below waits for the
> controller to become busy instead of waiting for it to be idle.
> 

RD_DONE gets set when the read operations completes and is reset on
register read, so this will not cause a timeout.

> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> > +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> > +				      regnum) |
> > +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> > +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> > +				       (val & MT7628_ESW_PCR1_RD_DONE), 10,
> > +				       5000);
> > +out:
> > +	if (ret) {
> > +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> > +		return ret;
> > +	}
> > +	return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
> > +}
> > +
> > +static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum, u16 dat)
> > +{
> > +	struct mt7628_esw *esw = bus->priv;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> > +				       !(val & MT7628_ESW_PCR1_WT_DONE), 10,
> > +				       5000);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> > +			   FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
> > +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> > +				      regnum) |
> > +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> > +				      port) | MT7628_ESW_PCR0_WT_PHY_CMD);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> > +				       (val & MT7628_ESW_PCR1_WT_DONE), 10,
> > +				       5000);
> 
> Is this second poll waiting for the controller to become busy instead of
> idle, similar to the read function?
> 
WT_DONE is set when the data is ready and reset on read, same as
RD_DONE.

> > +out:
> > +	if (ret) {
> > +		dev_err(&bus->dev, "write failed. MDIO timeout?\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
> > +{
> > +	struct mt7628_esw *esw = ds->priv;
> > +	struct device_node *mdio;
> > +	struct mii_bus *bus;
> > +	int ret = 0;
> > +
> > +	mdio = of_get_available_child_by_name(ds->dev->of_node, "mdio");
> > +
> > +	bus = devm_mdiobus_alloc(esw->dev);
> 
> Can allocating devm_ resources in the DSA .setup callback cause a sysfs name
> collision?
> 
> The .setup callback is executed whenever the DSA tree binds. Since devm_
> resources are tied to the platform device (esw->dev) rather than the DSA
> tree lifecycle, they are not released when the DSA tree unbinds. On a
> subsequent re-bind, allocating a new MDIO bus with the same ID will fail
> because the original bus was never unregistered.
> 

I'm not sure how this would work. Other switches appear to be doing the
same. For example mt7530-mmio.c does `priv->dev = &pdev->dev` and later
uses priv->dev to register the mdio bus. Is this a real issue?

> [ ... ]
> > +static int mt7628_setup(struct dsa_switch *ds)
> > +{
> > +	struct mt7628_esw *esw = ds->priv;
> > +	int ret;
> > +
> > +	reset_control_reset(esw->rst_esw);
> > +	usleep_range(1000, 2000);
> > +	reset_control_reset(esw->rst_ephy);
> > +	usleep_range(1000, 2000);
> > +	/*
> > +	 * all MMIO reads hang if esw is not out of reset
> > +	 * ephy needs extra time to get out of reset or it ends up misconfigured
> > +	 */
> > +	mt7628_switch_init(ds);
> > +	rtnl_lock();
> > +	dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
> 
> Is it safe to ignore the return value of dsa_tag_8021q_register()?
> 
> If the registration fails, the core function frees the allocated context but
> does not clear ds->tag_8021q_ctx. The setup will continue, and the DSA core
> will later dereference the non-NULL ds->tag_8021q_ctx, leading to a
> use-after-free crash.
> 
> Also, if mt7628_setup_internal_mdio() below fails, the setup returns an
> error without unregistering the tagger, which leaks the tag_8021q context.
> 

No, will fix in v3. 

> > +	rtnl_unlock();
> > +
> > +	ret = mt7628_setup_internal_mdio(ds);
> > +	return ret;
> > +}
> [ ... ]
> > +static struct dsa_switch_ops mt7628_switch_ops = {
> > +	.get_tag_protocol = mt7628_get_tag_proto,
> > +	.setup = mt7628_setup,
> 
> Does this switch ops structure need a .teardown callback?
> 
> Without calling dsa_tag_8021q_unregister() in a .teardown callback, the
> tag_8021q context memory allocated during .setup will be permanently leaked
> whenever the DSA switch is unbound or the module is removed.
> 
Yes, will fix in V3. 

Thanks,
Joris

