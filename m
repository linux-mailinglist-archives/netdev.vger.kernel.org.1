Return-Path: <netdev+bounces-287923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LnALBmpBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88B5409A1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3825300B5A8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445D3B19DB;
	Thu, 14 May 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BbY0fwrr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F73A8739;
	Thu, 14 May 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755862; cv=none; b=H0Ptwg2TnrwGLCiA12aGxQuoQQksFO+Y0c9hbS5fTEONuou+Kpi8u2bcDxKRnB5NCMYTYQN4CB46X9zamvPG+27YusUvgit0pto+50GiGSkKe88muv1LBJxJKCfzxZXLKsNz/xicaFa6paPC76WiuhRC97JizzwG5ducfSTCOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755862; c=relaxed/simple;
	bh=/WadYXeNsvZ0sj7kfWtCdyJIzDwGWspdCLPutduhIbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q19DDycR4+8B6RkgtZKD2jOptvgqjbgggLzWzb6K7TUFth+Iyp6hSK2D0HDSuz6a8S7s/U711upJ8N8hBRN3wMzjYtigq5gwRg+CgUFFDFdqffrl1MqC3pGURP9vvCVV1Br/2AOWThbdfJ4yw4jcu2ZRADpp9R/X+Bc6WSePi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BbY0fwrr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755860; x=1810291860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WadYXeNsvZ0sj7kfWtCdyJIzDwGWspdCLPutduhIbI=;
  b=BbY0fwrrrm4LYCtLjrtIO/w2Z4wNaNwPhVoNyiibOMV0scUGkOlJeUSj
   S384IOhTUxFgtf1RmtV7xJoN1Inq/bwce6VRJqu7XjarXJBsb7guSMbi+
   VyOL0mbDNTuMgsqRHMTfqojWGsub0otdoAZn1acMAzGNQVjA9w/i8Hl2o
   deO23CR+zJxfnSjAlUlq44We15Bk36H9SklPKHSnA8Ceyn2AxWXCsTyAU
   zhG26JlxsahbbQLbfzPwIxzvLa9kc1uobmWhdG88z06UHtSSBJCn+Lp6j
   JuoD/CBfDYx400yW3pnK1Fm1T4w1V9CMIvkZnZU1Yqf3cJrC5ia7XrKoW
   w==;
X-CSE-ConnectionGUID: J87ETWj7TquzucIxuwH+Fw==
X-CSE-MsgGUID: JdpkNrejSIW6OSOdgXTqXg==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="65858088"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 03:50:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 14 May 2026 03:50:53 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:50:50 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
Date: Thu, 14 May 2026 16:20:24 +0530
Message-ID: <20260514105028.42942-2-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: 4E88B5409A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287923-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The flag is_sgmii_en indicates whether the PCS interface is enabled.
However, the name implies that the interface is strictly SGMII, which is
misleading.

Rename the variable to is_pcs_en to better reflect that the flag
represents the PCS enable state rather than a specific interface mode.
Update all references and logs accordingly (but keep device registers
unchanged to match its documentation).

No functional change intended.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 .../net/ethernet/microchip/lan743x_ethtool.c   |  4 ++--
 drivers/net/ethernet/microchip/lan743x_main.c  | 18 +++++++++---------
 drivers/net/ethernet/microchip/lan743x_main.h  |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 9195419ecee0..743acfd56554 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1312,7 +1312,7 @@ static int lan743x_get_regs_len(struct net_device *dev)
 	struct lan743x_adapter *adapter = netdev_priv(dev);
 	u32 num_regs = MAX_LAN743X_ETH_COMMON_REGS;
 
-	if (adapter->is_sgmii_en)
+	if (adapter->is_pcs_en)
 		num_regs += MAX_LAN743X_ETH_SGMII_REGS;
 
 	return num_regs * sizeof(u32);
@@ -1333,7 +1333,7 @@ static void lan743x_get_regs(struct net_device *dev,
 	lan743x_common_regs(dev, p);
 	p = (u32 *)p + MAX_LAN743X_ETH_COMMON_REGS;
 
-	if (adapter->is_sgmii_en) {
+	if (adapter->is_pcs_en) {
 		lan743x_sgmii_regs(dev, p);
 		p = (u32 *)p + MAX_LAN743X_ETH_SGMII_REGS;
 	}
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..fad4a246e06e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -59,22 +59,22 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	      hw_cfg & HW_CFG_RST_PROTECT_)) ||
 	    (strap & STRAP_READ_USE_SGMII_EN_)) {
 		if (strap & STRAP_READ_SGMII_EN_)
-			adapter->is_sgmii_en = true;
+			adapter->is_pcs_en = true;
 		else
-			adapter->is_sgmii_en = false;
+			adapter->is_pcs_en = false;
 	} else {
 		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
 		if (fpga_rev) {
 			if (fpga_rev & FPGA_SGMII_OP)
-				adapter->is_sgmii_en = true;
+				adapter->is_pcs_en = true;
 			else
-				adapter->is_sgmii_en = false;
+				adapter->is_pcs_en = false;
 		} else {
-			adapter->is_sgmii_en = false;
+			adapter->is_pcs_en = false;
 		}
 	}
 	netif_dbg(adapter, drv, adapter->netdev,
-		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+		  "PCS I/F %s\n", str_enable_disable(adapter->is_pcs_en));
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -1361,7 +1361,7 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	data = lan743x_csr_read(adapter, MAC_CR);
 	id_rev = adapter->csr.id_rev & ID_REV_ID_MASK_;
 
-	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
+	if (adapter->is_pci11x1x && adapter->is_pcs_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
@@ -3515,7 +3515,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		mutex_init(&adapter->sgmii_rw_lock);
 		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
 		sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-		if (adapter->is_sgmii_en) {
+		if (adapter->is_pcs_en) {
 			sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
 			sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
 		} else {
@@ -3580,7 +3580,7 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 
 	adapter->mdiobus->priv = (void *)adapter;
 	if (adapter->is_pci11x1x) {
-		if (adapter->is_sgmii_en) {
+		if (adapter->is_pcs_en) {
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 160d94a7cee6..f0fa0580b04e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1070,7 +1070,7 @@ struct lan743x_adapter {
 	struct lan743x_tx       tx[PCI11X1X_USED_TX_CHANNELS];
 	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
 	bool			is_pci11x1x;
-	bool			is_sgmii_en;
+	bool			is_pcs_en;
 	/* protect ethernet syslock */
 	spinlock_t		eth_syslock_spinlock;
 	bool			eth_syslock_en;
-- 
2.34.1


