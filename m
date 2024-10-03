Return-Path: <netdev+bounces-131598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8A98EF9C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186741C2158D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CB18893D;
	Thu,  3 Oct 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBxbKPJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370911E49B;
	Thu,  3 Oct 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959591; cv=none; b=GkSj3uw4QE//4ugZs4GCaI/piDU+AZ1/3/h0e0+4PHL4+eP4d3v6KxqYvWtwYMARR7Rh2ukRJpNTtw2Z3qWPJHrEfyCrPIzAfMpMg7JPZF25CyxbgFmuMT1FOnFzKgFdDxwsJNVnMTYAnImZiYZm4UddqogS9dZP45Rfk/hGHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959591; c=relaxed/simple;
	bh=FCV3IeDTV6gf3uGDIiuETN3zimQNAk+sQx8KxxDNovg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPadu1oljq6d7C6xky7PxsUyVQWwz7osGdS9qMBKg+iRCXJ19mcY3+oWO/VH2NoZbVUUE+m6P8KM0ZRJxlDTWK2yKzs7V7eJ5igEghACv3i4Ojq1tpjEZlJRX9nyFuMrnHEahOhSVYk3fswWy6PIdm63EJhAPTvQ8ekP4cWnkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBxbKPJ7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727959590; x=1759495590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCV3IeDTV6gf3uGDIiuETN3zimQNAk+sQx8KxxDNovg=;
  b=HBxbKPJ73ih9aAVI1zKK7LuoSifVURqpuZjW+e+DLEU0DF1v+QlAAGHE
   N4tXU9s9qVlU6yfsyskjhO1XqMeezNHovQmwR4em7OzSRk/MTgET8B7/L
   34V3jfTyaxyrGAU+cXXEOpygB1rGU3pOPOY3z6V6yVcTA2MC3M7RF3iau
   6qDS+DC0g1TkQGarL7klZmyujeIs8Po8+sfIrhpw2inFGWQL6ILIuMigP
   NrMahT+S6kC3xoHChJxwKlMP4h9sdydX4QPy/J1hmWbG6J8dba1+sTLLG
   Hq7OoaSmta1xipk2v7kulUu7pdVNImAvIrBDXDU54sWl3IUo6w5IwmuOW
   g==;
X-CSE-ConnectionGUID: /wYETjjPQJOJ4SrYKjMR/Q==
X-CSE-MsgGUID: XAWyHo/HTQGDC1acNtXH/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44677191"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44677191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:46:29 -0700
X-CSE-ConnectionGUID: nbcewy6ISOKS4/JA6MFAVA==
X-CSE-MsgGUID: FLeNWZibQ1CKuoLrpvH91g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105105877"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:46:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swLDs-0000000G95T-1PuI;
	Thu, 03 Oct 2024 15:46:24 +0300
Date: Thu, 3 Oct 2024 15:46:24 +0300
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
Message-ID: <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 03:43:17PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:

...

> > +#define __scoped_guard_labeled(_label, _name, args...)			\
> > +	for (CLASS(_name, scope)(args);					\
> > +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> > +		     ({ goto _label; }))				\
> > +		if (0)							\
> > +		_label:							\
> > +			break;						\
> > +		else
> 
> I believe the following will folow more the style we use in the kernel:
> 
> #define __scoped_guard_labeled(_label, _name, args...)			\
> 	for (CLASS(_name, scope)(args);					\
> 	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> 		     ({ goto _label; }))				\
> 		if (0) {						\
> _label:									\
> 			break;						\
> 		} else
> 
> ...
> 
> > -	     *done = NULL; !done; done = (void *)1) \
> > +	     *done = NULL; !done; done = (void *)1 +  	\
> 
> You have TABs/spaces mix in this line now.

And FWIW:
1) still NAKed;
2) interestingly you haven't mentioned that meanwhile I also helped you to
improve this version of the patch. Is it because I NAKed it?

-- 
With Best Regards,
Andy Shevchenko



