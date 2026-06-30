Return-Path: <netdev+bounces-303204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dn++EaDNQ2qEigoAu9opvQ
	(envelope-from <netdev+bounces-303204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:07:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A86E53A1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:07:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=DxBw5Qg4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303204-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD6331266ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364F2F0680;
	Tue, 30 Jun 2026 14:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6224A06A;
	Tue, 30 Jun 2026 14:01:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828117; cv=none; b=WE8i0sc8t1RwfoeegVeOqTuiJlY/iDroSpznt4k1cJ5HM6A6mzJh63WQITTiL+W3Y0VIeiWyG1gXssQO8CtDq/b84hOYutP33fMxhNIutUyk5BobEHASpcB6eRJKEoXr+xQBJTT+dSYCTBzGQHVJ18FDQmUw6bb5FFifdLaZrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828117; c=relaxed/simple;
	bh=HZc2BEXf+ysLeiL07xUt7XZS86DwsXs6gxJQ3lAPFDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtlqRMKKCM9TM6ejNbUwHgdZ/UNARxhrsQ7NOBhUfu7npRKBXae3I9OG17SQM+1KjcevKDq0IFMGD9zff6koOfptFFNc7NOohzSYGSOUeOiZvDfmavmUqRoQcQDg6Bz/qIZGFq962hnCwZrbr6PXBZP3Rjm8ir7GWgP1LiyV2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DxBw5Qg4; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=MEep7DEWjEwkHOcChn0k8KjEMKULC97jHYv3rGPYkvI=; b=DxBw5Qg4WLA2/B+1j409MjINCj
	BTpcmfu3ilojQI5brzEYIz2zajcLuRSgadlvJd09y8ESiWHvIiSWx0Xc3ecfq0wUrtSqSM2MvluX7
	omT70jOpXfN8uYBGoXEEqS7NIwak/Ajf25/og6DpP8i0x57g/fo5yll2/Auy8t+OC5SdxdqrMucQJ
	ImInYouDr2HObX5S32KfulIJHyl/+BldOydL84N6w9pXnzQi4jll0REnP1pDlEIv+lcVZGwpCRXnl
	c60DBIqxXd8nRbYq+dSwa+cpT4NfXk3DfWzKg6ZgIZ0z0gUJB2o6a9k1UItO0kI6f8U1ulVfOZbVd
	Yt4wdskw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weZ29-0077I7-2W;
	Tue, 30 Jun 2026 14:01:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 30 Jun 2026 07:01:27 -0700
Subject: [PATCH net-next v2 2/4] udp: convert udp_lib_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-getsockopt_phase2-v2-2-193335f3d4d1@debian.org>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
In-Reply-To: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=leitao@debian.org;
 h=from:subject:message-id; bh=HZc2BEXf+ysLeiL07xUt7XZS86DwsXs6gxJQ3lAPFDY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQ8xEZeEmUwRp75w0MgGIbYrhWb9OCf/CAAa8G
 5jr5KzlnW+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakPMRAAKCRA1o5Of/Hh3
 bcw8D/9gVr3/5sRDkqLbnKO7VnY506xcmF+xEX+XjB5ihucoX628WQUE2ft6jpZvB+ek+QDGNl7
 QnpCr13rjth/A3ToJdUzFbsj2Ea0oyO6KOKKwOuXIaomRuDQlS0IE8bz2hEUAD2HQ1JtCk3a0tQ
 8MUYsMh2Aje79B0pZgY3vTKtUKLKb0kucKSzYlt3azYIbmi5CjvkF/8Dlrd4L4jfaZiyJbpGK5w
 TB0TLjjRzl2gGNFOW/PIKRzbomWftXumXB/u5tTXI5a1XpyHj6Q/QwJZQKyqtSI9hhfLpXdhzU6
 SUy3yWD2vg3WoAx9wi6w3BSsKmdCnZjfKkpwKFTWOtpp+6Hgzrg2x27hrdesAJUbHeWRYLZDWRT
 RO0GSqLvvSTeOeXn+Tp9Wqp1vHZHj7TUKblTE0nZwype2++xEjksE3hgJq68SgScRBZy91CbAyk
 5vRVPHRESCoUCUsAAOzyGBYiDPHB0vMI2Kq1nd+sByGXAM8T6hDbxnJCgpjqmmNwSjOsDGP4Fs7
 186Qqx2IESuX3z17r+OQtUHsNxp+77p5ow3neJnGfffOwlVrbhWwFk3V5vu96XODsvMK+Kb/BtP
 whH6q4qO/btm5+Wv7wfTXHwQlXShLKBPdZRnpZWyqxu0liQBKCzYkJXjIB8moT0fvtu2CjaLkcw
 s6mvMSwevdYIsiQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303204-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B24A86E53A1

In preparation for converting the proto-layer getsockopt callbacks to the
sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.

The thin udp_getsockopt()/udpv6_getsockopt() wrappers keep their __user
signature for now: they build a user-backed sockopt_t with
sockopt_init_user(), call the helper, and write the returned length back
to optlen. The helper uses copy_to_iter() instead of copy_to_user().
No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/udp.h |  2 +-
 net/ipv4/udp.c    | 39 +++++++++++++++++++++++++++++----------
 net/ipv6/udp.c    | 19 ++++++++++++++++---
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 8262e2b215b4e..1fee17274745f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -430,7 +430,7 @@ struct sk_buff *skb_udp_tunnel_segment(struct sk_buff *skb,
 				       netdev_features_t features,
 				       bool is_ipv6);
 int udp_lib_getsockopt(struct sock *sk, int level, int optname,
-		       char __user *optval, int __user *optlen);
+		       sockopt_t *opt);
 int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen,
 		       int (*push_pending_frames)(struct sock *));
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 70f6cbd4ef73b..59248a59358ca 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -76,6 +76,7 @@
 
 #include <linux/bpf-cgroup.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/ioctls.h>
 #include <linux/memblock.h>
 #include <linux/highmem.h>
@@ -2995,14 +2996,13 @@ static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt
 }
 
 int udp_lib_getsockopt(struct sock *sk, int level, int optname,
-		       char __user *optval, int __user *optlen)
+		       sockopt_t *opt)
 {
 	struct udp_sock *up = udp_sk(sk);
 	int val, len;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
+	len = opt->optlen;
+	/* keep the check so direct sockopt_t callers stay covered. */
 	if (len < 0)
 		return -EINVAL;
 
@@ -3037,9 +3037,8 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -3047,9 +3046,29 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 static int udp_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
-	if (level == SOL_UDP)
-		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
-	return ip_getsockopt(sk, level, optname, optval, optlen);
+	sockopt_t opt;
+	int err;
+
+	/*
+	 * keep the old __user pointers, until ip_getsockopt() moves
+	 * to sockopt_t
+	 */
+	if (level != SOL_UDP)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = udp_lib_getsockopt(sk, level, optname, &opt);
+	if (err)
+		return err;
+
+	/* optval was written by copy_to_iter() in udp_lib_getsockopt() */
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
 }
 
 /**
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194eccc..392e18b970454 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1826,9 +1826,22 @@ static int udpv6_setsockopt(struct sock *sk, int level, int optname,
 static int udpv6_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, int __user *optlen)
 {
-	if (level == SOL_UDP)
-		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
-	return ipv6_getsockopt(sk, level, optname, optval, optlen);
+	sockopt_t opt;
+	int err;
+
+	if (level != SOL_UDP)
+		return ipv6_getsockopt(sk, level, optname, optval, optlen);
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = udp_lib_getsockopt(sk, level, optname, &opt);
+	if (err)
+		return err;
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+	return 0;
 }
 
 

-- 
2.53.0-Meta


