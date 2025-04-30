Return-Path: <netdev+bounces-187099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E312AA4F28
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEF9170D26
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75F19B3CB;
	Wed, 30 Apr 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sU+JyVq5"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7764199947
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024912; cv=none; b=ChfdBCkAqVMssyfSygzQWytqZPJhZo/HuuR2LuwjUJSuurFTM2aFVa59DizGvd9XzjodOh5z/GektjPWcO+vye22MkmuWIGIqY7psRgXUPhyAwzspTwjitFeIZJc8DahdIxpR+L5RBNPjzx0A7yMznRAYXgdQ2sePdENmTw0G/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024912; c=relaxed/simple;
	bh=WEEySaso6uZb9JJfCQDvLpBqYU9M4MXTxC6vCaAtrrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osrFMTfwVAxJMBK82/4KWn4ArIztu/UuVRprsnT2/vzzDcK7nZa9b5ybR/9ZMJ6FVAe+k0eHW9CdRB6fk6tIWUaJ5WO+lpWgDkKlRB39qIL45dBKBuLWpv2IGAmKp8qi3a09lAhVYsszBI3oZt6PxcYojjtfQ+qGfRO1Mwy1IFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sU+JyVq5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9119edd-69d3-4b0e-a7b3-03417db5fed8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746024907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W49DqB7i0H50EzhKyKdUBNDB+WMQqemrOE0YgL9+MgU=;
	b=sU+JyVq5MsC8zlSv8PyGQAicxrArBAj3dnsnn1ncICPOOly7lMkqyG4ArKIFX64R+lEK67
	+ehJDqX/av3Rv7GOGJECjaGNgwYj5yAX2sj6PAigX3vgcyhjlkvK1UaNXoV8xdD0LXaZfp
	zfPMYZxRLXuYxmUnD/0+R8jsWn/+gFc=
Date: Wed, 30 Apr 2025 15:55:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] bnxt_en: improve TX timestamping FIFO
 configuration
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250424125547.460632-1-vadfed@meta.com>
 <CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30/04/2025 13:59, Taehee Yoo wrote:
> On Thu, Apr 24, 2025 at 10:11 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
> 
> Hi Vadim,
> Thanks for this work!
> 
>> Reconfiguration of netdev may trigger close/open procedure which can
>> break FIFO status by adjusting the amount of empty slots for TX
>> timestamps. But it is not really needed because timestamps for the
>> packets sent over the wire still can be retrieved. On the other side,
>> during netdev close procedure any skbs waiting for TX timestamps can be
>> leaked because there is no cleaning procedure called. Free skbs waiting
>> for TX timestamps when closing netdev.
>>
>> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
>> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>> v3 -> v4:
>> * actually remove leftover unused variable in bnxt_ptp_clear()
>> (v3 was not committed before preparing unfortunately)
>> v2 -> v3:
>> * remove leftover unused variable in bnxt_ptp_clear()
>> v1 -> v2:
>> * move clearing of TS skbs to bnxt_free_tx_skbs
>> * remove spinlock as no TX is possible after bnxt_tx_disable()
>> * remove extra FIFO clearing in bnxt_ptp_clear()
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++++-----
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>>   3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index c8e3468eee61..2c8e2c19d854 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
>>
>>                  bnxt_free_one_tx_ring_skbs(bp, txr, i);
>>          }
>> +
>> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
>> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
>>   }
>>
>>   static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
>> @@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
>>          /* VF-reps may need to be re-opened after the PF is re-opened */
>>          if (BNXT_PF(bp))
>>                  bnxt_vf_reps_open(bp);
>> -       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
>> -               WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
>>          bnxt_ptp_init_rtc(bp, true);
>>          bnxt_ptp_cfg_tstamp_filters(bp);
>>          if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index 2d4e19b96ee7..0669d43472f5 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
>>          return HZ;
>>   }
>>
>> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
>> +{
>> +       struct bnxt_ptp_tx_req *txts_req;
>> +       u16 cons = ptp->txts_cons;
>> +
>> +       /* make sure ptp aux worker finished with
>> +        * possible BNXT_STATE_OPEN set
>> +        */
>> +       ptp_cancel_worker_sync(ptp->ptp_clock);
>> +
>> +       ptp->tx_avail = BNXT_MAX_TX_TS;
>> +       while (cons != ptp->txts_prod) {
>> +               txts_req = &ptp->txts_req[cons];
>> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
>> +                       dev_kfree_skb_any(txts_req->tx_skb);
>> +               cons = NEXT_TXTS(cons);
>> +       }
>> +       ptp->txts_cons = cons;
>> +       ptp_schedule_worker(ptp->ptp_clock, 0);
>> +}
>> +
>>   int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
>>   {
>>          spin_lock_bh(&ptp->ptp_tx_lock);
>> @@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
>>   void bnxt_ptp_clear(struct bnxt *bp)
>>   {
>>          struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>> -       int i;
>>
>>          if (!ptp)
>>                  return;
>> @@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
>>          kfree(ptp->ptp_info.pin_config);
>>          ptp->ptp_info.pin_config = NULL;
>>
>> -       for (i = 0; i < BNXT_MAX_TX_TS; i++) {
>> -               if (ptp->txts_req[i].tx_skb) {
>> -                       dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
>> -                       ptp->txts_req[i].tx_skb = NULL;
>> -               }
>> -       }
>> -
>>          bnxt_unmap_ptp_regs(bp);
>>   }
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> index a95f05e9c579..0481161d26ef 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>> @@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
>>   void bnxt_ptp_reapply_pps(struct bnxt *bp);
>>   int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
>>   int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
>> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
>>   int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
>>   void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
>>   int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
>> --
>> 2.47.1
>>
>>
> 
> I’ve encountered a kernel panic that I think is related to this patch.
> Could you please investigate it?
> 
> Reproducer:
>      ip link set $interface up
>      modprobe -rv bnxt_en
> 

Hi Taehee!

Yeah, looks like there are some issues on the remove path.
Could you please test the diff which may fix the problem:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 78e496b0ec26..86a5de44b6f3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)

         bnxt_rdma_aux_device_del(bp);

-       bnxt_ptp_clear(bp);
         unregister_netdev(dev);
+       bnxt_ptp_clear(bp);

         bnxt_rdma_aux_device_uninit(bp);


> Splat looks like:
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc00000000fd:I
> KASAN: null-ptr-deref in range [0x00000000000007e8-0x00000000000007ef]
> CPU: 2 UID: 0 PID: 1963 Comm: modprobe Not tainted 6.15.0-rc3+ #5
> PREEMPT(undef)  78b5b
> RIP: 0010:__kthread_cancel_work_sync (/kernel/kthread.c:1476)
> Code: 00 48 b8 00 00 00 00 00 fc ff df 41 57 4c 8d 7f 18 41 56 4c 89
> fa 41 55 48 c1 ea4
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   00 48 b8                add    %cl,-0x48(%rax)
>     3:   00 00                   add    %al,(%rax)
>     5:   00 00                   add    %al,(%rax)
>     7:   00 fc                   add    %bh,%ah
>     9:   ff                      (bad)
>     a:   df 41 57                filds  0x57(%rcx)
>     d:   4c 8d 7f 18             lea    0x18(%rdi),%r15
>    11:   41 56                   push   %r14
>    13:   4c 89 fa                mov    %r15,%rdx
>    16:   41 55                   push   %r13
>    18:   48                      rex.W
>    19:   c1                      .byte 0xc1
>    1a:   a4                      movsb  %ds:(%rsi),%es:(%rdi)
> RSP: 0018:ffff888111857608 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: 00000000000007d0 RCX: ffff8881330ece8e
> RDX: 00000000000000fd RSI: 0000000000000001 RDI: 00000000000007d0
> RBP: ffff888198ad8e00 R08: 0000000000000001 R09: ffff888198b800d8
> R10: ffff888198b8019f R11: 0000000000000000 R12: ffff888198ad9008
> R13: 0000000000000001 R14: ffff888198ad8e88 R15: 00000000000007e8
> FS:  00007f831f921080(0000) GS:ffff888888405000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005655646882e0 CR3: 000000014c52e000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
> bnxt_ptp_free_txts_skbs
> (/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:807) bnxt_en
> __bnxt_close_nic.constprop.0
> (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:3513
> /drivers/net/ethernet/broadcom/bnxt/bnxt.c:3523
> /drivers/net/ethernet/broadcom/bnxt/bnxt.c:12965) bnxt_en
> ? __lock_acquire (/kernel/locking/lockdep.c:5246)
> ? __pfx___bnxt_close_nic.constprop.0
> (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12940) bnxt_en
> bnxt_close_nic (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12980) bnxt_en
> ? do_raw_spin_trylock (/./arch/x86/include/asm/atomic.h:107
> /./include/linux/atomic/atomic-arch-fallback.h:2170
> /./include/linux/atomic/atomic-instrumented.h:1302
> /./include/asm-generic/qspinlock.h:97
> /kernel/locking/spinlock_debug.c:123)
> ? __pfx_bnxt_close_nic
> (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12980) bnxt_en
> ? __local_bh_enable_ip (/./arch/x86/include/asm/irqflags.h:42
> /./arch/x86/include/asm/irqflags.h:119 /kernel/softirq.c:412)
> ? lockdep_hardirqs_on (/./arch/x86/include/generated/asm/syscalls_64.h:316)
> ? dev_deactivate_many (/net/sched/sch_generic.c:1325
> /net/sched/sch_generic.c:1383)
> ? __local_bh_enable_ip (/./arch/x86/include/asm/irqflags.h:42
> /./arch/x86/include/asm/irqflags.h:119 /kernel/softirq.c:412)
> bnxt_close (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:12215
> /drivers/net/ethernet/broadcom/bnxt/bnxt.c:13015) bnxt_en
> ? __pfx_bnxt_close (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:13011) bnxt_en
> ? notifier_call_chain (/kernel/notifier.c:85)
> __dev_close_many (/net/core/dev.c:1702)
> ? __pfx___dev_close_many (/net/core/dev.c:1663)
> ? __pfx___mutex_lock (/arch/x86/entry/syscall_32.c:46)
> dev_close_many (/net/core/dev.c:1729)
> ? __pfx_dev_close_many (/net/core/dev.c:1719)
> unregister_netdevice_many_notify (/net/core/dev.c:11946)
> ? rcu_is_watching (/./include/linux/context_tracking.h:128
> /kernel/rcu/tree.c:736)
> ? __mutex_lock (/arch/x86/entry/syscall_32.c:46)
> ? __pfx_unregister_netdevice_many_notify (/net/core/dev.c:11909)
> ? rtnl_net_dev_lock (/net/core/dev.c:2093)
> ? __pfx___mutex_lock (/arch/x86/entry/syscall_32.c:46)
> unregister_netdevice_queue (/net/core/dev.c:11891)
> ? __pfx_unregister_netdevice_queue (/net/core/dev.c:11880)
> ? rtnl_net_dev_lock (/./include/linux/rcupdate.h:331
> /./include/linux/rcupdate.h:841 /net/core/dev.c:2084)
> ? rtnl_net_dev_lock (/net/core/dev.c:2093)
> unregister_netdev (/./include/net/net_namespace.h:409
> /./include/linux/netdevice.h:2708 /net/core/dev.c:2104
> /net/core/dev.c:12065)
> bnxt_remove_one (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:16012) bnxt_en
> pci_device_remove (/drivers/pci/pci-driver.c:474)
> device_release_driver_internal (/drivers/base/dd.c:1275 /drivers/base/dd.c:1296)
> driver_detach (/drivers/base/dd.c:1360)
> bus_remove_driver (/drivers/base/bus.c:748)
> pci_unregister_driver (/./include/linux/spinlock.h:351
> /drivers/pci/pci-driver.c:85 /drivers/pci/pci-driver.c:1465)
> bnxt_exit (/drivers/net/ethernet/broadcom/bnxt/bnxt.c:1588) bnxt_en
> __do_sys_delete_module.constprop.0 (/kernel/module/main.c:781)
> ? __pfx___do_sys_delete_module.constprop.0 (/kernel/module/main.c:724)
> ? __pfx_rseq_syscall (/kernel/rseq.c:458)
> ? ksys_write (/fs/read_write.c:736)
> ? __pfx_ksys_write (/fs/read_write.c:726)
> ? rcu_is_watching (/./include/linux/context_tracking.h:128
> /kernel/rcu/tree.c:736)
> ? do_syscall_64 (/./include/trace/events/initcall.h:10)
> do_syscall_64 (/./include/trace/events/initcall.h:10)
> entry_SYSCALL_64_after_hwframe (/./include/trace/events/initcall.h:27)
> RIP: 0033:0x7f831f12ac9b
> Code: 73 01 c3 48 8b 0d 7d 81 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> 2e 0f 1f 84 00 008
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   73 01                   jae    0x3
>     2:   c3                      ret
>     3:   48 8b 0d 7d 81 0d 00    mov    0xd817d(%rip),%rcx        # 0xd8187
>     a:   f7 d8                   neg    %eax
>     c:   64 89 01                mov    %eax,%fs:(%rcx)
>     f:   48 83 c8 ff             or     $0xffffffffffffffff,%rax
>    13:   c3                      ret
>    14:   66                      data16
>    15:   2e                      cs
>    16:   0f                      .byte 0xf
>    17:   1f                      (bad)
>    18:   84 00                   test   %al,(%rax)
>    1a:   08                      .byte 0x8
> RSP: 002b:00007ffdfb651448 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000055fb93ae5fa0 RCX: 00007f831f12ac9b
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055fb93ae6008
> RBP: 00007ffdfb651470 R08: 0000000000000073 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000000
> R13: 00007ffdfb6514a0 R14: 0000000000000000 R15: 0000000000000000
> </TASK>
> Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
> xt_MASQUERADE nf_c]
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__kthread_cancel_work_sync (/kernel/kthread.c:1476)
> Code: 00 48 b8 00 00 00 00 00 fc ff df 41 57 4c 8d 7f 18 41 56 4c 89
> fa 41 55 48 c1 ea4
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   00 48 b8                add    %cl,-0x48(%rax)
>     3:   00 00                   add    %al,(%rax)
>     5:   00 00                   add    %al,(%rax)
>     7:   00 fc                   add    %bh,%ah
>     9:   ff                      (bad)
>     a:   df 41 57                filds  0x57(%rcx)
>     d:   4c 8d 7f 18             lea    0x18(%rdi),%r15
>    11:   41 56                   push   %r14
>    13:   4c 89 fa                mov    %r15,%rdx
>    16:   41 55                   push   %r13
>    18:   48                      rex.W
>    19:   c1                      .byte 0xc1
>    1a:   a4                      movsb  %ds:(%rsi),%es:(%rdi)
> RSP: 0018:ffff888111857608 EFLAGS: 00010292
> RAX: dffffc0000000000 RBX: 00000000000007d0 RCX: ffff8881330ece8e
> RDX: 00000000000000fd RSI: 0000000000000001 RDI: 00000000000007d0
> RBP: ffff888198ad8e00 R08: 0000000000000001 R09: ffff888198b800d8
> R10: ffff888198b8019f R11: 0000000000000000 R12: ffff888198ad9008
> R13: 0000000000000001 R14: ffff888198ad8e88 R15: 00000000000007e8
> FS:  00007f831f921080(0000) GS:ffff888888405000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005655646882e0 CR3: 000000014c52e000 CR4: 00000000007506f0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x6000000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000)
> 
> Thanks a lot!
> Taehee Yoo


