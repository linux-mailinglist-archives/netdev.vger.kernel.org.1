Return-Path: <netdev+bounces-137505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD59A6B67
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0061F20F07
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA671FCC7A;
	Mon, 21 Oct 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gb8kvIxg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595E1FBF72;
	Mon, 21 Oct 2024 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519220; cv=none; b=mksd2psacdy4S0QRoUjT+e2/mMn+pmVd1O897o6B2Dv3C4vxXa5qPt/Ty4m0IyBGSVDIvMUC6RuKbeOCsHZGc77l0PYTXJWyFzUEDV5wmmGhTgUzN4jxhbswr4l9ZrFbHCJ8VimozxQTMoAO74a9cyXOCo0CSAahHc4gdF4Kl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519220; c=relaxed/simple;
	bh=aY0YypQAngRekw2GELmtGYkeTWjSw4VkDJVyIfxc2hA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=r/I/7+Oh6vCG/QX1MdMKT8gq9349goTY/cLPrvapI3cMU+n9P0nFDq6pbrAFtbT4wmXdjJWz7GWADB+Q+RdyQ7kNikBAF4tz9WS85QxV05mjq/ogOoIsoagtFZCVYdDmgEGbsUvdX43w93plsJjcSAsnOwPa0ole3Kxft9PSSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gb8kvIxg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519218; x=1761055218;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=aY0YypQAngRekw2GELmtGYkeTWjSw4VkDJVyIfxc2hA=;
  b=gb8kvIxgzLXDVvHAB7c8RiMhfiqqH4gVtP8Qlbox3IvBLhe7y58u3sF9
   R4hR3ruPHKs/DwTbxHnuecUVbmVMqB6ISm9JygohtBX3zgL+LDzxc5MOt
   ZSWCCM5OO8pQPw5qqtQm6nzkV/YWcpklMggVxjpveotmV4QeqIcCjAQL0
   dQtjqLvDOuAABdbzXDr5QgZe9yUp3yEthtk4kJ+tKJO2D9XCWHVaVwKLW
   6TtMyPBncnCJFtJ+iScCnBpHVQqRMO8EGj4h9rJgiJYqWIXFjsmM2o5tU
   Km/d42dbZAlzICmYG+0vgTH5xaHNMsCuUYCNo5N9pqq/erCzki1v0yG/L
   A==;
X-CSE-ConnectionGUID: Ky42XnPuQxK/Okp36Nw4mA==
X-CSE-MsgGUID: bBh1YTz8SNKwmHppzXUp1A==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:58:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:58:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 00/15] net: sparx5: add support for lan969x switch
 device
Date: Mon, 21 Oct 2024 15:58:37 +0200
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1eFmcC/x2NQQqDMBAAvyJ77oLGRk2/Ij3EuNaFdiubYAPi3
 5v2OAzMHBBJmSLcqgOUdo78lgLNpYKwenkQ8lwYTG2uTd10GDev2eLTi+tcxvjhFFaclXdSNNg
 HWqzth9a1A5TIprRw/g9GEEoolBPci5l8JJzUS1h/g5dngfP8AhHsB92RAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

== Description:

This series is the second of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts is split into multiple series (might change a
bit as we go along):

        1) Prepare the Sparx5 driver for lan969x (merged)

    --> 2) add support lan969x (same basic features as Sparx5
           provides excl. FDMA and VCAP).

        3) Add support for lan969x VCAP, FDMA and RGMII

== Lan969x in short:

The lan969x Ethernet switch family [1] provides a rich set of
switching features and port configurations (up to 30 ports) from 10Mbps
to 10Gbps, with support for RGMII, SGMII, QSGMII, USGMII, and USXGMII,
ideal for industrial & process automation infrastructure applications,
transport, grid automation, power substation automation, and ring &
intra-ring topologies. The LAN969x family is hardware and software
compatible and scalable supporting 46Gbps to 102Gbps switch bandwidths.

== Preparing Sparx5 for lan969x:

The main preparation work for lan969x has already been merged [1]. 

After this series is applied, lan969x will have the same functionality
as Sparx5, except for VCAP and FDMA support. QoS features that requires
the VCAP (e.g. PSFP, port mirroring) will obviously not work until VCAP
support is added later.

== Patch breakdown:

Patch #1-#4  do some preparation work for lan969x

Patch #5     adds new registers required by lan969x

Patch #6     adds initial match data for lan969x

Patch #7     defines the lan969x register differences

Patch #8     adds lan969x constants to match data

Patch #9     adds some lan969x ops in bulk

Patch #10    adds PTP function to ops

Patch #11    adds lan969x_calendar.c for calculating the calendar

Patch #12    makes additional use of the is_sparx5() macro to branch out
             in certain places.

Patch #13    documents lan969x in the dt-bindings

Patch #14    introduces new concept of devicetree target

Patch #15    introduces new concept of per-SKU features

[1] https://lore.kernel.org/netdev/20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com/

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: andrew@lunn.ch
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: horatiu.vultur@microchip.com
To: jensemil.schulzostergaard@microchip.com
To: Parthiban.Veerasooran@microchip.com
To: Raju.Lakkaraju@microchip.com
To: UNGLinuxDriver@microchip.com
To: Richard Cochran <richardcochran@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: jacob.e.keller@intel.com
To: ast@fiberby.net
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Steen Hegelund <steen.hegelund@microchip.com>
Cc: devicetree@vger.kernel.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (15):
      net: sparx5: add support for lan969x SKU's and core clock
      net: sparx5: change spx5_wr to spx5_rmw in cal update()
      net: sparx5: change frequency calculation for SDLB's
      net: sparx5: add sparx5 context pointer to a few functions
      net: sparx5: add registers required by lan969x
      net: lan969x: add match data for lan969x
      net: lan969x: add register diffs to match data
      net: lan969x: add constants to match data
      net: lan969x: add lan969x ops to match data
      net: lan969x: add PTP handler function
      net: lan969x: add function for calculating the DSM calendar
      net: sparx5: use is_sparx5() macro throughout
      dt-bindings: net: add compatible strings for lan969x SKU's
      net: sparx5: add compatible strings for lan969x and verify the target
      net: sparx5: add feature support

 .../bindings/net/microchip,sparx5-switch.yaml      |  17 +-
 MAINTAINERS                                        |   7 +
 drivers/net/ethernet/microchip/Kconfig             |   1 +
 drivers/net/ethernet/microchip/Makefile            |   1 +
 drivers/net/ethernet/microchip/lan969x/Kconfig     |   5 +
 drivers/net/ethernet/microchip/lan969x/Makefile    |  13 +
 drivers/net/ethernet/microchip/lan969x/lan969x.c   | 349 +++++++++++++++++++++
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |  56 ++++
 .../ethernet/microchip/lan969x/lan969x_calendar.c  | 190 +++++++++++
 .../net/ethernet/microchip/lan969x/lan969x_regs.c  | 223 +++++++++++++
 drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  72 +++--
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   2 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 272 +++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  76 ++++-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 132 ++++++++
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  |  10 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  26 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  16 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  46 +++
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  13 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   5 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   5 +-
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |  10 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |   5 +
 26 files changed, 1471 insertions(+), 85 deletions(-)
---
base-commit: 30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7
change-id: 20241016-sparx5-lan969x-switch-driver-2-7cef55783938

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


