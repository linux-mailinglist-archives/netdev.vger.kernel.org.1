Return-Path: <netdev+bounces-12765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FE738D8C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC411C20F23
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0FF19E44;
	Wed, 21 Jun 2023 17:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948819BC6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:47:25 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0451726
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:47:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc502a721b1so12249334276.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687369642; x=1689961642;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56GS3I8zXMeYIkoI8Ihw9R0z8F9Y+QVH5+LYUttrD3A=;
        b=Dg66ctbrKOi+ONr9YnbE5sjb8AeYlemv4/j5x8vuaLdAgCsfq1T+8Use9Ps5MDwgvC
         LpqmmcU5ZeYyHjf99Ssnhr2ok9yTjLI6cWuDCdwkt/iaWz3CZEgstU+XbfH6W53c+GBJ
         WZTpVEtEs3ty2trHcViYrvp4dC2Ad7ONzVsDSxKNVAEmCfzEUsDoBXWVRKXNebsBezAb
         aroV/C2fgOH4FGLQAMhtF/a6RxfBDvgsODagEaCahHEgVu+fTsogSbSG/YgO3um9pei0
         dqKE++DaxgEBaBZAXg1pFxTYq7lGuFUpoZZxOxb/xrVLzGpFvkRo2JTzI7g9cZgZrPZm
         ikkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369642; x=1689961642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56GS3I8zXMeYIkoI8Ihw9R0z8F9Y+QVH5+LYUttrD3A=;
        b=gbUGn/LWxZyyjWmKy9mdTco1m3Rrdnj63KVKNil+0L/psPHLPJHOKJSY/0Rona3pDz
         cmN20MCs9Ilt750nSaBFt4H70GSmrtZXTjUVG7ym68L0JjWNu9SgIYxoMXAM8SxsCje3
         Pb2z+WLNLQ+z6Ytjv1c//+JL7W7ankxzrW2dnQyZ9H7NNus6cZO8PiAvyRF4V2+avW7M
         rEfjnCjxVS0FvEi2P/cIMqxQi4nNw7k1Fuf1yGJF1YkmLU4pqMbIQ9SOVpgyoJmXVr3N
         X7EkMNu9NLlnvi8Gc0CayUw7idH6o9TsTYwSk/Krh023pRydSKO9VFXXBopa7QLitmM6
         SyYw==
X-Gm-Message-State: AC+VfDxllSEL2rcXC1h3dG+DNxJBlMugz4lo4IahiTaerKXJl/kXyFJ3
	JTR5IYP/r6KrweCsf1JizbvwjRRUm/8QIg==
X-Google-Smtp-Source: ACHHUZ6JS6rv039tSyTlGo4hFySM9p7zDbbyQOysA8S5LPV04TosKGlRJzpOEIOto+Mdz8AiDCj8ZAogz6wy1Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:92:b0:bc4:a660:528f with SMTP id
 h18-20020a056902009200b00bc4a660528fmr3731017ybs.5.1687369642711; Wed, 21 Jun
 2023 10:47:22 -0700 (PDT)
Date: Wed, 21 Jun 2023 17:47:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230621174720.1845040-1-edumazet@google.com>
Subject: [PATCH net] netlink: do not hard code device address lenth in fdb dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reports that some netdev devices do not have a six bytes
address [1]

Replace ETH_ALEN by dev->addr_len.

[1] (Case of a device where dev->addr_len = 4)

BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copyout+0xb8/0x100 lib/iov_iter.c:169
instrument_copy_to_user include/linux/instrumented.h:114 [inline]
copyout+0xb8/0x100 lib/iov_iter.c:169
_copy_to_iter+0x6d8/0x1d00 lib/iov_iter.c:536
copy_to_iter include/linux/uio.h:206 [inline]
simple_copy_to_iter+0x68/0xa0 net/core/datagram.c:513
__skb_datagram_iter+0x123/0xdc0 net/core/datagram.c:419
skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:527
skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
netlink_recvmsg+0x4ae/0x15a0 net/netlink/af_netlink.c:1970
sock_recvmsg_nosec net/socket.c:1019 [inline]
sock_recvmsg net/socket.c:1040 [inline]
____sys_recvmsg+0x283/0x7f0 net/socket.c:2722
___sys_recvmsg+0x223/0x840 net/socket.c:2764
do_recvmmsg+0x4f9/0xfd0 net/socket.c:2858
__sys_recvmmsg net/socket.c:2937 [inline]
__do_sys_recvmmsg net/socket.c:2960 [inline]
__se_sys_recvmmsg net/socket.c:2953 [inline]
__x64_sys_recvmmsg+0x397/0x490 net/socket.c:2953
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
__nla_put lib/nlattr.c:1009 [inline]
nla_put+0x1c6/0x230 lib/nlattr.c:1067
nlmsg_populate_fdb_fill+0x2b8/0x600 net/core/rtnetlink.c:4071
nlmsg_populate_fdb net/core/rtnetlink.c:4418 [inline]
ndo_dflt_fdb_dump+0x616/0x840 net/core/rtnetlink.c:4456
rtnl_fdb_dump+0x14ff/0x1fc0 net/core/rtnetlink.c:4629
netlink_dump+0x9d1/0x1310 net/netlink/af_netlink.c:2268
netlink_recvmsg+0xc5c/0x15a0 net/netlink/af_netlink.c:1995
sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1019
____sys_recvmsg+0x664/0x7f0 net/socket.c:2720
___sys_recvmsg+0x223/0x840 net/socket.c:2764
do_recvmmsg+0x4f9/0xfd0 net/socket.c:2858
__sys_recvmmsg net/socket.c:2937 [inline]
__do_sys_recvmmsg net/socket.c:2960 [inline]
__se_sys_recvmmsg net/socket.c:2953 [inline]
__x64_sys_recvmmsg+0x397/0x490 net/socket.c:2953
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
slab_alloc_node mm/slub.c:3451 [inline]
__kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
kmalloc_trace+0x51/0x200 mm/slab_common.c:1057
kmalloc include/linux/slab.h:559 [inline]
__hw_addr_create net/core/dev_addr_lists.c:60 [inline]
__hw_addr_add_ex+0x2e5/0x9e0 net/core/dev_addr_lists.c:118
__dev_mc_add net/core/dev_addr_lists.c:867 [inline]
dev_mc_add+0x9a/0x130 net/core/dev_addr_lists.c:885
igmp6_group_added+0x267/0xbc0 net/ipv6/mcast.c:680
ipv6_mc_up+0x296/0x3b0 net/ipv6/mcast.c:2754
ipv6_mc_remap+0x1e/0x30 net/ipv6/mcast.c:2708
addrconf_type_change net/ipv6/addrconf.c:3731 [inline]
addrconf_notify+0x4d3/0x1d90 net/ipv6/addrconf.c:3699
notifier_call_chain kernel/notifier.c:93 [inline]
raw_notifier_call_chain+0xe4/0x430 kernel/notifier.c:461
call_netdevice_notifiers_info net/core/dev.c:1935 [inline]
call_netdevice_notifiers_extack net/core/dev.c:1973 [inline]
call_netdevice_notifiers+0x1ee/0x2d0 net/core/dev.c:1987
bond_enslave+0xccd/0x53f0 drivers/net/bonding/bond_main.c:1906
do_set_master net/core/rtnetlink.c:2626 [inline]
rtnl_newlink_create net/core/rtnetlink.c:3460 [inline]
__rtnl_newlink net/core/rtnetlink.c:3660 [inline]
rtnl_newlink+0x378c/0x40e0 net/core/rtnetlink.c:3673
rtnetlink_rcv_msg+0x16a6/0x1840 net/core/rtnetlink.c:6395
netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2546
rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6413
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1913
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0x999/0xd50 net/socket.c:2503
___sys_sendmsg+0x28d/0x3c0 net/socket.c:2557
__sys_sendmsg net/socket.c:2586 [inline]
__do_sys_sendmsg net/socket.c:2595 [inline]
__se_sys_sendmsg net/socket.c:2593 [inline]
__x64_sys_sendmsg+0x304/0x490 net/socket.c:2593
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Bytes 2856-2857 of 3500 are uninitialized
Memory access of size 3500 starts at ffff888018d99104
Data copied to user address 0000000020000480

Fixes: d83b06036048 ("net: add fdb generic dump routine")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 41de3a2f29e15a1db04c9fd7f0b723c501fa0256..7776611a14ae4367fe8af1bde0f55b20c5e3507d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4090,7 +4090,7 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	ndm->ndm_ifindex = dev->ifindex;
 	ndm->ndm_state   = ndm_state;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, addr))
+	if (nla_put(skb, NDA_LLADDR, dev->addr_len, addr))
 		goto nla_put_failure;
 	if (vid)
 		if (nla_put(skb, NDA_VLAN, sizeof(u16), &vid))
@@ -4104,10 +4104,10 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static inline size_t rtnl_fdb_nlmsg_size(void)
+static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg)) +
-	       nla_total_size(ETH_ALEN) +	/* NDA_LLADDR */
+	       nla_total_size(dev->addr_len) +	/* NDA_LLADDR */
 	       nla_total_size(sizeof(u16)) +	/* NDA_VLAN */
 	       0;
 }
@@ -4119,7 +4119,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(rtnl_fdb_nlmsg_size(), GFP_ATOMIC);
+	skb = nlmsg_new(rtnl_fdb_nlmsg_size(dev), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
-- 
2.41.0.178.g377b9f9a00-goog


