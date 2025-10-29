Return-Path: <netdev+bounces-233872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3CC19B7B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6113C340066
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AA339B47;
	Wed, 29 Oct 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Mp/RIP2R"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105230ACFD;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733438; cv=none; b=WXwLCjJ8aD8RFnP11ovCerAR5rAQeKTpsiXynfmE0oLdZJJPbCYxZgt/tiQ+DTK1tRzcoidwdeVW2a45n0BYtjGTSiTEDGCWr/6J9/bkLyxMZJnqNh84wmlpDi/b7hMsjl5dFK6U3euxTH/ob25H6Ca/CGmunpmnFd2AkuFwSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733438; c=relaxed/simple;
	bh=LWorVN0z+K6kgceBcQg4hnxyitdv/Bg0r2zhT2rt2I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIgeTVBSJ7dq2z2dsPdE9uTEtcJJhVlfVyaqKPx4TaHEdwzMd8395KmOpG8RHCayzoAw7k/9xBP8SzBM4fa3v2Mm2/1clXgvyiwO88u2yU+mP+yN2vbxh7axeaTE6fMinZ7Ss4AqkVhQCOOFj6AWWHm0Emht/rf0BByPJ7VWncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Mp/RIP2R; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3EB0EA08A7;
	Wed, 29 Oct 2025 11:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=2z5QiMzrrCSkR3IZJVVV
	A5sX7Ppj2SIi4n51Kw6tQiQ=; b=Mp/RIP2RTvl8NnemkKMMEu1dBi+YaMPW9RNg
	9V+w6F2wpb++gvB5ezQpzy/CjFkLqe1f0BG1IjcR6NTy1XvYWlC806DXD4AdeKRK
	KzqavfYiL7iPftqytwQP7NGeFDroDuAISevkU0/BGGwy70LG3nA75DGYtnd9dq8c
	T9AWzxpnTQnT3Z0mEOk+pqP2LKi1H4/+ZANXpImvmz069OnNNTbdBb92v4jOlW2V
	YOdczkk1Hneh84K8+dBNIimdU/cd6+QK+OEC0Pedrwd2GCQHLqEPdzsNh6h9GgN3
	OhXBV7alzgaGgUGiH6cKlVA88UFiyvfCm6MPundjYdGAPqPHuG8hCrs9WhDUGFP/
	q0TGLAdOi56GJGWbnKt2no8eAh+BZKgv64TvZ/cJQoghv3gizCa8rOe8zhN9ggBt
	mWDDJymR9CJyXiRHZkeOEqM4blMbzpQp4LPKwNNLdjmHBf77g7dRHNph88Nd+gzV
	zCvx5kx+3n9upajmoUwF56t7jqpBcd8ld0csP3tVax/zhrv+P95CYixrfbYHt6Nd
	wccKdD0fswUcMgjPLGNpU6R3TX0YgXLHmSOZww0tCfF/7cci279zWUZMUqqdneiS
	C6D+/umzSfUZvwa8LWwTsMaIUxvfHZhkR34sTurOQaW/xgPGYdgoQapqnbBsBgXW
	lVa1xeU=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v5 4/4] net: mdio: add message when resetting a PHY before registration
Date: Wed, 29 Oct 2025 11:23:44 +0100
Message-ID: <30736cb54c803e8992c9c4fd3ab38960a85dbc80.1761732347.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761732347.git.buday.csaba@prolan.hu>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761733432;VERSION=8000;MC=1456441996;ID=148165;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

Add an info level message when resetting a PHY before registration.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V4 -> V5: moved the info message to a separate commit
---
 drivers/net/mdio/fwnode_mdio.c |  9 +++++++--
 drivers/net/phy/mdio_device.c  | 13 +++++++++++++
 include/linux/mdio.h           |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 9669da2b7..d753ebd37 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -133,8 +133,13 @@ static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
 		return rc;
 	}
 
-	mdio_device_reset(tmpdev, 1);
-	mdio_device_reset(tmpdev, 0);
+	if (mdio_device_has_reset(tmpdev)) {
+		dev_info(&bus->dev,
+			 "PHY device at address %d not detected, resetting PHY.\n",
+			 addr);
+		mdio_device_reset(tmpdev, 1);
+		mdio_device_reset(tmpdev, 0);
+	}
 
 	mdio_device_unregister_reset(tmpdev);
 	mdio_device_free(tmpdev);
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index e24bce474..f2cbcb6bb 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -171,6 +171,19 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
+/**
+ * mdio_device_has_reset - Check if an MDIO device has reset properties defined
+ * @mdiodev: mdio_device structure
+ *
+ * Return: non-zero if the device has a reset GPIO or reset controller,
+ *         zero otherwise.
+ */
+int mdio_device_has_reset(struct mdio_device *mdiodev)
+{
+	return (mdiodev->reset_gpio || mdiodev->reset_ctrl);
+}
+EXPORT_SYMBOL(mdio_device_has_reset);
+
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {
 	unsigned int d;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index d81b63fc7..83cfc051e 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -92,6 +92,7 @@ void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
 int mdio_device_register_reset(struct mdio_device *mdiodev);
 void mdio_device_unregister_reset(struct mdio_device *mdiodev);
+int mdio_device_has_reset(struct mdio_device *mdiodev);
 int mdio_device_register(struct mdio_device *mdiodev);
 void mdio_device_remove(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
-- 
2.39.5



