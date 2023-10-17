Return-Path: <netdev+bounces-42045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5557CCC2B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499092820C7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51632EB1C;
	Tue, 17 Oct 2023 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLVkJS4Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125FD2EB14
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:23:08 +0000 (UTC)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C97B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:23:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-7740cf4136aso710728285a.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697570586; x=1698175386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubg9oAed4hFu/Cytj9RXpPVFIYTdemuWDNf8huMw/BY=;
        b=NLVkJS4QrfJZM6YUFXBBME7ev0A82UC54AP2boF/rDhOQ8a8HRaP7nMkmx5wcoYBCP
         8Cvs7IQTW1Cg5bisAyDiuguEVk9/hCBbMnACkmgD2kBi3NKfE21WSgpXEimm3usojc11
         gIx/Eq+iCQRx/mbnewIxmaIDfe2SqO3w0K81c69xHtTP/nYJQPWQm1TG2nMmoKKADmVj
         2+bTEDUn8HUrLs2ezFMlLR8o/67KyPJ9k1VddCeB71jQQM5gJc9hu840awIzlWfqZQHF
         YW+wSLCPm/12zzO3AnOGfK+Eyr7Sa3ehqsGcsZJ1tC/cK1wpJQW25lzLxQYE59x+I32k
         w3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570586; x=1698175386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubg9oAed4hFu/Cytj9RXpPVFIYTdemuWDNf8huMw/BY=;
        b=sCLB8CimWZwZKreTwDK9oLeH7eTRzZrLZ1giBvU2USCQiJX6QwPMD2WBGVPDElIDZ3
         yzZjtyI5vKA5s0nhuFMzRCPb3JzAd8EQ6h0wK4bADdV18b3lu7RaGgeKqtAU2IqJzz6i
         p7hsyzKaoad0lRlog9FYIY3cXIZymwu0Bgm6LQ6gdsENNhXgQk9ENjrzXiKNhE9H8Nf8
         n+HaX1P67CpgBTG/umY/IBHrjXh8xY71jt44ORpqnmlyD8/oKS+XxZ/IrQigpmqJEq3r
         s23eANCs+6ol1caD16EWMRhMPUVwjGCwn7j5n6eIsHo9Ck9SW230TG/XedLaOT1RXoaJ
         C76A==
X-Gm-Message-State: AOJu0Yylbpcii8j3IE20hwIjVaRsHi5FPJxUY6Sk1Iig8YOUH7OLoZor
	Ff60Ig+mnDodpkOxixrSkc8nV+zNnbedoQ==
X-Google-Smtp-Source: AGHT+IHIDa8Jcwd8PP6IsQ4HnDGXaIi0CmhE/Gfg+pwqWiCJhcGARPIHmmOkkiWl0W5z7qIjQth7IMz3g6L3mQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:8a15:b0:76e:fdb4:c124 with SMTP
 id qt21-20020a05620a8a1500b0076efdb4c124mr56615qkn.3.1697570586724; Tue, 17
 Oct 2023 12:23:06 -0700 (PDT)
Date: Tue, 17 Oct 2023 19:23:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017192304.82626-1-edumazet@google.com>
Subject: [PATCH net] ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a data-race while accessing nh->nh_saddr_genid [1]

Add annotations, but leave the code lazy as intended.

[1]
BUG: KCSAN: data-race in fib_select_path / fib_select_path

write to 0xffff8881387166f0 of 4 bytes by task 6778 on cpu 1:
fib_info_update_nhc_saddr net/ipv4/fib_semantics.c:1334 [inline]
fib_result_prefsrc net/ipv4/fib_semantics.c:1354 [inline]
fib_select_path+0x292/0x330 net/ipv4/fib_semantics.c:2269
ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
__ip_route_output_key include/net/route.h:134 [inline]
ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read to 0xffff8881387166f0 of 4 bytes by task 6759 on cpu 0:
fib_result_prefsrc net/ipv4/fib_semantics.c:1350 [inline]
fib_select_path+0x1cb/0x330 net/ipv4/fib_semantics.c:2269
ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
__ip_route_output_key include/net/route.h:134 [inline]
ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x959d3217 -> 0x959d3218

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 6759 Comm: kworker/u4:15 Not tainted 6.6.0-rc4-syzkaller-00029-gcbf3a2cb156a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker

Fixes: 436c3b66ec98 ("ipv4: Invalidate nexthop cache nh_saddr more correctly.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_semantics.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1ea82bc33ef14bd4411204c58ea5fece02783b35..5eb1b8d302bbd1c408c4999636b6cf4b81a0ad7e 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1325,15 +1325,18 @@ __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
 				 unsigned char scope)
 {
 	struct fib_nh *nh;
+	__be32 saddr;
 
 	if (nhc->nhc_family != AF_INET)
 		return inet_select_addr(nhc->nhc_dev, 0, scope);
 
 	nh = container_of(nhc, struct fib_nh, nh_common);
-	nh->nh_saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
-	nh->nh_saddr_genid = atomic_read(&net->ipv4.dev_addr_genid);
+	saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
 
-	return nh->nh_saddr;
+	WRITE_ONCE(nh->nh_saddr, saddr);
+	WRITE_ONCE(nh->nh_saddr_genid, atomic_read(&net->ipv4.dev_addr_genid));
+
+	return saddr;
 }
 
 __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
@@ -1347,8 +1350,9 @@ __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
 		struct fib_nh *nh;
 
 		nh = container_of(nhc, struct fib_nh, nh_common);
-		if (nh->nh_saddr_genid == atomic_read(&net->ipv4.dev_addr_genid))
-			return nh->nh_saddr;
+		if (READ_ONCE(nh->nh_saddr_genid) ==
+		    atomic_read(&net->ipv4.dev_addr_genid))
+			return READ_ONCE(nh->nh_saddr);
 	}
 
 	return fib_info_update_nhc_saddr(net, nhc, res->fi->fib_scope);
-- 
2.42.0.655.g421f12c284-goog


