Return-Path: <netdev+bounces-46471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71A7E4561
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B05EB20BC4
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F53321B3;
	Tue,  7 Nov 2023 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0PlT5+He"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07C321B8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 16:04:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B437A6A
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:04:49 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a90d6ab944so79314367b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699373089; x=1699977889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7N2obbCjbyLS/X7ETiPew3oMreBKgQ5d2YqyX5SlPyI=;
        b=0PlT5+HevK/4qWBDw/uvVozZZJGfYsKKRwHUDvzreNovYcxLb+7JMloqonZ7f7oAPp
         I6t3SDrPswAz0cj/nxD1T1aRSNavilvamJwSIbfr8bSyrQFkQyslqODNhf8Hh8EBiuah
         IPq71zaeEf2MQBMq5XZvMrC7+sNfPTq4Wsn0aqXDCYzSaZGoHY7NdxGe//HwyJ8S3EmJ
         4GzA9TiVHElXOBZGPkLA3AoBZ5xSr/G8EmBELlFtnpgLIBJBnP1BQdYIEWY5/V5R4lF5
         I/f0edEshiuvzR1SvWyubaPU8q1tD3RtXz480VCyD6i8UvCRF/Kmzqoj6X0rizCkifiy
         htaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373089; x=1699977889;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N2obbCjbyLS/X7ETiPew3oMreBKgQ5d2YqyX5SlPyI=;
        b=pXJ/4AmJjk+jS2KrxnOAi9tmx06asKky4/8ygKPMJlIOZ0vf5s5U+SyAQLKqD9D7G6
         Xexh3rU7p8I4Z7zClIJGXkEu0Mct2J1bgR2Rf41aIA3Glz5Ueh4KbE2gfjSO6EIpyFIq
         maunTZP2/CQtXFvVW7F+b3eV9fi4Eb8MEquzyEx/ff6XGuiEXK3Yj4wGBvcnOy3ngTiq
         Zpsjd4X2b9HwDk/gEbvdDG2sRYD/vHvUVQC1Do61NsIj5lebJthXEzvjGgSuxa1jDrOV
         A85TeXuckEd9EHbzb4RnGCmijR54do3DBPbhQHUgGAxeCaQtY7X7FF1T2CZfo410roIu
         YRWQ==
X-Gm-Message-State: AOJu0YySbpnS57OqhNDKaiyXlcjMhcdQmRVpNLAebfT4MG5mvLw75z+x
	YxA0Zfpxgd82UfwNLeon804fRxHq8map0w==
X-Google-Smtp-Source: AGHT+IFkn6KDJMOxqr3H4ffOv1z6tkAn5usae+YGK5VNtW7WSmcUzpUt9Oh9Mg0y8E0Xvl3FO0hafwygiytneA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:dd01:0:b0:5a7:bbdb:6b39 with SMTP id
 e1-20020a81dd01000000b005a7bbdb6b39mr279148ywn.3.1699373089127; Tue, 07 Nov
 2023 08:04:49 -0800 (PST)
Date: Tue,  7 Nov 2023 16:04:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107160440.1992526-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_fq: better validate TCA_FQ_WEIGHTS and TCA_FQ_PRIOMAP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot was able to trigger the following report while providing
too small TCA_FQ_WEIGHTS attribute [1]

Fix is to use NLA_POLICY_EXACT_LEN() to ensure user space
provided correct sizes.

Apply the same fix to TCA_FQ_PRIOMAP.

[1]
BUG: KMSAN: uninit-value in fq_load_weights net/sched/sch_fq.c:960 [inline]
BUG: KMSAN: uninit-value in fq_change+0x1348/0x2fe0 net/sched/sch_fq.c:1071
fq_load_weights net/sched/sch_fq.c:960 [inline]
fq_change+0x1348/0x2fe0 net/sched/sch_fq.c:1071
fq_init+0x68e/0x780 net/sched/sch_fq.c:1159
qdisc_create+0x12f3/0x1be0 net/sched/sch_api.c:1326
tc_modify_qdisc+0x11ef/0x2c20
rtnetlink_rcv_msg+0x16a6/0x1840 net/core/rtnetlink.c:6558
netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6576
netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg net/socket.c:745 [inline]
____sys_sendmsg+0x9c2/0xd60 net/socket.c:2588
___sys_sendmsg+0x28d/0x3c0 net/socket.c:2642
__sys_sendmsg net/socket.c:2671 [inline]
__do_sys_sendmsg net/socket.c:2680 [inline]
__se_sys_sendmsg net/socket.c:2678 [inline]
__x64_sys_sendmsg+0x307/0x490 net/socket.c:2678
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
slab_alloc_node mm/slub.c:3478 [inline]
kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
__alloc_skb+0x318/0x740 net/core/skbuff.c:651
alloc_skb include/linux/skbuff.h:1286 [inline]
netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg net/socket.c:745 [inline]
____sys_sendmsg+0x9c2/0xd60 net/socket.c:2588
___sys_sendmsg+0x28d/0x3c0 net/socket.c:2642
__sys_sendmsg net/socket.c:2671 [inline]
__do_sys_sendmsg net/socket.c:2680 [inline]
__se_sys_sendmsg net/socket.c:2678 [inline]
__x64_sys_sendmsg+0x307/0x490 net/socket.c:2678
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5001 Comm: syz-executor300 Not tainted 6.6.0-syzkaller-12401-g8f6f76a6a29f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023

Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
Fixes: 49e7265fd098 ("net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 0fd18c344ab5ae6d53e12fc764c0506a2979b4c8..3a31c47fea9bd97d815f2624d926bf7be62387cd 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -919,14 +919,8 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 	[TCA_FQ_TIMER_SLACK]		= { .type = NLA_U32 },
 	[TCA_FQ_HORIZON]		= { .type = NLA_U32 },
 	[TCA_FQ_HORIZON_DROP]		= { .type = NLA_U8 },
-	[TCA_FQ_PRIOMAP]		= {
-			.type = NLA_BINARY,
-			.len = sizeof(struct tc_prio_qopt),
-		},
-	[TCA_FQ_WEIGHTS]		= {
-			.type = NLA_BINARY,
-			.len = FQ_BANDS * sizeof(s32),
-		},
+	[TCA_FQ_PRIOMAP]		= NLA_POLICY_EXACT_LEN(sizeof(struct tc_prio_qopt)),
+	[TCA_FQ_WEIGHTS]		= NLA_POLICY_EXACT_LEN(FQ_BANDS * sizeof(s32)),
 };
 
 /* compress a u8 array with all elems <= 3 to an array of 2-bit fields */
-- 
2.42.0.869.gea05f2083d-goog


