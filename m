Return-Path: <netdev+bounces-182620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C39A895A2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D75B7A71E3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834312741D9;
	Tue, 15 Apr 2025 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exI9TlEL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBD194C86;
	Tue, 15 Apr 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703447; cv=none; b=kfIB8VW5ZunMcQdXw8lkP7/LQB1XA9u/8WTZwnTSXrudhvXTlc2MsRmuQ7xbe95YAT74Z/yIUqNuD3kNC+mo0rEbGwnLEJmB1I802Syfxs7ftfiHrLvPbAKRnt3BYdYfDvWyA6l3lr6X9vFPoX5lhLhqcDc2oXPkVCzaz9JPQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703447; c=relaxed/simple;
	bh=qC/0FXLpOvgrDoBUcYckTUw8tEHEKThRr/hZUIioUQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLVriRAhq1Mh70+rtrvcqBl4Kt2gtCpTGhIRyiKqOERiHDIVpJXFrpQUXZHBngtcSnj6gKj0m0pUu1ya6IXWtb/u4ulc+OiBV3Ff5WL+W/7cnfPX0Vn+VPaNg+eER95z1jM8v+DDW5J/kM4zyBRrtUnfbxn/2Gb3Dgaql6637+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exI9TlEL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744703445; x=1776239445;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qC/0FXLpOvgrDoBUcYckTUw8tEHEKThRr/hZUIioUQo=;
  b=exI9TlELx6s/q0eLIsBv5uVr3cgUt+CS9COZU2ZllhO9wxbhCUjhCpDH
   ONPRdo8LQ7bhLRKasn2X2cDGAuwsDjaZcOm/H5sbVYyQWnjkMVwKqrRqW
   lGDh6LF7YNNT1QA+bNJA/jxiM6dY//YlY5yQZWf7uXBmAIUtrgUJZ2KJM
   nyRwrwicg+zaGqXkI4u6f6mTyfKp+M/zcbMM/BcUP7Du4SWfcgTfLnsTu
   3N4A/zH+QITqEpCC/LJxBFw1aEjDYYFAkUGzJB+Es8KCrgJDjTRRk+Bop
   eO9xiooL7+Al67ySyH99j0Xo5p4LY+2T663Eoq6t1Fw+ZpIxMi37fLdyW
   w==;
X-CSE-ConnectionGUID: qVRgBJCqTVWEF0XLioWV2w==
X-CSE-MsgGUID: iYF0jDjMQCqwM9qd0WsXIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46329978"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46329978"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:49:36 -0700
X-CSE-ConnectionGUID: rQ4ZqfbXTIuwZv8Nk1Ab8Q==
X-CSE-MsgGUID: ecXfQhzOSzu0xo52qs9ShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129809381"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:49:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell
 King <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net> <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net> <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
Date: Tue, 15 Apr 2025 10:49:29 +0300
Message-ID: <87v7r5sw3a.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:
>> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:
>> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
>> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
>> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> > >> 
>> > >> > This changeset contains the kernel-doc.py script to replace the verable
>> > >> > kernel-doc originally written in Perl. It replaces the first version and the
>> > >> > second series I sent on the top of it.
>> > >> 
>> > >> OK, I've applied it, looked at the (minimal) changes in output, and
>> > >> concluded that it's good - all this stuff is now in docs-next.  Many
>> > >> thanks for doing this!
>> > >> 
>> > >> I'm going to hold off on other documentation patches for a day or two
>> > >> just in case anything turns up.  But it looks awfully good.
>> > >
>> > > This started well, until it becomes a scripts/lib/kdoc.
>> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
>> > > "disgusting turd" )as said by Linus) in the clean tree.
>> > >
>> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.
>> > 
>> > If nothing else, "make cleandocs" should clean it up, certainly.
>> > 
>> > We can also tell CPython to not create that directory at all.  I'll run
>> > some tests to see what the effect is on the documentation build times;
>> > I'm guessing it will not be huge...
>> 
>> I do not build documentation at all, it's just a regular code build that leaves
>> tree dirty.
>> 
>> $ python3 --version
>> Python 3.13.2
>> 
>> It's standard Debian testing distribution, no customisation in the code.
>> 
>> To reproduce.
>> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
>> 2) The following snippet in shell shows the issue
>> 
>> $ git clean -xdf
>> $ git status --ignored
>> On branch ...
>> nothing to commit, working tree clean
>> 
>> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
>> make[1]: Entering directory '...'
>>   GEN     Makefile
>>   DESCEND objtool
>>   CALL    .../scripts/checksyscalls.sh
>>   INSTALL libsubcmd_headers
>> .pylintrc: warning: ignored by one of the .gitignore files
>> Kernel: arch/x86/boot/bzImage is ready  (#23)
>> make[1]: Leaving directory '...'
>> 
>> $ touch drivers/gpio/gpiolib-acpi.c
>> 
>> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
>> make[1]: Entering directory '...'
>>   GEN     Makefile
>>   DESCEND objtool
>>   CALL    .../scripts/checksyscalls.sh
>>   INSTALL libsubcmd_headers
>> ...
>>   OBJCOPY arch/x86/boot/setup.bin
>>   BUILD   arch/x86/boot/bzImage
>> Kernel: arch/x86/boot/bzImage is ready  (#24)
>> make[1]: Leaving directory '...'
>> 
>> $ git status --ignored
>> On branch ...
>> Untracked files:
>>   (use "git add <file>..." to include in what will be committed)
>> 	scripts/lib/kdoc/__pycache__/
>> 
>> nothing added to commit but untracked files present (use "git add" to track)
>
> FWIW, I repeated this with removing the O=.../out folder completely, so it's
> fully clean build. Still the same issue.
>
> And it appears at the very beginning of the build. You don't need to wait to
> have the kernel to be built actually.

kernel-doc gets run on source files for W=1 builds. See Makefile.build.

BR,
Jani.


>
>> It's 100% reproducible on my side. I am happy to test any patches to fix this.
>> It's really annoying "feature" for `make O=...` builds. Also note that
>> theoretically the Git worktree may be located on read-only storage / media
>> and this can induce subtle issues.

-- 
Jani Nikula, Intel

