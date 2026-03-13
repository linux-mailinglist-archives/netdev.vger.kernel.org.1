Return-Path: <netdev+bounces-267299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPe6CfC0s2l5aAAAu9opvQ
	(envelope-from <netdev+bounces-267299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954827E637
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BCDF301AB8B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920430CDAF;
	Fri, 13 Mar 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Sjgk/651"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2D5474F;
	Fri, 13 Mar 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384939; cv=none; b=RNUC5YWRcNPn1a0t2HpYv/a8PlXk4+yZLw0hFFUEHIOWSp1K/4QmAfz/MpLPoQ7qSzl5jUT3IucKlC183LOxKwU/nm9Fvw8uBhtEF1QNggWizfNiC/3KiwDxtCjqNB37jKkxYagVUYZ3RINhAQxttr8jb8cx5jask4oWuOtyb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384939; c=relaxed/simple;
	bh=j3+p5+i5VDxxgE0WM6Ud50FOzeWOCZydwKAn+qv/VSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjhFD9/bv9Of9Lhng0CGUynbhbibw4XXyT7gZDYQH86frW7RlGgQKH8Rq3ELjnOwbVh9D4YRZQJTwMPOdr1uuzyRb22O/UE3+2XB5TvRdNglmC5U5ORdTKFUN3NnsRinrDIQwSmcQlhHiUFcKo4MMqXc486ftAiDBwhgVsfa0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Sjgk/651; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hZnEtLPqcaQ8qA3z/Vzbhjzdoofj5lcVtonecwvZDRM=; b=Sjgk/651R0+MoyArzAn9BLaPmZ
	d/d4NPW7QAzlEBiMU7MT/ihC4nddwki4u8xJCDuOPvsNuoa7yVARPcCAAiTJn6f9Ahwkzo/IMAWqj
	kimTEVuKKoQveZtI6BCzTQbWLkyDFIO8tzjMdKk+cccwsWH6Fvkb1eyBWEzq5JtNjQK6vNucS1jYi
	1VUvPJmU7/7qnAQelCUiC5DIZ8+iJBDQeg4RG013hkKAlHKpgvgcPOBTl1UgtprU0WVy6AGF8n4LY
	yOoaMniWTcbZLjg9ebEn94FWabd6tg4PQfoCM9XkcAgcCFet4fRrFluV9OIyKMzuAqSMG+Kiqb7BZ
	OaxRY0+A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w0wQm-0009qL-1w;
	Fri, 13 Mar 2026 07:55:32 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	Keenan Dong <keenanat2000@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net] clsact: Fix use-after-free in init/destroy rollback asymmetry
Date: Fri, 13 Mar 2026 07:55:31 +0100
Message-ID: <20260313065531.98639-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27938/Thu Mar 12 07:24:01 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267299-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9954827E637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a use-after-free in the clsact qdisc upon init/destroy rollback asymmetry.
The latter is achieved by first fully initializing a clsact instance, and
then in a second step having a replacement failure for the new clsact qdisc
instance. clsact_init() initializes ingress first and then takes care of the
egress part. This can fail midway, for example, via tcf_block_get_ext(). Upon
failure, the kernel will trigger the clsact_destroy() callback.

Commit 1cb6f0bae504 ("bpf: Fix too early release of tcx_entry") details the
way how the transition is happening. If tcf_block_get_ext on the q->ingress_block
ends up failing, we took the tcx_miniq_inc reference count on the ingress
side, but not yet on the egress side. clsact_destroy() tests whether the
{ingress,egress}_entry was non-NULL. However, even in midway failure on the
replacement, both are in fact non-NULL with a valid egress_entry from the
previous clsact instance.

What we really need to test for is whether the qdisc instance-specific ingress
or egress side previously got initialized. This adds a small helper for checking
the miniq initialization called mini_qdisc_pair_inited, and utilizes that upon
clsact_destroy() in order to fix the use-after-free scenario. Convert the
ingress_destroy() side as well so both are consistent to each other.

Fixes: 1cb6f0bae504 ("bpf: Fix too early release of tcx_entry")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/net/sch_generic.h |  5 +++++
 net/sched/sch_ingress.c   | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d5d55cb21686..beeacf2a1229 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1429,6 +1429,11 @@ void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
 				struct tcf_block *block);
 
+static inline bool mini_qdisc_pair_inited(struct mini_Qdisc_pair *miniqp)
+{
+	return !!miniqp->p_miniq;
+}
+
 void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx);
 
 int sch_frag_xmit_hook(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb));
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index cc6051d4f2ef..c3e18bae8fbf 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -113,14 +113,15 @@ static void ingress_destroy(struct Qdisc *sch)
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct bpf_mprog_entry *entry = rtnl_dereference(dev->tcx_ingress);
+	struct bpf_mprog_entry *entry;
 
 	if (sch->parent != TC_H_INGRESS)
 		return;
 
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 
-	if (entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp)) {
+		entry = rtnl_dereference(dev->tcx_ingress);
 		tcx_miniq_dec(entry);
 		if (!tcx_entry_is_active(entry)) {
 			tcx_entry_update(dev, NULL, true);
@@ -290,10 +291,9 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 
 static void clsact_destroy(struct Qdisc *sch)
 {
+	struct bpf_mprog_entry *ingress_entry, *egress_entry;
 	struct clsact_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct bpf_mprog_entry *ingress_entry = rtnl_dereference(dev->tcx_ingress);
-	struct bpf_mprog_entry *egress_entry = rtnl_dereference(dev->tcx_egress);
 
 	if (sch->parent != TC_H_CLSACT)
 		return;
@@ -301,7 +301,8 @@ static void clsact_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 
-	if (ingress_entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp_ingress)) {
+		ingress_entry = rtnl_dereference(dev->tcx_ingress);
 		tcx_miniq_dec(ingress_entry);
 		if (!tcx_entry_is_active(ingress_entry)) {
 			tcx_entry_update(dev, NULL, true);
@@ -309,7 +310,8 @@ static void clsact_destroy(struct Qdisc *sch)
 		}
 	}
 
-	if (egress_entry) {
+	if (mini_qdisc_pair_inited(&q->miniqp_egress)) {
+		egress_entry = rtnl_dereference(dev->tcx_egress);
 		tcx_miniq_dec(egress_entry);
 		if (!tcx_entry_is_active(egress_entry)) {
 			tcx_entry_update(dev, NULL, false);
-- 
2.43.0


