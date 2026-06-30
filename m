Return-Path: <netdev+bounces-303205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 48vUCozMQ2rZiQoAu9opvQ
	(envelope-from <netdev+bounces-303205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2F6E52E5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:02:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=aZz5Z1DL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303205-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303205-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B911B3041C93
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A40372EE0;
	Tue, 30 Jun 2026 14:02:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AD36C580;
	Tue, 30 Jun 2026 14:01:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828121; cv=none; b=DcdJX+gBj1hNMVkVEeJF4Vv/6IgcHHwFPIYD1+KUcc1Q+gJW3Cv2H6iJf6ARGwFnujgqXckUZNt/zvZ8w4IPpZAbwnhumrG+ol0UzaHsQM54CKUnJ616oJPetHwZTWdoNPHIc+SVmajA31GBrQ6WJFD+Hq7hxp4CJ6RRIsUsoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828121; c=relaxed/simple;
	bh=S3YWFNWPNkC9kZJSH9FPF2+AtJSXIFazRD9WtTjLSfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpiECIl1sxEnnRaUFSAbR3qATtPaVYw0Kx3ujCCzM2YFPvFXWfdTjfU/Soslt+U/rBdy9awFmNYUdXBehZRllR81cESt4VtIW233+mBrq3sG9lgTEqut3OGm/8XrsnEHs4dbZn3mDAtfxlpY3x04TXCwmUNYHIuBEMQanIjuCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aZz5Z1DL; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ndvgMa5fBzPsAMbgG3x1zQ4HPedxS/cCwojyxNDs0jo=; b=aZz5Z1DLYlH+pkabeyMG1uTNBn
	4PBiUBsrVM0IM/smqzVWt6vIl5DHoz5NxxVcp4oZSdAsRGcIGkxa+PjGj7RX0VW3LCSGPIZMW33AN
	OVYArf4Gn32zy5ojHiuYumdVezXncOBdK77oI0ku+aUaCw+yWURUOJa5TGitqp+vdDFmqweEYhdkF
	VkuawEHRZaeSsb1ypOAUbiFBeAfYUX+5acUrFqUX14ocSaJRTYBtYE33EM0bsiIoysSh8SNyejUjK
	47TD/k29W63zkzFgvkdx+43X9+Q4CG5yHKuZivnOaQtH0K19SzpElnbpDTyoT2cwU3Tpk8CyjrGaO
	ZiYcTupQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weZ2D-0077IO-34;
	Tue, 30 Jun 2026 14:01:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 30 Jun 2026 07:01:28 -0700
Subject: [PATCH net-next v2 3/4] ipv4: raw: convert do_raw_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-getsockopt_phase2-v2-3-193335f3d4d1@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; i=leitao@debian.org;
 h=from:subject:message-id; bh=S3YWFNWPNkC9kZJSH9FPF2+AtJSXIFazRD9WtTjLSfo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQ8xEPT8F8Qg0v8gIeJiuTNSukB1tobQurpvQ1
 HsHY+SpxN2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakPMRAAKCRA1o5Of/Hh3
 bWIlEACc8zZFOZt65jI1L3Ntetw9bIn8iAnitvL3XOg27hvFbwWfB85EfnkQmTdARbAjyPrdkZ8
 Q+aJUM6EbsIczku/OZEcmNb/7tn6WRIlPvytvNpYBismcJyKQVRVizRwFRtDyi5T6z2hDB2I+qy
 S3MW78b1x+JF7cY2B+NWwcW/8377Q6J25Z6mCthePbFPc+ttzYJ3kTGlPft3MhGURwn3+epTX7z
 jKUeeeMTtliFCopOccsqh+29cfFFi5VF/ail/ygsKv7CLxz8jnJ9Iew8k19V2xYx8qRZbcXQQMV
 b4X/sQDfsi5dH7xtNEKm12RPybrXXlC4eAOYeN8RlJGgr5ipg85CdpcTjBd8M3vPNW8nhPOZh36
 P3NXTf4HBouK42aEaRjLlZL2WQphJck4IbGfp9j0198A6FLiikgta/odjQq36Xk9VbSJUopLtFo
 CpBdO2jd0jS3MDrYcTOwRYNRkLSar9ORoQgAoQ+2v7k62gV+iGylulgla1hRyn+KKAtKryoco1c
 OLEIzTnbej1pmgRb6DHK8veEgt884yA8qRjUYMngXZv9EdXE/lOkRBsyparorWr8LMfRttE61xO
 8LXC1BvFPGS2L6aHk1cFGfrfmsEKPLKwLQkS87DlNSom2GsOzksDiX3Hg3IjrD8cu8DawCG34Xg
 dnPh2lyPk3j4CZw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303205-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45F2F6E52E5

Continue converting the proto-layer getsockopt callbacks to the sockopt_t
interface, switching do_raw_getsockopt() and its raw_geticmpfilter()
helper to take a sockopt_t.

The thin raw_getsockopt() wrapper keeps its __user signature for now: it
builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
and writes the returned length back to optlen. The helper uses
copy_to_iter() instead of copy_to_user(). No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/raw.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e9fbab6ad9146..2aebaf8297e04 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -809,23 +809,18 @@ static int raw_seticmpfilter(struct sock *sk, sockptr_t optval, int optlen)
 	return 0;
 }
 
-static int raw_geticmpfilter(struct sock *sk, char __user *optval, int __user *optlen)
+static int raw_geticmpfilter(struct sock *sk, sockopt_t *opt)
 {
-	int len, ret = -EFAULT;
+	int len = opt->optlen;
 
-	if (get_user(len, optlen))
-		goto out;
-	ret = -EINVAL;
 	if (len < 0)
-		goto out;
+		return -EINVAL;
 	if (len > sizeof(struct icmp_filter))
 		len = sizeof(struct icmp_filter);
-	ret = -EFAULT;
-	if (put_user(len, optlen) ||
-	    copy_to_user(optval, &raw_sk(sk)->filter, len))
-		goto out;
-	ret = 0;
-out:	return ret;
+	opt->optlen = len;
+	if (copy_to_iter(&raw_sk(sk)->filter, len, &opt->iter_out) != len)
+		return -EFAULT;
+	return 0;
 }
 
 static int do_raw_setsockopt(struct sock *sk, int optname,
@@ -848,14 +843,13 @@ static int raw_setsockopt(struct sock *sk, int level, int optname,
 	return do_raw_setsockopt(sk, optname, optval, optlen);
 }
 
-static int do_raw_getsockopt(struct sock *sk, int optname,
-			     char __user *optval, int __user *optlen)
+static int do_raw_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
 {
 	if (optname == ICMP_FILTER) {
 		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
 			return -EOPNOTSUPP;
 		else
-			return raw_geticmpfilter(sk, optval, optlen);
+			return raw_geticmpfilter(sk, opt);
 	}
 	return -ENOPROTOOPT;
 }
@@ -863,9 +857,24 @@ static int do_raw_getsockopt(struct sock *sk, int optname,
 static int raw_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
+	sockopt_t opt;
+	int err;
+
 	if (level != SOL_RAW)
 		return ip_getsockopt(sk, level, optname, optval, optlen);
-	return do_raw_getsockopt(sk, optname, optval, optlen);
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = do_raw_getsockopt(sk, optname, &opt);
+	if (err)
+		return err;
+
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int raw_ioctl(struct sock *sk, int cmd, int *karg)

-- 
2.53.0-Meta


