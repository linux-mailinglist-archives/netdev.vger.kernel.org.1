Return-Path: <netdev+bounces-208298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D2B0AD3E
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7B158788D
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BA1E0E0B;
	Sat, 19 Jul 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IfayFrAj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E4186E40;
	Sat, 19 Jul 2025 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888101; cv=none; b=USRuyLf3Z2ExT9OKeaCUdYmnD350eF1OSpDYE2qgJ3AMJtXVIxeBBoPW3MXyrTHcya//ucB5BhTVEzxEeBi7zeYalb5nlFj2auxX2Yw8idg8U2I3mYmPn/ixrPwd3P0+FNiB7UKK3qCSduA4Nmik0uECqPXIu1L64u/61JRLLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888101; c=relaxed/simple;
	bh=ClODL7EYnCanK3yv21OF96C8rJsPIG4vZ2d/fmS82wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVvhb8FyYtUZBMXO31GuenCiIk0YWoKarnieSvEgu0YiVUj4cGJeU3hpD5HvrJtG7VJXNxkw7Dz3EIP1ECDhjGXTnc7SRyTmai7QUuagTPBnIO+7dI9GDH1znA8SygXNAoKMstDfgsNtn1C5OmmeU+ix4liFtkjzxHW0223ltgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IfayFrAj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752888100; x=1784424100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClODL7EYnCanK3yv21OF96C8rJsPIG4vZ2d/fmS82wg=;
  b=IfayFrAjydoGpxA3SfzeyYu5iCmCLLLJtQVBLjA1FglMmwcx2oOIwgT1
   fLmx7LBILRaPyeZkKw29ThqFjJZAUdEY7d8dXy9jum4w++qWgvDpfglwp
   hnl/QSPkfuz5uktZMBCtZf+IOS2xxuf/1WIh3PueKAQAVuG9JUgpFT1di
   BdzU+NgughLWr7jyj/c/AaAFPy20muOfoE/LiXaLBYQsaDFM0zWsz7nyJ
   5nJGaYUBdiG3uZGdYrPHjzFmN6lyv72wmY6sYzQCHJLAXIoM1dkNjVRMX
   MX4jk24EQnF0xNbHaIUNXlC0vwF7trnpoeWeMsMGKBzkb4gcVc99ZjkUl
   w==;
X-CSE-ConnectionGUID: nNeMYTH9S7+QK+h8shmrqw==
X-CSE-MsgGUID: abDUL0bbTwiNG1kf5zBd0Q==
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="44154237"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2025 18:21:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 18 Jul 2025 18:21:06 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 18 Jul 2025 18:21:06 -0700
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
Subject: [PATCH net-next v4 6/7] net: dsa: microchip: Setup fiber ports for KSZ8463
Date: Fri, 18 Jul 2025 18:21:05 -0700
Message-ID: <20250719012106.257968-7-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719012106.257968-1-Tristram.Ha@microchip.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
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
index 9b0ea77a081a..1fb0ebd0c50d 100644
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


