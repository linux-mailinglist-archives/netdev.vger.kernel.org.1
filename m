Return-Path: <netdev+bounces-117110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7694CC07
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A71B22263
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7818CC18;
	Fri,  9 Aug 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjqg/bFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BB18CC16
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191545; cv=none; b=mupqmG1WWULZbAngx6JdogEePTY4duBMeL+nsxAcutNT/e40bKHdlRK5oL7LYeooZFfrTmwHyYqhrhCZXD4h1CHvLOykZe82eT9w+rg1DZ7aKLS53VM5QAcoelGiWabEPr85nuk59k65YN8bYVPyoxijdpan1xHAUoIHkX+UVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191545; c=relaxed/simple;
	bh=LjEBP4qpYozvlNKkWCn6zPNPgha4HeIP/6WAWotjQ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGdpb+9qST5U5pEvxCIrJG2tG2tpOZkeRoTBC07ahCSNp2jnmpzoKva+ke0sXJ7guGiGLNBtskdmYvEdSJgnjQJSiXpBKd9LS/cXzPuLmbCdqtjExKVyCfD7ASGyCKT+wE0QFuBkGwD7c11C3eBmBveYDQ/1QHKrg9WGsoWj7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjqg/bFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D6C32782;
	Fri,  9 Aug 2024 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723191544;
	bh=LjEBP4qpYozvlNKkWCn6zPNPgha4HeIP/6WAWotjQ2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjqg/bFUcBvdVyM6Vay9cu2UKgCVzn4Lm5FWXgoHguFFNdWLnz3AkEisaaQAEjjsX
	 AFok0A1RTiwPrTkApkmG2cFN/0vtpo7OCow2hXp/MGJgQICgZ4ui66s6CmtYcO9Pa9
	 Vev1d8wdqr2lRmUUM4f686SgFf17AivSpXwMRUdWuafSk4fyEtyAAgsHABmDP164J5
	 g8ozkP3r9QUQAtf8HvysWfu0dsy5037M8QysZqnvflztbQ67g5iVHrHqAYDFwfUr+o
	 UVdasqbXs/8Ekdh6qj2swaF6ICMq9sv4MGCyBoDAcxNE5a4vYHy2WKTepHz8UkieRa
	 YG6DP6UFWzfbA==
Date: Fri, 9 Aug 2024 09:19:01 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next 0/9] l2tp: misc improvements
Message-ID: <20240809081901.GE3075665@kernel.org>
References: <cover.1722856576.git.jchapman@katalix.com>
 <20240806144038.GV2636630@kernel.org>
 <bb820af8-6079-cd7f-4466-9c9a9851155e@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb820af8-6079-cd7f-4466-9c9a9851155e@katalix.com>

On Tue, Aug 06, 2024 at 04:53:24PM +0100, James Chapman wrote:
> On 06/08/2024 15:40, Simon Horman wrote:
> > On Mon, Aug 05, 2024 at 12:35:24PM +0100, James Chapman wrote:
> > > This series makes several improvements to l2tp:
> > > 
> > >   * update documentation to be consistent with recent l2tp changes.
> > >   * move l2tp_ip socket tables to per-net data.
> > >   * fix handling of hash key collisions in l2tp_v3_session_get
> > >   * implement and use get-next APIs for management and procfs/debugfs.
> > >   * improve l2tp refcount helpers.
> > >   * use per-cpu dev->tstats in l2tpeth devices.
> > >   * fix a lockdep splat.
> > >   * fix a race between l2tp_pre_exit_net and pppol2tp_release.
> > > 
> > > James Chapman (9):
> > >    documentation/networking: update l2tp docs
> > >    l2tp: move l2tp_ip and l2tp_ip6 data to pernet
> > >    l2tp: fix handling of hash key collisions in l2tp_v3_session_get
> > >    l2tp: add tunnel/session get_next helpers
> > >    l2tp: use get_next APIs for management requests and procfs/debugfs
> > >    l2tp: improve tunnel/session refcount helpers
> > >    l2tp: l2tp_eth: use per-cpu counters from dev->tstats
> > >    l2tp: fix lockdep splat
> > >    l2tp: flush workqueue before draining it
> > 
> > Hi James,
> > 
> > I notice that some of these patches are described as fixes and have Fixes
> > tags. As such they seem appropriate for, a separate, smaller series,
> > targeted at net.
> > 
> > ...
> 
> Hi Simon,
> 
> Thanks for reviewing.
> 
> Patch 3 changes code which already differs in the net-next and net trees. If
> it is applied to net, I think commit 24256415d1869 ("l2tp: prevent possible
> tunnel refcount underflow") is also suitable for net. I see now that I
> haven't used the Fixes tag consistently. tbh, I think both commits address
> possible issues in a rare use case so aren't necessary for net. But if you
> or others think otherwise, I'll respin for net.

Thanks, and sorry for my slow response.

In principle I think it is fine to push changes to net-next, without Fixes
tags, that are marginal wrt being fixes.

> 
> I'll respin patch 8 targetted at net.
> 
> Patch 9 addresses changes code that isn't yet in the net tree. I'll remove
> the Fixes tag in v2.
> 
> 

