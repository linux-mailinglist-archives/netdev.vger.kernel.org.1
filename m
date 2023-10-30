Return-Path: <netdev+bounces-45184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C377DB4A0
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE1F1C208A5
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A05CA61;
	Mon, 30 Oct 2023 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irZ/4Y2d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3D6AC0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:55:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CEC2
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698652549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5t9eU8J5yxO7BvU8JT+OpUytvz6S9LcChDCUUgV2Oz8=;
	b=irZ/4Y2dQSaBsBuzaueaPk+OvJb2xtduDvBqGfzbuwamlcmVl7fVT2F7okjTkVdvTutUqZ
	FpxQw9hwVQqid9ASePBC9fvc2AlrujBVMVWfwzKVUh7w1VOsp4HEC/jLf2eCKGD9ZjyFVk
	PcF8R7Rcp2vaRC+hNMbKnfiULEyOOqM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HI4T-qURNkmJNqNdorOGTA-1; Mon, 30 Oct 2023 03:55:47 -0400
X-MC-Unique: HI4T-qURNkmJNqNdorOGTA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so2589353b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 00:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652546; x=1699257346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t9eU8J5yxO7BvU8JT+OpUytvz6S9LcChDCUUgV2Oz8=;
        b=CnaWrqeRIYa63QhKoW36YS8NvOI7yRAOtCJXU6a5Xg346Iji+jD4Y0fOm+5fP5K/Et
         r6U5e/CSqMXoB0t0OpwN7GSdWClFvN8S3xcWQuYxqPL9kjnHbfxPE3UtiRHPAUAciaXo
         quBWRHtEKxw81RYMoCAGX/tFg5i5ULiZVc3nBjAOqTnCxbhq2Pr+by6cTZLmkCgpL/U1
         1u7HxKGNyBXZx6Xt1UD/lPkWO2FQ8ScGLV1jMJkhTT4D7klB4EVCvk9mjUX88u2rtjfd
         Fp2jLglBEQK9l3gPtPMgD3zlWIycACujADB1A3feyXxoz2dX/Nx+8USq+DoBFRyJ7Hge
         JEng==
X-Gm-Message-State: AOJu0Yw2Gkcv/6YfhW67NQs/5u4ncNCJGtFxoGTkx1qrfbbr/Sped+Ac
	WQLcgYxhOYT324a+Yl+/1uYXUCpcJxlFOhOMJkPDtaGX3j13LT0XTF6952Y6zSQh04ho2fNH9HI
	zpMPsq1gUrUeJ38jM
X-Received: by 2002:a05:6a20:3d0b:b0:16b:79c2:7d6e with SMTP id y11-20020a056a203d0b00b0016b79c27d6emr8487042pzi.30.1698652546280;
        Mon, 30 Oct 2023 00:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1Rxl23x3SQRnaFLCEUYXHyALve0OUwu9/SycOUu0i0w32D2cvv1z7vkHbvguD9UjlU6/wA==
X-Received: by 2002:a05:6a20:3d0b:b0:16b:79c2:7d6e with SMTP id y11-20020a056a203d0b00b0016b79c27d6emr8487037pzi.30.1698652545956;
        Mon, 30 Oct 2023 00:55:45 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001c9e53b721csm3016067plb.261.2023.10.30.00.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 00:55:45 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
	syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: [PATCH net v3] tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
Date: Mon, 30 Oct 2023 16:55:40 +0900
Message-ID: <20231030075540.3784537-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
 strlen lib/string.c:418 [inline]
 strstr+0xb8/0x2f0 lib/string.c:756
 tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
 genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

TIPC bearer-related names including link names must be null-terminated
strings. If a link name which is not null-terminated is passed through
netlink, strstr() and similar functions can cause buffer overrun. This
causes the above issue.

This patch changes the nla_policy for bearer-related names from NLA_STRING
to NLA_NUL_STRING. This resolves the issue by ensuring that only
null-terminated strings are accepted as bearer-related names.

syzbot reported similar uninit-value issue related to bearer names [2]. The
root cause of this issue is that a non-null-terminated bearer name was
passed. This patch also resolved this issue.

Fixes: 7be57fc69184 ("tipc: add link get/dump to new netlink api")
Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574 [1]
Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51 [2]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v2->v3:
- Change the title
- Change the nla_policy for bearer-related names instead of using nla_strscpy()
- Resolve bearer-name related issue too
https://lore.kernel.org/all/20231020163415.2445440-1-syoshida@redhat.com/

v1->v2:
- Use nla_strscpy()
- Fix similar bugs in other functions other than syzbot reported
https://lore.kernel.org/all/20230924060325.3779150-1-syoshida@redhat.com/
---
 net/tipc/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index e8fd257c0e68..1a9a5bdaccf4 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -88,7 +88,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -125,7 +125,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
-- 
2.41.0


