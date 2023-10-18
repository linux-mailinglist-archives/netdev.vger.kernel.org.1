Return-Path: <netdev+bounces-42166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776707CD759
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3386A281D39
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E916427;
	Wed, 18 Oct 2023 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWh/C0+W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52411723
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:00:19 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4DF9
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:00:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c6ab06242so1481484276.2
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697619617; x=1698224417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdl0e02+fzmdDNtZW4QZEzk2fnupS9pcSP9s69wjNOc=;
        b=nWh/C0+WNvkKaslGIdEEOcwX0XlOTxLx1RI1wXrJZzsldCEScX8LjE8l2b5SW0qdMO
         JLUmC/I4cqtaFFd/mJ6h7n0B5vxYVS79lDVyXYJs/sZ1HOO1rWbEgQWvfRnlHM54pnoh
         XxKsjRsSn4vp0WtXW9jQyUxUluiLQ10HXSFoKBMxXLXwHUyfl3J2uK27Z+mS2Hq9T4+g
         vkZtC7NRj8ZUV384eRuD+6HCySrGk6YtRHFxw/j/13aka2ys3vCls0qOTgn2f8tujn30
         bePprhaPJ1+9K+HgDvVEv38+wyfq+uDP7s0n2AMnQCNWkYyK5EHsWVJvshmPLfIuaJUQ
         O66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619617; x=1698224417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdl0e02+fzmdDNtZW4QZEzk2fnupS9pcSP9s69wjNOc=;
        b=duw9mMmz1ug/ryPDrMUib2Fxt5Jb+ZOWRhc2jDwt1ftj6vYEKJ7yMEiKPKp/egcptI
         +XfpOavF83wPFHGsssHbQK9iEQR2OuKVqmqLQWaZHXw9Q3nO5BTqoGUr5m6ihJC2h3+Z
         O8bR0lpILjvXVVh0CCwYJy+uEfAz4bMqivjt5etuUEPwY6pwUP9gd3cGH1L/88e9y5pO
         hssER0MePTx+zfMRkAREt5z9vYGzzDrtLaRySoJnNjtZvAM5utukWCqPrUW5fm5QiFvI
         X++xk/Jn649mrEhy1r60xXdulX0iEn3QzE69jCeswmNouWAtHmlCEoZ5ASztgItqp1oU
         p45g==
X-Gm-Message-State: AOJu0YzDoApdJRAP47cdmDBT9mu8ji1qok9oWclm7bYHZJi5yTVebzz6
	dO+pJ0h8cT8mD3g1DOcBiERXvo9GUTZPaw==
X-Google-Smtp-Source: AGHT+IHv+obtPhucexH/IJCwoPMuYVkyncBT2xD3h9NDDffXznbr+04iZzPWK6FUcW6ydVFUKwUVWea8OW/F8g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102d:b0:d9c:2a58:b905 with SMTP
 id x13-20020a056902102d00b00d9c2a58b905mr127673ybt.9.1697619617192; Wed, 18
 Oct 2023 02:00:17 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:00:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018090014.345158-1-edumazet@google.com>
Subject: [PATCH net-next] inet: lock the socket in ip_sock_set_tos()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christoph Paasch reported a panic in TCP stack [1]

Indeed, we should not call sk_dst_reset() without holding
the socket lock, as __sk_dst_get() callers do not all rely
on bare RCU.

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 12bad6067 P4D 12bad6067 PUD 12bad5067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 2750 Comm: syz-executor.5 Not tainted 6.6.0-rc4-g7a5720a344e7 #49
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:tcp_get_metrics+0x118/0x8f0 net/ipv4/tcp_metrics.c:321
Code: c7 44 24 70 02 00 8b 03 89 44 24 48 c7 44 24 4c 00 00 00 00 66 c7 44 24 58 02 00 66 ba 02 00 b1 01 89 4c 24 04 4c 89 7c 24 10 <49> 8b 0f 48 8b 89 50 05 00 00 48 89 4c 24 30 33 81 00 02 00 00 69
RSP: 0018:ffffc90000af79b8 EFLAGS: 00010293
RAX: 000000000100007f RBX: ffff88812ae8f500 RCX: ffff88812b5f8f01
RDX: 0000000000000002 RSI: ffffffff8300f080 RDI: 0000000000000002
RBP: 0000000000000002 R08: 0000000000000003 R09: ffffffff8205eca0
R10: 0000000000000002 R11: ffff88812b5f8f00 R12: ffff88812a9e0580
R13: 0000000000000000 R14: ffff88812ae8fbd2 R15: 0000000000000000
FS: 00007f70a006b640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012bad7003 CR4: 0000000000170ee0
Call Trace:
<TASK>
tcp_fastopen_cache_get+0x32/0x140 net/ipv4/tcp_metrics.c:567
tcp_fastopen_cookie_check+0x28/0x180 net/ipv4/tcp_fastopen.c:419
tcp_connect+0x9c8/0x12a0 net/ipv4/tcp_output.c:3839
tcp_v4_connect+0x645/0x6e0 net/ipv4/tcp_ipv4.c:323
__inet_stream_connect+0x120/0x590 net/ipv4/af_inet.c:676
tcp_sendmsg_fastopen+0x2d6/0x3a0 net/ipv4/tcp.c:1021
tcp_sendmsg_locked+0x1957/0x1b00 net/ipv4/tcp.c:1073
tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1336
__sock_sendmsg+0x83/0xd0 net/socket.c:730
__sys_sendto+0x20a/0x2a0 net/socket.c:2194
__do_sys_sendto net/socket.c:2206 [inline]

Fixes: e08d0b3d1723 ("inet: implement lockless IP_TOS")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h                                   |  1 +
 net/ipv4/ip_sockglue.c                             | 11 +++++++++--
 net/mptcp/sockopt.c                                |  4 ++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6fbc0dcf4b9780d60b5e5d6f84d6017fbf57d0ae..1fc4c8d69e333e81b6fae1840262df18c2c66e25 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -810,5 +810,6 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
+void  __ip_sock_set_tos(struct sock *sk, int val);
 
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 0b74ac49d6a6f82f5e8ffe5279dba3baf30f874e..9c68b6b74d9f440be279badd8e0d7fe99ee75d0a 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -585,9 +585,9 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return err;
 }
 
-void ip_sock_set_tos(struct sock *sk, int val)
+void __ip_sock_set_tos(struct sock *sk, int val)
 {
-	u8 old_tos = READ_ONCE(inet_sk(sk)->tos);
+	u8 old_tos = inet_sk(sk)->tos;
 
 	if (sk->sk_type == SOCK_STREAM) {
 		val &= ~INET_ECN_MASK;
@@ -599,6 +599,13 @@ void ip_sock_set_tos(struct sock *sk, int val)
 		sk_dst_reset(sk);
 	}
 }
+
+void ip_sock_set_tos(struct sock *sk, int val)
+{
+	lock_sock(sk);
+	__ip_sock_set_tos(sk, val);
+	release_sock(sk);
+}
 EXPORT_SYMBOL(ip_sock_set_tos);
 
 void ip_sock_set_freebind(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 18ce624bfde2a5a451e42148ec7349d1ead2cec3..59bd5e114392a007a71df57217e0ec357aae8229 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -738,7 +738,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		ip_sock_set_tos(ssk, val);
+		__ip_sock_set_tos(ssk, val);
 	}
 	release_sock(sk);
 
@@ -1411,7 +1411,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
 	ssk->sk_ipv6only = sk->sk_ipv6only;
-	ip_sock_set_tos(ssk, inet_sk(sk)->tos);
+	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 61a2a1988ce69ffa17e0dd8e629eac550f4f7d99..b1fc8afd072dc6ddde8d561a675a5549a9a37dba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -716,7 +716,7 @@ run_test_transparent()
 	# the required infrastructure in MPTCP sockopt code. To support TOS, the
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
-	if ! mptcp_lib_kallsyms_has "T ip_sock_set_tos$"; then
+	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
 		echo "INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
-- 
2.42.0.655.g421f12c284-goog


