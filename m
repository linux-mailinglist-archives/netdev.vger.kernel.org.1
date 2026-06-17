Return-Path: <netdev+bounces-300036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uepxN+0xMmobwgUAu9opvQ
	(envelope-from <netdev+bounces-300036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4341A6969B5
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:34:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=Q9ynpzRo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300036-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300036-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227D7310F23F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BB34EF03;
	Wed, 17 Jun 2026 05:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1B337107;
	Wed, 17 Jun 2026 05:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674385; cv=none; b=cxw0w1EJKNU9HfYyo4YUoHP6h1rxVlFRVQyfUmbIOc4c0XQJNgzx2gSueNZzhK/kK8H5qV20WBGD5WL/nwQFQRzp0EG6ir1vCrtxcEZuSv4cRkJVoFZs8hnRa3vJ0KKivZSpSGv90xfqHlzsLNxRZTt2tsQ3jGerWKP+iMXhMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674385; c=relaxed/simple;
	bh=cQPEr8n+gNE4UdhFiMURGhuDCBHi3UB5i17jEoz712c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXAfBps6d0sQXl86wqToBv8PaBhY9lLZypFpnNgEy5BX0op6I2TPJsXa9WlmMyXRO0WzwUpef7CC8mlrya52Xxf2pvDTOOFOQG/5ncfnJUwPsxIs1TsPp+D1fMv9yY4XGK1tUEwfaxASkcZjyC6kxbpGgNNyu0fwCdTkbywamMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q9ynpzRo; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781674384; x=1813210384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQPEr8n+gNE4UdhFiMURGhuDCBHi3UB5i17jEoz712c=;
  b=Q9ynpzRoj7X/gI01bEgxg8OJSxqF0vuhZPmnNdtJKItiBp4QAUqP2u28
   7hq0Up81PmvwAs92zSfpfThWmOHcwG442eXjacdljw31/KCtun15DtYDp
   Q9xt8CV6h7HjE5vgmsDPfACG3GDtzSAKtQQSidfi/MdfcNmWoIJd2osUP
   MLBSO9COO0vy1W7YwS87bXTmLgNUU7aVTd8VX4qczo7yd77u2NUebEuSt
   mGzRhNDXGcIc1bJIqk3CvDH0uN4MqYn08ib9tsecqInp3Irr+rN5sSpYz
   cg2GNLfI3T7rflDyFo8SwhPfUitjHpT+3ITJxVPZT7q5KSYonLpsDR8oz
   A==;
X-CSE-ConnectionGUID: Pioby+k1SN6oZG37jLscdA==
X-CSE-MsgGUID: OHNLBiAET9GCLPFMMGpQQg==
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="68341237"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:33:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 22:33:03 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Jun 2026 22:33:00 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 2/2] net: lan743x: add support for RMII interface
Date: Wed, 17 Jun 2026 11:02:41 +0530
Message-ID: <20260617053241.157932-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617053241.157932-1-thangaraj.s@microchip.com>
References: <20260617053241.157932-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4341A6969B5

Enable RMII interface in the lan743x driver for PHY and MAC
configuration.

- Select RMII interface in lan743x_phy_interface_select().
- Update phylink supported_interfaces and MAC capabilities.
- Enable RMII via RMII_CTL in lan743x_hardware_init().
- Define RMII_CTL register and enable bit in lan743x_main.h.

EEE is not supported with RMII on PCI11x1x: the hardware does not
implement LPI signaling over RMII. Clear RMII from lpi_interfaces to
prevent phylink from enabling EEE on this interface.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 22 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 0798f3f1f435..75303b0e1df0 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1402,6 +1402,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 
 	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	else if (adapter->is_pci11x1x && adapter->is_rmii_en)
+		adapter->phy_interface = PHY_INTERFACE_MODE_RMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
 	else if ((id_rev == ID_REV_ID_LAN7431_) && (data & MAC_CR_MII_EN_))
@@ -3190,6 +3192,12 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  adapter->phylink_config.supported_interfaces);
 		break;
+	case PHY_INTERFACE_MODE_RMII:
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  adapter->phylink_config.supported_interfaces);
+		adapter->phylink_config.lpi_capabilities = 0;
+		break;
+
 	default:
 		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
 	}
@@ -3197,6 +3205,9 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	memcpy(adapter->phylink_config.lpi_interfaces,
 	       adapter->phylink_config.supported_interfaces,
 	       sizeof(adapter->phylink_config.lpi_interfaces));
+	if (adapter->phy_interface == PHY_INTERFACE_MODE_RMII)
+		__clear_bit(PHY_INTERFACE_MODE_RMII,
+			    adapter->phylink_config.lpi_interfaces);
 
 	pl = phylink_create(&adapter->phylink_config, NULL,
 			    adapter->phy_interface, &lan743x_phylink_mac_ops);
@@ -3541,6 +3552,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 {
 	struct lan743x_tx *tx;
 	u32 sgmii_ctl;
+	u32 rmii_ctl;
 	int index;
 	int ret;
 
@@ -3562,6 +3574,11 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
 		}
 		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+		if (adapter->is_rmii_en) {
+			rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
+			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
+			lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
+		}
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
@@ -3628,8 +3645,9 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
 			dev_dbg(&adapter->pdev->dev, "lan743x-mdiobus-c45\n");
 		} else {
-			dev_dbg(&adapter->pdev->dev, "RGMII operation\n");
-			// Only C22 support when RGMII I/F
+			dev_dbg(&adapter->pdev->dev, "%s operation\n",
+				adapter->is_rmii_en ? "RMII" : "RGMII");
+			// Only C22 support when RGMII/RMII I/F
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1f8d9294a6ef..d9495cf96b41 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -325,6 +325,9 @@
 #define MAC_WUCSR2_IPV6_TCPSYN_RCD_	BIT(5)
 #define MAC_WUCSR2_IPV4_TCPSYN_RCD_	BIT(4)
 
+#define RMII_CTL			(0x710)
+#define RMII_CTL_RMII_ENABLE_		BIT(0)
+
 #define SGMII_ACC			(0x720)
 #define SGMII_ACC_SGMII_BZY_		BIT(31)
 #define SGMII_ACC_SGMII_WR_		BIT(30)
-- 
2.34.1


