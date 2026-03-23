Return-Path: <netdev+bounces-270415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GiWCH77wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6262EE4E5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57CBB3023050
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB363806B0;
	Mon, 23 Mar 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hM0frUcr"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9F3815D8
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254906; cv=none; b=XkevjlFxEQlKfYJmBs/xWZewetMsYsKbVgMalrFJyQxfUUmi+J3/Hj1jLcf6jgfQG78nQNEXY5yGIs8TB7BLySRgJ51IVR9b3nvVa5Ov9hzH2KDUoPbKQ98jDG519V/W+Pu8JBe2f/lHKMRjUUYZH0KZk8POzgu/ejU2rJGB30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254906; c=relaxed/simple;
	bh=O5hMB+pWMcQoDwmGWSnXYxVYEctwJVXU5eSsATx8UGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdqUIFHfhbaPPq2ReXtadmultrD4MRfGMzdrm7K6iyPpa/09A09OhtPKUGIW6TGmaU5oaUnN48QGIygUSIOXa/+jfcpnZXGeMbCUSy5r4r85n0MNBav1IqVNnAQGnxqREhGUWcphrON7bkmLe7cxMK7aXIuWzyfiMmgA1XHn1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hM0frUcr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A9715207BE;
	Mon, 23 Mar 2026 09:35:03 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NBH-bCH456Hv; Mon, 23 Mar 2026 09:35:03 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DED9A206DF;
	Mon, 23 Mar 2026 09:35:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DED9A206DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254902;
	bh=6D2vSnNmqhKodlvgFilkF1Xh4fISJr3tdQ7IBoGCE5c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hM0frUcrV20XqpL0Yi7hnbdqNINcdCe9jargwYJUZlN0uw4jCE2Se40O9lQSLL8Ys
	 yKjlswoTidghLgQR93aGMurNDikFwzSTPHEy7h4DLMxq854oaJw1Td5KgsoA4Q2i0T
	 Qt2v3OIcgZBDwfaRJoF43AsOg7VxAJDQrpDOcea1OH/rdB8SMxLRkD0p+3U+RD8SsB
	 qUpJtn+sf/eR7eixL60din+zBMN/yrEKSfT/mG6gtHK/Uvjf/K9ySyqxtWVhdSYx6S
	 J8WJVJxSsYX2PRZQkDLoSD8K0EVG8WO0rImOeedsiItyP2V7dYOCSDnCcW43SiTKSE
	 W6Ixc6TtIObqA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:02 +0100
Received: (nullmailer pid 2741827 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/20] xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
Date: Mon, 23 Mar 2026 09:33:51 +0100
Message-ID: <20260323083440.2741292-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D6262EE4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

We're under xfrm_state_lock for all those walks, we can use
xfrm_state_deref_prot to silence sparse warnings such as:

net/xfrm/xfrm_state.c:933:17: warning: dereference of noderef expression

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 34cf9f361683..27192b11be43 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -870,7 +870,7 @@ xfrm_state_flush_secctx_check(struct net *net, u8 proto, bool task_valid)
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
 
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			if (xfrm_id_proto_match(x->id.proto, proto) &&
 			   (err = security_xfrm_state_delete(x)) != 0) {
 				xfrm_audit_state_delete(x, 0, task_valid);
@@ -891,7 +891,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 		struct xfrm_state *x;
 		struct xfrm_dev_offload *xso;
 
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			xso = &x->xso;
 
 			if (xso->dev == dev &&
@@ -931,7 +931,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
 restart:
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			if (!xfrm_state_kern(x) &&
 			    xfrm_id_proto_match(x->id.proto, proto)) {
 				xfrm_state_hold(x);
@@ -973,7 +973,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 restart:
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			xso = &x->xso;
 
 			if (!xfrm_state_kern(x) && xso->dev == dev) {
@@ -1652,7 +1652,7 @@ xfrm_stateonly_find(struct net *net, u32 mark, u32 if_id,
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	h = xfrm_dst_hash(net, daddr, saddr, reqid, family);
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.family == family &&
 		    x->props.reqid == reqid &&
 		    (mark & x->mark.m) == x->mark.v &&
@@ -1779,7 +1779,7 @@ static void __xfrm_state_bump_genids(struct xfrm_state *xnew)
 	u32 cpu_id = xnew->pcpu_num;
 
 	h = xfrm_dst_hash(net, &xnew->id.daddr, &xnew->props.saddr, reqid, family);
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.family	== family &&
 		    x->props.reqid	== reqid &&
 		    x->if_id		== if_id &&
@@ -1815,7 +1815,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 	struct xfrm_state *x;
 	u32 mark = m->v & m->m;
 
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.reqid  != reqid ||
 		    x->props.mode   != mode ||
 		    x->props.family != family ||
@@ -2097,7 +2097,7 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 	if (m->reqid) {
 		h = xfrm_dst_hash(net, &m->old_daddr, &m->old_saddr,
 				  m->reqid, m->old_family);
-		hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
@@ -2116,7 +2116,7 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 	} else {
 		h = xfrm_src_hash(net, &m->old_daddr, &m->old_saddr,
 				  m->old_family);
-		hlist_for_each_entry(x, net->xfrm.state_bysrc+h, bysrc) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h, bysrc) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
@@ -2319,7 +2319,7 @@ void xfrm_state_update_stats(struct net *net)
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		hlist_for_each_entry(x, net->xfrm.state_bydst + i, bydst)
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst)
 			xfrm_dev_state_update_stats(x);
 	}
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
@@ -2510,7 +2510,7 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	unsigned int h = xfrm_seq_hash(net, seq);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byseq + h, byseq) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h, byseq) {
 		if (x->km.seq == seq &&
 		    (mark & x->mark.m) == x->mark.v &&
 		    x->pcpu_num == pcpu_num &&
-- 
2.43.0


