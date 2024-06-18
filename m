Return-Path: <netdev+bounces-104573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EE90D5F5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79FC287525
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FB156898;
	Tue, 18 Jun 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POZmKsOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9191553A0;
	Tue, 18 Jun 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721640; cv=none; b=GZINVMaVUqtSpBdFIuVGvLjHDjH0z41mh+icbdFqHv1pi61BDiT7wG1dNVu2KUnwbvJ7nautocyH4H0Hcham7QAwYseYpe+bxnJwFjW8506bGtU73Q5037NlAeZVA8I03mxWTSIm9VWk7X1tJk4TaQ4861PPNCn/WH7XeKqccBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721640; c=relaxed/simple;
	bh=SoQgjwKNmNPrQpd4eSgDp5k6ZpYXww/VUXvzfmyNfXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZLQLgFwh87FGJZPFBxSv5vtGV1smlTujJC/ChGfKQBbVTkiAVRcNGGp/pDdWQm3InF0rnEJCRrlpapZ3Tgq1jutA2eta4SPv48AZaUO6nTMXcG98W+kOjv1FJqXfecy5rlQDtTUVhZTYRWvtdCDrxw8+YU8oRPlT25B+0fPJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POZmKsOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE49BC4AF1C;
	Tue, 18 Jun 2024 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718721638;
	bh=SoQgjwKNmNPrQpd4eSgDp5k6ZpYXww/VUXvzfmyNfXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=POZmKsOPxOkHeCjOBjSPUo+8cYLN4xVmaB/UA2Jl4G1eo7ZIyAdpmuKgc3/MbkPTD
	 W6sm4kykRc7IFPx2yemUsXGtlqybVXSBpPwovooCUDBkOF5T+lbMTKM3+feuJ/7JF0
	 1G5w60SfYByMdG75Uvm5uvcff8KBYswZus1+NqaRwQm1ZNiK1mVulbZWnspsTFb5y8
	 vd96sGJwbxy+HVGT3eTdW9DhLHhoVrAciatVay+p2l8CPWS0fazkj0ig5dbdzjw3ia
	 UuQTx3Y7DmqgxzmEECaQ78vBQksp/jjXuC/PwnzqGd8B6uN8ZHchJVpXdACuHOrE6k
	 e950yuPplSytg==
Date: Tue, 18 Jun 2024 07:40:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <20240618074037.66789717@kernel.org>
In-Reply-To: <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
References: <20240617072451.1403e1d2@kernel.org>
	<CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 04:24:08 +0100 Dmitry Safonov wrote:
> Hi Jakub,
> 
> thanks for pinging,
> 
> On Mon, 17 Jun 2024 at 15:24, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Hi Dmitry!
> >
> > We added kmemleak checks to the selftest runners, TCP AO/MD5 tests seem
> > to trip it:
> >
> > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-unsigned-md5-ipv6/stdout
> >
> > Could you take a look? kmemleak is not infallible, it could be a false
> > positive.  
> 
> Sure, that seems somewhat interesting, albeit at this moment not from
> the TCP side :D
> 
> There is some pre-history to the related issue here:
> https://lore.kernel.org/lkml/0000000000004d83170605e16003@google.com/
> 
> Which I was quite sure being addressed with what now is
> https://git.kernel.org/linus/5f98fd034ca6
> 
> But now that I look at that commit, I see that kvfree_call_rcu() is
> defined to __kvfree_call_rcu() under CONFIG_KASAN_GENERIC=n. And I
> don't see the same kmemleak_ignore() on that path.
> 
> To double-check, you don't have kasan enabled on netdev runners, right?

We do:

CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y

here's the full config:
https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/645202/config

> And then straight away to another thought: the leak-report that you
> get currently is ao_info, which should not happen if kfree_rcu() is
> properly fixed.
> But I'd expect kmemleak to be unhappy with ao keys freeing as well:
> they are currently released with call_rcu(&key->rcu,
> tcp_ao_key_free_rcu), which doesn't have a hint for kmemleak, too.
> 
> I'm going to take a look at it this week. Just to let you know, I'm
> also looking at fixing those somewhat rare flakes on tcp-ao counters
> checks (but that may be net-next material together with tracepoint
> selftests).

Let me add rcu@ to CC, perhaps folks there can guide us on known false
positives with KASAN + kmemleak?

