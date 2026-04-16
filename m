Return-Path: <netdev+bounces-278930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECYsEXN34GkfhQAAu9opvQ
	(envelope-from <netdev+bounces-278930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:45:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87540A70A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF49C3081EB0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DE2749CF;
	Thu, 16 Apr 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TUPZEEfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61033D6FC
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318314; cv=none; b=OrsEzRtVBRGlZwW5+u2FA3H/w8bKoAoIzrm6HZAmOxg6DLuL4yL24AbVF3sjXC+osr1s70zc+KXq1Huh79d0KEFgPSMEMEjkfd7nK1UEkIRwf7PZXg43CJ/PoU2mQVXMcv64oKK/f+gV01btdL48z/70DoCij6RQwUaaDGTGe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318314; c=relaxed/simple;
	bh=RoIEFKAscxxXli+ysevO6opb7ENwBkdnVvVpXFIqDAU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HFhj+a2xN82xLt9YNk3DVCQL3uoMV6IghmzGQ5Tqn7sDrDm9GHsZasr2FlinReoqHcvPZ7Y2RYsI4xRRu9XdF6PmqLCokv5UPBfKqs9jol74Eg9PjuBCrday7V+s371hUhqezlRik1Uca0uSHjSK5BcpbGxMKQHSmPCvyKiTeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TUPZEEfZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E6C632083F;
	Thu, 16 Apr 2026 07:45:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RPSvZkeA9RH; Thu, 16 Apr 2026 07:45:03 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2E4C1206D2;
	Thu, 16 Apr 2026 07:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2E4C1206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1776318303;
	bh=dbJ1ilEBXZna9sFrB9gmfZwrpwnfGNg7aWWlepCgY04=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=TUPZEEfZ76X2J1C2FDhT8jEKX9e68o4//ZQ2rpBwcuf7Q/eXD9pXTBqftfVWqErrZ
	 gTkGHCcy/raVqKiZocxG75P7IemcsfSdIWalhbbG9on29uYW79dGNO0T5OLA71Rsf6
	 bscwOP9oAshQz1xp7ssu/EIuz9KVZduszrlYzzMkT+4Otk4c3arDbpzo6mm1Ht11AL
	 KWBtGsA0fSHiHFM/m7QqbpcJJmnpOhTjG4uAkOyCGvgyFcy1JWPWIvnf+pLh3Xlf7A
	 ikz0s44PxsLznznWPf1gZyUbajjI1jN01dlkKbfp1T7kMySZ4prFNyUAsgEIKVfBxw
	 AjINdMdeZpKDw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 07:45:02 +0200
Date: Thu, 16 Apr 2026 07:44:56 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Aakash Kumar S <saakashkumar@marvell.com>, Yan Yan
	<evitayan@google.com>
CC: Abed Mohammad Kamaluddin <akamluddin@marvell.com>, Nathan Harold
	<nharold@google.com>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>,
	Antony Antony <antony.antony@secunet.com>
Subject: [PATCH RFC] xfrm: enforce SPI uniqueness for inbound SAs only
Message-ID: <20260416-alloc-spi-dir-v1-1-145e16477480@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAHZ04GkC/yWNQQrCMBBFr1Jm7UBMSkG3ggdwKy4y6dSOlDRkt
 BRK726iy/f4j7+BchZWODcbZF5EZY4FjocGwujjk1H6wmCN7YxzBv00zQE1CfaS0VHHdmjJtXy
 C0pBXRso+hrFWkpRD9SnzIOvv5w636wUef6kfenF41y3s+xcTT466jgAAAA==
X-Change-ID: 20260330-alloc-spi-dir-3b6e2f4b34e9
X-Mailer: b4 0.15-dev
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278930-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:replyto,secunet.com:email,secunet.com:dkim,secunet.com:mid]
X-Rspamd-Queue-Id: 8F87540A70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Per RFC 4301 section 4.4.2.1, the SPI is selected by the receiving
end, which is interpreted as making SPI uniqueness an inbound-only
requirement.

Commit 94f39804d891 ("xfrm: Duplicate SPI Handling") introduced
xfrm_state_lookup_spi_proto() to fix duplicate SPI allocation for
inbound SAs with different destination addresses.  However, it enforces
global uniqueness by (spi, proto) across all states regardless of
direction, which causes SPI allocation to fail for outbound SAs when
the same (spi, proto) is already in use by an inbound SA.

When x->dir == XFRM_DIR_IN, enforce SPI uniqueness via
xfrm_state_lookup_spi_proto() scoped to inbound SAs. SAs created via
PF_KEY, without direction, or with XFRM_DIR_OUT restore the
pre 94f39804d891, RFC 2401 lookup by (daddr, spi, proto).

Reported-by: Yan Yan <evitayan@google.com>
Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 16 ++++++++++++++--
 net/xfrm/xfrm_user.c  |  6 +++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..b1ec95141512 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1698,15 +1698,21 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byspi);
 
-static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
+static struct xfrm_state *xfrm_state_lookup_input_spi(struct net *net,
+						      __be32 spi, u8 proto,
+						      u8 dir)
 {
 	struct xfrm_state *x;
 	unsigned int i;
 
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_byspi, net) + i, byspi) {
+			if (x->dir != dir)
+				continue;
+
 			if (x->id.spi == spi && x->id.proto == proto)
 				return x;
+
 		}
 	}
 	return NULL;
@@ -2578,6 +2584,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	struct xfrm_state *x0;
 	int err = -ENOENT;
 	u32 range = high - low + 1;
+	u32 mark = x->mark.v & x->mark.m;
 	__be32 newspi = 0;
 
 	spin_lock_bh(&x->lock);
@@ -2599,7 +2606,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
+		if (x->dir == XFRM_SA_DIR_IN)
+			x0 = xfrm_state_lookup_input_spi(net, newspi,
+							 x->id.proto, x->dir);
+		else
+			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, newspi,
+					       x->id.proto, x->props.family);
 		if (!x0) {
 			x->id.spi = newspi;
 			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..f9db2d2c392b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1883,13 +1883,13 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out_noput;
 	}
 
+	if (attrs[XFRMA_SA_DIR])
+		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
 	err = xfrm_alloc_spi(x, p->min, p->max, extack);
 	if (err)
 		goto out;
 
-	if (attrs[XFRMA_SA_DIR])
-		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
-
 	resp_skb = xfrm_state_netlink(skb, x, nlh->nlmsg_seq);
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);

---
base-commit: 426c355742f02cf743b347d9d7dbdc1bfbfa31ef
change-id: 20260330-alloc-spi-dir-3b6e2f4b34e9

Best regards,
--  
Antony Antony <antony.antony@secunet.com>


