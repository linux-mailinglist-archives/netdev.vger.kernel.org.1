Return-Path: <netdev+bounces-300873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vt3rFvq2N2rAQAcAu9opvQ
	(envelope-from <netdev+bounces-300873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0D6AA900
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="AW/8OV6O";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300873-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300873-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EF1B300B3F0
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B6288530;
	Sun, 21 Jun 2026 10:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634F1E885A
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036214; cv=none; b=TLwMFbYkOyNGWxZHMDEbKbAVDNG4FZT8o38vVgmc0icPc0EMzYewOYa9URrjgfTW6jHMP/PNjBDeXGDxkvJZR1Rg9eudoxh5pUJUu/M0IluvbHcEVoXDsK3Fk3oKBUOAbauH+zMY5hZM3SWyqrCNbfwQGaN7W6fPNTLQoioZAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036214; c=relaxed/simple;
	bh=u2YeirNNp694xOrA7GnHYixwSCMGKBPcKnxfgH+NST4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqo2ieG4Te6Pjx3KVjM8sH36c3ibt6LFANQn37dBEwrgpTLypGF5d2m/R2izjaTW2DbgnZ6LPKQY1vjR3zP2nW6AUFIVRuo498hyV06bjn/8tyn1H8CyOz4yHtQ2Px1FiqtWP77P1YVP0fBF8iVpzePdfGgr6neEd+HB9M8uFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW/8OV6O; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fd464d51fso1998896f8f.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036211; x=1782641011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCskOvtha3WSz520YJDlSo06sskkak2HetR13aVf5p8=;
        b=AW/8OV6OX+TX7jPyFRcpUFoTJK1MRKl7fyeY098F3g5nt4H8+PRiV1+0KTFoz2QkIT
         u9VeWyMu19AbIJ8Ry+mt0Uu3Rl32aX8sQ2c1tZGBSfsePJ7KMp3L23y3H61WgAZnDo/R
         OhHbKbkZn4tg8grxSz9CE/XhTgyU66hy0D2Xyjx3ODa227Go6GBK3aS6nArB/08v+6EJ
         EttbbpZTg08nDtlaUB0X6GpORUMRI8kc0/Qi8xM/r7wBbJ4IUl3Te479VsqlIhyqIzwb
         3v+IDatv5L3rDqCMt/7BKgT4IAr5Ei4LUWWS8qeR+Zl9p1prizwD6a/yUmhXm6CzMr4B
         qJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036211; x=1782641011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCskOvtha3WSz520YJDlSo06sskkak2HetR13aVf5p8=;
        b=juZFZSaUB6eAnfNTmBXJoky94N9NFgjqvV5Afx0bBprb9iOPSPhpD/UlEiYFEftmv4
         rquw+KRMY3r4mLfFnYD/7UN67cW9M1orY+AOwa6RlZYkTaET8/Eibb/EU5TS3XIBrOg2
         Ib7Prseixcjnj1AkFGpRxtGa03MOk7doGN7o1xszt2pZUxb358tJoSqeCGYf94SVzuuU
         n3DeHoIBY3sFZQ6X+9ZKIJvJ/aQ1WyzZbKd61Po5dpgZtV0iEN/kvh70zeYlz3sur/g4
         7jxOpjDMw3L8SL4Us7WQA7dVI2aenD42qp+IPqpEcRDr1xt3anWN6qG1WxnU2iDyaPZQ
         QLrw==
X-Gm-Message-State: AOJu0YzY5exkW6XUAyu1N6h1D8rpklcdBb9fqMgmOUmT9sUKqYst7jFS
	rK1Venx87TCbhFzStW9560tHLgrsdKIx76qAZiD1Umuf7RFvtAFbcltgfJygNLNS
X-Gm-Gg: AfdE7ckbcxj3kXF2x28p/T52AzmeNQ8DrvURRO8KrWadBocClKjxopq6slJ7WkVyCWP
	fPJ8NaaL+qmWTZr0eP6ceetcXrbn5ke9o9Fcww8+WJmoar880KhEAelSPLVuytOFH1y5Po7UYh6
	k7mqOCJ+NOeOnAOVlBZXzfWdQwDzS5h/CfwNpX/0JK9qq3HS5mzZEJ8vMDZsVbm7qIBN3unfq5N
	SPhW1rxcK63Okr7py64G5VaO/+wvzG19sdh3c7y3A1MPe3D7+/yfmIQeh3EM9jh0kz12i4CWOm9
	aJRDwzH+KeTbvkASUInrN222fqoPAmdra8U5xAQCqWd4Hno3w7O2RZEozXZi9F0jxC9gk1NnBh2
	3KNiRnQ29efJxknCHI/XQnWOmeUP0VZ7R9OVmVe9kW5H6CL0hjOfDgk9QN7ctuv6MWYLrAoL8Pp
	dL3EMGsnJNaEEPkFc2MnxWgEiESADfw50MQ9vNZoYYL4ihc0ms+iRzG/uR3x4JVM9bWthNd7FGw
	vE6mV0=
X-Received: by 2002:a05:6000:2892:b0:467:222a:a6c9 with SMTP id ffacd0b85a97d-467222aa754mr6573104f8f.40.1782036210648;
        Sun, 21 Jun 2026 03:03:30 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm14400283f8f.3.2026.06.21.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:03:30 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v5 1/2] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
Date: Sun, 21 Jun 2026 12:03:26 +0200
Message-ID: <20260621100327.40203-2-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260621100327.40203-1-petr.wozniak@gmail.com>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
 <20260621100327.40203-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,gondor.apana.org.au,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300873-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6B0D6AA900

validate_xmit_xfrm() returns NULL both when a packet is dropped and
when it is stolen by async crypto (-EINPROGRESS from ->xmit()).
Callers cannot distinguish the two cases.

f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
changed the semantics of a NULL return from "dropped" to "stolen or
dropped", but __dev_queue_xmit() was not updated.  On virtual/bridge
interfaces (noqueue qdisc) __dev_queue_xmit() initialises rc=-ENOMEM
and jumps to out: when skb is NULL, returning -ENOMEM to the caller
even though the packet will be delivered correctly via xfrm_dev_resume().

Return ERR_PTR(-EINPROGRESS) from validate_xmit_xfrm() for the async
case so callers can tell it apart from a real drop.  Update
__dev_queue_xmit() to handle ERR_PTR(-EINPROGRESS) from
validate_xmit_skb() correctly.  Update validate_xmit_skb_list() to
use IS_ERR_OR_NULL() so that ERR_PTR(-EINPROGRESS) is not mistakenly
added to the transmitted list.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 net/core/dev.c         | 10 ++++++++--
 net/xfrm/xfrm_device.c |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5c01dfaa6c44..f7ffc4d29597 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4018,6 +4018,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	return NULL;
 }
 
+/* Returns the skb on success, NULL if dropped, or ERR_PTR(-EINPROGRESS)
+ * if stolen by async xfrm crypto (delivered via xfrm_dev_resume()).
+ */
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	netdev_features_t features;
@@ -4089,7 +4092,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		skb->prev = skb;
 
 		skb = validate_xmit_skb(skb, dev, again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb))
 			continue;
 
 		if (!head)
@@ -4860,8 +4863,11 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			goto recursion_alert;
 
 		skb = validate_xmit_skb(skb, dev, &again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb)) {
+			if (PTR_ERR(skb) == -EINPROGRESS)
+				rc = NET_XMIT_SUCCESS;
 			goto out;
+		}
 
 		HARD_TX_LOCK(dev, txq, cpu);
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 630f3dd31cc5..19c77f09acc9 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -182,7 +182,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		err = x->type_offload->xmit(x, skb, esp_features);
 		if (err) {
 			if (err == -EINPROGRESS)
-				return NULL;
+				return ERR_PTR(-EINPROGRESS);
 
 			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
 			kfree_skb(skb);
@@ -224,7 +224,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		pskb = skb2;
 	}
 
-	return skb;
+	return skb ? skb : ERR_PTR(-EINPROGRESS);
 }
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
 
-- 
2.51.0


