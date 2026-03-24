Return-Path: <netdev+bounces-271216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyFNV/TwmmUmgQAu9opvQ
	(envelope-from <netdev+bounces-271216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:09:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6840A31A85B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5F6305F521
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02938759C;
	Tue, 24 Mar 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t3/nDzxY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6F38236B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375723; cv=none; b=PqDRwgV42N3eSrTnvZMsQv5AzUTrmdfS0prjA/M5Ftyi+NeLOQSNhDbNjDE7e+eJReHakolg+hHzFfCZda/hsnS/1nLlnwmwtRg0T3avCTlmTrj20X/2zO7iyNjgHmRV8AQ/FXQZIzrYAatJG88ovU7sGi7w+k8H/I9eNWnL29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375723; c=relaxed/simple;
	bh=+rWsbnSu7iavpJeVQJPIMaiKsTi7XaRy03sKxDvZt8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wdz9DeEi4KsvZ7J9i2ZA4sR3WCqbVm2J1lDTBkoQtp7jFRpHZbOHMYeaymNydUo6KXC9+IRiq7dW2KyzFrPZcNy3FvQg62bmhSApVIVKWvPR1DDQ6nMlI4duBeHCsJTPN7BVmyoTSiz2jwzeznM5blhB3Ouqvarw957ZMcLZMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t3/nDzxY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 799384E427DA;
	Tue, 24 Mar 2026 18:08:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A6FA601A0;
	Tue, 24 Mar 2026 18:08:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7536D1045075C;
	Tue, 24 Mar 2026 19:08:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774375719; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5b9xyixENnVbw2fCyzMYNZxOHOwrlBNV7wONFUp6FTc=;
	b=t3/nDzxYUoGwdezk70NQIzwogvo9UOSdjZADoVHb/O22Al/cC7dl/J7f1jdUSNu1v/XIf4
	NLF/mi3Yzm1jpsZGfvcnW03f+9Bj0DcJ9yAij+9GFTNAyu/47lcH0FXzBQTVeBNo4ctpWK
	7bMuLfLpnS7VHUY6C1nTAALW/qXGAaJEhCDIgfNCNuwEO2oKHYVFQ+MKdt507/+nRgPVkU
	oxT3RxTSIdU3T/w4BxIvV2tyxLTahorUepXsVawolUzi2YAVOKf220+SrG7slAbRUwSAwu
	TzryPWnWiI33ZCZW3s7y0+zhlieu86toqOpNTUIPytvGtAbIoqTi5gy0vmPuRA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	UNGLinuxDriver@microchip.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: microchip: Drop unnecessary check in ksz9477 PCS setup
Date: Tue, 24 Mar 2026 19:08:24 +0100
Message-ID: <20260324180826.524327-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
References: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,microchip.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6840A31A85B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ksz_dev_ops .pcs_create() is called under the assumption that the
switch has a PCS port :

  if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
          ret = dev->dev_ops->pcs_create(dev);
	  [...]
  }

The KSZ9477 implementation of .pcs_create() does the same check on
ksz_has_sgmii_port(), and protects the entire function with it.

Drop it, saving a level of indentation and increasing readability.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 55 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 5416016b33e0..30d8c0146bbb 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -310,36 +310,33 @@ static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
 
 int ksz9477_pcs_create(struct ksz_device *dev)
 {
-	/* This chip has a SGMII port. */
-	if (ksz_has_sgmii_port(dev)) {
-		int port = ksz_get_sgmii_port(dev);
-		struct ksz_port *p = &dev->ports[port];
-		struct phylink_pcs *pcs;
-		struct mii_bus *bus;
-		int ret;
-
-		bus = devm_mdiobus_alloc(dev->dev);
-		if (!bus)
-			return -ENOMEM;
-
-		bus->name = "ksz_pcs_mdio_bus";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
-			 dev_name(dev->dev));
-		bus->read_c45 = &ksz9477_pcs_read;
-		bus->write_c45 = &ksz9477_pcs_write;
-		bus->parent = dev->dev;
-		bus->phy_mask = ~0;
-		bus->priv = dev;
-
-		ret = devm_mdiobus_register(dev->dev, bus);
-		if (ret)
-			return ret;
+	int port = ksz_get_sgmii_port(dev);
+	struct ksz_port *p = &dev->ports[port];
+	struct phylink_pcs *pcs;
+	struct mii_bus *bus;
+	int ret;
 
-		pcs = xpcs_create_pcs_mdiodev(bus, 0);
-		if (IS_ERR(pcs))
-			return PTR_ERR(pcs);
-		p->pcs = pcs;
-	}
+	bus = devm_mdiobus_alloc(dev->dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "ksz_pcs_mdio_bus";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
+		 dev_name(dev->dev));
+	bus->read_c45 = &ksz9477_pcs_read;
+	bus->write_c45 = &ksz9477_pcs_write;
+	bus->parent = dev->dev;
+	bus->phy_mask = ~0;
+	bus->priv = dev;
+
+	ret = devm_mdiobus_register(dev->dev, bus);
+	if (ret)
+		return ret;
+
+	pcs = xpcs_create_pcs_mdiodev(bus, 0);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+	p->pcs = pcs;
 
 	return 0;
 }
-- 
2.49.0


