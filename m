Return-Path: <netdev+bounces-251036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F3D3A3E3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEEC33087CE0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E313093C4;
	Mon, 19 Jan 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeNy9/X1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EB3093C7;
	Mon, 19 Jan 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816460; cv=none; b=TbZh94qFZ3xquTmeS14VWFmYw7BU0YQmAJo7Q60Zs323UltxH+K0R7VnY3F0c7gOa1Z5IapgKxXEe6iWcJz0oFnp+KCWNeEsfBeyTtgldo1YvmoojBqnatFiceDqStC1myfQyTmGeGMZDZSpjU/H9uG95G+ok/uqxKndb4c0SGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816460; c=relaxed/simple;
	bh=J4nwEZIVoATz20DGRTmblZGUhdJB+XrPtB67DJbiZVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGV0JjQHTIUvVgvjosZ4RDCADA1pG5y8JRM3UFphrND4OGKj+Bz5jKxsY1eLHaeaYrFCw14lvz93v4YqijQqJ/SSw2Auvyk5kdtgjTJgS47MXBQZ2CgmxcL32675Sl2AEOODXEq002RYFJtJ86mktv/dOaicGHpSARFFNgTJ0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeNy9/X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2E3C116C6;
	Mon, 19 Jan 2026 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768816459;
	bh=J4nwEZIVoATz20DGRTmblZGUhdJB+XrPtB67DJbiZVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FeNy9/X1lS5XBkqNN/aX3doUGJOHyD12yaWxh58XQsIHL3TmOHyF1AU4Lei8Vjfxj
	 URkbyKgGRe4/dotfOjsbnBWmcrz83gWmu1JK/TBClBEGecp6pauy64106AXmWJ3lxy
	 pBuPWM65/qpYC1po0XI1ixvOPCaJegw/CxHWeQTOjQtDyu8rJIsFa/efGYNIHrLSJZ
	 Zm/Dq7g1BAFfaw9r/XDUizkEj/tPn1O05vYQZjXMqXiOZ2H+NNCba+YD4xjOgBMuBC
	 Sl+Hh8GjFha+91s/SE2YdZT1rDI+qMNn9zW18csB+jWSaz4U8NEkD2sBGc/f7Mqj/D
	 hIlX9VJI8XWfg==
Message-ID: <34a10265-e6de-489d-b079-6f6c5cc48dc7@kernel.org>
Date: Mon, 19 Jan 2026 10:54:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
To: Leon Hwang <leon.hwang@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 <8dc3765b-e97f-4937-b6b9-872a83ba1e26@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <8dc3765b-e97f-4937-b6b9-872a83ba1e26@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/01/2026 09.49, Leon Hwang wrote:
> 
> 
> On 5/1/26 00:43, Jakub Kicinski wrote:
>> On Fri, 2 Jan 2026 12:43:46 +0100 Jesper Dangaard Brouer wrote:
>>> On 02/01/2026 08.17, Leon Hwang wrote:
>>>> Introduce a new tracepoint to track stalled page pool releases,
>>>> providing better observability for page pool lifecycle issues.
>>>
>>> In general I like/support adding this tracepoint for "debugability" of
>>> page pool lifecycle issues.
>>>
>>> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3],
>>> which gives us the ability to get events and list page_pools from userspace.
>>> I've not used this myself (yet) so I need input from others if this is
>>> something that others have been using for page pool lifecycle issues?
>>
>> My input here is the least valuable (since one may expect the person
>> who added the code uses it) - but FWIW yes, we do use the PP stats to
>> monitor PP lifecycle issues at Meta. That said - we only monitor for
>> accumulation of leaked memory from orphaned pages, as the whole reason
>> for adding this code was that in practice the page may be sitting in
>> a socket rx queue (or defer free queue etc.) IOW a PP which is not
>> getting destroyed for a long time is not necessarily a kernel issue.
>>

What monitoring tool did production people add metrics to?

People at CF recommend that I/we add this to prometheus/node_exporter.
Perhaps somebody else already added this to some other FOSS tool?

https://github.com/prometheus/node_exporter


>>> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only
>>> Page Pools associated with a net_device can be listed".  Don't we want
>>> the ability to list "invisible" page_pool's to allow debugging issues?
>>>
>>>    [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>>>    [2] https://docs.kernel.org/userspace-api/netlink/index.html
>>>    [3] https://docs.kernel.org/netlink/specs/netdev.html
>>>    [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get
>>
>> The documentation should probably be updated :(
>> I think what I meant is that most _drivers_ didn't link their PP to the
>> netdev via params when the API was added. So if the user doesn't see the
>> page pools - the driver is probably not well maintained.
>>
>> In practice only page pools which are not accessible / visible via the
>> API are page pools from already destroyed network namespaces (assuming
>> their netdevs were also destroyed and not re-parented to init_net).
>> Which I'd think is a rare case?
>>
>>> Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
>>> notification is only generated once (in page_pool_destroy) and not when
>>> we retry in page_pool_release_retry (like this patch).  In that sense,
>>> this patch/tracepoint is catching something more than netlink provides.
>>> First I though we could add a netlink notification, but I can imagine
>>> cases this could generate too many netlink messages e.g. a netdev with
>>> 128 RX queues generating these every second for every RX queue.
>>
>> FWIW yes, we can add more notifications. Tho, as I mentioned at the
>> start of my reply - the expectation is that page pools waiting for
>> a long time to be destroyed is something that _will_ happen in
>> production.
>>
>>> Guess, I've talked myself into liking this change, what do other
>>> maintainers think?  (e.g. netlink scheme and debugging balance)
>>
>> We added the Netlink API to mute the pr_warn() in all practical cases.
>> If Xiang Mei is seeing the pr_warn() I think we should start by asking
>> what kernel and driver they are using, and what the usage pattern is :(
>> As I mentioned most commonly the pr_warn() will trigger because driver
>> doesn't link the pp to a netdev.
> 
> Hi Jakub, Jesper,
> 
> Thanks for the discussion. Since netlink notifications are only emitted
> at page_pool_destroy(), the tracepoint still provides additional
> debugging visibility for prolonged page_pool_release_retry() cases.
> 
> Steven has reviewed the tracepoint [1]. Any further feedback would be
> appreciated.

This change looks good as-is:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Your patch[0] is marked as "Changes Requested".
I suggest you send a V4 with my Acked-by added.

--Jesper

[0] 
https://patchwork.kernel.org/project/netdevbpf/patch/20260102071745.291969-1-leon.hwang@linux.dev/




