Return-Path: <netdev+bounces-131721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E562498F588
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F69DB2099F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4CA1A7250;
	Thu,  3 Oct 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDSvoWF3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81836126;
	Thu,  3 Oct 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977675; cv=none; b=f/qo7oZjZE3M/b8pk0kfJEGu5Gk9yc+WvKIPMwimvTxqZWwGEWwtwr2470mJ1AtgENb2SwYJKulkdoL9JhoSFv/PLXAf7WPOwcWjSIuBIUnf2O9Pbd7FJ611PKeN2DHnfVY7Ofgnk7nDJ4fEX3Il72kw5GYBnalq919jx7io87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977675; c=relaxed/simple;
	bh=BBAlqBhSnPMozlYFdbQWCelgUwjNdy//bRfOuSlblps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muSe3QT8VIYOdp4oJoUebH0HzLxQI4Losu4/nbVSlHaHgov2Sdyc1xL2j7yvxVJF20xb5uygdZcoVOrT5r4cAs63H852jyiPca4/e3ksirL04SCv2n3fp+Ah0+snOSOMbkRNPGeIreuMQI2eADLDdxyfG5M83r4mLn6s+j5T+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDSvoWF3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977674; x=1759513674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBAlqBhSnPMozlYFdbQWCelgUwjNdy//bRfOuSlblps=;
  b=eDSvoWF3zrN2r17QGdbdeXILzEgG0Mp91S/yMUeuh+rmb4dh5REvn40m
   mTT3n6tXXeVKJrPxGM8y72OtovPBsu1CjHGtunTRVBrKqQvH5ra2Mw720
   woI58FGwbNOzgu+eAsGrRnjNJg/CEZT0kd9cI+/HXkSFPGqFSjn+pdo8U
   MpnxhAG1iYAC5azUWgzxWSBaL2WRgJMZpvAU2C4GptzhWSGfzDSXMh446
   mQS7RBramdc7FA/LabDZnERxhMo8pD8SW78ryUtXwRhNi5sxjYKmNI1mi
   tUt+9ibyRKyIE/qu5WJ0YHLKkIdq26qcDlyuzHBb+4LSFFVcpHVUc1vqg
   Q==;
X-CSE-ConnectionGUID: p2E5qJ+zQ2+iyHiG4VFnlQ==
X-CSE-MsgGUID: STEEWqP1S0mqMiZDqcc0EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="49714925"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="49714925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:47:53 -0700
X-CSE-ConnectionGUID: Qsfl+iIVTfaDD2DBt1JJTQ==
X-CSE-MsgGUID: g+hoeYPwSquySlq834lcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="97748898"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:47:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swPvX-0000000GFE7-2gmU;
	Thu, 03 Oct 2024 20:47:47 +0300
Date: Thu, 3 Oct 2024 20:47:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv7Yw1iJehLW73Fq@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
 <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
 <e242741e-2f9f-4404-93f9-83e8971ace7a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e242741e-2f9f-4404-93f9-83e8971ace7a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 03:38:45PM +0200, Przemek Kitszel wrote:
> On 10/3/24 14:46, Andy Shevchenko wrote:
> > On Thu, Oct 03, 2024 at 03:43:17PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:

...

> > > > +#define __scoped_guard_labeled(_label, _name, args...)			\
> > > > +	for (CLASS(_name, scope)(args);					\
> > > > +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> > > > +		     ({ goto _label; }))				\
> > > > +		if (0)							\
> > > > +		_label:							\
> > > > +			break;						\
> > > > +		else
> > > 
> > > I believe the following will folow more the style we use in the kernel:
> > > 
> > > #define __scoped_guard_labeled(_label, _name, args...)			\
> > > 	for (CLASS(_name, scope)(args);					\
> > > 	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> > > 		     ({ goto _label; }))				\
> > > 		if (0) {						\
> > > _label:									\
> > > 			break;						\
> > > 		} else
> > > 
> > > ...
> > > 
> > > > -	     *done = NULL; !done; done = (void *)1) \
> > > > +	     *done = NULL; !done; done = (void *)1 +  	\
> > > 
> > > You have TABs/spaces mix in this line now.
> > 
> > And FWIW:
> > 1) still NAKed;
> 
> I guess you are now opposed to just part of the patch, should I add:
> # for enabling "scoped_guard(...) return ...;" shortcut
> or keep it unqualified?

As you put a reference to the whole list the detailed elaboration
is not needed.

> > 2) interestingly you haven't mentioned that meanwhile I also helped you to
> > improve this version of the patch. Is it because I NAKed it?
> 
> 0/1 vs false/true and whitespaces, especially for RFC, are not big deal

+ the above now.

I assume every contribution should be credited, no?
Otherwise it sounds like a bit of disrespect.

> anyway, I will reword v2 to give you credits for your valuable
> contribution during internal review :)

-- 
With Best Regards,
Andy Shevchenko



