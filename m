Return-Path: <netdev+bounces-189236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D16AB132C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43A63A6BD9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A7274642;
	Fri,  9 May 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="EbQobLJG"
X-Original-To: netdev@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520722D9F8;
	Fri,  9 May 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793196; cv=none; b=phllemGobOfF5O3H/W0PYN1jQ7ky6zqaMd2YPsv2+GwmOC3ooiFhH7vk4xhyN+yXISO/CEPKNCz5aywudPaBQPWf9xjIan1TMvWySJx/c4Wt7o/vSP2E2VP3/33o2SfXYWb8m1HTPHlBpK2DKGz1+FFtwm67mzKNxZUCTd3qHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793196; c=relaxed/simple;
	bh=+91OYGRy69mtMICQt/vUfYhND/ZGYPeC1wbH0m+Gxvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rxl0MmPqYpLo79rWcwrn7ZdgOEa5W2uSXETvo8RDK7S0bnfg+x4Qb9XHPTN1qZ3jAutLoRQPj+tG6BKBEENZzpP92DBJa8kS2onj++TYqOpMWrHpYrRTL0WmIHkzAHmrKyNRhAwJy+bIIoLf+3dGkkS8YEEUB8YVokkIJkkeNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=EbQobLJG; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1uDMhe-0000f3-W6; Fri, 09 May 2025 08:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=H139cGEHa3IIp3U0gVnQ9YB0rP5tNLxOUIGuATG7bCo=; b=EbQobLJGIs+IHO
	G2kjXUJ1gp6egYsaaYANdAMDHmYwk5rqwmsrz6W+sN8K1syABCEsCGE2XK/f0VTHBOTQJafkWf9FI
	HaRjbkxrA59/SXqGU0CSVo9HWAU5H37MMiXMskCdzZzSWdqb+93uLDV1DjLQ2C9NTHywj4bT+8QTH
	+VPOts0YlQxLroIdE4GXh3dVTuvAkurABQPx/5gAshgOT4pe5UL8RO/UsaqHtln1YfOa9huRRKSJM
	w6iKNXEKcDBQJkeCK0CXJ6xPm6nMwjvDPKXmN5aQxu1DBlNjmn3TCkNpxJH9Ro/KUJVeQoxMJPtwB
	PIOlso5CNcqCFbT08e8A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anton.reding@landisgyr.com,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH net v2] net: cadence: macb: Fix a possible deadlock in macb_halt_tx.
Date: Fri,  9 May 2025 14:19:35 +0200
Message-ID: <20250509121935.16282-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a situation where after THALT is set high, TGO stays high as
well. Because jiffies are never updated, as we are in a context with
interrupts disabled, we never exit that loop and have a deadlock.

That deadlock was noticed on a sama5d4 device that stayed locked for days.

Use retries instead of jiffies so that the timeout really works and we do
not have a deadlock anymore.

Fixes: e86cd53afc590 ("net/macb: better manage tx errors")

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
v2: Use read_poll_timeout_atomic and add a Fixes tag.

 drivers/net/ethernet/cadence/macb_main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1fe8ec37491b1..e1e8bd2ec155b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -997,22 +997,15 @@ static void macb_update_stats(struct macb *bp)
 
 static int macb_halt_tx(struct macb *bp)
 {
-	unsigned long	halt_time, timeout;
-	u32		status;
+	u32 status;
 
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
 
-	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
-	do {
-		halt_time = jiffies;
-		status = macb_readl(bp, TSR);
-		if (!(status & MACB_BIT(TGO)))
-			return 0;
-
-		udelay(250);
-	} while (time_before(halt_time, timeout));
-
-	return -ETIMEDOUT;
+	/* Poll TSR until TGO is cleared or timeout. */
+	return read_poll_timeout_atomic(macb_readl, status,
+					!(status & MACB_BIT(TGO)),
+					250, MACB_HALT_TIMEOUT, false,
+					bp, TSR);
 }
 
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
-- 
2.49.0


