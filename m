Return-Path: <netdev+bounces-182626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD87A8964D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE34417855D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C1241CA2;
	Tue, 15 Apr 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvN71Rp2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7121ADCB;
	Tue, 15 Apr 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705109; cv=none; b=dvuC1Z1TS7P/6pIyT8zrHFcMit0zAmNudsCkj27sLNGez5/12R0n0y4T9K17aJws+1ZN0P3VwDv2mqO1ToNAQjYh1Mrya/J+aJhf+TiufFowrZtLoO7jSDYGiPMtq2WJAAviS2Gos/9UU2gckFUEGQm76OlUUrUVitYHzO5oIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705109; c=relaxed/simple;
	bh=g6D6sl641a9cuRCwXKKcjM7803pO8zwZMcpM3uNv6/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e477rAsYfzjmndifcI7dcgVs+1Ke2pPZZkgiynB/M5jhtKXBHHyKnr0PYUoFUhSSNT+pY5lySJaBDRlppNpiLQcyO0/5wxeFIeY6Kz9O+LWU0jzgnRSYt2miRkQR1J6l2UNCbwC9Y+mB9CINK5SgQsbalgGCqzSaQF/fyrcXoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvN71Rp2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705107; x=1776241107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6D6sl641a9cuRCwXKKcjM7803pO8zwZMcpM3uNv6/g=;
  b=WvN71Rp2K8BDZ4qpKrhvqBLF9+Nn4Z0wHNEUrvkaDN7sRSpA6n5/JHYK
   lqUBZG7GP/Sps15EB/Wdrd5mEscitc0DWUxW3V40HIHf+W0cfMXmJyefm
   m4SXYjtxvqYtwNmyhpTXnAdhaPGun0L0VN9Plrp6s31yqdwhQb+z20Nlu
   4jzqo+B7tImddoQtx0F3pEo1J9hYeCO+GK99Hbm/tkQ8iq+/W1SyiG1L7
   rgdzuOhJ+OvDydf9IpTfheT/NHuA2FysLN6s0bzre5KDuOlPNEPYWZO71
   uddiGAWSW9QAjANUSPWfXYG7q7S+E1nlbmkgTMJt9t3h312xRyyri2Z5F
   A==;
X-CSE-ConnectionGUID: vcZRsSJGSDSY7kDwMaBG3A==
X-CSE-MsgGUID: wQia35/ETrCzUt042KcHEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45434953"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45434953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:17:18 -0700
X-CSE-ConnectionGUID: v77BI4t/QliJthM1JAmUjw==
X-CSE-MsgGUID: SEpekbLOTkicFFElnexa6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130015687"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:17:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4bTk-0000000CUAC-2nI9;
	Tue, 15 Apr 2025 11:17:12 +0300
Date: Tue, 15 Apr 2025 11:17:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
 <87v7r5sw3a.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7r5sw3a.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 10:49:29AM +0300, Jani Nikula wrote:
> On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:
> >> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:
> >> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> >> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
> >> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >> > >> 
> >> > >> > This changeset contains the kernel-doc.py script to replace the verable
> >> > >> > kernel-doc originally written in Perl. It replaces the first version and the
> >> > >> > second series I sent on the top of it.
> >> > >> 
> >> > >> OK, I've applied it, looked at the (minimal) changes in output, and
> >> > >> concluded that it's good - all this stuff is now in docs-next.  Many
> >> > >> thanks for doing this!
> >> > >> 
> >> > >> I'm going to hold off on other documentation patches for a day or two
> >> > >> just in case anything turns up.  But it looks awfully good.
> >> > >
> >> > > This started well, until it becomes a scripts/lib/kdoc.
> >> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> >> > > "disgusting turd" )as said by Linus) in the clean tree.
> >> > >
> >> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.
> >> > 
> >> > If nothing else, "make cleandocs" should clean it up, certainly.
> >> > 
> >> > We can also tell CPython to not create that directory at all.  I'll run
> >> > some tests to see what the effect is on the documentation build times;
> >> > I'm guessing it will not be huge...
> >> 
> >> I do not build documentation at all, it's just a regular code build that leaves
> >> tree dirty.
> >> 
> >> $ python3 --version
> >> Python 3.13.2
> >> 
> >> It's standard Debian testing distribution, no customisation in the code.
> >> 
> >> To reproduce.
> >> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> >> 2) The following snippet in shell shows the issue
> >> 
> >> $ git clean -xdf
> >> $ git status --ignored
> >> On branch ...
> >> nothing to commit, working tree clean
> >> 
> >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> >> make[1]: Entering directory '...'
> >>   GEN     Makefile
> >>   DESCEND objtool
> >>   CALL    .../scripts/checksyscalls.sh
> >>   INSTALL libsubcmd_headers
> >> .pylintrc: warning: ignored by one of the .gitignore files
> >> Kernel: arch/x86/boot/bzImage is ready  (#23)
> >> make[1]: Leaving directory '...'
> >> 
> >> $ touch drivers/gpio/gpiolib-acpi.c
> >> 
> >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> >> make[1]: Entering directory '...'
> >>   GEN     Makefile
> >>   DESCEND objtool
> >>   CALL    .../scripts/checksyscalls.sh
> >>   INSTALL libsubcmd_headers
> >> ...
> >>   OBJCOPY arch/x86/boot/setup.bin
> >>   BUILD   arch/x86/boot/bzImage
> >> Kernel: arch/x86/boot/bzImage is ready  (#24)
> >> make[1]: Leaving directory '...'
> >> 
> >> $ git status --ignored
> >> On branch ...
> >> Untracked files:
> >>   (use "git add <file>..." to include in what will be committed)
> >> 	scripts/lib/kdoc/__pycache__/
> >> 
> >> nothing added to commit but untracked files present (use "git add" to track)
> >
> > FWIW, I repeated this with removing the O=.../out folder completely, so it's
> > fully clean build. Still the same issue.
> >
> > And it appears at the very beginning of the build. You don't need to wait to
> > have the kernel to be built actually.
> 
> kernel-doc gets run on source files for W=1 builds. See Makefile.build.

Thanks for the clarification, so we know that it runs and we know that it has
an issue.

> >> It's 100% reproducible on my side. I am happy to test any patches to fix this.
> >> It's really annoying "feature" for `make O=...` builds. Also note that
> >> theoretically the Git worktree may be located on read-only storage / media
> >> and this can induce subtle issues.

-- 
With Best Regards,
Andy Shevchenko



