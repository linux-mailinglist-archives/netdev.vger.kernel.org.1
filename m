Return-Path: <netdev+bounces-270412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LOKAIf8wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73E2EE5F6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECFD230416DA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D83806D1;
	Mon, 23 Mar 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AZXvR/mZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979E36E465
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254904; cv=none; b=EaWf1cOPmUe5amHHlvGziyF1I2k7NRF4jWVxy0VZz/6H1dxSzfZg2TmhTV9p9ZBjj+SSSX17kdyGARZNzk6uoM6tjUzE74Fg9h70h1EKwGTxU0vWJlHPxuBgY4pELjp+DfXUXHbI5zU3c5wOBtpHrOc7THcCqN0BkJ7OR3WdtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254904; c=relaxed/simple;
	bh=usjtqLBtcyCaMigZcGQawHcol7bfOllfkWw+2RkbriI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk1MQCKzN0H3Sze6mN8lk+X+yqi02tMJ6/lTOpwteW9HBjGDcAoZKLFSUb2AStajyElnb/LXXiDEfjWrwMjdKd+XbT+z/EA/SOqUw2pfl9GrC2558MackM2DBxpZc6XBWbkmJnP/NZSNNYN1RqscWk3mnLmVdcrI3BQVFNLL3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AZXvR/mZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F3C842080B;
	Mon, 23 Mar 2026 09:34:58 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08sQL-WWfV9e; Mon, 23 Mar 2026 09:34:58 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5851F207AC;
	Mon, 23 Mar 2026 09:34:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5851F207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254898;
	bh=JqXZPxHVaARmPOQAVwfPajbQ7QF8faJpPZHQe08StQs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=AZXvR/mZFQPPhiIwCwCV+UDYcTQ0r2qHptlClwffF0dmls8+TazucVYbEVFeyJ6cB
	 aTkwiA4NHGOLLj1OjYFX9mtBSCnNT68VjSa1UMx+pm1QuhP6VS5alagpFdQ4XRqy7s
	 k7ArHoHDs6Kqm3s4hF2wvcCNQB5WV2kiGuaRQB2/0D92zfEqoJjcQSXP1VAZGW7SJf
	 x4yMJprdlzNu3tGHsteG3X55MCjk1c/SWIm68ib8iidKttOiQed8GsBOCwHXd9EpyA
	 7GXCBDCy54VgSxDrr9DYiVNuzHdnbimog2l7VbeYcGGzIF8Iijtmbf23x91e5Io57q
	 8fTZRQElvRx6g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:57 +0100
Received: (nullmailer pid 2741833 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/20] xfrm: state: silence sparse warnings during netns exit
Date: Mon, 23 Mar 2026 09:33:53 +0100
Message-ID: <20260323083440.2741292-13-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270412-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,secunet.com:dkim,secunet.com:email,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C73E2EE5F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

Silence sparse warnings in xfrm_state_fini:
net/xfrm/xfrm_state.c:3327:9: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:3327:9:    expected struct hlist_head const *h
net/xfrm/xfrm_state.c:3327:9:    got struct hlist_head [noderef] __rcu *state_byseq

Add xfrm_state_deref_netexit() to wrap those calls. The netns is going
away, we don't have to worry about the state_by* pointers being
changed behind our backs.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f28cbe249c05..1748d374abca 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3316,6 +3316,8 @@ int __net_init xfrm_state_init(struct net *net)
 	return -ENOMEM;
 }
 
+#define xfrm_state_deref_netexit(table) \
+	rcu_dereference_protected((table), true /* netns is going away */)
 void xfrm_state_fini(struct net *net)
 {
 	unsigned int sz;
@@ -3328,17 +3330,17 @@ void xfrm_state_fini(struct net *net)
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_byspi + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_bysrc + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_bydst + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_byseq) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_byspi) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_bysrc) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_bydst) + i));
 	}
 
 	sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_byseq), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_byspi), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_bysrc), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_bydst), sz);
 	free_percpu(net->xfrm.state_cache_input);
 }
 
-- 
2.43.0


