Return-Path: <netdev+bounces-206780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA5B04593
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91201A62D3B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C6263F47;
	Mon, 14 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aphfYyu7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914626158B;
	Mon, 14 Jul 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511033; cv=none; b=u496EN99ApeDC21anV1gxPA5LdnB5U5sRK/JqCYGuc/ZSYO3qa59RDPDb4oJ+K+vJpBr3n4ka+rSipkN1l91wHamYY6SPz2KSISZjY2fLpzJ7OCN25kMMXcbDJJjqdhfuKF8U3BXSo8hlluzuoQcaA51Dvol/eO59oPjVS15ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511033; c=relaxed/simple;
	bh=yReikR58Lp8W/7OGiLE+dcPuXMVnnclT1LFvehcRPsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0+OnpzVKPG7agB0Mrlonq9IGfvGgDB7OJpJY2eKOW5eO67EYzYW5jm5CSyg4GUAoMkATLpKUOs62rK3x7jcCsNzf704mn+x1dFXtV/gs/2s/9RPT/Z5lhP/0hjKuOgFPFKOBs8JbnEp06WWmJn6JnvfquILHL/xZBrZa2jU/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aphfYyu7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752511032; x=1784047032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yReikR58Lp8W/7OGiLE+dcPuXMVnnclT1LFvehcRPsU=;
  b=aphfYyu7jfULjTqdixkuYII8sUZCPT6PTMbEsBRan4MCeqW7+V2Loe3H
   6+sSkvAN3CzX1PJf5g0U9QjEAbhGuPkLpVds0OAE9SxpZSLzVli7/9MRc
   FikCOe+PNAditOvS4eM9FU9+CipCIuVSx6eBo8h2yiLearPk2nciyIYKA
   QzC8CQbsZWdQ1G0i62amPOUvtxN6QY9ojYQ3lM8QpEvMoI8hz8y7pOfHw
   1ZIRW/K055Y9MFkKPsV/bUNSeO+AYs8otjm5RX5ZRICXnklZOVUWl1+2U
   VeHnZ+Gssc4ijID0eniWQIaSkCPJ3+brlWz8GdF73Zo1hsLJI+mHuViVt
   w==;
X-CSE-ConnectionGUID: hBq1ljEWSkqL674rDMJkcA==
X-CSE-MsgGUID: iEPb35OVRjOOUiIF1VgRIw==
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="211399323"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 09:37:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Jul 2025 09:36:28 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Jul 2025 09:36:28 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 2/5] net: cadence: macb: Expose REFCLK as a device tree property
Date: Mon, 14 Jul 2025 09:37:00 -0700
Message-ID: <7f9b65896d6b7b48275bc527b72a16347f8ce10a.1752510727.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752510727.git.Ryan.Wanner@microchip.com>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
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
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d1f1ae5ea161..9ebe1062b359 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4109,8 +4109,12 @@ static const struct net_device_ops macb_netdev_ops = {
 static void macb_configure_caps(struct macb *bp,
 				const struct macb_config *dt_conf)
 {
+	struct device_node *np = bp->pdev->dev.of_node;
+	bool refclk_ext;
 	u32 dcfg;
 
+	refclk_ext = of_property_read_bool(np, "cdns,refclk-ext");
+
 	if (dt_conf)
 		bp->caps = dt_conf->caps;
 
@@ -4141,6 +4145,9 @@ static void macb_configure_caps(struct macb *bp,
 		}
 	}
 
+	if (refclk_ext)
+		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
+
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
 
-- 
2.43.0


