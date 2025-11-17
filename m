Return-Path: <netdev+bounces-239117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003CC6443D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4C4C1240FB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6A32E754;
	Mon, 17 Nov 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tTbcMzAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1F32E6AB;
	Mon, 17 Nov 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384767; cv=none; b=X/8DELWW0hyZ88YC6xEQnYtwZuOhiAUzixngVv5E8f0/jcwIn3cQRafVaQRpRzHtnnmyVMMO834e3enYUj00enzT3ZHN1czQTiXRCH8MfcgeBF/yGzOR0sItuqPU9iTqA82v6mbLVHkDw5lZb5lv/b7T0c9zBQwf+Xm8uGgC+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384767; c=relaxed/simple;
	bh=Z+tuxarBHcRf03hexaRUPHmiKA1sZNeRDUlTYTEkTIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPT8VkDI/IfdoyUHIoAhe9QoOBCm4ZXUpD0FEQkk23b7oMvHlpClk8Eo59u4v3+tMCwC/zkORW7dSKqt5j7cyiPk75mzP9KWvfZAHv0ovoelMCzzn3MWlmF6jnj8Xp/erocE/1gCiUGP/Zdgw96hz9QgdpUUrTNjvadAG6mvU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tTbcMzAI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C382A1A1B79;
	Mon, 17 Nov 2025 13:06:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 997B5606B9;
	Mon, 17 Nov 2025 13:06:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74CB010371D32;
	Mon, 17 Nov 2025 14:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763384762; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CvnWrT3thpWNlYlyOwUMzAwg6Afa8Xa8RrmUZcVmlZ8=;
	b=tTbcMzAIimDwj+5GmnWQtvaBulYfZ9JtQsE43Pdod3tbZDWueebeSDP0/npF1pvDkzas6E
	LPeqCPKQk9AQ5QFXlKivaphtVC9yKF1JQhNy1bJGToNmhk2gWj8YVx1zc/9rlYQavkAo0w
	U05+Os/E9jsdYD/E7MbSEKoSFbh48oOxvbHsOVrgE3ng6nfgGjikhOv/lCsQyVOHnJ5x9b
	xejMZMQWofjDingQTCt6GYwmeWFD2vbkJnM0mflTF2eP9QSiGD47TKyB0iF2n1RCzbeF8J
	hyz1igeZFbyIBIqg75S1qPs7Vcw+fWVTuAl5ZFT7BIJcfBT3I8gEECGkGtljTw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Nov 2025 14:05:42 +0100
Subject: [PATCH net v4 1/5] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-ksz-fix-v4-1-13e1da58a492@bootlin.com>
References: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
In-Reply-To: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, on each
irq_find_mapping() call, we verify that the returned value isn't
negative.

Fix the irq_find_mapping() checks to enter error paths when 0 is
returned. Return -EINVAL in such cases.

Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2251ab23859b93a4f8af30a7d9c209ca64121408..c724f5af5d98bf3ff784e36393dd5b3fa7b37c13 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2584,8 +2584,8 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 
 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -EINVAL;
 				goto out;
 			}
 			ds->user_mii_bus->irq[phy] = irq;
@@ -2949,8 +2949,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);
-	if (pirq->irq_num < 0)
-		return pirq->irq_num;
+	if (!pirq->irq_num)
+		return -EINVAL;
 
 	return ksz_irq_common_setup(dev, pirq);
 }

-- 
2.51.1


