Return-Path: <netdev+bounces-276703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJmoJHq71mnLHggAu9opvQ
	(envelope-from <netdev+bounces-276703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B783C3CF8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62C43047BF7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A613DA7FC;
	Wed,  8 Apr 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHdZK38O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E6339853
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680289; cv=none; b=f83B3ecPsgodypxeeZSNb/xPyDo3la2BmP5bu4PYwcbYHHgGn/BBrmVPIWbiQxGa5tG0qAxmwX5LxfIwPhTGKlLoi0VCni6wBbIH1SV0oB22CLZQOb7XqVXQWQPoWu4i0FjcxueqfBs4OTyv7Ckc7un3+lLOM9QwRAAbuIkKq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680289; c=relaxed/simple;
	bh=0Lnk5yYR4Jeq9L9QdpulP898oS7mVURTig5G98MTirM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSeQ596Or9kW8qYwINiuUCSefUJNrn+LGK5o5pfWR9CsKfy3rxssTRrc7vYlcnfnQhj8RlP2if8BjXjMK0o0rJRjuNsjd17nEAzZbjP75Dos1x3Aa/K+fXWjC/z8zRz1YpTi3nZbb3BvHfRzfh37mHmEnme4k9r9/woAxTbhJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHdZK38O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so202951a91.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680288; x=1776285088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZYke3O/zC0G+KGI4eNcYA6PyLtyQl46QT4L47XXVX8=;
        b=hHdZK38O2Z0FLLq3YS37w9kMQp727onqxh63meCiyK6mvH5LRHeiiJk4IBhXtQXblJ
         OiXRCEMiu/8sDut4nnFsxOXBHlxUKunAKg0tnckuQxcGmhW1LxIAUtvrMRRYw6GDtL+A
         08VIo5JfMQznAR4ZRqPQLdF72c46QbAjz3a84P2lWEGEklJ/cMN5PotgclKmX9n6o6Nc
         B9JBwZRbTnS8q34uG7qlaqk/4WQdu4042xQ+b8X79Tg0K1shXMmITYBBhk79cde/Ek0e
         4IS5LFN6TURLtXOToih+qFwf2dO+Bj9ItC19zttIm0Cas37mCNZno0R9K//5YfksJ96X
         bGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680288; x=1776285088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ZYke3O/zC0G+KGI4eNcYA6PyLtyQl46QT4L47XXVX8=;
        b=qWpuSHzoWkj3nNlgBb4OVGExJiCQaJuoUi9+2v43Nhw3kTEtadzrVhkCeBwqPIHrWo
         PyzUX1A4byCIWGuBR6NrXzi+WI5BKY6F/mFmadyxQS61jGQ2sKqimclfrA/aVzyFAREW
         zhQST69VRu1CmN4tKQyjU24Sq8oBbu0VLH6kUzY/5FWR0bbG0YSmYXdBRYmbu3sAshe9
         iFInT4w+2rfc6yYCB758KKNNPQUz0TulIIbJ6oO1DOfHrgQ+CHTLmTAengtN6iyXShx1
         0C6rNRkjTGJIKcdD09HQa6cbHkIWn/IqXYvbTze3gCAj0kqzpyLCOsb7dZNOq9c1/6pX
         cBmQ==
X-Gm-Message-State: AOJu0YzFN7ItaCCi77h0uiYWvw0hipirFboTwHVSB4Aif1t49dM7akR0
	wMof/o+IOteKI2gpwhVGfmfjStLcSwPfPz5gt5MOl77it0f2C48chE62
X-Gm-Gg: AeBDietCYI6C5rN8wF7sdmEZ8F7SxY6Ga8kf3jUJTsf2u/NQx6bhP0ZGvS7XDnpC6dP
	k+kbtU6BctY0o1RvQrpdf7Uc9OQudLnS5ILYGLDZoCnYHBoVMO38YOAdL+oRy53junFAEwcoHiv
	8i84Y2vYeP/+MHrLfk0mlxb1gBQK9AKOuiQPPr1yhQY9+kurnpBGJlt4zICVT4PYIenQA0pwx1m
	m5G/Sk4Axpd/QrRCWd21qbaMhrsT3dloo6IQNNVXoRtJVhnGBuuk+ds8W/smd6NvTEcTpaS6lOP
	Q6tHFahKP6lKLTZW/vbUOVhn9vWXavUAmjxrr1H5ybW5IH3AMSd8EdSqI4Ftj7txiu57QXiatBx
	EmofPkViO6uYds1pYh+CAjh4ZcefsRx22kgrjFQWj/h+20i1eVxX+x2jP1+f7t3+eCO1g6i7f2v
	DF6oYJ1NnuHBRfb5Y786IdaHAS9YEEJQftz22ACA==
X-Received: by 2002:a05:7301:6097:b0:2d3:1b7f:9273 with SMTP id 5a478bee46e88-2d40e6dd37bmr610184eec.21.1775680287991;
        Wed, 08 Apr 2026 13:31:27 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d16d115c00sm9556512eec.12.2026.04.08.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:31:26 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 08 Apr 2026 17:31:02 -0300
Subject: [net-next PATCH 2/2] net: dsa: tag_rtl8_4: set KEEP flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-realtek_fixes-v1-2-915ff1404d56@gmail.com>
References: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
In-Reply-To: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bang-olufsen.dk,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: E3B783C3CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KEEP=1 is needed because we should respect the format of the packet as
the kernel sends it to us. Unless tx forward offloading is used, the
kernel is giving us the packet exactly as it should leave the specified
port on the wire. Until now this was not needed because the ports were
always functioning in a standalone mode in a VLAN-unaware way, so the
switch would not tag or untag frames anyway. But arguably it should have
been KEEP=1 all along.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 net/dsa/tag_rtl8_4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index b7ed39c5419f..852c6b88079a 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -99,6 +99,7 @@
 #define   RTL8_4_REASON_TRAP		80
 
 #define RTL8_4_LEARN_DIS		BIT(5)
+#define RTL8_4_KEEP			BIT(7)
 
 #define RTL8_4_TX			GENMASK(3, 0)
 #define RTL8_4_RX			GENMASK(10, 0)
@@ -114,8 +115,9 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 	/* Set Protocol; zero REASON */
 	tag16[1] = htons(FIELD_PREP(RTL8_4_PROTOCOL, RTL8_4_PROTOCOL_RTL8365MB));
 
-	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX, KEEP; set LEARN_DIS */
-	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
+	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX; set KEEP, LEARN_DIS */
+	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1) |
+			 FIELD_PREP(RTL8_4_KEEP, 1));
 
 	/* Zero ALLOW; set RX (CPU->switch) forwarding port mask */
 	tag16[3] = htons(FIELD_PREP(RTL8_4_RX, dsa_xmit_port_mask(skb, dev)));

-- 
2.53.0


