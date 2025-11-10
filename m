Return-Path: <netdev+bounces-237147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76140C4625D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2790F3A8DE4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A04302CC9;
	Mon, 10 Nov 2025 11:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CC301472;
	Mon, 10 Nov 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773008; cv=none; b=LJvxV6XgX1z+24v+DgbMxGBh1LybhFON4QjapN0bCnJuralIZpqmoLJYULVid51Lyjb6ntydtZiTUhJXmAqTUoVWaQeBCfyKNxGm9p2sJHG6ZtLCwmbZ53a+hYixEIIu778hvnhOn7DUfu0hG1lCN6duS2s9dvzW3rLMRbv+J0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773008; c=relaxed/simple;
	bh=mSZ7gmoan1EeU4GVjsq0MXdF6q2IRPBWHzVnBREFK+s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kKlmaNf3bNT4/QLDPD0twuo7dvaYvPtQDCP5d+wD4cc7PSvQkyUdhoq2KlB3Ov3+yNEInNSTgP64V0/YMdNZ0kySwqjhSAbdncbWiPA3P09MQPuDitFVRLMyDCiGObWhUqDj+yFJWztgrWAlCCvhH3fVJKtdiaLfCb8lxflnQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 10 Nov 2025 19:09:24 +0800
Message-ID: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTHEWkC/32Q0WrDMAxFf6X4eQ6y1NjpnvYfowTXURpvbdLZb
 mgo+fcaF7aHjT2Jy+UcId1F5OA5itfNXQSeffTTmMP2ZSPcYMcjS9/lLBCwVkBKhuPZ+7bjk11
 a1ADSAhwAt40zrEXGLoF7fyvKdzFykiPfktjnZvAxTWEpu2YqfdFm72/tTBIko+1R17o3nXmz8
 cLcJXZD5aZzMc74bYFGEWgiUBVR09RKKvlh3efSumG6/gmrH5iUyWOHWKka9Y7M//T6vDPw1zV
 /LD2P3a/rA4EO8HpPAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=3865;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=mSZ7gmoan1EeU4GVjsq0MXdF6q2IRPBWHzVnBREFK+s=;
 b=JVJatIp03PtH1be/zgyXFjCLbEZ6UugDbJ2mlEjc9L64B6RVVc4X2jTenUy6r0JzK1NSYWVcJ
 IOdDKo1zV8jDzZ5RwMbbHMmwydpv/KiWg9M0TEjzQ70L0Y1AMMjfoWl
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
  MAC2/3.
- ARM: dts: aspeed-g6: Add aspeed,rgmii-delay-ps and aspeed,scu
  properties.
- ARM: dts: aspeed-ast2600-evb: Add rx/tx-internal-delay-ps properties and 
  update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Po-Yu Chuang <ratbert@faraday-tech.com>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: taoren@meta.com

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v4:
- Remove the compatible "aspeed,ast2600-mac01" and
  "aspeed,ast2600-mac23"
- Add new property to specify the RGMII delay step for each MACs
- Add default value of rx/tx-internal-delay-ps
- For legacy dts, a warning message reminds users to update phy-mode
- If lack rx/tx-internal-delay-ps, driver will use default value to
  configure the RGMII delay
- Link to v3: https://lore.kernel.org/r/20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com

Changes in v3:
- Add new item on compatible property for new compatible strings
- Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
- Add new compatible and scu handle to MAC node in
  aspeed-ast2600-evb.dts
- Change all phy-mode of MACs to "rgmii-id"
- Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
  rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
- Link to v2: https://lore.kernel.org/r/20250813063301.338851-1-jacky_chou@aspeedtech.com

Changes in v2:
- added new compatible strings for MAC0/1 and MAC2/3
- updated device tree bindings to restrict phy-mode and delay properties
- refactored driver code to handle rgmii delay configuration
- Link to v1: https://lore.kernel.org/r/20250317025922.1526937-1-jacky_chou@aspeedtech.com

---
Jacky Chou (4):
      dt-bindings: net: ftgmac100: Add delay properties for AST2600
      ARM: dts: aspeed-g6: Add scu and rgmii delay value per step for MAC
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC
      net: ftgmac100: Add RGMII delay support for AST2600

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  35 +++++
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  20 ++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   8 ++
 drivers/net/ethernet/faraday/ftgmac100.c           | 148 +++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h           |  20 +++
 5 files changed, 227 insertions(+), 4 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


