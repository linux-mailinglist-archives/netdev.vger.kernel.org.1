Return-Path: <netdev+bounces-34166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504537A26C6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261351C20A22
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E2182CA;
	Fri, 15 Sep 2023 19:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46318E0B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:00:56 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8F2102
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:00:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81d85aae7cso1710171276.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694804440; x=1695409240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8KWgfsICIsS0hxA6hqlYAH10z58pgLuDyIfyy8w/SY=;
        b=iD6vnlmk4ra1gwF5ZrILGAR4xQdaR/DffaYQA0FUHisSBsgFRfedXw8z4udJIsZAvB
         LjLSyZzpl4AqQlDRVnSlBiy37W6hfCskbifDAarpLrZApEjOF5tA+sTt84Ccx+HnNXzQ
         058Z0TIjuojet9/Yb8A6dtiXJcqs39WH2KLiwTIrbVfbTMHZfxhPzENlJx5eq7zBb7BZ
         nTsw5YURS6jvL5ohfOajztOmvwjkT73f8HerWH6i5lRAEi2oePrwTIn/wnAkJ6FCi8i7
         icDwFdKdUscbypv93fKeMsrCja1znXebhhBLy3omur/Gy5PDj3Hg5Knh7pcMZ37TbAAv
         94PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804440; x=1695409240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8KWgfsICIsS0hxA6hqlYAH10z58pgLuDyIfyy8w/SY=;
        b=TjNzBM3mdlC6x0o0+LnjoABwcnignf88KqJ5DtCMbuIg+SuUnyamn3Ufosus6d7EW7
         ZhJMPEgHH8WAU5RiVgjQiXenLTro5fMpkw/JG5GQSLqTC5O7CaJS5/Iz7pMAE/1LdcPo
         cCGMWOjeXSogl64AThggfb5KMVaajMuPv+nivdN+ce+muQBaIDcm/c4h+20wEY/eqhIj
         s2nJHeimJZXW8X3W5/N9y4ik/9zaZqaoLm0omrI7+egxWfT0TckJj76TaVLFAr3yuUpf
         Jnqi3/CdbxiDvGA+cdHIKE9DbBaZ+PhoJMIZqLHyFi7pfIlQowMPqN4kUnvkryFnqXq4
         2Liw==
X-Gm-Message-State: AOJu0YwqAlfOKAMGaeqtlhOmH/32I15gPr20JJeaXMN/oRFDoxckKD94
	F0j0Y6XFA3e3C3/cY7oGdGn4GNm1KAk7yQ==
X-Google-Smtp-Source: AGHT+IH4x1j6BAssPktQOHwsg3G5tmgSZ7k5//m9FD8waUnadIwLsh3SAg+ougI311MSZLd/HExqdTZqohh06g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:3202:0:b0:d7b:b648:f0da with SMTP id
 y2-20020a253202000000b00d7bb648f0damr172253yby.6.1694804439960; Fri, 15 Sep
 2023 12:00:39 -0700 (PDT)
Date: Fri, 15 Sep 2023 19:00:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915190035.4083297-1-edumazet@google.com>
Subject: [PATCH v2 net] dccp: fix dccp_v4_err()/dccp_v6_err() again
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
not in the "byte 7" as Jann claimed.

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
v2: fix a typo I made on Jann name, sorry !
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


