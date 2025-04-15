Return-Path: <netdev+bounces-182668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA1A89972
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5711895E22
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63A2797A9;
	Tue, 15 Apr 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nel4OjhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193528A1CE;
	Tue, 15 Apr 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711609; cv=none; b=H1kDQ+Ja1dLVgdKmCBIV39qNCvQgBBWezNUQJZ/tn77U1TdlArPwbLsi1NdIDUDXeRSExdYRucgQngsCzlFPOQ9HEnGj5oJyhhYXSXxglAYtso9aPokIg0mReY3qNM4FHos8ufEVf3oVGTmBm3LPsQ+M4wtchpLxL44O2fFxDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711609; c=relaxed/simple;
	bh=AcYgonVLWePGiHAxSjHPdf3Rwctz0JHoJhO6Z55gyjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhN8o75mITgz8M56Zr0xVFnSNzCatZ9QinNttGFcQk8SDrtWfqdSVCpzOEPTa4f/AJHvEclbJ5wFiEufcwlpV7jMlg0NOPYNOa6aVi1k5YLg63PPg7mn+Pf6ngo6J8I53O8veIMwBbEUUsIcL/FZRtofIT+w/9goGwDRTdv8S48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nel4OjhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BABCC4CEEC;
	Tue, 15 Apr 2025 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744711608;
	bh=AcYgonVLWePGiHAxSjHPdf3Rwctz0JHoJhO6Z55gyjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nel4OjhKJ2V4eB0k235iwkT92Zff0JgyX2u+r1qGYzh+fAUOiclUFq29lVhtp9URX
	 fdU8Sa5Ok8eyVRgvBIsk3tou351fS0cApWKH0+TfXKn8wvwxwVvDg2Rwg1J2GpE3I7
	 bjaQChu6WDmIRmzBypMQdkAtLhWP832riIS18pkd+7B/I8R78GRkdTKAndfKGO1evA
	 Sr/0vT8vDNu2njW4KLvuyrKjFfwShkMpXmVSd6quxTREjeAHG6ch6UrQEbnjeBnXDr
	 AmBisEVtdEISTBC/0+d3JIxhyLrrYBVOSiZOhOEckG8WtCTePuXoPJqVLqAeAfZmiI
	 WiwWBD8qRmqjA==
Date: Tue, 15 Apr 2025 18:06:31 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <20250415180631.180e9a9f@sal.lan>
In-Reply-To: <Z_4sxCFvpqs7qmcN@smile.fi.intel.com>
References: <871pu1193r.fsf@trenco.lwn.net>
	<Z_zYXAJcTD-c3xTe@black.fi.intel.com>
	<87mscibwm8.fsf@trenco.lwn.net>
	<Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
	<Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
	<87v7r5sw3a.fsf@intel.com>
	<Z_4WCDkAhfwF6WND@smile.fi.intel.com>
	<Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
	<20250415164014.575c0892@sal.lan>
	<Z_4sKaag1wZhME7B@smile.fi.intel.com>
	<Z_4sxCFvpqs7qmcN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 15 Apr 2025 12:54:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:

> On Tue, Apr 15, 2025 at 12:51:38PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 15, 2025 at 04:40:34PM +0800, Mauro Carvalho Chehab wrote:  
> > > Em Tue, 15 Apr 2025 11:19:26 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:  
> > > > On Tue, Apr 15, 2025 at 11:17:12AM +0300, Andy Shevchenko wrote:  
> > > > > On Tue, Apr 15, 2025 at 10:49:29AM +0300, Jani Nikula wrote:    
> > > > > > On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > > > > On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:    
> > > > > > >> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:    
> > > > > > >> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:    
> > > > > > >> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:    
> > > > > > >> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > > > > > >> > >>     
> > > > > > >> > >> > This changeset contains the kernel-doc.py script to replace the verable
> > > > > > >> > >> > kernel-doc originally written in Perl. It replaces the first version and the
> > > > > > >> > >> > second series I sent on the top of it.    
> > > > > > >> > >> 
> > > > > > >> > >> OK, I've applied it, looked at the (minimal) changes in output, and
> > > > > > >> > >> concluded that it's good - all this stuff is now in docs-next.  Many
> > > > > > >> > >> thanks for doing this!
> > > > > > >> > >> 
> > > > > > >> > >> I'm going to hold off on other documentation patches for a day or two
> > > > > > >> > >> just in case anything turns up.  But it looks awfully good.    
> > > > > > >> > >
> > > > > > >> > > This started well, until it becomes a scripts/lib/kdoc.
> > > > > > >> > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > > > > > >> > > "disgusting turd" )as said by Linus) in the clean tree.
> > > > > > >> > >
> > > > > > >> > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.    
> > > > > > >> > 
> > > > > > >> > If nothing else, "make cleandocs" should clean it up, certainly.
> > > > > > >> > 
> > > > > > >> > We can also tell CPython to not create that directory at all.  I'll run
> > > > > > >> > some tests to see what the effect is on the documentation build times;
> > > > > > >> > I'm guessing it will not be huge...    
> > > > > > >> 
> > > > > > >> I do not build documentation at all, it's just a regular code build that leaves
> > > > > > >> tree dirty.
> > > > > > >> 
> > > > > > >> $ python3 --version
> > > > > > >> Python 3.13.2
> > > > > > >> 
> > > > > > >> It's standard Debian testing distribution, no customisation in the code.
> > > > > > >> 
> > > > > > >> To reproduce.
> > > > > > >> 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> > > > > > >> 2) The following snippet in shell shows the issue
> > > > > > >> 
> > > > > > >> $ git clean -xdf
> > > > > > >> $ git status --ignored
> > > > > > >> On branch ...
> > > > > > >> nothing to commit, working tree clean
> > > > > > >> 
> > > > > > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > > > > > >> make[1]: Entering directory '...'
> > > > > > >>   GEN     Makefile
> > > > > > >>   DESCEND objtool
> > > > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > > > >>   INSTALL libsubcmd_headers
> > > > > > >> .pylintrc: warning: ignored by one of the .gitignore files
> > > > > > >> Kernel: arch/x86/boot/bzImage is ready  (#23)
> > > > > > >> make[1]: Leaving directory '...'
> > > > > > >> 
> > > > > > >> $ touch drivers/gpio/gpiolib-acpi.c
> > > > > > >> 
> > > > > > >> $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > > > > > >> make[1]: Entering directory '...'
> > > > > > >>   GEN     Makefile
> > > > > > >>   DESCEND objtool
> > > > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > > > >>   INSTALL libsubcmd_headers
> > > > > > >> ...
> > > > > > >>   OBJCOPY arch/x86/boot/setup.bin
> > > > > > >>   BUILD   arch/x86/boot/bzImage
> > > > > > >> Kernel: arch/x86/boot/bzImage is ready  (#24)
> > > > > > >> make[1]: Leaving directory '...'
> > > > > > >> 
> > > > > > >> $ git status --ignored
> > > > > > >> On branch ...
> > > > > > >> Untracked files:
> > > > > > >>   (use "git add <file>..." to include in what will be committed)
> > > > > > >> 	scripts/lib/kdoc/__pycache__/
> > > > > > >> 
> > > > > > >> nothing added to commit but untracked files present (use "git add" to track)    
> > > > > > >
> > > > > > > FWIW, I repeated this with removing the O=.../out folder completely, so it's
> > > > > > > fully clean build. Still the same issue.
> > > > > > >
> > > > > > > And it appears at the very beginning of the build. You don't need to wait to
> > > > > > > have the kernel to be built actually.    
> > > > > > 
> > > > > > kernel-doc gets run on source files for W=1 builds. See Makefile.build.    
> > > > > 
> > > > > Thanks for the clarification, so we know that it runs and we know that it has
> > > > > an issue.    
> > > > 
> > > > Ideal solution what would I expect is that the cache folder should respect
> > > > the given O=... argument, or disabled at all (but I don't think the latter
> > > > is what we want as it may slow down the build).  
> > > 
> > > From:
> > > 	https://github.com/python/cpython/commit/b193fa996a746111252156f11fb14c12fd6267e6
> > > and:
> > > 	https://peps.python.org/pep-3147/
> > > 
> > > It sounds that Python 3.8 and above have a way to specify the cache
> > > location, via PYTHONPYCACHEPREFIX env var, and via "-X pycache_prefix=path".
> > > 
> > > As the current minimal Python version is 3.9, we can safely use it.
> > > 
> > > So, maybe this would work:
> > > 
> > > 	make O="../out" PYTHONPYCACHEPREFIX="../out"
> > > 
> > > or a variant of it:
> > > 
> > > 	PYTHONPYCACHEPREFIX="../out" make O="../out" 
> > > 
> > > If this works, we can adjust the building system to fill PYTHONPYCACHEPREFIX
> > > env var when O= is used.  
> > 
> > It works,

Good!

> > the problem is that it should be automatically assigned to the
> > respective folder, so when compiling kdoc, it should be actually
> > 
> > $O/scripts/lib/kdoc/__pycache__
> > 
> > and so on for _each_ of the python code.  

Yeah, agreed. We need to think on a more generic solution though,
as we also may have scripts/lib/abi/__pycache__ if one runs
get_abi.pl, and, in the future, we may have more. Not sure how
hard/easy would be to do that, though.

> So, the bottom line, can we just disable it for a quick fix and when a proper
> solution comes, it will redo that?

Agreed, this sounds to be the best approach.

I'll try to craft a patch along the week to add
PYTHONDONTWRITEBYTECODE=1 to the places where kernel-doc
is called.

Regards,
Mauro


