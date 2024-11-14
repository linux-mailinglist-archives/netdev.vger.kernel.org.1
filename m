Return-Path: <netdev+bounces-144965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8009C8E8A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A791F282E1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF161AB533;
	Thu, 14 Nov 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W+67YXOF"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A119F113;
	Thu, 14 Nov 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598577; cv=none; b=G6JGNIVQ3HQ4n0VTol3HcrjGcYYG/SGy5HoItLuoEA59SCwK9ngNoeALWfnbGpYYWkqSwX1L02E4raMWhcWFpeyshuMa/HOtZnXhRoO+jdE9jOZA8TnrE5Bq+eAdIgX3VACB33f5/F8yV+nqRdDyDBezDxOCONHzvVkPb4wbhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598577; c=relaxed/simple;
	bh=pagQ4E98llj5WhhVwg5sUuIuZIu2/SnjGoREWIzjN8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uynCysnXHSvM6vcc6wO5TPJ/YEzwMby9MIzWLlTr0wi/m1AE+Qk2g9OBXh+wkPIoIbmOtVv9PkA0FdqOGBILtCj/6z3PnPUWLH7JEBRGEAN+Ocd6S51wkxKMiLfA5pAE5aHzrjaHIbUl5nfDk31glRCh8ysYQS/3nhK+XMsMfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W+67YXOF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D47D81BF214;
	Thu, 14 Nov 2024 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VD8/1+T7I2KYJ8+l7lEvgJb4z9DYRhu4yhGy99MnF/0=;
	b=W+67YXOFfNvngolUaEvMFYOYRinl6enMqD5OqOmjXIWHHFOzdBmjrwrUBNQmp7wUJLYcMe
	F5M+Wf3jWW8MMfYQjcXkIS8EkCg0MvR3z/SbGct+UkK/ctnFz3duQeXPvAWcOhhydmiuSq
	DTc0gYfpubMHuJqpvt2ZkdbgLABoUDOzeLkM3Hc3PFJXyeaHTljLX2CpWk7jKeyviKYxzr
	sJouP0/UqDuz9GeM2ReV6PsBpk5o75QQT+gRJSbCW46OHuyj+8YboIecRaVUb0kFfhHJMo
	ORH0CkWRXITnbTEzk9KwX4sht1y4nAFOS9ufbG29hGiLdVDyySx1gWgm3/OTzg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 09/10] net: freescale: ucc_geth: Introduce a helper to check Reduced modes
Date: Thu, 14 Nov 2024 16:36:00 +0100
Message-ID: <20241114153603.307872-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

A number of parallel MII interfaces also exist in a "Reduced" mode,
usually with higher clock rates and fewer data lines, to ease the
hardware design. This is what the 'R' stands for in RGMII, RMII, RTBI,
RXAUI, etc.

The UCC Geth controller has a special configuration bit that needs to be
set when the MII mode is one of the supported reduced modes.

Add a local helper for that.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: New patch

 drivers/net/ethernet/freescale/ucc_geth.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 15d05b270b6e..ace332d51aa8 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1258,6 +1258,13 @@ static int init_min_frame_len(u16 min_frame_length,
 	return 0;
 }
 
+static bool phy_interface_mode_is_reduced(phy_interface_t interface)
+{
+	return phy_interface_mode_is_rgmii(interface) ||
+	       interface == PHY_INTERFACE_MODE_RMII ||
+	       interface == PHY_INTERFACE_MODE_RTBI;
+}
+
 static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 {
 	struct ucc_geth_info *ug_info;
@@ -1290,12 +1297,7 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	upsmr = in_be32(&uf_regs->upsmr);
 	upsmr &= ~(UCC_GETH_UPSMR_RPM | UCC_GETH_UPSMR_R10M |
 		   UCC_GETH_UPSMR_TBIM | UCC_GETH_UPSMR_RMM);
-	if ((ugeth->phy_interface == PHY_INTERFACE_MODE_RMII) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
+	if (phy_interface_mode_is_reduced(ugeth->phy_interface)) {
 		if (ugeth->phy_interface != PHY_INTERFACE_MODE_RMII)
 			upsmr |= UCC_GETH_UPSMR_RPM;
 		switch (ugeth->max_speed) {
@@ -1594,9 +1596,7 @@ static void ugeth_link_up(struct ucc_geth_private *ugeth,
 				    ~(MACCFG2_INTERFACE_MODE_MASK)) |
 				    MACCFG2_INTERFACE_MODE_NIBBLE);
 			/* if reduced mode, re-set UPSMR.R10M */
-			if (interface == PHY_INTERFACE_MODE_RMII ||
-			    phy_interface_mode_is_rgmii(interface) ||
-			    interface == PHY_INTERFACE_MODE_RTBI) {
+			if (phy_interface_mode_is_reduced(interface)) {
 				if (speed == SPEED_10)
 					upsmr |= UCC_GETH_UPSMR_R10M;
 				else
-- 
2.47.0


