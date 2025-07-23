Return-Path: <netdev+bounces-209180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A61B0E89E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88B53A3EAE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746851FDA61;
	Wed, 23 Jul 2025 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f5hC/fl0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A581F099C;
	Wed, 23 Jul 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237609; cv=none; b=pi6uC3piPG2fWgnjtwhdQYpmhvUyEPB8+2zYYAk9l9iXY01HeFjmzqb6P6eQaqqtfTQMN73FNibD+TLURlgCe6A9TtS3GueMyXmDmR8ITcC87Gj53Q+UTyVOlKdnMF0a3CqMRDhzcaT3JRfkjXuXU0ecI48n5AvJFahV4jMequI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237609; c=relaxed/simple;
	bh=79Wgk5IW5Uc8vPPB58ide3VHHikd+vcI72rhK/lnzFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF4lQ068dal1zlCHlkPY3m32FjZ5s3p7F7zCTsg5eH3ciYh2ozMUF8F9f8V24ut0omPFhJejwavRhffdPuaWjsoYcTpttu6MtrzhKc8Fa4qIu6ti0FBBKH97RmeIxpij1jt2LDcVz3+Ew8gfcRx+xgPdlMr7rjhok8nsowRW7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f5hC/fl0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753237608; x=1784773608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79Wgk5IW5Uc8vPPB58ide3VHHikd+vcI72rhK/lnzFo=;
  b=f5hC/fl0o620tVp4QypFnjnTWkbVoFRb9Bqk53tdqJVcjY2uS5AqplDJ
   QcaUZaQwuNKzIgiMlyN5SZ8fH9zru/xAGAfubJYiwjXO2CCRS0rnjBqUs
   gESdOS4Ab00Kwo9b/5/WMCiWvd3407yJdz1itjFsAyzT0cXdtORegcwZX
   vGQ0UvWrIH3L71Sem0evCLo9KUZc+eDl45UhoVdQy5yyajVCQUyehC49I
   gWcurHNfsVvVZhy9CyPp6c0r60NMNoTM9QS0dRLb3xzzcfNz46MXkBsWS
   YdpW0JUaqZ8To0AoBYbRW0Fojy3iRE7Je04H+aX35M4gfaEzcDJi1VM3q
   g==;
X-CSE-ConnectionGUID: ol8zE+5pQbyz8nKT026TwA==
X-CSE-MsgGUID: Yi0SYItcTfKusgzYP8TsBw==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="275694688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2025 19:26:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Jul 2025 19:26:16 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 22 Jul 2025 19:26:16 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon Horman
	<horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v5 5/6] net: dsa: microchip: Setup fiber ports for KSZ8463
Date: Tue, 22 Jul 2025 19:26:11 -0700
Message-ID: <20250723022612.38535-6-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723022612.38535-1-Tristram.Ha@microchip.com>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
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
index 55c1460b8b2e..62224426a9bd 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1714,6 +1714,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
+	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -1744,6 +1745,21 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
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
+					   KSZ8463_REG_CFG_CTRL,
+					   fiber_ports << PORT_COPPER_MODE_S,
+					   0);
+			regmap_update_bits(ksz_regmap_16(dev),
+					   KSZ8463_REG_DSP_CTRL_6,
+					   COPPER_RECEIVE_ADJUSTMENT, 0);
+		}
 	}
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e47c4a5aad6f..7292bfe2f7ca 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -5439,6 +5439,9 @@ int ksz_switch_register(struct ksz_device *dev)
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


