Return-Path: <netdev+bounces-130922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F998C13B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A41285F61
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCC1CC150;
	Tue,  1 Oct 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgbV3GjL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BA1C9DF0;
	Tue,  1 Oct 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795349; cv=none; b=OOmdzPNHD5FyJIEKtrqFmVxjyntVx7+nQKUhBDSnYzZhaKyiqgsUIIPATTweCe7hgXfzqNTmVWXspEyNvV8GKXsqr7UMcOa7UutQNl9fBtBD2/NfeOQk3vk4MTj0HZc30b22F8dukPIz1tq4fgcy+VbHfUQFI5wP4Ox/XjL5rTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795349; c=relaxed/simple;
	bh=WFhSHfj2PdvHK+iw67+koqnCzBkC9pytuO+x87o3Pqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYpxh0ag/hRvL01QdmpdLiyBqnZ1rUsF3j1thsk4zyQEuvK/R0qpI6zU6Gnuty7SHQpCKUz7/gbPmQ/yw9L4l3azplVHhHQ3SBir1NSc+5mloYJVl+gMpd9wiZ4lBxjG//+e+bhi7B8lBGPKO7jMdQ3Sxf7etpzE1zBUULacPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgbV3GjL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727795348; x=1759331348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFhSHfj2PdvHK+iw67+koqnCzBkC9pytuO+x87o3Pqc=;
  b=mgbV3GjLhTzOEMa9Jlxu0pbRHC3DRlSwdLpWYdJEUdaiflnTjEnNM+0X
   vfGZd+HX6U3xvZ+9QU0b28W/Mwwya506qyyJ/hpSy2/18iS3kSoKA82uv
   52akj4Yg2Zm9VwSBmvej6+1N/fYegUREkKeSmpZNuH9XbHkzOhYzBSYEC
   QBzZjftsBKX5cU4gaS5C0Wm7bZUm63XpHKvqRQ1SqDV5yfCoq6PYWP5Dg
   +HfNeC4fa2MpJta9Gb0I+Opae9P9/mkqCuP/t0Za+ZnqSQRq6jJ3WerkW
   r4uWQVZhFgUIsSSmnd32K7VW2ZevdSxcS+V/+ScESGbdmkBQqqUsvnBLL
   A==;
X-CSE-ConnectionGUID: bHt0rpTVThy+8ttvdSeVJg==
X-CSE-MsgGUID: 8Kf2eYpfQWGST7II7V5MpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49459162"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="49459162"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:09:07 -0700
X-CSE-ConnectionGUID: KgRafcuOS+mPG2MS8WEYCw==
X-CSE-MsgGUID: U0vunsTBQ+i78v6pnVPx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74015392"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:09:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1sveUn-0000000FEty-1HDT;
	Tue, 01 Oct 2024 18:09:01 +0300
Date: Tue, 1 Oct 2024 18:09:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFC PATCH v2] Simply enable one to write code like:
Message-ID: <ZvwQjMwdDVviQL2P@smile.fi.intel.com>
References: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 01, 2024 at 04:57:18PM +0200, Przemek Kitszel wrote:

...

> NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

And still NAKed.

> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Andy believes that this change is completely wrong C, the reasons
> (that I disagree with of course, are in v1, below the commit message).

Have you retested the macro expansion for this version?

...

>   */
>  
> +

Too many blank lines.

> +#define DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> +static __maybe_unused const bool class_##_name##_is_conditional = _is_cond

...

> +	DEFINE_CLASS_IS_CONDITIONAL(_name, 0); \

Here and everywhere else, boolean has values true and false.

-- 
With Best Regards,
Andy Shevchenko



