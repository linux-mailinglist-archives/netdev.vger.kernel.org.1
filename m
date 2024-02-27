Return-Path: <netdev+bounces-75375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74F869A42
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1A21C22871
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9B713DBA4;
	Tue, 27 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNkXWKNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752C130E2A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047446; cv=none; b=dc6FRIl3+Z1GUmWlsCx5l4nGxJHpcld9wds2Gi1kOFEx7NpaGFBQOlgQQm5VHCzMhWFvrfjNDpQV6Hhr0JDZYOKGKgWLmBlMaoKmAVahrCgPcRHM0fZvpjNRrDJT2zaXpySJhefrikwdz98Fiu50rIq8CtZc+0AKu+dnQ9XZ+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047446; c=relaxed/simple;
	bh=YyV9pkz56Afk6K/nZFq9LuTx+0xHcvZauMtAkG6vPUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx9uxy5xOq+8mO9KsV7tEaost2paUPwEK2T0CaGt5rvRtEPk0bBOXfui8Rx508HJeDWFByrZiZrobk0WpvJHyxT2ghAq+poTQ4tws6a14RRqpS3mjcNv55Z32BuizVfJxfdrfSWtRSBijExfjWtyGRl+eRzmPsGGCOMZQlExW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNkXWKNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701BDC433F1;
	Tue, 27 Feb 2024 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709047445;
	bh=YyV9pkz56Afk6K/nZFq9LuTx+0xHcvZauMtAkG6vPUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sNkXWKNUKVxLC2y40n3JT8Ea/JpCV3oujhSOMHUegLQI/BSCMsCOVsmCvyAIZBsDP
	 ioJcDgykL5u4OJsMzGy2GsZiysO5+SsmCScD3I2lSYpdJjgCKfqUiiq9yFylnRw8zK
	 brHxOxlS7GBP12KHbWwcGU2PhYKn/V4HwPBAeLHoax8m9XC81aJL0IFb7lCyVWQBuK
	 FuSfE6z9LesHNVWVfOll3Wcqr9akhLWz9nSUGacU7bS2AS9CMyf4jvuHxtb8Ec07ht
	 5eRarr9tYkmk40PNxw8G0iFKiw9P7F2O5xoKs/Q2m/tRR2qcdlRhsZ3czPe3NgqW1u
	 7MZ+N2yXOUiFw==
Date: Tue, 27 Feb 2024 07:24:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com,
 mst@redhat.com, michael.chan@broadcom.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240227072404.06ea4843@kernel.org>
In-Reply-To: <Zd1Y4M7gwEVmgJ8q@google.com>
References: <20240226211015.1244807-1-kuba@kernel.org>
	<20240226211015.1244807-2-kuba@kernel.org>
	<Zd0EJq3gS2_p9NQ8@google.com>
	<20240226141928.171b79fe@kernel.org>
	<Zd1Y4M7gwEVmgJ8q@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 19:37:04 -0800 Stanislav Fomichev wrote:
> On 02/26, Jakub Kicinski wrote:
> > On Mon, 26 Feb 2024 13:35:34 -0800 Stanislav Fomichev wrote:  
> > > IIUC, in order to get netdev-scoped stats in v1 (vs rfc) is to not set
> > > stats-scope, right? Any reason we dropped the explicit netdev entry?
> > > It seems more robust with a separate entry and removes the ambiguity about
> > > which stats we're querying.  
> > 
> > The change is because I switched from enum to flags.
> > 
> > I'm not 100% sure which one is going to cause fewer issues down
> > the line. It's a question of whether the next scope we add will 
> > be disjoint with or subdividing previous scopes.
> > 
> > I think only subdividing previous scopes makes sense. If we were 
> > to add "stats per NAPI" (bad example) or "per buffer pool" or IDK what
> > other thing -- we should expose that as a new netlink command, not mix 
> > it with the queues.
> > 
> > The expectation is that scopes will be extended with hw vs sw, or
> > per-CPU (e.g. page pool recycling). In which case we'll want flags,
> > so that we can combine them -- ask for HW stats for a queue or hw
> > stats for the entire netdev.
> > 
> > Perhaps I should rename stats -> queue-stats to make this more explicit?
> > 
> > The initial version I wrote could iterate both over NAPIs and
> > queues. This could be helpful to some drivers - but I realized that it
> > would lead to rather painful user experience (does the driver maintain
> > stats per NAPI or per queue?) and tricky implementation of the device
> > level sum (device stats = Sum(queue) or Sum(queue) + Sum(NAPI)??)  
> 
> Yeah, same, not sure. The flags may be more flexible but a bit harder
> wrt discoverability. Assuming a somewhat ignorant spec reader/user,
> it might be hard to say which flags makes sense to combine and which isn't.
> Or, I guess, we can try to document it?

We're talking about driver API here, so document and enforce in code
review :) But fundamentally, I don't think we should be turning this op
into a mux for all sort of stats. We can have 64k ops in the family.

> For HW vs SW, do you think it makes sense to expose it as a scope?
> Why not have something like 'rx-packets' and 'hw-rx-packets'?

I had that in one of the WIP versions but (a) a lot of the stats can 
be maintained by either device or the driver, so we'd end up with a hw-
flavor for most of the entries, and (b) 90% of the time the user will
not care whether it's the HW or SW that counted the bytes, or GSO
segments. Similarly to how most of the users will not care about
per-queue breakdown, TBH, which made me think that from user
perspective both queue and hw vs sw are just a form of detailed
breakdown. Majority will dump the combined sw|hw stats for the device.

I could be wrong.

> Maybe, as you're suggesting, we should rename stats to queue-states
> and drop the score for now? When the time comes to add hw counters,
> we can revisit. For total netdev stats, we can ask the user to aggregate
> the per-queue ones?

I'd keep the scope, and ability to show the device level aggregation.
There are drivers (bnxt, off the top of my head, but I feel like there's
more) which stash the counters when queues get freed. Without the device
level aggregation we'd need to expose that as "no queue" or "history"
or "delta" etc stats. I think that's uglier that showing the sum, which
is what user will care about 99% of the time.

It'd be a pure rename.

