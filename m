Return-Path: <netdev+bounces-304928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7NXUDPWVS2oKWAEAu9opvQ
	(envelope-from <netdev+bounces-304928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:48:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C23710101
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=sm6L2+WS;
	dmarc=pass (policy=reject) header.from=microchip.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304928-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304928-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD8943383E76
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0046AF15;
	Mon,  6 Jul 2026 09:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C0478E25;
	Mon,  6 Jul 2026 09:33:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330391; cv=none; b=Pg5EV991lvsQGlzrilI7VlZwk15eUrAISlDQAe1JeHup0ZC6iXaNUZvA3h4cq9aEyj29BhIpbUMYuOvvTy64eRGW0SIe+De1Pjfby21q6RzDEzch0ufNxQwBNT7TjNsjEEXep7g7vgulWyNf1PnNP98rTIkokK5wE5Q6gr5PUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330391; c=relaxed/simple;
	bh=hkq6n81dbq5dKW84e7zPo4gM/LPRc1H91p+5jh2ZvYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUvcuEvjzRZ399rMyEw5x9dmIznoYF7RJgQewroCDIFXa25Wjz9hH/RkXto5yscVjcsppBHbTBAL14TUtESnFhwprwAsCSsks2DpfV3yxQqIjna4lHPOOfJ/jTjMjofEaO6ckpEYm3lRWuoxgzrrTT2RboPMK/dkVm1xOE/XZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sm6L2+WS; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783330389; x=1814866389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkq6n81dbq5dKW84e7zPo4gM/LPRc1H91p+5jh2ZvYw=;
  b=sm6L2+WSO0CTKP1cdzELBUF7AS9pcRta9l19i7zsILn32F17YlyKyuDU
   gj211jzR/MLqZkHemfjGaNiPiCISjRXsajVYm5U1hm5OYmfbAO+vLlmOv
   9Cy0H2RCK+a8rxoQiPm8Pyr3cY+r/SW3vD+F/NACshzN7NnYYMb33R4J2
   ucuUd6OfqkE0YQ6dDMXqrNvDQNHx2VHHuHSAh7GETtRgNrD9PVBatZDBb
   EeDVm8bZ2GPGlaHWGtMKQW0WM+9G474sNiCVMOyqUCOKp4dHJA0IX10Ps
   fGiZbNNTxz6Q3GvHvv57Xq2fHOKij/1oieL3IdlnNxbnrnP1yHYKrtVfB
   g==;
X-CSE-ConnectionGUID: X76+GsS6Rb+3wL+Py/LNSQ==
X-CSE-MsgGUID: gYK8m1i8QFOicc9OUh+rPg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="291536143"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 02:33:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 6 Jul 2026 02:32:59 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 02:32:56 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 2/2] net: lan743x: add support for RMII interface
Date: Mon, 6 Jul 2026 15:01:50 +0530
Message-ID: <20260706093150.9033-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093150.9033-1-thangaraj.s@microchip.com>
References: <20260706093150.9033-1-thangaraj.s@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-304928-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,microchip.com:from_mime,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96C23710101

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
 drivers/net/ethernet/microchip/lan743x_main.c | 23 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 3a418105cd11..24ae56a3c9ed 100644
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
 
@@ -3562,6 +3574,12 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
 		}
 		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+		rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
+		if (adapter->is_rmii_en)
+			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
+		else
+			rmii_ctl &= ~RMII_CTL_RMII_ENABLE_;
+		lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
@@ -3628,8 +3646,9 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
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


