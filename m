Return-Path: <netdev+bounces-243770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40759CA707A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9E53222C47
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903BE327203;
	Fri,  5 Dec 2025 09:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A53101B5;
	Fri,  5 Dec 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928409; cv=none; b=JVPgHstbHDWxF/NoPYBYapIkLZ0jMw4knFmvnW8taDVozT1M6yLU2KorP7caINgKFyWlPvRq8bmqC+dOlI8tqr/CAE6B7SThB6uP+jVdM75qfRrHU1Sd6pzvpmXOJU2svmd687Ye1RhmQ+nwVA+Y+HXL7HtI3ZInk/+dKU5HotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928409; c=relaxed/simple;
	bh=mfxL0uUIjxrFMdPcCRvbeueWw7KboedpnEge2ljo6CI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NifNhhIHrqR2ZFynzEJz5/Lo3Krxxt4t9irUHzvFBeZtIK2Y2GlJwaX89tEIlGIZZCu6s6i1D5XdObmpatTCjptOJv5u+NY6zc6uzbxA4Aze/2J04b+hu7QqxnuI0KadoDnpr7n8Dv9VIR0sSVRTQ+Fg7H14zmAcdZerMal0OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 17:53:15 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 17:53:15 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v5 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Fri, 5 Dec 2025 17:53:14 +0800
Message-ID: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqrMmkC/4XQ0WrDIBQG4FcpXs9wPEZNd7X3GCU4PWnc2qRTG
 xpK3n0uhW3Qwq7kcPg/Of+VJYqBEnveXFmkKaQwDmVQTxvmejvsiQdfZoaASoAUPO6PIbSeDnZ
 uUQNwC/AGWDfOkGYldorUhctKvrKBMh/oktmubPqQ8hjn9a9JrPtvtqimPFvESijUW2m44O/Wf
 cyt68fzi00nIp/J9ZUbj6s04W+6ERK0lCAqKZtGif/D8icsykn3F02SAye0HWqlO+PNQ6X+owh
 4oNRFUc56ic7o4twpy62tSJ/n0nu+VbZbli9NrY04lQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928395; l=3209;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=mfxL0uUIjxrFMdPcCRvbeueWw7KboedpnEge2ljo6CI=;
 b=C8V5JhC5awYAnXB6CpeQ932sjXs9JodBsINryrvjKvjIehpMpOKDxD4gfTha0lCZHrKQYNj8a
 Nq/LqtHJIdmA+X8fkLupp5tBUCVARFNtyzVzKdmRXBVCi6Y736bzQhH
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This patch series adds support for configuring RGMII internal delays for the
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay
properties for each MAC type. Corresponding changes are made to the device tree
source files and the FTGMAC100 driver to support the new delay configuration.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v5:
- Remove the new property, "aspeed,rgmii-delay-ps" from yaml and driver
- Add aspeed,scu to aspeed-g6 dtsi back
- Determine delay value from bootloader and tx/rx-internal-delay-ps to
  configure RGMII delay value with phy-mode
- Add a helper for AST2600 to get phy driver handle
- Link to v4: https://lore.kernel.org/r/20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com

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
      ARM: dts: aspeed-g6: add aspeed,scu property for MAC
      net: ftgmac100: Add RGMII delay support for AST2600
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  27 ++
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  20 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   4 +
 drivers/net/ethernet/faraday/ftgmac100.c           | 288 ++++++++++++++++++++-
 drivers/net/ethernet/faraday/ftgmac100.h           |  25 ++
 5 files changed, 358 insertions(+), 6 deletions(-)
---
base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


