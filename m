Return-Path: <netdev+bounces-132779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300D993219
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CDD1C2362E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F21DA0F1;
	Mon,  7 Oct 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKaIcxAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0C1D9340;
	Mon,  7 Oct 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316525; cv=none; b=T31jaBRZF1l2Ln2jTBrIp332RHs9JY9gKmCLnvEucdv/UupY6dQKYC6+OTe01USryohYCsgWiREz/3hQtgdnI79ShL0L+RsHLu2G/IrZROjjZZtffYk+/o2tEesFHt49BD5G/kkm07JACIYdKyAjcbrvm+dVggRpA0717AGC/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316525; c=relaxed/simple;
	bh=xUgQ12yWyVmh9UezQ+B9+CBgyoHn1hM31OEXrAfgu44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnJTZwThZirzQhe91ttF5KHNJp/lbHxJQ8KMWiozOao0eY4mppWUdVm+15tNTYWw5DDa68roVcyaFjjBSGnRH429J0o4VCl+9C6z9uSP3tNLHQHagu/pAQkfiebmn1qCLdZFY1CVdQhQkYlsfAuoqKElhdvUjMaA3G03ebGxFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKaIcxAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF13C4CEC6;
	Mon,  7 Oct 2024 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316524;
	bh=xUgQ12yWyVmh9UezQ+B9+CBgyoHn1hM31OEXrAfgu44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKaIcxAa0SNDiuN8sPVPp3hwCzROG0gdKoSKZo7LIq4d7t0JJoQau20VvyblvGWDQ
	 2i3H/lV/DYdkYT7FquT+4rzQtxu0I5fvCEDiYGjccq+BbTO5ccZmbz2uUOs3PXTfVj
	 +PPqudV5YQSWUV3YFCcBb1dZlBqEHgESIbL0n8sEU9hSVo0kaiJUfp86RxxrK8shji
	 DmercezjSMquFo/OGoFYJVcGA+G4y6m6iWGN4Uq5mFGa4cIifWQ0JlZoUd5I9aDisr
	 RO9j8cEDxWddr3RH29A6DaUy2QFbkHtwao6xhpKSldArh3/TrPuiLvsTt7ZP9e/Gvp
	 5Bhg0+2dnKxcQ==
Date: Mon, 7 Oct 2024 16:55:21 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241007155521.GI32733@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
 <20241007082430.21de3848@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007082430.21de3848@kernel.org>

On Mon, Oct 07, 2024 at 08:24:30AM -0700, Jakub Kicinski wrote:
> On Fri, 04 Oct 2024 10:49:53 +0100 Simon Horman wrote:
> > The purpose of this section is to document what is the current practice
> > regarding clean-up patches which address checkpatch warnings and similar
> > problems. I feel there is a value in having this documented so others
> > can easily refer to it.
> > 
> > Clearly this topic is subjective. And to some extent the current
> > practice discourages a wider range of patches than is described here.
> > But I feel it is best to start somewhere, with the most well established
> > part of the current practice.
> > 
> > --
> > I did think this was already documented. And perhaps it is.
> > But I was unable to find it after a quick search.
> 
> Thanks a lot for documenting it, this is great!
> All the suggestions below are optional, happy to merge as is.
> 
> > +Clean-Up Patches
> > +~~~~~~~~~~~~~~~~
> 
> nit: other sections use sentence-like capitalization (only capitalizing
> the first word), is that incorrect? Or should we ay "Clean-up patches"
> here?

I think we should be consistent here
(I'm intentionally avoiding answering what is correct :)

> 
> > +Netdev discourages patches which perform simple clean-ups, which are not in
> > +the context of other work. For example addressing ``checkpatch.pl``
> > +warnings, or :ref:`local variable ordering<rcs>` issues. This is because it
> > +is felt that the churn that such changes produce comes at a greater cost
> > +than the value of such clean-ups.
> 
> Should we add "conversions to managed APIs"? It's not a recent thing,
> people do like to post patches doing bulk conversions which bring very
> little benefit.

Well yes, I agree that is well established, and a common target of patches.
But isn't that covered by the previous section?

   "Using device-managed and cleanup.h constructs
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   "Netdev remains skeptical about promises of all “auto-cleanup” APIs,
    including even devm_ helpers, historically. They are not the preferred
    style of implementation, merely an acceptable one.

    ...

   https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

We could merge or otherwise rearrange that section with the one proposed by
this patch. But I didn't feel it was necessary last week.

> On the opposite side we could mention that spelling fixes are okay.
> Not sure if that would muddy the waters too much..

I think we can and should. Perhaps another section simply stating
that spelling (and grammar?) fixes are welcome.

