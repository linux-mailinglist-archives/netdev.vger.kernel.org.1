Return-Path: <netdev+bounces-31232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B078C44E
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B782281148
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3914F95;
	Tue, 29 Aug 2023 12:35:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A714AB3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:35:45 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB905A3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:35:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7454a43541so5201397276.1
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693312543; x=1693917343;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upywnKQrXIg4Bu64T3NzqGiYeE8oJnfengtXAcANbMo=;
        b=bCJ+fvmXBx+lHitrzuuIDJymNwznnSRyqHD+wfk7a7TuJfmqjfeFHjip8HMO/3UMml
         yb+/cY6jjODVlSJyQQ831YoCzyfa/dz0Id9O9+ugWzDukHwxGKrZ6njpPQolgoLle9TH
         cSOMcnMOB4BazWcil5jyQKoj4ATFwys1vUez/Eh06HtLh32BsTvfMJHpiTotMS+ziRjv
         JoMdc+IxUmVEMnW3CxTXISYm/ue/rficKi6CqSOZse6Sh9ZlO1n4BDjQp/luF750rRkd
         HY+CjWjQvIJ2ALsMo7QdCfmVxXZ0adEyc3f3oLOnS2rIyf4k77HYvbD/9Zf6GHpFXfJm
         4S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312543; x=1693917343;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upywnKQrXIg4Bu64T3NzqGiYeE8oJnfengtXAcANbMo=;
        b=d6wXAzyq5YxgpSR1xx1sBg/Tt46bSjeaCfoOBAyT/4KeliN8zVQOh8vO+5xpMw7JUF
         tREzlO549dsO7ssNGO+hQqEzuhmlNYP3f06aMd+3yDztXU3LAeIlA12hZ9dP/A7hRVoM
         Ufyy2JPcRYgjmCxEaG1oxmGmRme2JjIzm8J0yOz3Ws/VBBNB0YBbDTAl55Rh2d5ApY+G
         9obrPv524w+gFt0iUgisc0gAdutWbQgJTd2GPkrxlSUxpjMmM7uqQuiD4TpOu6k3sLEr
         fAxTUErnB+LjRlPdnuyGWbPHOh3qROgKCmKxVq5/kV4SDQMRX9ZDMqaNbd5oQIQSyvzQ
         bieA==
X-Gm-Message-State: AOJu0YzU/GYCIxo80/TxHknp66sBVIoRWuhCQNk4+5oxhlNTpv5RpFv5
	Du4idx63wWRY5r9poQ2qKD3KRo9mq/crsg==
X-Google-Smtp-Source: AGHT+IG7QmnFfjGfZI7cELuGr9mEWnEW1XFyuAlZzX57hPVV4TCHxC7oVeebbF90sbx0Heba+oIm0Fj7hiwiFw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4057:0:b0:d71:9aa2:d953 with SMTP id
 n84-20020a254057000000b00d719aa2d953mr860778yba.5.1693312543035; Tue, 29 Aug
 2023 05:35:43 -0700 (PDT)
Date: Tue, 29 Aug 2023 12:35:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829123541.3745013-1-edumazet@google.com>
Subject: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When setting a high number of flows (limit being 65536),
fq_pie_timer() is currently using too much time as syzbot reported.

Add logic to yield the cpu every 2048 flows (less than 150 usec
on debug kernels).
It should also help by not blocking qdisc fast paths for too long.
Worst case (65536 flows) would need 31 jiffies for a complete scan.

Relevant extract from syzbot report:

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2663 jiffies s: 873 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@google.com/
Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_pie.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 591d87d5e5c0f10379645da9eb0f4e7309d74916..68e6acd0f130d93de42b75f8af40513899b5e2bd 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -61,6 +61,7 @@ struct fq_pie_sched_data {
 	struct pie_params p_params;
 	u32 ecn_prob;
 	u32 flows_cnt;
+	u32 flows_cursor;
 	u32 quantum;
 	u32 memory_limit;
 	u32 new_flow_count;
@@ -375,22 +376,32 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 static void fq_pie_timer(struct timer_list *t)
 {
 	struct fq_pie_sched_data *q = from_timer(q, t, adapt_timer);
+	unsigned long next, tupdate;
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
-	u32 idx;
+	int max_cnt, i;
 
 	rcu_read_lock();
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
-	for (idx = 0; idx < q->flows_cnt; idx++)
-		pie_calculate_probability(&q->p_params, &q->flows[idx].vars,
-					  q->flows[idx].backlog);
-
-	/* reset the timer to fire after 'tupdate' jiffies. */
-	if (q->p_params.tupdate)
-		mod_timer(&q->adapt_timer, jiffies + q->p_params.tupdate);
+	/* Limit this expensive loop to 2048 flows per round. */
+	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
+	for (i = 0; i < max_cnt; i++) {
+		pie_calculate_probability(&q->p_params,
+					  &q->flows[q->flows_cursor].vars,
+					  q->flows[q->flows_cursor].backlog);
+		q->flows_cursor++;
+	}
 
+	tupdate = q->p_params.tupdate;
+	next = 0;
+	if (q->flows_cursor >= q->flows_cnt) {
+		q->flows_cursor = 0;
+		next = tupdate;
+	}
+	if (tupdate)
+		mod_timer(&q->adapt_timer, jiffies + next);
 	spin_unlock(root_lock);
 	rcu_read_unlock();
 }
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


