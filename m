Return-Path: <netdev+bounces-131724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF798F597
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2539D1C21A8A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C771AAE00;
	Thu,  3 Oct 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhjvbEFo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F219F418;
	Thu,  3 Oct 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977914; cv=none; b=HJdKUU3GLBefixUzdEuhAVxaIdt2nPoeSpn70T6LO0nIL491z33XhdlQdUlKmtbgo0g4I151mnv6uuu3ge5ObulaBuaka4QKDGxkFHoMq+dohHT+K+wwfg4ZdHWupiEBL2NWyr7Is4Ke59CAMa4TfLXKjxzyo5V841QJLclHphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977914; c=relaxed/simple;
	bh=YQb/Jf5Vu5sbohGAQtFYGn7Gk1YkMnWyUEDhMWp80Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLU8rjoj0C1j2UuDT1WiwzSv/+nf3kR653yiuYg2oneNc+IUWNE1wa91SWqXaUUrEtT2dzpW23uSCl0Uh96G1jQs1nSyrzqAn6oY9+HLNFKMS6uYzh1KaZi3Z0eOvlAfS6gJ4cs8jslc49Cr2Du69+9rEElvbaev0DRpULXuoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhjvbEFo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977913; x=1759513913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YQb/Jf5Vu5sbohGAQtFYGn7Gk1YkMnWyUEDhMWp80Oo=;
  b=lhjvbEFoRtFl3HrL8ePaTUrXWJYrsfryeFlWkd8iY0wV4FMHhwRryDhE
   tobVfXTETHAhObZbXcbSKVF9iFSEbmlt8RxKz0AtL9cvZPItJvoijWiAq
   YA/8ICSQWEDHlJ2pHtI/BlLe2/0tUqW7sgqT2zI59y/vyrMlqmM91GpWY
   Jz/xzVqlT+2C7JXgmTG/Tcl8jkjJ4pOkaZl7An3VdzTFfYoxu4n/50BET
   NJiGb7X1JHdSz9xBP/JDtG7kE5JEaerNXXBvXfSZkJQffHpjYznUiGpcz
   +MDndkj+BqlUv+l4a9TmyAQ2XAbLmtSuc8JLEKil3CR4W5b2QwmNIgL+s
   Q==;
X-CSE-ConnectionGUID: 8D1cJ3eMR3OhrMllKWYZ0Q==
X-CSE-MsgGUID: Tk3AhTnuTkacoFZtCDKZ+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="49715396"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="49715396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:51:52 -0700
X-CSE-ConnectionGUID: PO068jjwQa+3pAle2fxC4g==
X-CSE-MsgGUID: eHBkL0gWR7COUt9pm6xpqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79397954"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:51:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swPzO-0000000GFJL-3MX1;
	Thu, 03 Oct 2024 20:51:46 +0300
Date: Thu, 3 Oct 2024 20:51:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv7ZsieITDle2lgl@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
 <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
 <20241003141221.GT5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141221.GT5594@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 04:12:21PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2024 at 03:46:24PM +0300, Andy Shevchenko wrote:
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
> 
> Yeah, needs braces like that. I'm not super opposed to this, however, 
> 
> > And FWIW:
> > 1) still NAKed;
> 
> I would really like to understand why you don't like this; care to
> elaborate Andy?

To me the idea of

int my_foo(...)
{
	NOT_my_foo_macro(...)
		return X;
}

is counter intuitive from C programming. Without knowing the magic behind the
scenes of NOT_my_foo_macro() I would eager to ask for adding a dead code like

int my_foo(...)
{
	NOT_my_foo_macro(...)
		return X;
	return 0;
}

What I would agree on is

int my_foo(...)
{
	return NOT_my_foo_macro(..., X);
}

Or just using guard()().

-- 
With Best Regards,
Andy Shevchenko



