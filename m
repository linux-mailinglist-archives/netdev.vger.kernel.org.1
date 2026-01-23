Return-Path: <netdev+bounces-252855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFp5M36Ec2kDxAAAu9opvQ
	(envelope-from <netdev+bounces-252855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:23:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1676FB8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2C273008765
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB91328B41;
	Fri, 23 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1DmuAxl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DA30EF9D;
	Fri, 23 Jan 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178236; cv=none; b=FO1cZp6LdctVxf4CFJA0WIX/DkzqoJg67S1Oeio2dPVF5WIkq9qhk7e1wtk9ep0AFc56dCcAb5DKJXdoslCZ+PZpluV/3ykqnJHnQi/ClM9Rgr0xqrBdfisErqewauTV67BP+2m3EazbveeOzxmMHEDD66yEzJDLxcKn3Mi+vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178236; c=relaxed/simple;
	bh=a0YMZkAD2a5E2s7ETMm/WkewmQs83sM2I3yNPhhCcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZxhz6Yjjs32BRXY71PfgdGjH6vjl3PpUJXxR9L3gYEXDH2gto1AeMdf8rgnjingybSG7oACIB7KalVyXRw/qK1xRUt+QO5xkByeISF1smm48qfpqUCwkwK/7hQPHBZOHjEOmBHBwWWcEcFWPgSy4KGmfA+HmZfRiGVeZGqjqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1DmuAxl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769178235; x=1800714235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0YMZkAD2a5E2s7ETMm/WkewmQs83sM2I3yNPhhCcA0=;
  b=O1DmuAxlMHTex5aGNAXRXxJysLXOJeMoSJga1I6VsPXPzbXe9yXIQnXk
   MnLJgYXJe48J6gvcJuy2OMe++12ui12Wn/iIOUDHSJyE7rw/mSMzOVWY6
   UIXwsPSclXuVBJT2P9sQzgereY/TpzsbrqmI/llTE0S4sa2KSpvvGC2/l
   F+vU1wduAJhtnQGgUc7SBbZsjAA46/qlNg8+CYcrPPq8aN4+6h0Mbhhur
   cdOCCr7Ykc5ohK/qAXcUyvfR5OIv9OepC0b8WP23mKWlZhaNMZSbSEQaU
   MEIlbqzXoGvXW1IcOjwlEhFR1RqydjA0pMoXWancbbtWMW3r6RZL2xHms
   g==;
X-CSE-ConnectionGUID: jtJ/ehZOSIyb4WpVRD88zA==
X-CSE-MsgGUID: UvUPNlodT2etRTTy4xAdpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70482582"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70482582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:23:53 -0800
X-CSE-ConnectionGUID: ppHN3y9XRCibrXLjTT11vg==
X-CSE-MsgGUID: uJ61GAP6Ry2+GQo6Afnd4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206145827"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:23:48 -0800
Date: Fri, 23 Jan 2026 16:23:45 +0200
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXOEcT-iyRrAMxFf@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
 <20260123121529.inik6xrfdianljq6@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123121529.inik6xrfdianljq6@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252855-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 5DC1676FB8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:15:29PM +0200, Vladimir Oltean wrote:
> On Fri, Jan 23, 2026 at 09:20:58AM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 12:18:48AM +0200, Vladimir Oltean wrote:
> > > On Thu, Jan 22, 2026 at 04:38:37PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jan 22, 2026 at 03:47:04PM +0200, Vladimir Oltean wrote:
> > > > > On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:

...

> > > > > -	if (config->resource)
> > > > > +	if (config->resource) {
> > > > 
> > > > Btw, this might be not enough, one should check size and flags as well
> > > > before use. There was a discussion about this recently. Maybe we should
> > > > just move to a simple unsigned int in the config for now? Because handling
> > > > resources maybe considered as over engineering in this case.
> > > 
> > > The resource flags are never taken into consideration, but I can for
> > > sure replace the resource in struct mdio_regmap_config with just an
> > > unsigned int start and an end, but that doesn't get rid of the resource
> > > usage. The dev_get_resource(dev->parent, NULL) call is how we learn of
> > > where our register window is located in the "one big regmap" provided by
> > > the parent (SJA1105). So we still need this check somewhere else if we
> > > wanted to not fail silently in case of address bits truncation.
> > 
> > Hmm... Bu why we can't embed the full struct resource in such a case?
> 
> We can also embed the full struct resource, I never said we can't...
> 
> > Because resource should have a flag check, otherwise it's a wrong check.
> > 
> > Discussion I mentioned is this:
> > https://lore.kernel.org/lkml/20251207215359.28895-1-ansuelsmth@gmail.com/
> > 
> > Fixes due to that finding:
> > https://lore.kernel.org/lkml/20251208200437.14199-1-ansuelsmth@gmail.com/
> > https://lore.kernel.org/lkml/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com/
> 
> The linked issues seem unrelated; they are caused by the assumption that
> resource_size() can be zero. But I'm not using the resource_size()
> helper, and even if I were, I'm not testing it against zero.

I referred to the full discussion, and not just to the OP message.
During discussion it was explicitly said that:
1) doing

	struct resource foo = {};

is wrong, and

2) checking the resource parameters (start, end), a.k.a. size is wrong
without checking flags.

So it is related.

> As opposed to the PCI BAR case, we don't keep around in an altered form
> the resources exceeding 4G.
> Just need to reject them once and be done with them.

I'm not sure I follow here. The PCI case is much more complicated (it has
resources even in 64-bit space that can be resplit, remerged, etc. It's
a dynamic living thing due to hotplug and bridges and USB4/Thunderbolt.
I am definitely not talking about all of this.

> Also, what else to even check about the resource flags? We get the
> resource using "platform_get_resource(pdev, IORESOURCE_REG, 0)", so we
> know they're of that type. I don't think IORESOURCE_REG resources have
> any other valid bits in flags except for IORESOURCE_TYPE_BITS.

They can (not sure that is possible with current code, but in general)
be disabled, or size can be 0. Maybe even more, I haven't checked that.

> > > > > +		if (config->resource->start > U32_MAX ||
> > > > > +		    config->resource->end > U32_MAX) {
> > > > 
> > > > Ideally it should be resource_overlaps() check. But see above.
> > > 
> > > resource_overlaps_with_what? The only problem is that the resource can
> > > exceed the 32 bit representation that regmap works with.
> > 
> > Obviously with the 4G address space :-)
> > 
> > 	struct resource r4g = DEFINE_RESOURCE...(..., 0, SZ_4G...);
> > 
> > 	if (resource_overlaps(&r4g, config->resource))
> > 		aiaiai! // using %pR to print the content
> 
> This is a buggy replacement of my intention.

Sorry for that, I haven't given enough time to think about it.

> I need to sanity check that
> my IORESOURCE_REG resource is entirely within the 0-4G region.
> 
> The correct way to express this using helpers:
> 
> 	if (!resource_contains(&r4g, config->resource))
> 		nazad!
> 
> but... you see my point? In trying to make use of "standard" helpers, we
> overcomplicate simple things and introduce bugs.

I see, but do you see my points? I may have made a mistake, no doubts,
the point of using helpers is to avoid other, more subtle bugs.

> My initially proposed test can be written even simpler:
> 
> 	if (config->resource->end > U32_MAX) {
> 		...
> 
> because end >= start, so also testing resource->start is redundant.

Not at all, both needs to be checked and flags.

> > > > > +			dev_err(config->parent,
> > > > > +				"Resource exceeds regmap API addressing possibilities\n");
> > > > > +			return ERR_PTR(-EINVAL);
> > > > > +		}
> > > > >  		mr->base = config->resource->start;
> > > > > +	}

-- 
With Best Regards,
Andy Shevchenko



