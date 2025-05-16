Return-Path: <netdev+bounces-190928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA84BAB9518
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB7F3B82F3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4720E716;
	Fri, 16 May 2025 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HBSlRIT8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8C2AD0C;
	Fri, 16 May 2025 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368133; cv=none; b=kLN/ekbdmatyJT7dNM1BcqN/RzaXGX3DnU977paxu5iFI4GinOV5cGcmXZKWNxFtwBDZ16RE/QKp2xENxM/sbFsj3yHHEO7K3ighU1b+0yj4tjC35+FSACGMSr8GlaJHPd3KFhOhh0+mngKh15WXcqsRuTT1DctxQV6x9koP8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368133; c=relaxed/simple;
	bh=FEq1Zz6rvKC3+g5rUEw0L5h3Sk5Q4+GdZ6LwyjcNeD0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQaRuNM/RGor/AxIT2D0lwRNkc3ecPlfrCVVfkxgmSgfpa7V6oZKaWFKzayN/R9BUNu1t3DoOZKT7tHeExM/2FV5qlMdvrPp7UX/2ihxmmgsvou+Xnl0eDTohcyqgHl9yRtUwfZKgWSFPS5OmiUx8wqRgTo4G7UMfQi0kd8P6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HBSlRIT8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747368132; x=1778904132;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FEq1Zz6rvKC3+g5rUEw0L5h3Sk5Q4+GdZ6LwyjcNeD0=;
  b=HBSlRIT8n1QJdNnuLrOWupFPbaqYg/pSq3C9aiSmeaCd4FRL139SQ2oS
   /PaOXmlrpKm+ayFUcnQSCDEkJHk9Kv19sAY+JXGcP3fZJrVeLUGdrTOr0
   QoENc8T4hpjZk1GatHpvy/PTeAImk6U7XxUQhABlcEF9TSWXO/S8FCaLy
   3tX9l0CKoNVe4ZiWrh3Fzq80ytsGj4Idc5EtqA7nj0qKvnwZJmJZXDLS5
   FDQBZYmUUm3OY5mJoRdsR4ozCNrdeWc7nH07Kkdrte8AKUyPaVFrPzXTK
   EMY8wdqXzvgisKLyWUFT3jHp8D9cOdNxeKJC420mZS2l16RLpuvFSseAP
   w==;
X-CSE-ConnectionGUID: +J73kJbCQ6Clq1C8JITz0A==
X-CSE-MsgGUID: IR2eFHcEQIK2dad2fDJ6zw==
X-IronPort-AV: E=Sophos;i="6.15,293,1739862000"; 
   d="scan'208";a="273028766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2025 21:02:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 15 May 2025 21:01:49 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 15 May 2025 21:01:46 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on resume
Date: Fri, 16 May 2025 09:27:19 +0530
Message-ID: <20250516035719.117960-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SGMII_CTRL register, which specifies the active interface, was not 
properly restored when resuming from suspend. This led to incorrect
interface selection after resume particularly in scenarios involving
the FPGA.

To fix this:
- Move the SGMII_CTRL setup out of the probe function.
- Initialize the register in the hardware initialization helper function,
which is called during both device initialization and resume.

This ensures the interface configuration is consistently restored after
suspend/resume cycles.

Fixes: a46d9d37c4f4f ("net: lan743x: Add support for SGMII interface")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 880681085df2..7e71579632f3 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3495,6 +3495,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 				 struct pci_dev *pdev)
 {
 	struct lan743x_tx *tx;
+	u32 sgmii_ctl;
 	int index;
 	int ret;
 
@@ -3507,6 +3508,15 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
 		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
+		sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+		if (adapter->is_sgmii_en) {
+			sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
+			sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
+		} else {
+			sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
+			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
+		}
+		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
@@ -3558,7 +3568,6 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
-	u32 sgmii_ctl;
 	int ret;
 
 	adapter->mdiobus = devm_mdiobus_alloc(&adapter->pdev->dev);
@@ -3570,10 +3579,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	adapter->mdiobus->priv = (void *)adapter;
 	if (adapter->is_pci11x1x) {
 		if (adapter->is_sgmii_en) {
-			sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-			sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
-			sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
-			lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
@@ -3584,10 +3589,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus-c45\n");
 		} else {
-			sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-			sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
-			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
-			lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "RGMII operation\n");
 			// Only C22 support when RGMII I/F
-- 
2.25.1


