Return-Path: <netdev+bounces-182630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F9A896B7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DF188E5E5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A127C879;
	Tue, 15 Apr 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVcWO21J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A927B4F1;
	Tue, 15 Apr 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705832; cv=none; b=ZoscL6cLS4GzqWUQN0IXULyZzGHyAam5FdN2nTOKYHUZlCRzpvSfFrf0y3I04gxx7N1crYewEkxLDW8DeYyu4SG7slj0QBeiw5wDNAfkxijd5qeCmZFI5vQwdU720fBOXDQb8YhYwXyVxtqAwkJnalPCUTi5LHdLiTgIqjBw3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705832; c=relaxed/simple;
	bh=luRNjjq9Ky4e8OeXI2+K5Ns2S6QljlO+7NwvSgkcH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFpo0C60L+hw4oG0Ao1dTkz2j97Hht83qMWGZShj19f4jGQ/0VSxDnB/9+8pxOaaD5bbOI0yNzhK2TrkvQSRNdfjv8+nAgt+sUSWO3bB8YYiNCAQ6GCMEkHL5TgaH3jd7/nHhzNcKcj2T4FvnbuUV4BrR3rEoGZH0Iudn+zFvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVcWO21J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A338C4CEE9;
	Tue, 15 Apr 2025 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744705832;
	bh=luRNjjq9Ky4e8OeXI2+K5Ns2S6QljlO+7NwvSgkcH2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVcWO21JVPPefr1i5FyIc6PzdVdqZdH6GIbZbhao8j8PQlehZnUahYbQRNEuO4bFY
	 dznACuhUAN/mM3iZL9puDzlFp5h3CfcAfoh1i5ns8E77Mpgz7gz+7m8jAaG9WRf1nC
	 4V4oo0xhNg6LhKvwr6mFAaWL/UcsIKC5vl0p1eCELBZd6q4zS1d6cF0i04ab9I0IrX
	 J7zV+Ee44iy7sFP69DgGUt7Jzp1nkpNN8zHj07tAr95U4w+BpizcJAc2J8GiqR6e4b
	 WOs9sklRJ58erHqPiZxo6vyFqv+u4vuZm9769RIVdyU7bddJQS0f2ZUcVyoAPbar36
	 9SlIEmVBLWW+g==
Date: Tue, 15 Apr 2025 16:30:16 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <20250415163016.39bcc220@sal.lan>
In-Reply-To: <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
	<871pu1193r.fsf@trenco.lwn.net>
	<Z_zYXAJcTD-c3xTe@black.fi.intel.com>
	<87mscibwm8.fsf@trenco.lwn.net>
	<Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
	<Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 15 Apr 2025 10:03:47 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:

> On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:  
> > > Andy Shevchenko <andriy.shevchenko@intel.com> writes:  
> > > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:  
> > > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > > >>   
> > > >> > This changeset contains the kernel-doc.py script to replace the verable
> > > >> > kernel-doc originally written in Perl. It replaces the first version and the
> > > >> > second series I sent on the top of it.  
> > > >> 
> > > >> OK, I've applied it, looked at the (minimal) changes in output, and
> > > >> concluded that it's good - all this stuff is now in docs-next.  Many
> > > >> thanks for doing this!
> > > >> 
> > > >> I'm going to hold off on other documentation patches for a day or two
> > > >> just in case anything turns up.  But it looks awfully good.  
> > > >
> > > > This started well, until it becomes a scripts/lib/kdoc.
> > > > So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> > > > "disgusting turd" )as said by Linus) in the clean tree.
> > > >
> > > > *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.  
> > > 
> > > If nothing else, "make cleandocs" should clean it up, certainly.

Not sure about that, as __pycache__ is completely managed by Python: it
will not only create it for scripts/lib, but also for all Python libraries,
including the Sphinx ones.

IMO, it makes more sense, instead, to ensure that __pycache__ won't be
created at the sourcedir if O= is used, but ignore it if this is created.

Btw, the same problem should already happen with get_abi.py, as it also
uses "import" from scripts/lib. So, we need a more generic solution. See
below.

> > > 
> > > We can also tell CPython to not create that directory at all.  I'll run
> > > some tests to see what the effect is on the documentation build times;
> > > I'm guessing it will not be huge...  

I doubt it would have much impact for kernel-doc, but it can have some impact
for Sphinx, as disabling Python JIT to store bytecode would affect it too.

-

Andy, 

Could you please remove __pycache__ and set this env:

	PYTHONDONTWRITEBYTECODE=1

before building the Kernel? If this works, one alternative would be to 
set it when O= is used.

> > I do not build documentation at all, it's just a regular code build that leaves
> > tree dirty.
> > 
> > $ python3 --version
> > Python 3.13.2
> > 
> > It's standard Debian testing distribution, no customisation in the code.
> > 
> > To reproduce.
> > 1) I have just done a new build to reduce the churn, so, running make again does nothing;
> > 2) The following snippet in shell shows the issue
> > 
> > $ git clean -xdf
> > $ git status --ignored
> > On branch ...
> > nothing to commit, working tree clean
> > 
> > $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > make[1]: Entering directory '...'
> >   GEN     Makefile
> >   DESCEND objtool
> >   CALL    .../scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> > .pylintrc: warning: ignored by one of the .gitignore files
> > Kernel: arch/x86/boot/bzImage is ready  (#23)
> > make[1]: Leaving directory '...'
> > 
> > $ touch drivers/gpio/gpiolib-acpi.c
> > 
> > $ make LLVM=-19 O=.../out W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> > make[1]: Entering directory '...'
> >   GEN     Makefile
> >   DESCEND objtool
> >   CALL    .../scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> > ...
> >   OBJCOPY arch/x86/boot/setup.bin
> >   BUILD   arch/x86/boot/bzImage
> > Kernel: arch/x86/boot/bzImage is ready  (#24)
> > make[1]: Leaving directory '...'
> > 
> > $ git status --ignored
> > On branch ...
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> > 	scripts/lib/kdoc/__pycache__/
> > 
> > nothing added to commit but untracked files present (use "git add" to track)  
> 
> FWIW, I repeated this with removing the O=.../out folder completely, so it's
> fully clean build. Still the same issue.
> 
> And it appears at the very beginning of the build. You don't need to wait to
> have the kernel to be built actually.

Depending on your .config, kernel-doc will be called even without building
documentation to check for some problems at kernel-doc tags.

> 
> > It's 100% reproducible on my side. I am happy to test any patches to fix this.
> > It's really annoying "feature" for `make O=...` builds. Also note that
> > theoretically the Git worktree may be located on read-only storage / media
> > and this can induce subtle issues.  

Python's JIT compiler automatically creates __pycache__ whenever it
encounters an "import" and the *.pyc is older than the script (or doesn't
exist). This happens with external libraries, and also with the internal
ones, like the ones we now have at the Kernel.

I dunno what happens if the FS is read-only. I would expect that the JIT
compiler would just work as if bytecode creation is disabled.

That's said, I never played myself with __pycache__.

Yet, I have some raw ideas about how to deal with that. This requires
more tests, though. I can see some possible solutions for that:

1. Assuming that PYTHONDONTWRITEBYTECODE=1 works, the build system could
   set it if O= is used. This would have some performance impact for both
   Kernel compilation (because kernel-doc is called to check doc issues),
   and for Kernel compilation itself. I dunno how much it would impact,
   but this is probably the quickest solution to implement;

2. when O=<targetdir> is used, copy scripts/lib/*/*.py to the target
   directory and change kernel-doc.py to use <targetdir> for library search
   on such case. This way, the __pycache__ would be created at the 
   <targetdir>. This might work as well with symlinks. The performance
   impact here would be minimal, but it will require an extra step for
   O= to copy data (or to create symlinks);

3. eventually there is a way to teach Python to place the __pycache__
   at <targetdir>, instead of <sourcedir>. If supported, this would
   be the cleanest solution.

Regards,
Mauro

