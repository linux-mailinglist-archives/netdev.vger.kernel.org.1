Return-Path: <netdev+bounces-234965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A77C2A5BA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 08:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0FF188FF6D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9682BEC55;
	Mon,  3 Nov 2025 07:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFA2BE7BB;
	Mon,  3 Nov 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155582; cv=none; b=i2Ua6ttXXL8ImpJSBY1vzYWWA9GGBTlXxcTfiLuV7gVVzFIIFTbMqn06suDsMbvhTPMIZ/FNmM3TSR938zIAERKwqipbn3w5JxlnIYJ321m6wQxPHFpXbgWgd3sXrsZoR16C/Db8ADfG3b+KzcWwkfgMana1i6KdWqCWdazv0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155582; c=relaxed/simple;
	bh=PqRciZ9pt8w7E8BTpp5PCJ9LMcXBFSAE7sxgLoWY5qw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ev/7XdOdYJj27IU89gJJ8wcin1kfW4bKNZiLATNDSJwbH2bjWAx8mOqjK732bBu3NZJ1fRW2CpnCtQDgErgEIyfhII0pDoUZyp4bL9fVjnga99AyW0sbbprN20FgVvC9ORcvi5CrG/rOCRVImq7FytN4l+gmWdEl2QKxYUBGaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 3 Nov 2025 15:39:15 +0800
Message-ID: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNcCGkC/x3MQQrCMBBG4auEWRuYpLWKV5FS0vQ3DmiUpEik5
 O4NXX6L9zbKSIJMN7VRwk+yfGJDd1Lkny4GaFmaybI9G+6MTuEtMi14uf9kB2btmGe2/dVfMFD
 LvgkPKcfyThGrjigrjbXupxSX7mwAAAA=
X-Change-ID: 20251031-rgmii_delay_2600-a00b0248c7e6
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=2614;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PqRciZ9pt8w7E8BTpp5PCJ9LMcXBFSAE7sxgLoWY5qw=;
 b=ZsJ8ICqzAmlkil/2X2ZC7pjgchQy9vsSXnfRLxbn93VAb2AZ7aFqIKPI55aDCy+mKjYG59Tvr
 xGzWRAravsVAlfBgdPT3x9YoiA7roBDKdmhSD7nvuhS1ZpkX9EDnUso
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This patch series adds support for configuring RGMII internal delays for the
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay
properties for each MAC type. Corresponding changes are made to the device tree
source files and the FTGMAC100 driver to support the new delay configuration.

Summary of changes:
- dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and
  MAC2/3, restrict delay properties, and require SCU phandle.
- ARM: dts: aspeed-g6: Add ethernet aliases to indentify the index of
  MAC.
- ARM: dts: aspeed-ast2600-evb: Add new compatibles, scu handle and
  rx/tx-internal-delay-ps properties and update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

---
v3:
 - Add new item on compatible property for new compatible strings
 - Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
 - Add new compatible and scu handle to MAC node in
   aspeed-ast2600-evb.dts
 - Change all phy-mode of MACs to "rgmii-id"
 - Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
   rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
v2:
 - added new compatible strings for MAC0/1 and MAC2/3
 - updated device tree bindings to restrict phy-mode and delay properties
 - refactored driver code to handle rgmii delay configuration
---

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

---
Jacky Chou (4):
      dt-bindings: net: ftgmac100: Add delay properties for AST2600
      ARM: dts: aspeed-g6: Add ethernet alise
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC
      net: ftgmac100: Add RGMII delay support for AST2600

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  50 ++++++++++
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  28 +++++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   4 +
 drivers/net/ethernet/faraday/ftgmac100.c           | 110 +++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h           |  15 +++
 5 files changed, 203 insertions(+), 4 deletions(-)
---
base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


