Return-Path: <netdev+bounces-238324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79121C57462
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B6024E4ABA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06034DB54;
	Thu, 13 Nov 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tmtGWLb9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038634D4D4;
	Thu, 13 Nov 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034755; cv=none; b=XhLYpJpN7ssQGRITcS9kMtaJpZzQB+ADEaZKdfa0PnWIj+ox3oL0c1q8YDmNfUnwej5JZRl12pKHDLuKnaG0oAGXDAAWZ9uSYd86DziSlXV4zp7w9MiNuAAfrocg/LQcYaztztJrF0cWPPpkDuIUWlwX8pkXhbDTBjzMNE2oGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034755; c=relaxed/simple;
	bh=GZF8lgeDQC7Hi6xFhfCRpYi6s7kn1kyAv2TSa5O3FrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuuV0x6KZDXuDR1KxgITsA3SvDrGfqMbwwba/CEoYL4sqWz+BCFTn01T6HFlAXdg37Prw1f3TKTrwkoSOnePOf+526HSSIRpmxviQbJ77zzEY3i5Pd3h7Y9jIH76t6/yn5WrWLuTtv4INUJ0+q68sdv7CBzwYVtt8lrfnHpfWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tmtGWLb9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763034753; x=1794570753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZF8lgeDQC7Hi6xFhfCRpYi6s7kn1kyAv2TSa5O3FrA=;
  b=tmtGWLb964mKwy6i0BFyDdOGsadJnEt9CWnbvHNWKw5O0mZTJkRcrYHE
   TkEA45msS685sLB0OTOp+OZsG1a3zGivfhMcEY9sVUrzcswuSsIXuVCas
   DPiZNL0S4Htm/1JGan5mogytQSieIO7TzwN+zbw95+5K5YljLIfQX4c/T
   NJ0qdePjvF6WVSBRKRu0VK961v8CY3lHpOs8EqaV0BPLH7v9hGaD6Wx8F
   mIP5YniSVPlmr5NNhpEgoww9cH9rzv3o6f6Zc70SOZri6NgNvowkAdGm4
   eQjswl/ToLdeA20ZH9EgtQjklwIDOMy1d2MEq3zbs6pwAVlemFx92n8rB
   Q==;
X-CSE-ConnectionGUID: 3YIJu1weQma93cjyGpczEw==
X-CSE-MsgGUID: WJ5Ct3BCSkiGrTsFsPRkSA==
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="55526998"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 04:52:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 13 Nov 2025 04:52:25 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 13 Nov 2025 04:52:20 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 2/2] net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs
Date: Thu, 13 Nov 2025 17:22:06 +0530
Message-ID: <20251113115206.140339-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Signal Quality Index (SQI) reporting in the
Microchip T1S PHY driver for LAN867x Rev.D0 (OATC14-compliant) PHYs.

This patch registers the following callbacks in the microchip_t1s driver
structure:

- .get_sqi      - returns the current SQI value
- .get_sqi_max  - returns the maximum SQI value

This allows network drivers and diagnostic tools to query link
signal quality, improving monitoring and troubleshooting
capabilities. Existing PHY functionality remains unchanged.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 5a0a66778977..e601d56b2507 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -575,6 +575,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_status    = genphy_c45_plca_get_status,
 		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
 		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
+		.get_sqi            = genphy_c45_oatc14_get_sqi,
+		.get_sqi_max        = genphy_c45_oatc14_get_sqi_max,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


