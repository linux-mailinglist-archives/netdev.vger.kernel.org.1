Return-Path: <netdev+bounces-233027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B3C0B765
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD83B1102
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408E301492;
	Sun, 26 Oct 2025 23:44:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C91D5AC6;
	Sun, 26 Oct 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522250; cv=none; b=iGOj0mLIv5M3Vzv9xBV04uOpHNFyK4z3HQh07qnxdDkluiAUyCJrZzg7Xc+8EQW1IxZvqQCgoNpzzL3UgGojz293tzRAbKNSibM3GI+HTjlNOF3/nLAXT0XYXQwS6gYKCwm2QJ0kYrz4fL63l4vCWQWao91mbUDLihQK7mfm100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522250; c=relaxed/simple;
	bh=YAVKUAQGj55Zdu+hOF82E/UlMYcum7FtLqIIghmzNJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=an7K3KRbpRnroQe83vl2VgA2M2T9E1YPN7tGdVbvU/dpDqrIV6QuIrhqg23WQeUowfR8Cv+B4d7YvmuDjAcTbQIKyhWAtvPTs99f9/fPQLMQbkQA+r0uuevwgbECViDFi0GCyYg/RPhg3dhZBR1gBjSyGsOiDkY5604gfVcf9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDAOs-000000007bx-0BDL;
	Sun, 26 Oct 2025 23:43:50 +0000
Date: Sun, 26 Oct 2025 23:43:46 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v3 00/12] net: dsa: lantiq_gswip: Add support for
 MaxLinear GSW1xx switch family
Message-ID: <cover.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series extends the existing lantiq_gswip DSA driver to support
the MaxLinear GSW1xx family of dedicated Ethernet switch ICs. These switches
are based on the same IP as the Lantiq/Intel GSWIP found in VR9 and xRX
MIPS router SoCs, but are connected via MDIO instead of memory-mapped I/O.

The series includes several improvements and refactoring to prepare for the
new hardware support.

The GSW1xx family includes several variants:
 - GSW120: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X
 - GSW125: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
 - GSW140: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X
 - GSW141: 6 ports, 4 PHYs, RGMII & SGMII
 - GSW145: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X, industrial temperature

Key features implemented:
 - MDIO-based register access using regmap
 - Support for SGMII/1000Base-X/2500Base-X SerDes interfaces
 - Configurable RGMII delays via device tree properties
 - Configurable RMII clock direction
 - Energy Efficient Ethernet (EEE) support
 - enabling/disabling learning

Daniel Golle (12):
  net: dsa: lantiq_gswip: split into common and MMIO parts
  net: dsa: lantiq_gswip: support enable/disable learning
  net: dsa: lantiq_gswip: support Energy Efficient Ethernet
  net: dsa: lantiq_gswip: set link parameters also for CPU port
  net: dsa: lantiq_gswip: define and use
    GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
  dt-bindings: net: dsa: lantiq,gswip: add support for MII delay
    properties
  net: dsa: lantiq_gswip: allow adjusting MII delays
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear RMII refclk output
    property
  net: dsa: lantiq_gswip: add vendor property to setup MII refclk output
  dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx
    switches
  net: dsa: add tagging driver for MaxLinear GSW1xx switch family
  net: dsa: add driver for MaxLinear GSW1xx switch family

 .../bindings/net/dsa/lantiq,gswip.yaml        |  307 ++-
 MAINTAINERS                                   |    3 +-
 drivers/net/dsa/lantiq/Kconfig                |   18 +-
 drivers/net/dsa/lantiq/Makefile               |    2 +
 drivers/net/dsa/lantiq/lantiq_gswip.c         | 1617 +--------------
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   20 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  | 1748 +++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           |  736 +++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  126 ++
 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h       |  154 ++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    8 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_mxl-gsw1xx.c                      |  141 ++
 14 files changed, 3215 insertions(+), 1668 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/lantiq_gswip_common.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.h
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

-- 
2.51.1

