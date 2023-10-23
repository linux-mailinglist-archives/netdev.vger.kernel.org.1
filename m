Return-Path: <netdev+bounces-43506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F627D3B35
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDFDB20CE7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364C1C297;
	Mon, 23 Oct 2023 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AOcbmYXp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BA291E;
	Mon, 23 Oct 2023 15:47:23 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FFF10A;
	Mon, 23 Oct 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076042; x=1729612042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=azRF8Tr1FjS1mhmfgNj7KBFmuZpo8uSGPa9Rwz8beHA=;
  b=AOcbmYXpP3I3AeurpyTMMH9NIWqUTqv1/JnVYwMlZHWZ0PIjOcB5VkJz
   VUI8X1QMg6+gErmM8bxi9SU+Z1rMV6p0yBKhoTFIeri2gxGJYhWFcHiKW
   J1W1Y7S4HKgjtX7soYkG23s9/CO7WEpwcFSXL/WP/mwNYhSepkfjfCxnp
   pE5jh3oRVRn0GTVGI5tmCOtjjjJgQ9X89O50kFiQFhXW6NOYJOJt79yfw
   euUqyezUwQ89rXsi4U44OIZcG8l4dDMkSaNa8s+LAhTkwkkPDblU29IHh
   arMPZpE7myqngTRsXeTaAWxMKBhDEXmKS6O1jagfpMOdLJVLwvg21QrWh
   g==;
X-CSE-ConnectionGUID: NJm2u3DySce+5c8BG0159g==
X-CSE-MsgGUID: KpmGRKNCTo+hPa8sxGPz0A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="10702766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:47:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:47:08 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:46:56 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
	<steen.hegelund@microchip.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
	<casper.casan@gmail.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface
Date: Mon, 23 Oct 2023 21:16:40 +0530
Message-ID: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series contain the below updates,
- Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
  net/ethernet/oa_tc6.c.
- Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
  Ethernet driver in the net/ethernet/microchip/lan865x.c.

Changes:
v2:
- Removed RFC tag.
- OA TC6 framework configured in the Kconfig and Makefile to compile as a
  module.
- Kerneldoc headers added for all the API methods exposed to MAC driver.
- Odd parity calculation logic updated from the below link,
  https://elixir.bootlin.com/linux/latest/source/lib/bch.c#L348
- Control buffer memory allocation moved to the initial function.
- struct oa_tc6 implemented as an obaque structure.
- Removed kthread for handling mac-phy interrupt instead threaded irq is
  used.
- Removed interrupt implementation for soft reset handling instead of
  that polling has been implemented.
- Registers name in the defines changed according to the specification
  document.
- Registers defines are arranged in the order of offset and followed by
  register fields.
- oa_tc6_write_register() implemented for writing a single register and
  oa_tc6_write_registers() implemented for writing multiple registers.
- oa_tc6_read_register() implemented for reading a single register and
  oa_tc6_read_registers() implemented for reading multiple registers.
- Removed DRV_VERSION macro as git hash provided by ethtool.
- Moved MDIO bus registration and PHY initialization to the OA TC6 lib.
- Replaced lan865x_set/get_link_ksettings() functions with
  phy_ethtool_ksettings_set/get() functions.
- MAC-PHY's standard capability register values checked against the
  user configured values.
- Removed unnecessary parameters validity check in various places.
- Removed MAC address configuration in the lan865x_net_open() function as
  it is done in the lan865x_probe() function already.
- Moved standard registers and proprietary vendor registers to the
  respective files.
- Added proper subject prefixes for the DT bindings.
- Moved OA specific properties to a separate DT bindings and corrected the
  types & mistakes in the DT bindings.
- Inherited OA specific DT bindings to the LAN865x specific DT bindings.
- Removed sparse warnings in all the places.
- Used net_err_ratelimited() for printing the error messages.
- oa_tc6_process_rx_chunks() function and the content of oa_tc6_handler()
  function are split into small functions.
- Used proper macros provided by network layer for calculating the
  MAX_ETH_LEN.
- Return value of netif_rx() function handled properly.
- Removed unnecessary NULL initialization of skb in the
  oa_tc6_rx_eth_ready() function removed.
- Local variables declaration ordered in reverse xmas tree notation.

Parthiban Veerasooran (9):
  net: ethernet: implement OPEN Alliance control transaction interface
  net: ethernet: oa_tc6: implement mac-phy software reset
  net: ethernet: oa_tc6: implement OA TC6 configuration function
  dt-bindings: net: add OPEN Alliance 10BASE-T1x MAC-PHY Serial
    Interface
  net: ethernet: oa_tc6: implement internal PHY initialization
  dt-bindings: net: oa-tc6: add PHY register access capability
  net: ethernet: oa_tc6: implement data transaction interface
  microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
  dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY

 .../bindings/net/microchip,lan865x.yaml       |  101 ++
 .../devicetree/bindings/net/oa-tc6.yaml       |   86 ++
 Documentation/networking/oa-tc6-framework.rst |  233 ++++
 MAINTAINERS                                   |   16 +
 drivers/net/ethernet/Kconfig                  |   12 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/microchip/Kconfig        |   11 +
 drivers/net/ethernet/microchip/Makefile       |    2 +
 drivers/net/ethernet/microchip/lan865x.c      |  415 ++++++
 drivers/net/ethernet/oa_tc6.c                 | 1117 +++++++++++++++++
 include/linux/oa_tc6.h                        |  109 ++
 11 files changed, 2103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/oa-tc6.yaml
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/microchip/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h

-- 
2.34.1


