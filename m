Return-Path: <netdev+bounces-287924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNRRHWipBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:52:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9FD5409EA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CD73051BE8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9023B7B71;
	Thu, 14 May 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZWeqCujk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC283B27C6;
	Thu, 14 May 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755863; cv=none; b=pEB10ygbsaApwVn8EdyaFnUnS1iZe6idLc5xq/TvG8ZJ9zSOSKQrsrypiSHk14YeeLx1HXKyZKliQf7rQ5yBwvF9yw2Os+9Im2S0BDNJ3RpjXOraGdEOoH5sm/9L598YnKwyi8pt5tMNEDBFVDB/xLIYyPxCzLe+jOun5PEqMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755863; c=relaxed/simple;
	bh=acyoDuUwj1EZwWtotrmwzaqW9W/kOls3BxemOwPKds0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkRCANY4C4k5SD73G5VxIQCMSlAzUr7hgM0lWlgVHOnQAq2v0Ny78OeghhzKcn0jDzdO/N/SgVKLGis7PWr31hkdAiw0KMjMuo0CLto4Vrnf99jkspAlERy/4016/T05RowejytK45PWf6Q0yhhM9e4Tu2wDtUEgJl6ms/q5bOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZWeqCujk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755862; x=1810291862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acyoDuUwj1EZwWtotrmwzaqW9W/kOls3BxemOwPKds0=;
  b=ZWeqCujkLgSKdL5JZprCS5WjV/LnztXD4oMUpp+1qVqfebYFKQRCOi3D
   wqyeezWojSgH6ZY7CZOABbji3QJcc+TPWv9pzCRfXxCE286XtsOw4sGuw
   NVAXSsk0L5CGKObLfOxGtF37FyIB02RePM6ORGT7JIsqYOiDBLrddFSZ6
   FoTjmSlNeLqMiQqPUsjn3+GVc4D3X355soijmTEntI10/+NoapqNBZv79
   lpr+mU9LkAcGCn8L0pSPQPPR+yJAL4QiUl94o2m+l3iysn9b8KdNnW+E+
   ND+MMoWUnGP7GNfh0Owrp54sOmHjvnGCNllsT/LCaQqwIpUMkg1+nYqRB
   Q==;
X-CSE-ConnectionGUID: cbIlmiQpSLmlTBRpT6NgNg==
X-CSE-MsgGUID: GNGhjyd/Su2HW/T0XdSHWw==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="65858092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 03:50:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 14 May 2026 03:50:58 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:50:54 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Date: Thu, 14 May 2026 16:20:25 +0530
Message-ID: <20260514105028.42942-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514105028.42942-1-thangaraj.s@microchip.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: CA9FD5409EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-287924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

Reads the SFP enable bits from the strap registers to determine
if the hardware is configured for SFP usage.

Introduce CONFIG_LAN743X_SFP to guard SFP-specific code and select
the required peripheral dependencies (I2C_PCI1XXXX, GP_PCI1XXXX, SFP,
PCS_XPCS) only when SFP hardware is present. HWMON is also selected to
support thermal monitoring of SFP modules via the sfp subsystem.

- Add STRAP_SFP_USE_EN_ and STRAP_SFP_EN_ definitions to read SFP
  straps.
- Store SFP status in the adapter's is_sfp_support_en flag.
- Add a validation check when SFP support is requested without SGMII_EN
  strap; log the invalid combination and force is_sfp_support_en to false
  so subsequent SFP/PCS paths are safely skipped.
- Add debug logging for is_sfp_support_en using str_enable_disable()
  helper, consistent with the existing PCS debug log.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        | 15 ++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.c | 23 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index ee046468652c..0cc55d00ab52 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -57,6 +57,21 @@ config LAN743X
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
 
+config LAN743X_SFP
+	bool "SFP support for PCI11x1x"
+	depends on LAN743X
+	select HWMON if LAN743X=y
+	select I2C_PCI1XXXX
+	select GP_PCI1XXXX
+	select SFP
+	select PCS_XPCS
+	help
+	  Enable SFP module support for the Microchip PCI11x1x Ethernet
+	  controller. Requires the GPIO and I2C peripheral controllers on
+	  the PCI11x1x device to be present and probed.
+
+	  If unsure, say N.
+
 source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index fad4a246e06e..77a554a0432c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -62,6 +62,14 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_pcs_en = true;
 		else
 			adapter->is_pcs_en = false;
+
+#ifdef CONFIG_LAN743X_SFP
+		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
+			adapter->is_sfp_support_en = true;
+		else
+			adapter->is_sfp_support_en = false;
+#endif
+
 	} else {
 		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
 		if (fpga_rev) {
@@ -73,8 +81,22 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_pcs_en = false;
 		}
 	}
+
+#ifdef CONFIG_LAN743X_SFP
+	if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
+	    adapter->is_sfp_support_en) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Invalid EEPROM configuration: SFP_EN strap specified without SGMII_EN strap\n");
+		adapter->is_sfp_support_en = false;
+	}
+#endif
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "PCS I/F %s\n", str_enable_disable(adapter->is_pcs_en));
+#ifdef CONFIG_LAN743X_SFP
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP support %s\n", str_enable_disable(adapter->is_sfp_support_en));
+#endif
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -3665,6 +3687,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
+	adapter->is_sfp_support_en = false;
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index f0fa0580b04e..d9eb10ffac6c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -37,6 +37,8 @@
 
 #define STRAP_READ			(0x0C)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_SFP_USE_EN_		BIT(31)
+#define STRAP_SFP_EN_			BIT(15)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1081,6 +1083,7 @@ struct lan743x_adapter {
 	u8			max_tx_channels;
 	u8			used_tx_channels;
 	u8			max_vector_count;
+	bool			is_sfp_support_en;
 
 #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
 	u32			flags;
-- 
2.34.1


