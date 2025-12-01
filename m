Return-Path: <netdev+bounces-242882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFCC95A4A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 04:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B163A198A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B51E008B;
	Mon,  1 Dec 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EbR9201B"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974719C542;
	Mon,  1 Dec 2025 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559460; cv=none; b=bxuWXyCPR2kWxMPyIWYMj5XoyGEBbqKHoiyanfp8IwRDzZLQGO6oZTWucGO2eQBJQPkjPrDYkld/Dvncb/l0swD0cZyjUtiVqhfLMZXpDPq+uGcjxvxxFMT8iO6dMEE8Mc0vsHuQhGbR06DeC809atu6yQ8aiOHk5uTWfpJmoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559460; c=relaxed/simple;
	bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clsICol1y6pLU7MlVAfZRNGrUDcDewDYmM46/EG6jl2c7m1AWd9GN8IE1/ghWILLrIGytX4rGQ7MkBrKjo6BowEFWyO/5Kb16jmB8CLS3HwwiQwgxXPeSgNi4atLsFbgZxZ+NzEdrUy6y+eoOvDNhcAlrB7RRqXtSuJwqGvIAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EbR9201B; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764559458; x=1796095458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
  b=EbR9201BzZTHeLq8fz+5ZeYROertE4DXOzb0fA7RJ/NiEygskJw0wrak
   nx50J8U63MCGhHWH64mCLDDb1qATp5vhSk4BcvftgPaXV1TSrvtUIPIzg
   LaAeU8ZV0/YlAz71yPi6L5cgbYw2CnIHLxfHc5D2UUJkeWsrXVtfmGUJe
   +VbgurofmOrhOUqKyv81INQ100maPIuchbcNXLmZtY7NSJSnsgfMmIPy8
   1Z/4o59RDbF6bygZIiU1xeiSbBBTkilOKjh2ede6wzwfIbEiX1V3kI7pa
   NJS9QWq8Y1duAHWTOhOQlDjJbGG9ofPzWlF/Q1qw5iI5NWTyrATJsBwsN
   A==;
X-CSE-ConnectionGUID: 1XGbcUZ+QfelIecK6MTplQ==
X-CSE-MsgGUID: 3D7Uo0clSd28zOu8RZf/Hw==
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="217188630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 20:24:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 30 Nov 2025 20:24:01 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 30 Nov 2025 20:23:57 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 2/2] net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs
Date: Mon, 1 Dec 2025 08:53:46 +0530
Message-ID: <20251201032346.6699-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
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

This enables ethtool to report the SQI value for LAN867x Rev.D0 PHYs.

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


