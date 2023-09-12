Return-Path: <netdev+bounces-32984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698279C1B0
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B377A281762
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6815A2;
	Tue, 12 Sep 2023 01:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCD1382
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:33:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC811161114
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:33:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b50b45481so44484567b3.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694482426; x=1695087226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWUXE3J5lE0Vw3vlpdHWbtqpp4667kXmYY3wN4ZTMxw=;
        b=Y8PGUpIRv1/mU+bNqdIGS83f/nl+uwdy013YZ4voE7w8rNQMU7f27pDLhd3PmM/Xd6
         ZDgLFspv5MSTMj48WSZQM77DAJROizqiymkxuGU3RE2vU5F3yr1Vz3LsTKJnnH+SOnZm
         XR9U+hfLX1owqOASx4aLsy4kLcIBBsrm2b6cqGGX4oMa0DNXfjSU9io4/zSRlF1ozdjh
         asa/W9QdKnA+60pba38dY2Wx4DhGU2WdbykIh5LcVU4jS52BErC00+eAWlQt6j3MWIgk
         /eTvMc2o4QGmIh6vRCUCbqYypbBHalkfYv1LEOIlwPhu7ipR/TmLbwjTE0JuTGRWd0gH
         jgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694482426; x=1695087226;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWUXE3J5lE0Vw3vlpdHWbtqpp4667kXmYY3wN4ZTMxw=;
        b=F/BNgd9QmAD+kWtoeyNilcUIvSFW5+l/BdDuL4wPM5ueZVzuJO3tUnNlAZBN4MkfPN
         FZEwfoN3n7wO3FqbFP/cfvJHUtixzh8ZwbDBLRAGxgcYc5zmq9BgyX+4w46I7cBRll3/
         liT0Oolf1U1Lz9ey5ayCIqTUgz5zqF37Ot+sG0mdMAy1mAiVBmunFYBDvhdGMDPwA4Gi
         rHdTgbGwPBaqgzoYgOZdIG3rHVOtwpuKMAL3l5mJK9ds/XosDzm3Otgk5HFUNkAhKoL6
         5lLjsTSfwng6c/TWoFnKPihbnBMizeHICLgGVB65HfuPuFp+sIxWtioM8LeS2ulecJzA
         KV+g==
X-Gm-Message-State: AOJu0Yw+5JGF/DmFpn8KeetiKjhnZBuOzplSs0XIyEi3i/Tm1OfWbb+Y
	NRFbncUJ4xy9jd8hHRyPD+Fi0M44kQ==
X-Google-Smtp-Source: AGHT+IEJMnX/iZzjHqedLRgWpMYh6kVIsnhc4IKzTsKgfRLNPS5yCgV4I5pqj13qzpazSIdWD+OGYIiN+Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:df03:0:b0:d35:bf85:5aa0 with SMTP id
 w3-20020a25df03000000b00d35bf855aa0mr264120ybg.4.1694482425954; Mon, 11 Sep
 2023 18:33:45 -0700 (PDT)
Date: Mon, 11 Sep 2023 20:33:31 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912013332.2048422-1-jrife@google.com>
Subject: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that kernel_connect() will not overwrite the address parameter
in cases where BPF connect hooks perform an address rewrite. However,
there remain other cases where BPF hooks can overwrite an address held
by a kernel client.

==Scenarios Tested==

* Code in the SMB and Ceph modules calls sock->ops->connect() directly,
  allowing the address overwrite to occur. In the case of SMB, this can
  lead to broken mounts.
* NFS v3 mounts with proto=udp call sock_sendmsg() for each RPC call,
  passing a pointer to the mount address in msg->msg_name which is
  later overwritten by a BPF sendmsg hook. This can lead to broken NFS
  mounts.

In order to more comprehensively fix this class of problems, this patch
pushes the address copy deeper into the stack and introduces an address
copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all callers
from address rewrites.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/af_inet.c | 18 ++++++++++++++++++
 net/ipv4/udp.c     | 21 ++++++++++++++++-----
 net/ipv6/udp.c     | 23 +++++++++++++++++------
 net/socket.c       |  7 +------
 4 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3d2e30e204735..c37d484fbee34 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -568,6 +568,7 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 {
 	struct sock *sk = sock->sk;
 	const struct proto *prot;
+	struct sockaddr_storage addr;
 	int err;
 
 	if (addr_len < sizeof(uaddr->sa_family))
@@ -580,6 +581,14 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
+		if (uaddr && addr_len <= sizeof(addr)) {
+			/* pre_connect can rewrite uaddr, so make a copy to
+			 * insulate the caller.
+			 */
+			memcpy(&addr, uaddr, addr_len);
+			uaddr = (struct sockaddr *)&addr;
+		}
+
 		err = prot->pre_connect(sk, uaddr, addr_len);
 		if (err)
 			return err;
@@ -625,6 +634,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			  int addr_len, int flags, int is_sendmsg)
 {
 	struct sock *sk = sock->sk;
+	struct sockaddr_storage addr;
 	int err;
 	long timeo;
 
@@ -668,6 +678,14 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			goto out;
 
 		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
+			if (uaddr && addr_len <= sizeof(addr)) {
+				/* pre_connect can rewrite uaddr, so make a copy to
+				 * insulate the caller.
+				 */
+				memcpy(&addr, uaddr, addr_len);
+				uaddr = (struct sockaddr *)&addr;
+			}
+
 			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
 			if (err)
 				goto out;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c8445808..5f5ee2752eeb7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1142,18 +1142,29 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
+		struct sockaddr_in tmp_addr;
+		struct sockaddr_in *addr = usin;
+
+		/* BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK can rewrite usin, so make a
+		 * copy to insulate the caller.
+		 */
+		if (usin && msg->msg_namelen <= sizeof(tmp_addr)) {
+			memcpy(&tmp_addr, usin, msg->msg_namelen);
+			addr = &tmp_addr;
+		}
+
 		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin, &ipc.addr);
+					    (struct sockaddr *)addr, &ipc.addr);
 		if (err)
 			goto out_free;
-		if (usin) {
-			if (usin->sin_port == 0) {
+		if (addr) {
+			if (addr->sin_port == 0) {
 				/* BPF program set invalid port. Reject it. */
 				err = -EINVAL;
 				goto out_free;
 			}
-			daddr = usin->sin_addr.s_addr;
-			dport = usin->sin_port;
+			daddr = addr->sin_addr.s_addr;
+			dport = addr->sin_port;
 		}
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a4688..cbc1917fad629 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1506,26 +1506,37 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6->fl6_sport = inet->inet_sport;
 
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
+		struct sockaddr_in6 tmp_addr;
+		struct sockaddr_in6 *addr = sin6;
+
+		/* BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK can rewrite sin6, so make a
+		 * copy to insulate the caller.
+		 */
+		if (sin6 && addr_len <= sizeof(tmp_addr)) {
+			memcpy(&tmp_addr, sin6, addr_len);
+			addr = &tmp_addr;
+		}
+
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
-					   (struct sockaddr *)sin6,
+					   (struct sockaddr *)addr,
 					   &fl6->saddr);
 		if (err)
 			goto out_no_dst;
-		if (sin6) {
-			if (ipv6_addr_v4mapped(&sin6->sin6_addr)) {
+		if (addr) {
+			if (ipv6_addr_v4mapped(&addr->sin6_addr)) {
 				/* BPF program rewrote IPv6-only by IPv4-mapped
 				 * IPv6. It's currently unsupported.
 				 */
 				err = -ENOTSUPP;
 				goto out_no_dst;
 			}
-			if (sin6->sin6_port == 0) {
+			if (addr->sin6_port == 0) {
 				/* BPF program set invalid port. Reject it. */
 				err = -EINVAL;
 				goto out_no_dst;
 			}
-			fl6->fl6_dport = sin6->sin6_port;
-			fl6->daddr = sin6->sin6_addr;
+			fl6->fl6_dport = addr->sin6_port;
+			fl6->daddr = addr->sin6_addr;
 		}
 	}
 
diff --git a/net/socket.c b/net/socket.c
index c8b08b32f097e..39794d026fa11 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3570,12 +3570,7 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	struct sockaddr_storage address;
-
-	memcpy(&address, addr, addrlen);
-
-	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
-					     addrlen, flags);
+	return READ_ONCE(sock->ops)->connect(sock, addr, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
-- 
2.42.0.283.g2d96d420d3-goog


