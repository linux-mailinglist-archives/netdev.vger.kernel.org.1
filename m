Return-Path: <netdev+bounces-184727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46325A97086
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C59168F04
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35828F92D;
	Tue, 22 Apr 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUKAPbeV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23328936D;
	Tue, 22 Apr 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335367; cv=none; b=NJxsTcXTvbWJvHBBBraCtGJxYZeAWDyC2ogtg7exr4j4xomRxP7pxn840jlW0s3iES7JMoiuGT6yAFfwjrBm8vXWgA21r7ijl0cAB/bJFP4FgOpCYcv4vkT4LrCvWn7g00bOrz7qbgHMHYbAha4zshDoZv3VS9C9Zk+yc0BXs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335367; c=relaxed/simple;
	bh=D3haV5NBdLifarUSGD9OaJjieXNkf4E0uuG46CLCXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeNsKEMFvmKZNy+HbNUpF1yjYLHCrfcl3UnJrdAfdyELvqyk4yH6Yw1Dogk9OyUT8KAyZoitOAXURu5qwEVNmAwNnChw7eZ6RyLEpvVeKbzk1217696VtpcNA2TVuw0wsoy2IQlEm403KCuQQVp2khICCMC4Cpbt1eCpeJRM7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUKAPbeV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745335366; x=1776871366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3haV5NBdLifarUSGD9OaJjieXNkf4E0uuG46CLCXYk=;
  b=ZUKAPbeVn0OQAEmADHiIU1neYydVcO+RgN9PxeZ9ldvM9Q/h3Qu5T9NL
   SXihsaYou3wqLD1wq93QlCt8bQRhKmuvKi8pczA/GVz1hsxNCXXrAsOF8
   4RKl/AjZk+CpqBMHXVSPgu0mPTasIjqmY29BuRgOOrRJ7jlvkyz5l3Qpw
   emi41Knt64BhTQV/Mt5fahLZLZp3L96c0V7b2Wnln6lbUnbr43I2saVXn
   PRTcItSYT7W+WmXDjtzUAsp20kT4rapcoKeQRW8D/K0JQxUgofrAwPwPa
   7RdmFDwLHydz4fW0Bg3p9/Vkhonom8NY/WGW+0ShjhIXSicTpanRZYy1L
   A==;
X-CSE-ConnectionGUID: XdrpksPOQgGolISPC8/1Ng==
X-CSE-MsgGUID: rX1S2cH4Tz+J28xioCvUKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64430397"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="64430397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:22:45 -0700
X-CSE-ConnectionGUID: Ot0pmeBpRVyqVU4jCjCR2A==
X-CSE-MsgGUID: 1oTGdjgCQQqOTvp8lcwjWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132590029"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:22:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u7FSF-0000000ElPn-0z2h;
	Tue, 22 Apr 2025 18:22:35 +0300
Date: Tue, 22 Apr 2025 18:22:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Hector Martin <marcan@marcan.st>, alyssa@rosenzweig.io,
	Petr Mladek <pmladek@suse.com>, Sven Peter <sven@svenpeter.dev>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Maxime Ripard <mripard@kernel.org>, airlied@redhat.com,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	Kees Cook <kees@kernel.org>, tamird@gmail.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	Asahi Linux Mailing List <asahi@lists.linux.dev>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <aAe0O50RmUw3k0o9@smile.fi.intel.com>
References: <PN3PR01MB9597382EFDE3452410A866AEB8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B01823415CB7FCD3BC27B8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com>
 <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
 <aAdsbgx53ZbdvB6p@smile.fi.intel.com>
 <CAMuHMdXuM5wBoAeJXK+rTp5Ok8U87NguVGm+dng5WOWaP3O54w@mail.gmail.com>
 <PN3PR01MB9597D8AE22D48C7A5D351ABBB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597D8AE22D48C7A5D351ABBB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 08:45:31PM +0530, Aditya Garg wrote:
> On 22-04-2025 04:02 pm, Geert Uytterhoeven wrote:
> > On Tue, 22 Apr 2025 at 12:16, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > I am not against h/n in se, but I am against bad/confusing naming.
> > The big question is: should it print
> >   (A) the value in network byte order, or
> >   (B) the reverse of host byte order?
> > 
> > If the answer is (A), I see no real reason to have %p4n, as %p4b prints
> > the exact same thing.  Moreover, it leaves us without a portable
> > way to print values in reverse without the caller doing an explicit
> > __swab32() (which is not compatible with the %p pass-by-pointer
> > calling convention).
> > 
> > If the answer is (B), "%p4n using network byte order" is bad/confusing
> > naming.
> 
> The answer is definitely (B). As far as bad/confusing naming is concerned,
> I'll let vsprintf maintainers decide. As far as usage is concerned, %p4cl
> is used in appletbdrm and %p4ch is used in to be upstreamed soon smc driver
> by Asahi Linux.

Can it use %p4cb? Or in another word,
why does it require "host" representation?

-- 
With Best Regards,
Andy Shevchenko



