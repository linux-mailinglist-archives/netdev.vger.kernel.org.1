Return-Path: <netdev+bounces-236710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD8C3F305
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0223E3B1573
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8243016EB;
	Fri,  7 Nov 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxMjRvx0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBC2F531F;
	Fri,  7 Nov 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508146; cv=none; b=Z63wB1yPncfTLluLEAZmaf2oGpWGHi+D2GMXsDHNMY8JdNf9M3x+SeMfKBuQ8phH1F+LMb4U2oaWnOsDdF5SohJ2xz7gnsiLY9R2tU0JhIHPaAAUfPo87nFEv0O6tfIhbJ6XA199B7/+50fTMDWf5nxbbrFD5bnPTOmFVZJBGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508146; c=relaxed/simple;
	bh=D6+yKptFABPYFPYxyWtBQ5zOKqzK3MNINc2rvH2D/n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouYfM0aLKoWTbSJE6+hSt262Ea/5TfJ+Uc+rJHSpRNkl9rt8ZQAQfqHQba8YbdP1zqvcl2eEnPJAtR2zwX5c9n127sZUW52kpPAJDwin+FThq2+yu4wprQG001J+EA589XNPoxBJ3sEk3E6AtZtXw9Ta3zAX9zVzZRP/Mlwrf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxMjRvx0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762508144; x=1794044144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6+yKptFABPYFPYxyWtBQ5zOKqzK3MNINc2rvH2D/n0=;
  b=JxMjRvx0Z+62vaxS1jc3+6bFKL+ouYPJOMCbMZIrRUncwhvCIFa9YLDx
   Sdpu8OiL8T1r9KagxVtmBE6qnrvpqX1BzDlhI13u5U49HIdjzS1LmFvoa
   ZarjVfrDc9uLfviLAm7sGqGWMJ7ull8OOWHrfXAQSXyI0yPO7Hk1z/pI+
   c/OOT38xQYtwYmmaoK7J/plXyfKC3nilN0rxUoGI3xU8z9Cut0NMAtZ5B
   go+kl7TXUlrN3UY2t74h/rd75tmg8zdMRSnWAathtNKMC90Y5tQxZTTkl
   4IJAo5lrPx/NxUJjYW0Kom71HmU9OlLsEMETXPYiJ/Cu45nfQpP1J6zgr
   Q==;
X-CSE-ConnectionGUID: 8UPIavC3Sg+ZfOGTe7XIxw==
X-CSE-MsgGUID: 1MYkzOWESGy0mOFbzYk9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562382"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562382"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:35:43 -0800
X-CSE-ConnectionGUID: LsAWghEFRpKKLxOW5gSDpQ==
X-CSE-MsgGUID: ipmj13SgRROyYswd7KgaXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192360859"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:35:39 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vHIsZ-00000006Q6y-30Zg;
	Fri, 07 Nov 2025 11:35:35 +0200
Date: Fri, 7 Nov 2025 11:35:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
	tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
	mchehab@kernel.org, awalls@md.metrocast.net,
	linux-media@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aQ29Zzajef81E2DZ@smile.fi.intel.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107091246.4e5900f4@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:
> On Thu, 6 Nov 2025 21:38:33 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:

...

> That is true for all the snprintf() functions.
> 
> > I wonder if we should instead implement a kasprintf() version of this
> > which reallocs each time and then switch all the callers over to that.
> 
> That adds the cost of a malloc, and I, like kasprintf() probably ends up
> doing all the work of snprintf twice.
> 
> I'd be tempted to avoid the strlen() by passing in the offset.
> So (say):
> #define scnprintf_at(buf, len, off, ...) \
> 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)
> 
> Then you can chain calls, eg:
> 	off = scnprintf(buf, sizeof buf, ....);
> 	off += scnprintf_at(buf, sizeof buf, off, ....);

I like this suggestion. Also note, that the original implementation works directly
on static buffers.

-- 
With Best Regards,
Andy Shevchenko



