Return-Path: <netdev+bounces-205197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB2AFDC5D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638C11C23433
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC612E1CD;
	Wed,  9 Jul 2025 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pv2BDL/4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C00433A4;
	Wed,  9 Jul 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021187; cv=none; b=fiVogjr5w3/90oT0Jn4YwRx106g027YNciWhXYOMwvx2dt/Ih5Eq9y85zgQxr7V+KKki7OhvZo9A8/I7R0galT8TI+tKvaJHBfokpNjgY8c9vqH3mVeaLAh3TF4h5W0WOXNlPGN9TO7gqWL9QC95uVmBqhk3UTC/FHXs4gXjhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021187; c=relaxed/simple;
	bh=A7UgiFWhY6x4isXdHAZ4Gyk/kxfu0iiKVvhuop6xPaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqVX49UTp/JZP2gq4jMHaXpH1800VNdncKoEBdiSWJGQBB75EXMuezxvYtj/jD7BqBw3KGcWPsjPCfJN+LsJEfVSqjgjJtNOeD3P9pcv8kqtGK575rDDAOq4m+vX4Q/RXwsu2SGyP14HanNZhwMxCw4Zkjd0vIcMXdMM+n3z4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pv2BDL/4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752021186; x=1783557186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7UgiFWhY6x4isXdHAZ4Gyk/kxfu0iiKVvhuop6xPaM=;
  b=pv2BDL/4qQr+/WByA5wnBXMCk5eGygxPKYt7BU7PzmRdWNjXFkm4UUDr
   t0AuUgnaAKauGctH6HF8/kPJ8yAYpTQ8R31kFhTBplqrnTssN028CxW9y
   L6bkYIJhO2YppfpSb5nkkWtSl1+ByvGc4gi96Gw4UFzgdmk1ORBMbo4a6
   SwmsUd0Ui6HVDNfK/bnZJLXVGLyvqnRVI4UKgFAUqqeo40+69ySoTC+yS
   EnY5FWy3I+7vj94M3hn6qfWM6IX1/53GT7oRVDcc//l9lpJEhU6I9jX8U
   EzXdLGDxFvFk8vRxsDj4tsHtvLt1ThD7fgVyWaMJKC0MJnFFSz0N4E+Zm
   w==;
X-CSE-ConnectionGUID: 6Mp8GMV4SjKiBLDMr7TPXA==
X-CSE-MsgGUID: jZPyB53hSwiEHU+0/Z0CMA==
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="44354049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 17:32:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 17:32:38 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 8 Jul 2025 17:32:37 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v3 6/7] net: dsa: microchip: Setup fiber ports for KSZ8463
Date: Tue, 8 Jul 2025 17:32:32 -0700
Message-ID: <20250709003234.50088-7-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709003234.50088-1-Tristram.Ha@microchip.com>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The fiber ports in KSZ8463 cannot be detected internally, so it requires
specifying that condition in the device tree.  Like the one used in
Micrel PHY the port link can only be read and there is no write to the
PHY.  The driver programs registers to operate fiber ports correctly.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v3
- Disable PTP function in a separate patch

 drivers/net/dsa/microchip/ksz8.c       | 16 ++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 904db68e11f3..ddbd05c44ce5 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
+	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -1745,6 +1746,21 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 		else
 			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
 				     PORT_FORCE_FLOW_CTRL, false);
+		if (p->fiber)
+			fiber_ports |= (1 << i);
+	}
+	if (ksz_is_ksz8463(dev)) {
+		/* Setup fiber ports. */
+		if (fiber_ports) {
+			fiber_ports &= 3;
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_CFG_CTRL),
+					   fiber_ports << PORT_COPPER_MODE_S,
+					   0);
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
+					   COPPER_RECEIVE_ADJUSTMENT, 0);
+		}
 	}
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0ef41f8d0066..975caf911762 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -5441,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *dev)
 						&dev->ports[port_num].interface);
 
 				ksz_parse_rgmii_delay(dev, port_num, port);
+				dev->ports[port_num].fiber =
+					of_property_read_bool(port,
+							      "micrel,fiber-mode");
 			}
 			of_node_put(ports);
 		}
-- 
2.34.1


