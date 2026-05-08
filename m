Return-Path: <netdev+bounces-285634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJP5EpBz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D24F1E95
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DBA301CFB9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1D33C183;
	Fri,  8 May 2026 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CxXc7oV0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84433BBC5;
	Fri,  8 May 2026 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217749; cv=none; b=XENXQREJl1TvzZBPwz4lYIYI+qUW6lPipBD5y2LPfRH6vCTM30HS38R6TEvXKlfTzAFF8X3byseOzi5zcuWVu08swJMlvPu+/6jaCS/4rHMuxCunhuB+tQzbyHQzj+MHRGqB7lnamCJGp3t9aO39zOBlbgd11SYWCmGrnDsSp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217749; c=relaxed/simple;
	bh=RkAcGFS++tyGD7Hqu5U360Au8/lV2PT0DRuuLMnRFJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4+ZLJYtK3R4MVPu3jlgnGAicYi8/BFhdfmpDF+LNzcptk2jhHK3SWgu4Xr+iIUjMPtTptEttPtvOQovEaRxFkAkwYwLxStT2W6F5MpntjmypE809/7uJTi17jof6s0tFu8CTPk4QC7W0e4rmVI5JSLpO9urmR8Cp+MheThZsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CxXc7oV0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217747; x=1809753747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RkAcGFS++tyGD7Hqu5U360Au8/lV2PT0DRuuLMnRFJg=;
  b=CxXc7oV0ordvXDPevrHTKNvEAjQG+rcHBi+rSefUGPGQ+qse3pmhrrcS
   AojKxhprwqFgplaVg6qpcewfKdWkPgPXwbm7+PDh0T3ZVX3LByDPH+2Ad
   liLJeWII/EXfwsfrAPvHTQxdUZbbMchM4SnWU6MnZEwpSjohY/hFIuP0v
   zF4ev/LOmGmXaAgxa56RrPkDSSA7PCSUk8RiNnjlXv58+sBaGhcUhLgKr
   4W6QCr82+J6e689GsPgpbVnIS107WlBXdzbDLDDVaZd+ur0YKNQLye0RN
   C/Uetw3tTZYeZBdnkHg3LHzIXViIJORz954jm9iMUfbx5LdOB3aHu/Osu
   w==;
X-CSE-ConnectionGUID: bd7FDk8rS9SqCTU5B3h9eg==
X-CSE-MsgGUID: zJlJVzpUTDyGiRPH0D/uoA==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="288577539"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 22:22:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 22:22:26 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:22 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 2/5] net: lan743x: read SFP straps from PCI11x1x device
Date: Fri, 8 May 2026 10:51:47 +0530
Message-ID: <20260508052150.11852-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508052150.11852-1-thangaraj.s@microchip.com>
References: <20260508052150.11852-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: B22D24F1E95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:mid,microchip.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Reads the SFP enable bits from the strap registers to determine
if the hardware is configured for SFP usage.

- Add STRAP_SFP_USE_EN_ and STRAP_SFP_EN_ definitions to read SFP
straps.
- Store SFP status in the adapter's is_sfp_support_en flag.
- Add a validation check to ensure PCS is enabled when SFP support
is requested, as SFP operation requires the PCS interface.
- Refactor debug logging to use the str_enable_disable() helper for
  consistency with modern kernel standards.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 16 ++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index fad4a246e06e..867310dbe9ba 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -62,6 +62,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_pcs_en = true;
 		else
 			adapter->is_pcs_en = false;
+
+		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
+			adapter->is_sfp_support_en = true;
+		else
+			adapter->is_sfp_support_en = false;
+
 	} else {
 		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
 		if (fpga_rev) {
@@ -73,8 +79,17 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_pcs_en = false;
 		}
 	}
+
+	if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
+	    adapter->is_sfp_support_en) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Invalid EEPROM configuration: SFP_EN strap specified without SGMII_EN strap\n");
+	}
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "PCS I/F %s\n", str_enable_disable(adapter->is_pcs_en));
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP support %s\n", str_enable_disable(adapter->is_sfp_support_en));
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -3665,6 +3680,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
+	adapter->is_sfp_support_en = false;
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index f0fa0580b04e..26c30dc2e55c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -37,6 +37,8 @@
 
 #define STRAP_READ			(0x0C)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_SFP_USE_EN_              BIT(31)
+#define STRAP_SFP_EN_                  BIT(15)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1081,6 +1083,7 @@ struct lan743x_adapter {
 	u8			max_tx_channels;
 	u8			used_tx_channels;
 	u8			max_vector_count;
+	bool                    is_sfp_support_en;
 
 #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
 	u32			flags;
-- 
2.34.1


