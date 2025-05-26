Return-Path: <netdev+bounces-193345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE3AC394C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ABC3AF99A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327321CAA62;
	Mon, 26 May 2025 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hurJAwJ6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5F1B3930;
	Mon, 26 May 2025 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237739; cv=none; b=ZTOZy2a7jqil2wABVbw7QXqhgwCOTXJiqO9uIhSFnojtTyu2X8OdT6vAuMhJxe1Efh0qNLGQQ67uArzH69uGyRTLX+91l7oqqd2P48QJ0KD89cfwq+QkxwijUlYVKbvsxgPFT04IOzhXLN5gXyvy2VuTanC3zUncmxLpQi9BlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237739; c=relaxed/simple;
	bh=0pNqoPv8fPVLNxtu59Wp0wSlLX9MZ0Zb+OUFxvPIcKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm2ziAXLbksqzM7L4US6MljM2npAhI71Ix6nYOxcTrhvjKW/1czv0+TjGmIOHpaZewGJt+em3yGYveXNalB3XEgHZ2LHoP8nWJl+QSOCIznE6cvTnfq5EaXQrgx+8xXJhLhXkVsFXce5XnGzVvYVCXbQt30DbqAoXp0Qohg58Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hurJAwJ6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748237737; x=1779773737;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0pNqoPv8fPVLNxtu59Wp0wSlLX9MZ0Zb+OUFxvPIcKA=;
  b=hurJAwJ6QlLm26FjYERejJD66WPdI4bEvhbJsK1+STvweniEohn0cwBm
   UETjdRpTTolbl81xoRvHMG2VgYIjxbN9f2X3ruvrZ0cgbweTJep3bIWid
   vLx7nx/OYXTtW40lox9dWcu1NJPT0kM7eomQg1vCo958GDpmizRUHIK2b
   6tiBfNp+H/VAqf3tyD/a02U8+GXytqaHWgE6IAON4RuFekPjWu6I+2AZb
   of2OOw0iebeS4Z8ZVYFfNNQYyhLH6BUki8g9cQG6QCmSCs+5a4UMypzbh
   FyrGWXvGsQC5pO2uiR0UTAoXN2N2/cf3exYmbZkr5zizq0JNBxLRb0iH1
   w==;
X-CSE-ConnectionGUID: ZIY/Wzj3Q22sZWvgvBPVZg==
X-CSE-MsgGUID: pU6mxBHsTDO5iMasIG/dxg==
X-IronPort-AV: E=Sophos;i="6.15,315,1739862000"; 
   d="scan'208";a="41602085"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2025 22:35:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 25 May 2025 22:35:08 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 25 May 2025 22:35:05 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 2/2] net: lan743x: Fix PHY reset handling during initialization and WOL
Date: Mon, 26 May 2025 11:00:48 +0530
Message-ID: <20250526053048.287095-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526053048.287095-1-thangaraj.s@microchip.com>
References: <20250526053048.287095-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove lan743x_phy_init from lan743x_hardware_init as it resets the PHY
registers, causing WOL to fail on subsequent attempts. Add a call to
lan743x_hw_reset_phy in the probe function to ensure the PHY is reset
during device initialization.

Fixes: 23f0703c125be ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index efa569b670cb..9d70b51ca91d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1346,11 +1346,6 @@ static int lan743x_hw_reset_phy(struct lan743x_adapter *adapter)
 				  50000, 1000000);
 }
 
-static int lan743x_phy_init(struct lan743x_adapter *adapter)
-{
-	return lan743x_hw_reset_phy(adapter);
-}
-
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 {
 	u32 id_rev;
@@ -3534,10 +3529,6 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
-
 	ret = lan743x_ptp_init(adapter);
 	if (ret)
 		return ret;
@@ -3674,6 +3665,10 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_pci;
 
+	ret = lan743x_hw_reset_phy(adapter);
+	if (ret)
+		goto cleanup_pci;
+
 	ret = lan743x_hardware_init(adapter, pdev);
 	if (ret)
 		goto cleanup_pci;
-- 
2.25.1


