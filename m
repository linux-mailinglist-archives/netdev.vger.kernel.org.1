Return-Path: <netdev+bounces-117318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6194D938
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6BB1C21442
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1016DC3D;
	Fri,  9 Aug 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d+4rzZwk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A716D9A2;
	Fri,  9 Aug 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246728; cv=none; b=rR7pbSXTxhkO/PPdrWZQRLtLkRzd5AZUtHX/UR8hV41XnF5qeHvK5fTKHmXyK7k3VayXU2ik+pU5cocwQBjCJcg7MWaEUAFbmaDIWmgx5d5hjsgtsZ3m4lb5IBvX7yDEp4NqweW1v5cB+ShpqbyryqedvN3wO/qPaZf20ILN4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246728; c=relaxed/simple;
	bh=WFbeAolBN08iDgK7DMHwz5qY2rBBhAHYQ5rcEX8OL4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgVJKUADbIqei9KKYIJxLxbH5jX4IZhl0sLZI8QaPdeqyiMHOoxeZNkBOR5gF4iFJ61lHm66P/jJ1ZuRMs8jVIhd65W5wwXPAO2GLQVSU1a4xJs+SMV3tNt/GN7BxRc0iTMTWPgH4QzeG0CssMbcDd1ATguI0x+ABwZjTzI44do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d+4rzZwk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723246726; x=1754782726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFbeAolBN08iDgK7DMHwz5qY2rBBhAHYQ5rcEX8OL4I=;
  b=d+4rzZwkbn5+nqpfp7N3g2JUX/4IVUkua7bDaK/yBRGqOfIZaeOUkNh1
   U6hOpH9Wg8RroI2anDYPlZzhzkKhVWe4ZfUZAk1EVRAzZIpdQsIs/4W4Y
   A7wmQ5L6vEkijhbKxoeaGJ0TiT89Xo3p6UgDWKFdjJHJGpSQ8RT9VeDGm
   BYZmKqfQlA3OP1LL6tIwMu147c6WPgY83tCJUbnaP9R8rnthyysD7POqh
   /2cIuN6gdzjVr/7uQ2UxfMRrPUflUbVMshZ4XRV/WjbO87kgYVeqqCLNM
   qzVMglvf994ZkMJZyRk1yvnvVXHC+R8boFTKTFno7I4uWl/vlbBBARoOB
   g==;
X-CSE-ConnectionGUID: zHerXwjfR2qUoEM/PnTZ/A==
X-CSE-MsgGUID: fdJpwhyNQZCKlheyjWH6cw==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30988810"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 16:38:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 16:38:41 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:41 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 2/4] net: dsa: microchip: support global switch interrupt in KSZ DSA driver
Date: Fri, 9 Aug 2024 16:38:38 -0700
Message-ID: <20240809233840.59953-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809233840.59953-1-Tristram.Ha@microchip.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 DSA driver outsources interrupt handling to other drivers
such as PHY, but the switch driver still needs to handle some interrupts
itself.  This patch prepares the common code to allow specific switch
drivers to handle all switch interrupts.

The port interrupt handling uses the same function as used by the global
switch interrupt, so the port variable is used to differentiate that.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 15 ++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  5 ++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1491099528be..f328c97f27d1 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2,7 +2,7 @@
 /*
  * Microchip switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/delay.h>
@@ -2257,6 +2257,12 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	if (ret)
 		goto out;
 
+	if (dev->dev_ops->handle_irq) {
+		ret = dev->dev_ops->handle_irq(dev, kirq->port, &data);
+		if (ret == IRQ_HANDLED)
+			++nhandled;
+	}
+
 	for (n = 0; n < kirq->nirqs; ++n) {
 		if (data & BIT(n)) {
 			sub_irq = irq_find_mapping(kirq->domain, n);
@@ -2300,6 +2306,7 @@ static int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
 
+	girq->port = 0;
 	girq->nirqs = dev->info->port_cnt;
 	girq->reg_mask = REG_SW_PORT_INT_MASK__1;
 	girq->reg_status = REG_SW_PORT_INT_STATUS__1;
@@ -2314,6 +2321,7 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 {
 	struct ksz_irq *pirq = &dev->ports[p].pirq;
 
+	pirq->port = p + 1;
 	pirq->nirqs = dev->info->port_nirqs;
 	pirq->reg_mask = dev->dev_ops->get_port_addr(p, REG_PORT_INT_MASK);
 	pirq->reg_status = dev->dev_ops->get_port_addr(p, REG_PORT_INT_STATUS);
@@ -2419,6 +2427,11 @@ static int ksz_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_ptp_clock_unregister;
 
+	if (dev->irq > 0) {
+		if (dev->dev_ops->enable_irq)
+			dev->dev_ops->enable_irq(dev);
+	}
+
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
 			   SW_START, SW_START);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..a2547646026f 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip switch driver common header
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ_COMMON_H
@@ -99,6 +99,7 @@ struct ksz_irq {
 	int irq_num;
 	char name[16];
 	struct ksz_device *dev;
+	u8 port;
 };
 
 struct ksz_ptp_irq {
@@ -373,6 +374,8 @@ struct ksz_dev_ops {
 	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
 	void (*exit)(struct ksz_device *dev);
+	void (*enable_irq)(struct ksz_device *dev);
+	irqreturn_t (*handle_irq)(struct ksz_device *dev, u8 port, u8 *data);
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
-- 
2.34.1


