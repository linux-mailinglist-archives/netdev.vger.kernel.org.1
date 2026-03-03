Return-Path: <netdev+bounces-263178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lo8AOLSpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913E1EF552
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F42B3016B1B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF1311975;
	Tue,  3 Mar 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Hbmryubh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC0337BA0;
	Tue,  3 Mar 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540629; cv=none; b=TjSl+6+dgJNa9tgoklxi7d3fggHAaDaEJpXcjfd1PimNipGBf7cRw7kvg3RN73KX2L1EDKYZysWRb+khsUsOQFAaMym7lBST32gwcFmWPSH758yHA0pVMkgXkl8l9IMDCKX3LBJxGVMMo93gKeyfFi2Q72m34XYfvU0ZwQ8GeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540629; c=relaxed/simple;
	bh=g3fKDlurWC1PfL7BGX0dpJf2FNsgSqsCMdJ5IN8RwKc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XuXyRWNm/1k0JzQD/EQlEaUs4867PEA8AWKdxVu136bdk5vOhxdYIpIT3NoJv5jhnCVAmVdwtFVEzrcYqAGnuiTCi4IivzaW2DVARmjc2M4cApPkgjj1OQfCEE81zZzjarCpd3e4RiThGtaF1g+xqe6L2Q79H0Djp1fxwfC9/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hbmryubh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772540627; x=1804076627;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=g3fKDlurWC1PfL7BGX0dpJf2FNsgSqsCMdJ5IN8RwKc=;
  b=HbmryubhJW/rdfk4vg+ed2gnZ1DnWKkfE0W8XHzBoC1ARetHXeuP+42j
   CMbGD2DmEQ3DRdLu//I5Cr00iiQSHVcXZgI22Ys9OTzVEIKOMrcIAkEOl
   g6Gf9oIkpreE/ZsoGJjqxdn2uy+a5XY3AE2XcLNAo7YQLP4gq3riBh+p3
   HtxOjtGwqv8Ec67DeaLxWHOCZEsn87AK3hc9jv/m0C0+wYb3ywXiGQJRV
   cRUbL8CuitshQf5kn6xXcQKyu6c0th1DnN/nTcrxhO4LnCYwjOoQai54p
   E7QlG/VsxFW+KilZkj0C30/ft7VyCuQMSRvAqTceY2B8SCAU0s6lXhxmR
   g==;
X-CSE-ConnectionGUID: O5MLb/nJR+Ce7h6ad0rSrA==
X-CSE-MsgGUID: a4jxtFRLR5O47naYPXqVkQ==
X-IronPort-AV: E=Sophos;i="6.21,321,1763449200"; 
   d="scan'208";a="285516796"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 05:23:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 05:23:19 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 05:23:16 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next 0/8] net: dsa: add DSA support for the LAN9645x
 switch chip family
Date: Tue, 3 Mar 2026 13:22:26 +0100
Message-ID: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAILSpmkC/x3NTQrCMBBA4auUWRtIUq3oVaSE/EztgIwyE2qg9
 O4Gl9/mvR0UhVDhPuwguJHSmzvcaYC8Rn6iodIN3vrJemdN0RhekW/T+dKCfqnmNRShDSWkqGh
 G51Na8njFkqBXPoILtf/hAYzVMLYK83H8AKyZSs57AAAA
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Queue-Id: 5913E1EF552
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263178-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series provides the Microchip LAN9645X Switch driver.

The LAN9645x is a family of chips with ethernet switch functionality and
multiple peripheral functions. The switch delivers up to 9 ethernet
ports and 12 Gbps switching bandwidth.

The switch chip has 5 integrated copper PHYs, support for 2x RGMII
interfaces, 2x SGMII and one QSGMII interface.

The switch chip is from the same design architecture family as ocelot
and lan966x, and the driver reflects this similarity. However, LAN9645x
does not have an internal CPU in any package, and must be driven
externally. For register IO it supports interfaces such as SPI, I2C and
MDIO.

The chip supports a variety of network features such as

* Mactable for MDB/FDB functionality
* Bridge forwarding offload
* VLAN-aware bridging
* IGMP/MLD snooping
* Link aggregation
* PTP timestamping
* FRER (802.1CB)
* Media Redundancy Protocol
* Parallel Redundancy and High-Availability Seamless Redundancy
  (HSR/PRP) in DANH/DANP mode
* Per stream filtering and policing
* Shapers such as Credit Based Shaping and Time Aware Shaing
* Frame preemption
* A TCAM (VCAP) for line-rate frame processing

The LAN9645x family consists of the following SKUs:

LAN96455F
LAN96457F
LAN96459F
LAN96455S
LAN96457S
LAN96459S

The difference between the SKUs is the number of supported ports (5, 7
or 9) and features supported. The F subfamily supports HSR/PRP and TSN,
while the S subfamily does not.

The intended way to bind this driver is using a parent MFD driver,
responsible for the register IO protocol, and distributing regmaps to
child devices. The goal is to use the same approach as the MFD driver in
drivers/mfd/ocelot-spi.c.

This driver expects to request named regmaps from a parent device. This
approach is similar to the DSA driver

drivers/net/dsa/ocelot/ocelot_ext.c

which supports being driven by an external CPU via SPI with parent
device drivers/mfd/ocelot-spi.c.

The MFD driver will come in a later series, because there are
requirements on the number of child devices before a driver qualifies as
a MFD device.

Development is done using the LAN966x as a host CPU, running the lan966x
swichdev driver, using the EVB-LAN9668 EDS2 board.

The datasheet is available here:
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN9645xF-Data-Sheet-DS00006065.pdf

This series will deliver the following features:

* Standalone ports
* Bridge forwarding and FDB offloading
* VLAN-aware bridge
* Stats integration

More support will be added at a later stage. Here is a tentative plan of
future patches for this DSA driver:

* Add LAG support.
* Add MDB support.
* Add TC matchall mirror support.
* Add TC matchall police support.
* Add DCB/qos support.
* Add simple TC support: mqprio, cbs, tbf, ebf.
* Add TC flower filter support.
* Add HSR/PRP offloading support.
* Add PTP support.
* Add TC taprio support.

For completeness I include tentative plan of planned patches for
LAN9645x peripherals:

* Extend pinctrl-ocelot for LAN9645x:
  https://lore.kernel.org/linux-gpio/20260119-pinctrl_ocelot_extend_support_for_lan9645x-v1-0-1228155ed0ee@microchip.com/
* Add driver for internal PHY:
  https://lore.kernel.org/netdev/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com/
* MFD driver for managing register IO protocol and child device
  initialization.
* Extend pinctrl-microchip-sgpio for LAN9645x support.
* Extend i2c_designware for LAN9645x support.
* Add driver for outbound interrupt controller.
* Add serdes driver for lan9645x.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Jens Emil Schulz Østergaard (8):
      net: dsa: add tag driver for LAN9645X
      dt-bindings: net: lan9645x: add LAN9645X switch bindings
      net: dsa: lan9645x: add autogenerated register macros
      net: dsa: lan9645x: add basic dsa driver for LAN9645X
      net: dsa: lan9645x: add bridge support
      net: dsa: lan9645x: add vlan support
      net: dsa: lan9645x: add mac table integration
      net: dsa: lan9645x: add port statistics

 .../net/dsa/microchip,lan9645x-switch.yaml         |  137 ++
 MAINTAINERS                                        |   10 +
 drivers/net/dsa/microchip/Makefile                 |    1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |   12 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   10 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  413 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  884 ++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  478 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |   99 ++
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  |  537 ++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |  294 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_regs.h | 1851 ++++++++++++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.c    |  825 +++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.h    |  288 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c |  339 ++++
 drivers/net/ethernet/microchip/Kconfig             |    1 +
 include/linux/dsa/lan9645x.h                       |  290 +++
 include/net/dsa.h                                  |    2 +
 net/dsa/Kconfig                                    |   10 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag_lan9645x.c                             |  143 ++
 21 files changed, 6625 insertions(+)
---
base-commit: 01857fc712f6469cab9cc578120cdc80f1c2a634
change-id: 20260210-dsa_lan9645x_switch_driver_base-312bbfc37edb

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


