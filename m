Return-Path: <netdev+bounces-251199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E3D3B43E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7707D3005193
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25271328B64;
	Mon, 19 Jan 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH0Eq5bH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4D324718;
	Mon, 19 Jan 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843622; cv=none; b=UHdcMqFFEMZz+GCuagVOD89pTVfXTCVMx9jwdGnpB02yH2whn2DkgsoaHnzjxO1+HSY8c+YQS1FkzIV840O0WZBRs/018Le+1sNQrLN4RWKB3ZikzqDkTWd4MXKwtiZf6wMtcnpGS9TRdj1zQkb1dXRyz9oe4WBY9xZ2WZQiNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843622; c=relaxed/simple;
	bh=h/y0x7JfkcAmO9wWFjfC5qhu+ZUjCXgY299F0KHGKto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntxbCDHLYJNyswwi7opdGCQphQBEcKkGmnS/OCzUtdEGYdMuSTVPIUfycPKwcf92Z8NiTNMvTlvMDXpW9LhI8kFR+qEZQeTKgc2q89Cj0SY/01KGyiK+3z5bXdWDKtRGsvrqGQ6kiYUemRA4YFv+F5TqRXDHWssmN3QIF7UC4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH0Eq5bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B40C116C6;
	Mon, 19 Jan 2026 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843621;
	bh=h/y0x7JfkcAmO9wWFjfC5qhu+ZUjCXgY299F0KHGKto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jH0Eq5bHH/GYthjmrzVGLf199xjzvr0M2DEwPWhPzb5GiwKsvSmYAjOZv8HJ8K07o
	 zMAG/Rgv5Y60BB0P1/pZjrTgZ/Vl8ln3FBrqdsQUrw5HYvouhM615A1hnpaMq04sbt
	 R2f2BeawOMwz7T02UN+YxfBaH87blFUcu7XyOVX5g2SEMDpE5hTd2bqyjd28TuWRg6
	 3b+OqTc+yh3S7U/yMAatggOl7mKvCEseMRXi413AGm4eDj85ldnRWzrPH2BIzS2Uv7
	 3vGVilPHtXLC6N+WQBttbTuG66WoxEXadpN+0Ayy4mgQO7zdKRvZVB0yrDiQtJIWbA
	 xdH+SX0xIT71Q==
Message-ID: <d769109c-2479-4050-a24a-e79323620a62@kernel.org>
Date: Mon, 19 Jan 2026 18:26:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
 <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
 <20260104084347.5de3a537@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260104084347.5de3a537@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/01/2026 17.43, Jakub Kicinski wrote:
> On Fri, 2 Jan 2026 12:43:46 +0100 Jesper Dangaard Brouer wrote:
>> On 02/01/2026 08.17, Leon Hwang wrote:
>>> Introduce a new tracepoint to track stalled page pool releases,
>>> providing better observability for page pool lifecycle issues.
>>
>> In general I like/support adding this tracepoint for "debugability" of
>> page pool lifecycle issues.
>>
>> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3],
>> which gives us the ability to get events and list page_pools from userspace.
>> I've not used this myself (yet) so I need input from others if this is
>> something that others have been using for page pool lifecycle issues?
> 
> My input here is the least valuable (since one may expect the person
> who added the code uses it) - but FWIW yes, we do use the PP stats to
> monitor PP lifecycle issues at Meta. That said - we only monitor for
> accumulation of leaked memory from orphaned pages, as the whole reason
> for adding this code was that in practice the page may be sitting in
> a socket rx queue (or defer free queue etc.) IOW a PP which is not
> getting destroyed for a long time is not necessarily a kernel issue.
> 
>> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only
>> Page Pools associated with a net_device can be listed".  Don't we want
>> the ability to list "invisible" page_pool's to allow debugging issues?
>>
>>    [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>>    [2] https://docs.kernel.org/userspace-api/netlink/index.html
>>    [3] https://docs.kernel.org/netlink/specs/netdev.html
>>    [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get
> 
> The documentation should probably be updated :(
> I think what I meant is that most _drivers_ didn't link their PP to the
> netdev via params when the API was added. So if the user doesn't see the
> page pools - the driver is probably not well maintained.
> 
> In practice only page pools which are not accessible / visible via the
> API are page pools from already destroyed network namespaces (assuming
> their netdevs were also destroyed and not re-parented to init_net).
> Which I'd think is a rare case?
> 
>> Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
>> notification is only generated once (in page_pool_destroy) and not when
>> we retry in page_pool_release_retry (like this patch).  In that sense,
>> this patch/tracepoint is catching something more than netlink provides.
>> First I though we could add a netlink notification, but I can imagine
>> cases this could generate too many netlink messages e.g. a netdev with
>> 128 RX queues generating these every second for every RX queue.
> 
> FWIW yes, we can add more notifications. Tho, as I mentioned at the
> start of my reply - the expectation is that page pools waiting for
> a long time to be destroyed is something that _will_ happen in
> production.
> 
>> Guess, I've talked myself into liking this change, what do other
>> maintainers think?  (e.g. netlink scheme and debugging balance)
> 
> We added the Netlink API to mute the pr_warn() in all practical cases.
> If Xiang Mei is seeing the pr_warn() I think we should start by asking
> what kernel and driver they are using, and what the usage pattern is :(
> As I mentioned most commonly the pr_warn() will trigger because driver
> doesn't link the pp to a netdev.

The commit that introduced this be0096676e23 ("net: page_pool: mute the
periodic warning for visible page pools") (Author: Jakub Kicinski) was
added in kernel v6.8.  Our fleet runs 6.12.

Looking at production logs I'm still seeing these messages, e.g.:
  "page_pool_release_retry() stalled pool shutdown: id 322, 1 inflight 
591248 sec"

Looking at one of these servers it runs kernel 6.12.59 and ice NIC driver.

I'm surprised to see these on our normal servers and also the long
period.  Previously I was seeing these on k8s servers, which makes more
sense at veth interfaces are likely to be removed and easier reach the
pr_warn() (as Jakub added extra if statement checking netdev in commit
(!netdev || netdev == NET_PTR_POISON)).

An example from a k8s server have smaller stalled period, and I think it 
recovered:
  "page_pool_release_retry() stalled pool shutdown: id 18, 1 inflight 
3020 sec"

I'm also surprised to see ice NIC driver, as previously we mostly seen
these warning on driver bnxt_en.  I did manage to find some cases of the
bnxt_en driver now, but I see that the server likely have a hardware defect.

Bottom-line yes these stalled pool shutdown pr_warn() are still
happening in production.

--Jesper





