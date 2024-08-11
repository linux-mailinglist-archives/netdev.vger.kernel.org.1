Return-Path: <netdev+bounces-117475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C794E13F
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0499C1C20970
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A64E1C8;
	Sun, 11 Aug 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEDyNt4B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875322626
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380058; cv=none; b=uoF2dztfKcPL+jI8kIfs9mIRGwnHgH4Xf6d85iicBur5eZAOpT4cwss0ApqLJXUoFXf9uBRfWfgn8lH9VG3xtZn5Jgf4ToKE5rqTIHY6gHte3Sc7/G9ZSs6ADdAeTmTVh4Ww2mR6hSdKPwvCdwuupVcnp2+Kt0wvR4TYfcw8W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380058; c=relaxed/simple;
	bh=wvq4i2bN9NIEMLQPvBYduxp/8pXdw9FsYlZfKXNeN08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwHgPqIicgnXk46i0mj88UqY9ZLlOfhwR+d/URZyX7HCHWWTb/TxN/EQeYcP1pXXotf1jYYxmGGwsSALlH/RKjGIwtBbC78DzqUJpJrJsEEPuhA2GKY7WhZelpqCS1qqzYweSeKFuESsRn/9Jget4Var+n1rXXVze3Oiwif/grU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEDyNt4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FCAC32786;
	Sun, 11 Aug 2024 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723380057;
	bh=wvq4i2bN9NIEMLQPvBYduxp/8pXdw9FsYlZfKXNeN08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEDyNt4B4Qm7QIVhNEvojpO4BnESMM93/xAwjFSCmrfn9Kfn4VNDGMdixB4hjE74w
	 IhseDByOaInxO8BXF4Z0H7rI7tkrLoGfbhzSCVyO2UH74z8xK2FZFTTXJXCmTJOBjV
	 bfpXbkIkRhZgUMksf9zyl1aqoCELNWH5vccXb+35kzQ5zIn2v5RVVdLMlpNW7eNlFp
	 yzUXlqmjHZHPpE5bEKN7bTfxAXxvRls/UF5W3OyExMHpxRHEVxW0sl+EHa9mSAMaC3
	 uo+rQy5ahj2xlFcvc616hmgIrwpELQdGE35asAN+l/bTsu4cFHYXir4R1pSuYw7Ja3
	 Mx8LnZplrmA3w==
Date: Sun, 11 Aug 2024 13:40:53 +0100
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
Message-ID: <20240811124053.GI1951@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org>
 <20240805142253.GG2636630@kernel.org>
 <20240805123655.50588fa7@kernel.org>
 <20240806152158.GZ2636630@kernel.org>
 <20240808122042.GA3067851@kernel.org>
 <20240808071754.72be6896@kernel.org>
 <20240808143443.GI3006561@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808143443.GI3006561@kernel.org>

On Thu, Aug 08, 2024 at 03:34:43PM +0100, Simon Horman wrote:
> On Thu, Aug 08, 2024 at 07:17:54AM -0700, Jakub Kicinski wrote:
> > On Thu, 8 Aug 2024 13:20:42 +0100 Simon Horman wrote:

...

> > > It may be a bit heavy handed, but my tested solution is to invoke a
> > > baseline rebuild if a Kconfig change is made. At the very last it does
> > > address the problem at hand. (In precisely the same way as manually setting
> > > FIRST_IN_SERIES=1.)
> > > 
> > > The patch implementing this for build_allmodconfig.sh which I tested is
> > > below. If we want to go ahead with this approach then I expect it is best
> > > to add it to other build tests too. But this seems to be a good point
> > > to report my findings, so here we are.
> > > 
> > > --- build_allmodconfig.sh.orig  2024-08-08 07:30:56.599372164 +0000
> > > +++ build_allmodconfig.sh       2024-08-08 09:58:22.692206313 +0000
> > > @@ -34,8 +34,10 @@
> > >  echo "Tree base:"
> > >  git log -1 --pretty='%h ("%s")' HEAD~
> > > 
> > > -if [ x$FIRST_IN_SERIES == x0 ]; then
> > > -    echo "Skip baseline build, not the first patch"
> > > +if [ x$FIRST_IN_SERIES == x0 ] && \
> > > +   ! git diff --name-only HEAD~ | grep -q -E "Kconfig$"
> > > +then
> > > +    echo "Skip baseline build, not the first patch and no Kconfig updates"
> > >  else
> > >      echo "Baseline building the tree"
> > 
> > Excellent idea, let's try it! Could you send a PR to NIPA?
> 
> Yes, can do.

For reference, the PR is here:
https://github.com/linux-netdev/nipa/pull/35

