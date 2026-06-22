Return-Path: <netdev+bounces-300978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33iMOEHrOGpKkAcAu9opvQ
	(envelope-from <netdev+bounces-300978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C896AD755
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=hZdCy78P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300978-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B15103028B63
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A8383333;
	Mon, 22 Jun 2026 07:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD8382F23
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115066; cv=none; b=ctHboSAQsQYZqzTuU9MDYZKyYlnaoP3DY8K+fNpAQ6IQcLfwOI+ZN3+Fdoh+2QEILP/vYB1op3DvHsf483GKeoomrC58CAROjfk2h+pLw06V4dhH5jeaGkKoiavUgfnOgQgXlhDnLTRG6//KQXRntlZtPke5nrsVrK8szkfVatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115066; c=relaxed/simple;
	bh=AoWTkHIthw/TghHN/By2+bjiHW4e31e6eQ4ON2fKfoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7ZdlXaYz4RAQEx0jCMg3DfLezReHeXA8/WZSwMeV6TnnzdyvNOZc3q0rkCNmbJK2WZwmeAAfHen7+sUkmUH6apX0ZzqCRMg5QGwwg0nlOKbFWZwC0hlbm7LBmiOosv6RoA6F3uQk8+e+7oNR3hcxfyR8snDz3ambK1BFga63vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hZdCy78P; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 761D720684;
	Mon, 22 Jun 2026 09:57:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-IE3ChO69zj; Mon, 22 Jun 2026 09:57:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9B1E720748;
	Mon, 22 Jun 2026 09:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9B1E720748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115057;
	bh=37TJ9pfn4JY9JKjNJkyDdT7lHAsXAL9SzHaQdvSIxUg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hZdCy78PQvS/Vu3wbxw//ljNctcDsRGuQQCig6Gigo8wrfzd1XoUDyi6URHxbuacT
	 /+jYs5CuGv+VeYwcwsunlE7/ta/9OSx7hVsbGI0dSzrzWGJi54HNdyPG/w3bn8P4/N
	 D/gKUUwNQd07X+rNHUeCiBHzja5H4Xn1JtpyVkKfhQ69ZYzyCFmuBlEWGs7eKxq4PO
	 KsTMYFrC5a3OOlvO66AGfAekwUpjaPw916aKyZdL22Fl1PJXQoD2YEohsfIP6Ti8BZ
	 KXMi7ApmLZfPiIIpPND2mRtBSMDILpP+4dDp1oiRfu0t6YxqjuxSPwEiHfTWl8BcCF
	 T1QWcdBdu2i3w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:37 +0200
Received: (nullmailer pid 30073 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/7] xfrm: validate selector family and prefixlen during match
Date: Mon, 22 Jun 2026 09:57:09 +0200
Message-ID: <20260622075726.29685-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
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
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300978-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,sel.family:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35C896AD755

From: Eric Dumazet <edumazet@google.com>

syzbot reported a shift-out-of-bounds in xfrm_selector_match()
due to AF_UNSPEC selector with large prefixlen (e.g. 128) matched
against IPv4 flow (when XFRM_STATE_AF_UNSPEC is set).

Fix this by:

- Rejecting mismatched families in xfrm_selector_match.
- Returning false in addr4_match if prefixlen > 32.
- Returning false in addr_match if prefixlen > 128 (prevents overflow).

Fixes: 3f0ab59e6537 ("xfrm: validate new SA's prefixlen using SA family when sel.family is unset")
Reported-by: syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2fbe35.be3f099c.2836ae.0018.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 7 +++++++
 net/xfrm/xfrm_policy.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 35a743129329..f8c909b0f0c3 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -943,6 +943,9 @@ static inline bool addr_match(const void *token1, const void *token2,
 	unsigned int pdw;
 	unsigned int pbi;
 
+	if (prefixlen > 128)
+		return false;
+
 	pdw = prefixlen >> 5;	  /* num of whole u32 in prefix */
 	pbi = prefixlen &  0x1f;  /* num of bits in incomplete u32 in prefix */
 
@@ -967,6 +970,10 @@ static inline bool addr4_match(__be32 a1, __be32 a2, u8 prefixlen)
 	/* C99 6.5.7 (3): u32 << 32 is undefined behaviour */
 	if (sizeof(long) == 4 && prefixlen == 0)
 		return true;
+
+	if (prefixlen > 32)
+		return false;
+
 	return !((a1 ^ a2) & htonl(~0UL << (32 - prefixlen)));
 }
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 1f4afd580105..639934f30016 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -242,6 +242,9 @@ __xfrm6_selector_match(const struct xfrm_selector *sel, const struct flowi *fl)
 bool xfrm_selector_match(const struct xfrm_selector *sel, const struct flowi *fl,
 			 unsigned short family)
 {
+	if (family != sel->family && sel->family != AF_UNSPEC)
+		return false;
+
 	switch (family) {
 	case AF_INET:
 		return __xfrm4_selector_match(sel, fl);
-- 
2.43.0


