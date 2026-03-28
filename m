Return-Path: <netdev+bounces-272759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CEcBvSqx2mAaQUAu9opvQ
	(envelope-from <netdev+bounces-272759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E234E0AB
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B746301CA84
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DA386561;
	Sat, 28 Mar 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/oupwEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE13859DB
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693096; cv=none; b=Rzu/5e6LFZHldBrDpK/PmxDazqCCjqcTnE5fJMlOFFAfj1OZ+01JSVHCWi0UJ6CjVE/CmN/JAjsXTs0kjeIrUMQbughBgdWTH/aRpm/gJG4FfC8QhfTZLOrUGOCkYN+A0RiKnvrXXXF/zdVzyWKeAE3maM4lRA6YMbV4k8BTnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693096; c=relaxed/simple;
	bh=Gql/hDXAuhPTZGOHS0sXYEq7hvdlL4Glbi9u+rsLkwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQLGBEBwz2ktP6rtySZ2Lup8FY9r4RxqVaEMHJOsXOZnN2yRgphXToTkRHZJcXCAuC3Y+NogFEqMw3512QV8qj4SQusMP0sS2eWou7xhj198yocLjZsCmaa6O8Je2QquzxdiCx+D+BRlcFn2Bd4Y2VuJRNzlky4I7CtQhSiEmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/oupwEz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50baf2df711so8479751cf.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693094; x=1775297894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2JKDz5SN0bqrWQsiSlllvDWjT5BjdDgA8TDWbOa04Q=;
        b=G/oupwEzA8atrB4ovMI18ftnIU8+W4SexA8Kl2BP0qRkrBPus+8FSKm8R3fhJKm8dp
         BZ8TYfcqKb7Y4J+FTmZQ4FAxDXWuJMczhfPYWxmTf2KktF7FB9ngyhDFMShac6UKH+Vt
         i4OKsVotW1s8eWvyD6ujE5l2K3jGw+/CpgG5XvpiNLRSDvAhMpZbV7PnqBANZieo3o/X
         NG1Mxbf7e6a5/Xlldvld9FDy0XEEWlvSVv4NC4FUgAQvbblpulLE7INR/7iQn5P32xYw
         E3DE+SQTXbx7VLGjkHzObSovKTpUJ6cq9brHv2VJEyao8C7xLcNoi/U66vd3VP4NpG4H
         kS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693094; x=1775297894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2JKDz5SN0bqrWQsiSlllvDWjT5BjdDgA8TDWbOa04Q=;
        b=Mv1NL8NT+aSJzygzC7hSw++S16+D/ZaUOBXii5QVVUMNJHm2MUmRp6KFzl/LiCJv5+
         uLS5BL1tx608KEeJ2Qy+QSeW/KvwA101ILtCcdF0m6Dp8sGLmDwmOEF8y5ULWUPQT+8s
         Ms8bKzhmPTEC65X9kOLI+cj7gNC3ns3P0dILemM19MWuu43HdNel+LoKd16dUBwjidET
         9vnA9I7kRbmJaOiY5zhAnLCiS6fHDmRtTJztTIlkX87ibzl2MAjPncsAjVpYiCGeGRC4
         RC1XXrnNrrn+/jFl3cOOHAGEPiONpoV0YU6/XCXwL0we+akr6NLu8jVAZK1Gaf1Ue1/Z
         Wy9g==
X-Forwarded-Encrypted: i=1; AJvYcCWW58ZbfM8tB81JTQS2j2XWo26+lszcJsWWYMSYSxRK8TkzK7ghVFehs9KVb7oMlk5Nyur6heI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUtCOl6cT8rRksOnsMX35UQ4OUU0A5VZ+90poGaHOwAFnYhE5
	ihjcxdZxMDB5zl7/+hksnnhal6LW0lCA1Wrw3wWajfvdCrwdjdvW9nsR
X-Gm-Gg: ATEYQzyIxVXcNEK5VIx1nPSJBWMVCwc0hXHJBG/37UYMOUHN5odpB6N10O7MwxNITMb
	GRieS/6FTue62Cx53CU7Y49pOz/HxePDwBgml5vZ/pvOJW8sECv4B7RXga/KI4WbiqV+SauaR5i
	HKoS96kDtZMozAqZ8sOj/zsG2wbn8+kmrySXC0zjCK2aQz+rNj+7rK6wJ8l09RNcGOb4coCQggm
	zX2OyHmopkJSCfhibCxfazD5wr8+NSrClJ0nM46lDJBpwgmGGj/0XFLAg1IGarFZEGyqbVVg7Bm
	92R9jy25oypnyyNLf7m9n1x06yub7TVw2QGLJtM7OxlO643uerWiuZJWVRCz/c7Z3wNjDP/SQmt
	S9HnafwqjZ2f/O+4VVqsqeb4dtDnYdmnLENBSCNuJo4VTmuyA1YSP1CRAgdrD3gZVotXfvUVqIs
	krawBe4Rw7OJCso8IZ/wC7kNuBwBdBnXDV
X-Received: by 2002:a05:622a:1919:b0:50b:5258:28da with SMTP id d75a77b69052e-50ba37d16c0mr72418191cf.5.1774693094592;
        Sat, 28 Mar 2026 03:18:14 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e17372sm15490681cf.24.2026.03.28.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:18:14 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 28 Mar 2026 18:17:45 +0800
Subject: [PATCH net-next 1/4] net: macb: Replace open-coded implementation
 with napi_schedule()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-macb-irq-v1-1-7b3e622fb46c@gmail.com>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
In-Reply-To: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272759-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 553E234E0AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver currently duplicates the logic of napi_schedule() primarily
to include additional debug information. However, these debug details
are not essential for a specific driver and can be effectively obtained
through existing tracepoints in the networking core, such as
/sys/kernel/tracing/events/napi/napi_poll. Therefore, this patch
replaces the open-coded implementation with napi_schedule() to
simplify the driver's code.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c8182559edf602e7f5d94644cffb22e8f58423cc..886246a6f6bdd0b6a8cb4b86d7788ac181ee602a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2120,10 +2120,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
-			if (napi_schedule_prep(&queue->napi_rx)) {
-				netdev_vdbg(bp->dev, "scheduling RX softirq\n");
-				__napi_schedule(&queue->napi_rx);
-			}
+			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -2138,10 +2135,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				wmb(); // ensure softirq can see update
 			}
 
-			if (napi_schedule_prep(&queue->napi_tx)) {
-				netdev_vdbg(bp->dev, "scheduling TX softirq\n");
-				__napi_schedule(&queue->napi_tx);
-			}
+			napi_schedule(&queue->napi_tx);
 		}
 
 		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {

-- 
2.53.0


