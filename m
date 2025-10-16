Return-Path: <netdev+bounces-229883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE9BE1B74
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5D4E7AEE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD42D3A60;
	Thu, 16 Oct 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NEU+OE59"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F902D3EDC;
	Thu, 16 Oct 2025 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596008; cv=none; b=AsvObmaGvx1FuzEVsiELobf18A3ntoZe0kayXX+FgTMJJ3qZ1djLNHFF74rrtcU936xZ8gOvHTEgyX01LnQ3YFPyKdsnqTDaWaVQnUV6G5SPkXuc6AgZpgV+Z68FpQWKn0MCBlDJT73j7nQzZQYZOpXqtoVhHtBThZchtRQQ/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596008; c=relaxed/simple;
	bh=kVgWRoBfU0SLiUylqnXf18m5/a7RY8bkCfvlPxEzIDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lMXnYDNNxzXZGND1Aqui5BXKYCFoQ7vq902m44wMeR9pSTwiTeMAGTLZgwDrRAcstRHLtr2zQHP3lj0QFmouAaXWGb+s3054hdP/3lo32o20AIY8zpZe8Yd7A5qbImYKZzVdW6DhWR7x92Vs/As88G0muC3yes01xjfKcRTSLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NEU+OE59; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OVT+nSnFu6sG2HJ2rpfjozyiBbIZjchaX39jShXiZSQ=;
	b=NEU+OE59kLCV3ynrfXIGLvqEpCZmndqu0gWuAOma5gCQDUoSQBGpAFovtepfu2DFRRZdDdLIK
	cWbFkl19fnKzyF69YCjH2zSOiWNsADPQ+fHhW2WyR175gz5AAc9xyIekvSdH+0YTZnTru3qzkqn
	alPb9LI51FxlG/TV5BO6ssY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cnHyR2rhGz12LDs;
	Thu, 16 Oct 2025 14:25:51 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CE67140258;
	Thu, 16 Oct 2025 14:26:36 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 14:26:35 +0800
Message-ID: <bcb84f88-4bdd-4095-b5ea-e806e7733a54@huawei.com>
Date: Thu, 16 Oct 2025 14:26:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: drop_monitor: Add debugfs support
To: Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Simon
 Horman <horms@kernel.org>
CC: <nhorman@tuxdriver.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20251015101417.1511732-1-wangliang74@huawei.com>
 <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/15 18:40, Eric Dumazet 写道:
> On Wed, Oct 15, 2025 at 2:51 AM Wang Liang <wangliang74@huawei.com> wrote:
>> This patch add debugfs interfaces for drop monitor. Similar to kmemleak, we
>> can use the monitor by below commands:
>>
>>    echo clear > /sys/kernel/debug/drop_monitor/trace
>>    echo start > /sys/kernel/debug/drop_monitor/trace
>>    echo stop  > /sys/kernel/debug/drop_monitor/trace
>>    cat /sys/kernel/debug/drop_monitor/trace
>>
>> The trace skb number limit can be set dynamically:
>>
>>    cat /sys/kernel/debug/drop_monitor/trace_limit
>>    echo 200 > /sys/kernel/debug/drop_monitor/trace_limit
>>
>> Compare to original netlink method, the callstack dump is supported. There
>> is a example for received udp packet with error checksum:
>>
>>    reason   : UDP_CSUM (11)
>>    pc       : udp_queue_rcv_one_skb+0x14b/0x350
>>    len      : 12
>>    protocol : 0x0800
>>    stack    :
>>      sk_skb_reason_drop+0x8f/0x120
>>      udp_queue_rcv_one_skb+0x14b/0x350
>>      udp_unicast_rcv_skb+0x71/0x90
>>      ip_protocol_deliver_rcu+0xa6/0x160
>>      ip_local_deliver_finish+0x90/0x100
>>      ip_sublist_rcv_finish+0x65/0x80
>>      ip_sublist_rcv+0x130/0x1c0
>>      ip_list_rcv+0xf7/0x130
>>      __netif_receive_skb_list_core+0x21d/0x240
>>      netif_receive_skb_list_internal+0x186/0x2b0
>>      napi_complete_done+0x78/0x190
>>      e1000_clean+0x27f/0x860
>>      __napi_poll+0x25/0x1e0
>>      net_rx_action+0x2ca/0x330
>>      handle_softirqs+0xbc/0x290
>>      irq_exit_rcu+0x90/0xb0
>>
>> It's more friendly to use and not need user application to cooperate.
>> Furthermore, it is easier to add new feature. We can add reason/ip/port
>> filter by debugfs parameters, like ftrace, rather than netlink msg.
> I do not understand the fascination with net/core/drop_monitor.c,
> which looks very old school to me,
> and misses all the features,  flexibility, scalability  that 'perf',
> eBPF tracing, bpftrace, .... have today.
>
> Adding  /sys/kernel/debug/drop_monitor/* is even more old school.
>
> Not mentioning the maintenance burden.
>
> For me the choice is easy :
>
> # CONFIG_NET_DROP_MONITOR is not set
>
> perf record -ag -e skb:kfree_skb sleep 1
>
> perf script # or perf report


Thank you for taking time to review this patch!

My initially thought was that the drop_monitor may cover more drop
positions (not just kfree_skb), show more skb info, filter skb by ip/port
debugfs parameter (not support now), and not need userspace tools.

Currently perf is indeed a better choice, adding debugfs is not necessary.

Thanks!


