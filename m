Return-Path: <netdev+bounces-192947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D52AC1C9B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EAF504324
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F52288D2;
	Fri, 23 May 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zKxq5kFf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251412248B9;
	Fri, 23 May 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979302; cv=none; b=riCaHKjyB7npyIGLYqF72jyAQUskxyLInyaJqb2s+FEP9iXLyd/JdUR7ohPQcRxxstzPQcv/TjSk0VpxJ78xIJhp3CJ/0B2k+ec2qxjuF+L0uvsVtn8C9GcHuZ+DJvVd1v7o//CY+N0ky84Utguss4NMABMUe/dIRh9guPcTL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979302; c=relaxed/simple;
	bh=NkZac1jXB759OXdvhCBjyMMV0SCNkMUUj2/mxuU91qg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr0e2Vu0s6HOXdJBSEFY4SblJCvFiuTF8etNoMKAWJwU4DoQVHiS9ATO4DSlK9iIoU68zGLwf5OQf9mX8Hlb+7HR3wTJOC7gsU8Ku+3rJIBGMmCGvkwvU5W/a7JKr627587tOTEoXUEW1NO/088zFiSbfZVSAKkc3Wv05yYnL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zKxq5kFf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747979300; x=1779515300;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NkZac1jXB759OXdvhCBjyMMV0SCNkMUUj2/mxuU91qg=;
  b=zKxq5kFfm4kiS9NvNjjq1MdPcBAvU6AigNbatWZAR0ygWaiKAece3Ak8
   IX8fk6ivJJf+Bji3X+Dh8rGPqg07gB4mX0QXWsloPe3YrPuE5acfhUZQi
   HbnpGbGWjNCO9kuAhAZbrjvVjhJE/atT+WZkxwBiDbU0m+Dv+eIErMgQm
   y5AUyP6RYYw74q6QD6FAVkx6qw0s2EPFWRt3lvSu4CM3w8vqcGFOCtVnS
   yOa6ciD3FuORafcRQAzk76qB3jg+C6KXa72z7RIx1Qy5crC1nBYXivlja
   1u1l956HvoLo0d9ZpqTCfDgC17krcgkieDYykhTnKgCICsLQwXSwAYck1
   w==;
X-CSE-ConnectionGUID: LGngJwnIRy2YdRhcTVLYQw==
X-CSE-MsgGUID: Ry7+DmchTVWMn7saj3PUxQ==
X-IronPort-AV: E=Sophos;i="6.15,308,1739862000"; 
   d="scan'208";a="209485740"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 22:48:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 22:47:53 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 22:47:50 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net 2/2] net: lan743x: Fix PHY reset handling during initialization and WOL
Date: Fri, 23 May 2025 11:13:25 +0530
Message-ID: <20250523054325.88863-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523054325.88863-1-thangaraj.s@microchip.com>
References: <20250523054325.88863-1-thangaraj.s@microchip.com>
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


