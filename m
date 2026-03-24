Return-Path: <netdev+bounces-270986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOeFLBVuwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:57:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27380306DCE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD243317A322
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F13E3C74;
	Tue, 24 Mar 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EZpbpWIf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABE3DF00F;
	Tue, 24 Mar 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349429; cv=none; b=oOn4mMKYISvUxxi7JSCVPWs9Ug5/R4pw7P0jSyPYKwfLsq+Ye4j3Cfhx3g6JkFXGq37Z0Wg61/Ob+uNdU3uZUuUN8jcORxx5LSO3f4ab/R2Mu9BjGueZDVYEJn9wMFNRn6AGvuwRcHkraw+OI5uITExmquAHE5ChY3OyDAtaxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349429; c=relaxed/simple;
	bh=1WtNlVI+w1qUcrumaIdXKE0MuxzfP955dqwu3O0p62U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hU8likpb8/8YT7Vb6c01jATkC/qGHHXEIvpHY9BE4TwT24XSrM3OVHW5h29W9FQx+NKe24G6+87qItfOx67ioeKKaZ38gn+OfxWRcYaKfNJBWpR5y+zPHvNxhS3FH3hKQSwpviRh9xHcM5b/9yinQNOUUiOta/kdCCdiiJonLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EZpbpWIf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774349427; x=1805885427;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=1WtNlVI+w1qUcrumaIdXKE0MuxzfP955dqwu3O0p62U=;
  b=EZpbpWIfBTVQosbxNs9xM7YmmL3E2Ocs/1xsdEHt+aWqKIugvs1zEFTP
   /qg5+efmU+f/vtILZdtxk3ZKD7Urm7IS5a1Vz4uAmSg1SgE/zpazIXDWi
   n8jn7MSo4tL+RdVkc0mUVNNoQ7Jbe+1qZHNk9i8qGn1Gg6UTSO3PhCi46
   muxifsj8467+saG2UAvmwd+T6+M1C0KGqm3kEigFW9t8jU6wclG3/SQgz
   7YOvCcF47Nl/rHuKlt7ei/x6cFEWBXydfMuNRQeVO3lphf5BsfIXmKtF9
   uQmOpbHitB6Yi6U4Eze3U+i1VZNV1CqcLz/l0qdd/Vty9JfiOdJW5kTIm
   w==;
X-CSE-ConnectionGUID: Vq74BuQ4T0ugMhVa5vdexg==
X-CSE-MsgGUID: HL1WO7gfTi2ZQ4Vl54iovw==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="222375794"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2026 03:50:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 24 Mar 2026 03:49:58 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Mar 2026 03:49:55 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next v2 0/9] net: dsa: add DSA support for the LAN9645x
 switch chip family
Date: Tue, 24 Mar 2026 11:46:43 +0100
Message-ID: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJRrwmkC/4XNSwqDMBSF4a3IHTclj2prR91HEcnjpl6oiSRiL
 eLeG9xAh4cfzrdBxkSY4V5tkHChTDGUIU8V2EGHFzJyZYPksuFScOay7t86tM2lXvv8odkOvUu
 0YOqNzsiUkMZ4q67oDJSXKaGn9RCeEHBmAdcZulIGynNM34NexNEPRXH1V1kE48x4f7NaqLbx9
 WMkm6IdaDrbOEK37/sPxsDBJNwAAAA=
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270986-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_mcast.sh:url,no_forwarding.sh:url,bridge_mld.sh:url,bridge_vlan_aware.sh:url,microchip.com:dkim,microchip.com:mid,microchip.com:email,microchip.com:url,test_fdb_stress_test.sh:url,bridge_vlan_unaware.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27380306DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v2:
- Individual patches have specific v2 changes.
- Ran DSA, and std counters, selftests, which prompted several changes.
  The following selftests pass, except for some expected failures:
    - bridge_vlan_aware.sh
    - bridge_vlan_unaware.sh
    - bridge_vlan_mcast.sh
    - no_forwarding.sh
    - bridge_mdb.sh
    - bridge_mld.sh
    - test_fdb_stress_test.sh
    - .../drivers/net/hw/ethtool_rmon.sh
    - .../drivers/net/hw/ethtool_std_stats.sh (from Ioana's series)
- Added new patch for MDB management, as this was required for selftests.
- Added port_set_host_flood to enable unknown traffic to standalone during
  promisc/ALL_MULTI (selftests).
- Remove the dubugfs.
- Link to v1: https://lore.kernel.org/r/20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com

---
Jens Emil Schulz Østergaard (9):
      net: dsa: add tag driver for LAN9645X
      dt-bindings: net: lan9645x: add LAN9645X switch bindings
      net: dsa: lan9645x: add autogenerated register macros
      net: dsa: lan9645x: add basic dsa driver for LAN9645X
      net: dsa: lan9645x: add bridge support
      net: dsa: lan9645x: add vlan support
      net: dsa: lan9645x: add mac table integration
      net: dsa: lan9645x: add mdb management
      net: dsa: lan9645x: add port statistics

 .../net/dsa/microchip,lan96455s-switch.yaml        |  119 ++
 MAINTAINERS                                        |   10 +
 drivers/net/dsa/Kconfig                            |    2 +
 drivers/net/dsa/microchip/Makefile                 |    1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |   11 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   12 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  420 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  982 ++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  450 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  |  391 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |   99 +
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  |  381 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |  190 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_regs.h | 1915 ++++++++++++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.c    |  922 ++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.h    |  277 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c |  353 ++++
 include/linux/dsa/lan9645x.h                       |  145 ++
 include/net/dsa.h                                  |    2 +
 net/dsa/Kconfig                                    |   11 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag_lan9645x.c                             |  291 +++
 22 files changed, 6985 insertions(+)
---
base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
change-id: 20260210-dsa_lan9645x_switch_driver_base-312bbfc37edb

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


