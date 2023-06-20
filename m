Return-Path: <netdev+bounces-12390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B713973747F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87872813F6
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BADFC01;
	Tue, 20 Jun 2023 18:44:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D2AB23
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:44:29 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C495
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 11:44:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-570022400b9so62814027b3.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687286667; x=1689878667;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERHX9zF4HTb2DPCzSVHZJCIl0rY8psKRRy4j7nw6pzk=;
        b=gwjA9nfsVQF07oHhMumyyvb5qZcfkuUFSyBafWr9Mo0ON/S9JVJNZjDoB3KmE/03xo
         r/qmDHkvz7JUfqcf37FCmTUpm8rHK8aVVG7xPJo+LSvWSHyRxorr8T28PIPfd1864Ih+
         a3RpTjhEb9KtujgX9VXrp1JEGxUjik9KlBZ5frmR50PjeolictOxadvREOnJYoGgh3kv
         gM6x3v2PwVvGbroJJhqKjZfwgdrtzxwGQff7J4CQnXgCOT0YsCUiQ8F4lXO1sVo9Fxvv
         dmolY2KmKNBLofqL9qi3n+hLZ++UMgq6xE/kgNjiRIE/VkPMdIWtQSBKtHqyucjWGN3G
         PlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286667; x=1689878667;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERHX9zF4HTb2DPCzSVHZJCIl0rY8psKRRy4j7nw6pzk=;
        b=fOaNIRbB7thlLgiNE24ojH/QrqZi/POy1SEE5UV0nxhCpIgZb/NtJ0ZqBJ7mkVB/Vg
         0y671jUjHOm9DJOk+gYPySx1Ka36v64BZm99NB0J1w7UvOwxsKlG8yg8sRsfVnwKcdI2
         YgjHoNeijXE/pPeAZZpA9eWnw3BUIx2Us1ElkGQ4Y+VJNAhDMZ4nCAUKkBbfokasLwQ+
         uuposxAaOPBZvgUKbnEk278SNFWLZIRI2fMsbcRIyvIvTnt8BiZ9vYdM5V09O78u/F0H
         Z3N67Nbptw+PKoFMQ0f60KDFXghkka8Eb1A7OD3VAN0w8uWzMFwAXMXvgeC7NxEmOLkl
         zo7w==
X-Gm-Message-State: AC+VfDx6QEBjFYZwxz9ZcC20cPIO1neSM8VnRRZEffgIop5OSxaj1gmr
	cGhJkK1BiZKuGdnnCzRnpxQg0IX2r/vtKg==
X-Google-Smtp-Source: ACHHUZ4TrKhbuHvNX6ty3cByNB1j1pbUTw9jHV5OP8Y0Z4sLRLEXYxneJm8FTYivuxJfD3x1dNHzlFCXdYUwgA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ad0e:0:b0:570:7b63:55cc with SMTP id
 l14-20020a81ad0e000000b005707b6355ccmr4852170ywh.9.1687286667309; Tue, 20 Jun
 2023 11:44:27 -0700 (PDT)
Date: Tue, 20 Jun 2023 18:44:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230620184425.1179809-1-edumazet@google.com>
Subject: [PATCH net] sch_netem: acquire qdisc lock in netem_change()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot managed to trigger a divide error [1] in netem.

It could happen if q->rate changes while netem_enqueue()
is running, since q->rate is read twice.

It turns out netem_change() always lacked proper synchronization.

[1]
divide error: 0000 [#1] SMP KASAN
CPU: 1 PID: 7867 Comm: syz-executor.1 Not tainted 6.1.30-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
RIP: 0010:packet_time_ns net/sched/sch_netem.c:357 [inline]
RIP: 0010:netem_enqueue+0x2067/0x36d0 net/sched/sch_netem.c:576
Code: 89 e2 48 69 da 00 ca 9a 3b 42 80 3c 28 00 4c 8b a4 24 88 00 00 00 74 0d 4c 89 e7 e8 c3 4f 3b fd 48 8b 4c 24 18 48 89 d8 31 d2 <49> f7 34 24 49 01 c7 4c 8b 64 24 48 4d 01 f7 4c 89 e3 48 c1 eb 03
RSP: 0018:ffffc9000dccea60 EFLAGS: 00010246
RAX: 000001a442624200 RBX: 000001a442624200 RCX: ffff888108a4f000
RDX: 0000000000000000 RSI: 000000000000070d RDI: 000000000000070d
RBP: ffffc9000dcceb90 R08: ffffffff849c5e26 R09: fffffbfff10e1297
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108a4f358
R13: dffffc0000000000 R14: 0000001a8cd9a7ec R15: 0000000000000000
FS: 00007fa73fe18700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa73fdf7718 CR3: 000000011d36e000 CR4: 0000000000350ee0
Call Trace:
<TASK>
[<ffffffff84714385>] __dev_xmit_skb net/core/dev.c:3931 [inline]
[<ffffffff84714385>] __dev_queue_xmit+0xcf5/0x3370 net/core/dev.c:4290
[<ffffffff84d22df2>] dev_queue_xmit include/linux/netdevice.h:3030 [inline]
[<ffffffff84d22df2>] neigh_hh_output include/net/neighbour.h:531 [inline]
[<ffffffff84d22df2>] neigh_output include/net/neighbour.h:545 [inline]
[<ffffffff84d22df2>] ip_finish_output2+0xb92/0x10d0 net/ipv4/ip_output.c:235
[<ffffffff84d21e63>] __ip_finish_output+0xc3/0x2b0
[<ffffffff84d10a81>] ip_finish_output+0x31/0x2a0 net/ipv4/ip_output.c:323
[<ffffffff84d10f14>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
[<ffffffff84d10f14>] ip_output+0x224/0x2a0 net/ipv4/ip_output.c:437
[<ffffffff84d123b5>] dst_output include/net/dst.h:444 [inline]
[<ffffffff84d123b5>] ip_local_out net/ipv4/ip_output.c:127 [inline]
[<ffffffff84d123b5>] __ip_queue_xmit+0x1425/0x2000 net/ipv4/ip_output.c:542
[<ffffffff84d12fdc>] ip_queue_xmit+0x4c/0x70 net/ipv4/ip_output.c:556

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
---
 net/sched/sch_netem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6ef3021e1169a376494d610ac8c3f1c04fb911c5..e79be1b3e74da3c154f7ee23e16cc9e8da8f7106 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -966,6 +966,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
 	old_loss_model = q->loss_model;
@@ -974,7 +975,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
-			return ret;
+			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
@@ -1041,6 +1042,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+unlock:
+	sch_tree_unlock(sch);
 	return ret;
 
 get_table_failure:
@@ -1050,7 +1053,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	q->clg = old_clg;
 	q->loss_model = old_loss_model;
-	return ret;
+
+	goto unlock;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
-- 
2.41.0.178.g377b9f9a00-goog


