Return-Path: <netdev+bounces-244174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03187CB13F9
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 22:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C6A30AC65D
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BAF2DEA79;
	Tue,  9 Dec 2025 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDT4WvDf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAA262FC1;
	Tue,  9 Dec 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765317283; cv=none; b=fF4mWUbahSimVBgZSbzU1qheuDQ+u0P/h57k+f1v02zAJd70E1MFBcA4WW7uCsVm6tsP4kiEVgq2R7fKvzxvLlX2gzQc1WFqov2ZK4xbzJ3EH8C4KHcwY/irILZFGR9nL+V635HIxfdwWtvIo5S0bOUlMjnrOZRlUEh/gGST1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765317283; c=relaxed/simple;
	bh=xtYLyHUmG1D0oKjx5ZhX3mwTe2vJZTh9I0Ydg0tBMjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH3nUfvvXyY2zTJvVjd1f3L4d9pNIPE58DaQ69PiYtbnIXDmgvWJpuB9OntKToimkJl9S2sfkCPMQQIcdtT4dB4qVZJWb1kkHCBqm2cpZuRDwsSEQ+SgBzdOinr21VxnIoezEHdGUtJGgdFM79+Ee6vyaGlnW3JM6UJLdOjeyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDT4WvDf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765317282; x=1796853282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtYLyHUmG1D0oKjx5ZhX3mwTe2vJZTh9I0Ydg0tBMjQ=;
  b=CDT4WvDfaiFmt1eA9KbXD1rYNHtqO9GfB7PuMOSlZY3TPXbUvZoWPvTa
   ou8YdcLqhAVcxWGIXYBrq25a7dq92blxZzTg9d+h1P+nGNgdyVtyw72Q0
   6O5SMj27GxlYmIqBBHdTW5ev+snixP/DVWMAJw6GJl3UvNlSZ/WD/JM+S
   PLN5sduEWH38uFZVWAX86pxFeLNBP9Knbak8dgTT1VhXxG6OwaJamT5Sf
   0p3HUWvUYZ7BqVdC4SGs8hPPdo9xjilXor6zTJ/Fw4jdsqU84jmaJaZo0
   jSIwtg/OgM7ABo2vbRvkVzhDIPBWg57QI11wh2/q7hJeHX1wE5iHavJpI
   Q==;
X-CSE-ConnectionGUID: 1Fs+mFqaRxOIHm2+P7oa4w==
X-CSE-MsgGUID: LepQURjsQAqku/24tor4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67335278"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67335278"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:54:41 -0800
X-CSE-ConnectionGUID: xvwgSbk6Qq+Tzw0Qk9o/AQ==
X-CSE-MsgGUID: p7dPqkNBQYS9nOuDpCUxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="200817543"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:54:37 -0800
Date: Tue, 9 Dec 2025 23:54:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 4/9] bitfield: Copy #define parameters to locals
Message-ID: <aTiamjTnVw8sYhE0@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-5-david.laight.linux@gmail.com>
 <aThFlDZVFBEyBhFq@smile.fi.intel.com>
 <20251209191148.16b7fdee@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209191148.16b7fdee@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 07:11:48PM +0000, David Laight wrote:
> On Tue, 9 Dec 2025 17:51:48 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Dec 09, 2025 at 10:03:08AM +0000, david.laight.linux@gmail.com wrote:

...

> > > -#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
> > > +#define __BF_FIELD_CHECK_MASK(mask, val, pfx)				\
> > >  	({								\
> > > -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> > > -				 _pfx "mask is not constant");		\
> > > -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> > > -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> > > -				 ~((_mask) >> __bf_shf(_mask)) &	\
> > > -					(0 + (_val)) : 0,		\
> > > -				 _pfx "value too large for the field"); \
> > > -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> > > -					      (1ULL << __bf_shf(_mask))); \
> > > +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> > > +				 pfx "mask is not constant");		\
> > > +		BUILD_BUG_ON_MSG((mask) == 0, _pfx "mask is zero");	\
> > > +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> > > +				 ~((mask) >> __bf_shf(mask)) &		\
> > > +					(0 + (val)) : 0,		\
> > > +				 pfx "value too large for the field");	\
> > > +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> > > +					      (1ULL << __bf_shf(mask))); \
> > >  	})  
> > 
> > I looks like renaming parameters without any benefit, actually the opposite
> > it's very hard to see if there is any interesting change here. Please, drop
> > this or make it clear to focus only on the things that needs to be changed.
> 
> I'm pretty sure there are no other changes in that bit.

Yes, but the rule of thumb to avoid putting several logical changes into a
single patch and here AFAICT the renaming should be avoided  / split to a
precursor or do it after this.

> (The entire define is pretty much re-written in a later patch and I
> did want to separate the changes.)

Then probably don't do the change at all (renaming), as it's useless here?

> I wanted to the file to be absolutely consistent with the parameter/variable
> names.

No objection on this.

> Plausibly the scheme could be slightly different:
> 'user' parameters are 'xxx', '__auto_type' variables are '_xxx'.
> But internal defines that evaluate/expand parameters more than once are
> '_xxx' and must be 'copied' by an outer define.

-- 
With Best Regards,
Andy Shevchenko



