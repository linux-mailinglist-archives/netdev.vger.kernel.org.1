Return-Path: <netdev+bounces-204795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB7AFC13F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71981BC04E5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D61239E66;
	Tue,  8 Jul 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DIYryuX7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F32343C9;
	Tue,  8 Jul 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944641; cv=none; b=Xc6KoWkCnR57xnAvIRTgoRFags6CmNt7A/czPI1hU3p9q5/g4Q39S3UcnITu2u0gh1KkhTS7Jx6ixmsLK6iFUctK5Yy8qJJ4mzo13k9G2p0ftHQ7y94U8y3NtlLScIETu9x4h7zmxS3okjKlKyox6CnLyZxxvGCB5XxzA65eYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944641; c=relaxed/simple;
	bh=yaM4TO7Trs1zxekdm1BdALVDkOi1WzDqa6qkyV8slns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJqUMST+j1TTSdNSdIVrJdWHnD51vU8AOv/7JKgQkuSLBzvY+G++z6i+JWWdzsEZ0ZpNUC0f35voVhN+k0XxsXJgObYH6E34fXZB4Ttgi/amFNxOWnOEtAoDbp5M9SyWkyglnutQvAzH8cEALb69Ys/ncbLNGfKzRwy0TZgnvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DIYryuX7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944639; x=1783480639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaM4TO7Trs1zxekdm1BdALVDkOi1WzDqa6qkyV8slns=;
  b=DIYryuX7D/RIUHaWi7Ha+6aOic+z1uo1FSmk9DPPNFq7PCRYA/0Bm89O
   AHXqEZ8inbWToAeyf/GH734MIrZxbuinCYyvYCKT46LVsoSUjgNZgVBm8
   rZB/sLkWDu2bwAUgHBEGS/orIqq6/o1wF12yH9LYWNDMYTlGGlZoP4x7M
   2nG68e+lswKRHfGzby81Z8MKHMlB3Mo8vyKlnkP6Em1ru9Vivwsd6ZuBd
   KE+g8lFQXWZi70ccyFRyP0J2jt0t8jlhqE1WIpU+1Q+1FoyrP1JLhpHrs
   tjyPFPipMs8g4wzyUZkUGxNiDSKso2WVQ2CVFv+c2Idyhe4w4aKIQ6dzD
   Q==;
X-CSE-ConnectionGUID: cVEISvaDRiehsZPvdpmZNg==
X-CSE-MsgGUID: +EB7KnAmQT2nOQYvsqhkOQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="43198304"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:47 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:47 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports for KSZ8463
Date: Mon, 7 Jul 2025 20:16:48 -0700
Message-ID: <20250708031648.6703-7-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708031648.6703-1-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
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

The PTP function of the switch is also turned off as it may interfere the
normal operation of the MAC.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 26 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 904db68e11f3..1207879ef80c 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
+	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -1745,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 		else
 			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
 				     PORT_FORCE_FLOW_CTRL, false);
+		if (p->fiber)
+			fiber_ports |= (1 << i);
+	}
+	if (ksz_is_ksz8463(dev)) {
+		/* Setup fiber ports. */
+		if (fiber_ports) {
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_CFG_CTRL),
+					   fiber_ports << PORT_COPPER_MODE_S,
+					   0);
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
+					   COPPER_RECEIVE_ADJUSTMENT, 0);
+		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c08e6578a0df..b3153b45ced9 100644
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


