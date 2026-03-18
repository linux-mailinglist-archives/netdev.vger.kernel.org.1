Return-Path: <netdev+bounces-268886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBS2GF1IumkFTwIAu9opvQ
	(envelope-from <netdev+bounces-268886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:38:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B258D2B67ED
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F943024150
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022134F462;
	Wed, 18 Mar 2026 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1DYLI6mY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A9322B88;
	Wed, 18 Mar 2026 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815617; cv=none; b=LAyZcbKfYnpj9oLC7unynpUF5eNt3aFq7O+1ve+EqTidXR7xculkWY4xhP7tcU2lUjdi004dlCrgueusD6PhIXpUgvg1apOuQ7bv/XxmjRB5ISoZ3Z7yaos0lrkG+EE0FpR0QmCJBEcUPsSBfvB3lsXDgwVe4ykMvDfhiNYPMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815617; c=relaxed/simple;
	bh=kBBHbXZQpWXBbi+D4f9F2PePfXUe6gQNo+1xckPTAcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXHOcZ739IlvyZOtJm9+foQ3KzIlx9bKyIjLH+scJMQPfrOCN8rP2AGd5tRcXEJc6jxtMt+FyxtOYYecD8UJpZZQWCx3Y6GmkX764KaPotQj7IWdzgr6WndiYNaRXtNA3TCKOB/Ni0okReMicxgjR6EPxfSqQf1Mpe/SNvvBU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1DYLI6mY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773815616; x=1805351616;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kBBHbXZQpWXBbi+D4f9F2PePfXUe6gQNo+1xckPTAcc=;
  b=1DYLI6mY5zmyqKwoFKqZdR7aGW3Rscwssb/xQJ7LVdHEiq25NlISDDBt
   rkWTGHczsSV+ruYxk3Wi1dge/pXhGFqvr17ACbK9Yi3YD81avx0RdzWeS
   r3/+BVpNFx7apPQdFccFtECa2sFbGASAu3q5O+YjxMlDsG8SpmXN5EqX5
   8sgIXm5LnWAoCOvgJuWyz/l7AIlNlde9CUgnlZLgTuLk6y+CKRJF7ZjGw
   mAW5Ct0EqpFAqepB+lwESbXyW/E8A3Uvp1OtDjs+lY/R6gDjXH2HpRCYV
   LhmbMkcg+4mGkbuOOqUtGNbXQhnYG/KZcqwaw1I+734fhzv7MRQ7WihQb
   g==;
X-CSE-ConnectionGUID: DWBeoPGXSvWEP4D/TigK3g==
X-CSE-MsgGUID: eQ69UpvYTTStPeCzhNrr1g==
X-IronPort-AV: E=Sophos;i="6.23,127,1770620400"; 
   d="scan'208";a="286209789"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:33:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 23:32:54 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 17 Mar 2026 23:32:51 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net-next] net: lan743x: fix SGMII detection on PCI1xxxx B0+ during warm reset
Date: Wed, 18 Mar 2026 12:02:28 +0530
Message-ID: <20260318063228.17110-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-268886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B258D2B67ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A warm reset on boards using an EEPROM-only strap configuration (where
no MAC address is set in the image) can cause the driver to incorrectly
revert to RGMII mode. This occurs because the ENET_CONFIG_LOAD_STARTED
bit may not persist or behave as expected.

Update pci11x1x_strap_get_status() to use revision-specific validation:

- For PCI11x1x A0: Continue using the legacy check (config load started
  or reset protection) to validate the SGMII strap.
- For PCI11x1x B0 and later: Use the newly available
  STRAP_READ_USE_SGMII_EN_ bit in the upper strap register to validate
  the lower SGMII_EN bit.

This ensures the SGMII interface is correctly identified even after a
warm reboot.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v0 -> v1
	* Added helpers to check if the device revision is a0
---
 drivers/net/ethernet/microchip/lan743x_main.c | 15 +++++++++++----
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a3845edf0e48..83b640ab9d62 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -28,6 +28,12 @@
 
 #define RFE_RD_FIFO_TH_3_DWORDS	0x3
 
+static bool pci11x1x_is_a0(struct lan743x_adapter *adapter)
+{
+	u32 dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
+	return dev_rev == ID_REV_CHIP_REV_PCI11X1X_A0_;
+}
+
 static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
 	u32 chip_rev;
@@ -47,10 +53,11 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
 	lan743x_hs_syslock_release(adapter);
 	hw_cfg = lan743x_csr_read(adapter, HW_CFG);
-
-	if (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
-	    hw_cfg & HW_CFG_RST_PROTECT_) {
-		strap = lan743x_csr_read(adapter, STRAP_READ);
+	strap = lan743x_csr_read(adapter, STRAP_READ);
+	if ((pci11x1x_is_a0(adapter) &&
+	     (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
+	     hw_cfg & HW_CFG_RST_PROTECT_)) ||
+	     (strap & STRAP_READ_USE_SGMII_EN_)) {
 		if (strap & STRAP_READ_SGMII_EN_)
 			adapter->is_sgmii_en = true;
 		else
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 02a28b709163..160d94a7cee6 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -27,6 +27,7 @@
 #define ID_REV_CHIP_REV_MASK_		(0x0000FFFF)
 #define ID_REV_CHIP_REV_A0_		(0x00000000)
 #define ID_REV_CHIP_REV_B0_		(0x00000010)
+#define ID_REV_CHIP_REV_PCI11X1X_A0_	(0x000000A0)
 #define ID_REV_CHIP_REV_PCI11X1X_B0_	(0x000000B0)
 
 #define FPGA_REV			(0x04)
-- 
2.34.1


