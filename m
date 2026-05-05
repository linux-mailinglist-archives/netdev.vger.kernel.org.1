Return-Path: <netdev+bounces-284186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGIgFv9y+Wn58gIAu9opvQ
	(envelope-from <netdev+bounces-284186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181954C661E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 218BC30234FE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 04:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C9397E6A;
	Tue,  5 May 2026 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zzKTMntC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3C386440;
	Tue,  5 May 2026 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955556; cv=none; b=bJRBeoak+5n9Ep0N3kqcT6tRE0M2Mnf+mQRz1C0RJxP72LeqwDuECwdBwL2O+ERb52m+LLXKoDo075goTSXh6OqyHSzc8A93AhtpbjWq22ssnvWSKEJtMIMuFOXV+76fRdMXJJ1nLGE0D9OV26L0LBvQ3yxJjLkaZvgn9icvceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955556; c=relaxed/simple;
	bh=v0v+zISKNuP/nv5XzWz4Z8J8aXvWvQXXhXX4Sz2Nw+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIg9iwKKijf8Th5/hcRTRKIi0PzRONATQIZGnomTUoDqubrMwJMDiCk8rnCQrfFC4sH6KstzFYqwD4fKho2QYPFZJe3ZyB0HbyXR3XABIIDaZHfztg1eDUvCISo7j3SHqrHrp6iBTnbBFAk3n8taSPl31zGaHjcn47lyR47tjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zzKTMntC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3B7E0206DF;
	Tue,  5 May 2026 06:32:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WtVGlcF6EcJw; Tue,  5 May 2026 06:32:32 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 71B15201E4;
	Tue,  5 May 2026 06:32:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 71B15201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955552;
	bh=reHrVhu2Zy7jSc3h+nfh/fBptMMgIZHh6fsQsnQ/yCw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zzKTMntCuQn4oGSnWWcq6zqzKWUX/BGTpO92RknWLE8FBrwrGwdWgyaUJVr/4jv7c
	 EAfO9/v8BLhE38fFMLOkRpNVuwMHOoBqLQ68pnS6oElpeKkQ+AM2eJL5+hwiR8oi90
	 xhKOp8QQOb1whPTjineOoPNA1VHyWRwUj8zvcw69vpCQF7Mk021STrw1wVEO46rLEd
	 CqY55GuAOtzvu7n3IINtRSIZ7H4mFBF9bYS/D/sT6VH+AJa79GnUnSPD8j+evuyvzM
	 IXoSO/wGtyA/BBG6GhReDoFVeWR0crtM5zI30l9S8TOFMC58iHwMMEkzTnPiM2D0E4
	 Iy4Igcu2Yx9zg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:32:30 +0200
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
Subject: [PATCH ipsec-next v8 02/14] xfrm: add extack to xfrm_init_state
Date: Tue, 5 May 2026 06:32:19 +0200
Message-ID: <migrate-state-v8-2-4578fb016965@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v8-0-4578fb016965@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
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
X-Rspamd-Queue-Id: 181954C661E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284186-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:dkim,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Add a struct extack parameter to xfrm_init_state() and pass it
through to __xfrm_init_state(). This allows validation errors detected
during state initialization to propagate meaningful error messages back
to userspace.

xfrm_state_migrate_create() now passes extack so that errors from the
XFRM_MSG_MIGRATE_STATE path are properly reported. Callers without an
extack context (af_key, ipcomp4, ipcomp6) pass NULL, preserving their
existing behaviour.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v5->v6: added this patch
---
 include/net/xfrm.h    | 2 +-
 net/ipv4/ipcomp.c     | 2 +-
 net/ipv6/ipcomp6.c    | 2 +-
 net/key/af_key.c      | 2 +-
 net/xfrm/xfrm_state.c | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..0c035955d87d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1774,7 +1774,7 @@ u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
 int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
-int xfrm_init_state(struct xfrm_state *x);
+int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 9a45aed508d1..b1ea2d37e8c5 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -77,7 +77,7 @@ static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 	memcpy(&t->mark, &x->mark, sizeof(t->mark));
 	t->if_id = x->if_id;
 
-	if (xfrm_init_state(t))
+	if (xfrm_init_state(t, NULL))
 		goto error;
 
 	atomic_set(&t->tunnel_users, 1);
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 8607569de34f..b340d67eb1d9 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -95,7 +95,7 @@ static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 	memcpy(&t->mark, &x->mark, sizeof(t->mark));
 	t->if_id = x->if_id;
 
-	if (xfrm_init_state(t))
+	if (xfrm_init_state(t, NULL))
 		goto error;
 
 	atomic_set(&t->tunnel_users, 1);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8788..842bf5786e3f 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1299,7 +1299,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 		}
 	}
 
-	err = xfrm_init_state(x);
+	err = xfrm_init_state(x, NULL);
 	if (err)
 		goto out;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9417a025270c..53d88b87bdbd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2143,7 +2143,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
-	if (xfrm_init_state(xc) < 0)
+	if (xfrm_init_state(xc, extack) < 0)
 		goto error;
 
 	/* configure the hardware if offload is requested */
@@ -3238,11 +3238,11 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
 EXPORT_SYMBOL(__xfrm_init_state);
 
-int xfrm_init_state(struct xfrm_state *x)
+int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	int err;
 
-	err = __xfrm_init_state(x, NULL);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		return err;
 

-- 
2.47.3


