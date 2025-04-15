Return-Path: <netdev+bounces-182598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448CA89467
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E417AED7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027127511C;
	Tue, 15 Apr 2025 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjuL2bnE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E1E5B70;
	Tue, 15 Apr 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700635; cv=none; b=AuBMLwlHGVEqvjBzPWz6v9lgPdep4gVaEwJQfK8zMPqyDprxOlGvEkcOWdSv2qXH7AtKFZ2qEp0nEFAfjz8BrhomO7CgjhOzAFbSv7glTLCHWeVhmnlc80qnQbaanFbEJ9ykkbc91X+iYiYkiItdtr625aznUJ5s9uTOKLfKTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700635; c=relaxed/simple;
	bh=ISHme36ClXIZls+3gW0ZDvgDcWa18XrAFOfHqyp+34c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afVj7nMKqCmNPnROwqdbxEynNGwAbciNKpWsRD/fJk1rglj7yS6TmT/Ubx/09J9TbF1e2pEd1IzK4yvsbXOsnHzAS0/mnW439hpit2b9WGrMIC8nJcBvqTvySoIf0RgfqClhQUCO6elygTWheptvi/UALUB91glIkgCv6uCAbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjuL2bnE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744700634; x=1776236634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISHme36ClXIZls+3gW0ZDvgDcWa18XrAFOfHqyp+34c=;
  b=KjuL2bnEV6ve+0IjYnUVAgRoQUpX9oe3AIm9C+Pirg2NMwfH8QxYWIlg
   wl0TCF6/mLaMYFag8aPf0gAHW1l9Kp96kaIL8YJeyUvqUz/0mK5Di8tIX
   gFlE7/Vddp3VwSM5K6K/Kz5zSMYMT22XzQvrzHKEQDFVjtlJiWQ9KYc3S
   6PTIPFxd6BfqE6snrqFg6maHK0iz2e0L0k9lx+twibGUESM+0Ddl2UC8+
   o84ptihqYmeHegI89a66ywoe0l1moq25U8W1xXxwg/GZXr895ZheITqEx
   bqB4/DZIJF66DTgOo7/OKCtwiROL+6Bmj/owRCcwJkvjfiOxeZcsJ0qoZ
   A==;
X-CSE-ConnectionGUID: /jKFhcu1R9qBNiNGO3ytUg==
X-CSE-MsgGUID: Kk7EVFatSaCFRATopBUcTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56854783"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="56854783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:03:53 -0700
X-CSE-ConnectionGUID: zwdmO1Y1QXGDlEV2QT4Sjw==
X-CSE-MsgGUID: MiXPFpmxRKu7CnxoYAq6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="161002059"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:03:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4aKi-0000000CTBW-0UUp;
	Tue, 15 Apr 2025 10:03:48 +0300
Date: Tue, 15 Apr 2025 10:03:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:
> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > >> 
> > >> > This changeset contains the kernel-doc.py script to replace the verable
> > >> > kernel-doc originally written in Perl. It replaces the first version and the
> > >> > second series I sent on the top of it.
> > >> 
> > >> OK, I've applied it, looked at the (minimal) changes in output, and
> > >> concluded that it's good - all this stuff is now in docs-next.  Many
> > >> thanks for doing this!
> > >> 
> > >> I'm going to hold off on other documentation patches for a day or two
> > >> just in case anything turns up.  But it looks awfully good.
> > >
> > > This started well, until it becomes a scripts/lib/kdoc.
> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > > "disgusting turd" )as said by Linus) in the clean tree.
> > >
> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.
> > 
> > If nothing else, "make cleandocs" should clean it up, certainly.
> > 
> > We can also tell CPython to not create that directory at all.  I'll run
> > some tests to see what the effect is on the documentation build times;
> > I'm guessing it will not be huge...
> 
> I do not build documentation at all, it's just a regular code build that leaves
> tree dirty.
> 
> $ python3 --version
> Python 3.13.2
> 
> It's standard Debian testing distribution, no customisation in the code.
> 
> To reproduce.
> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> 2) The following snippet in shell shows the issue
> 
> $ git clean -xdf
> $ git status --ignored
> On branch ...
> nothing to commit, working tree clean
> 
> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> make[1]: Entering directory '...'
>   GEN     Makefile
>   DESCEND objtool
>   CALL    .../scripts/checksyscalls.sh
>   INSTALL libsubcmd_headers
> .pylintrc: warning: ignored by one of the .gitignore files
> Kernel: arch/x86/boot/bzImage is ready  (#23)
> make[1]: Leaving directory '...'
> 
> $ touch drivers/gpio/gpiolib-acpi.c
> 
> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> make[1]: Entering directory '...'
>   GEN     Makefile
>   DESCEND objtool
>   CALL    .../scripts/checksyscalls.sh
>   INSTALL libsubcmd_headers
> ...
>   OBJCOPY arch/x86/boot/setup.bin
>   BUILD   arch/x86/boot/bzImage
> Kernel: arch/x86/boot/bzImage is ready  (#24)
> make[1]: Leaving directory '...'
> 
> $ git status --ignored
> On branch ...
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	scripts/lib/kdoc/__pycache__/
> 
> nothing added to commit but untracked files present (use "git add" to track)

FWIW, I repeated this with removing the O=.../out folder completely, so it's
fully clean build. Still the same issue.

And it appears at the very beginning of the build. You don't need to wait to
have the kernel to be built actually.

> It's 100% reproducible on my side. I am happy to test any patches to fix this.
> It's really annoying "feature" for `make O=...` builds. Also note that
> theoretically the Git worktree may be located on read-only storage / media
> and this can induce subtle issues.

-- 
With Best Regards,
Andy Shevchenko



