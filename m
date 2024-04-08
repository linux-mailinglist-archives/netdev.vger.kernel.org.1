Return-Path: <netdev+bounces-85850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2889C92D
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BC9B20FE7
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A11420D2;
	Mon,  8 Apr 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="B6FGf0KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF722091
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591919; cv=none; b=TeF9K4Y4twAfrgpyoqZ4U4/fscLAGi8sKA0eTRuIKoSigPAddxmL25jNJfPYalQRafAHSFOfZmJpcaYzxcuexbA6PQYO6zKFXWZ4/ILBr+TRMs+x83EZI+Z+//t3DLdarPvNiPl+OH9nCUfFpWJ7Nf1H1iTOSEeitYXKrRFJFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591919; c=relaxed/simple;
	bh=pvSmKamt9fMfzvObQa541abgRTi+BA07OpthE/8lvTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjFmC99eERcIOGTRTmv1uPA8VLVxNxf+Prz+5t1eNvs1POoAzpYCHOKdZ771QaP7E2IfdSLgX8K/MNATP9uWYd4leU+OHgDJITam2vzOqby3EJ4X/oqy4sv4EwETrZHM3r0gZTuMJHBsTHfLvJXABNd5j+b7x79lWS46BbAnjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=B6FGf0KA; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3EA5D600A2;
	Mon,  8 Apr 2024 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712591912;
	bh=pvSmKamt9fMfzvObQa541abgRTi+BA07OpthE/8lvTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B6FGf0KAqcPiWvs2pihs3T+Tqc51e6SGGsN4QyqbPgL1GWaVk8067pS0SXQvDMxI1
	 aculFk4LV57i4NSbX8Ty+2hk91BM87/JuNGru+Id7SJCbA/AcjCLT1QC+m/6jEYVSl
	 ihfm+Qty2SHJQ1kA0LbIczM7XSh1tAwVlDk+k/yys6uwmJM0xu8O5YMYsoL1xEC7tZ
	 FLWjHbGjQvyUflZNM1CRaij78ttR8WsBsY8TTTpM0P6IVAHYhvmr6rOwRd2rBWapU3
	 Qtg66S7UXSOgPCC5t9ZR8H4yDrUardFLdQQ9GSWvR2RUwUcUgYFubVEcgUeJ5qrTdX
	 5RaDIZdcYz4Kw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 54407200A3D;
	Mon, 08 Apr 2024 15:58:20 +0000 (UTC)
Message-ID: <ba38d934-a877-4197-87ab-ff821c77d5f0@fiberby.net>
Date: Mon, 8 Apr 2024 15:58:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sched: cls_api: fix slab-use-after-free in
 fl_dump_key
To: Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, marcelo.leitner@gmail.com, horms@kernel.org
Cc: Cosmin Ratiu <cratiu@nvidia.com>
References: <20240408134817.35065-1-jianbol@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240408134817.35065-1-jianbol@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 1:48 PM, Jianbo Liu wrote:
> The filter counter is updated under the protection of cb_lock in the
> cited commit. While waiting for the lock, it's possible the filter is
> being deleted by other thread, and thus causes UAF when dump it.
> 
> Fix this issue by moving tcf_block_filter_cnt_update() after
> tfilter_put().
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in fl_dump_key+0x1d3e/0x20d0 [cls_flower]
>   Read of size 4 at addr ffff88814f864000 by task tc/2973
> 
>   CPU: 7 PID: 2973 Comm: tc Not tainted 6.9.0-rc2_for_upstream_debug_2024_04_02_12_41 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x7e/0xc0
>    print_report+0xc1/0x600
>    ? __virt_addr_valid+0x1cf/0x390
>    ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
>    ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
>    kasan_report+0xb9/0xf0
>    ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
>    fl_dump_key+0x1d3e/0x20d0 [cls_flower]
>    ? lock_acquire+0x1c2/0x530
>    ? fl_dump+0x172/0x5c0 [cls_flower]
>    ? lockdep_hardirqs_on_prepare+0x400/0x400
>    ? fl_dump_key_options.part.0+0x10f0/0x10f0 [cls_flower]
>    ? do_raw_spin_lock+0x12d/0x270
>    ? spin_bug+0x1d0/0x1d0
>    fl_dump+0x21d/0x5c0 [cls_flower]
>    ? fl_tmplt_dump+0x1f0/0x1f0 [cls_flower]
>    ? nla_put+0x15f/0x1c0
>    tcf_fill_node+0x51b/0x9a0
>    ? tc_skb_ext_tc_enable+0x150/0x150
>    ? __alloc_skb+0x17b/0x310
>    ? __build_skb_around+0x340/0x340
>    ? down_write+0x1b0/0x1e0
>    tfilter_notify+0x1a5/0x390
>    ? fl_terse_dump+0x400/0x400 [cls_flower]
>    tc_new_tfilter+0x963/0x2170
>    ? tc_del_tfilter+0x1490/0x1490
>    ? print_usage_bug.part.0+0x670/0x670
>    ? lock_downgrade+0x680/0x680
>    ? security_capable+0x51/0x90
>    ? tc_del_tfilter+0x1490/0x1490
>    rtnetlink_rcv_msg+0x75e/0xac0
>    ? if_nlmsg_stats_size+0x4c0/0x4c0
>    ? lockdep_set_lock_cmp_fn+0x190/0x190
>    ? __netlink_lookup+0x35e/0x6e0
>    netlink_rcv_skb+0x12c/0x360
>    ? if_nlmsg_stats_size+0x4c0/0x4c0
>    ? netlink_ack+0x15e0/0x15e0
>    ? lockdep_hardirqs_on_prepare+0x400/0x400
>    ? netlink_deliver_tap+0xcd/0xa60
>    ? netlink_deliver_tap+0xcd/0xa60
>    ? netlink_deliver_tap+0x1c9/0xa60
>    netlink_unicast+0x43e/0x700
>    ? netlink_attachskb+0x750/0x750
>    ? lock_acquire+0x1c2/0x530
>    ? __might_fault+0xbb/0x170
>    netlink_sendmsg+0x749/0xc10
>    ? netlink_unicast+0x700/0x700
>    ? __might_fault+0xbb/0x170
>    ? netlink_unicast+0x700/0x700
>    __sock_sendmsg+0xc5/0x190
>    ____sys_sendmsg+0x534/0x6b0
>    ? import_iovec+0x7/0x10
>    ? kernel_sendmsg+0x30/0x30
>    ? __copy_msghdr+0x3c0/0x3c0
>    ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
>    ? lock_acquire+0x1c2/0x530
>    ? __virt_addr_valid+0x116/0x390
>    ___sys_sendmsg+0xeb/0x170
>    ? __virt_addr_valid+0x1ca/0x390
>    ? copy_msghdr_from_user+0x110/0x110
>    ? __delete_object+0xb8/0x100
>    ? __virt_addr_valid+0x1cf/0x390
>    ? do_sys_openat2+0x102/0x150
>    ? lockdep_hardirqs_on_prepare+0x284/0x400
>    ? do_sys_openat2+0x102/0x150
>    ? __fget_light+0x53/0x1d0
>    ? sockfd_lookup_light+0x1a/0x150
>    __sys_sendmsg+0xb5/0x140
>    ? __sys_sendmsg_sock+0x20/0x20
>    ? lock_downgrade+0x680/0x680
>    do_syscall_64+0x70/0x140
>    entry_SYSCALL_64_after_hwframe+0x46/0x4e
>   RIP: 0033:0x7f98e3713367
>   Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
>   RSP: 002b:00007ffc74a64608 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>   RAX: ffffffffffffffda RBX: 000000000047eae0 RCX: 00007f98e3713367
>   RDX: 0000000000000000 RSI: 00007ffc74a64670 RDI: 0000000000000003
>   RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
>   R10: 00007f98e360c5e8 R11: 0000000000000246 R12: 00007ffc74a6a508
>   R13: 00000000660d518d R14: 0000000000484a80 R15: 00007ffc74a6a50b
>    </TASK>
> 
>   Allocated by task 2973:
>    kasan_save_stack+0x20/0x40
>    kasan_save_track+0x10/0x30
>    __kasan_kmalloc+0x77/0x90
>    fl_change+0x27a6/0x4540 [cls_flower]
>    tc_new_tfilter+0x879/0x2170
>    rtnetlink_rcv_msg+0x75e/0xac0
>    netlink_rcv_skb+0x12c/0x360
>    netlink_unicast+0x43e/0x700
>    netlink_sendmsg+0x749/0xc10
>    __sock_sendmsg+0xc5/0x190
>    ____sys_sendmsg+0x534/0x6b0
>    ___sys_sendmsg+0xeb/0x170
>    __sys_sendmsg+0xb5/0x140
>    do_syscall_64+0x70/0x140
>    entry_SYSCALL_64_after_hwframe+0x46/0x4e
> 
>   Freed by task 283:
>    kasan_save_stack+0x20/0x40
>    kasan_save_track+0x10/0x30
>    kasan_save_free_info+0x37/0x50
>    poison_slab_object+0x105/0x190
>    __kasan_slab_free+0x11/0x30
>    kfree+0x111/0x340
>    process_one_work+0x787/0x1490
>    worker_thread+0x586/0xd30
>    kthread+0x2df/0x3b0
>    ret_from_fork+0x2d/0x70
>    ret_from_fork_asm+0x11/0x20
> 
>   Last potentially related work creation:
>    kasan_save_stack+0x20/0x40
>    __kasan_record_aux_stack+0x9b/0xb0
>    insert_work+0x25/0x1b0
>    __queue_work+0x640/0xc90
>    rcu_work_rcufn+0x42/0x70
>    rcu_core+0x6a9/0x1850
>    __do_softirq+0x264/0x88f
> 
>   Second to last potentially related work creation:
>    kasan_save_stack+0x20/0x40
>    __kasan_record_aux_stack+0x9b/0xb0
>    __call_rcu_common.constprop.0+0x6f/0xac0
>    queue_rcu_work+0x56/0x70
>    fl_mask_put+0x20d/0x270 [cls_flower]
>    __fl_delete+0x352/0x6b0 [cls_flower]
>    fl_delete+0x97/0x160 [cls_flower]
>    tc_del_tfilter+0x7d1/0x1490
>    rtnetlink_rcv_msg+0x75e/0xac0
>    netlink_rcv_skb+0x12c/0x360
>    netlink_unicast+0x43e/0x700
>    netlink_sendmsg+0x749/0xc10
>    __sock_sendmsg+0xc5/0x190
>    ____sys_sendmsg+0x534/0x6b0
>    ___sys_sendmsg+0xeb/0x170
>    __sys_sendmsg+0xb5/0x140
>    do_syscall_64+0x70/0x140
>    entry_SYSCALL_64_after_hwframe+0x46/0x4e
> 
> Fixes: 2081fd3445fe ("net: sched: cls_api: add filter counter")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Tested-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

> ---
>   net/sched/cls_api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index db0653993632..17d97bbe890f 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2400,10 +2400,10 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
>   			      flags, extack);
>   	if (err == 0) {
> -		tcf_block_filter_cnt_update(block, &tp->counted, true);
>   		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
>   			       RTM_NEWTFILTER, false, rtnl_held, extack);
>   		tfilter_put(tp, fh);
> +		tcf_block_filter_cnt_update(block, &tp->counted, true);
>   		/* q pointer is NULL for shared blocks */
>   		if (q)
>   			q->flags &= ~TCQ_F_CAN_BYPASS;

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

