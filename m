Return-Path: <netdev+bounces-252654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LFnDxUic2mUsgAAu9opvQ
	(envelope-from <netdev+bounces-252654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:24:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80971AB8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598233015455
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BC332903;
	Fri, 23 Jan 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwXkInno"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46423168F1;
	Fri, 23 Jan 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152870; cv=none; b=jiLjqGise7k4AjWu8OQBzGvG8etwsnEsESS8VT9KV6Yrac7Ek3zEScYBSJNkfnvSm2rU8kB6CZzkUA0cr2pIw8hZJcaCfDA2H+tqxIXKzQVG5D/nlYlXynBFhJobDivI1vF9eB5WNGqnEo1KSIKVnHA5yrUeGxoNd5jvLK+FtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152870; c=relaxed/simple;
	bh=EVZM8i72JTVmyCAaYpKZOevQq4ai7P5rZPslFXeTKZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Vvvf8drM5kqfUI0FUXXZsGSLCaFnzVM5YZdydmKon5U5ODE/YIILXisM06ekVRaNVbFTF50Si76Vte2rq7sR2CIImGQjPQJo09F0e0Ze/Bm94Z1bbifthUzD4dehDw4MxqtWPm3ULJ2yyzbC2KgKvzWrh+7ZFt0+fpRz0oU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwXkInno; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769152869; x=1800688869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EVZM8i72JTVmyCAaYpKZOevQq4ai7P5rZPslFXeTKZI=;
  b=XwXkInnoXLfo5GXOeSixoInXS898wbRXRmVe5YIFy3wNxw9xUiJZU1sV
   w6EZajZgT4rmP8JbrwLpW8xOQZ52cHhshWm0yosEs6QqAz6fB+rY498c9
   q2ygEAOnlApFZBMiUOHeAoX5d3H4jVn5Js0u7+WqA8MTuBoXtSqjkLPms
   rZk3w8mst10NvZco+wIxuZRfE+vWPnBaDlC2w9mZZog8KusZkg9Un23Rz
   C/wEEc0Q7N9snphKQDqwI3ixtTV/b5zPhDCfZ5czhtvueu2NLWR591GFb
   RRP8UY3CnLM1P0LjeUjmA/KoLRKZxVnsyqT8kRQiGAoqbC+FpjjF6aNvX
   w==;
X-CSE-ConnectionGUID: s3J3/VHZTuyJ6O6w7fnqow==
X-CSE-MsgGUID: /hA74zfNQwaWrNeypbVCEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70125915"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70125915"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:21:06 -0800
X-CSE-ConnectionGUID: adBIYdryTta+8/J/CZNT0Q==
X-CSE-MsgGUID: hboqfqoRR0ySr41HzLAWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207005243"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:21:01 -0800
Date: Fri, 23 Jan 2026 09:20:58 +0200
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
Message-ID: <aXMhWo0NpPK-BELG@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122221848.py4p7mwxzybicnsq@skbuf>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252654-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,bootlin.com:url,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: CF80971AB8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:18:48AM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 04:38:37PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 03:47:04PM +0200, Vladimir Oltean wrote:
> > > On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:

...

> > > > > > +	unsigned int base;
> > > > > 
> > > > > Hmm... resource_size_t ?
> > 
> > > > Well, regmap_read() takes "unsigned int reg".
> > > > https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> > > > So in practice, a truncation will be done somewhere if the register base
> > > > exceeds unsigned int storage capacity. But I didn't feel that it's worth
> > > > handling that.
> > > 
> > > Would this address your feedback?
> > 
> > Yes and no. See my remarks below.

...

> > > -	if (config->resource)
> > > +	if (config->resource) {
> > 
> > Btw, this might be not enough, one should check size and flags as well
> > before use. There was a discussion about this recently. Maybe we should
> > just move to a simple unsigned int in the config for now? Because handling
> > resources maybe considered as over engineering in this case.
> 
> The resource flags are never taken into consideration, but I can for
> sure replace the resource in struct mdio_regmap_config with just an
> unsigned int start and an end, but that doesn't get rid of the resource
> usage. The dev_get_resource(dev->parent, NULL) call is how we learn of
> where our register window is located in the "one big regmap" provided by
> the parent (SJA1105). So we still need this check somewhere else if we
> wanted to not fail silently in case of address bits truncation.

Hmm... Bu why we can't embed the full struct resource in such a case?
Because resource should have a flag check, otherwise it's a wrong check.

Discussion I mentioned is this:
https://lore.kernel.org/lkml/20251207215359.28895-1-ansuelsmth@gmail.com/

Fixes due to that finding:
https://lore.kernel.org/lkml/20251208200437.14199-1-ansuelsmth@gmail.com/
https://lore.kernel.org/lkml/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com/

> > > +		if (config->resource->start > U32_MAX ||
> > > +		    config->resource->end > U32_MAX) {
> > 
> > Ideally it should be resource_overlaps() check. But see above.
> 
> resource_overlaps_with_what? The only problem is that the resource can
> exceed the 32 bit representation that regmap works with.

Obviously with the 4G address space :-)

	struct resource r4g = DEFINE_RESOURCE...(..., 0, SZ_4G...);

	if (resource_overlaps(&r4g, config->resource))
		aiaiai! // using %pR to print the content

> > > +			dev_err(config->parent,
> > > +				"Resource exceeds regmap API addressing possibilities\n");
> > > +			return ERR_PTR(-EINVAL);
> > > +		}
> > >  		mr->base = config->resource->start;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko



