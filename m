Return-Path: <netdev+bounces-286597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HkRNr2yAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FED50C0F7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC238303589A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438853DA5A8;
	Mon, 11 May 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Afyk9n3y"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE23D9026;
	Mon, 11 May 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496137; cv=none; b=Wf1CIV+zHf3f4NZdjYXQ0VesDIP3skB4lLqXlAn+JEnIdUAc4PYsXwTxuTv4oSAxoVloWy0gK+SnD6viTRj2M+wALC8Pnr5xuFVS8P6oanTzLVxLbEr4cMIcsrSYPi7Tbde2kc3JFfMcUcdka37yZuVWhs1B/d+VwPFUTvj68Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496137; c=relaxed/simple;
	bh=gB0St4CQxpXU7gKF9rXtafb1OmVyY/D/UPam9e+oqso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXCR4DaJPXbcpDVYPiFs5vdX4NqleKiSTomfA0dOxL7VU6FbP+kkIXa9II74lTk/IdjVqBN4UInTy5wbA+KxTHqYdTFJGot0YpdD1P2rrc1UMpyWPRnrc/H/OyXtxu/tZI2NIRX874H051i4YuEF4+4p+ZN7fgFY621/OiX9Pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Afyk9n3y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=JpTg0E3qD/O8DeTaZUSnQmT3HKvGWqiv+8u7BGQ9VJ0=; b=Afyk9n3yDjsUKtGOOSiBu+JG4P
	oqkXOHELRk1xIiE9skzzXTskyS/VbLzJKaCHpivIIC0h3dRDDCii07X7wfpkIu5OU5ud6wR3lAUTu
	Z6xB9LhQ0lak2t6ABXW1TriJO1AV1FqoppDqTXNOQ3d6mhz/x6iXeTQ/q2ruI5igVgg2K8Sr7yJOt
	psBMAoYRJl3t/tnmQPpnGi+A1xJwFIVnPlF5u8ftFYOHozunLTwPuZSvJQnCG4Jrb88VN6oPsgql9
	xijVGQd8FOemwKuQsqBsm9xOixcYizQDhJysn7wxkmyOpodL1e2+jAbLN/QNb0pdiIxSdgGpHkuvw
	jvvawcqg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5V-001Xeo-2Z;
	Mon, 11 May 2026 10:42:14 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:49 -0700
Subject: [PATCH net-next 4/7] Bluetooth: RFCOMM: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-4-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=leitao@debian.org;
 h=from:subject:message-id; bh=gB0St4CQxpXU7gKF9rXtafb1OmVyY/D/UPam9e+oqso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvTF8VL3YZdMUJyT8l8qJdVzq0VBXo0AR6Z
 cknCl4WOFuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bbTxD/9Ol78Y43c9IM/BxYRgHM3yTwOjBwnOTmvpvhCijK3NYpl1NnQd3CxMKSjEibUFwKhyqgI
 0Pv1OGnxc41Udg0RpqXpoxKDYetGX/7TEkBE1OvB1bqxLr4qi13JwrBLsfB/Fkbg2LMnBHY04Rh
 K4b90L4voyLrQZpm+O0Er4f/QllppYBdRJfLdCPLFXUSK3ZhLzSeYPSWIMpwQZj152z6035Uogp
 EsyPHhjIv71OyKpHyGC5pYwLLzBOYgSTTUC2Jvj3AF4msCP5hpF8+IEPokfhmSBGqrrcm1QIx3d
 aEllRtjWuLi+UCfu6B/3FW3L31ri8A3QlKqD+z5UXST9RahNNTcc97I1i5pDuJXdxe3lYl/HgjD
 Os/ffB74yaMMTOzCUe1JQ7wZnj3TX1lGAb64GzL5F6hclpMK+o9uOfriUc9e7t0sXydmwbzyA8C
 kCUtv88zlf7iHAAE82HApIhG573zEPnQl1XkdezXIqXZ10fZj/f6ENepRH5QV/0CbNTF4XU1GZz
 jFGoAcMU+c98sm1gVpGYXKkS/7C8udNp4gbfykoI23/1cU0FWdF1xpu7OJFTEM1YmSf12OJvtqw
 Hc/qvx5V5LAmWsclZxPQ/hStJGkiryMTKlO01JlAgCY24d88C9PzOgQbeUoeLZ/vtoPxkUFahqk
 s7N+aiNtqbksTdw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 56FED50C0F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286597-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert RFCOMM socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

The sockopt_t parameter is named sopt rather than opt to avoid
collision with the existing local u32 opt used by RFCOMM_LM.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/rfcomm/sock.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6f590..9b22e4240ed14 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -723,7 +724,8 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
-static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
+static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
+				      sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct sock *l2cap_sk;
@@ -735,8 +737,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 
 	BT_DBG("sk %p", sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -765,7 +766,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		if (rfcomm_pi(sk)->role_switch)
 			opt |= RFCOMM_LM_MASTER;
 
-		if (put_user(opt, (u32 __user *) optval))
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -785,7 +787,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
+		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -799,23 +801,24 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	return err;
 }
 
-static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname,
+				  sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
 	size_t len;
+	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
 	if (level == SOL_RFCOMM)
-		return rfcomm_sock_getsockopt_old(sock, optname, optval, optlen);
+		return rfcomm_sock_getsockopt_old(sock, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -830,7 +833,7 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 		sec.key_size = 0;
 
 		len = min(len, sizeof(sec));
-		if (copy_to_user(optval, (char *) &sec, len))
+		if (copy_to_iter(&sec, len, &sopt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -841,8 +844,9 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 			break;
 		}
 
-		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *) optval))
+		opt = test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		if (copy_to_iter(&opt, sizeof(opt), &sopt->iter_out) !=
+		    sizeof(opt))
 			err = -EFAULT;
 
 		break;
@@ -1014,7 +1018,7 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.recvmsg	= rfcomm_sock_recvmsg,
 	.shutdown	= rfcomm_sock_shutdown,
 	.setsockopt	= rfcomm_sock_setsockopt,
-	.getsockopt	= rfcomm_sock_getsockopt,
+	.getsockopt_iter = rfcomm_sock_getsockopt,
 	.ioctl		= rfcomm_sock_ioctl,
 	.gettstamp	= sock_gettstamp,
 	.poll		= bt_sock_poll,

-- 
2.53.0-Meta


