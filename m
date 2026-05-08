Return-Path: <netdev+bounces-285632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGXMHzhz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B264F1E7F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA2F30315ED
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533033ADA9;
	Fri,  8 May 2026 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g12dDC/C"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0B32FA14;
	Fri,  8 May 2026 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217738; cv=none; b=bQpGopY6McvHT6cyWZV1FK1GM/Z0WuCmYbzohqB8pnsqSvpotH0wO+bY6SpUxrYkqm9phUpq+WiJjjg1Fe8yt1AhsiVd5XE3628XqXEa7qle1/sOKoOOTpABZONwG/cYiAlAlt9HruVl6Unk2aduIgrR5D2pcMOfi9ttN49IReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217738; c=relaxed/simple;
	bh=l3+4m1BK8eQay8j9gZSUAJTgeB2ZdXYQ7hOu2JFX1qs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGDc2SWOQmmKQMrkr1WzIHJwwJvkcBtz7bfOyhJgqhPzDZ9uPORfurXcEaZcYEkbtCkMlbR2KWsqTaQapCOnXAriSZPzppeZkzMlmePjDlueMzdqyVb6vOPVJb/9z/M64mBuVt2hlPbFP8tV1yZDXdLauuvdoH8jTay39UcfOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g12dDC/C; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217737; x=1809753737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l3+4m1BK8eQay8j9gZSUAJTgeB2ZdXYQ7hOu2JFX1qs=;
  b=g12dDC/CfbTTv8WTmT/Nl3BKlDn3VQXfCjPHxvw4i+T67SOOQCclzBQP
   Z/JRRqPhX6Z9n7cqDKAcY3QNcXMqqBV6dnpzi3mqILjXfUKlIDtl1gVPU
   ti4KLpD1TWLUmm5smk+Ki7eQvoncK6uE9TffehaoWtKzedBJG2dEcNN8c
   lKJ7RCocZAFqmgI5ErEXJmTyhhLPerVhiR/VDZ2fuY9cUNVwpZaDUUuwO
   hgSQvkOX3IZ4mc8CQG/27jEpU+OsEC7bisqh4JEx6gROob1NnpzJUoxX1
   LaTc4tqIOmPp5sCJw/wEhVb+Zg++gJnM8aEB6dnA/LdEh0elOB7Iz+K68
   w==;
X-CSE-ConnectionGUID: NAg15HABSc2VbPsFG7KDgQ==
X-CSE-MsgGUID: RIiEK+q1STKCyoxZfE3+2w==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="56428033"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2026 22:22:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 7 May 2026 22:22:16 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:12 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 0/5] net: lan743x: Add SFP support for PCI11x1x
Date: Fri, 8 May 2026 10:51:45 +0530
Message-ID: <20260508052150.11852-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: F3B264F1E7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
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
cage node, and a phylink node configured for in-band-status mode. The driver
navigates the PCI topology at probe time to locate the paired peripheral
controller functions.

Patch 4 registers an SFP platform device backed by the SFP software node
when SFP support is enabled, and associates the I2C adapter's firmware node
so the SFP subsystem can manage module detection and EEPROM reads.

Patch 5 adds a dedicated PCS MDIO bus and an XPCS instance for SFP link
management. C45 read/write callbacks are wired to the existing internal
SGMII access functions. The mac_select_pcs phylink callback returns the XPCS
instance when present. SGMII and 2.5GBASE-X interface modes are enabled in
phylink to support the range of SFP modules. The phylink connect path is
also updated to skip the fallback PHY scan when SFP support is active.

Based on original work by Raju Lakkaraju:
https://lwn.net/ml/all/20240911161054.4494-1-Raju.Lakkaraju%40microchip.com/

Change Log:
===========
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
    structs (pci1xxxx_i2c, gp_aux_data_type, auxiliary_device_wrapper,
    aux_bus_device) from lan743x_main.c to lan743x_main.h [patch 3/5]
  - Add lan743x_swnodes_unregister() helper with kfree inside the if block
    [patch 3/5]
  - Move software node registration out of lan743x_hardware_init() into
    lan743x_phylink_create() with proper error unwind, so it is not called
    on PM resume path [patch 3/5]
  - Move software node unregistration from lan743x_full_cleanup() into
    lan743x_destroy_phylink() to be symmetric with registration and handle
    probe failure path correctly [patch 3/5]
  - Use kzalloc_obj() instead of kzalloc() for sw_nodes allocation [patch 3/5]
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

 drivers/net/ethernet/microchip/Kconfig        |   3 +
 .../net/ethernet/microchip/lan743x_ethtool.c  |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 367 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  91 ++++-
 4 files changed, 447 insertions(+), 18 deletions(-)

-- 
2.34.1


