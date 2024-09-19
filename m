Return-Path: <netdev+bounces-128981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598897CB38
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957791F23320
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E951A0712;
	Thu, 19 Sep 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TFbtrbYK"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB31A00D0
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757775; cv=none; b=Oqdua+G354FHLehIxv7OlVUNWY+jkp9NI4exYVJfOAZ9TAheWyktWPmHGNnMPWFRBV9S76t6DiOXOdAmTdG3aj0PZ/NmwsC82yGhkYbPLgbYMqz6aJkKQnh0/HpaMdRAZcKWwcw1LYq8mtLXmQxQwcm26VGrH9E5ZgdQ8oS5kiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757775; c=relaxed/simple;
	bh=qiQggod+BH+PiOZ9MBdxFiV5USki6+kf5kxRWPinAiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qsQCk3pCEO2cPzCCtdBpDBnIpCoKb1E7AQCLFwCQ1VeIz/vJ7HFqE3q7Fw8OguFBr6tPP2xxvpQE7kTjY72EksfDvjn/7ooa/aUW4gFRe4yqi4IFrF7tutka6TgFsVMuSH/jabCCNygfQOVjWkD34x3QTSctoJWeyMuBznVjkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TFbtrbYK; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B920F280081;
	Thu, 19 Sep 2024 14:56:03 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.44.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 260E113C2B0;
	Thu, 19 Sep 2024 07:56:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 260E113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726757762;
	bh=qiQggod+BH+PiOZ9MBdxFiV5USki6+kf5kxRWPinAiI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TFbtrbYKGWg30pgPVo15/x1yD0c12il2IrBEJZC886EJQPyCqmSJKj1SiII4Qv61V
	 /ZM0LEk0SvoRzAQQsJGP92cXwb7V6IKZzSb8KzT5+F8aLj8p7E3DCToHNlQmPah5Su
	 rKH8kSO1BkGMA9i5eAc+NNShytvm+xkXxQ7ov/R0=
Message-ID: <0bbcd0f2-42e1-4fdc-a9bd-49dd3506c7f4@candelatech.com>
Date: Thu, 19 Sep 2024 07:56:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] af_packet: Fix softirq mismatch in tpacket_rcv
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
References: <20240918205719.64214-1-greearb@candelatech.com>
 <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1726757764-TpaOh2TssKxJ
X-MDID-O:
 us5;ut7;1726757764;TpaOh2TssKxJ;<greearb@candelatech.com>;2f43c458b1d402e5e75c1bcf06c3ca94

On 9/19/24 05:10, Willem de Bruijn wrote:
> greearb@ wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> tpacket_rcv can be called from softirq context on input
>> path from NIC to stack.  And also called on transmit path
>> when sniffing is enabled.  So, use _bh locks to allow this
>> to function properly.
> 
> It cannot be as straightforward as that, or we would have seen this
> much earlier.
> 
> On transmit, packet sockets are intercepted by dev_queue_xmit_nit.
> Which is called from __dev_queue_xmit with bottom halfs already
> disabled:
> 
>          /* Disable soft irqs for various locks below. Also
>           * stops preemption for RCU.
>           */
>          rcu_read_lock_bh();

dev_queue_xmit_nit is also called directly from vrf xmit logic,
maybe that is the issue?  You can see it in the call flow
that lockdep shows in the second backtrace below.

> 
> Also, if this proves a real issue on the socket lock, then it would
> apply to packet_rcv and tpacket_rcv equally.
> 
> Will need to read up a bit more closely on IN-SOFTIRQ-W vs
> SOFTIRQ-ON-W unless someone beats me to it.
> 
> But likely this is either a false positive, or something specific to
> that tpacket_v3 blk_fill_in_prog_lock. Which does get called also
> from a timer.

We see OS lockup, as well as lockdep splats.  Possibly the root
cause exists elsewhere, we are still testing...

To reproduce the problem, run traffic across a network device in
a VRF, then open sniffer on the vrf interface.

Thanks,
Ben

> 
> 
>> Thanks to Johannes Berg for providing some explanation of the cryptic
>> lockdep output.
>>
>> ================================
>> WARNING: inconsistent lock state
>> 6.11.0 #1 Tainted: G        W
>> --------------------------------
>> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
>> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
>> {IN-SOFTIRQ-W} state was registered at:
>>    lock_acquire+0x19a/0x4f0
>>    _raw_spin_lock+0x27/0x40
>>    packet_rcv+0xa33/0x1320
>>    __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
>>    __netif_receive_skb_list_core+0x2c9/0x890
>>    netif_receive_skb_list_internal+0x610/0xcc0
>>    napi_complete_done+0x1c0/0x7c0
>>    igb_poll+0x1dbb/0x57e0 [igb]
>>    __napi_poll.constprop.0+0x99/0x430
>>    net_rx_action+0x8e7/0xe10
>>    handle_softirqs+0x1b7/0x800
>>    __irq_exit_rcu+0x91/0xc0
>>    irq_exit_rcu+0x5/0x10
>>    common_interrupt+0x7f/0xa0
>>    asm_common_interrupt+0x22/0x40
>>    cpuidle_enter_state+0x289/0x320
>>    cpuidle_enter+0x45/0xa0
>>    do_idle+0x2fe/0x3e0
>>    cpu_startup_entry+0x4b/0x60
>>    start_secondary+0x201/0x280
>>    common_startup_64+0x13e/0x148
>> irq event stamp: 467094363
>> hardirqs last  enabled at (467094363): [<ffffffff83dc794b>] _raw_spin_unlock_irqrestore+0x2b/0x50
>> hardirqs last disabled at (467094362): [<ffffffff83dc7753>] _raw_spin_lock_irqsave+0x53/0x60
>> softirqs last  enabled at (467094360): [<ffffffff83481213>] skb_attempt_defer_free+0x303/0x4e0
>> softirqs last disabled at (467094358): [<ffffffff83481188>] skb_attempt_defer_free+0x278/0x4e0
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(rlock-AF_PACKET);
>>    <Interrupt>
>>      lock(rlock-AF_PACKET);
>>
>>   *** DEADLOCK ***
>>
>> 3 locks held by btserver/134819:
>>   #0: ffff888136a3bf98 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_recvmsg+0xc7/0x4e0
>>   #1: ffffffff84e4bc20 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x59/0x1e20
>>   #2: ffffffff84e4bc20 (rcu_read_lock){....}-{1:2}, at: dev_queue_xmit_nit+0x2a/0xa40
>>
>> stack backtrace:
>> CPU: 2 UID: 0 PID: 134819 Comm: btserver Tainted: G        W          6.11.0 #1
>> Tainted: [W]=WARN
>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x73/0xa0
>>   mark_lock+0x102e/0x16b0
>>   ? print_usage_bug.part.0+0x600/0x600
>>   ? print_usage_bug.part.0+0x600/0x600
>>   ? print_usage_bug.part.0+0x600/0x600
>>   ? lock_acquire+0x19a/0x4f0
>>   ? find_held_lock+0x2d/0x110
>>   __lock_acquire+0x9ae/0x6170
>>   ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>>   ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>>   lock_acquire+0x19a/0x4f0
>>   ? tpacket_rcv+0x863/0x3b30
>>   ? run_filter+0x131/0x300
>>   ? lock_sync+0x170/0x170
>>   ? do_syscall_64+0x69/0x160
>>   ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>   ? lock_is_held_type+0xa5/0x110
>>   _raw_spin_lock+0x27/0x40
>>   ? tpacket_rcv+0x863/0x3b30
>>   tpacket_rcv+0x863/0x3b30
>>   ? packet_recvmsg+0x1340/0x1340
>>   ? __asan_memcpy+0x38/0x60
>>   ? __skb_clone+0x547/0x730
>>   ? packet_recvmsg+0x1340/0x1340
>>   dev_queue_xmit_nit+0x709/0xa40
>>   ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>>   vrf_finish_direct+0x26e/0x340 [vrf]
>>   ? vrf_ip_local_out+0x570/0x570 [vrf]
>>   vrf_l3_out+0x5f4/0xe80 [vrf]
>>   __ip_local_out+0x51e/0x7a0
>>   ? __ip_append_data+0x3d00/0x3d00
>>   ? __lock_acquire+0x1b57/0x6170
>>   ? ipv4_dst_check+0xd6/0x150
>>   ? lock_is_held_type+0xa5/0x110
>>   __ip_queue_xmit+0x7ff/0x1e20
>>   __tcp_transmit_skb+0x1699/0x3850
>>   ? __tcp_select_window+0xfb0/0xfb0
>>   ? __build_skb_around+0x22f/0x330
>>   ? __alloc_skb+0x13d/0x2c0
>>   ? __napi_build_skb+0x40/0x40
>>   ? __tcp_send_ack.part.0+0x5f/0x690
>>   ? skb_attempt_defer_free+0x303/0x4e0
>>   tcp_recvmsg_locked+0xdd1/0x23e0
>>   ? tcp_recvmsg+0xc7/0x4e0
>>   ? tcp_update_recv_tstamps+0x1c0/0x1c0
>>   tcp_recvmsg+0xe5/0x4e0
>>   ? tcp_recv_timestamp+0x6c0/0x6c0
>>   inet_recvmsg+0xf0/0x4b0
>>   ? inet_splice_eof+0xa0/0xa0
>>   ? inet_splice_eof+0xa0/0xa0
>>   sock_recvmsg+0xc8/0x150
>>   ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>>   sock_read_iter+0x258/0x380
>>   ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>>   ? sock_recvmsg+0x150/0x150
>>   ? rw_verify_area+0x64/0x590
>>   vfs_read+0x8d5/0xc20
>>   ? poll_schedule_timeout.constprop.0+0xe0/0xe0
>>   ? kernel_read+0x50/0x50
>>   ? __asan_memset+0x1f/0x40
>>   ? ktime_get_ts64+0x85/0x210
>>   ? __fget_light+0x4d/0x1d0
>>   ksys_read+0x166/0x1c0
>>   ? __ia32_sys_pwrite64+0x1d0/0x1d0
>>   ? __ia32_sys_poll+0x3e0/0x3e0
>>   do_syscall_64+0x69/0x160
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> RIP: 0033:0x7f6909b01b92
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   net/packet/af_packet.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 4692a9ef110b..17f9e2efdf25 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -760,8 +760,8 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>>   	 */
>>   	if (BLOCK_NUM_PKTS(pbd)) {
>>   		/* Waiting for skb_copy_bits to finish... */
>> -		write_lock(&pkc->blk_fill_in_prog_lock);
>> -		write_unlock(&pkc->blk_fill_in_prog_lock);
>> +		write_lock_bh(&pkc->blk_fill_in_prog_lock);
>> +		write_unlock_bh(&pkc->blk_fill_in_prog_lock);
>>   	}
>>   
>>   	if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
>> @@ -1021,8 +1021,8 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
>>   		 */
>>   		if (!(status & TP_STATUS_BLK_TMO)) {
>>   			/* Waiting for skb_copy_bits to finish... */
>> -			write_lock(&pkc->blk_fill_in_prog_lock);
>> -			write_unlock(&pkc->blk_fill_in_prog_lock);
>> +			write_lock_bh(&pkc->blk_fill_in_prog_lock);
>> +			write_unlock_bh(&pkc->blk_fill_in_prog_lock);
>>   		}
>>   		prb_close_block(pkc, pbd, po, status);
>>   		return;
>> @@ -1044,7 +1044,7 @@ static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
>>   {
>>   	struct tpacket_kbdq_core *pkc  = GET_PBDQC_FROM_RB(rb);
>>   
>> -	read_unlock(&pkc->blk_fill_in_prog_lock);
>> +	read_unlock_bh(&pkc->blk_fill_in_prog_lock);
>>   }
>>   
>>   static void prb_fill_rxhash(struct tpacket_kbdq_core *pkc,
>> @@ -1105,7 +1105,7 @@ static void prb_fill_curr_block(char *curr,
>>   	pkc->nxt_offset += TOTAL_PKT_LEN_INCL_ALIGN(len);
>>   	BLOCK_LEN(pbd) += TOTAL_PKT_LEN_INCL_ALIGN(len);
>>   	BLOCK_NUM_PKTS(pbd) += 1;
>> -	read_lock(&pkc->blk_fill_in_prog_lock);
>> +	read_lock_bh(&pkc->blk_fill_in_prog_lock);
>>   	prb_run_all_ft_ops(pkc, ppd);
>>   }
>>   
>> @@ -2413,7 +2413,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>   			vnet_hdr_sz = 0;
>>   		}
>>   	}
>> -	spin_lock(&sk->sk_receive_queue.lock);
>> +	spin_lock_bh(&sk->sk_receive_queue.lock);
>>   	h.raw = packet_current_rx_frame(po, skb,
>>   					TP_STATUS_KERNEL, (macoff+snaplen));
>>   	if (!h.raw)
>> @@ -2453,7 +2453,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>   		skb_clear_delivery_time(copy_skb);
>>   		__skb_queue_tail(&sk->sk_receive_queue, copy_skb);
>>   	}
>> -	spin_unlock(&sk->sk_receive_queue.lock);
>> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
>>   
>>   	skb_copy_bits(skb, 0, h.raw + macoff, snaplen);
>>   
>> @@ -2546,10 +2546,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>   #endif
>>   
>>   	if (po->tp_version <= TPACKET_V2) {
>> -		spin_lock(&sk->sk_receive_queue.lock);
>> +		spin_lock_bh(&sk->sk_receive_queue.lock);
>>   		__packet_set_status(po, h.raw, status);
>>   		__clear_bit(slot_id, po->rx_ring.rx_owner_map);
>> -		spin_unlock(&sk->sk_receive_queue.lock);
>> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
>>   		sk->sk_data_ready(sk);
>>   	} else if (po->tp_version == TPACKET_V3) {
>>   		prb_clear_blk_fill_status(&po->rx_ring);
>> @@ -2565,7 +2565,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>   	return 0;
>>   
>>   drop_n_account:
>> -	spin_unlock(&sk->sk_receive_queue.lock);
>> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
>>   	atomic_inc(&po->tp_drops);
>>   	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
>>   
>> -- 
>> 2.42.0
>>
> 
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


