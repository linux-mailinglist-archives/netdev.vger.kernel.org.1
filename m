Return-Path: <netdev+bounces-34114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7FE7A221B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6223F1C20A36
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC011190;
	Fri, 15 Sep 2023 15:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975C1097D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:15:15 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9310D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:15:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5884836cso28703557b3.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694790913; x=1695395713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3P+qFMME2GH9/paGWgViIx1mihp7cvVSnXAODxkFu5k=;
        b=XGO2d990ySBz3ZkRSujRsULwHPKu2Unmz/PENopokOUQ+1tyYLkupZtYBdYWjXuKwR
         DekUAUC05Q74DonA1n2pXSK9gmClbcmYy9SaPyaV9gQ/wTmK3NmdYRr3ILmyC8wE9tpZ
         XDsYffILqN6WfggyPezQOkJZ36YMZnmvFWBpnz25h1hZovy5seh5OjzKeimMs7T5UTUU
         3AtOH9px06zLyaGBCpzUBSSNnBYYnyUD/E1ZFglNgaCVu8FDzxCCP33bqzpX+tOLbfl4
         ZOe0CG20/kYNRcAMLjHwF+T1qbS5uzfWK0v3dTVb9DjaJ1Hvc7tbvCL0Z1GQWCrE0gU7
         VE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790913; x=1695395713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3P+qFMME2GH9/paGWgViIx1mihp7cvVSnXAODxkFu5k=;
        b=N+ZsEPL8Sgs65IAos2xtAXXfQYMB/5l2WryUNGhct/WVL/P9w+qzjB2ow9Gdhbt+yp
         jVF4Xm+9dhhAjM2RHjzLfFxKqLn3cJiWn4+BU8j7rdOOLN2LONxHH7VtLuvX8LwuBsEa
         mHdzzJHIQoKO36Md2RFqTFCqJ2kT0TSrKuCkYWfHNRRlAh7MYTgTgDGq2GRANTlSD4SJ
         FtlWRYC9gpYsNU8+gKfbDrN068hKleO/1fWQBYipD9CvtWcoiHVo7rKYzFKXDut/e1eZ
         jwue+wksk2SHY2WgKs2hPyrIoMtPNvYagpYkvD8NspRovmTVs1xrXlylsCtOVaB9nxpA
         UxzA==
X-Gm-Message-State: AOJu0YzVM0jH67/OmoAyPVHKUlpeh+OPLJMrWQVaOlcqJHalqMYbxlzr
	nXUqCOfSkAIJ3KQpYKsbdbHk5WZZ0DVobg==
X-Google-Smtp-Source: AGHT+IG6ZyfrdinmN2nQLhv7y5dNaa+GYR/ibB4saccOfcOqEf2EBFQ3on5kUKJz/vxLmMF6tSd1iEghrf+7nQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a78a:0:b0:59b:ea2e:23e5 with SMTP id
 e132-20020a81a78a000000b0059bea2e23e5mr59461ywh.7.1694790913608; Fri, 15 Sep
 2023 08:15:13 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:15:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915151512.3803083-1-edumazet@google.com>
Subject: [PATCH net] dccp: fix dccp_v4_err()/dccp_v6_err() again
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
not in the "byte 7" as John claimed.

We need to make sure the ICMP messages are big enough,
using more standard ways (no more assumptions).

syzbot reported:
BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2681 [inline]
BUG: KMSAN: uninit-value in dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
pskb_may_pull include/linux/skbuff.h:2681 [inline]
dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
icmpv6_notify+0x4c7/0x880 net/ipv6/icmp.c:867
icmpv6_rcv+0x19d5/0x30d0
ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
NF_HOOK include/linux/netfilter.h:304 [inline]
ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:304 [inline]
ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
__netif_receive_skb_one_core net/core/dev.c:5523 [inline]
__netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
netif_receive_skb_internal net/core/dev.c:5723 [inline]
netif_receive_skb+0x58/0x660 net/core/dev.c:5782
tun_rx_batched+0x83b/0x920
tun_get_user+0x564c/0x6940 drivers/net/tun.c:2002
tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:1985 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x8ef/0x15c0 fs/read_write.c:584
ksys_write+0x20f/0x4c0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x93/0xd0 fs/read_write.c:646
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
alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6313
sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2795
tun_alloc_skb drivers/net/tun.c:1531 [inline]
tun_get_user+0x23cf/0x6940 drivers/net/tun.c:1846
tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:1985 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x8ef/0x15c0 fs/read_write.c:584
ksys_write+0x20f/0x4c0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x93/0xd0 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 4995 Comm: syz-executor153 Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023

Fixes: 977ad86c2a1b ("dccp: Fix out of bounds access in DCCP error handler")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jann Horn <jannh@google.com>
---
 net/dccp/ipv4.c | 9 ++-------
 net/dccp/ipv6.c | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 8f56e8723c7386c9f9344f1376823bfd0077c8c2..69453b936bd557c77a790a27ff64cc91e5a58296 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -254,13 +254,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 33f6ccf6ba77b9bcc24054b09857aaee4bb71acf..c693a570682fba2ad93c7bceb8788bd9d51a0b41 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -83,13 +83,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
-- 
2.42.0.459.ge4e396fd5e-goog


