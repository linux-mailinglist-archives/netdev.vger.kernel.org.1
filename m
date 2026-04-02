Return-Path: <netdev+bounces-274555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLHkBqdyzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05CC389F0A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 949C0308C52E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950E313E01;
	Thu,  2 Apr 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+eYnKCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772630FC39
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137330; cv=none; b=Bz6RhMoEd10ZiNU5hheTFNJApatExhthksmGiZC3p4sIqQurwKm9tgSraqZM0qTg7hqXEhAnX9SuqNWoaJslDqyN2cE9wT1lepouD5OB9EWFYlupXIPgdBRP2D6JKMFIjESyg9saCFjBJ9B7EgmS29dILk5zPIGHJL6g5WS5TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137330; c=relaxed/simple;
	bh=8EsQ4WiMF6AOiYRmTcxX72F9EpKYLqIQBV0lWFmkbqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBWrQiTLElx+LsZtnKpm8cv6GMeSZOJ8XdYqEffWBmIPkPxTxy/GYoCPuyDF9lknAcgN8HQkrdiweFQbG6lc6BINshGu/Tm0XJsjCG37PMG0LGu62fum4lAXHx4c0g8q0AUJZDpyfi4VXtVoqX/Ezogn/z/+G2gnSWcztSEmIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+eYnKCC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89cc797547fso10241036d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137328; x=1775742128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW+HBbbtZKPAiroM7nF3jnrX2LFs7aEwJqdUcFVsVqQ=;
        b=A+eYnKCCzXtIuMGRowjvhozCcOI+1XSJUGZ3GtPpkWqVfkYFIwBuYawU1oIbgvU34a
         mcFLQxmTnD5tt3nJu1cz4axgyEj+f7AM7hPa+VFHsdy1TMVuPRkGFYAGfl/kviNtrApG
         H0KJGdsHIpuKbqQKkgDai6L9RkO1leXoWfjv2WWhKk96UbVMujn4125KHDaXOh8+7Ldb
         hMQumeDqi2ohRgTxC+NLf/ure/uiHZfvPmh/4VRYZVKSA3q/Mn82APKQlprmCBzXf1Br
         B4a41HqNLMfcnyUR6ZLpvf/Nf8hEZloWT5PaHQ8YqCMuxJWXLOMrdQ5WXxCMr9QYYmNm
         vY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137328; x=1775742128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kW+HBbbtZKPAiroM7nF3jnrX2LFs7aEwJqdUcFVsVqQ=;
        b=SMruzf8a2vh+oARXNoBx+CVSZizPsGWQuk2gQ34rGp27LtA/V3VjdI2aYsEwvMKsxW
         C4GuOsePcUZZflEnYC94lKnHXG8PEtgEQJYBYY81XR6l9S9AeuyB1X24M6quY4k0vCMG
         sM1AAPCqZFATUFgwaZCP1ofPiM7FAZHkUeXxjyL3eg4Gw39vWSKvXriPJabisbOPZO3M
         mYIMRlSwxeYERJWe2twBonHVd71wqt4FG1ruWCbfsaCogbrMg9olVc/uEO38NN6IqEuh
         mHSckBtRXCae2iOtq52BjmCgixIvSn4WucqINUYXBT7u7tCbf7AUozOtJU+J3QxXG7DG
         Qftg==
X-Forwarded-Encrypted: i=1; AJvYcCW7C2GH6jjpFr2JovFcxfL9/UJeRzmddLZmcEKT6r2opFenjtPmTTJRmvkswGkbBWkRQH7jOh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3gTDFMiWRsUxZjLfpVhx5bWY6vo2UZkpPWu2dCLZe4Pti4d8
	bwbwXPk5Llm7u3zam84aTT2ey21khvDgmWlPeuJVWZNJp0wbI4kXP4OG
X-Gm-Gg: AeBDietQCecCthYFmGAjMiL8DouWUbgkv5qLW32jAuPvJS1ookVuB238FEy6LGTS12J
	rsBgHOM5pGku5aS1+ZbPZ361bS5VI1snBUjiDPJfpAZE40+RaYPr69T27epxPQ1RJm0wHOqqxcY
	80swC6NvhoIOL3m0eORSFK/EP3q8D4dcbANQyPwrEMyTe1TpHt2gEpctWwmjSxFJ86a0gzTPI4g
	nfBprUPif8Q6kxvk0xyUw3fpRrE7tFrKuoiQWTyN8tzFZ/UwfuqKteTTmx2GL4YLI11IQyV/aAn
	LeVZlTKLblVtjwY02up6pGILcw90/+xinTdUdxsG+ZtJQbATdIYxRnTxKFDIWpggjM8efu7Vhmk
	SO8GWv1QlxsZX42YUVR7mEMWKFKKqVU+5GSR5TCc4ocQ6IVkqiZHRcx5+RK43RnoqjlJk194HOe
	XAqpdg3TAji7ZjAlYVAo9Fp5qC3/7OmaUc
X-Received: by 2002:a05:6214:6104:b0:89c:505e:a96d with SMTP id 6a1803df08f44-8a59ec879f4mr44181976d6.3.1775137327745;
        Thu, 02 Apr 2026 06:42:07 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm22636786d6.16.2026.04.02.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:42:06 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 02 Apr 2026 21:41:22 +0800
Subject: [PATCH net-next v2 1/4] net: macb: Replace open-coded
 implementation with napi_schedule()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-macb-irq-v2-1-942d98ab1154@gmail.com>
References: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
In-Reply-To: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274555-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B05CC389F0A
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
index 7a48ebe0741f3b031d4c3c266cc0e565bab61211..6bfba329bc9f1c918295d44ebfa38eefe209b648 100644
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


