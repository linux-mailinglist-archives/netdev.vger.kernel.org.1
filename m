Return-Path: <netdev+bounces-287922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCvaHBOpBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68854099A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86ABD3000894
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876553AEF44;
	Thu, 14 May 2026 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w4WOAcH7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59C3B19B1;
	Thu, 14 May 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755854; cv=none; b=hyTWj/hyfkKXf8iOWHpKEJDEL0fHRkphnRNunCZ3DAXQXI5XuK/E+KZI6QwAJKonat8+eZFCwvbfKGcQhBuMStiSZKX9r/Os3bzWjtYznkcDxSoGLwULoWAG76dxAFLT50eGD/MhTxXdbgdHA5uYxcp9LykyC6qLdzDt4bx18Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755854; c=relaxed/simple;
	bh=xYq3XhE9D+cD8KHPW0WBAKksLBWcNGoAUf14L+sOG0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T37TEHY6WALSoolsLADS5tVC8ycMVAG75twyZKKB3d567VPlWg60VOg+yljtt0PmpanWIGxBeVKO8xUuK8VagL8AysGQKTY859YjmZeCC99A5CLFJ6XYM7Ett0Est8xi6ErM46NygQFcPM2KlAfdBa/ZwRKRntoC6MKmOd2hWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w4WOAcH7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755852; x=1810291852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xYq3XhE9D+cD8KHPW0WBAKksLBWcNGoAUf14L+sOG0s=;
  b=w4WOAcH7NOr/GIt9RonWpRFhmnWLET2TiWcshyBLtuxrl8mAh8cK6PbR
   +y6eJoATHBsEG3fnHiy4jQa84kOFCBI8y2DG5WEYPC+d8yzd3FXDlHrZz
   I8agTkoeBTcJRHwVbtSqk7wWuOCDWWbzss0Sy9cVx+yyLQav4ppAaGA6q
   GhGvuRT6dmM2WttCYBMPK6djf6rzNF4RdV07+pfunL/tOBKKhnYQ5vwVn
   UiBAYdUsZC6mNH3qbGlvEt2OBe5TZjn5u5A2gpiB2V1R3P9OMRpXJdmT6
   34cP/U/iHcf6HB86vbonVz7BdwkqyV9U3QAcflIILbhuRKt3NSR9TVRcU
   g==;
X-CSE-ConnectionGUID: nLLIMr+6ThGN7rVuX/yuXw==
X-CSE-MsgGUID: MCQCzWOIT0Wc0uqEXKlBnQ==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="224736395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 03:50:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 14 May 2026 03:50:45 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:50:42 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/5] net: lan743x: Add SFP support for PCI11x1x
Date: Thu, 14 May 2026 16:20:23 +0530
Message-ID: <20260514105028.42942-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 6D68854099A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-287922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url]
X-Rspamd-Action: no action

This series adds SFP module support for the Microchip PCI11x1x Ethernet
controller family by integrating with the kernel's phylink/SFP subsystem.

The PCI11x1x device contains an embedded PCIe switch with downstream
ports for the Ethernet controller and a multi-function peripheral endpoint
(GPIO, I2C, UART, SPI controllers). SFP support relies on this peripheral
endpoint: the GPIO controller provides the SFP control/status signals and
the I2C controller provides access to the SFP module EEPROM. SFP capability
is hardware-strapped and detected at probe time.

Patch 1 renames the misleading is_sgmii_en flag to is_pcs_en to better
reflect that it tracks PCS interface enablement rather than a specific
SGMII mode. No functional change.

Patch 2 reads the SFP enable straps (STRAP_SFP_USE_EN_ and STRAP_SFP_EN_)
from the PCI11x1x strap registers and stores the result in a new
is_sfp_support_en flag. A validation check ensures PCS is also enabled
whenever SFP support is requested, since SFP operation requires the PCS
interface.

Patch 3 registers software nodes to describe the SFP hardware topology to
the kernel: the GPIO device (for TX-fault, TX-disable, LOS, mod-def0, and
rate-select0 signals), the I2C adapter (for SFP EEPROM access), the SFP
cage node, and a phylink node configured for in-band-status mode. The
driver navigates the PCI topology at probe time to locate the paired
peripheral controller functions. A new CONFIG_LAN743X_SFP Kconfig symbol
guards the feature and selects the required I2C, GPIO, SFP, and PCS_XPCS
dependencies.

Patch 4 registers an SFP platform device backed by the SFP software node
when SFP support is enabled, and associates the I2C adapter's firmware node
so the SFP subsystem can manage module detection and EEPROM reads.

Patch 5 adds a dedicated PCS MDIO bus and an XPCS instance for SFP link
management. C45 read/write callbacks are wired to the existing internal
SGMII access functions. The mac_select_pcs phylink callback returns the
XPCS instance when present. SGMII and 2.5GBASE-X interface modes are
enabled in phylink to support the range of SFP modules. The phylink
connect path is also updated to skip the fallback PHY scan when SFP
support is active.

Based on original work by Raju Lakkaraju:
https://lwn.net/ml/all/20240911161054.4494-1-Raju.Lakkaraju%40microchip.com/

Change Log:
===========
v3 -> v4:
  - Use device_find_child() + i2c_verify_adapter() to locate the I2C
    adapter and dev_is_auxiliary() + name match to locate the GPIO aux
    device; removes dependency on peripheral driver struct layouts
    [patch 3/5, 4/5]
  - Use pci_walk_bus() for PCI peripheral device traversal [patch 4/5]
  - Fix memory leak on error paths in lan743x_swnodes_register()
    [patch 3/5]
  - Fix missing NULL terminator in property_entry arrays [patch 3/5]
  - Use DL_FLAG_AUTOREMOVE_CONSUMER for device links to peripheral
    devices [patch 4/5]
  - Set phy_mask = ~0 on PCS MDIO bus to prevent unintended PHY scan
    [patch 5/5]
  - Style fixes [patch 3/5]

v2 -> v3:
  - Add patch 1/5 to rename is_sgmii_en -> is_pcs_en as a prerequisite
    cleanup before the SFP series [patch 1/5]
  - Update error message to reference strap names:
    "SFP_EN strap specified without SGMII_EN strap" [patch 2/5]
  - Use str_enable_disable() helper for debug logging instead of open-coded
    ternary [patch 2/5]
  - Add is_sfp_support_en initialisation to false in probe [patch 2/5]
  - Move <linux/i2c.h>, <linux/gpio/machine.h>, <linux/auxiliary_bus.h>
    includes, PCI1XXXX_*/PCI11X1X_* macros, NODE_PROP macro and helper
    structs from lan743x_main.c to lan743x_main.h [patch 3/5]
  - Add lan743x_swnodes_unregister() helper with kfree inside the if block
    [patch 3/5]
  - Move software node registration out of lan743x_hardware_init() into
    lan743x_phylink_create() with proper error unwind, so it is not called
    on PM resume path [patch 3/5]
  - Move software node unregistration from lan743x_full_cleanup() into
    lan743x_destroy_phylink() to be symmetric with registration and handle
    probe failure path correctly [patch 3/5]
  - Use kzalloc_obj() instead of kzalloc() for sw_nodes allocation
    [patch 3/5]
  - Fix typo: "SPIcontrollers" -> "SPI controllers" in comment [patch 3/5]
  - Add cleanup_sfp: label in probe error path; null sfp_dev and i2c_adap
    pointers after unregister in lan743x_full_cleanup() [patch 4/5]
  - Move <linux/platform_device.h> to lan743x_main.h where
    struct platform_device *sfp_dev is declared [patch 4/5]
  - Fix probe failure path: goto cleanup_hardware -> goto cleanup_phylink
    on lan743x_sfp_register() failure [patch 4/5]
  - Consolidate phylink PCS and 2500Base-X support into a single patch
    [patch 5/5]
  - Switch from struct dw_xpcs * to struct phylink_pcs * internally; use
    xpcs_create_pcs_mdiodev() instead of xpcs_create_mdiodev() +
    xpcs_to_phylink_pcs(), and xpcs_destroy_pcs() instead of
    xpcs_destroy() [patch 5/5]
  - Use devm_mdiobus_alloc() instead of mdiobus_alloc() for pcs_mdiobus
    [patch 5/5]
  - Move <linux/phylink.h> and <linux/pcs/pcs-xpcs.h> from
    lan743x_main.c to lan743x_main.h [patch 5/5]

v1 -> v2:
  - Split the patches to 'PHYLINK' and 'SFP' parts
  - Change variable name from 'chip_rev' to 'fpga_rev'
  - SFP GPIO definitions and other macros move from lan743x_main.c to
    lan743x_main.h file
  - Change from 'PCI11X1X_' to 'PCI11X1X_EVB_PCI11010_' strings for
    GPIO macros
  - Add platform_device_unregister() when sfp register fail
  - Add two new patches to this patch series

Thangaraj Samynathan (5):
  net: lan743x: rename is_sgmii_en to is_pcs_en
  net: lan743x: read SFP straps from PCI11x1x device
  net: lan743x: Add support to software-nodes for SFP
  net: lan743x: Register SFP platform device for PCI11x1x
  net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x

 drivers/net/ethernet/microchip/Kconfig        |  15 +
 .../net/ethernet/microchip/lan743x_ethtool.c  |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 450 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  69 ++-
 4 files changed, 520 insertions(+), 18 deletions(-)

-- 
2.34.1


