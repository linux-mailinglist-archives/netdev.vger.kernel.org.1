Return-Path: <netdev+bounces-188594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304AAADC46
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BC172539
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3C20C497;
	Wed,  7 May 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="O+kU63T7"
X-Original-To: netdev@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC933FD;
	Wed,  7 May 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612764; cv=none; b=QX/RegmX+Q3cgMwjEkgyiG+Mf0hVZAUXtDhKjbnbPa5peWH+WVEAQRu/TuHQd5gVXjrmfNjeuN4vACa/iT5d86X69gErGb3614mpUm6C7pLvDjrKQHDreLRKFQlwBo2h020qO8dlXt+ToR7p6zSpKLCCeyjvXPmmylmYc9zddNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612764; c=relaxed/simple;
	bh=6sFQdNkfd4RMb0E9im/alpoZAbz8DgNAo7xkb53MLoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmASEEXY1hVloZLNsNrWQ2+FsMs14iNP3cuOUWJjswvV7QoLhTj6zHfq3PgTWQdoZSgGiKTwxlrWBO3Hx3A9xpxDsaMBo8eimVlj4VrgFROEsaJNK7ij/KlfLxodRi3L7GNrfYsVLWpdRAq36H4U1z+MKaLfTqtj9MZRBVOUhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=O+kU63T7; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1uCblV-0004Su-I4; Wed, 07 May 2025 06:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=vCpJ2J3KHxiqYjZhPsqE5SUvFO//8m8vFjUOTtCuMLk=; b=O+kU63T7OAWoyV
	l7phJqEitr2cd/s06GbTtbmm5qphEq4WkqEVIHh/biwWEBdSB+2XBJniVpRhyR6yfO9vJLO7IRDoe
	3tOH//STEdZ9JsHfIZjYB5U8YHFNREDXYJ6LN0nlNI0S89gFVaea4E6FM7x8Tnms8GI7T78d/ugDp
	l4A0mGEx+YPJqcbEWxyhlbrg+z4A9empLf4UYsi/uQUltNFTvpR5ij+CccoR68z2x7ufA7XPKX9a9
	fd/Fuss+Iexvi/8jPdZQKAfT4Fu2otJIq5/OUgrJjDDeUYxbGD0MXSzdwY47yvR+eReyuCJz/jVYL
	HnG/Ekf4ZAkytcXDlWOw==;
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
Subject: [PATCH] net: cadence: macb: Fix a possible deadlock in macb_halt_tx.
Date: Wed,  7 May 2025 12:12:31 +0200
Message-ID: <20250507101231.12578-1-othacehe@gnu.org>
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

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1fe8ec37491b1..ffcf569c14f6a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -997,20 +997,19 @@ static void macb_update_stats(struct macb *bp)
 
 static int macb_halt_tx(struct macb *bp)
 {
-	unsigned long	halt_time, timeout;
-	u32		status;
+	unsigned int delay_us = 250;
+	unsigned int retries = MACB_HALT_TIMEOUT / delay_us;
+	u32 status;
 
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
 
-	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
 	do {
-		halt_time = jiffies;
 		status = macb_readl(bp, TSR);
 		if (!(status & MACB_BIT(TGO)))
 			return 0;
 
-		udelay(250);
-	} while (time_before(halt_time, timeout));
+		udelay(delay_us);
+	} while (retries-- > 0);
 
 	return -ETIMEDOUT;
 }
-- 
2.49.0


