Return-Path: <netdev+bounces-246573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8ACEE68E
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0402A30285F9
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7BF2F3609;
	Fri,  2 Jan 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3fsaD/4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6A2E6CC7;
	Fri,  2 Jan 2026 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354233; cv=none; b=S/H2iWQn/8ZiiuYex7bN/VpEvFqq7I6iWplMFcSnMDOlaRAbzHC0N9//nQA1laLd+ep3Ovfe2yBH2UjhRYvXQm+F5XrtcRTBmlUOylZNH/uKdiu+vQrWyIIa5fcs3pzQOLkvYGiSSrUorUoFXqPW/JM6MAMryNcU24Nx2BLltkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354233; c=relaxed/simple;
	bh=sLC8UGfwzdnc6FYoiWOajoAfu6XPBRq07y6jMEZyH48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2AOZS2J8wyXiMB1S4+yf8xpNZnTGL6VArN2W0MQLyWwje8XnMZdPvzMbuReFmQzwR/LAier/TWv9rq94lUX1v+3JSI8qD8vtiqDIFCEDhWMZ4aYoUw2f9dSKSd2s2ikQ/tQWhZp5jKT/Gn/c+RJpSbauxtoIPAlWn916xZynBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3fsaD/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9D0C116B1;
	Fri,  2 Jan 2026 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767354232;
	bh=sLC8UGfwzdnc6FYoiWOajoAfu6XPBRq07y6jMEZyH48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z3fsaD/4vuOolaxerlDlxL1Bj/DiNisIBjNQzFjqKCxYe622dgmwAkbSavcMcdDlR
	 BbS+uSjB5sU9XRbgkGibLXyT8xOf1TqXeOCrse8wBqSF9IcXehXXO+PGys4U73S24r
	 1yfgyR1ihp/Tcgy/2nSZA0wEoL+1gZxP6DzXN4W/5NBOm2q6jLJmjmuv6P0lZE84Vn
	 Q1fIj19BfxqoK7x0r8Iq+swKKyMJt+AEC6zfHTStjpJpjAiP7ZfFg7YK9I9tALC1bG
	 Y5Pavf2mY1+de8MUqzeZwIWDfovA/hZgfGDXsIFIZL0R2bKUbnv3/6/iGjyyDh1mga
	 peYhcUjkb0JGw==
Message-ID: <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Date: Fri, 2 Jan 2026 12:43:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
To: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260102071745.291969-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/01/2026 08.17, Leon Hwang wrote:
> Introduce a new tracepoint to track stalled page pool releases,
> providing better observability for page pool lifecycle issues.
> 

In general I like/support adding this tracepoint for "debugability" of
page pool lifecycle issues.

For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3], 
which gives us the ability to get events and list page_pools from userspace.
I've not used this myself (yet) so I need input from others if this is 
something that others have been using for page pool lifecycle issues?

Need input from @Kuba/others as the "page-pool-get"[4] state that "Only 
Page Pools associated with a net_device can be listed".  Don't we want 
the ability to list "invisible" page_pool's to allow debugging issues?

  [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
  [2] https://docs.kernel.org/userspace-api/netlink/index.html
  [3] https://docs.kernel.org/netlink/specs/netdev.html
  [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get

Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
notification is only generated once (in page_pool_destroy) and not when
we retry in page_pool_release_retry (like this patch).  In that sense,
this patch/tracepoint is catching something more than netlink provides.
First I though we could add a netlink notification, but I can imagine
cases this could generate too many netlink messages e.g. a netdev with
128 RX queues generating these every second for every RX queue.

Guess, I've talked myself into liking this change, what do other
maintainers think?  (e.g. netlink scheme and debugging balance)


> Problem:
> Currently, when a page pool shutdown is stalled due to inflight pages,
> the kernel only logs a warning message via pr_warn(). This has several
> limitations:
> 
> 1. The warning floods the kernel log after the initial DEFER_WARN_INTERVAL,
>     making it difficult to track the progression of stalled releases
> 2. There's no structured way to monitor or analyze these events
> 3. Debugging tools cannot easily capture and correlate stalled pool
>     events with other network activity
> 
> Solution:
> Add a new tracepoint, page_pool_release_stalled, that fires when a page
> pool shutdown is stalled. The tracepoint captures:
> - pool: pointer to the stalled page_pool
> - inflight: number of pages still in flight
> - sec: seconds since the release was deferred
> 
> The implementation also modifies the logging behavior:
> - pr_warn() is only emitted during the first warning interval
>    (DEFER_WARN_INTERVAL to DEFER_WARN_INTERVAL*2)
> - The tracepoint is fired always, reducing log noise while still
>    allowing monitoring tools to track the issue
> 
> This allows developers and system administrators to:
> - Use tools like perf, ftrace, or eBPF to monitor stalled releases
> - Correlate page pool issues with network driver behavior
> - Analyze patterns without parsing kernel logs
> - Track the progression of inflight page counts over time
> 
> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v2 -> v3:
>   - Print id using '%u'.
>   - https://lore.kernel.org/netdev/20260102061718.210248-1-leon.hwang@linux.dev/
> 
> v1 -> v2:
>   - Drop RFC.
>   - Store 'pool->user.id' to '__entry->id' (per Steven Rostedt).
>   - https://lore.kernel.org/netdev/20251125082207.356075-1-leon.hwang@linux.dev/
> ---
>   include/trace/events/page_pool.h | 24 ++++++++++++++++++++++++
>   net/core/page_pool.c             |  6 ++++--
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
> index 31825ed30032..a851e0f6a384 100644
> --- a/include/trace/events/page_pool.h
> +++ b/include/trace/events/page_pool.h
> @@ -113,6 +113,30 @@ TRACE_EVENT(page_pool_update_nid,
>   		  __entry->pool, __entry->pool_nid, __entry->new_nid)
>   );
>   
> +TRACE_EVENT(page_pool_release_stalled,
> +
> +	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
> +
> +	TP_ARGS(pool, inflight, sec),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct page_pool *, pool)
> +		__field(u32,			  id)
> +		__field(int,			  inflight)
> +		__field(int,			  sec)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pool		= pool;
> +		__entry->id		= pool->user.id;
> +		__entry->inflight	= inflight;
> +		__entry->sec		= sec;
> +	),
> +
> +	TP_printk("page_pool=%p id=%u inflight=%d sec=%d",
> +		  __entry->pool, __entry->id, __entry->inflight, __entry->sec)
> +);
> +
>   #endif /* _TRACE_PAGE_POOL_H */
>   
>   /* This part must be outside protection */
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 265a729431bb..01564aa84c89 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1222,8 +1222,10 @@ static void page_pool_release_retry(struct work_struct *wq)
>   	    (!netdev || netdev == NET_PTR_POISON)) {
>   		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
>   
> -		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
> -			__func__, pool->user.id, inflight, sec);
> +		if (sec >= DEFER_WARN_INTERVAL / HZ && sec < DEFER_WARN_INTERVAL * 2 / HZ)
> +			pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
> +				__func__, pool->user.id, inflight, sec);
> +		trace_page_pool_release_stalled(pool, inflight, sec);
>   		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
>   	}
>   


