Return-Path: <netdev+bounces-184605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FAA965A1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC731888462
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549F1F4608;
	Tue, 22 Apr 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJmtq8bG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06DF510;
	Tue, 22 Apr 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316987; cv=none; b=q2XAkkTSvKg3RxoBWrSqoVcbZztP/fgGtJQa+MCySmnFes1KIFI7rsXpJrxCyJwj0HA8p7o9uFhgqewWA+0Elh7SmWVBT/Jy61RyyYF8TDF4o4wrnyBWgOdU3uX5PMXBs/rr8si6hnzg8y/rRcf6C+6ocWISejli454ALKcxY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316987; c=relaxed/simple;
	bh=wWjKBX2zeekrjYxCeQgtVm5V/GoHtzZQlT8JVvJNDWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pINYpaGxRCybjPRASnierEmuA539BLEP1o46+a4bjErG6gGeVN7iES2A4x1csWaUbbm3BJ029dJK/n7603ABy9JELTCB/RUf6NVR+kkdwFdF9WFtmBtbuWzGsGTIAA7+NCKUGcOLrAIvHt9/UkA8SZznxkP2M3fdb8MK84CQQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJmtq8bG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745316986; x=1776852986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWjKBX2zeekrjYxCeQgtVm5V/GoHtzZQlT8JVvJNDWk=;
  b=PJmtq8bGCja3G5VPd96LQFIi1PAaj5jo6fd+DVKjchWYEBeSNLpE7lc3
   z5ME8ba/PWvTg6ijdAJ4ojZfASnPU55VsvwTEnI6zpmmgm0k6tUjVUTP1
   hFhRCbr+mPtRbMAVIqaIBmtaKjMiv9bf4VS1ITpMPX+bh/edk3mdBaYqE
   UfWAaxU3JEu/ZAUJgWslZacj4kQ+ksLNvhqz+SYsND6RNVTm+QkbfX9RG
   yZS6oPgd4OvhTVvLraHZ4QRhKUA8eXWZ+/GQ2T7XUkcE6TIQtZexOJ41G
   fX86OB6KRKsZPUk6Ie3tuYjZYdOjw2u81z9DfonABeVcrEwuBxzzhqOaw
   Q==;
X-CSE-ConnectionGUID: hm8sOjwMQpCcczQqFgITYg==
X-CSE-MsgGUID: 0oc2Us8NR2CYrP5W/mN0cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58244146"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="58244146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:16:25 -0700
X-CSE-ConnectionGUID: wGdjKXAeT1SkyB2PVG1zzA==
X-CSE-MsgGUID: 97t2Opq9TX+hchHBw8+i/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="132513185"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:16:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u7Afm-0000000EhIi-3puL;
	Tue, 22 Apr 2025 13:16:14 +0300
Date: Tue, 22 Apr 2025 13:16:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>,
	alyssa@rosenzweig.io, Petr Mladek <pmladek@suse.com>,
	Sven Peter <sven@svenpeter.dev>,
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
Message-ID: <aAdsbgx53ZbdvB6p@smile.fi.intel.com>
References: <PN3PR01MB9597382EFDE3452410A866AEB8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B01823415CB7FCD3BC27B8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com>
 <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 10:43:59AM +0200, Geert Uytterhoeven wrote:
> On Tue, 22 Apr 2025 at 10:30, Aditya Garg <gargaditya08@live.com> wrote:
> > On 22-04-2025 01:37 pm, Geert Uytterhoeven wrote:
> > > On Tue, 8 Apr 2025 at 08:48, Aditya Garg <gargaditya08@live.com> wrote:

...

> > Originally, it was %p4cr (reverse-endian), but on the request of the
> > maintainers, it was changed to %p4cn.
> 
> Ah, I found it[1]:
> 
> | so, it needs more information that this mimics htonl() / ntohl() for
> networking.
> 
> IMHO this does not mimic htonl(), as htonl() is a no-op on big-endian.
> while %p4ch and %p4cl yield different results on big-endian.
> 
> > So here network means reverse of host, not strictly big-endian.
> 
> Please don't call it "network byte order" if that does not have the same
> meaning as in the network subsystem.
> 
> Personally, I like "%p4r" (reverse) more...
> (and "%p4ch" might mean human-readable ;-)

It will confuse the reader. h/r is not very established pair. If you really
wont see h/n, better to drop them completely for now then. Because I'm against
h/r pair.

> [1] https://lore.kernel.org/all/Z8B6DwcRbV-8D8GB@smile.fi.intel.com


-- 
With Best Regards,
Andy Shevchenko



