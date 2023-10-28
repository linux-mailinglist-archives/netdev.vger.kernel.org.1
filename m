Return-Path: <netdev+bounces-45014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BC7DA831
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5BB1C2095C
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847E17723;
	Sat, 28 Oct 2023 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A/sGEfir"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A394443D
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 17:16:22 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05030E5
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 10:16:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2800f7c8125so1069949a91.1
        for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698513379; x=1699118179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPNO+ahBLQBMC1iObupMpuBe+kCZA+YomrzIkUwQcdA=;
        b=A/sGEfir5a7LWI4ZVQWRH/ZMR5LpsXMyjFq8opGZwxx+smvh61kDKG8qKxgTo8J/0r
         yzaj62gCwupRRSox6Bldfm5alSZ6DKt9s3SMMbSzdmPww9K/T4E2tyi56COoSBwimsDl
         l63fCMDMMCU8cHSsm1u9cEH9yUz+c458gtuoZw0SO9mO9ZSfq6PCmG9iu/rWJ+OLK4y8
         IRzKd4zVduSOzGbgV3pW1uIwOu+0Gykm5S92pxbNtMGPz9zpZgVg4nvJcGdqjHCe3UcP
         0tFEQX5I5E3LZcJEViDLHb5BRyYx/Y7f9qko2nnIdH/VL7gnkT1iJiwRFL7OaSM/XTHb
         wGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698513379; x=1699118179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPNO+ahBLQBMC1iObupMpuBe+kCZA+YomrzIkUwQcdA=;
        b=c1kZF/75830MBq1UHT19EOzvI1mkkT5EVtfGAxVs9hWzYbYviHwM0TRPrPc+HuB18m
         ULQ7Fm2dQjyXarL4gyTg+wnEsMJxg4kLZxw9PhZL7cAe91DdFlR0NVF05tn0o/PYPKZE
         IuRBrKS/P3MEM3cjtHEWdSR1J+pyY1dHRZIjxcaln4Vl8WTysT7pxjdxgYh8NTaq9n/C
         MMFP0SJyiPV85Z+Dl8/Y5nu46mRMgr6tJpCPZTEEtNmL7Oh7xcIiLtvbRkJ8cLuIgntJ
         dMXCGAvQ6yPT2pPypP8U8p4x5ZHFZrEE1zJq2O7B9bEKS0PlRG5S7MJGCVwjL23mEhmQ
         fvTA==
X-Gm-Message-State: AOJu0Ywhg9eW8qmWpn3NfmUuFW7Zafd3wZoPwEW6TR+Cesc5yruBOWP0
	ifG2CyQlXKsk2c8UMpeI9JZo5A==
X-Google-Smtp-Source: AGHT+IH2PAayCVb7jRktTBu5FkVrrM9EO2e6XCqvBrfKOsesKwX3lcV/Zo2+ZKHR6zL58Iwy9yCn+A==
X-Received: by 2002:a17:90b:1c8b:b0:280:72b:397d with SMTP id oo11-20020a17090b1c8b00b00280072b397dmr7253510pjb.20.1698513379160;
        Sat, 28 Oct 2023 10:16:19 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net (S0106e0553d2d6601.vc.shawcable.net. [24.86.212.220])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a551500b002802a080d1dsm1266704pji.16.2023.10.28.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 10:16:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	daniel@iogearbox.net,
	idosch@idosch.org,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config
Date: Sat, 28 Oct 2023 13:16:10 -0400
Message-Id: <20231028171610.28596-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getting the following splat [1] with CONFIG_DEBUG_NET=y and this
reproducer [2]. Problem seems to be that classifiers clear 'struct
tcf_result::drop_reason', thereby triggering the warning in
__kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).

Fixed by disambiguating a legit error from a verdict with a bogus drop_reason

[1]
WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
Modules linked in:
CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
RIP: 0010:kfree_skb_reason+0x38/0x130
[...]
Call Trace:
 <IRQ>
 __netif_receive_skb_core.constprop.0+0x837/0xdb0
 __netif_receive_skb_one_core+0x3c/0x70
 process_backlog+0x95/0x130
 __napi_poll+0x25/0x1b0
 net_rx_action+0x29b/0x310
 __do_softirq+0xc0/0x29b
 do_softirq+0x43/0x60
 </IRQ>

[2]

ip link add name veth0 type veth peer name veth1
ip link set dev veth0 up
ip link set dev veth1 up
tc qdisc add dev veth1 clsact
tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1

Ido reported:

  [...] getting the following splat [1] with CONFIG_DEBUG_NET=y and this
  reproducer [2]. Problem seems to be that classifiers clear 'struct
  tcf_result::drop_reason', thereby triggering the warning in
  __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [...]

  [1]
  WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
  Modules linked in:
  CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
  RIP: 0010:kfree_skb_reason+0x38/0x130
  [...]
  Call Trace:
   <IRQ>
   __netif_receive_skb_core.constprop.0+0x837/0xdb0
   __netif_receive_skb_one_core+0x3c/0x70
   process_backlog+0x95/0x130
   __napi_poll+0x25/0x1b0
   net_rx_action+0x29b/0x310
   __do_softirq+0xc0/0x29b
   do_softirq+0x43/0x60
   </IRQ>

  [2]
  #!/bin/bash

  ip link add name veth0 type veth peer name veth1
  ip link set dev veth0 up
  ip link set dev veth1 up
  tc qdisc add dev veth1 clsact
  tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
  mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1

What happens is that inside most classifiers the tcf_result is copied over
from a filter template e.g. *res = f->res which then implicitly overrides
the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which was
set via sch_handle_{ingress,egress}() for kfree_skb_reason().

Commit text above copied verbatim from Daniel. The general idea of the patch
is not very different from what Ido originally posted but instead done at the
cls_api codepath.

Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flexible")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
---
 net/sched/act_api.c | 2 +-
 net/sched/cls_api.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9d3f26bf0440..c39252d61ebb 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1098,7 +1098,7 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				net_warn_ratelimited("can't go to NULL chain!\n");
+				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1daeb2182b70..1976bd163986 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1658,6 +1658,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				 int act_index,
 				 u32 *last_executed_chain)
 {
+	u32 orig_reason = res->drop_reason;
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 16;
 	const struct tcf_proto *first_tp;
@@ -1712,8 +1713,14 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			goto reset;
 		}
 #endif
-		if (err >= 0)
+		if (err >= 0) {
+			/* Policy drop or drop reason is over-written by
+			 * classifiers with a bogus value(0) */
+			if (err == TC_ACT_SHOT &&
+			    res->drop_reason == SKB_NOT_DROPPED_YET)
+				tcf_set_drop_reason(res, orig_reason);
 			return err;
+		}
 	}
 
 	if (unlikely(n)) {
-- 
2.34.1


