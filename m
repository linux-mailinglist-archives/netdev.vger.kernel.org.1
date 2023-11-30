Return-Path: <netdev+bounces-52435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291017FEBC6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B7B1C20AAC
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E46374D1;
	Thu, 30 Nov 2023 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFuTsskM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374639D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:23:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca26c07848so12769707b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701336181; x=1701940981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmcjMmBXHfOiGgDa48arhN+Q0TX0EvMWP2Ur85fIm8o=;
        b=dFuTsskMAvT9jR81dF0fWupZ+gi9OV4VzcV4TFRWXQI1GK7pyLRlKRT86z20TveFPW
         vFSb5UfvIgwenLlHreTvA2QKHfAEWRrw0bPeSwPFFW+sJlwrbG0fCCOQkHQS6SFS4jaM
         /CRbgk4Nyy990jeRYAoRbiPoTiaXitOCms7YMqetyVFxdoeaZBqlbHJOwrqNzNzejpXE
         im3ATFV2F2VaaZcvmRJYQGiIFcj54u7YxbrSn5qXlNhT6beLArBSwuydXtwG/2KJFTzt
         AwzsB/yjrBKEFkx+BLsG6vPnwbYc1Wfq+83m8z97gd/PExAFzyFaHa3rYZt3rsC5cP/s
         JqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336181; x=1701940981;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmcjMmBXHfOiGgDa48arhN+Q0TX0EvMWP2Ur85fIm8o=;
        b=AQXUvWlXybp5CDtXCm+C0bix3DjfAon3WVlFEgq8ZpXhtZExHwSzj1rOTkSpCiXvYg
         z2W4ElnNBXV8xiEecZv+Tc1sJl1c1aJjOJV3aNy211J6RF0REfrt7/PjPPU5wBfyjoK9
         qERaqEVF3my6niGpZXztCBtjyh7f1WsRGmJ9pxeNACxtnVDcGarrsUamvs7eN/8wNBzp
         YOxAWzkTOf1xyu4kjM40NXBzLzs5dEJBa2IdMO6tP4/GU02l9kVjbLpt8iIM3ryEAi51
         9z24knPFCBXsS9k66wo4s0WRvq/NhF2zupw33Jfk8jlU+bhTul36xuN9pKdn5BAydRro
         YfXw==
X-Gm-Message-State: AOJu0Yxcd4j6T40P+JdEG0jA2iuuwjn5aXJYEsAax3DQqisQoWdQ5GaX
	kGOYxHIPpttWjCym0sawT+g6oxeYdh2r5g==
X-Google-Smtp-Source: AGHT+IEqoHe20lq9QWThohBH3uPiQMHepOlsv+58416v2tWk1kdR8vZTrm9Gtr4vtj79PWNQz9zOw1ixXt5fxg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d057:0:b0:db5:3e85:9c63 with SMTP id
 h84-20020a25d057000000b00db53e859c63mr27577ybg.6.1701336181467; Thu, 30 Nov
 2023 01:23:01 -0800 (PST)
Date: Thu, 30 Nov 2023 09:22:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130092259.3797753-1-edumazet@google.com>
Subject: [PATCH net-next] net: page_pool: fix general protection fault in page_pool_unlist
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot was able to trigger a crash [1] in page_pool_unlist()

page_pool_list() only inserts a page pool into a netdev page pool list
if a netdev was set in params.

Even if the kzalloc() call in page_pool_create happens to initialize
pool->user.list, I chose to be more explicit in page_pool_list()
adding one INIT_HLIST_NODE().

We could test in page_pool_unlist() if netdev was set,
but since netdev can be changed to lo, it seems more robust to
check if pool->user.list is hashed  before calling hlist_del().

[1]

Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packet loss!
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00533-ga379972973a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __page_pool_destroy net/core/page_pool.c:851 [inline]
 page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
 page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
 xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
 bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
 bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
 bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
 __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
 __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486

Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
Reported-and-tested-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/page_pool_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1426434a7e1587797da92f3199c0012559b51271..ffe5244e5597e806e1cbd2dc82894276e107e91c 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -310,6 +310,7 @@ int page_pool_list(struct page_pool *pool)
 	if (err < 0)
 		goto err_unlock;
 
+	INIT_HLIST_NODE(&pool->user.list);
 	if (pool->slow.netdev) {
 		hlist_add_head(&pool->user.list,
 			       &pool->slow.netdev->page_pools);
@@ -339,7 +340,8 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_lock(&page_pools_lock);
 	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
 	xa_erase(&page_pools, pool->user.id);
-	hlist_del(&pool->user.list);
+	if (!hlist_unhashed(&pool->user.list))
+		hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


