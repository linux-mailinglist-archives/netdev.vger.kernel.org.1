Return-Path: <netdev+bounces-133701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C9996BBA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64D11C23E6B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48199199949;
	Wed,  9 Oct 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOz/nLYu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37711126C0F;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480076; cv=none; b=m9w87yQZU8KCaNaoqa0D0FIhyrko4BTFjis52unWkuKRgyAvPem2WZc9SaXKJ+AOKCG/GhPGQ+fOJ1qgWJvM6oMqNh+i9QRSu37CKRrgsxMorLzpjzmvIH1lhpLH6z35XVcxyuoZby8VmnPkuYz20B8THIrYZRUCFa0WnX8AzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480076; c=relaxed/simple;
	bh=id0daXtFOzbrelYtwicjbB38DtPm66zoZR+OFqNlhLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO/npOqjvd9/iQHnOwij7GtY3jrrCk2p9eOKU9ipCXFdC9JWp+lXRGUQpXGBSPP0LfyGQ/H7uXIgnjydAIbznsRpfHObYDlnj/3PIrvuWBVRdArP18KnmfslU9DGDFgjBYKry+dQEdUQTSZPRAZhtrUgAL8XIswEID2uINvWN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOz/nLYu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728480075; x=1760016075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=id0daXtFOzbrelYtwicjbB38DtPm66zoZR+OFqNlhLY=;
  b=SOz/nLYuPVtDKz3C1ianfm/jgpR88TjMThdpWI7oZhJjIHZPtDt9q7cg
   +RsKCViKhRJCtb/cip0IUrDAaACFIY2Y3TjoBMf67COoHfFZ/TUY10iwA
   4TPc/Fl8vDURDIJ553yjsZP771KCTdnmu53NP68JnqQm0ZzIzdY+SQkAR
   XzgAEC8rjJd9ubrfdN6rsGFrxulO4+DFwGOkRwHuFtWXpbF7jO326yFHB
   YQZsXCOvqNpHAq8mISa0aLnf+c/EtV0OQNFknrVVgCiBCKCWB/kWPxw2k
   wEqhfoEN6hUcsoEdgHJ5gZpdX0abRhIVl2H0cz+Yt7HxHtl/6y1cq2wvi
   A==;
X-CSE-ConnectionGUID: nzCzdMzXSqagM2swKn5Gxg==
X-CSE-MsgGUID: w4MlxcJ8S1uOg8geUA4o3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45246568"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45246568"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:21:14 -0700
X-CSE-ConnectionGUID: N651c8blRcCjdYDnrpfqYQ==
X-CSE-MsgGUID: 0YREzMx2RYCssUEeog/gMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76472441"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:21:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1syWcm-000000018Pi-1Da7;
	Wed, 09 Oct 2024 16:21:08 +0300
Date: Wed, 9 Oct 2024 16:21:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <ZwaDRJBs82oFMbZ8@smile.fi.intel.com>
References: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 01:44:17PM +0200, Przemek Kitszel wrote:
> Change scoped_guard() to make reasoning about it easier for static
> analysis tools (smatch, compiler diagnostics), especially to enable them
> to tell if the given scoped_guard() is conditional (interruptible-locks,
> try-locks) or not (like simple mutex_lock()).
> 
> Add compile-time error if scoped_cond_guard() is used for non-conditional
> lock class.
> 
> Beyond easier tooling and a little shrink reported by bloat-o-meter:
> add/remove: 3/2 grow/shrink: 45/55 up/down: 1573/-2069 (-496)
> this patch enables developer to write code like:
> 
> int foo(struct my_drv *adapter)
> {
> 	scoped_guard(spinlock, &adapter->some_spinlock)
> 		return adapter->spinlock_protected_var;
> }
> 
> Current scoped_guard() implementation does not support that,
> due to compiler complaining:
> error: control reaches end of non-void function [-Werror=return-type]
> 
> Technical stuff about the change:
> scoped_guard() macro uses common idiom of using "for" statement to declare
> a scoped variable. Unfortunately, current logic is too hard for compiler
> diagnostics to be sure that there is exactly one loop step; fix that.
> 
> To make any loop so trivial that there is no above warning, it must not
> depend on any non-const variable to tell if there are more steps. There is
> no obvious solution for that in C, but one could use the compound
> statement expression with "goto" jumping past the "loop", effectively
> leaving only the subscope part of the loop semantics.
> 
> More impl details:
> one more level of macro indirection is now needed to avoid duplicating
> label names;
> I didn't spot any other place that is using the
> "for (...; goto label) if (0) label: break;" idiom, so it's not packed
> for reuse, what makes actual macros code cleaner.
> 
> There was also a need to introduce const true/false variable per lock
> class, it is used to aid compiler diagnostics reasoning about "exactly
> 1 step" loops (note that converting that to function would undo the whole
> benefit).
> 
> Big thanks to Andy Shevchenko for help on this patch, both internal and
> public, ranging from whitespace/formatting, through commit message
> clarifications, general improvements, ending with presenting alternative
> approaches - all despite not even liking the idea.
> 
> Big thanks to Dmitry Torokhov for the idea of compile-time check for
> scoped_cond_guard(), and general improvements for the patch.

...

> @@ -149,14 +149,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *      similar to scoped_guard(), except it does fail when the lock
>   *      acquire fails.
>   *
> + *	Only for conditional locks.

> + *

Slipped redundant blank line.

>   */

...

> +/* helper for the scoped_guard() macro

 /*
  * This is wrong style of the comment block, it's not network
  * related code where it's acceptable. Also, respect English,
  * i.e. capitalisation and punctuation in the sentences.
  */

> + *
> + * Note that the "!__is_cond_ptr(_name)" part of the condition ensures
> + * that compiler would be sure that for unconditional locks the body of
> + * the loop could not be skipped; it is needed because the other
> + * part - "__guard_ptr(_name)(&scope)" - is too hard to deduce (even if
> + * could be proven true for unconditional locks).
> + */

-- 
With Best Regards,
Andy Shevchenko



