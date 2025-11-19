Return-Path: <netdev+bounces-239922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0061C6DFE3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 53AF2242B9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3234B191;
	Wed, 19 Nov 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEhenwBB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DB26B2D3;
	Wed, 19 Nov 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548295; cv=none; b=BfOCT5Ly/1gavnN++w5RhAG5w6YycrYlMe3V3zYKFhlqZBQwy7ZAZrMOXfNJ4x8RtwT1V63A1TdIP+ui/lf24AJ2n2c13K+7V/ETQYVTIzEvan9kzNfqKlxuys0UrvKW0sSr6JsNgEPUXNLKH+PWVzdaNYEb5EYkGgkDZd6FRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548295; c=relaxed/simple;
	bh=KtDcZHSvhj7fJOFvGyXUFC3nphFFNItQhRAAxUGAJ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j42OafVWmWhpi5rKDj/gDb2lynJy5HdHloGD8+BupeDEsL6bPndBF+y7WxfdtovHZ04gkqspdymqBOJDSRQh24vEemKeDq00Px/KdMbfSCyXK4p0hfRmdOIFHUXMgDOpKHBoFiYghlp1JvQlE1iwCapLS0jqcDp53YsZphjHIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEhenwBB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763548295; x=1795084295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtDcZHSvhj7fJOFvGyXUFC3nphFFNItQhRAAxUGAJ18=;
  b=FEhenwBBieLgA7oT5IliOleaqDF6vG5PPbo0QimGNPKlp6wUqe0eZQx9
   e0PMzWtMlIDz85YtI0RAbJAQEMfaea83yOWZrLvMMTq/Z+LPVNPMtITk7
   9+ElU+GHlnAoHsYbcu7bbVmj7sINb9/JVXQGPL9Aj1HkHx1qeok2RFHWl
   MJAOcjcwXk7MK6kJQwAGy/2rFg+UcqC5Wd7VyixmIfzOBZa/MvkjCJU6U
   xDJ4bsjz78lay6KFPc2SN4v/zdCeYyLSCz5hk2sClsKktHYnl5J7b2gcP
   qrSD1Lj7QagwA4gcwVergoff0p+RVmOV4ADc9MoxpFbw196L8gp43bx59
   g==;
X-CSE-ConnectionGUID: cL7q5/skTO6TMlaLCCNDOQ==
X-CSE-MsgGUID: Q+Jj+veyRS2u1rgwcrHaZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65518381"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65518381"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:31:34 -0800
X-CSE-ConnectionGUID: 8nxlWazwTx+EiSKaHL8adw==
X-CSE-MsgGUID: BiuZlLbbQJe9gbCFC3jMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190271566"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:31:30 -0800
Date: Wed, 19 Nov 2025 12:31:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR2cf91qdcKMy5PB@smile.fi.intel.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119095942.bu64kg6whi4gtnwe@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 11:59:42AM +0200, Vladimir Oltean wrote:
> On Tue, Nov 18, 2025 at 04:41:30PM -0800, Jakub Kicinski wrote:
> > On Tue, 18 Nov 2025 21:05:29 +0200 Vladimir Oltean wrote:

...

> > > +	for_each_child_of_node(node, child) {
> > > +		if (!of_node_name_eq(child, name))
> > > +			continue;
> > > +
> > > +		if (of_property_read_u32_array(child, "reg", reg, ARRAY_SIZE(reg)))
> > > +			continue;
> > > +
> > > +		if (reg[0] == res->start && reg[1] == resource_size(res))
> > > +			return true;
> > 
> > coccicheck says you're likely leaking the reference on the child here
> 
> Ok, one item added to the change list for v2.

Note, we have __free() and _scoped() variants of the respective APIs to make it
easier to not forget.

> Why is cocci-check.sh part of the "contest" test suite that runs on
> remote executors? This test didn't run when I tested this series locally
> with ingest_mdir.py.

I believe it's due to heavy load it makes. Running it on a (whole) kernel make
take hours.


-- 
With Best Regards,
Andy Shevchenko



