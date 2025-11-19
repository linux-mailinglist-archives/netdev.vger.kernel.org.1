Return-Path: <netdev+bounces-240103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F2C70855
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F8A4E8A09
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1973081A5;
	Wed, 19 Nov 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJKvu3e8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0618FDDB;
	Wed, 19 Nov 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573996; cv=none; b=GXeGOsqQ1JLMdEVdMUWl2QnGbR+uVC6s14/BxLlo9ObTpXhkXAJG11tZN+TdF8wXhGxx3WITS2iPE9OYqgvGbU62FyzZNgnfey2CeOsKF6ec37nS4r/JzK/+Muufq5++HFBspscuf8aoJg52+lBpQnjP28mDuJ5i22N7zGWjqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573996; c=relaxed/simple;
	bh=Bjn4BraK/Py9sIk7zFAiJG3N6SyJlS0AEVUR4C3qAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqDiyp+we2rbNh4OMI7jbksNPMZtJy5AAPBNQ6JcQ1sEaMb8jYnI3zeKUGI75aVC1W1hxoM1x9OnOr0mS5aK3XafslcsmEJPxopnU5LGbDieqvdnmn1cNYL+xHsTS8nzOqHW5DMJAhPtaa4S7PmooJXidKLzvI2mE4tqDpWFiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJKvu3e8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763573989; x=1795109989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bjn4BraK/Py9sIk7zFAiJG3N6SyJlS0AEVUR4C3qAWo=;
  b=aJKvu3e8ZhCCo0Xt6JAs/K1ai5/6XBkil+iZRcgZzkUeZ4TdWNIJZg0+
   h68Sqz943c96LbRM2NCZPpSPykQ8xN1Oy88cg2b14fpM+yNIXQFp5wwnB
   jGdgMAHJVK2uL8+gawWfS8iFKEsgPdferohdSXmWLY6FxBpR0aQIvgEl1
   PvDRg0K+2kGyu9Bq9ddGNxxlgXeOEqCifYAdQot+a+T1PpckZVPxjBIm0
   rxzepZuR21/A/Dj7RhQVuYvgF2tSZ0KsWjtCAnKONXoJb3CBYfWOgA3gx
   LCGqfBGqiogW+3wV+JgX5pVC4SGX+DbigRx32n0c4ffqearU98o18VYyC
   w==;
X-CSE-ConnectionGUID: rNO7soykSGOI6n2B7vVCNw==
X-CSE-MsgGUID: CDhWm+TKT+erBQAsQuOF2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83016162"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="83016162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:39:39 -0800
X-CSE-ConnectionGUID: zCsG4mRjQBiTZM+MvbPyQw==
X-CSE-MsgGUID: MWBeMgPjRpO4CuKng5x6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="196262565"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:39:35 -0800
Date: Wed, 19 Nov 2025 19:39:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR4A1MaCn9fStNdm@smile.fi.intel.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
 <20251119112522.dcfrh6x6msnw4cmi@skbuf>
 <20251119081112.3bcaf923@kernel.org>
 <aR3trBo3xqZ0sDyr@smile.fi.intel.com>
 <aR39JBrqn5PC911s@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR39JBrqn5PC911s@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 05:23:48PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 06:17:48PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:
> > > On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:
> > > > I think it's due to the fact that the "contest" checks are fundamentally
> > > > so slow, that they can't be run on individual patch sets, and are run on
> > > > batches of patch sets merged into a single branch (of which there seem
> > > > to be 8 per day).
> > > 
> > > Correct, looking at the logs AFAICT coccicheck takes 25min on a
> > > relatively beefy machine, and we only run it on path that were actually
> > > modified by pending changes. We get 100+ patches a day, and 40+ series,
> > > and coccicheck fails relatively rarely. So on the NIPA side it's not
> > > worth it.
> > > 
> > > But, we can certainly integrate it into ingest_mdir.
> > > 
> > > FTR make htmldocs and of course selftests are also not executed by
> > > ingest_mdir.
> > 
> > Btw, do you do `make W=1` while having CONFIG_WERROR=y?
> > And if so, do you also compile with clang?
> 
> If you look at any patch in patchwork, e.g.
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/E1vLgSZ-0000000FMrW-0cEu@rmk-PC.armlinux.org.uk/
> 
> it gives a list of the tests performed. In answer to your questions:
> 
> netdev/build_clang 	success 	Errors and warnings before: 1 this patch: 1
> 
> So yes, building with clang is tested.
> 
> I can say that stuff such as unused const variables gets found by
> nipa, via -Wunused-const-variable, which as I understand it is a
> W=1 thing.
> 
> I suspect CONFIG_WERROR=y isn't used (I don't know) as that would
> stop the build on warnings, whereas what is done instead is that
> the output of the build is analysed, and the number of warnings
> counted and reported in patchwork. Note that the "build" stuff
> reports number of errors/warnings before and after the patch.
> 
> Hope this answers your question.

Pretty much, thanks!

-- 
With Best Regards,
Andy Shevchenko



