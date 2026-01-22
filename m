Return-Path: <netdev+bounces-252382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJgcAN9KcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:05:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B32636980D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 086417C6B09
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA30D34AAF2;
	Thu, 22 Jan 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KN94QSbT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3292E7F07;
	Thu, 22 Jan 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093097; cv=none; b=Eh6yKtdWOyi3fCeSMJvUCzFB0Lnb9TCUf09gS61ZdUFWLhQV2nc/RxQWU6qN41uB1Nifb4Q3IW+fa0lrbu/Hj60GyYL+8JgHHH7NjZ+L3LfEvLnaS79nsVd0Zo/qtf0OeLuwC8aYEK4dBoNMvM9UJfi00VOkfbYwlBEHdICgybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093097; c=relaxed/simple;
	bh=Lp+G6RNRNa1qqAWbsVbuiD5hhNvMHAeZ7fl9TFEhFn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG77N2qQg7TNkoPtmoHAxkutFy7RTsd+a5siK4DMl9GgSNhspL77bJzVu37MJQXERIU4p+z1ucc+EYC+w0HAmy1eWF17IjJVYwDcJIQ9F8nCQbEioiU5LnVzTrESH3aNQOcE/QF+jUgNCxNbrX53kGTo1CILVqMBwmUf5MglGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KN94QSbT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769093096; x=1800629096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lp+G6RNRNa1qqAWbsVbuiD5hhNvMHAeZ7fl9TFEhFn4=;
  b=KN94QSbTRWXVBryiyfXhKEfWN6FQl0v361LSmZh0nCt3e3M8fLIi3O7d
   3l1PPJlOjWUx32uVS4lKxUIRF3ONsg542zFIHDnprkyH2YnRYwcILXbpC
   c9+lTj/UXtPzVIBQkvSWMU+86N2RH7zUBYbXWbS52IFAuH82tUFnGBfGR
   S8VJ8bGwLB3EtM0Wi9wzZOa23RXIsppANKg0VKwVp93PjSmM4IuFMMMHg
   aGHkWajEqdu1K97nNGJuwrYd+RrWUwYfc7ew/GC+9SJqTUnitdMdDvjIe
   2yBDiib5ROKC9dIzN+JLMOyB5DnkIk8iyOb+GaPpxhWEnPWbCCGMAjegn
   w==;
X-CSE-ConnectionGUID: 1OOLouz3QOyeJyQUeodu/g==
X-CSE-MsgGUID: 1xA66/e7R6uYO5sgmlgixQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57901265"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="57901265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:44:55 -0800
X-CSE-ConnectionGUID: q/F6B0UHRvaQexLJIydWqA==
X-CSE-MsgGUID: LBnmNTG9R0W4LcVLy678jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206801848"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:44:50 -0800
Date: Thu, 22 Jan 2026 16:44:47 +0200
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
Subject: Re: [PATCH v2 net-next 02/15] net: mdio: add driver for NXP SJA1110
 100BASE-T1 embedded PHYs
Message-ID: <aXI339TiHFaEAWXE@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
 <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
 <20260122124708.pxckp6vgi2rvagmm@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122124708.pxckp6vgi2rvagmm@skbuf>
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
	TAGGED_FROM(0.00)[bounces-252382-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: B32636980D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:47:08PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:12:21PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 12:56:41PM +0200, Vladimir Oltean wrote:

...

> > > +static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
> > > +{
> > > +	struct sja1110_base_t1_private *priv = bus->priv;
> > > +	struct regmap *regmap = priv->regmap;
> > > +	unsigned int addr, val;
> > > +	int err;
> > > +
> > > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
> > 
> > GENMASK() ? Or do you have already a defined mask for this?
> 
> Hmm, I can't find a definition for this. In the MDIO world it is
> "well known" that clause 22 offers a 5-bit register address space.
> So the 0x1f number doesn't seem too magical to me.
> 
> But I think my assumptions date since before the MDIO bus API was split
> between separate clause 22 and clause 45 reads/writes. I don't know
> whether masking reg & 0x1f is the best practice. I'm surprised that
> __mdiobus_read() doesn't enforce a limit on "regnum", and I don't see
> other MDIO bus drivers explicitly C22 registers >= 32. I really don't
> know what is the best practice.

Me neither. At bare minimum to check / perform two things:
- make sure this approach is consistent across the kernel
- define the magic with meaningful name

Maybe (assuming second one is done) fix the rest in the future
via some helper function?

...

> > > +static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
> > > +{
> > > +	struct sja1110_base_t1_private *priv;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct regmap *regmap;
> > > +	struct resource *res;
> > > +	struct mii_bus *bus;
> > > +	int err;
> > 
> > > +	if (!dev->of_node || !dev->parent)
> > 
> > Can we avoid dereferencing? And perhaps dev_fwnode(dev)?
> 
> Avoid dereferencing what?

of_node

> > > +		return -ENODEV;
> > > +
> > > +	regmap = dev_get_regmap(dev->parent, NULL);
> > > +	if (!regmap)
> > > +		return -ENODEV;
> > > +
> > > +	bus = mdiobus_alloc_size(sizeof(*priv));
> > > +	if (!bus)
> > > +		return -ENOMEM;
> > > +
> > > +	bus->name = "SJA1110 100base-T1 MDIO bus";
> > > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > > +	bus->read = sja1110_base_t1_mdio_read_c22;
> > > +	bus->write = sja1110_base_t1_mdio_write_c22;
> > > +	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
> > > +	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
> > > +	bus->parent = dev;
> > > +	priv = bus->priv;
> > > +	priv->regmap = regmap;
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> > > +	if (res)
> > > +		priv->base = res->start;
> > > +
> > > +	err = of_mdiobus_register(bus, dev->of_node);
> 
> Why would I use dev_fwnode() if I need to pass it as OF to
> of_mdiobus_register() here?

dev_of_node() then. Wondering if we can use fwnode_mdiobus_register_phy() here
(I remember that OF/fwnode code in MDIO/PHY is not trivial, but I don't know
 all the details).

> > > +	if (err)
> > > +		goto err_free_bus;
> > > +
> > > +	priv->bus = bus;
> > > +	platform_set_drvdata(pdev, priv);
> > > +
> > > +	return 0;
> > > +
> > > +err_free_bus:
> > > +	mdiobus_free(bus);
> > > +
> > > +	return err;
> > > +}

-- 
With Best Regards,
Andy Shevchenko



