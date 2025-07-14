Return-Path: <netdev+bounces-206778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987ACB0458F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20524A0902
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C8261584;
	Mon, 14 Jul 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zZzX7kso"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46C1F4CB3;
	Mon, 14 Jul 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511031; cv=none; b=X91WdL+qN3hGq+05+GbMDbRumMe4hvFuqPp+87Qx77y7bnQyDCa7oepvz8eTPqihTrCm6OMilSfqGo3LKU8DeJMatUSnKVUTe9HMGzb5wKAUIcAfqTeS4egOdWUPYjTSjp8ejScks2+v1Xd4Smfr77+ZKO368h+L9sUrFxy8s+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511031; c=relaxed/simple;
	bh=tMrOtJ+kfSdVA0qrXoov8X2JtXzZ9F1mreWoWfrUzIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrwkaHjOYq0biVxflIym6opjmOQ+zBMyLtkkTpTEbIa6xMjdT7qOBRFA6Zl3NpkBn9zPqxUEKdTRhNu9zx2VKM1Tjb0kop8XsU22MXIJHf8nDg/qhYyzs9uz9yQiZTenboN0HpAFNsD2zr209MLv5Z6aOJmcTz5eRk6wHjiJ4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zZzX7kso; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752511030; x=1784047030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tMrOtJ+kfSdVA0qrXoov8X2JtXzZ9F1mreWoWfrUzIA=;
  b=zZzX7kso/xD7+fcBPkvGhcz9onTkmnn+MDC0/4KHhG3eEYiaWZ4V7VjP
   Gf8aAVrcQOrZ08MucMVu/XCD7rHNCG8/p2RzLZish5PGG8OCGgvIN1BkM
   P8kEU5TYCG9wQdMA3nbsaAHgOiCmnQiHBYfiP6JajwMj2yUHOoHbVUvAY
   s7W5BIX1+l7Fw25jbD2M4yxQqv/g0Uu9/IovpwUxVHqszAT7hGk+QIYA6
   1hvH3J15nFj/S1UyaBGyioOERy07t0GRKZa+yMG42T5AxgRYNtjj0my8h
   9HtR3SI+HljyaYzHFBrNmDNdtVC99EYm9GrTHKQ2EUSWFCOX4m2iUqwzq
   g==;
X-CSE-ConnectionGUID: hBq1ljEWSkqL674rDMJkcA==
X-CSE-MsgGUID: per8wVp3TQ2Qiv2PcIAY/A==
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="211399318"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 09:37:08 -0700
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
Subject: [PATCH v2 0/5] Expose REFCLK for RMII and enable RMII
Date: Mon, 14 Jul 2025 09:36:58 -0700
Message-ID: <cover.1752510727.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This set allows the REFCLK property to be exposed as a dt-property to
properly reflect the correct RMII layout. RMII can take an external or
internal provided REFCLK, since this is not SoC dependent but board
dependent this must be exposed as a DT property for the macb driver.

This set also enables RMII mode for the SAMA7 SoCs gigabit mac.

V1 is here [1]

changes v1 -> v2:
- Add device tree changes to use the new REFCLK property.
- Remove USARIO_HAS_CLKEN from the sama7g54 emac node to use the exposed
  REFCLK propterty.
- Use property_read_bool() instead of property_present check.
- Adjust variables to follow reverse xmas tree

1) https://lore.kernel.org/all/cover.1750346271.git.Ryan.Wanner@microchip.com/

Ryan Wanner (5):
  dt-bindings: net: cdns,macb: Add external REFCLK property
  net: cadence: macb: Expose REFCLK as a device tree property
  net: cadence: macb: Enable RMII for SAMA7 gem
  net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag
  ARM: dts: microchip: sama7g5: Add RMII ext refclk flag

 Documentation/devicetree/bindings/net/cdns,macb.yaml |  7 +++++++
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts       |  1 +
 drivers/net/ethernet/cadence/macb_main.c             | 11 +++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.43.0


