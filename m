Return-Path: <netdev+bounces-252383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF2XLwo+cmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78A68726
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43799A3A5C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E1345CD8;
	Thu, 22 Jan 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beOaXzMv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD87082F;
	Thu, 22 Jan 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093349; cv=none; b=r2KR5loxwEkl8Zlekh8DiZIy+A16xuqHrAnnEmHp4UI3OFHHSeVU06lBEc2FtL3DoA5gOxQErqsPfxZOQBPQ7cSAmttjuWFu7xeYd4h/r51ob61q1j9NwHYJIr/h/RVU2iOv2vnQD8zFBwC7eLFPnu0ElQpS5IeDJHZ8crXqsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093349; c=relaxed/simple;
	bh=20U0OICFO684mmGGcmK4OTCVjQQ903vGfEP70A+pA2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+bq3eohcEx7s1mfFKWzUGWwh512QkemJ4L42qAkxR76HjDyn5l3BYCZ311HZK89D1t8YtQFZQsQt9aciW88pK5sQuc75s+pM0tYhIskZOS9fi5cXsvHYA5nbWbJxkuCx6i7cB79tLcJh3H8HaeL9y7gyGpZt2zWm51+yWzLMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beOaXzMv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769093347; x=1800629347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20U0OICFO684mmGGcmK4OTCVjQQ903vGfEP70A+pA2A=;
  b=beOaXzMvbzYSBIdlF/j2ruVOfGNzaHnVTmCneDbDafSVMKwjlC4Kabws
   IATLoydpCXzjpTnoelAml/peTSoN2q9jcuWYRotEBGAQn7lnoHyC8gbQt
   N+8iJ2pHQYnJY+2ZbsqJpTeAMHM6+jzbC6pzXc0m4NVQH2u/Z46hLO4nQ
   noudfCZ3JZK5SgN2JH/cPh5WQf7ICtozTZH/iN8b0gy9fSKsOW2oLeBht
   qN/jJGCvL5nEijPZ8mw7mVR4kT0g50Wbyzu5AVbq4R5GDubW8B4MGHJNx
   uiQgAkMtC/FcpNCB28fJBWrwnSTzzkiqlvfxcX2naNcBlz2y/qORi5oUq
   w==;
X-CSE-ConnectionGUID: eZAmDvwdSl2NG95NQHm2uw==
X-CSE-MsgGUID: dSVbuEoiRmaaoNG5v1/d1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70382907"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70382907"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:49:06 -0800
X-CSE-ConnectionGUID: z++1x3EeQ3GBMAdpOtc0Ww==
X-CSE-MsgGUID: WLaHyP7tS1S9NKSALD2YIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206802518"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:49:01 -0800
Date: Thu, 22 Jan 2026 16:48:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 03/15] net: mdio: add generic driver for NXP
 SJA1110 100BASE-TX embedded PHYs
Message-ID: <aXI42kYpTGJZrOc8@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-4-vladimir.oltean@nxp.com>
 <aXIWBpIvp7KZYZCn@smile.fi.intel.com>
 <20260122133123.w3jr7gdga4fhlj5z@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122133123.w3jr7gdga4fhlj5z@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-252383-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 2F78A68726
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:31:23PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:20:22PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 12:56:42PM +0200, Vladimir Oltean wrote:

...

> > > +static int mdio_regmap_simple_probe(struct platform_device *pdev)
> > > +{
> > > +	const struct mdio_regmap_simple_data *data;
> > > +	struct mdio_regmap_config config = {};
> > > +	struct device *dev = &pdev->dev;
> > > +	struct regmap *regmap;
> > > +	struct mii_bus *bus;
> > > +
> > > +	if (!dev->of_node || !dev->parent)
> > 
> > dev->of_node check is not needed, see below.
> 
> Oh.... this is a bug. dev->of_node should have been propagated to
> devm_mdio_regmap_register() -> devm_mdiobus_register(), turning it into
> devm_of_mdiobus_register().
> 
> It shows that my SJA1110 testing platform (Bluebox 3) doesn't have the
> CBTX PHY routed to pinout, since I didn't catch this... I'll fix this
> for v3.

Same Q, why not using fwnode APIs to begin with?

> > > +		return -ENODEV;
> > > +
> > > +	regmap = dev_get_regmap(dev->parent, NULL);
> > > +	if (!regmap)
> > > +		return -ENODEV;
> > > +
> > > +	data = device_get_match_data(dev);
> > > +
> > > +	config.regmap = regmap;
> > > +	config.parent = dev;
> > > +	config.name = dev_name(dev);
> > > +	/* The resource is optional, provided for finding the registers
> > > +	 * within a device-wide non-MMIO regmap
> > > +	 */
> > > +	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);
> > 
> > > +	if (data) {
> > 
> > We may always require data to be present. As you use a default one anyway.
> > 
> > > +		config.valid_addr = data->valid_addr;
> > > +		config.autoscan = data->autoscan;
> > > +	}
> > 
> > And if it is not provided we will have a crash which is fine. It will just
> > point that the code was not ever been run on real HW.
> 
> Hmm. This patch is super old, so I'm revisiting it with foreign eyes,
> same as you.
> 
> I think the case with .valid_addr = 0 and .autoscan = false will
> constitute the vast majority of instantiations of this driver.
> I would like to avoid the proliferation of the same basic config with
> 100 different names (nxp_sja1110_base_tx, etc).

But you name it as default_blablalbla. That will be just assigned to each
currently "NULL" driver_data. We have examples in the kernel that do this.
IIRC 8250_dw cases, stmmac driver (PCI glue part of it?), et cetera...

> So for v3 I'm planning to:
> - rename nxp_sja1110_base_tx to mdio_regmap_simple_default_data
> - delete the "if (data)" conditional and directly assign from
>   device_get_match_data() to the config structure
> 
> Thanks for taking a look.

You're welcome!

> > > +	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
> > > +}

-- 
With Best Regards,
Andy Shevchenko



