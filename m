Return-Path: <netdev+bounces-298618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7iw3Ds3yK2qAIQQAu9opvQ
	(envelope-from <netdev+bounces-298618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5976791FA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:51:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=JyzzVKXi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298618-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298618-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B9B131F5102
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885D3EB11F;
	Fri, 12 Jun 2026 11:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6A3EB115;
	Fri, 12 Jun 2026 11:45:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264731; cv=none; b=GfBAmZRz0lCkuGIBNVRbhuS8DNZkcm1olWqP02en80SjjZrk3rpw8RgeRStCk+81YSS4Kz71tvBLidwCWbdsdaJOfh7b/PpXLFuhuYaEqvjQAEqLTT6gWpB2/14+6iTlAsKebKqAftML8HyocZ+O0Nzq1wc+R/KKj8DtKngrY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264731; c=relaxed/simple;
	bh=2EKhKE+g+2PVQ83P2KF3Jx1/ZtlUCH0luQ/9Bn056qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaHFm9hmcCf7ZYdtuzdszQbdFQ1gs0Xk6btCWq7Dxz604Z4HSjU7OPp6tRrwH5U/MLtMLgZwsW8juJR4BYCl3BYdghR60Z32tVo5nX7icTCKHFB66BeTtS50lUubDv+WKPsJaLxCBt8C+eTKKF3d9uiyQiw+eltaFSLRKDw6BMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JyzzVKXi; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=hQSih0WSdzvp0lXq/60yeOgfYWs/GUe5DctMpTTKNYo=; b=JyzzVKXiIpDRLe7vIVthMZ/5s8
	uGGsrzyCDO3lWdEbUZ6JauXUowzv9NXTx4QjkIVTVZefGHoHgD8yOjTZk6Du2/NzJlH6PRdm8FYTx
	II6OnNPDmUeXouqS3xq7tnNhe4RkKu7gtdbGTABDoWxapwDFmj749myUZ36kEruTKxoOx1sry65Wy
	IdLuF6s1+CyQ3HJwS+P4j/H/4hr2LDjRjHXzEa7GJpPIZ3u6BTnpo5Mzg3HhXI1Nba1W01wN2JIOq
	ii+AYPK+owegLOXj9565pkvFM9pkqe2OdoHt+fYVK65fZlnq3KqNo/wtZyw2Agzv88k6EJUAxM49Y
	coyWeMRw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wY0KE-00Ai6m-1J;
	Fri, 12 Jun 2026 11:45:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Jun 2026 04:45:06 -0700
Subject: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
In-Reply-To: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4308; i=leitao@debian.org;
 h=from:subject:message-id; bh=2EKhKE+g+2PVQ83P2KF3Jx1/ZtlUCH0luQ/9Bn056qI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqK/FKqS+JOleNJffNTE/8teKrHcgEiuVlFyMpQ
 UzZmtwpbKOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaivxSgAKCRA1o5Of/Hh3
 bbBgD/9TU3fg1NV5dlmOJ1DWOQ/ybQCGpsYxlYXUFn6mpEGpzET8FfaH0+dooK3wa2KwiZerioS
 XrO2kDdOJJXYbeH8KfJ+YyyliY1FF19Xd1nslS5BC4tbCa9nuthKKEWd/vpkYZVaaji3/rSW5rh
 r5Mj6R3Hopfw4onXwlMqNDjPbonvzth78T4IdBSMNWU0U3yKqnx7DbzgDwBhprbxsOKm31K7+r8
 Iyb9kCQL+nIU0dGJ986VI1FGngMKgGOOjYUM02Q4g6/xypOSvHH3oy9qnpDIFR6q9kDOVpll7DF
 D8SlDg5m7BTjW/niyVhLP9Z0vBAcCjlZ0SIQrca41AQWSnWmOfWAL7y0Q/CG0hvhEGaSf+SEMMq
 6jjOX9NZJy0vpwZVbz2b4C8A7p5RBnrWu2DYpr7igoXbgCPwHux2f8EV3eUZMnzSVWOdxjLhBic
 +/Z5N3+H2a0MyEK14EmIYWAXrHCLAOzfcrHjLEJd1OvebspIhcdwDyumKy8XOxBJg5kKMSIZAUv
 8NFsEonsHM3lJaM9/Zj+M1SoG4Zz5XDMiO/uH2DiK+Y7Ud+5WOGHJmLHkOczantITmYTuIDxbQJ
 N5YKXsJtN3hDmhx+inxOvqm/xQdGuDSXlKlpWd2kboZV4kZr8BZAOKSu7xuW1XOq4LMKbW/gbdw
 52mqdFQ3uTEG57A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298618-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E5976791FA

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
 net/ipv4/udp.c    | 40 ++++++++++++++++++++++++++--------------
 net/ipv6/udp.c    | 17 ++++++++++++++---
 3 files changed, 41 insertions(+), 18 deletions(-)

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
index 70f6cbd4ef73b..0691f74db2c11 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -76,6 +76,7 @@
 
 #include <linux/bpf-cgroup.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/ioctls.h>
 #include <linux/memblock.h>
 #include <linux/highmem.h>
@@ -2995,18 +2996,12 @@ static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt
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
-	if (len < 0)
-		return -EINVAL;
-
-	len = min_t(unsigned int, len, sizeof(int));
+	len = min_t(unsigned int, opt->optlen, sizeof(int));
 
 	switch (optname) {
 	case UDP_CORK:
@@ -3037,9 +3032,8 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
@@ -3047,9 +3041,27 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
+	/* indepedendent of the err, return optlen */
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+	/* Optval was updated in copy_to_iter in udp_lib_getsockopt() */
+
+	return err;
 }
 
 /**
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194eccc..731122deed8a5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1826,9 +1826,20 @@ static int udpv6_setsockopt(struct sock *sk, int level, int optname,
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
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+	return err;
 }
 
 

-- 
2.53.0-Meta


