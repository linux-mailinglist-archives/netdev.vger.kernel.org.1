Return-Path: <netdev+bounces-251008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9A6D3A20E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA3473002165
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAE3502B8;
	Mon, 19 Jan 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U2EUKKnz"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983333A008
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812616; cv=none; b=tu5IJaQfLUlaVvDD/ksgE0t+Mim+LZMRND5DlLpIfC34TcI/a9T1x1wjHo8lVvOo4W1APSBjfH9Hu+zLs3HaAdbJZrjp6pwF6pNDlQUhBPCwZea3hwj8veaNSzAsYzy1MNaqkRWIzwaaGdm0LeStC80tv58dUzBZ7SuiNCEKJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812616; c=relaxed/simple;
	bh=84ETkUfpc3EswQvnB2lM/Q2ffz1tmPudt+ruJY+u4aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA2K92A28U4ywoxSDuJPLu5t8nFgDODjKtJxBHVuXrNMBX297HBFCjXKfUc5Whs9dReH5SL73eG0B9/jdjfRVp+MpGcdqeB3JG1nbOzLTF3oCzh4+PZ4J+SBh3uUIX8+KatifFZTPbVaHVZ9n8ogInCrYVJLVVDki2ZEB8EAL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2EUKKnz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8dc3765b-e97f-4937-b6b9-872a83ba1e26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768812600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJnFBuVeKy2seKUMYgvEGmFX+m+0gIR/n54nnj5zXCE=;
	b=U2EUKKnzZTcZW+2kot9Xseo/1FRep+r+OC8Ha0An9OPuzah0NdoxUMdi5waz23MjoCkBUM
	W057bD5cGyRLJHFvTr2xGpU8SlfsyB5LZgGtBHNnlMz7/xJnvxpRWShToda22hHlxDkzMr
	DB/4k3CLbcHT8MjqH9GY8siroY1a8ko=
Date: Mon, 19 Jan 2026 16:49:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260104084347.5de3a537@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/1/26 00:43, Jakub Kicinski wrote:
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
>>   [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>>   [2] https://docs.kernel.org/userspace-api/netlink/index.html
>>   [3] https://docs.kernel.org/netlink/specs/netdev.html
>>   [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get
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

Hi Jakub, Jesper,

Thanks for the discussion. Since netlink notifications are only emitted
at page_pool_destroy(), the tracepoint still provides additional
debugging visibility for prolonged page_pool_release_retry() cases.

Steven has reviewed the tracepoint [1]. Any further feedback would be
appreciated.

Thanks,
Leon

[1]
https://lore.kernel.org/netdev/20260102104504.7f593441@gandalf.local.home/



