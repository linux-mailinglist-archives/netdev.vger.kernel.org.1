Return-Path: <netdev+bounces-193116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A14AC28E0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BC51C0145B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFB298C16;
	Fri, 23 May 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UyT8x5z9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE229826C;
	Fri, 23 May 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021851; cv=none; b=m9y4+QULbcNoQQDqygHLMm+YuRUIZs6QWw61g/0XDx5HHxTQn4DiONRZyvMrfL6F8ztamJ43neI9ViXSKqb6IZ06sIj7+VYLHv/QbnO506PT7nShdQsXZ7TXbr7j0fMzgSke/yJwyX53KFbFSaV+kfiXvNrlD/0GKja2H6iZi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021851; c=relaxed/simple;
	bh=p+IBqUvjAED01I5pg3BQzrhZMuhdd+dQRTmhsBmJTGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fugfvcy9MbQf1dLdN2Ke2CY6ty+hbQVZBgz61O/jfPAmGd5h4siGtl71EbA2qDCesRvGwup+ObuhKHV4+PbQlRVf+Q8gfBo8fdbS2SMRttuOkJLDa6Kk7iM+iK/QjrJut8Ch6qIR+ytax/ABYO6BsfWlI/TPK+ekg9dRSM1ZhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UyT8x5z9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748021849; x=1779557849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p+IBqUvjAED01I5pg3BQzrhZMuhdd+dQRTmhsBmJTGA=;
  b=UyT8x5z9UuQVWxsmzc4UKWdmwAKZZJnEmV9A7L0+0EfN4PqcWt8AM2Nu
   xduZwu3mNJMa1N2/5VNOpnW4fIqytb+ZZ42yeb76AeFCQ/ldd8Lt1DClL
   km9mjFI+vqY39kEcfJcpvgZ2sWg9Qj3h5qIpurl9I7SomCeWEgErTK4CX
   CYOSU/MK8kn3zCCiCpaXDs6wIbZ7qopS13Rp2HJHqaOpw2A1Us2aAfR8Z
   fuAPhut5G8BEP5EHWeQQ1Enqw/Xa23SooE8Jj16p7fPKkFvtTUKQEjGnz
   pEL+iCToBl4L3vy7cPXTSGK8SsAWEAcWS2xk9ywszyrzfo6HNJ9iwVufE
   Q==;
X-CSE-ConnectionGUID: vtf0FASOTiybk7hIvf2RSg==
X-CSE-MsgGUID: LjzpeQ8+T6K3l0Cs0PemIQ==
X-IronPort-AV: E=Sophos;i="6.15,309,1739862000"; 
   d="scan'208";a="209508488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2025 10:37:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 23 May 2025 10:36:52 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 23 May 2025 10:36:49 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 net-next] net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices
Date: Fri, 23 May 2025 23:03:26 +0530
Message-ID: <20250523173326.18509-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Maximum OTP and EEPROM size for hearthstone PCI1xxxx devices are 8 Kb
and 64 Kb respectively. Adjust max size definitions and return correct
EEPROM length based on device. Also prevent out-of-bound read/write.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 .../net/ethernet/microchip/lan743x_ethtool.c   | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 1459acfb1e61..64a3b953cc17 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -18,6 +18,8 @@
 #define EEPROM_MAC_OFFSET		    (0x01)
 #define MAX_EEPROM_SIZE			    (512)
 #define MAX_OTP_SIZE			    (1024)
+#define MAX_HS_OTP_SIZE			    (8 * 1024)
+#define MAX_HS_EEPROM_SIZE		    (64 * 1024)
 #define OTP_INDICATOR_1			    (0xF3)
 #define OTP_INDICATOR_2			    (0xF7)
 
@@ -272,6 +274,9 @@ static int lan743x_hs_otp_read(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -320,6 +325,9 @@ static int lan743x_hs_otp_write(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -497,6 +505,9 @@ static int lan743x_hs_eeprom_read(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -539,6 +550,9 @@ static int lan743x_hs_eeprom_write(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -604,9 +618,9 @@ static int lan743x_ethtool_get_eeprom_len(struct net_device *netdev)
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	if (adapter->flags & LAN743X_ADAPTER_FLAG_OTP)
-		return MAX_OTP_SIZE;
+		return adapter->is_pci11x1x ? MAX_HS_OTP_SIZE : MAX_OTP_SIZE;
 
-	return MAX_EEPROM_SIZE;
+	return adapter->is_pci11x1x ? MAX_HS_EEPROM_SIZE : MAX_EEPROM_SIZE;
 }
 
 static int lan743x_ethtool_get_eeprom(struct net_device *netdev,
-- 
2.25.1


