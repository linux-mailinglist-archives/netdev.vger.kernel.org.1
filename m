Return-Path: <netdev+bounces-99833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E98D69C4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890EC1F2888D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986E17FAC7;
	Fri, 31 May 2024 19:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE01.vmware.com (EX-PRD-EDGE01.vmware.com [208.91.3.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD417D35A;
	Fri, 31 May 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183870; cv=none; b=GfVa4XVVrD81PfK+Z/X1/rCfNJLIyXFs4m+Vx6czcNWpiKaJvBcvCeYmBCq6aEPrmNq6XTAMloNbhSigGmVzh/cHkFNOl1tzzCDeiLCwtRTp1OZG5InR7BXYzq8FazID/UboAp/HW3iN22kTjsWbLUf7dHMZE40Rydv1VzSsrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183870; c=relaxed/simple;
	bh=z3TA2Pyh5iL5iHoyqIePu3tYmCwqk19EjybdfTrNXDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myAT24F/R6LFFfNufVVrvuBGM6aAqGOKFIx50efwdm7NUugQMW6gJA/Joe9woZBQzi6+d9D4jc2vii5BNvFN5Ky8dfoRus6bY1ojMhvpxF33xPHJg0K/hD+QrSn+IjkzASr0E/IM86OqIQFmsw6R+RB6+22OYYYD7ISO4S0QVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX-PRD-EDGE01.vmware.com (10.188.245.6) with Microsoft SMTP Server id
 15.1.2375.34; Fri, 31 May 2024 12:30:35 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost3.vmware.com (Postfix) with ESMTP id DA3E320175;
	Fri, 31 May 2024 12:30:56 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id D6AB2B04D3; Fri, 31 May 2024 12:30:56 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] vmxnet3: update to version 9
Date: Fri, 31 May 2024 12:30:49 -0700
Message-ID: <20240531193050.4132-5-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240531193050.4132-1-ronak.doshi@broadcom.com>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE01.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.73 as permitted
 sender)

With all vmxnet3 version 9 changes incorporated in the vmxnet3 driver,
the driver can configure emulation to run at vmxnet3 version 9, provided
the emulation advertises support for version 9.

Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 46 ++++++++-------------------------------
 drivers/net/vmxnet3/vmxnet3_int.h |  4 ++--
 2 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index e26d223a659f..b16449671b8b 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3951,7 +3951,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
 	u8 mac[ETH_ALEN];
-	int size;
+	int size, i;
 	int num_tx_queues;
 	int num_rx_queues;
 	int queues;
@@ -4018,42 +4018,14 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		goto err_alloc_pci;
 
 	ver = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_VRRS);
-	if (ver & (1 << VMXNET3_REV_7)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_7);
-		adapter->version = VMXNET3_REV_7 + 1;
-	} else if (ver & (1 << VMXNET3_REV_6)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_6);
-		adapter->version = VMXNET3_REV_6 + 1;
-	} else if (ver & (1 << VMXNET3_REV_5)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_5);
-		adapter->version = VMXNET3_REV_5 + 1;
-	} else if (ver & (1 << VMXNET3_REV_4)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_4);
-		adapter->version = VMXNET3_REV_4 + 1;
-	} else if (ver & (1 << VMXNET3_REV_3)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_3);
-		adapter->version = VMXNET3_REV_3 + 1;
-	} else if (ver & (1 << VMXNET3_REV_2)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_2);
-		adapter->version = VMXNET3_REV_2 + 1;
-	} else if (ver & (1 << VMXNET3_REV_1)) {
-		VMXNET3_WRITE_BAR1_REG(adapter,
-				       VMXNET3_REG_VRRS,
-				       1 << VMXNET3_REV_1);
-		adapter->version = VMXNET3_REV_1 + 1;
-	} else {
+	for (i = VMXNET3_REV_9; i >= VMXNET3_REV_1; i--) {
+		if (ver & (1 << i)) {
+			VMXNET3_WRITE_BAR1_REG(adapter, VMXNET3_REG_VRRS, 1 << i);
+			adapter->version = i + 1;
+			break;
+		}
+	}
+	if (i < VMXNET3_REV_1) {
 		dev_err(&pdev->dev,
 			"Incompatible h/w version (0x%x) for adapter\n", ver);
 		err = -EBUSY;
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 31e8db568db2..9f24d66dbb27 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -72,12 +72,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.7.0.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.9.0.0-k"
 
 /* Each byte of this 32-bit integer encodes a version number in
  * VMXNET3_DRIVER_VERSION_STRING.
  */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01070000
+#define VMXNET3_DRIVER_VERSION_NUM      0x01090000
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.11.0


