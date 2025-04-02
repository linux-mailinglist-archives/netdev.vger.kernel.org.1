Return-Path: <netdev+bounces-178759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC10A78C6E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036C57A5042
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8E20D519;
	Wed,  2 Apr 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNR0e/if"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7511953A1;
	Wed,  2 Apr 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589997; cv=none; b=I1u0xVROqYphdZCMOfd0tO/0gqGJi6pKVyCim6JKqnwK+YS/UfahWnryK2MTaEtd0OZt4+b3ow2hZ0Kd7DNy7DUdkKJlBtNdvr1xBVG+Bf8Wo1gg9FvlYeZ86rOjmeQMsw6ZY4aeXcHcYcu0pn9QvXjEFCL0oRTuqVV3wxMxj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589997; c=relaxed/simple;
	bh=uzgVRHkC0/6oVwMh4YG7sDY5ZqY1Wc1ZMefrtNkrfxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRpKoe3nHwP2V3+327UX466dxRyfir+pR30k/WC4qWgeR9/1+y7wA8pr68A5Nd6TRnZ60L1klF5YvjX84nGagZT0XrjcsUbQxy7w2JNHG79/N+tG+BLuFdRbe2sFRkS+AnXtGAHX3dsaRikM9a5uNg0JT8sedubmOmn8dAYkj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNR0e/if; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743589997; x=1775125997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzgVRHkC0/6oVwMh4YG7sDY5ZqY1Wc1ZMefrtNkrfxw=;
  b=ZNR0e/ifFoCRm1YcC0C88pk/IH+Dcn6W0RkU9/gTTAMazpwH9jGK/Y13
   wg6swhSoOW0cgtHgTKG/QcIIjBFpD2EWpoN020W1DrKMh1ghAWMeT+Wjb
   MMYK+CZta4aywY8/Fbizu8kDhAeryyaD4GxWzkOfWpew43RL7t5FxkYFo
   B0sTQGMTfx+1hEBvbJQCZmxKZK9D7JgoifMQAFb0MM/JHzPMxizko/dON
   bxwSa9KsmscELSLPtmSEBm4ie5PS706Fl+rmYBANnFDYdzWlPnRi6d8+m
   RzQcQRHDDIegGuPeh63sROJwWsIaCuEzhuR52dpPlKBlvVvp6K+l/YnWD
   w==;
X-CSE-ConnectionGUID: PN7LF4jiRB+P/HYH9m1x0g==
X-CSE-MsgGUID: FvGcDMdmQp+UOCz8CnonVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="62346681"
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="62346681"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:32:58 -0700
X-CSE-ConnectionGUID: jnKqawtdRCC7ytoiJ+6FvA==
X-CSE-MsgGUID: 9Y43AS5zQbiCJvtQWGGu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="126417413"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:32:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzvOu-00000008RE3-0xzR;
	Wed, 02 Apr 2025 13:32:52 +0300
Date: Wed, 2 Apr 2025 13:32:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, peterz@infradead.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> Add auto_kfree macro that acts as a higher level wrapper for manual
> __free(kfree) invocation, and sets the pointer to NULL - to have both
> well defined behavior also for the case code would lack other assignement.
> 
> Consider the following code:
> int my_foo(int arg)
> {
> 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> 
> 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> 	/* ... */
> }
> 
> So far it is fine and even optimal in terms of not assigning when
> not needed. But it is typical to don't touch (and sadly to don't
> think about) code that is not related to the change, so let's consider
> an extension to the above, namely an "early return" style to check
> arg prior to allocation:
> int my_foo(int arg)
> {
>         struct my_dev_foo *foo __free(kfree); /* no assignement */
> +
> +	if (!arg)
> +		return -EINVAL;
>         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
>         /* ... */
> }
> Now we have uninitialized foo passed to kfree, what likely will crash.
> One could argue that `= NULL` should be added to this patch, but it is
> easy to forgot, especially when the foo declaration is outside of the
> default git context.
> 
> With new auto_kfree, we simply will start with
> 	struct my_dev_foo *foo auto_kfree;
> and be safe against future extensions.
> 
> I believe this will open up way for broader adoption of Scope Based
> Resource Management, say in networking.
> I also believe that my proposed name is special enough that it will
> be easy to know/spot that the assignement is hidden.


I understand the issue and the problem it solves, but...

> +#define auto_kfree __free(kfree) = NULL

...I do not like this syntax at all (note, you forgot to show the result
in the code how it will look like).

What would be better in my opinion is to have it something like DEFINE_*()
type, which will look more naturally in the current kernel codebase
(as we have tons of DEFINE_FOO().

	DEFINE_AUTO_KFREE_VAR(name, struct foo);

with equivalent to

	struct foo *name __free(kfree) = NULL

-- 
With Best Regards,
Andy Shevchenko



