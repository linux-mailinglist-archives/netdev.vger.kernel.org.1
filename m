Return-Path: <netdev+bounces-246701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D13CF086F
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 03:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E49B300F8B4
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19A241103;
	Sun,  4 Jan 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="f6c33vgW"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636E19D093;
	Sun,  4 Jan 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493153; cv=none; b=tFpKVZ3cWwtKPslNHxA1w9IOEE4ozDw5LNVSyu5WOQsYfV5nLaL0hevuqLNH7irDZZPXAZtaosMvNNbFYFsNtBKVkwDabNA0SHgjFHC+KOIUHDjNsMXsDAtBVZvK9KxOz6XUIfhBNa/kAgaK1qqp2KYdYfKSFAvlJIY9x3IIN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493153; c=relaxed/simple;
	bh=y3QaYbrkjyyOPmdsHqhgwhgovdLb2QZ3keKDHZJtdCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tn5bzHPrkBjCPl4olTJw6qBFyvyL1KyLLHTzEe+eo9ZAABpeeBB8Q2/xpXr8zYk0sblU3MMy/xl4JEEghJGlznqVAP+gRUUCUaSKRKbGy5lJxCBmULPKxl9xxE3WhO2PIKNgTdlYJBfSWDoPjef3TOU8jz1nUloNwL2S/jL+jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=f6c33vgW; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6z5+S1yxCPSNbxBzivMIIqV9f4PGVRzEFQUWbP9fmvs=;
	b=f6c33vgW9RV+dsQlbKk7K4l6byfS340uX2l8nOr5kmPf6avZao3sY5n+HSNANjrl6rT+uUU6O
	EtpJkBCT8OhQeZttZNPaTwxDVzG+SR8wUjxtIfGyaIFkz3Sfu0OwRj7YIMgcbrQ5mKwjmlOz73A
	yT0AXdwDGNXU8Y27T+pdwhk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dkLcw0qxPzpStt;
	Sun,  4 Jan 2026 10:15:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B1F74036C;
	Sun,  4 Jan 2026 10:18:59 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 4 Jan
 2026 10:18:58 +0800
Message-ID: <dfc33064-f99f-4728-858f-95c80300bcff@huawei.com>
Date: Sun, 4 Jan 2026 10:18:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
To: Jesper Dangaard Brouer <hawk@kernel.org>, Leon Hwang
	<leon.hwang@linux.dev>, <netdev@vger.kernel.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <kerneljasonxing@gmail.com>, <lance.yang@linux.dev>,
	<jiayuan.chen@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Leon Huang Fu
	<leon.huangfu@shopee.com>, Dragos Tatulea <dtatulea@nvidia.com>, kernel-team
	<kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
 <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf200006.china.huawei.com (7.185.36.61)

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
> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3], which gives us the ability to get events and list page_pools from userspace.
> I've not used this myself (yet) so I need input from others if this is something that others have been using for page pool lifecycle issues?
> 
> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only Page Pools associated with a net_device can be listed".  Don't we want the ability to list "invisible" page_pool's to allow debugging issues?
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
> 
>> Problem:
>> Currently, when a page pool shutdown is stalled due to inflight pages,
>> the kernel only logs a warning message via pr_warn(). This has several
>> limitations:
>>
>> 1. The warning floods the kernel log after the initial DEFER_WARN_INTERVAL,
>>     making it difficult to track the progression of stalled releases
>> 2. There's no structured way to monitor or analyze these events
>> 3. Debugging tools cannot easily capture and correlate stalled pool
>>     events with other network activity
>>
>> Solution:
>> Add a new tracepoint, page_pool_release_stalled, that fires when a page
>> pool shutdown is stalled. The tracepoint captures:
>> - pool: pointer to the stalled page_pool
>> - inflight: number of pages still in flight
>> - sec: seconds since the release was deferred
>>
>> The implementation also modifies the logging behavior:
>> - pr_warn() is only emitted during the first warning interval
>>    (DEFER_WARN_INTERVAL to DEFER_WARN_INTERVAL*2)
>> - The tracepoint is fired always, reducing log noise while still
>>    allowing monitoring tools to track the issue

If the initial log is still present, I don't really see what's the benefit
of re-triggering logs or tracepoints when the first two fields are unchanged
and the last two fields can be inspected using some tool? If there are none,
perhaps we only need to print the first trigger log and a log upon completion
of page_pool destruction.

>>
>> This allows developers and system administrators to:
>> - Use tools like perf, ftrace, or eBPF to monitor stalled releases
>> - Correlate page pool issues with network driver behavior
>> - Analyze patterns without parsing kernel logs
>> - Track the progression of inflight page counts over time
>>
>> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

