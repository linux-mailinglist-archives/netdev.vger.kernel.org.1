Return-Path: <netdev+bounces-31638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E878F2BA
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4E281441
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B882198A3;
	Thu, 31 Aug 2023 18:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4321170A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 18:37:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B4A0
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:37:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e4d2b7d16so14589967b3.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693507072; x=1694111872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUz7iMTxybKX0LOy8LkmbWQDVDyPX2mZkhHr5+jFLhk=;
        b=BHzNcRe5waVrhCCAxmkAJdgIjfvQ0zqVdOgmHpZZluqBkfqQriWaVRCuQUczqnq/yC
         GxEoNSPTC9DkvW9ssuwAYQUlq/qvGDtEBRvnFZbt4ydnEeqPTQgzihg8MlXVuh/wiWsy
         Xo4+RVNtnO2m50HAop8iCUfeyUuhAqAC6zAzDV6Q8SUfYxXnRXMSnR8GFSm4zitkxiyQ
         e+lcgqc4aaWhg8hyA96WQUNEH+O4PQllTT96GqaB+KckSiad30NiwArMX/o6a2a0F4EE
         e3Pd540fGb3lszlFNUs0f5V5a4ajfp3N08nfaDkoQxb7pGDvNoEcA7E3PELmbISBmZTW
         Jm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507072; x=1694111872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUz7iMTxybKX0LOy8LkmbWQDVDyPX2mZkhHr5+jFLhk=;
        b=Ym9RvUB+FMxCurHvcpFp3ZhMn6DtntWKWc540h924nXlYRUpDZn3rT4AtvgLXdoA+m
         pjk4yZoZdCwR1r7RzIa0nDiQP0nqGVmnDKU1XbMng6fqMdHxqudcG8ldjGrwv47FCZj4
         A3KyDT1tIoPAd0iLDBYUtmWa4NijsyWsZ9s1P36/dBknFGnOiYekPkXdhXMVzhGDZ2ir
         binapzGDoJhSW7qimpgkpiWRGN/gKufwsyqU7PXcTaJb8Q0TgYeej6XD48Fy9csyCkdZ
         E4D/IAHHKzlOBDTO1P+3kC0xFIYwotM8nCtrUZlNVrCjbZYFAp/BGyRJSJ2ofT/OmM71
         tFrQ==
X-Gm-Message-State: AOJu0YzjGqknjmWThkWVIoGKlfpt0DVwsapIvoCSDsXIQzIEQAIZJT0F
	h+cJ2oBUWVgGrFdl8IXWFpI4frpdO9UR7g==
X-Google-Smtp-Source: AGHT+IEV8mDc9+KXKrffSvsUljMSCOiE0v1IrQlt0BR8mTXGWkC8lVgrsHPj90Xup7Ovkq7LAEMhJzqWPsiKSA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:a82:0:b0:d44:be8a:ca39 with SMTP id
 h2-20020a5b0a82000000b00d44be8aca39mr11865ybq.7.1693507071833; Thu, 31 Aug
 2023 11:37:51 -0700 (PDT)
Date: Thu, 31 Aug 2023 18:37:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831183750.2952307-1-edumazet@google.com>
Subject: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kyle Zeng <zengyhkyle@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Blamed commit changed:
    ptr = kmalloc(size);
    if (ptr)
      size = ksize(ptr);

to:
    size = kmalloc_size_roundup(size);
    ptr = kmalloc(size);

This allowed various crash as reported by syzbot [1]
and Kyle Zeng.

Problem is that if @size is bigger than 0x80000001,
kmalloc_size_roundup(size) returns 2^32.

kmalloc_reserve() uses a 32bit variable (obj_size),
so 2^32 is truncated to 0.

kmalloc(0) returns ZERO_SIZE_PTR which is not handled by
skb allocations.

Following trace can be triggered if a netdev->mtu is set
close to 0x7fffffff

We might in the future limit netdev->mtu to more sensible
limit (like KMALLOC_MAX_SIZE).

This patch is based on a syzbot report, and also a report
and tentative fix from Kyle Zeng.

[1]
BUG: KASAN: user-memory-access in __build_skb_around net/core/skbuff.c:294 [inline]
BUG: KASAN: user-memory-access in __alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
Write of size 32 at addr 00000000fffffd10 by task syz-executor.4/22554

CPU: 1 PID: 22554 Comm: syz-executor.4 Not tainted 6.1.39-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call trace:
dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:279
show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:286
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x120/0x1a0 lib/dump_stack.c:106
print_report+0xe4/0x4b4 mm/kasan/report.c:398
kasan_report+0x150/0x1ac mm/kasan/report.c:495
kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
memset+0x40/0x70 mm/kasan/shadow.c:44
__build_skb_around net/core/skbuff.c:294 [inline]
__alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
alloc_skb include/linux/skbuff.h:1316 [inline]
igmpv3_newpack+0x104/0x1088 net/ipv4/igmp.c:359
add_grec+0x81c/0x1124 net/ipv4/igmp.c:534
igmpv3_send_cr net/ipv4/igmp.c:667 [inline]
igmp_ifc_timer_expire+0x1b0/0x1008 net/ipv4/igmp.c:810
call_timer_fn+0x1c0/0x9f0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers+0x54c/0x710 kernel/time/timer.c:1790
run_timer_softirq+0x28/0x4c kernel/time/timer.c:1803
_stext+0x380/0xfbc
____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
invoke_softirq kernel/softirq.c:437 [inline]
__irq_exit_rcu+0x1c0/0x4cc kernel/softirq.c:683
irq_exit_rcu+0x14/0x78 kernel/softirq.c:695
el0_interrupt+0x7c/0x2e0 arch/arm64/kernel/entry-common.c:717
__el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:724
el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:729
el0t_64_irq+0x1a0/0x1a4 arch/arm64/kernel/entry.S:584

Fixes: 12d6c1d3a2ad ("skbuff: Proactively round up to kmalloc bucket size")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 net/core/skbuff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 45707059082f2d706a9820f4484d0d4636aaa930..ba3a0a7f526d7b819d7836d460ea83716b17ce1c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -550,7 +550,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 			     bool *pfmemalloc)
 {
 	bool ret_pfmemalloc = false;
-	unsigned int obj_size;
+	size_t obj_size;
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
@@ -567,7 +567,13 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 		obj = kmem_cache_alloc_node(skb_small_head_cache, flags, node);
 		goto out;
 	}
-	*size = obj_size = kmalloc_size_roundup(obj_size);
+
+	obj_size = kmalloc_size_roundup(obj_size);
+	/* The following cast might truncate high-order bits of obj_size, this
+	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
+	 */
+	*size = (unsigned int)obj_size;
+
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
-- 
2.42.0.283.g2d96d420d3-goog


