Return-Path: <netdev+bounces-260405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Go8ENtinWksPQQAu9opvQ
	(envelope-from <netdev+bounces-260405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:35:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990CF183D4B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6013019BB9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35561366814;
	Tue, 24 Feb 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RW5z6UsP"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A199366DA1;
	Tue, 24 Feb 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922111; cv=none; b=B8v40htL4j1DGhA+buZFbBAMSMgpu7Qv/wIWtiPifnBEjxPpy3V7jxRhgRkYVfzRNBl6t+wG/lqUZIjn5peFdN8d5IZRInC/5zFhbI6EHzGoPrxkspDbHKXKQTxcVnLid6dRUohBo5nGnbrSEyMxx1JDMbjIHXis7HyoG/j/K5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922111; c=relaxed/simple;
	bh=43m26sbpVD4yg8OL79u3M2NiOM3BzPRPCgbYPX+O1+k=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EBw0ZsPRdGsAHofTGkTNcK3ih7OUYM0FK8ZnrrcPXXN3wG6qHAKkplMKjycnogwsJ346scJ3Pub/QFEVOfFJaaMoRsT6h3HVQmAInrPeVaX/0a6U1kHX57OKAS+f2LgZz+/J210MGfkvLEVB0HqokYkZOiAEonO616cYi+zgRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RW5z6UsP; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DVsICJgyDOq5n55e+N9YMtGRTcnXzdB9j4fTbzYgE7M=;
	b=RW5z6UsPyv0yDN2hfUkcM0Be2o+cmUXCeU4zyB6PT+ZPk2qcRPWPcN7WS4qeMdNZ0sBbBw4wp
	ec3yYhAY7sMhhhsYiUX+aR4cJXmnEyKginoJT98OmTUPm0lkPa8ug8St1N9ADvpN4/tDeHlog+/
	C55ZK36q7Nc7NsT3AFWyOH4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fKrWR1bPczLlSJ;
	Tue, 24 Feb 2026 16:30:11 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4981B4055B;
	Tue, 24 Feb 2026 16:34:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 16:34:56 +0800
Message-ID: <a5914383-06fc-45e8-9a6c-9760617383be@huawei.com>
Date: Tue, 24 Feb 2026 16:34:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kevin.curtis@farsite.co.uk>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] net: wan: farsync: Fix use-after-free bugs caused by
 unfinished tasklets
To: Duoming Zhou <duoming@zju.edu.cn>, <netdev@vger.kernel.org>
References: <20260219124637.72578-1-duoming@zju.edu.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260219124637.72578-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260405-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 990CF183D4B
X-Rspamd-Action: no action


on 2026/2/19 20:46, Duoming Zhou wrote:
> When the FarSync T-series card is being detached, the fst_card_info is
> deallocated in fst_remove_one(). However, the fst_tx_task or fst_int_task
> may still be running or pending, leading to use-after-free bugs when the
> already freed fst_card_info is accessed in fst_process_tx_work_q() or
> fst_process_int_work_q().
>
> A typical race condition is depicted below:
>
> CPU 0 (cleanup)           | CPU 1 (tasklet)
>                            | fst_start_xmit()
> fst_remove_one()          |   tasklet_schedule()
>    unregister_hdlc_device()|
>                            | fst_process_tx_work_q() //handler
>    kfree(card) //free      |   do_bottom_half_tx()
>                            |     card-> //use
>
> The following KASAN trace was captured:
>
> ==================================================================
>   BUG: KASAN: slab-use-after-free in do_bottom_half_tx+0xb88/0xd00
>   Read of size 4 at addr ffff88800aad101c by task ksoftirqd/3/32
>   ...
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x55/0x70
>    print_report+0xcb/0x5d0
>    ? do_bottom_half_tx+0xb88/0xd00
>    kasan_report+0xb8/0xf0
>    ? do_bottom_half_tx+0xb88/0xd00
>    do_bottom_half_tx+0xb88/0xd00
>    ? _raw_spin_lock_irqsave+0x85/0xe0
>    ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>    ? __pfx___hrtimer_run_queues+0x10/0x10
>    fst_process_tx_work_q+0x67/0x90
>    tasklet_action_common+0x1fa/0x720
>    ? hrtimer_interrupt+0x31f/0x780
>    handle_softirqs+0x176/0x530
>    __irq_exit_rcu+0xab/0xe0
>    sysvec_apic_timer_interrupt+0x70/0x80
>   ...
>
>   Allocated by task 41 on cpu 3 at 72.330843s:
>    kasan_save_stack+0x24/0x50
>    kasan_save_track+0x17/0x60
>    __kasan_kmalloc+0x7f/0x90
>    fst_add_one+0x1a5/0x1cd0
>    local_pci_probe+0xdd/0x190
>    pci_device_probe+0x341/0x480
>    really_probe+0x1c6/0x6a0
>    __driver_probe_device+0x248/0x310
>    driver_probe_device+0x48/0x210
>    __device_attach_driver+0x160/0x320
>    bus_for_each_drv+0x101/0x190
>    __device_attach+0x198/0x3a0
>    device_initial_probe+0x78/0xa0
>    pci_bus_add_device+0x81/0xc0
>    pci_bus_add_devices+0x7e/0x190
>    enable_slot+0x9b9/0x1130
>    acpiphp_check_bridge.part.0+0x2e1/0x460
>    acpiphp_hotplug_notify+0x36c/0x3c0
>    acpi_device_hotplug+0x203/0xb10
>    acpi_hotplug_work_fn+0x59/0x80
>   ...
>
>   Freed by task 41 on cpu 1 at 75.138639s:
>    kasan_save_stack+0x24/0x50
>    kasan_save_track+0x17/0x60
>    kasan_save_free_info+0x3b/0x60
>    __kasan_slab_free+0x43/0x70
>    kfree+0x135/0x410
>    fst_remove_one+0x2ca/0x540
>    pci_device_remove+0xa6/0x1d0
>    device_release_driver_internal+0x364/0x530
>    pci_stop_bus_device+0x105/0x150
>    pci_stop_and_remove_bus_device+0xd/0x20
>    disable_slot+0x116/0x260
>    acpiphp_disable_and_eject_slot+0x4b/0x190
>    acpiphp_hotplug_notify+0x230/0x3c0
>    acpi_device_hotplug+0x203/0xb10
>    acpi_hotplug_work_fn+0x59/0x80
>   ...
>
>   The buggy address belongs to the object at ffff88800aad1000
>    which belongs to the cache kmalloc-1k of size 1024
>   The buggy address is located 28 bytes inside of
>    freed 1024-byte region
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xaad0
>   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>   flags: 0x100000000000040(head|node=0|zone=1)
>   page_type: f5(slab)
>   raw: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
>   raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
>   head: 0100000000000040 ffff888007042dc0 dead000000000122 0000000000000000
>   head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
>   head: 0100000000000003 ffffea00002ab401 00000000ffffffff 00000000ffffffff
>   head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffff88800aad0f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff88800aad0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   >ffff88800aad1000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                               ^
>    ffff88800aad1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ffff88800aad1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ==================================================================
>
> Fix this by ensuring that both fst_tx_task and fst_int_task are properly
> canceled before the fst_card_info is released. Add tasklet_kill() in
> fst_remove_one() to synchronize with any pending or running tasklets.
> Since unregister_hdlc_device() stops data transmission and reception,
> and fst_disable_intr() prevents further interrupts, it is appropriate
> to place tasklet_kill() after these calls.
>
> The bugs were identified through static analysis. To reproduce the issue
> and validate the fix, a FarSync T-series card was simulated in QEMU and
> delays(e.g., mdelay()) were introduced within the tasklet handler to
> increase the likelihood of triggering the race condition.
>
> Fixes: 2f623aaf9f31 ("net: farsync: Fix kmemleak when rmmods farsync")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/wan/farsync.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
> index 5b01642ca44..6b2d1e63855 100644
> --- a/drivers/net/wan/farsync.c
> +++ b/drivers/net/wan/farsync.c
> @@ -2550,6 +2550,8 @@ fst_remove_one(struct pci_dev *pdev)
>   
>   	fst_disable_intr(card);
>   	free_irq(card->irq, card);
> +	tasklet_kill(&fst_tx_task);
> +	tasklet_kill(&fst_int_task);
>   
>   	iounmap(card->ctlmem);
>   	iounmap(card->mem);

