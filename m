Return-Path: <netdev+bounces-285633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC12JmRz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:23:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED514F1E8E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9CB3037160
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076C33B6F9;
	Fri,  8 May 2026 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DwhQWZKv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB232FA14;
	Fri,  8 May 2026 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217743; cv=none; b=XhKR+8hZYRBMfOVX0cnrpJdUGTU5mzrdGZ+1zv73HePjbp7LWIP/A1zjeg6VW9hUS9QqYeZFWQvicwypnu4xsD3zKNS5cgC18Kbro6NPWFQlczX4gQETeDf+Rs9qlGE4FYYuK3uZ5ER3b4RWuHifHwCTUrRE8Nbws7/Elu51zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217743; c=relaxed/simple;
	bh=/WadYXeNsvZ0sj7kfWtCdyJIzDwGWspdCLPutduhIbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inKVIiq5yn8FmuNk+pijXj6Z4JEN/srO/KjRC7rLeigbedpKVyaR/kedjepQVnLaXQG99Hi/6Gs8KI+RAvQuCZ6ECMxGnqusY/U97j+9OlQsjjPpclYlvYDuJmXlG8GdcDKpz0u/GkgHKzEJ83CTUQdkPTFz8F0QzfM3XMym4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DwhQWZKv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217742; x=1809753742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WadYXeNsvZ0sj7kfWtCdyJIzDwGWspdCLPutduhIbI=;
  b=DwhQWZKv83/FNwmr3d0D/X5gwdzLMMe28uXtlQTmd7B6B9nAeY2AvC5w
   0znOhB5AcFLdXmM/cr7Q3Wa3Vrhm7FkwyZEo769HwPPLBCitx7ptenMvO
   sycOlA53v9gy1AHgYtzObWKfM77EHPy76AExk4X4y7oPv+YGsqDVKDEZz
   nM8oDdTLZ65SI7YW2/SaxQtI/9Tt23gWsaGfXqMlMpiy59oAQgW3gIa9o
   YA6zqTgUP14JHJKan21gJEi8hogw5ytsCr8CkZzXa4Jy4+pCPwcfeUp8n
   h77LsCie0snomyobUNsHDHVNNvmGkzBRtgPN3MdZfu0z9QxnUSMJxwjYA
   A==;
X-CSE-ConnectionGUID: gjLlGO3yT0u1Gc7mL7ViJQ==
X-CSE-MsgGUID: l0g/kl3wSESbZ1mZaDgmlw==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="57611587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 22:22:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 22:22:21 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:17 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
Date: Fri, 8 May 2026 10:51:46 +0530
Message-ID: <20260508052150.11852-2-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: 1ED514F1E8E
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
	TAGGED_FROM(0.00)[bounces-285633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:mid,microchip.com:dkim]
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


