Return-Path: <netdev+bounces-305967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eV6qGeKeTmprQwIAu9opvQ
	(envelope-from <netdev+bounces-305967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3BB729C4E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:02:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nYTnqZkV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305967-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305967-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5208306AEA4
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D031987D;
	Wed,  8 Jul 2026 19:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A3270540
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 19:02:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537337; cv=none; b=iVshYoPXG1FbhilHv/HbJP5k+mfwrRJNcUhlAb6bfCw/qM9RlNPUqpU7KlQce+4daurwN/qgMUuvRY8J9f+xnBtGq8Xy6CLwt/J3H8QHR8E9d8HIrMYoiIDYWCmVaf+jue9vjSFVMvV5zmIPiFvQUbJAMp1OkeqWYi66dcX6I4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537337; c=relaxed/simple;
	bh=Vif2MjHiTHDnsG7KTlzPaYWpFdvuZkkTzLfu8U72/eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QL4idUpoHoi8PLVHfPMZzxU/GKE3HuvdWrf30gtEJO3U78HlqZIXoLXpbXU0HcFs8VAbDjKHLfZu/UA/zPP3OVaXzYc/nfo58X/sydMt+HnymdGInTZNAkwbKswQfEMC7k5mVH73+yJ0Elfr5M+Pt/nILvqG090xZbDZAs4YHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYTnqZkV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA87A1F00AC4;
	Wed,  8 Jul 2026 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537335;
	bh=HpVymHzVcb0QxYp1ZYts3vB/+YwjzHrrzmF1p+frD+o=;
	h=From:Date:Subject:To:Cc;
	b=nYTnqZkVRvkS2pnSXQePYnRHIqVOBaY4m1CxiwAyJzi8lWPF5KuEmar0cEpvSEU98
	 Y1RuDPG5L+4q/CJE+8DmVW4GCSbRjw25KJqKYHYx+e+rOKIK5IcQnhDn7EpgAqneTa
	 qvft1/SpYTWSi1dohyi+ENMSg+ayUquwc9UZaQPpw/WNkx5uKvu5JlFHQQzRf+1ZHb
	 2+OLTcpEEF4L1w0l0h0zyJ/vxWm67LnRIGSk4hqWNHXeIM4jycP6oeX876tS7h5Uz8
	 zKpcb2YWjbUxBq39mlg5K7JcmgHsBYzbXjzKpEFew5QoYQ3Y91RtiKxJLtCgTWA6lP
	 6JqOMLG+PGY5A==
From: Simon Horman <horms@kernel.org>
Date: Wed, 08 Jul 2026 20:02:05 +0100
Subject: [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKyeTmoC/x3MQQqAMAwAwa9IzgaiSKt+RTyIxhqQKG2RQvHvF
 o8Dy2YI7IUDjFUGz48EubSgqStYj0Udo2zF0FJryFKPLt7oo55I1mw0GNvx3kDJb8+7pH81gXJ
 E5RRhft8PecCyXGQAAAA=
X-Change-ID: 20260708-gtp-rtnl-076d09674ef1
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Harald Welte <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF3BB729C4E

This reverts commit 0be5c3f0fbef3679f50f345b9237b8f9ea5de4e9.

Commit 0be5c3f0fbef ("gtp: annotate PDP lookups under RTNL") added a
lockdep_rtnl_is_held condition to hlist_for_each_rcu() loops to help
insure that RTNL is held.

Unfortunately, as pointed out by Pablo Neira Ayuso, the PDP context list
is actually protected by the genetlink mutex. And so the condition
is incorrect.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/gtp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4ad9528322c45c4511a2cde02d3ca7c8faea3758..a60ef32b35b8255a17bed3fbc6ce19f26b3ba3a8 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -151,8 +151,7 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
-				 lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
@@ -169,8 +168,7 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
-				 lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
@@ -187,8 +185,7 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
-				 lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms.addr.s_addr == ms_addr)
 			return pdp;
@@ -223,8 +220,7 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 
 	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
-				 lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
 		if (pdp->af == AF_INET6 &&
 		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
 			return pdp;




