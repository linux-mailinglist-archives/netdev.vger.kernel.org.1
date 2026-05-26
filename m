Return-Path: <netdev+bounces-291892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBLeObPvFWoKfgcAu9opvQ
	(envelope-from <netdev+bounces-291892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D515DBC21
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C249301EE25
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB7A3C13F1;
	Tue, 26 May 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vCrvoO4v"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E33C0A11;
	Tue, 26 May 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822500; cv=none; b=f5Le/RixGbgUNM/kEaJwPs71KEmF6IwHfjvhQiuuivjBwmO+S+vAeZbL8nImmjvyCxVrbURjfZ9nmheIBlicLbVENkPWtLrbuxSV3thZWoE7c6YE5NaeG1PFcKHns4zkWsfc4HecN9VWx8Km17e3yblgtXATgS97IehVobUWS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822500; c=relaxed/simple;
	bh=ZVU6BMMyLsMwEL3kp4Mh9bfYUhXA+tt043PdfGzDCW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRgrLMB0UjWqcNbSe455b+t99J2BfXf3/FhdEnJ1Bn5/Gd1wz95W4PbGtX7E1F3guTNXv3jJW6ax3aVBJ0d7H6lwo636cl0BAJzNjlK3qI7h3Do7TC+IAIC7ODtB4t2VS5oqEHc9r3MEjR5fIjWS9OI6EebMBEQ0BtKmDGUMxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vCrvoO4v; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8A2FB201E4;
	Tue, 26 May 2026 21:08:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfymSei_Q92h; Tue, 26 May 2026 21:08:17 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0250E201A7;
	Tue, 26 May 2026 21:08:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0250E201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822497;
	bh=iEM84ja9LZz8SPIA1eC0292mPOIeL9QVu+IHxo9TP0w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=vCrvoO4vKJk8i82lZuch6IveoC8OlTu5qUD7K2IlFBxHjbIsYn43k9Rt4WIvQX793
	 2TxCs0iz0b523ekJ8cYXC/+2QBrvXZAE14G5q3ZcyH7WhbG+LwS84S3leRJqWVIUYE
	 NmGBrYvfjUbn6QkQnElIgHw50zEWnaGv6/T6l2y5pj4/xMGNj90MyJpvpLVtrYVGYt
	 9sVNNHIp2s3xpu3CHTHSoaNVXmaSae2swb2pj8sbb+geTRLeJdj0BAUBGiYozfbSA0
	 psellgTqhDBEbGEs66IgQ6FZx3gA1NsS1oegtVeWh8gxPGYzIs0TK0FgizjnaRM4vD
	 vndfSVJD2t7jA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:08:02 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide
 NAKAMURA <nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v9 07/16] xfrm: check family before comparing addresses in migrate
Date: Tue, 26 May 2026 21:07:43 +0200
Message-ID: <migrate-state-v9-7-ad9947e4ae74@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
References: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291892-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 89D515DBC21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When migrating between different address families, xfrm_addr_equal()
cannot meaningfully compare addresses, different lengths.
Only call xfrm_addr_equal() when families match, and take
the xfrm_state_insert() path when addresses are equal.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v8->v9: remove comment reflow, moved to previous patch (Sabrina)
v5->v6: added this patch
---
 net/xfrm/xfrm_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 85fd80520184..327a855253e6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2159,10 +2159,11 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack)
 {
-	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
+	if (m->new_family == m->old_family &&
+	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/*
-		 * Care is needed when the destination address
-		 * of the state is to be updated as it is a part of triplet.
+		 * Care is needed when the destination address of the state is
+		 * to be updated as it is a part of triplet.
 		 */
 		xfrm_state_insert(xc);
 	} else {

-- 
2.47.3


