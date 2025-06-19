Return-Path: <netdev+bounces-199571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976DAE0BB0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B570E3BC1E9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6128CF73;
	Thu, 19 Jun 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VxPrA0Ts"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876C28BAB0;
	Thu, 19 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352681; cv=none; b=fXlw05pGBzClVVs1HAkLRgC4+Qh5ceDSVuEq/hPN6wo7ctB/6A7/dCPQYKA8HsKEqAWH7/ls6Pgjk3wSWcy5qCsjl7OIJWO5R68pyNsudzDEQf5E02lnFoZuepJOAbbf1fbS5tARrpJ0/wE5s8k3weULONowjTGwyaI89KVxWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352681; c=relaxed/simple;
	bh=LBxk1XbCpvlQaaVQ7qLlGRQ+MP2uxh41c3edxa57o58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0iJ8VwKoNq18qJ3yvlITrNIVRA9ov232kV4qUKN8HSvOnq96ayhcPWWKpjI4TVbSk5vL1laaKKrhRD3853G7nHPcQ5OAW3SOkJ+wFknfsWHxi7Ekmkb809KztCwYGeuB+WzXjwALS8FKnQe3NBpgABatCkNDj9dtMNh9bkNBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VxPrA0Ts; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750352680; x=1781888680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBxk1XbCpvlQaaVQ7qLlGRQ+MP2uxh41c3edxa57o58=;
  b=VxPrA0Ts7ZThfQ54tRtFCjj/nyWUvOvoRE5Axf0G8PJhQJtaBzfRG4Pb
   XLVHU9AOUs+DuKsom4aORyLzl+V2mL7dcqLNfhFHGYj9OKOHGdXhesGOd
   hB2VJiXSdkIyRsdIRZOSUk9hikLeaBLDLcgHfxBWfezZOJqVfeTdikdhk
   g38zL96LqFAPhPCeyYTQRG0K/IkDKJ7bppMRORmEKHD9d9dwHQCcigcUW
   4Zf8HeWYL5Aji6oJYrAG8B60K2cWQlYAf6FC86Q5docrTWN2yPTXFuf9U
   10Mdegpm4Ytb873Unrl2S19xl4bJovSPxQVwEL+cuhOW5lu43SCegLPBT
   g==;
X-CSE-ConnectionGUID: pR/nkXtYSem+L1lGhth8FQ==
X-CSE-MsgGUID: x4p3wmC6Rbi9YyjdA3x1iQ==
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="274392752"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 10:04:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Jun 2025 10:04:02 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 19 Jun 2025 10:04:02 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/3] net: cadence: macb: Expose REFCLK as a device tree property
Date: Thu, 19 Jun 2025 10:04:14 -0700
Message-ID: <c5de54b31ed4a206827dfaf359b0bb9042aaca74.1750346271.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750346271.git.Ryan.Wanner@microchip.com>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

The RMII and RGMII can both support internal or external provided
REFCLKs 50MHz and 125MHz respectively. Since this is dependent on
the board that the SoC is on this needs to be set via the device tree.

This property flag is checked in the MACB DT node so the REFCLK cap is
configured the correct way for the RMII or RGMII is configured on the
board.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d1f1ae5ea161..146e532543a1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4109,6 +4109,8 @@ static const struct net_device_ops macb_netdev_ops = {
 static void macb_configure_caps(struct macb *bp,
 				const struct macb_config *dt_conf)
 {
+	struct device_node *np = bp->pdev->dev.of_node;
+	bool refclk_ext = of_property_present(np, "cdns,refclk-ext");
 	u32 dcfg;
 
 	if (dt_conf)
@@ -4141,6 +4143,9 @@ static void macb_configure_caps(struct macb *bp,
 		}
 	}
 
+	if (refclk_ext)
+		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
+
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
 
-- 
2.43.0


