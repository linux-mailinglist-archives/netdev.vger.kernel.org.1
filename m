Return-Path: <netdev+bounces-31781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940A37901EA
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 20:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A961C209A4
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9596C2D7;
	Fri,  1 Sep 2023 18:09:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0EC134
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 18:09:30 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFF92
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 11:09:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bca3588edbso1663834a34.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1693591768; x=1694196568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2i49DufRKSOgePhtC9Aq1qjy6weL4GN6JJVO+yGbZA=;
        b=P57p2Omrd5jACVpRxI1Ku1BqdRN3AWusrNc1DFcx9nl7ayOp791jBsEzf4r1ztI7n4
         i4HOUXuOl+mBhXJeUHensyI5whUhFJk51MdzB6TRbetkMdN5JJYCMp3HhmRdouVAexRf
         lCnM3PuU7pl8HUVfNfqK7P2PM2bWo32+KwN7RComlDzmvOSCK3UliNwZUNl9unN9v1CI
         jJ3+cxHIMp6fEeRRRdy6WiT4PbmxA+Lgd8zh337yTZb+Z2ylttKxBTbrFJe87w9+c0sm
         MsCL+fjs+puKsjd9xDNsVKOybp+p2RvgTzk+/R8YDblmeScoE3LrOsOMga0pVowG2xTG
         1WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693591768; x=1694196568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2i49DufRKSOgePhtC9Aq1qjy6weL4GN6JJVO+yGbZA=;
        b=NAxgo4798fbMJUdMcDL5cWdShdkt1fRzdTFWfh+S1XkwND9fosEapmcasko0nE64b4
         joM9r6cE0hdR2ssBuAv3bMCuZuRoxGpZ5ILwMJZVqD7BA/GOsHugS0ArrunTKS0k0WS2
         PbVWqzEee19IjZwCZESjJuZNi9lg4h+Vd5QZELfM/n3crhTusIrt1uigUE0RI4qxwG1p
         1tzE1zYjM1uK9JfKALTV567o/jzYKslqcvKMqikv0rezsS9NQCer8QtJy+ORrAnH6cp5
         1a22oZ9+dEZj+h2Ca+BgNYBR7kFi1DjuwvCUxJb/kqqiFpAK940s+K/flcM2bwoVSiSd
         Q9vA==
X-Gm-Message-State: AOJu0YzHnR5sXf+z8c3mOeOi+kxHwVG/QydaDNJB+dX24+c0XIZRoj0j
	duHT6Wf+n0fTIi92T2oV00YmUQ==
X-Google-Smtp-Source: AGHT+IGMWgDrwFDaVuJU3ptsvnmYCkVEhwN3xPt1GdGZe/cxpiJnS9uJb5hrTjHwm4b5aRbb/Qz6eA==
X-Received: by 2002:a05:6871:88b:b0:1bf:fd8a:826e with SMTP id r11-20020a056871088b00b001bffd8a826emr3352796oaq.55.1693591767720;
        Fri, 01 Sep 2023 11:09:27 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:ea95:e205:ffa8:bfad? ([2804:14d:5c5e:44fb:ea95:e205:ffa8:bfad])
        by smtp.gmail.com with ESMTPSA id x21-20020a05687031d500b001d0cf6ba822sm2431545oac.53.2023.09.01.11.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 11:09:27 -0700 (PDT)
Message-ID: <39597d43-7522-38e7-1b37-82c4a84158aa@mojatatu.com>
Date: Fri, 1 Sep 2023 15:09:22 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 1/1] net: sched: sch_qfq: Fix UAF in qfq_dequeue()
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 sec@valis.email, paolo.valente@unimore.it
References: <20230901162237.11525-1-jhs@mojatatu.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230901162237.11525-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/09/2023 13:22, Jamal Hadi Salim wrote:
> From: valis <sec@valis.email>
> 
> When the plug qdisc is used as a class of the qfq qdisc it could trigger a
> UAF. This issue can be reproduced with following commands:
> 
>    tc qdisc add dev lo root handle 1: qfq
>    tc class add dev lo parent 1: classid 1:1 qfq weight 1 maxpkt 512
>    tc qdisc add dev lo parent 1:1 handle 2: plug
>    tc filter add dev lo parent 1: basic classid 1:1
>    ping -c1 127.0.0.1

Not sure if net or net-next material, but I would also demote the 
WARN_ON_ONCE
in qfq_dequeue to a pr_warn[0], as it would just crash kernels that set 
panic_on_warn and honestly it's not that bad of a misconfiguration (a 
plain tc qdisc/class del would fix it).

[0] https://elixir.bootlin.com/linux/latest/source/net/sched/sch_qfq.c#L1001

> 
> and boom:
> 
> [  285.353793] BUG: KASAN: slab-use-after-free in qfq_dequeue+0xa7/0x7f0
> [  285.354910] Read of size 4 at addr ffff8880bad312a8 by task ping/144
> [  285.355903]
> [  285.356165] CPU: 1 PID: 144 Comm: ping Not tainted 6.5.0-rc3+ #4
> [  285.357112] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [  285.358376] Call Trace:
> [  285.358773]  <IRQ>
> [  285.359109]  dump_stack_lvl+0x44/0x60
> [  285.359708]  print_address_description.constprop.0+0x2c/0x3c0
> [  285.360611]  kasan_report+0x10c/0x120
> [  285.361195]  ? qfq_dequeue+0xa7/0x7f0
> [  285.361780]  qfq_dequeue+0xa7/0x7f0
> [  285.362342]  __qdisc_run+0xf1/0x970
> [  285.362903]  net_tx_action+0x28e/0x460
> [  285.363502]  __do_softirq+0x11b/0x3de
> [  285.364097]  do_softirq.part.0+0x72/0x90
> [  285.364721]  </IRQ>
> [  285.365072]  <TASK>
> [  285.365422]  __local_bh_enable_ip+0x77/0x90
> [  285.366079]  __dev_queue_xmit+0x95f/0x1550
> [  285.366732]  ? __pfx_csum_and_copy_from_iter+0x10/0x10
> [  285.367526]  ? __pfx___dev_queue_xmit+0x10/0x10
> [  285.368259]  ? __build_skb_around+0x129/0x190
> [  285.368960]  ? ip_generic_getfrag+0x12c/0x170
> [  285.369653]  ? __pfx_ip_generic_getfrag+0x10/0x10
> [  285.370390]  ? csum_partial+0x8/0x20
> [  285.370961]  ? raw_getfrag+0xe5/0x140
> [  285.371559]  ip_finish_output2+0x539/0xa40
> [  285.372222]  ? __pfx_ip_finish_output2+0x10/0x10
> [  285.372954]  ip_output+0x113/0x1e0
> [  285.373512]  ? __pfx_ip_output+0x10/0x10
> [  285.374130]  ? icmp_out_count+0x49/0x60
> [  285.374739]  ? __pfx_ip_finish_output+0x10/0x10
> [  285.375457]  ip_push_pending_frames+0xf3/0x100
> [  285.376173]  raw_sendmsg+0xef5/0x12d0
> [  285.376760]  ? do_syscall_64+0x40/0x90
> [  285.377359]  ? __static_call_text_end+0x136578/0x136578
> [  285.378173]  ? do_syscall_64+0x40/0x90
> [  285.378772]  ? kasan_enable_current+0x11/0x20
> [  285.379469]  ? __pfx_raw_sendmsg+0x10/0x10
> [  285.380137]  ? __sock_create+0x13e/0x270
> [  285.380673]  ? __sys_socket+0xf3/0x180
> [  285.381174]  ? __x64_sys_socket+0x3d/0x50
> [  285.381725]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  285.382425]  ? __rcu_read_unlock+0x48/0x70
> [  285.382975]  ? ip4_datagram_release_cb+0xd8/0x380
> [  285.383608]  ? __pfx_ip4_datagram_release_cb+0x10/0x10
> [  285.384295]  ? preempt_count_sub+0x14/0xc0
> [  285.384844]  ? __list_del_entry_valid+0x76/0x140
> [  285.385467]  ? _raw_spin_lock_bh+0x87/0xe0
> [  285.386014]  ? __pfx__raw_spin_lock_bh+0x10/0x10
> [  285.386645]  ? release_sock+0xa0/0xd0
> [  285.387148]  ? preempt_count_sub+0x14/0xc0
> [  285.387712]  ? freeze_secondary_cpus+0x348/0x3c0
> [  285.388341]  ? aa_sk_perm+0x177/0x390
> [  285.388856]  ? __pfx_aa_sk_perm+0x10/0x10
> [  285.389441]  ? check_stack_object+0x22/0x70
> [  285.390032]  ? inet_send_prepare+0x2f/0x120
> [  285.390603]  ? __pfx_inet_sendmsg+0x10/0x10
> [  285.391172]  sock_sendmsg+0xcc/0xe0
> [  285.391667]  __sys_sendto+0x190/0x230
> [  285.392168]  ? __pfx___sys_sendto+0x10/0x10
> [  285.392727]  ? kvm_clock_get_cycles+0x14/0x30
> [  285.393328]  ? set_normalized_timespec64+0x57/0x70
> [  285.393980]  ? _raw_spin_unlock_irq+0x1b/0x40
> [  285.394578]  ? __x64_sys_clock_gettime+0x11c/0x160
> [  285.395225]  ? __pfx___x64_sys_clock_gettime+0x10/0x10
> [  285.395908]  ? _copy_to_user+0x3e/0x60
> [  285.396432]  ? exit_to_user_mode_prepare+0x1a/0x120
> [  285.397086]  ? syscall_exit_to_user_mode+0x22/0x50
> [  285.397734]  ? do_syscall_64+0x71/0x90
> [  285.398258]  __x64_sys_sendto+0x74/0x90
> [  285.398786]  do_syscall_64+0x64/0x90
> [  285.399273]  ? exit_to_user_mode_prepare+0x1a/0x120
> [  285.399949]  ? syscall_exit_to_user_mode+0x22/0x50
> [  285.400605]  ? do_syscall_64+0x71/0x90
> [  285.401124]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  285.401807] RIP: 0033:0x495726
> [  285.402233] Code: ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 09
> [  285.404683] RSP: 002b:00007ffcc25fb618 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [  285.405677] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 0000000000495726
> [  285.406628] RDX: 0000000000000040 RSI: 0000000002518750 RDI: 0000000000000000
> [  285.407565] RBP: 00000000005205ef R08: 00000000005f8838 R09: 000000000000001c
> [  285.408523] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000002517634
> [  285.409460] R13: 00007ffcc25fb6f0 R14: 0000000000000003 R15: 0000000000000000
> [  285.410403]  </TASK>
> [  285.410704]
> [  285.410929] Allocated by task 144:
> [  285.411402]  kasan_save_stack+0x1e/0x40
> [  285.411926]  kasan_set_track+0x21/0x30
> [  285.412442]  __kasan_slab_alloc+0x55/0x70
> [  285.412973]  kmem_cache_alloc_node+0x187/0x3d0
> [  285.413567]  __alloc_skb+0x1b4/0x230
> [  285.414060]  __ip_append_data+0x17f7/0x1b60
> [  285.414633]  ip_append_data+0x97/0xf0
> [  285.415144]  raw_sendmsg+0x5a8/0x12d0
> [  285.415640]  sock_sendmsg+0xcc/0xe0
> [  285.416117]  __sys_sendto+0x190/0x230
> [  285.416626]  __x64_sys_sendto+0x74/0x90
> [  285.417145]  do_syscall_64+0x64/0x90
> [  285.417624]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  285.418306]
> [  285.418531] Freed by task 144:
> [  285.418960]  kasan_save_stack+0x1e/0x40
> [  285.419469]  kasan_set_track+0x21/0x30
> [  285.419988]  kasan_save_free_info+0x27/0x40
> [  285.420556]  ____kasan_slab_free+0x109/0x1a0
> [  285.421146]  kmem_cache_free+0x1c2/0x450
> [  285.421680]  __netif_receive_skb_core+0x2ce/0x1870
> [  285.422333]  __netif_receive_skb_one_core+0x97/0x140
> [  285.423003]  process_backlog+0x100/0x2f0
> [  285.423537]  __napi_poll+0x5c/0x2d0
> [  285.424023]  net_rx_action+0x2be/0x560
> [  285.424510]  __do_softirq+0x11b/0x3de
> [  285.425034]
> [  285.425254] The buggy address belongs to the object at ffff8880bad31280
> [  285.425254]  which belongs to the cache skbuff_head_cache of size 224
> [  285.426993] The buggy address is located 40 bytes inside of
> [  285.426993]  freed 224-byte region [ffff8880bad31280, ffff8880bad31360)
> [  285.428572]
> [  285.428798] The buggy address belongs to the physical page:
> [  285.429540] page:00000000f4b77674 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbad31
> [  285.430758] flags: 0x100000000000200(slab|node=0|zone=1)
> [  285.431447] page_type: 0xffffffff()
> [  285.431934] raw: 0100000000000200 ffff88810094a8c0 dead000000000122 0000000000000000
> [  285.432757] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
> [  285.433562] page dumped because: kasan: bad access detected
> [  285.434144]
> [  285.434320] Memory state around the buggy address:
> [  285.434828]  ffff8880bad31180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  285.435580]  ffff8880bad31200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  285.436264] >ffff8880bad31280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  285.436777]                                   ^
> [  285.437106]  ffff8880bad31300: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> [  285.437616]  ffff8880bad31380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  285.438126] ==================================================================
> [  285.438662] Disabling lock debugging due to kernel taint
> 
> Fix this by:
> 1. Changing sch_plug's .peek handler to qdisc_peek_dequeued(), a
> function compatible with non-work-conserving qdiscs
> 2. Checking the return value of qdisc_dequeue_peeked() in sch_qfq.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Reported-by: valis <sec@valis.email>
> Signed-off-by: valis <sec@valis.email>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>   net/sched/sch_plug.c |  2 +-
>   net/sched/sch_qfq.c  | 22 +++++++++++++++++-----
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
> index ea8c4a7174bb..35f49edf63db 100644
> --- a/net/sched/sch_plug.c
> +++ b/net/sched/sch_plug.c
> @@ -207,7 +207,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
>   	.priv_size   =       sizeof(struct plug_sched_data),
>   	.enqueue     =       plug_enqueue,
>   	.dequeue     =       plug_dequeue,
> -	.peek        =       qdisc_peek_head,
> +	.peek        =       qdisc_peek_dequeued,
>   	.init        =       plug_init,
>   	.change      =       plug_change,
>   	.reset       =	     qdisc_reset_queue,
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index befaf74b33ca..09d2955baab1 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -974,10 +974,13 @@ static void qfq_update_eligible(struct qfq_sched *q)
>   }
>   
>   /* Dequeue head packet of the head class in the DRR queue of the aggregate. */
> -static void agg_dequeue(struct qfq_aggregate *agg,
> -			struct qfq_class *cl, unsigned int len)
> +static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
> +				   struct qfq_class *cl, unsigned int len)
>   {
> -	qdisc_dequeue_peeked(cl->qdisc);
> +	struct sk_buff *skb = qdisc_dequeue_peeked(cl->qdisc);
> +
> +	if (!skb)
> +		return NULL;
>   
>   	cl->deficit -= (int) len;
>   
> @@ -987,6 +990,8 @@ static void agg_dequeue(struct qfq_aggregate *agg,
>   		cl->deficit += agg->lmax;
>   		list_move_tail(&cl->alist, &agg->active);
>   	}
> +
> +	return skb;
>   }
>   
>   static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
> @@ -1132,11 +1137,18 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>   	if (!skb)
>   		return NULL;
>   
> -	qdisc_qstats_backlog_dec(sch, skb);
>   	sch->q.qlen--;
> +
> +	skb = agg_dequeue(in_serv_agg, cl, len);
> +
> +	if (!skb) {
> +		sch->q.qlen++;
> +		return NULL;
> +	}
> +
> +	qdisc_qstats_backlog_dec(sch, skb);
>   	qdisc_bstats_update(sch, skb);
>   
> -	agg_dequeue(in_serv_agg, cl, len);
>   	/* If lmax is lowered, through qfq_change_class, for a class
>   	 * owning pending packets with larger size than the new value
>   	 * of lmax, then the following condition may hold.

