Return-Path: <netdev+bounces-31363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440F78D508
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9754281302
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B82103;
	Wed, 30 Aug 2023 10:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0741C08
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 10:12:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBF1B0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 03:12:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d72403b9e03so6066916276.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693390366; x=1693995166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c71ImQV1EBmd4qWegaNV2q8RhJ05KLjPe6OmoS6eTTY=;
        b=e9ld3LGxEB47qMcQJZe6Mb6+rS7oIXHvBr8ercVOHxaz98BmvnYU/Adu1qkkFsmvtn
         TH3fC7D8OGv/vNtAAa5gaPpvDAE+xTrZVcUccZDAemwTwIrhnoo3t8lV5XXky65rqS9e
         ClOkQEXgMSL7A4UZctylVQLdy/zQGACVNwFpAz2qdBEk40/wbPVMBeyWx6WlB39o16gL
         qO9RDM21yLtnhy0X03+o8BiO6TuSmWV2UGFSIyOhjvwzJgh8r3fV2oWUvfiycr2SHdTh
         LwuHfNS7bsIcxWCCjnD+QY2B4wPViBaUSYQz2hiKC2w2IsP2Av0idAvQkZOJ/PykDY+3
         7LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390366; x=1693995166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c71ImQV1EBmd4qWegaNV2q8RhJ05KLjPe6OmoS6eTTY=;
        b=Tb6bwE1QN+O0oVxd8QgBNxeZDJob8hzxfb3/AtMGoSjR4cW53zt6Nhibx6RI9n8Q7s
         DtnTfyrcjXkHcaVOokTPdhxBcqKF5iC7SjDHsCPUu60Qo3S9fAPSFv+8PS+lni5Aj8Jj
         tmmKkMe5amPP4qnUrNTUSEjy6yu5rDv6uT2IMhOiTqi6iLuGh68cZRVVI4OE9YnrMsHh
         Po8DUGS38jqxd9PoUZuoRMZDMqceWvn5ozeORssdDb8Tw9cXiYpAxYfq2es7GNJ+q/rZ
         zOiG4Z97nTJ7eng/WHfyHtEVr3XBMoRR831R0SUBbVWOzNhQcUQm+9rsX44taqxUlDTV
         90uw==
X-Gm-Message-State: AOJu0YzYHKH1dLymSEqxRd46cZkxvlW1lHXswX1WDQhyRosm/v1hHjqY
	Nus8VmtFYUh943QrKV8RXvdNccTHONmT7Q==
X-Google-Smtp-Source: AGHT+IHguaEWJtoT6/c6rdhMFxzmmSmOCYbWKDHDclBmCmwb/clzlEYEgpb5Z8/IxO/Qx8DG389Yw8KaNeaVUw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4146:0:b0:d78:215f:ba5f with SMTP id
 o67-20020a254146000000b00d78215fba5fmr48997yba.9.1693390366264; Wed, 30 Aug
 2023 03:12:46 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:12:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830101244.1146934-1-edumazet@google.com>
Subject: [PATCH v2 net] net: read sk->sk_family once in sk_mc_loop()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot is playing with IPV6_ADDRFORM quite a lot these days,
and managed to hit the WARN_ON_ONCE(1) in sk_mc_loop()

We have many more similar issues to fix.

WARNING: CPU: 1 PID: 1593 at net/core/sock.c:782 sk_mc_loop+0x165/0x260
Modules linked in:
CPU: 1 PID: 1593 Comm: kworker/1:3 Not tainted 6.1.40-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_power_efficient gc_worker
RIP: 0010:sk_mc_loop+0x165/0x260 net/core/sock.c:782
Code: 34 1b fd 49 81 c7 18 05 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ff e8 25 36 6d fd 4d 8b 37 eb 13 e8 db 33 1b fd <0f> 0b b3 01 eb 34 e8 d0 33 1b fd 45 31 f6 49 83 c6 38 4c 89 f0 48
RSP: 0018:ffffc90000388530 EFLAGS: 00010246
RAX: ffffffff846d9b55 RBX: 0000000000000011 RCX: ffff88814f884980
RDX: 0000000000000102 RSI: ffffffff87ae5160 RDI: 0000000000000011
RBP: ffffc90000388550 R08: 0000000000000003 R09: ffffffff846d9a65
R10: 0000000000000002 R11: ffff88814f884980 R12: dffffc0000000000
R13: ffff88810dbee000 R14: 0000000000000010 R15: ffff888150084000
FS: 0000000000000000(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 000000014ee5b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<IRQ>
[<ffffffff8507734f>] ip6_finish_output2+0x33f/0x1ae0 net/ipv6/ip6_output.c:83
[<ffffffff85062766>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inline]
[<ffffffff85062766>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:211
[<ffffffff85061f8c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
[<ffffffff85061f8c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
[<ffffffff852071cf>] dst_output include/net/dst.h:444 [inline]
[<ffffffff852071cf>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
[<ffffffff83618fb4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline]
[<ffffffff83618fb4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline]
[<ffffffff83618fb4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
[<ffffffff83618fb4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/ipvlan_core.c:677
[<ffffffff8361ddd9>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvlan_main.c:229
[<ffffffff84763fc0>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
[<ffffffff84763fc0>] xmit_one net/core/dev.c:3644 [inline]
[<ffffffff84763fc0>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
[<ffffffff8494c650>] sch_direct_xmit+0x2a0/0x9c0 net/sched/sch_generic.c:342
[<ffffffff8494d883>] qdisc_restart net/sched/sch_generic.c:407 [inline]
[<ffffffff8494d883>] __qdisc_run+0xb13/0x1e70 net/sched/sch_generic.c:415
[<ffffffff8478c426>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
[<ffffffff84796eac>] net_tx_action+0x7ac/0x940 net/core/dev.c:5247
[<ffffffff858002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:599
[<ffffffff814c3fe8>] invoke_softirq kernel/softirq.c:430 [inline]
[<ffffffff814c3fe8>] __irq_exit_rcu+0xc8/0x170 kernel/softirq.c:683
[<ffffffff814c3f09>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:695

Fixes: 7ad6848c7e81 ("ip: fix mc_loop checks for tunnels with multicast outer addresses")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: rebase on latest net tree

 net/core/sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 666a17cab4f5605076af3f929864d03bc5e90058..b0dd501dabd6a86aeda148007faf35c3c50a2bba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -765,7 +765,8 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	switch (sk->sk_family) {
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


