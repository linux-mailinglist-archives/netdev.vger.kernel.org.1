Return-Path: <netdev+bounces-231594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71823BFB147
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F961A03EFC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE03128D6;
	Wed, 22 Oct 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ZSjOjKdv"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602113115A6;
	Wed, 22 Oct 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124148; cv=none; b=ugqj69JC8E79t4D8KoCkOlS6wiHkFPx5N4jlggF8WfAytvgPW4TkhIq95hcb9RiQ1txz3N0lEnE67d91nUKIwafVYlTXcn/Ju8DSiBmY38Z6PW1PaFrtGO6FqAxEb+NOAg3Aa8ubEBQONqWNIt/Li1wA5UKzb4rymGF85+qWMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124148; c=relaxed/simple;
	bh=G2OOEo3rsfXSLJ4b3pmJVczmnz4uhk9lVRDIDwJIZCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fr2KGBnTiNYK1nkvhv5W0t/e5mUz12HB2Ikn3Zff7SnEQlQ4DkWQgn7fvyd67h+mOQ01kH9FWBfDT8IEcJNlyYRxP8DxIp2AqoH3dsWR59EEnN6WO0Zy/U0AF1yaiEcip3/jwHFAPJJkP5XYxAQ/l1BC0fo7iOX5/WPiVR9qKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ZSjOjKdv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4E84CA0255;
	Wed, 22 Oct 2025 11:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=iYozPLyaUEmOmLcTWVsd
	K59TTR8u4rh5ZEbwwSdE814=; b=ZSjOjKdvU5YyfqhlGoq4OSTSGbZeQpphW0UR
	EgXGsLX2wYz6Spc/UeGIE6euX3OfZDmQcJESuypXEL8WCK+/R9okh8hOpYt6qPI9
	r6JVzJYBGFOhni+84zmQLGSdOnFhltfDLIglErp8A+r/MCsIGLYmLI8Jf49Y5Y7f
	WWT1DxKB1eo9rZy9A7jU+vTT0IW/u/fByBlKrZTsWLTpon84OK2blnFMdJ9JtrQq
	SAZjyNrXzBpVKr0K0G+vYHOoKcR/S9DA2QGRe3iaGrEtgH5lTSPXpAyThYmhpKYx
	9CQja60RjqtEfzb+I3Bjr1kD+IY9//ZQj+emnFTg4TZTM9xF5fKjrJYuR/kA7HN0
	Ro34KyKbui7fR189TZhqhlpkfUVZPWzo9wt+jkFHNkcqxgBdVqVBEvaA+A/TCgWC
	fpAGDoY6KfE8EMG4+UzbhskMlqLVK6DzDa2QBoaxnsrnEGDwJbJZvu3uGITBHUvw
	xn7JwXRr5ff0UkHASwprmJ8xJy1xXBrJeeolLce1yQBTsmX22MxPHfiErJ+CR5Cq
	z1MAxDnvhSyCaiE0GIoBl3v7M/1l8E5NSdn/9XM+dv5ievrd8p3WuGnLwylv56Kk
	p7oEY/piBqlQkVroX1NX73qjhl6lmVd6zxvz0HPaZ7qUJIb41oXlGGdPUruzBfgO
	Mx03fd8=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v4 3/4] net: mdio: introduce mdio_device_has_reset()
Date: Wed, 22 Oct 2025 11:08:52 +0200
Message-ID: <ad7fc6105e7e9187d504a1cb9873e039ab1d4f8d.1761124022.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761124022.git.buday.csaba@prolan.hu>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761124136;VERSION=8000;MC=3312345989;ID=130160;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647D62

Introduced mdio_device_has_reset() to check if an MDIO
device has any reset properties defined.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V3 -> V4: new commit
---
 drivers/net/phy/mdio_device.c | 13 +++++++++++++
 include/linux/mdio.h          |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 5d39b25b7..b1122bab8 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -170,6 +170,19 @@ void mdio_device_remove(struct mdio_device *mdiodev)
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



