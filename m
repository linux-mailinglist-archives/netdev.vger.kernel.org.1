Return-Path: <netdev+bounces-178637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EBA7803A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AF33B3158
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027520D503;
	Tue,  1 Apr 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jhRQUPTO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E820D4F8;
	Tue,  1 Apr 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524009; cv=none; b=QFvj57Ci/BGNLcYzwqKYG+EJTsKDNwY2QHAjIDbHZAU5mCwwE6h8DCc/9Q0pioMgYqITh1lJUAKX2kwlNx83g4hWhcCrftt5GxbpfE4rG0GMXrQYcQIM18QhY2RQMlLA29+ch/jMAXZZlOorOU0NRAkf/+5jTz0umWzozkXl4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524009; c=relaxed/simple;
	bh=oSwJs4scoL8ULhTOhuRgce9k9EhyWpP90w5Fz+liDCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K6CFnKe/J7ki/HgQLd++Gv+KMI7PBwMP8cu8OAWVxZ9G3XQ8k86f5Iy+VInXfDLuGzIy/7eIquZ2xEFZ2wAoEr7xUnU6D97j2K60DeUKly7Tc5RnK0ttfJO7entDj8HptgYv3aZtdbs5QFBwqdTVSHMUwMuqV4dkuqws2YHjYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jhRQUPTO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524007; x=1775060007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oSwJs4scoL8ULhTOhuRgce9k9EhyWpP90w5Fz+liDCo=;
  b=jhRQUPTOpmJIrU5FW5z3G4Mk/6MUJXlUxUZn+ItYqMfqi5geR/WI1aRh
   lzSfEUo55TOjy1fVle7+TwJ/lqeS1W5p5qXALSqNaXELXeQd8nk082BvM
   MHhJ5ggFQT9c4YZHmECq3+UIOAZ0FX5O90MGLznSkXgb7uLT6w1ogWpFS
   km4PXL27oufKrt+YIUtf6zEDOunDAcHwjw/PeBCZkk3Pn9UDhRysg/hLO
   HcIc2Vbe3G0rEixpXX1BIeQ/oETLmTiIqZvelCqdMWYvPcWxa5yDUruOP
   sc1leSVPbsoUYXDb2A6z+iytJRs00DSq8ZrHaJ+sLTCnzrDIx1WsypZqH
   A==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: rWQOGm/mQu2gEKSfpww8yQ==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 0/6] Enable FLEXCOMs and GMAC for SAMA7D65 SoC
Date: Tue, 1 Apr 2025 09:13:16 -0700
Message-ID: <cover.1743523114.git.Ryan.Wanner@microchip.com>
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

This patch set adds all the supported FLEXCOMs for the SAMA7D65 SoC.
This also adds the GMAC interfaces and enables GMAC0 interface for the SAMA7D65 SoC.

With the FLEXCOMs added to the SoC the MCP16502 and the MAC address
EEPROM are both added to flexcom10.

The dt-binding for USART is here [1]. And the dt-binding for DMA has
been applied here [2].

1) https://lore.kernel.org/linux-arm-kernel/20250306160318.vhPzJLjl19Vq9am9RRbuv5ddmQ6GCEND-YNvPKKtAtU@z/
2) https://lore.kernel.org/linux-arm-kernel/174065806827.367410.5368210992879330466.b4-ty@kernel.org/

Ryan Wanner (6):
  dt-bindings: net: cdns,macb: add sama7d65 ethernet interface
  ARM: dts: microchip: sama7d65: Add gmac interfaces for sama7d65 SoC
  ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC
  ARM: dts: microchip: sama7d65: Enable GMAC interface
  ARM: dts: microchip: sama7d65: Add MCP16502 to sama7d65 curiosity
  ARM: dts: microchip: sama7d65_curiosity: add EEPROM

 .../devicetree/bindings/net/cdns,macb.yaml    |   1 +
 .../dts/microchip/at91-sama7d65_curiosity.dts | 207 ++++++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 299 ++++++++++++++++++
 3 files changed, 507 insertions(+)

-- 
2.43.0


