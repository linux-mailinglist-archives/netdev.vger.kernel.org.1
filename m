Return-Path: <netdev+bounces-98825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914E8D290D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2BCB25260
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549414387A;
	Tue, 28 May 2024 23:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE02.vmware.com (ex-prd-edge02.vmware.com [208.91.3.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D3143868;
	Tue, 28 May 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940492; cv=none; b=B5cOHRNP5yMzcGIYAJ0ZbCUzf3aSl/YrURSzU2o0Bw/UL39ZY75YlVQHlGDTF9o46JbGpGaOYABUPFesATfFvZ5gDngLnekGSwfNnjRHPuy7PEHJX+p7HZId++AtPeN/UZdHL3Be0/xmGVlTVUsMlkW8UadScbLnBSGKFuN82N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940492; c=relaxed/simple;
	bh=2+fysG0Du4d/s61FaL2qUIhRstpR34hy/uZrTBVGS8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFPWmj4U6+kmL29oEIAdE4fZ7Ojz5ev7Grz1cmqiuYFynIVGTKSbDyqI3TtfQ5v+dIgnlSie88RO1w0SO66yJH3049TQocfbmvRJzDHZWcREYEdhHaZiMKNyrtMFLVCxfHS38Yt1D3tqzTD08eDunsJPGR+pC40DIAgv4psYpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX-PRD-EDGE02.vmware.com (10.188.245.7) with Microsoft SMTP Server id
 15.1.2375.34; Tue, 28 May 2024 16:39:02 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost1.vmware.com (Postfix) with ESMTP id 70A90201E4;
	Tue, 28 May 2024 16:39:21 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id 6EAEBB04C9; Tue, 28 May 2024 16:39:21 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net-next 4/4] vmxnet3: update to version 9
Date: Tue, 28 May 2024 16:39:06 -0700
Message-ID: <20240528233907.2674-5-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240528233907.2674-1-ronak.doshi@broadcom.com>
References: <20240528233907.2674-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE02.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.71 as permitted
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
index 0fe55234f2bf..49e920bc0061 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3955,7 +3955,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
 	u8 mac[ETH_ALEN];
-	int size;
+	int size, i;
 	int num_tx_queues;
 	int num_rx_queues;
 	int queues;
@@ -4022,42 +4022,14 @@ vmxnet3_probe_device(struct pci_dev *pdev,
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


