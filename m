Return-Path: <netdev+bounces-304629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0eM6BLXsR2rBhgAAu9opvQ
	(envelope-from <netdev+bounces-304629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:09:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA937048D6
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:09:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=nLH269bK;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304629-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304629-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E76D3010EF3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C22F12D4;
	Fri,  3 Jul 2026 17:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C523EAA6;
	Fri,  3 Jul 2026 17:08:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098527; cv=none; b=RvYWDwqvmuXB2uNvp5r2RZNgFbvmvPJUPNN6KnUVc2zKHMalczZXVoDRnZcfIEJgYlKQKJrD6UjHmOc/QLkn3TEQnXIH+t0mEfE212pPD3WKSbSmEp7P22SA5qDGmLMFt61eo+ud/0n8tMz/l0GbOqnSUZj0jQmIa7SgnfVjt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098527; c=relaxed/simple;
	bh=fuYZ8a5c3IWNPCFBEt/Cj77f7YPFLrDU/BJYZVC+rnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkWWj0Qgp9RyZsmyUmaMCLe5H8X2i+Tcegnk18NnJk0aslpLeITsjnFESBKKYCiXZfq2bAe8zJSf56Hc7ecDqjgCoxLWgvt28rO1VIHhLLaLT7ezcgoKYaTz0RxjVK6Tr6/4UbOBTJw61Imdbx+Mz6jeX+u0eN+OG7Y/fB2lCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nLH269bK; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AA2F520758;
	Fri,  3 Jul 2026 19:08:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0M6nlmXRV8Z2; Fri,  3 Jul 2026 19:08:44 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F3A5720612;
	Fri,  3 Jul 2026 19:08:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F3A5720612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783098524;
	bh=Pa+FNghhNJWq8sHQD/aYvV9yZ4XNOE/0fQeAQqHo7nA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nLH269bKSJxDI2dzE+7n8EVoZNnQf8T4lRs+k5DBUl6F4bXssLYECU01AUEwMQHOD
	 SaNSV59wHyRq8eIuaGvCxxczFrgjht/TLVUNcamlwLSVljaS5HiSIRSD7uEu0/S8IM
	 fN/yMRClNoOuoZyMWeycGzCDrHKsWGcdtPHowShib8ETPWfX/hl5jfQrjTyiKQLian
	 efcOEhYqnIICg9mTqYBvxe4wSvbonZ1NATK62BOErothD2AuXVSvlAOoEoy5GDyJoX
	 nkeKjORzp9GXvgHPBhThiRIL2sL3fItuz7yRx0VONGCHnaTAMXvnpvzWUvtyx4JxbI
	 cWThfTkctlPZg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 19:08:43 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH ipsec 6/8] xfrm: include mark in MIGRATE_STATE SA collision check
Date: Fri, 3 Jul 2026 19:08:34 +0200
Message-ID: <migrate-state-fixes-v0-6-a69e8637ba3b@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
References: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antony.antony@secunet.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:hadi@cyberus.ca,m:shuah@kernel.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:evitayan@google.com,m:tobias@strongswan.org,m:fw@strlen.de,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304629-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFA937048D6

The SA lookup tuple is (daddr, spi, proto, family, mark), but the
EEXIST pre-check and the xfrm_state_insert() vs xfrm_state_add()
decision only considered daddr and family, ignoring mark.
A migration that only changes the mark inserts a duplicate SA tuple
into the hash tables.

Before:
root@west:~# ip xfrm state add src 10.1.1.1 dst 10.1.1.2 proto esp \
        spi 0x1000  reqid 100 mode tunnel aead "rfc4106(gcm(aes))" \
        0x1111111111111111111111111111111111111111 96 \
        mark 0x1 mask 0xff

root@west:~# ip xfrm state add src 10.1.1.1 dst 10.1.1.2 proto esp \
        spi 0x1000  reqid 100 mode tunnel aead "rfc4106(gcm(aes))" \
        0x1111111111111111111111111111111111111111 96 \
        mark 0x2 mask 0xff
root@west:~# ip xfrm state migrate dst 10.1.1.2 proto esp spi 0x1000 \
        mark 0x1 mask 0xff \
        new-dst 10.1.1.2 new-src 10.1.1.1 new-reqid 100 \
        new-mark 0x2 mask 0xff
ip x s
src 10.1.1.1 dst 10.1.1.2
    proto esp spi 0x00001000 reqid 100 mode tunnel
    replay-window 0
    mark 0x2/0xff
    aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
    anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
src 10.1.1.1 dst 10.1.1.2
    proto esp spi 0x00001000 reqid 100 mode tunnel
    replay-window 0
    mark 0x2/0xff
    aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
    anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
    sel src 0.0.0.0/0 dst 0.0.0.0/0

Notice two states with same mark 0x2/0xff.
After:

Error: New SA tuple already occupied.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c |  8 +++++---
 net/xfrm/xfrm_user.c  | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d78cfe481f75..bffe985e42ea 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2221,10 +2221,12 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct netlink_ext_ack *extack)
 {
 	if (m->new_family == m->old_family &&
-	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
+	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) &&
+	    xc->mark.v == x->mark.v && xc->mark.m == x->mark.m) {
 		/*
-		 * Care is needed when the destination address of the state is
-		 * to be updated as it is a part of triplet.
+		 * Care is needed when the destination address or mark of the
+		 * state is to be updated, as they are part of the lookup
+		 * triplet.
 		 */
 		xfrm_state_insert(xc);
 	} else {
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 87ef198993db..a2317e6e6802 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3435,18 +3435,23 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 						       x->nat_keepalive_interval);
 
 	if (m.new_family != um->id.family ||
-	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family)) {
+	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family) ||
+	    (m.new_mark && (m.new_mark->v != x->mark.v ||
+			   m.new_mark->m != x->mark.m))) {
 		u32 new_mark_key = m.new_mark ? m.new_mark->v & m.new_mark->m :
-						m.old_mark.v & m.old_mark.m;
+						x->mark.v & x->mark.m;
 		struct xfrm_state *x_new;
 
 		x_new = xfrm_state_lookup(net, new_mark_key, &m.new_daddr,
 					  um->id.spi, um->id.proto, m.new_family);
 		if (x_new) {
 			xfrm_state_put(x_new);
-			NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
-			err = -EEXIST;
-			goto out;
+			if (x_new != x) {
+				NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
+				err = -EEXIST;
+				goto out;
+			}
+			/* self-match via wide mark mask; not a collision */
 		}
 	}
 

-- 
2.47.3


