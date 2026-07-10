Return-Path: <netdev+bounces-306474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nci3JB26UGpP4AIAu9opvQ
	(envelope-from <netdev+bounces-306474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0E738FF4
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=P6s+4niW;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306474-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306474-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2DDA30C3EE1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D63DA7F5;
	Fri, 10 Jul 2026 09:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D13D6CB5
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674248; cv=none; b=FNitlb95He+fwITU4Itohd20AlGl7Sa0ly7bSH6TQvYRaQXO0MaUOLqmhlOJtzud/qaaFVdj9A0SSIKIEXdPFje5L24mOu+KDcTjovtriEKXl1ZJ/TDwFKjAP8Shlnb8H7aZzAvgLoIcMhDwfUyd5hDBw0kD3Z7YtLz+mB1tB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674248; c=relaxed/simple;
	bh=3w05C0XBoB8fJZuVU6A2+WJMXyRnsWgMf3DkjwhjPLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMGKrdy+7AXywV0puIB18q4gpeyRN/7+/vbfeOTGs9SRWyI1iSXZyVNeRcmus7mWejC9OojGPQv80qJWC/QjuV47J0c9Z8LB8wdgzOHRENl+viHhEDmKnwwedoMrQ3LwKL779KpXmpIPaYMdM1+P8fhLSleWFnJyvd9Ib9vVtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=P6s+4niW; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 02AAD207C1;
	Fri, 10 Jul 2026 11:04:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GCAuubFCG5ES; Fri, 10 Jul 2026 11:04:01 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 662AF205E5;
	Fri, 10 Jul 2026 11:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 662AF205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674241;
	bh=u8wzv+LV/tQ5l8X3cCVe+NuwD4DT/Ho3cpNt7OT5KLY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=P6s+4niWrQabz8FAR/ieAahAMSXgtcV9Wvckt6BNfZn5EpFpbdW/dY3z/OZovKJb9
	 hHPYMXNmbS4V30yZ+BEUfC8PgUEybV8zm1Eu8cc50C3yqtWlycgFN8qsLzuZP0PKPl
	 UKPZ9KkjcrTqiU4aWVI2u0mNepzcAhlzkacRjMX7hzc4HNTM9zxC3BHUAyUwLC7Hct
	 ZgvNlEDwoEsNhXAYN8Ng/nUkC4b1wlAA51yLaWhTQv1p4EIQQcWMGXWmsxGOs05e16
	 sxXySDxYPfS1MCncRZABpHL6adP4HF8y5Sr+7IdWybOsvCWlKr23DI/3SI0TfSTTkB
	 nNsi7roMzPN5Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:00 +0200
Received: (nullmailer pid 343839 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/10] xfrm: fix stale skb->prev after async crypto steals a GSO segment
Date: Fri, 10 Jul 2026 11:03:15 +0200
Message-ID: <20260710090349.343389-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306474-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CC0E738FF4

From: Petr Wozniak <petr.wozniak@gmail.com>

skb_gso_segment() leaves the segment list head with ->prev pointing at
the last segment, an invariant validate_xmit_skb_list() relies on when
it sets its tail pointer (tail = skb->prev).

When validate_xmit_xfrm() walks a GSO list and some segments are stolen
by async crypto (->xmit() returns -EINPROGRESS), those segments are
unlinked from the list but the head ->prev is never updated.  If the
last segment is the one stolen, the returned head still has ->prev
pointing at it, even though it is now owned by the crypto engine and may
be freed.  validate_xmit_skb_list() later does tail->next = skb, writing
through that stale pointer -- a use-after-free.

Repoint skb->prev at the last retained segment before returning.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 19c77f09acc9..aec1e1184a71 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -224,6 +224,14 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		pskb = skb2;
 	}
 
+	/* skb_gso_segment() set skb->prev to the last segment, but async
+	 * crypto may have stolen it above without updating ->prev.  Repoint
+	 * it at the last retained segment so validate_xmit_skb_list() does
+	 * not chain onto a segment now owned by the crypto engine.
+	 */
+	if (skb)
+		skb->prev = pskb;
+
 	return skb ? skb : ERR_PTR(-EINPROGRESS);
 }
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
-- 
2.43.0


