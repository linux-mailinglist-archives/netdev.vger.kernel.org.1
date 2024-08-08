Return-Path: <netdev+bounces-116888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3194BFB6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CC81F21EC3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6718E77B;
	Thu,  8 Aug 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbuwJnV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6D18E760
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127688; cv=none; b=kCamSCmaVGHjK95ZfQCwzPnjXKavNCoj0JEOOcVSoSv03SHT1s07N+J1e5e8hc9g62V+w8gaddOjpT8rOXWLE5lJVuakt9xoZI0GSvTT6Y7Aa1WVj/LLXjlTziTqDzJrLl5hAP62qWKMvlI2oUTRBvdV0RWF1J4KF8MP49kbmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127688; c=relaxed/simple;
	bh=eGELJ4GrmhKEtcLVoZJ3mNO0W+davUHM2Vs3B3NWg3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twjUEs/SfJfQ7LzBPcIpgSGJzgZcjZuwrzoJWbgYaoan4/yC8jBNpZEcKe22AkjOMtr3kLZltyhhrlTT31C3+qoCaDgcJ/cSLzjfKwYQHa1FDK6TltYk6RNjoLa5HdKcS8OPdx2/PxryGh9s5FRFhQ3729cmRLT6/RJ9nBAFCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbuwJnV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04811C4AF0C;
	Thu,  8 Aug 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723127688;
	bh=eGELJ4GrmhKEtcLVoZJ3mNO0W+davUHM2Vs3B3NWg3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbuwJnV8JAyPZlErRb64t/npDjNm5FKIaPMSOwg1zdNa7x33aqXe0ksR4A/V5+WqN
	 P3pxdWqcmbkyhVNaL6xS/82OUqgacf3qePKO7o30m0Z0pTJqQy7ipfJVu++/b1fb76
	 xMzNVfn+M3HjH0Vg6stIZofW6dQfS4tiyUGJ0smkfaE/wDIoavvVSj6fv4L6LFxgqK
	 QguuxfeCKU2KFWk8ZxgxHBLZlgPvGEEe6LVAnsQrFXh9LzH0Al/le00hiIEvr0XHuo
	 J2+y+Hmpfz4n74UIqrGBwDNKHCGFEzE0V92xwTv6Fr7faQxzC3Lk1VQVU3LVLkvXeY
	 D8YgTrniSeXYA==
Date: Thu, 8 Aug 2024 15:34:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240808143443.GI3006561@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org>
 <20240805142253.GG2636630@kernel.org>
 <20240805123655.50588fa7@kernel.org>
 <20240806152158.GZ2636630@kernel.org>
 <20240808122042.GA3067851@kernel.org>
 <20240808071754.72be6896@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808071754.72be6896@kernel.org>

On Thu, Aug 08, 2024 at 07:17:54AM -0700, Jakub Kicinski wrote:
> On Thu, 8 Aug 2024 13:20:42 +0100 Simon Horman wrote:
> > Thanks again for the information.
> > 
> > I have now taken another look at this problem.
> > 
> > Firstly, my analysis is that the cause of the problem is a combination of
> > the way the patchset is constricted, and the way that the build tests (I
> > have focussed on build_allmodconfig_warn.sh [1]).
> > 
> > [1] https://github.com/linux-netdev/nipa/blob/main/tests/patch/build_allmodconfig_warn/build_allmodconfig.sh
> > 
> > What I believe happens is this: The patches 01/12 - 07/12 modify some
> > header files, adds a new Kconfig entry, and does a bunch of other normal
> > stuff. Each of those patches is tested in turn, and everything seems fine.
> > 
> > Then we get to patch 08/12. The key thing about this patch is that it
> > enables the CONFIG_NET_SHAPER Kconfig option, in the context of an
> > allmodconfig build. That in turn modifies the headers
> > include/linux/netdevice.h and net/core/dev.h (and net/Makefile). Not in the
> > in terms of their on-disk contents changing, but rather in the case of the
> > header files, in terms of preprocessor output. And this is, I believe,
> > where everything goes wrong.
> 
> That's strange, make does not understand preprocessor, does it?
> Either file has been modified or it has not.

True, that is a good point.
I would say there is something deeper going on than
I have been able to discover at this time: probably something very obvious.

> I guess it doesn't matter, given your solution  

Right, in any case I think the script needs to be enhanced.
My solution may prove heavy handed, but it can be improved over time.

> > NIPA arrives at running build_allmodconfig_warn.sh for patch 08/12 with the tree
> > built for the previous patch, 07/12. It then:
> > 
> > * touches $output_dir/include/generated/utsrelease.h
> > * checks out HEAD~ (patch 07/12)
> > * prepares the kernel config
> > * builds kernel and records incumbent errors (49)
> > 
> > The thing to note here is that the tree has been little perturbed since build
> > tests were run for patch 07/12, and thus few files are rebuilt.
> > 
> > Moving on, simplifying things, the following then runs:
> > 
> > * touches $output_dir/include/generated/utsrelease.h
> > * checks out $HEAD (patch 08/12)
> > * prepares the kernel config
> > * builds kernel and records current errors (4219)
> > 
> > The key to understanding why the large delta between 49 and 4219 is
> > that vastly more files have been rebuilt. Because the preprocessor output
> > of netdevice.h and dev.h have changes since the last build, and those
> > headers are included, directly or indirectly, by a lot of files (and
> > compilation results in warnings for many of those files).
> > 
> > 
> > I was able to reproduce the result by running build_allmodconfig_warn.sh
> > over patch 07/12 and then 07/12 with FIRST_IN_SERIES=0.

Correction: this should have read "07/12 and then 08/12"

> > I was able to get the desired result no new compiler warnings
> > by doing the same again, but with FIRST_IN_SERIES=1 for the
> > invocation of build_allmodconfig_warn.sh for 08/12.
> > 
> > I believe this is entirely due to a baseline rebuild being run due to the
> > FIRST_IN_SERIES=1 parameter. And, FWIIW, I believe the invocation of
> > build_allmodconfig_warn.sh for 07/12 ensures reproducibility.
> > 
> > My suggestion is that while we may consider reorganising the patch-set,
> > that is really only a work around. And it would be best to make the CI more
> > robust in the presence of such constructions.
> > 
> > It may be a bit heavy handed, but my tested solution is to invoke a
> > baseline rebuild if a Kconfig change is made. At the very last it does
> > address the problem at hand. (In precisely the same way as manually setting
> > FIRST_IN_SERIES=1.)
> > 
> > The patch implementing this for build_allmodconfig.sh which I tested is
> > below. If we want to go ahead with this approach then I expect it is best
> > to add it to other build tests too. But this seems to be a good point
> > to report my findings, so here we are.
> > 
> > --- build_allmodconfig.sh.orig  2024-08-08 07:30:56.599372164 +0000
> > +++ build_allmodconfig.sh       2024-08-08 09:58:22.692206313 +0000
> > @@ -34,8 +34,10 @@
> >  echo "Tree base:"
> >  git log -1 --pretty='%h ("%s")' HEAD~
> > 
> > -if [ x$FIRST_IN_SERIES == x0 ]; then
> > -    echo "Skip baseline build, not the first patch"
> > +if [ x$FIRST_IN_SERIES == x0 ] && \
> > +   ! git diff --name-only HEAD~ | grep -q -E "Kconfig$"
> > +then
> > +    echo "Skip baseline build, not the first patch and no Kconfig updates"
> >  else
> >      echo "Baseline building the tree"
> 
> Excellent idea, let's try it! Could you send a PR to NIPA?

Yes, can do.

> Note that the code is copied 3 times for each flavor of building :(

I assumed so :)

