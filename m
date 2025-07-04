Return-Path: <netdev+bounces-204183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2AAF9617
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061FC3AEBD9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C427E1A1;
	Fri,  4 Jul 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LjP3c9/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k066FzHc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4071D54D8
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640904; cv=none; b=fKxU9xsF8wYg/kL9j2PH3Aozhm/Da5JZbHpFVZ2qvbRvg+CAzFXlCeyArrXtFHYB8j4JGFCGgpc9b/B6tIWHLvNLCTwA3nRO6wF3p+xG0KE/nmuRU2foWCxPDvOlHt7XTwhry91/5tgB7uOrixpG1sbfj7vzb0pO9Crz5n9PooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640904; c=relaxed/simple;
	bh=dCvk78irN0+rDCRbS+eOntiWo65ZQu/dx7l6taAH3EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uipwq8AaEQ9f8m3MIBBzWOCYFgOwpG6Jb8aIKONUIvZkNFZkHxg9Snm8S72rDVANI1zMvHuqBS+b+SKJXKpxhvH27UJwH3VjaRAxQjEpLjJJXATCieIA0zi+SP19DrIYCrGYF7wGhhrMMdd71b5sa9JrotQg20nUd2wslJwLyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LjP3c9/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k066FzHc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E09117A019B;
	Fri,  4 Jul 2025 10:55:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Jul 2025 10:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751640900; x=
	1751727300; bh=kUQkdwHhhgmrPZV0D6xIQYopM+BYucsq0GEI3IZE9xk=; b=L
	jP3c9/ngYGDdwGZYKRoCTcFDa3NT2ZO2ICE0htxgs3dY5z9KJ3SQA9rDy5CrTObC
	7X/6eVTlMB+Yybn0ttBQp5jwBKbFF0wlpvlq0uE3Fo2d4o3Ixu0D4thHq+AX2GHX
	XPSH4b3e45kxz73uO13SVImzzTxq8HpNhjp4+/hb4FkWrQIDGwRWmwxLrImhChpZ
	R2nmQSnvCi6oEwxvbvbj5oSY0OcRBlNtWc34MLaoXGXpsRJzpRODSwaISvV9dvop
	VnmWx3zOWtmanp72ii2JM+jWoCOH6qeDWAC2x42Lzz6YCScxN3ahdcEbLQgPPzlD
	yx2BignXVelqiTHagfi0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751640900; x=1751727300; bh=k
	UQkdwHhhgmrPZV0D6xIQYopM+BYucsq0GEI3IZE9xk=; b=k066FzHcPzi5/0HOg
	kxVeBcZUktQUzxHtbJ7RgxXLcuBxnAZBPNi/ni8nTL68nW/DYH4HQLYhh/oM+BqP
	E9qP2d3gw1nC/eA8GfD93dxH6xQ5K5pJtakcpGkk6LNOx496xyqFVKTmZLcaQlk/
	AtA/k/XFpzzbf6pBDSWQOHtdfz0UPQPcG2uL3BSMxt5WhE7Vo2vCiFyS419oEA9s
	JSHfX/je56FX5J2rt7QcU9dmkX8yU8k+DrtgPJ2gEjuBeCNGRk0vIFGe11o3KqlI
	VFRfB6Zr7sa0HbCTGTAeBPYpYB6oPXlhhT0sI+UVZX8KrqwyhV5iVxOFDuUPVcbQ
	/5BBA==
X-ME-Sender: <xms:ROtnaAxJbhLTx4J_95g_BQ4__n61Zi5XHJMhN__YSf1X5LOl60A1Ag>
    <xme:ROtnaET-m_Wz4wEBhEb2l-SQbOx54V5hW7JeZMncYJUggJ_mdi79cFXOsBtOvd4LB
    az_LQKuk32RSF6hjEo>
X-ME-Received: <xmr:ROtnaCWz7A_SKdkFK4FI6hXwZKpCcDzjuluz7UmircHS_DFxf-0NFrkUhRdJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfetveeuleejieejieevhefghedu
    gfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvght
    rdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorh
    hgrdgruhdprhgtphhtthhopegrughosghrihihrghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:ROtnaOjwuvFSB5SyQlPQjBh9PBAdpm6OAiH35Umyb4dhN__Exs4eGg>
    <xmx:ROtnaCDHLGM1ycq-blb03IcLyoGDOfvIe6qDVC3JfeHVd9gOvke8DA>
    <xmx:ROtnaPIkXkd65YjY9ntK_bybabY-SZrUeNZ_TxNcbSA1YTrn6BevTg>
    <xmx:ROtnaJC4_FWCD5kNAHwVKmHnvbQ8NcX1NWQqrVIDmo34mYKPBb1oxw>
    <xmx:ROtnaPjlzznbaVumw6koleBGR6imc8ayQTJPCk6-YwC1asWk0qPhTdZk>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 10:55:00 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 2/2] Revert "xfrm: destroy xfrm_state synchronously on net exit path"
Date: Fri,  4 Jul 2025 16:54:34 +0200
Message-ID: <a00d0bf700c2fe3bab37481ea47b33cdb578a05f.1751640074.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751640074.git.sd@queasysnail.net>
References: <cover.1751640074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f75a2804da391571563c4b6b29e7797787332673.

With all states (whether user or kern) removed from the hashtables
during deletion, there's no need for synchronous destruction of
states. xfrm6_tunnel states still need to have been destroyed (which
will be the case when its last user is deleted (not destroyed)) so
that xfrm6_tunnel_free_spi removes it from the per-netns hashtable
before the netns is destroyed.

This has the benefit of skipping one synchronize_rcu per state (in
__xfrm_state_destroy(sync=true)) when we exit a netns.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/xfrm.h      | 12 +++---------
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/key/af_key.c        |  2 +-
 net/xfrm/xfrm_state.c   | 23 +++++++++--------------
 net/xfrm/xfrm_user.c    |  2 +-
 5 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 91d52a380e37..f3014e4f54fc 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -915,7 +915,7 @@ static inline void xfrm_pols_put(struct xfrm_policy **pols, int npols)
 		xfrm_pol_put(pols[i]);
 }
 
-void __xfrm_state_destroy(struct xfrm_state *, bool);
+void __xfrm_state_destroy(struct xfrm_state *);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
@@ -925,13 +925,7 @@ static inline void __xfrm_state_put(struct xfrm_state *x)
 static inline void xfrm_state_put(struct xfrm_state *x)
 {
 	if (refcount_dec_and_test(&x->refcnt))
-		__xfrm_state_destroy(x, false);
-}
-
-static inline void xfrm_state_put_sync(struct xfrm_state *x)
-{
-	if (refcount_dec_and_test(&x->refcnt))
-		__xfrm_state_destroy(x, true);
+		__xfrm_state_destroy(x);
 }
 
 static inline void xfrm_state_hold(struct xfrm_state *x)
@@ -1769,7 +1763,7 @@ struct xfrmk_spdinfo {
 
 struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 int xfrm_state_delete(struct xfrm_state *x);
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid);
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
 int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 			  bool task_valid);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 7fd8bc08e6eb..5120a763da0d 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, 0, false, true);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/key/af_key.c b/net/key/af_key.c
index efc2a91f4c48..b5d761700776 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1766,7 +1766,7 @@ static int pfkey_flush(struct sock *sk, struct sk_buff *skb, const struct sadb_m
 	if (proto == 0)
 		return -EINVAL;
 
-	err = xfrm_state_flush(net, proto, true, false);
+	err = xfrm_state_flush(net, proto, true);
 	err2 = unicast_flush_resp(sk, hdr);
 	if (err || err2) {
 		if (err == -ESRCH) /* empty table - go quietly */
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f7110a658897..327a1a6f892c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -592,7 +592,7 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
-static void ___xfrm_state_destroy(struct xfrm_state *x)
+static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
 		x->mode_cbs->destroy_state(x);
@@ -631,7 +631,7 @@ static void xfrm_state_gc_task(struct work_struct *work)
 	synchronize_rcu();
 
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
-		___xfrm_state_destroy(x);
+		xfrm_state_gc_destroy(x);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -795,19 +795,14 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 }
 #endif
 
-void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
+void __xfrm_state_destroy(struct xfrm_state *x)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
 
-	if (sync) {
-		synchronize_rcu();
-		___xfrm_state_destroy(x);
-	} else {
-		spin_lock_bh(&xfrm_state_gc_lock);
-		hlist_add_head(&x->gclist, &xfrm_state_gc_list);
-		spin_unlock_bh(&xfrm_state_gc_lock);
-		schedule_work(&xfrm_state_gc_work);
-	}
+	spin_lock_bh(&xfrm_state_gc_lock);
+	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
+	spin_unlock_bh(&xfrm_state_gc_lock);
+	schedule_work(&xfrm_state_gc_work);
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
@@ -922,7 +917,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 }
 #endif
 
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 {
 	int i, err = 0, cnt = 0;
 
@@ -3283,7 +3278,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, 0, false, true);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 1db18f470f42..684239018bec 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2635,7 +2635,7 @@ static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_usersa_flush *p = nlmsg_data(nlh);
 	int err;
 
-	err = xfrm_state_flush(net, p->proto, true, false);
+	err = xfrm_state_flush(net, p->proto, true);
 	if (err) {
 		if (err == -ESRCH) /* empty table */
 			return 0;
-- 
2.50.0


