Return-Path: <netdev+bounces-182047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F4A877FC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090F57A247E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD91AC458;
	Mon, 14 Apr 2025 06:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C39461;
	Mon, 14 Apr 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612587; cv=none; b=V0+LEswBAc5i4r8bCxDNatmoiKMY/Az90NyfqJ7Hezp7RmpocZip+VKppxwCLRCVcXQgyuJDEL8rQCmM1CLlC/xQdzU5WYBgQ8iMIH/p80rMvtEN9FcXhVShGKejrHZaR+tH8w5w4B9POoe4xnIRrMq7gty/sfFiiA9B3s/rjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612587; c=relaxed/simple;
	bh=Kt6zZL3qwYe3T/6wCjXt8RSMNjqz6aTlMHNVxRv1JTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCIDMXEo/q1bB+PbE468AD65XAoy/sb36lVofvnEFlV0IL6i0MGt2q79PPWr599yWhJmI614U6EAKf/viYiOJHjiGVyIqSKCUunSQuN1QAHetS0CNnQCytuSWYhJLh3DUdAAxBgPSvXeZHhLE2sZR+1e+dvjq18njRek8NqHWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: qijxJlCJSSiT7E5X0QS2TA==
X-CSE-MsgGUID: wgsF3KS8Sd2u7N3kCUuUtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="49872934"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="49872934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:36:25 -0700
X-CSE-ConnectionGUID: tKrMwEcIR+6eiqIM4QFn0w==
X-CSE-MsgGUID: 51+4ks8WT4+ifV71S0N2IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130275780"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4DQX-0000000C9Uq-01JE;
	Mon, 14 Apr 2025 09:36:17 +0300
Date: Mon, 14 Apr 2025 09:36:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
Message-ID: <Z_ys4Lo46KusTBIj@smile.fi.intel.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
 <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 08:40:22AM +0200, Ivan Vecera wrote:
> On 07. 04. 25 8:05 odp., Andy Shevchenko wrote:
> > On Mon, Apr 07, 2025 at 07:28:28PM +0200, Ivan Vecera wrote:

...

> > > +/*
> > > + * Regmap ranges
> > > + */
> > > +#define ZL3073x_PAGE_SIZE	128
> > > +#define ZL3073x_NUM_PAGES	16
> > > +#define ZL3073x_PAGE_SEL	0x7F
> > > +
> > > +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
> > > +	{
> > > +		.range_min	= 0,
> > 
> > Are you sure you get the idea of virtual address pages here?
> 
> What is wrong here?
> 
> I have a device that uses 7-bit addresses and have 16 register pages.
> Each pages is from 0x00-0x7f and register 0x7f is used as page selector
> where bits 0-3 select the page.

The problem is that you overlap virtual page over the real one (the main one).

The drivers you mentioned in v2 discussions most likely are also buggy.
As I implied in the above question the developers hardly get the regmap ranges
right. It took me quite a while to see the issue, so it's not particularly your
fault.

> > > +		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
> > > +		.selector_reg	= ZL3073x_PAGE_SEL,
> > > +		.selector_mask	= GENMASK(3, 0),
> > > +		.selector_shift	= 0,
> > > +		.window_start	= 0,
> > > +		.window_len	= ZL3073x_PAGE_SIZE,
> > > +	},
> > > +};

...

> > > +	zldev->regmap = devm_regmap_init_i2c(client,
> > > +					     zl3073x_get_regmap_config());
> > 
> > It's perfectly a single line.
> 
> I tried to follow strictly 80 chars/line. Will fix.

Yes, but in some cases when it gains in readability it is allowed to use longer
lines even if one sticks with stricter 80 characters limit.

-- 
With Best Regards,
Andy Shevchenko



