Return-Path: <netdev+bounces-31525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F578E8A0
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D5C1C2097C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255CF79F6;
	Thu, 31 Aug 2023 08:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16072746B
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:45:13 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E5CE7
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:45:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so8338407b3.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693471511; x=1694076311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WpxEhZVbNlTmssSObGecOPvTrx1dfnd7OTrPl/CgL5k=;
        b=bTtrAQrULRb1LdjQinGHBoPIILgDt6nvGs0FMNkfkyFIUfDYzJnEJTZZbXPkUM1Ets
         WIoiNBnqmGPv8r5Coj1Ivh/J4ke7HEWbpyTaPlGkUwZjKKXvxs9yAW5UZYyKuw3PjR2I
         EQIA6/CTKHIly7K2bEvCGD9pJcvZ8LY7fJ5kbr+nRByL9UpPkkNEEmk03lgu7mhrnazf
         QaBpDVycrGSJbCw0OuiElTQtfd5kXdDp7gsf7FX8kbNWKrSIjOrchC3FvkbMDdzohWBD
         t7MLR7cWn4zb74HvqQW9FEesihHdTV8sJKfEYxmQ2+SY8NwdF/3yVlekLQLegau8E0uy
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471511; x=1694076311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpxEhZVbNlTmssSObGecOPvTrx1dfnd7OTrPl/CgL5k=;
        b=aSV+iG4TbM+AsmGqC6ySSgMKRzcek8prjHtWxPMIMUq0ZmbgmTMJcG8p+EDHBSGa7r
         5HCHx9tnIqaMXGqVTegu11ejgqWKdqalSSa3PepKr/k1OS5II7dAt/xF7rDWvZem7xTU
         7kJHZwATrUHLrFB+6rJb4fw9UuIQrKACEiS7Ff970pIbX6DnCJ73tt6HaaujzRq/nvsN
         0oqizBX8Ghlop7RiDmy4TXxRnrGMVxfwbKj4RVgSZ12l3RrSUqsF16hjP/w7oK1OSrqb
         IzuMupp+vlMMnKDNjG0W7ILnTHKxdoeJ1QeZt1825wOT/5qzeI7RG5anCcaO/pxYoS/W
         /UPA==
X-Gm-Message-State: AOJu0YwVNJlpHbDRd4njWdWue5yn7nKf1jUZOpazGy+9ZE3QfrGH/3Dn
	GTMj+3hSuMxtpzQqstjUaKyP8zRV7/KePw==
X-Google-Smtp-Source: AGHT+IHsMKOgCTvcGz43KDm/UDL6ID5zlaOLih0Ee4Bud1jImftA8dLmPD74Ku2Em7bj1Z3xV7KNU6mWYiLtBA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2d04:0:b0:d7e:3629:a684 with SMTP id
 t4-20020a252d04000000b00d7e3629a684mr58946ybt.3.1693471511633; Thu, 31 Aug
 2023 01:45:11 -0700 (PDT)
Date: Thu, 31 Aug 2023 08:45:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831084509.1857341-1-edumazet@google.com>
Subject: [PATCH v2 net] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We should not call trace_handshake_cmd_done_err() if socket lookup has failed.

Also we should call trace_handshake_cmd_done_err() before releasing the file,
otherwise dereferencing sock->sk can return garbage.

This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local variable")

Unable to handle kernel paging request at virtual address dfff800000000003
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Mem abort info:
ESR = 0x0000000096000005
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x05: level 1 translation fault
Data abort info:
ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000003] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 5986 Comm: syz-executor292 Not tainted 6.5.0-rc7-syzkaller-gfe4469582053 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
lr : handshake_nl_done_doit+0x180/0x9c8
sp : ffff800096e37180
x29: ffff800096e37200 x28: 1ffff00012dc6e34 x27: dfff800000000000
x26: ffff800096e373d0 x25: 0000000000000000 x24: 00000000ffffffa8
x23: ffff800096e373f0 x22: 1ffff00012dc6e38 x21: 0000000000000000
x20: ffff800096e371c0 x19: 0000000000000018 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800080516cc4 x15: 0000000000000001
x14: 1fffe0001b14aa3b x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000003
x8 : 0000000000000003 x7 : ffff800080afe47c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080a88078
x2 : 0000000000000001 x1 : 00000000ffffffa8 x0 : 0000000000000000
Call trace:
handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
genl_rcv_msg+0x96c/0xc50 net/netlink/genetlink.c:1067
netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2549
genl_rcv+0x38/0x50 net/netlink/genetlink.c:1078
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x56c/0x840 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmsg+0x26c/0x33c net/socket.c:2577
__do_sys_sendmsg net/socket.c:2586 [inline]
__se_sys_sendmsg net/socket.c:2584 [inline]
__arm64_sys_sendmsg+0x80/0x94 net/socket.c:2584
__invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 12800108 b90043e8 910062b3 d343fe68 (387b6908)

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
---
v2: remove req=NULL as claimed in changelog (Paolo)

 net/handshake/netlink.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1086653e1fada1724f98ccbc81fbcf7741ef9bc9..d0bc1dd8e65a8201751fddcc2356da89cd2c65e7 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -157,26 +157,24 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
-	struct handshake_req *req = NULL;
-	struct socket *sock = NULL;
+	struct handshake_req *req;
+	struct socket *sock;
 	int fd, status, err;
 
 	if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_DONE_SOCKFD))
 		return -EINVAL;
 	fd = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_SOCKFD]);
 
-	err = 0;
 	sock = sockfd_lookup(fd, &err);
-	if (err) {
-		err = -EBADF;
-		goto out_status;
-	}
+	if (!sock)
+		return err;
 
 	req = handshake_req_hash_lookup(sock->sk);
 	if (!req) {
 		err = -EBUSY;
+		trace_handshake_cmd_done_err(net, req, sock->sk, err);
 		fput(sock->file);
-		goto out_status;
+		return err;
 	}
 
 	trace_handshake_cmd_done(net, req, sock->sk, fd);
@@ -188,10 +186,6 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 	handshake_complete(req, status, info);
 	fput(sock->file);
 	return 0;
-
-out_status:
-	trace_handshake_cmd_done_err(net, req, sock->sk, err);
-	return err;
 }
 
 static unsigned int handshake_net_id;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


