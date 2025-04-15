Return-Path: <netdev+bounces-182597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA721A8945D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13FF17BEC4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E32417C2;
	Tue, 15 Apr 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM18OPyt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CD2DFA34;
	Tue, 15 Apr 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700473; cv=none; b=byB5AGN24aa+PO1VFDc9pWKfepFzr9xj743ZNcomygD0hGv/CPM1Kl2UE41+V0LWE/nf8EpRUMbGMffsdmwj8UDo/+rB9rjK1dROWuP32dFMSeWO0xXTsP5IKtgDGKEyvNxOLE8paOoahh15ZpDzFh6XZKtDHGajdZc0F+jQhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700473; c=relaxed/simple;
	bh=tP1nLNEOryZ2Rfki3LWUs8Eu0CqMBbLY8xZy7cXBm1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkf/lOSOyTBFmzjXZmz+U7xBq44JTFS37ib3JvAewk26CyZSDlUOfR3iAoM9WLvecfJCVNUOGjWWQulgzdVpOvi93tzJ/ZzyTklKRqHC7gVj9qq6Afx4gan7C6PfBWZSozwcxrcoKiqn+s2u2rfOhhkV/vup9OanmHlgE7QTE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM18OPyt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744700471; x=1776236471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP1nLNEOryZ2Rfki3LWUs8Eu0CqMBbLY8xZy7cXBm1M=;
  b=KM18OPytoj12OMm8L7QAJ8kgYc8yLznReoS8MSs+G5sRmABv8xGrNTSk
   KJnColaZQvQ5VUj4SuWFzyuNmu/8OX2FE/FD5JBrbJ7ILU/lGexHninDr
   +AVoLVy/tbCmYA3Kgx6jdLNAccOZBZwtEgGwn3wmX0+c5KjPLDq2XCJ6I
   o3A4zlRPK5+SVzEPxCCKIPkAZgGD7Jc+zxadfPWqBe0fV3o6auRJE+TQH
   WS41PuXsSL9b/6/81StljZxqy+it8t/o+ZPnRdpa/1y+1GPB+jwWu5bFs
   096jdz7qkGwpjLuXzpG/uaibaWHwPTxQOPxOApHFhJ2lQZQXxnCKwLKMm
   A==;
X-CSE-ConnectionGUID: L8W0ygYzRlGp1Gf/wHN25A==
X-CSE-MsgGUID: JIRDwf/oRBunTN4nGlb4lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="49845957"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="49845957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:01:10 -0700
X-CSE-ConnectionGUID: pMPcLX8ESJ22RSF9di3EvQ==
X-CSE-MsgGUID: MoBCwUo+Tl+cMeqTJnpNSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129999895"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:01:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4aI4-0000000CT86-0em2;
	Tue, 15 Apr 2025 10:01:04 +0300
Date: Tue, 15 Apr 2025 10:01:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mscibwm8.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >> 
> >> > This changeset contains the kernel-doc.py script to replace the verable
> >> > kernel-doc originally written in Perl. It replaces the first version and the
> >> > second series I sent on the top of it.
> >> 
> >> OK, I've applied it, looked at the (minimal) changes in output, and
> >> concluded that it's good - all this stuff is now in docs-next.  Many
> >> thanks for doing this!
> >> 
> >> I'm going to hold off on other documentation patches for a day or two
> >> just in case anything turns up.  But it looks awfully good.
> >
> > This started well, until it becomes a scripts/lib/kdoc.
> > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > "disgusting turd" )as said by Linus) in the clean tree.
> >
> > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.
> 
> If nothing else, "make cleandocs" should clean it up, certainly.
> 
> We can also tell CPython to not create that directory at all.  I'll run
> some tests to see what the effect is on the documentation build times;
> I'm guessing it will not be huge...

I do not build documentation at all, it's just a regular code build that leaves
tree dirty.

$ python3 --version
Python 3.13.2

It's standard Debian testing distribution, no customisation in the code.

To reproduce.
1) I have just done a new build to reduce the churn, so, running make again does nothing;
2) The following snippet in shell shows the issue

$ git clean -xdf
$ git status --ignored
On branch ...
nothing to commit, working tree clean

$ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
make[1]: Entering directory '...'
  GEN     Makefile
  DESCEND objtool
  CALL    .../scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
.pylintrc: warning: ignored by one of the .gitignore files
Kernel: arch/x86/boot/bzImage is ready  (#23)
make[1]: Leaving directory '...'

$ touch drivers/gpio/gpiolib-acpi.c

$ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
make[1]: Entering directory '...'
  GEN     Makefile
  DESCEND objtool
  CALL    .../scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
...
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#24)
make[1]: Leaving directory '...'

$ git status --ignored
On branch ...
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	scripts/lib/kdoc/__pycache__/

nothing added to commit but untracked files present (use "git add" to track)

It's 100% reproducible on my side. I am happy to test any patches to fix this.
It's really annoying "feature" for `make O=...` builds. Also note that
theoretically the Git worktree may be located on read-only storage / media
and this can induce subtle issues.

-- 
With Best Regards,
Andy Shevchenko



