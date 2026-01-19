Return-Path: <netdev+bounces-251013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BDD3A245
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C953064C0E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0253502B7;
	Mon, 19 Jan 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="y1usbb4a"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752B2A1CF;
	Mon, 19 Jan 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812901; cv=none; b=R2LV5JA3yc/TheoxGF0+a1HF3HRwsPIZtg/d7YC7np6KLGGOteFxBrNtGZkgRjtsh42+CnjgqN+HMwxjl/HQj5i3PhuhK0x1Tbfe4XRjAbq9zh/aMrjadrp6xHRIGw1XKOGJ6V/CwFkt/C3hwdcJhN3UJ+0OpmSmFgBDjNveQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812901; c=relaxed/simple;
	bh=VjsiqB54qWZdPQv3Tety+U4rsYdcSSnOhw58Xod2OC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFdyl5EXDaRXmhqA3kPMId8kDB4l+HsA6zqSAlWDrg+ovorVNe1TMmQJ/Hc/HVIPXNzjJPsHaO6lQMl61gQdvXR27iTdt/I9RDSDEX3+HyKgyV/pwiMY2IZ+iBA2PLOYaHwyxg9DPJdm/jZUdOjYLix3gswTmBy+hVCBk/mW8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=y1usbb4a; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CF8F820660;
	Mon, 19 Jan 2026 09:54:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0pSbRWt0lPs0; Mon, 19 Jan 2026 09:54:56 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 24DCF201C7;
	Mon, 19 Jan 2026 09:54:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 24DCF201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768812896;
	bh=02tFdjTCBGuWIj8XS4z95Xz466D/MYvWk8hj4144Clw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=y1usbb4ausSvabThAl/FizoTt7fZowD+5tQHC4GbZWHOefqVtOZ2E2JHaRaQJuM2S
	 Kav5kv1AqnLjYn/aIpvXnSowDQuq/jBGb3RttnNS/edJo8UqnvkoypR7qZKWbDnb5A
	 47KGYTnj/VlTV2Kp1iL8ObmAirklI8nWJrGqIeBnUC4uzU8pDmZNgO378Zewix6wGj
	 1OAvpk+iTsah+CiHzeo4vSG1V3nM25jKEcJZRZx4dIbm0yfK2Buu4tl9oCPYEcTrGN
	 Z4RkX3sTBEZWfpi3yov82eHFSkRviZw5Ykip3yR25M4Jt0lLz1WkiYdO1ICJBUR92Q
	 EglDTlgVu+Gwg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:54:55 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v4 4/5] xfrm: rename reqid in xfrm_migrate
Date: Mon, 19 Jan 2026 09:54:41 +0100
Message-ID: <f9b0c8b9d47b3ca4effa4a9c7e1176b038d5fe63.1768811736.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768811736.git.antony.antony@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

In preparation for the following patch rename s/reqid/old_reqid/.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h     |  2 +-
 net/key/af_key.c       | 10 +++++-----
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  6 +++---
 net/xfrm/xfrm_user.c   |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0a14daaa5dd4..05fa0552523d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -685,7 +685,7 @@ struct xfrm_migrate {
 	u8			proto;
 	u8			mode;
 	u16			reserved;
-	u32			reqid;
+	u32			old_reqid;
 	u16			old_family;
 	u16			new_family;
 };
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 571200433aa9..a856bdd0c0d7 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2538,7 +2538,7 @@ static int ipsecrequests_to_migrate(struct sadb_x_ipsecrequest *rq1, int len,
 	if ((mode = pfkey_mode_to_xfrm(rq1->sadb_x_ipsecrequest_mode)) < 0)
 		return -EINVAL;
 	m->mode = mode;
-	m->reqid = rq1->sadb_x_ipsecrequest_reqid;
+	m->old_reqid = rq1->sadb_x_ipsecrequest_reqid;

 	return ((int)(rq1->sadb_x_ipsecrequest_len +
 		      rq2->sadb_x_ipsecrequest_len));
@@ -3634,15 +3634,15 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if (mode < 0)
 			goto err;
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ?  IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->old_family,
+				     (mp->old_reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->old_family,
 				     &mp->old_saddr, &mp->old_daddr) < 0)
 			goto err;

 		/* new ipsecrequest */
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->new_family,
+				     (mp->old_reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->new_family,
 				     &mp->new_saddr, &mp->new_daddr) < 0)
 			goto err;
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..854dfc16ed55 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4530,7 +4530,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
 	int match = 0;

 	if (t->mode == m->mode && t->id.proto == m->proto &&
-	    (m->reqid == 0 || t->reqid == m->reqid)) {
+	    (m->old_reqid == 0 || t->reqid == m->old_reqid)) {
 		switch (t->mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
@@ -4624,7 +4624,7 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 				    sizeof(m[i].old_saddr)) &&
 			    m[i].proto == m[j].proto &&
 			    m[i].mode == m[j].mode &&
-			    m[i].reqid == m[j].reqid &&
+			    m[i].old_reqid == m[j].old_reqid &&
 			    m[i].old_family == m[j].old_family) {
 				NL_SET_ERR_MSG(extack, "Entries in the MIGRATE attribute's list must be unique");
 				return -EINVAL;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f5f699f5f98e..fe595d7f4398 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2080,14 +2080,14 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n

 	spin_lock_bh(&net->xfrm.xfrm_state_lock);

-	if (m->reqid) {
+	if (m->old_reqid) {
 		h = xfrm_dst_hash(net, &m->old_daddr, &m->old_saddr,
-				  m->reqid, m->old_family);
+				  m->old_reqid, m->old_family);
 		hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
-			if (m->reqid && x->props.reqid != m->reqid)
+			if (m->old_reqid && x->props.reqid != m->old_reqid)
 				continue;
 			if (if_id != 0 && x->if_id != if_id)
 				continue;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..26b82d94acc1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3087,7 +3087,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,

 		ma->proto = um->proto;
 		ma->mode = um->mode;
-		ma->reqid = um->reqid;
+		ma->old_reqid = um->reqid;

 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3170,7 +3170,7 @@ static int copy_to_user_migrate(const struct xfrm_migrate *m, struct sk_buff *sk
 	memset(&um, 0, sizeof(um));
 	um.proto = m->proto;
 	um.mode = m->mode;
-	um.reqid = m->reqid;
+	um.reqid = m->old_reqid;
 	um.old_family = m->old_family;
 	memcpy(&um.old_daddr, &m->old_daddr, sizeof(um.old_daddr));
 	memcpy(&um.old_saddr, &m->old_saddr, sizeof(um.old_saddr));
--
2.39.5


