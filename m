Return-Path: <netdev+bounces-216509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C06B342CF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B4716EF5C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076D2EDD6D;
	Mon, 25 Aug 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ge2ZC4VK"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291F21773F;
	Mon, 25 Aug 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130987; cv=none; b=W0kdm3hnNr/K7k0afJFe1V8Y3crPUNX0td/tuC0jCveMFud+/nYORTvj9yC4PRJ8H3nfBb1LAYdwfUBcCWICJZMeSWMDvbReHDyTJMrI72YalmVjfRktPxO1Gh+DgjP9+hiCKCBICeJD13lwzQELGDsyD10RkeXqgfw2F96DvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130987; c=relaxed/simple;
	bh=Nc/C+Uz9sI4IAH7BzAHFC+jOEg5BudUYmXbAWP/XQwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IbJUdoHhfFx570qu8bDgQueM5Y6rFfq/XsnbyJj3okgYnq4DcZuzsotS4jitjp9A6TiPcieeHNeI7qfkMH17D279NWbg+APs+HstbE57ep4J1Lxr0moNGg5/80JKiJbKPvBH04jtbCN3dFNBCd8mw5w/1wU+oSZeHzLCBA/agD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ge2ZC4VK; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CDBF2A01D2;
	Mon, 25 Aug 2025 16:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=qikWbUtqVmNTODGhbr83i6EXZE+fIqqYsVSThC2Lx7o=; b=
	Ge2ZC4VKQ5WtBrus8o6tRBczDgySjYzbeEVOHy0qAmpmsiVFfp2AwfqRNtCbu82c
	zjbwbaHfs067Kf7O6/15e6mlNwj5dBgO4frOj/QPJhQXL3TnETa51oNzZ8kjpxT+
	C8N8MsD6NmUWO6mbsBTUcawXH8QwOx8oIIaEsN2LWNY99GqjYC4pf9hR93Giebr4
	24k01OxnfVwmRFml1QhgJafA2bi59Nfaj28CbXpWMDVayMpY7ZahxoJFL9xuUaKY
	nw/YFT9bDjLnzgXydchMTtrdTO40e6i9ZOs7XK0sRJL21avIwoPrO31//fz93ual
	27JjhutmAJJhmNl6sV172/BzcbiKVRQNAaAInqBYxuMWhmMrWGOnXLScwP5TiK6f
	H64xIYfK6kUKe+9BL2BX6lct48x5deBu50u2QW5Fmsr/ms1VfnZ6UxOTx64lLcK+
	CLUeZSHGqDvNFthz0UK1aCVLGEKMhSIQ5UNnrwqUna0FunM5pzVZOuVEBtgg+GFA
	1qvq7RAkPgx4/tAi4646CJez9svpDj07fQ3rqVH6aneF4uzzQsP6/fsPQThjnZMU
	rfttxDakx1CgKFhf3SMqA2xB4MhMxVuvAdyrf+nmUMjdPN9GRGT42oApvL9vZS47
	qn07wcW5E5khRJCef+Fq5ZrfGR0Jb+1TKnH2I6qh5Nw=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Mon, 25 Aug 2025 16:09:34 +0200
Subject: [PATCH] net: mdiobus: Move all reset registration to
 `mdiobus_register_reset()`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250825-b4-phy-rst-mv-prep-v1-1-6298349df7ca@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAJ1urGgC/x3MQQ6CMBCF4auQWTtJaUDFqxgXLR3sLKjNDCESw
 t0ZXX4vef8OSsKk8Gh2EFpZ+VMM7aWBMYfyJuRkBu987+6+x9hhzRuKLjivWIUquiHRtU3dbXA
 T2NHGib//6PNljkEJo4Qy5l9qDrqQwHGcT4S72X0AAAA=
X-Change-ID: 20250825-b4-phy-rst-mv-prep-09de61d4790f
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1756130979;VERSION=7996;MC=1807055755;ID=536864;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E607067

Make `mdiobus_register_reset()` function handle both gpiod and
reset-controller-based reset registration.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cad6ed3aa10b643ad63fac15bfe7551446c8dca1..9117f0f93756f38acb2c367e163ef06616eab6e4 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -33,8 +33,10 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
+static int mdiobus_register_reset(struct mdio_device *mdiodev)
 {
+	struct reset_control *reset;
+
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
@@ -44,13 +46,6 @@ static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
 
-	return 0;
-}
-
-static int mdiobus_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
 	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
@@ -68,10 +63,6 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdiobus_register_gpiod(mdiodev);
-		if (err)
-			return err;
-
 		err = mdiobus_register_reset(mdiodev);
 		if (err)
 			return err;

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250825-b4-phy-rst-mv-prep-09de61d4790f

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



