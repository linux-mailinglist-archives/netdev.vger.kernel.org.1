Return-Path: <netdev+bounces-306842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ckEbIe8rUmqCMwMAu9opvQ
	(envelope-from <netdev+bounces-306842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F56741680
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TVvz/vkP";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306842-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7EE13007B90
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB63C276E;
	Sat, 11 Jul 2026 11:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B823C1400
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:41:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770093; cv=none; b=U4v6fNYua7j1FPFPdyH+huHx5LZf81rGZAinQSCgy1JRXgUhffLlYdEaPBP4LOTQf93I74ajBzpPGDtzWwIozwUj0EOcbMAChdyTxUwba+aQxmRQRNpEtpGc/HQvm9BxMPrD6VadrbmhBoaMKvWFR+2BUsV8gvYuuRzHamQLXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770093; c=relaxed/simple;
	bh=yty9WLIUjhx4aO4+deZv2mcG0G1/RFIWFovRaTjaN0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rICYCeOh0KllkQtwbAZLf/66HdkAT26YJmw3o3OXVVwjlhuBf2yG6eYkNTqCpmWAYBu69TNDBwlDwf4YF0YsU2Ss5+So4dL8WlJ5naVydmaaciUZFgdk0N+9caeZfyrjrtgQng6ESLPV1MhmiIFynFxnhPe+Vhnz0bAFkd5G2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVvz/vkP; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccf2360620so15263425ad.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783770091; x=1784374891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9JdVGG2sNfYkjr/rkIYVFcSLhYtKWGKRZRHailPGqU=;
        b=TVvz/vkPnwhqGtYWJR9HdjyOuiBN9LIIcZ1yROn7i8/2w4XZAFRkZhz8kI3sDvBlp2
         p0uswLU7WTaSoaV5VwekgJHFk12oBoad/3QHDmbUOFTXw0wRr/ibEViGUopgTMDkx1Vk
         tn8yvSQ8cRiO5lLgxULDUd97KcXDtH5fiWmdJ0wSBnS38ojqNkzojUcM0euUINZ6rG9I
         LAjhI/Uy5isVHnn/xLeN4OuAIRNi9cKt2PEqn+S4BKabw8eCa2BjLBykRd/koVA3fNVk
         HOW2gRsLOX8F+uIYA7kF5/Ycgxe80mxnj8loujtv8oVDygpa56WXdttktiqOnnfnnKbT
         rBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770091; x=1784374891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9JdVGG2sNfYkjr/rkIYVFcSLhYtKWGKRZRHailPGqU=;
        b=SiGHQcw+F9KCA4twgFKY4J3Iadeoy92ESIjVxKV7EqwPu+Jsxn/ldBW0M0mfFtijTL
         La/sm/mEBjNbfbkNAMUx5HRFNXTrNLjdt8VJO1B+I/2OSHyLGSNzLgXU0/oNrSP0YSrP
         ecUJcL6EV82MCR0iS8T283zUo9h20L8lW7xV85hHTvs8ETymooMEsmA7S2Q15BMkjmk+
         3Y83d5Dp2ek7gE4tXtFtfkpkjxnIUXndjQXmdl0kYvil8Z1rWSKITmFHL6MQdlgQ7j6H
         /SRV47cht13wJTPE/woXLchdGmrSjh92YKobxdOOOhgFqaKKHg6FzWE2n7biMhSF9mqV
         Y0jQ==
X-Gm-Message-State: AOJu0YyKpQ13MLcbW9erbo/Zc3b2Cu5ZcRGuW/dkjAb4/06h5BbizRoH
	D8xdegtG53SK+qHne0JdgtDILrD71gQ/sAcnD9BoMXiHBiDDjZy5aKS/YpPSYEA1
X-Gm-Gg: AfdE7ckZCEnu21YIraxL7eAYavG6/W9AZ1Dq1deNlMMvAenLueEwRrtrD/tYKm8JmYP
	0XW+bQUv1V/RxsvzmGaOWaWy+LzpyZ1cxtLhxGw4YL1I+UvX0FpxtVlOQPABN/Yi8tuIGHSmE2I
	olTgbFMKxQDbx8YqZbmQSmyD6PXwFrz6YGTMv3n3oR9iIC41xOsWqxt5RzIn2TUfoQkGJqAaSm0
	okxgnt5drbuN1p7xKwB+kz0hIyb4G9zHh0N2LloUZ9Vgntppzlu4NdL7U5csVmcbi4g4KyCvu4f
	poWjnVq9IQZKxO/PFzEkewKtaqOk8BQ8Nzv+dBz6NDCjhXuTfoCdqTiCnH6ohp9phImWPioh4KG
	HGATPZxs4U4NWfK03+F1dVRZJ+/kqzgUIhvKktWESzLcdQ22olivnY8DL5KkUOTAqhnHZKSGUQt
	PlN2sqoer3FJ9ChB3s/i45
X-Received: by 2002:a17:90b:1fc8:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-38dc75f4cf5mr2500551a91.15.1783770091060;
        Sat, 11 Jul 2026 04:41:31 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm32390087eec.24.2026.07.11.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:41:30 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next v2 2/2] net: dsa: mt7530: add EN7528 support
Date: Sat, 11 Jul 2026 15:41:01 +0400
Message-Id: <8c7dfabd860ab0a6dd771c2bac7b7599eb369a4f.1783770059.git.naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783770059.git.naseefkm@gmail.com>
References: <cover.1783770059.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306842-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arinc9.com,davemloft.net,lunn.ch,collabora.com,kernel.org,gmail.com,makrotopia.org,google.com,mediatek.com,redhat.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arinc.unal@arinc9.com,m:chester.a.unal@arinc9.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:conor+dt@kernel.org,m:dqfext@gmail.com,m:daniel@makrotopia.org,m:edumazet@google.com,m:kuba@kernel.org,m:krzk+dt@kernel.org,m:Landen.Chao@mediatek.com,m:matthias.bgg@gmail.com,m:pabeni@redhat.com,m:robh@kernel.org,m:linux@armlinux.org.uk,m:sean.wang@mediatek.com,m:olteanv@gmail.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:naseefkm@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59F56741680

The EcoNet EN7528 SoC integrates an MT7530 switch (the chip revision
register reads 0x7530), memory-mapped in the SoC register space and
reached through the same MMIO glue used for the built-in switches of the
MediaTek MT7988 and Airoha EN7581/AN7583 SoCs. Its reset sequence and its
PHY indirect access registers are the same as on those switches, so add
an ID_EN7528 variant bound with the "econet,en7528-switch" compatible,
reusing mt7988_setup() and the indirect PHY accessors.

The switch core, however, is an MT7530 and not an MT7531 derivative: the
CPU port to trap frames to is set through the MT7530-style CPU_EN /
CPU_PORT fields of the MFC register rather than the MT7531 CFC register,
so add it to the MT7530 handling in mt753x_conduit_state_change(). For the
same reason the MT7530 mirror and force-mode register layouts already
apply to it as the default of the MT753X_*() macros.

The four user ports (1-4) are connected to integrated Gigabit PHYs at
MDIO addresses 9-12 of the switch internal MDIO bus. The CPU port (port
6) is connected to the SoC Ethernet MAC at a fixed 1000 Mbps full duplex
link, so the port capabilities cannot be shared with the MT7988 and
EN7581 switches, whose CPU ports run at 10 Gbps.

The LAN GPHYs advertise EEE by default, but negotiating EEE with some
link partners results in an unstable link with dropped frames. Leave the
LPI capabilities empty for the EN7528 so that phylink disables EEE on
these PHYs and refuses to enable it from userspace.

Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 drivers/net/dsa/mt7530-mmio.c |  1 +
 drivers/net/dsa/mt7530.c      | 58 ++++++++++++++++++++++++++++++-----
 drivers/net/dsa/mt7530.h      |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 1dc8b93fb51a..1065671bcdd1 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -13,6 +13,7 @@
 static const struct of_device_id mt7988_of_match[] = {
 	{ .compatible = "airoha,an7583-switch", .data = &mt753x_table[ID_AN7583], },
 	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
+	{ .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },
 	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
 	{ /* sentinel */ },
 };
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3c2a3029b10c..6c8ed00ee9e7 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2912,6 +2912,30 @@ static void en7581_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
+static void en7528_mac_port_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
+{
+	switch (port) {
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 1 ... 4:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+		break;
+
+	/* Port 6 is connected to SoC's GMAC at 1000 Mbps full duplex. There
+	 * is no MII pinout.
+	 */
+	case 6:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_1000FD;
+		break;
+	}
+}
+
 static void
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -3101,17 +3125,24 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 eeecr;
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
-	config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
-
-	eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
-	/* tx_lpi_timer should be in microseconds. The time units for
-	 * LPI threshold are unspecified.
+	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
+	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
+	 * link with dropped frames. Leave the LPI capabilities empty so that
+	 * phylink disables EEE on these PHYs and refuses to enable it from
+	 * userspace.
 	 */
-	config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
+	if (priv->id != ID_EN7528) {
+		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
+
+		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
+		/* tx_lpi_timer should be in microseconds. The time units for
+		 * LPI threshold are unspecified.
+		 */
+		config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
+	}
 
 	priv->info->mac_port_get_caps(ds, port, config);
 }
@@ -3254,7 +3285,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	 * forwarded to the numerically smallest CPU port whose conduit
 	 * interface is up.
 	 */
-	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
+	    priv->id != ID_EN7528)
 		return;
 
 	mask = BIT(cpu_dp->index);
@@ -3459,6 +3491,16 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.mac_port_get_caps = en7581_mac_port_get_caps,
 	},
+	[ID_EN7528] = {
+		.id = ID_EN7528,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7988_setup,
+		.phy_read_c22 = mt7531_ind_c22_phy_read,
+		.phy_write_c22 = mt7531_ind_c22_phy_write,
+		.phy_read_c45 = mt7531_ind_c45_phy_read,
+		.phy_write_c45 = mt7531_ind_c45_phy_write,
+		.mac_port_get_caps = en7528_mac_port_get_caps,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index dd33b0df3419..5f1e841f42c0 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -21,6 +21,7 @@ enum mt753x_id {
 	ID_MT7988 = 3,
 	ID_EN7581 = 4,
 	ID_AN7583 = 5,
+	ID_EN7528 = 6,
 };
 
 #define	NUM_TRGMII_CTRL			5
-- 
2.34.1


