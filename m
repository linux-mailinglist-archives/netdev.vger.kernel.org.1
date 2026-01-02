Return-Path: <netdev+bounces-246586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B9CEEB39
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C113A300091B
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE73126C3;
	Fri,  2 Jan 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TjSVEr+l"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89847310630
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362078; cv=none; b=L0ay+h4iWolELLdk1jvPr7cgPFNskpD4CnU6sTnAsmxMmuG5pl6mg997R//smMS46jx8Z4TDfzfyAQaTGQhlidJtYlbTpyvTJD4t/UJN0at22Um7jec9C4yI7NqkebkQQ6gbdyk3oItkO0qLNZ1xTyndwHvVV91OItv4vwxq4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362078; c=relaxed/simple;
	bh=sfgzLw6T/MQzpo/xhzZ+DWJl9w43rzPkLh3LYn4joxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+hhv74wFK2fuJOVNBBS7WyHN3ASBDzoXI0JpGrlc+WNKsZjw9dgKSoP4ALTxdF7xDg+GAZdBdqQEzd4jZ0aGEWVMC2WNEW6ES2catjkfrtu0yaDJtGFBkA+utsQe6sM+cAh76nfPSaGqh3E1tVxoKNEIZB/Gy+wOf2ndhQBftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TjSVEr+l; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3461bd2d-2ee6-4592-9069-2c7a4b8a0b4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767362072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um8VhsKFWm3QgNgqCqwn+UbLKJeOFTEy1s5gZCC82xA=;
	b=TjSVEr+laVrs4xS/ZqgUOcA+M6r50cnGYXq/pLXedv0hKsxXhLP/9dC7+acKKQu+Kxwqbw
	jMx+EhlXsi/avIYKJqF/lwhjlho0VnydlCLuMd3mCW/09UwmBm/P2Xp2PJBRdtVUvrCLoS
	/xvUfChlTlN/C7PjLD7ekSEGQzSmDUw=
Date: Fri, 2 Jan 2026 21:54:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Leon Huang Fu <leon.huangfu@shopee.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
 <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/2 19:43, Jesper Dangaard Brouer wrote:
> 
> 
> On 02/01/2026 08.17, Leon Hwang wrote:
>> Introduce a new tracepoint to track stalled page pool releases,
>> providing better observability for page pool lifecycle issues.
>>
> 
> In general I like/support adding this tracepoint for "debugability" of
> page pool lifecycle issues.
> 
> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3],
> which gives us the ability to get events and list page_pools from
> userspace.
> I've not used this myself (yet) so I need input from others if this is
> something that others have been using for page pool lifecycle issues?
> 
> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only
> Page Pools associated with a net_device can be listed".  Don't we want
> the ability to list "invisible" page_pool's to allow debugging issues?
> 
>  [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>  [2] https://docs.kernel.org/userspace-api/netlink/index.html
>  [3] https://docs.kernel.org/netlink/specs/netdev.html
>  [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get
> 
> Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
> notification is only generated once (in page_pool_destroy) and not when
> we retry in page_pool_release_retry (like this patch).  In that sense,
> this patch/tracepoint is catching something more than netlink provides.
> First I though we could add a netlink notification, but I can imagine
> cases this could generate too many netlink messages e.g. a netdev with
> 128 RX queues generating these every second for every RX queue.
> 
> Guess, I've talked myself into liking this change, what do other
> maintainers think?  (e.g. netlink scheme and debugging balance)
> 

Hi Jesper,

Thanks for the thoughtful review and for sharing the context around the
existing netlink-based observability.

I ran into a real-world issue where stalled pages were still referenced
by dangling TCP sockets. I wrote up the investigation in more detail in
my blog post “let page inflight” [1] (unfortunately only available in
Chinese at the moment).

In practice, the hardest part was identifying *who* was still holding
references to the inflight pages. With the current tooling, it is very
difficult to introspect the active users of a page once it becomes stalled.

If we can expose more information about current page users—such as the
user type and a user pointer, it becomes much easier to debug these
issues using BPF-based tools. For example, by tracing
page_pool_state_hold and page_pool_state_release, tools like bpftrace
[2] or bpfsnoop [3] (which I implemented) can correlate inflight page
pointers with their active users. This significantly lowers the barrier
to diagnosing page pool lifecycle problems.

As you noted, the existing netlink notifications are generated only at
page_pool_destroy, and not during retries in page_pool_release_retry. In
that sense, the proposed tracepoint captures a class of issues that
netlink does not currently cover, and does so without the risk of
generating excessive userspace events.

Thanks again for the feedback, and I’m happy to refine the approach
based on further input from you, Kuba, or other maintainers.

Links:
[1] https://blog.leonhw.com/post/linux-networking-6-inflight-page/
[2] https://github.com/bpftrace/bpftrace/
[3] https://github.com/bpfsnoop/bpfsnoop/

Thanks,
Leon

[...]


