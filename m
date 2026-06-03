Return-Path: <netdev+bounces-294622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3i8dBGfZH2o5rAAAu9opvQ
	(envelope-from <netdev+bounces-294622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409F63544D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=aYdthSkC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61FE30FF918
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B923FFADF;
	Wed,  3 Jun 2026 07:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE63FF881
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471544; cv=none; b=pEZxFld4YGmUjCUthLVyEwP9YykIZ+tNxYULCu1mEm8/ANMS0wE3tESk2Yyznzw93ruQ7Lzy5OnuWMtUtDHf2QHi2YOhnbAPIj2A2n0/I9KiWCeVCJSEwlV9v6xq2EE45jcKGk7iw2lqYGXa39AG3qLZ+uEBgcNG5kbrJLWwooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471544; c=relaxed/simple;
	bh=BrXHBr159/wANmrNwtKans3Eli/BghSONnC8pmEoQOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG0nxKPvof4eiDnAr8jXNND/U1ro9m+ieSHpHLLRJHgcBFrmeDGqka+aTmz5c3czSGpnAKJbQ5/XKx47VZRw5qRXMiAXy51BXyUVvHQJwz0VrxxSrOXiloErkcbyDSyTQmIrp34QQJEF5iV68s8P9ka6wTmcOByIIVySPzgzybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=aYdthSkC; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2P6Y0aH38DpvKQoICwjpsy1mIH384HVW9QTFrseBuE=;
	b=aYdthSkCp8OU051eI2IthHUTCcqmhcBmIZJU0340OdG+cutQ4oVMDcXEiHlWZqfRejOneT
	Bqi+UkEd5hGr3cPSjDH/jabelUOYVSl6JbfKsXooJJ28esAh4ErUhqX0o/pUO4eXcl14T0
	pASwngCUyr3MP7selr8P6U9EHZSztuJuA8UlkFUYGOhbSd9eb+ScVqEhoyZ1zTZnkAPea7
	SPrYRK9LfJ7NCYI1io3WZC3s3Gn0jbBBMbImOSBRok4TqaUlHYBXYB7KbyALOrtgyNiyXc
	5xxkF+vqjxe2tgbuQWjgPUn3Gegz675EgxZ02Mf73pFjVcvTpYmXtKAeOfNgIA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: prevent ELP transmission interval underflow
Date: Wed,  3 Jun 2026 09:25:24 +0200
Message-ID: <20260603072527.174487-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294622-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6409F63544D

From: Sven Eckelmann <sven@narfation.org>

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e5463003a3bd6..1ba206e402733 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -919,9 +919,15 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
-		WRITE_ONCE(hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+		WRITE_ONCE(hard_iface->bat_v.elp_interval, elp_interval);
 	}
 
 	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
-- 
2.47.3


