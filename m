Return-Path: <netdev+bounces-289030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIpBFh0HC2oI/gQAu9opvQ
	(envelope-from <netdev+bounces-289030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:33:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1778356CBC7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 915F9304740E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798D40584D;
	Mon, 18 May 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gzGWmbui"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C52FF161;
	Mon, 18 May 2026 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107200; cv=none; b=tM4We/NT3YhJtrc/L+BHVzmgAJUTozcBrLuk8taBO0deT4jjHKggLl5Olyx3HB5CHHiU7sh9GIcBbzdedKKQdIjPWJu2LYohZcxPInlTGeP1nOqs+94bDjmyxZLzFiAjP0j7A3tLkq3dvFHraWdJOw8uwyGro+hXYkgDt+lNojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107200; c=relaxed/simple;
	bh=E8J0I3l/uE5hL0OpClqWP/gdv8T9yRbSeuGEZ0R7unc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Q40ni+WTcZm/8AK9ua5OMOJMRSv2pRQMhWA05zzQS00YW5fsaJjhfSiMfy5MnmPUIPXxjqO5DFKVeaFH8nmLvL9f/c5fbUcZ3vTJ/cHsl2WCkFcjHLU+APUDBn7x7750/erw3xoMG27fH+gFcmAR8rFj88F/kx8PvvXK8c6jmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gzGWmbui; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779107199; x=1810643199;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=E8J0I3l/uE5hL0OpClqWP/gdv8T9yRbSeuGEZ0R7unc=;
  b=gzGWmbuiFnG3H/oXkSOBPqaOf+yfoFJcbp6hJSAl/QdmeWj3d5WYxnft
   344foWxgVlMeXik4UexY0DfYEQkJfCzEAGF3A8ZSNzIRxL3rjNUYxBhRc
   p3Byr3UzZdWre8Nns63j7nNpPq6JK23a6r8g6z3QrCAZ/3KC8OqgJPsuQ
   y5d1Ap8vnh4yYClgVO6Xi4vqD05AWVPpb6xXr36u5BePGUFzO4OZmRYny
   vd7o2KctjieN2nKBpZHGyu33wZqcqY2nzoK7R20SnsR2AxyU0Ez91SBPI
   TNDLDVFsH+YAHuHUwlzAxzseXpTQ1eXW5bxtJdXqyB8mvtiRx2wcbYLqH
   w==;
X-CSE-ConnectionGUID: /RDnjdCIS8iL8cR+YlxTsQ==
X-CSE-MsgGUID: ufcyYYcXTveKm8+VXHs9aA==
X-IronPort-AV: E=Sophos;i="6.23,241,1770620400"; 
   d="scan'208";a="57661694"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:26:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 18 May 2026 05:26:36 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 18 May 2026 05:26:33 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next v5 0/9] net: dsa: add DSA support for the LAN9645x
 switch chip family
Date: Mon, 18 May 2026 14:24:55 +0200
Message-ID: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABcFC2oC/43QTWrDMBAF4KsErasiaSTZ7qr3KMHoZ1QLGjlIR
 nUIvntVbxpKIFk+HnxvmCspmCMW8na4kow1ljinFtTLgbjJpE+k0bdMBBOaCc6oL2b8MmnQUq1
 j+Y6Lm0afY8U8WlOQAhfWBgcdekuacs4Y4rovfJCEC024LuTYmimWZc6Xfbryvd9XgMHDlcopo
 zaE3hkOgw7q/RRdnt0Uz69uPu1+FTemkI9N0czQKSYRLNM9v2fCnymf+EaFZhrjXa8GBUz7e6a
 8MeEJU/7eya1mTAXT2+6/uW3bDxBic6DYAQAA
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
X-Rspamd-Queue-Id: 1778356CBC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
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
Changes in v5:
- Individual patches mention specific v5 changes
- Undo offset fix in postpull_rcsum. The original logic was correct for
  CHECKSUM_COMPLETE host NICs
- Use __always_inline in lan9645x_ifh_{get,set}
- remove double space after = in set_merge_mask
- remove unused fields dd_dis and tsn_dis, and add SKU supported port validation
  during setup
- phylink: remove MAC_2500FD
- phylink: add comment about empty supported_interfaces for port 5-6.
- phylink: fix 2:1 rgmii port muxing for port module 4 and 7 to be fully
  dynamic and validate requested mux settings.
- phylink: add comment about 2:1 rgmii port muxing for port module 4
  and 7.
- rx/tx-internal-delay-ps checked against supported 2ns value
- init lan9645x->npi = -1 at probe and check port < 0 in npi_deinit
- use ds->ageing_time_max
- use packed p->host_flood_req for atomic r/w
- fix typo in set_ageing_time comment
- include lan9645x->bridge deref under lock in brige_join
- switch -EBUSY to -EINVAL for vlan add/del in the reserved range.
- remove reserved HSR vlan
- lan9645x_mac_init returns error on table init timeout
- add comment about skipping LOCKED entries on fdb dump
- skip igmp/mld redir for npi port
- make lan9645x_stats_init void
- add SCNT_TX_BUFDROP to tx_dropped
- change rmon range {0,64} -> {64, 64}. Runt frames counted elsewhere.
- remove rx_crc, rx_symbol_err from rx_packets, as they are already
  counted in SZ_* buckets.
- add defensive cancel_delayed_work_sync in stats_free
- Link to v4: https://lore.kernel.org/r/20260430-dsa_lan9645x_switch_driver_base-v4-0-f1b6005fa8b7@microchip.com

Changes in v4:
- v3 was deferred, but I made some changes based on the Sashiko review
- Individual patches mention specific v4 changes
- Fix offset in postpull_rcsum so prefix eth header is cleared, not
  actual eth header, so tag driver works with CHECKSUM_COMPLETE host
  NICs
- Fix untagged rx on vlan aware port with pvid
- Add comment to QSYS_RES_CFG configuration
- Phylink_mac_prepare: fix to make sure we can dynamically change rgmii
  on port 4
- Move ports allocation to probe
- tag_npi_setup: reject cascaded setups
- Skip WARN_ON in lan9645x_to_port
- set_host_flood changed to per port work to coalesce values and skip
  atomic allocations
- Fix clear HOST_PVID vlan membership when a port joins a bridge.
- Explicit default value write to tag type register for untagged frames
- Use lan_rmw for ANA_DROP_CFG
- Add comment for error path in lan9645x_vlan_hw_wr
- Remove mac_entries list and just do direct IO to mac table from
  fdb_add/fdb_del.
- Clean up fresh mdb when hw mac table write fails.
- Remove rx_uc and tx_uc from ethtool stats list, as they are derivable
  from the eth-mac group
- Split stats_init into stats_alloc and stats_init, use alloc in probe
  and init in dsa_setup
- Link to v3: https://lore.kernel.org/r/20260410-dsa_lan9645x_switch_driver_base-v3-0-aadc8595306d@microchip.com

Changes in v3:
- Individual patches mention specific v3 changes.
- Add guard before vlan_remove_tag on xmit
- Add pskb_may_pull checks on rx
- Remove additionalProperties: true in bindings
- Remove unnecessary | from description in bindings
- Change top level $ref to dsa.yaml#/$defs/ethernet-ports
- Use ethernet-ports and ethernet-port
- Move ethernet-ports under properties instead of patternProperties
- Move unevaluatedProperties: false after $ref
- Update bindings example to use ethernet-ports and ethernet-port
- Move DEV_MAC_TAGS_CFG to port setup, instead of vlan config, so vlan
  overhead is always included in port frame maxlen calculation.
- Remove code disabling ipv6 on conduit
- Use of_property_read_u32 for {rx,tx}-internal-delay-ps
- Use dsa_user_ports(ds) instead of
  GENMASK(lan9645x->num_phys_ports - 1, 0) as base flood mask.
- Add comment explaining obey vlan
- Allow disabling aging with explicit zero parameters.
- Fix non-forwarding STP states in bridge fwd calculation.
- Restore host flood state on bridge leave.
- Avoid mac_entry dealloc when mac table writes fail.
- Avoid mdb_entry dealloc when mac table writes fail.
- Dealloc mac_entries on deinit.
- Dealloc mdb_entries on deinit.
- Link to v2: https://lore.kernel.org/r/20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com

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

 .../net/dsa/microchip,lan96455s-switch.yaml        |  111 ++
 MAINTAINERS                                        |   10 +
 drivers/net/dsa/Kconfig                            |    2 +
 drivers/net/dsa/microchip/Makefile                 |    1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |   11 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   12 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  306 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 1021 +++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  435 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  |  397 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |   83 +
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  |  409 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |  224 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_regs.h | 1915 ++++++++++++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.c    |  929 ++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.h    |  279 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c |  403 ++++
 include/linux/dsa/lan9645x.h                       |  145 ++
 include/net/dsa.h                                  |    2 +
 net/dsa/Kconfig                                    |   11 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag_lan9645x.c                             |  315 ++++
 22 files changed, 7022 insertions(+)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260210-dsa_lan9645x_switch_driver_base-312bbfc37edb

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


