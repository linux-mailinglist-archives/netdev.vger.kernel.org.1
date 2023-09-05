Return-Path: <netdev+bounces-32089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443F47922F4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C47D1C20986
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AAD50F;
	Tue,  5 Sep 2023 13:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AACA57
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:23:07 +0000 (UTC)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28619B
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 06:23:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-414cac7beaaso18270051cf.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693920185; x=1694524985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lBxCv84UW6hj6rwB1Apsn3aqO+mbNBLfgM1bBjMuk8=;
        b=syB6s8EnV+77y6XyHjikuMBYCBun9dtGwRwn5LzwCpwsR4YWOqKB1GxvEs7PYNcyRB
         xi4nAp+sKXuvwlAV0Ge3vq0uXI+GLCj2VjCxP1eLp+VBHOHaGnsSYY8tM73A+IRtJIIs
         u0b1cxnGG+HeHAFm+h5VjE3Liy3j9NtWD06+4M+tPAe/q/gVdsjMcqaNUD/AwexaJlzn
         pyAueOlHLP/m309szAvJAFSJeda6QDMgycyOuJuRu37ItevKny5suzz0MHwxbsrZYyE2
         xfFDdZqLKp3ONu27ncypqIOLuf+bA6NuWbz4F22Obt/j7zNEjn9dny22Zd8gUZ2OVJEe
         whbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693920185; x=1694524985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lBxCv84UW6hj6rwB1Apsn3aqO+mbNBLfgM1bBjMuk8=;
        b=EzyjMG+JgI3OJH9Jc4NGH959x2i7GgtbM0vzfjPvub3SNzq6AF7POTCoplS0Tb09+b
         bfrdNvpemvPTHD1rLW0BaEek7OkOhEgmVC+BCmUFZ3g+Pr+CFpoRcsU63nJUzhAn69XO
         chjPBApbwm6LH/w+KzQSXknb9WTl8gSB6Ijnh1vmDIFbMKX/XwNPFHCqrDL0HC8i6Mtb
         X8A+MUWMCltB5jobMZlzYoDOtTkq2dpCKHEy07YyynQFsGYfTZRobm421KLL5TtuQdsq
         JseTobAeWVWk3XNF1beTBsMlE/ZjXM8LOYF6cNzwLcIeGW9GkWpQAFaMF9skQfHWLrxz
         RmcA==
X-Gm-Message-State: AOJu0YytLU8qa6N2HmgKz3ZqFLxAE4oz+29IG8FvjbJoCsmMQSlb+zck
	yHI/UvcQ4fK5/mDDH4Ntg24JflnDC2TMRA==
X-Google-Smtp-Source: AGHT+IEb2jqkpcBq8k4fhQSBSTSVGhM1oP3ZCq9wzyG7FkK5y/gZNV4xm4ZnEqeb+eiRg2wMpKxguVpsXHWJmQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:49:b0:412:6df4:736 with SMTP id
 y9-20020a05622a004900b004126df40736mr306165qtw.12.1693920185089; Tue, 05 Sep
 2023 06:23:05 -0700 (PDT)
Date: Tue,  5 Sep 2023 13:23:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905132303.1927206-1-edumazet@google.com>
Subject: [PATCH net] xfrm: interface: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot/KCSAN reported data-races in xfrm whenever dev->stats fields
are updated.

It appears all of these updates can happen from multiple cpus.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

BUG: KCSAN: data-race in xfrmi_xmit / xfrmi_xmit

read-write to 0xffff88813726b160 of 8 bytes by task 23986 on cpu 1:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff88813726b160 of 8 bytes by task 23987 on cpu 0:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000000010d7 -> 0x00000000000010d8

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 23987 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index b864740846902db7f0ab60c6d72465a51b96b1d7..e21cc71095bb27012f774f50ace5e3c2c52e243d 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -380,8 +380,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	skb->dev = dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -426,7 +426,6 @@ static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
 	struct net_device *tdev;
@@ -473,7 +472,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	tdev = dst->dev;
 
 	if (tdev == dev) {
-		stats->collisions++;
+		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     dev->name);
 		goto tx_err_dst_release;
@@ -512,13 +511,13 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	}
 
 	return 0;
 tx_err_link_failure:
-	stats->tx_carrier_errors++;
+	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
@@ -528,7 +527,6 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	struct flowi fl;
 	int ret;
@@ -545,7 +543,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
 			if (dst->error) {
 				dst_release(dst);
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, dst);
@@ -561,7 +559,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
 			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, &rt->dst);
@@ -580,8 +578,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
+	DEV_STATS_INC(dev, tx_errors);
+	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
-- 
2.42.0.283.g2d96d420d3-goog


