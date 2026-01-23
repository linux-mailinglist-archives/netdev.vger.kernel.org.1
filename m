Return-Path: <netdev+bounces-252655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D81Abwic2mUsgAAu9opvQ
	(envelope-from <netdev+bounces-252655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:26:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7D71B40
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C9A30210C5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC5353EFF;
	Fri, 23 Jan 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktal4cYF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB884316917;
	Fri, 23 Jan 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153132; cv=none; b=oSyLaC2t4V3WmFNYHMVdmHcZSim8zG5DKVS03IAfjh00+wjIQfeLQSkBmjmW5lIPeRRk3BWZGqjtrrLsx0B4xw1KN6Ho0K6w9CK2ii9kYopXdF/Mpc97eSsE4edgTLpxM1/Mduf6a/x9FchEtSOAOtUxxEu3SQ/St+3EnNb/jcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153132; c=relaxed/simple;
	bh=7W56WHhueIg/HmPMtMILU6q4oOPjHjeeudduYSbM710=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHSfMUCaOVEUUIT7bVQmYHOjeYRH8kS8RrtwgircoaI+PhV/wWl0P4eYqT+pBHs/ZEjbpeVhCuiH5prL85RWS5YoKs/339yCnzMnffhesrjOy1HK3GZ2sJ24Hwd3qIp3RTYEnu2Ve37rvvabNss0iKRY2CFciLqcG/K1i2vAk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktal4cYF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769153131; x=1800689131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7W56WHhueIg/HmPMtMILU6q4oOPjHjeeudduYSbM710=;
  b=ktal4cYFC7nSN/+jvhY/U6eA83930MFHTUgW0lmaQo2uG/9sa1krSspl
   vrIfV2MCQw037LdTPUJXLsuuYYnDqfwnuxZxLMbbXbs4lNaGqU7A1xrG1
   48//X0RBSJ7D1LDcTrms+AqRBs6eBwY/1gXFVzqVw/tGR4xNsdYqo1yDG
   MjC51/cooTWrRI8i2IXyoKwIu68YtBRh2MbDOuNzodKrp4psewUyVntR2
   9VdTqGLDBz5YivCJdGlkKaQzmgFsxY21HvyB/aHuUTYZv2nDvvo/oKDmK
   Zy2v9VHbSyBRR6bXn8leGmhdHypNI4DIOE+nT8mUpbGRFIz7LUIeyPzJt
   w==;
X-CSE-ConnectionGUID: kpc7BqJVQLWS8qoLs3mnXg==
X-CSE-MsgGUID: FTH0CuhTQYe2CQnb1tlGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57974884"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="57974884"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:25:30 -0800
X-CSE-ConnectionGUID: DrObkHQGSvGNgj77c4biBA==
X-CSE-MsgGUID: G/51SBsNTo+yO4OJwnmriA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206861769"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:25:25 -0800
Date: Fri, 23 Jan 2026 09:25:23 +0200
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
Message-ID: <aXMiY_1bDbhtCFK7@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
 <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
 <20260122124708.pxckp6vgi2rvagmm@skbuf>
 <aXI339TiHFaEAWXE@smile.fi.intel.com>
 <20260122221003.p2cbemzvi2mayety@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122221003.p2cbemzvi2mayety@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 9EF7D71B40
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:10:03AM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 04:44:47PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 02:47:08PM +0200, Vladimir Oltean wrote:
> > > On Thu, Jan 22, 2026 at 02:12:21PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jan 22, 2026 at 12:56:41PM +0200, Vladimir Oltean wrote:

...

> > > > > +	if (!dev->of_node || !dev->parent)
> > > > 
> > > > Can we avoid dereferencing? And perhaps dev_fwnode(dev)?
> > > 
> > > Avoid dereferencing what?
> > 
> > of_node
> 
> Why? The driver is useless when bound to a device without an of_node.
> of_mdiobus_register() will fall back gracefully to __mdiobus_register(),
> and still technically get registered, but its child PHYs will be
> inaccessible through phandles.

dereferencing != use

> > > > > +		return -ENODEV;

What I meant is to avoid accessing of_node directly, use APIs: dev_of_node().

...

> > > > > +	err = of_mdiobus_register(bus, dev->of_node);
> > > 
> > > Why would I use dev_fwnode() if I need to pass it as OF to
> > > of_mdiobus_register() here?
> > 
> > dev_of_node() then. Wondering if we can use fwnode_mdiobus_register_phy() here
> > (I remember that OF/fwnode code in MDIO/PHY is not trivial, but I don't know
> >  all the details).
> 
> fwnode_mdiobus_register_phy() shall be read as: "hey MDIO bus, please
> register a PHY for this fwnode!"
> 
> of_mdiobus_register() shall be read as: "I have this mii_bus structure
> and I want it registered as an active MDIO bus, associated with this OF
> node".
> 
> So the two do not serve the same purpose; one is not the more generic
> variant of the other.
> 
> There is no fwnode variant of of_mdiobus_register(). Perhaps this
> snippet from drivers/net/ethernet/marvell/mvmdio.c can clarify:
> 
> 	/* For the platforms not supporting DT/ACPI fall-back
> 	 * to mdiobus_register via of_mdiobus_register.
> 	 */
> 	if (is_acpi_node(pdev->dev.fwnode))
> 		ret = acpi_mdiobus_register(bus, pdev->dev.fwnode);
> 	else
> 		ret = of_mdiobus_register(bus, pdev->dev.of_node);
> 
> Out of the two API functions, I used OF because that's what I need
> to support.

I see, so perhaps in the future we will see this snipped to be converted to
fwnode_mdiobus_register() then. Thank you for clarification.

> > > > > +	if (err)
> > > > > +		goto err_free_bus;

-- 
With Best Regards,
Andy Shevchenko



