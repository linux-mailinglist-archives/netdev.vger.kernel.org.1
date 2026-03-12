Return-Path: <netdev+bounces-266939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA7tFAZ2sml/MwAAu9opvQ
	(envelope-from <netdev+bounces-266939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C3A26EBAC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6A43029E51
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0829C325;
	Thu, 12 Mar 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FALcmNNt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765F3382F1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303284; cv=none; b=omPnhRLl3NTkxPj8XH6UFFh/YmBh3yUaLD+DWEcJRWSUjTMSERyXXK/2AiHfaG+plwje5wAmZLJqeHyXW9Fuz6A4MjdWszEafWHNyteBblBcRR+TMZedyQzR+My3kt2DRe3Nf+jT6Y0DQC0dPpKkETg2L0EafdzptCMZeG9z4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303284; c=relaxed/simple;
	bh=pqOwoURsmmdI1+K6rDnIiO1SBz5bs1V861H94NmP5V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJh7hiczC/GGnqVDFWMcgieMpTmZcJe6Z3RODczq6mKf77WaUrMrCGmY7J4ADRnyrm58HHjlz4AODEqqpDqkXJInYBVKTTxlm7nOvlldhAe4EM4J4ZDS+WfOmKUwCFABG/d8r2+FojfsZbNZmA3eM9ihkrWkHhY43yFMkF4Jt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FALcmNNt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50917417efbso7211871cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303282; x=1773908082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTars8MG2idRuOB2npLXPI43TOBe8XlC605+CICslTg=;
        b=FALcmNNtG91l9d7Cz57oKgRezGlvOZfrUGmSG1e7z1ZJ7i8iXhb1C0yEpaV3GVQ60H
         0sfYzXv837PMDWGuiwkPZHIzz+Y9O7nln1khnJmhEvihH0ucaeZq+2ilaU1pgEHxKtmB
         ymxcESGVnPihVtBr9abmaSNfbXgFb39rH0e+nSHydB4Zw4D1IWvb9g8oWi1JYOO/e02t
         /uWRSXiSPJM7irDafMa29FYNNd6okdOACjEL6I9V0OOsQ5CeKUgFlGd69b/2H/GTmfxl
         agsx9BpRgWZPlgTrCffcijlUjPrMiToKe/k3Hm2SGWKI1gm1ne0XrGXPj9sqzBQPOPAH
         g68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303282; x=1773908082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTars8MG2idRuOB2npLXPI43TOBe8XlC605+CICslTg=;
        b=gKh99wHEpGPjEeH4UtyxqN/LMi8cfVN5FaNlgmvES5l+lJVw0bBCCYEx7Pm/sgQwLM
         PGuJErVeSevuZ+7YgrC0inNP/iMQFhSR1m6nJSjZynvTwCh7OucjYetpelPE7C4yV0zG
         wKvAXaXehW2JYCCVqJPu8Xr1OGWWVnpaVKtGQqe/STiXO/N2ActDr+/XcLQR7WvlbvwA
         D9FyrvKtNG97OULqxtU0l0HjxmlVTcPcNhdO4ryVmWvPWEPSlgjVXYB/Nls4GPnzlb8R
         Ab38Yppwmyk2nQJSqFB6BxpqzC70J4ucoTTVzqe6jpL80P87IQj5YhR8/RVSyWWbEnrk
         92Lw==
X-Gm-Message-State: AOJu0YxS21fqgrOH1kZYUUCBOflYN/mrCnPE0Zw6Lm7EK/IumBhMRjav
	TdVnQBB7MyeQe4Z1c4Y1azuPNmjUhis/Wj85+lD1rp87OexODDBUyaNv
X-Gm-Gg: ATEYQzyOwuUAjvE79C7NmqGpbDfD6bsB2LGyUjUfzQZ9foalePCc0svPMyVpTHFEwOi
	4tcU6RPcR3MQUAydGqGavijSar3DZKESpPsSfBwwTBE8ZA7RP5VbzAx0QxOHzeo8ZiaVe0AcjeX
	A5zBtorfpAiMicfudF6dzF4YnX3PO3Vtw7i0ETcA4WOWtsmdvYMOjV9vYnVdF9IMKgZebf87d90
	eyXBwYsy1JTPLN6BpwTV/byTb19GjF1kI1IopUCd+m06ryFxSxwNUpKqRAQXS3xLXs0sQTJx9yY
	NWezqnYA0SfcOoF9v/hpe0Mpgnz7qGyyveZJCiCuIr3myzYnU9osWLc+d4EVC2sdfo32FVoQOJR
	vLYDDfBAt1SjEo4z8WVQL5ImcnYmSJ3kbCFEW/sLhGVujx0mizeTgTNGW8w3OEN8PKYM0nEUqkE
	2DvkElPA4+TDQ4YEvosDC+u9lWAVToCuJV
X-Received: by 2002:ac8:7f8b:0:b0:509:2231:977a with SMTP id d75a77b69052e-509472a98d8mr32623281cf.30.1773303282406;
        Thu, 12 Mar 2026 01:14:42 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c122c0sm30423076d6.23.2026.03.12.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:14:42 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 12 Mar 2026 16:13:58 +0800
Subject: [PATCH net 1/2] net: macb: Introduce gem_init_rx_ring()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-macb-versal-v1-1-467647173fa4@gmail.com>
References: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
In-Reply-To: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266939-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2C3A26EBAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the initialization code for the GEM RX ring into a new function.
This change will be utilized in a subsequent patch. No functional changes
are introduced.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 952aaf84757c20e94f3bbc98162a18330aa4cf73..67f7ecb05a7d6b8a5f49da588faafe1aa70d0d2b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2805,6 +2805,14 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
+static void gem_init_rx_ring(struct macb_queue *queue)
+{
+	queue->rx_tail = 0;
+	queue->rx_prepared_head = 0;
+
+	gem_rx_refill(queue);
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2822,10 +2830,7 @@ static void gem_init_rings(struct macb *bp)
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		queue->rx_tail = 0;
-		queue->rx_prepared_head = 0;
-
-		gem_rx_refill(queue);
+		gem_init_rx_ring(queue);
 	}
 
 	macb_init_tieoff(bp);

-- 
2.53.0


