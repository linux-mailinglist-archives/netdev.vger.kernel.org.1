Return-Path: <netdev+bounces-13109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EB73A4B7
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CE1281958
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203DC1F934;
	Thu, 22 Jun 2023 15:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D711E526
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:23:08 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75934135
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:23:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so7659915276.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687447386; x=1690039386;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y64Y7UfLV4SoW71jQGgKx9NrfPf1QUsCyOBx0w6DuwY=;
        b=s5hIj0pl89Sar0Ap89Gp84fbEhzfmurSohlkO8L3/WsWtQrJKY+3PVe3eM7ZQUSO3h
         xjX6lGGkLZt+5e6sIxZk8gzofywCqqf1WAFhtgqJJTzwskRCppQuS6X3d+2Df5PBsznc
         TJNyHeUxRc2woUteRzRU1ZvAKibja9H3dHF0SCli+HcWCiJgx32Foy4BJVa8nT5eDKqE
         HSSlhv02Zg4yDxzCg7liRCrTkPfD1Tfe4GVBsy0u7iFros/kVxBf80Oh3XEG+kitVdms
         6Oq6YbjIkg8rypupspu0ZN/BWjn7kP0jpvw/pNgmd9fEycejFBMKV4KhuWdaORR/whTE
         Kx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447386; x=1690039386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y64Y7UfLV4SoW71jQGgKx9NrfPf1QUsCyOBx0w6DuwY=;
        b=CA5x9rBeXKqOGVffAhKrEkDG9RrEy221iBJN7g6kNoFkhRPw4PhaNcnrTHohkjqmih
         DRd2KGechyhMG+NmUhJGPkOx8VKWLnXvxqTmSscqB0EfhUvhQD3k/QHOp6VUr9o/I+xl
         5fmKkFH6PZ6DhHmt14ymJOJhQQ8Ox+3aNexaKvdG6sD+CDcRB8BDIcck3SKD6AI85l+k
         dIXl3yZJD3V/FXEHmjSKwiptFTAcjavOkzdidZc46dyYYYUNnxJxO3YnksPOK4w2cdZ4
         aJJkO72lz4mZjgBcXSC5ORm+RHJnXAAWpsmgB64dbidpoirHblB/+3vOzGnO7USuEn9b
         PYxQ==
X-Gm-Message-State: AC+VfDyxqFbn1vILi8eJVCqhht3XKUgZ6hofbx4SH2GHr0MCBP2hBuDV
	NNNq7dMvkzmeeTyhcLSrihdQnAFia0dURQ==
X-Google-Smtp-Source: ACHHUZ7vPlwWn8EMSz8wj75V6N4nzu5m4vEIyJQ5BN0BO1L4KWL8zGebIg4ZbPXDwEmSWgyphm3ExbdZz49bBQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:abcb:0:b0:bdd:69e:95e6 with SMTP id
 v69-20020a25abcb000000b00bdd069e95e6mr2601493ybi.6.1687447386698; Thu, 22 Jun
 2023 08:23:06 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:23:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230622152304.2137482-1-edumazet@google.com>
Subject: [PATCH net] bonding: do not assume skb mac_header is set
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jarod Wilson <jarod@redhat.com>, Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drivers must not assume in their ndo_start_xmit() that
skbs have their mac_header set. skb->data is all what is needed.

bonding seems to be one of the last offender as caught by syzbot:

WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset include/linux/skbuff.h:2913 [inline]
WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
Modules linked in:
CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe e9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
[<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
[<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
[<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inline]
[<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet.c:284
[<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
[<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c:3143
[<ffffffff8467a4b2>] sock_sendmsg_nosec net/socket.c:716 [inline]
[<ffffffff8467a4b2>] sock_sendmsg net/socket.c:736 [inline]
[<ffffffff8467a4b2>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
[<ffffffff8467a715>] __do_sys_sendto net/socket.c:2151 [inline]
[<ffffffff8467a715>] __se_sys_sendto net/socket.c:2147 [inline]
[<ffffffff8467a715>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
[<ffffffff8553071f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
[<ffffffff8553071f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
[<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 7b8fc0103bb5 ("bonding: add a vlan+srcmac tx hashing option")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jarod Wilson <jarod@redhat.com>
Cc: Moshe Tal <moshet@nvidia.com>
Cc: Jussi Maki <joamaki@gmail.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1c0f26d185dc8ff5e3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 		return skb->hash;
 
 	return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
-				skb_mac_offset(skb), skb_network_offset(skb),
+				0, skb_network_offset(skb),
 				skb_headlen(skb));
 }
 
-- 
2.41.0.178.g377b9f9a00-goog


