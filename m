Return-Path: <netdev+bounces-31765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4987900A5
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ED028184B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC9C152;
	Fri,  1 Sep 2023 16:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B7C131
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 16:22:51 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE8E7E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 09:22:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-410ad0ae052so830311cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1693585369; x=1694190169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FrIFRJAaVBrCHWXfC72ydb/mo5/b1J/qqbeoUXbVxc=;
        b=nrg4auegCyguwb1ViTvNuGaCseRJs3yoBNOdNEpSbT5TXRB7CQWOIlWIzwjUzgfY4U
         pfM37VrNTD95QMGGYLXiyxzwAwoqiRRVPcj6jnJ0mujxquk146qLMXeh0ENXmpOiUexC
         zObbouT1OiGEBslDfBqxGVa48vux7JTrML6rHulxsa3ftaY0/YhyRyKjzBhtDBHS9nrT
         2KwxDyEgj3mRRaEz/il0VGDDduFrn+H5zHsQ8kz+dH6xXGhduKXb86YQjmg9C5281I9F
         4+Qm7iLIiOIuFVPsxYRusN6Iq+6k/h6jWM44POOZz+4gWBUYKiQ9Sz19VKPb5Jq0YWO3
         f34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693585369; x=1694190169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FrIFRJAaVBrCHWXfC72ydb/mo5/b1J/qqbeoUXbVxc=;
        b=GYtjm9q4p82g7SFxD32nKnYskO07a1iSdMGZsbZEzrfIe2d2SXwHkVVOGJJTOXHq0M
         oa09EtKEROOkf2VRFQWck0VkB2EkruBvm3XIniQ6Ut731b+SOGk3YfjHJK1DYh57BqSL
         z2f50EBNtZ3bd53j7GcN+3IYLA6LIa3Dc1PImBEQBsHofiNegdO58VRNIkWzhf8oDuoZ
         Cb/ywERjNWygpQP7el6qOUTJqtJxcn8CuLMqSc6qk/Fb3jn17EMPXfQg0KMbrsp4HGtH
         0Sf54WCEXvFdqPMCiUPnb2a1jhpqpndYxT/1P65mqMMniGwU80SVmURxpETgdoSvdKGz
         VW9w==
X-Gm-Message-State: AOJu0YyeLWjwKz73i4SdrDYCtBwgeyqLmQ/DEFMPeOybZDGmujA8AEPP
	iAS4talEvIghO9IiuUvl/zM0mA==
X-Google-Smtp-Source: AGHT+IEpZLwhba+Gr8fZdnk5b4TtrVpmuEifWOyVnj1A1x3QyFq9GEENm/PTSvTvjqpdMuGIHq5BrQ==
X-Received: by 2002:ac8:5c10:0:b0:412:c81:eff3 with SMTP id i16-20020ac85c10000000b004120c81eff3mr8499583qti.15.1693585369032;
        Fri, 01 Sep 2023 09:22:49 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b00410a91e9f26sm1557439qto.20.2023.09.01.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 09:22:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	sec@valis.email,
	paolo.valente@unimore.it,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net: sched: sch_qfq: Fix UAF in qfq_dequeue()
Date: Fri,  1 Sep 2023 12:22:37 -0400
Message-Id: <20230901162237.11525-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: valis <sec@valis.email>

When the plug qdisc is used as a class of the qfq qdisc it could trigger a
UAF. This issue can be reproduced with following commands:

  tc qdisc add dev lo root handle 1: qfq
  tc class add dev lo parent 1: classid 1:1 qfq weight 1 maxpkt 512
  tc qdisc add dev lo parent 1:1 handle 2: plug
  tc filter add dev lo parent 1: basic classid 1:1
  ping -c1 127.0.0.1

and boom:

[  285.353793] BUG: KASAN: slab-use-after-free in qfq_dequeue+0xa7/0x7f0
[  285.354910] Read of size 4 at addr ffff8880bad312a8 by task ping/144
[  285.355903]
[  285.356165] CPU: 1 PID: 144 Comm: ping Not tainted 6.5.0-rc3+ #4
[  285.357112] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[  285.358376] Call Trace:
[  285.358773]  <IRQ>
[  285.359109]  dump_stack_lvl+0x44/0x60
[  285.359708]  print_address_description.constprop.0+0x2c/0x3c0
[  285.360611]  kasan_report+0x10c/0x120
[  285.361195]  ? qfq_dequeue+0xa7/0x7f0
[  285.361780]  qfq_dequeue+0xa7/0x7f0
[  285.362342]  __qdisc_run+0xf1/0x970
[  285.362903]  net_tx_action+0x28e/0x460
[  285.363502]  __do_softirq+0x11b/0x3de
[  285.364097]  do_softirq.part.0+0x72/0x90
[  285.364721]  </IRQ>
[  285.365072]  <TASK>
[  285.365422]  __local_bh_enable_ip+0x77/0x90
[  285.366079]  __dev_queue_xmit+0x95f/0x1550
[  285.366732]  ? __pfx_csum_and_copy_from_iter+0x10/0x10
[  285.367526]  ? __pfx___dev_queue_xmit+0x10/0x10
[  285.368259]  ? __build_skb_around+0x129/0x190
[  285.368960]  ? ip_generic_getfrag+0x12c/0x170
[  285.369653]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  285.370390]  ? csum_partial+0x8/0x20
[  285.370961]  ? raw_getfrag+0xe5/0x140
[  285.371559]  ip_finish_output2+0x539/0xa40
[  285.372222]  ? __pfx_ip_finish_output2+0x10/0x10
[  285.372954]  ip_output+0x113/0x1e0
[  285.373512]  ? __pfx_ip_output+0x10/0x10
[  285.374130]  ? icmp_out_count+0x49/0x60
[  285.374739]  ? __pfx_ip_finish_output+0x10/0x10
[  285.375457]  ip_push_pending_frames+0xf3/0x100
[  285.376173]  raw_sendmsg+0xef5/0x12d0
[  285.376760]  ? do_syscall_64+0x40/0x90
[  285.377359]  ? __static_call_text_end+0x136578/0x136578
[  285.378173]  ? do_syscall_64+0x40/0x90
[  285.378772]  ? kasan_enable_current+0x11/0x20
[  285.379469]  ? __pfx_raw_sendmsg+0x10/0x10
[  285.380137]  ? __sock_create+0x13e/0x270
[  285.380673]  ? __sys_socket+0xf3/0x180
[  285.381174]  ? __x64_sys_socket+0x3d/0x50
[  285.381725]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  285.382425]  ? __rcu_read_unlock+0x48/0x70
[  285.382975]  ? ip4_datagram_release_cb+0xd8/0x380
[  285.383608]  ? __pfx_ip4_datagram_release_cb+0x10/0x10
[  285.384295]  ? preempt_count_sub+0x14/0xc0
[  285.384844]  ? __list_del_entry_valid+0x76/0x140
[  285.385467]  ? _raw_spin_lock_bh+0x87/0xe0
[  285.386014]  ? __pfx__raw_spin_lock_bh+0x10/0x10
[  285.386645]  ? release_sock+0xa0/0xd0
[  285.387148]  ? preempt_count_sub+0x14/0xc0
[  285.387712]  ? freeze_secondary_cpus+0x348/0x3c0
[  285.388341]  ? aa_sk_perm+0x177/0x390
[  285.388856]  ? __pfx_aa_sk_perm+0x10/0x10
[  285.389441]  ? check_stack_object+0x22/0x70
[  285.390032]  ? inet_send_prepare+0x2f/0x120
[  285.390603]  ? __pfx_inet_sendmsg+0x10/0x10
[  285.391172]  sock_sendmsg+0xcc/0xe0
[  285.391667]  __sys_sendto+0x190/0x230
[  285.392168]  ? __pfx___sys_sendto+0x10/0x10
[  285.392727]  ? kvm_clock_get_cycles+0x14/0x30
[  285.393328]  ? set_normalized_timespec64+0x57/0x70
[  285.393980]  ? _raw_spin_unlock_irq+0x1b/0x40
[  285.394578]  ? __x64_sys_clock_gettime+0x11c/0x160
[  285.395225]  ? __pfx___x64_sys_clock_gettime+0x10/0x10
[  285.395908]  ? _copy_to_user+0x3e/0x60
[  285.396432]  ? exit_to_user_mode_prepare+0x1a/0x120
[  285.397086]  ? syscall_exit_to_user_mode+0x22/0x50
[  285.397734]  ? do_syscall_64+0x71/0x90
[  285.398258]  __x64_sys_sendto+0x74/0x90
[  285.398786]  do_syscall_64+0x64/0x90
[  285.399273]  ? exit_to_user_mode_prepare+0x1a/0x120
[  285.399949]  ? syscall_exit_to_user_mode+0x22/0x50
[  285.400605]  ? do_syscall_64+0x71/0x90
[  285.401124]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  285.401807] RIP: 0033:0x495726
[  285.402233] Code: ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 09
[  285.404683] RSP: 002b:00007ffcc25fb618 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  285.405677] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 0000000000495726
[  285.406628] RDX: 0000000000000040 RSI: 0000000002518750 RDI: 0000000000000000
[  285.407565] RBP: 00000000005205ef R08: 00000000005f8838 R09: 000000000000001c
[  285.408523] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000002517634
[  285.409460] R13: 00007ffcc25fb6f0 R14: 0000000000000003 R15: 0000000000000000
[  285.410403]  </TASK>
[  285.410704]
[  285.410929] Allocated by task 144:
[  285.411402]  kasan_save_stack+0x1e/0x40
[  285.411926]  kasan_set_track+0x21/0x30
[  285.412442]  __kasan_slab_alloc+0x55/0x70
[  285.412973]  kmem_cache_alloc_node+0x187/0x3d0
[  285.413567]  __alloc_skb+0x1b4/0x230
[  285.414060]  __ip_append_data+0x17f7/0x1b60
[  285.414633]  ip_append_data+0x97/0xf0
[  285.415144]  raw_sendmsg+0x5a8/0x12d0
[  285.415640]  sock_sendmsg+0xcc/0xe0
[  285.416117]  __sys_sendto+0x190/0x230
[  285.416626]  __x64_sys_sendto+0x74/0x90
[  285.417145]  do_syscall_64+0x64/0x90
[  285.417624]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  285.418306]
[  285.418531] Freed by task 144:
[  285.418960]  kasan_save_stack+0x1e/0x40
[  285.419469]  kasan_set_track+0x21/0x30
[  285.419988]  kasan_save_free_info+0x27/0x40
[  285.420556]  ____kasan_slab_free+0x109/0x1a0
[  285.421146]  kmem_cache_free+0x1c2/0x450
[  285.421680]  __netif_receive_skb_core+0x2ce/0x1870
[  285.422333]  __netif_receive_skb_one_core+0x97/0x140
[  285.423003]  process_backlog+0x100/0x2f0
[  285.423537]  __napi_poll+0x5c/0x2d0
[  285.424023]  net_rx_action+0x2be/0x560
[  285.424510]  __do_softirq+0x11b/0x3de
[  285.425034]
[  285.425254] The buggy address belongs to the object at ffff8880bad31280
[  285.425254]  which belongs to the cache skbuff_head_cache of size 224
[  285.426993] The buggy address is located 40 bytes inside of
[  285.426993]  freed 224-byte region [ffff8880bad31280, ffff8880bad31360)
[  285.428572]
[  285.428798] The buggy address belongs to the physical page:
[  285.429540] page:00000000f4b77674 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbad31
[  285.430758] flags: 0x100000000000200(slab|node=0|zone=1)
[  285.431447] page_type: 0xffffffff()
[  285.431934] raw: 0100000000000200 ffff88810094a8c0 dead000000000122 0000000000000000
[  285.432757] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
[  285.433562] page dumped because: kasan: bad access detected
[  285.434144]
[  285.434320] Memory state around the buggy address:
[  285.434828]  ffff8880bad31180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  285.435580]  ffff8880bad31200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  285.436264] >ffff8880bad31280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  285.436777]                                   ^
[  285.437106]  ffff8880bad31300: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  285.437616]  ffff8880bad31380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  285.438126] ==================================================================
[  285.438662] Disabling lock debugging due to kernel taint

Fix this by:
1. Changing sch_plug's .peek handler to qdisc_peek_dequeued(), a
function compatible with non-work-conserving qdiscs
2. Checking the return value of qdisc_dequeue_peeked() in sch_qfq.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: valis <sec@valis.email>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_plug.c |  2 +-
 net/sched/sch_qfq.c  | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index ea8c4a7174bb..35f49edf63db 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -207,7 +207,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.priv_size   =       sizeof(struct plug_sched_data),
 	.enqueue     =       plug_enqueue,
 	.dequeue     =       plug_dequeue,
-	.peek        =       qdisc_peek_head,
+	.peek        =       qdisc_peek_dequeued,
 	.init        =       plug_init,
 	.change      =       plug_change,
 	.reset       =	     qdisc_reset_queue,
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index befaf74b33ca..09d2955baab1 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -974,10 +974,13 @@ static void qfq_update_eligible(struct qfq_sched *q)
 }
 
 /* Dequeue head packet of the head class in the DRR queue of the aggregate. */
-static void agg_dequeue(struct qfq_aggregate *agg,
-			struct qfq_class *cl, unsigned int len)
+static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
+				   struct qfq_class *cl, unsigned int len)
 {
-	qdisc_dequeue_peeked(cl->qdisc);
+	struct sk_buff *skb = qdisc_dequeue_peeked(cl->qdisc);
+
+	if (!skb)
+		return NULL;
 
 	cl->deficit -= (int) len;
 
@@ -987,6 +990,8 @@ static void agg_dequeue(struct qfq_aggregate *agg,
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
+
+	return skb;
 }
 
 static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
@@ -1132,11 +1137,18 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 	if (!skb)
 		return NULL;
 
-	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
+
+	skb = agg_dequeue(in_serv_agg, cl, len);
+
+	if (!skb) {
+		sch->q.qlen++;
+		return NULL;
+	}
+
+	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
-	agg_dequeue(in_serv_agg, cl, len);
 	/* If lmax is lowered, through qfq_change_class, for a class
 	 * owning pending packets with larger size than the new value
 	 * of lmax, then the following condition may hold.
-- 
2.34.1


