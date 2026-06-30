Return-Path: <netdev+bounces-303052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qd6VObWLQ2oSbAoAu9opvQ
	(envelope-from <netdev+bounces-303052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:26:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD06E2227
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:26:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=RrTK5d2w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303052-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303052-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 224593030D02
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FE3EBF2F;
	Tue, 30 Jun 2026 09:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051D35C190;
	Tue, 30 Jun 2026 09:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811471; cv=none; b=vA/pBVzATmldknLk6dQ0yTYTLnCMeQh9JDcuTOaPmNlMvDX0uK58fycxOMtfokmgAEOSs+zVOMo5kMde8eXAzLE8pldLMiyF+9U8X6MgZ7DdKDiKLtwJe1uJH6KveoaulVj01W3Udnm/s3Aq7CBB9ih8hUBK5VwqI5/zvgrDxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811471; c=relaxed/simple;
	bh=MAR7dBMvboAZsq8wqndsRj8+f2jQFua2iR0ewa1tL7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLYXA8ydn02ll+JfekAW5ZldInhOdRac5ToFw9QDR3RqiShz8/Br8x7OujOQa76YnyuA8HitXJOYMBlLis0H7PxR4UpOoPElQlaFM98XKHrsRqKvQBSrXtN9jg3h8xADFkPPR/0f93cl+/EnuhCRA9qNUpgohbcu0sOV/OM7oaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RrTK5d2w; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782811469; x=1814347469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MAR7dBMvboAZsq8wqndsRj8+f2jQFua2iR0ewa1tL7c=;
  b=RrTK5d2w1AmWNuQWOzC/8ERb8OGF+W5kdYok63VMTqNiW1z/4FkbLstl
   BJdsJBdVGR1OECgzhl2vz1tVvAwWrGT2cahpJwRZ+1jjTTHkhjCL1/C6G
   RufZvmUY6UDYzmpEj8WtNEJj9abs1yUzKysSMhlmbbHU0RDxcSXEgnBTX
   MEIOqsXRJisSj5PvpTzpDHgSyZMjYtRFVtYEuNVgX/+ZeVuX8tHk2xuQm
   QyOtApNu2dG9JT6TXw3hjZz04e2YqL46azN0xWLBM79oB+d7wIIyGomCg
   OIplOm7YL9esnnZKz94oDIvncWMOyYdQx2v9bWNMOzH5zJDhRGyu38EeK
   g==;
X-CSE-ConnectionGUID: h08U4A3ST1ap5TG9w0Nndw==
X-CSE-MsgGUID: 854853ThQGG7lQfDPj9ddw==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="291266459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:24:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:24:26 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:24:18 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v4 0/7] Read MAC address from SST vendor specific SFDP region
Date: Tue, 30 Jun 2026 14:53:59 +0530
Message-ID: <20260630092406.150587-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303052-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:manikandan.m@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[manikandan.m@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manikandan.m@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81BD06E2227

Some Microchip/SST QSPI flashes (e.g. the SST26VF064BEUI) are factory
programmed with globally unique, write-protected EUI-48 and EUI-64
identifiers stored in a vendor-specific SFDP parameter table. On boards
that have no on-board EEPROM (sama5d27_wlsom1, sama5d29 curiosity,
sam9x75 curiosity) this is a reliable source for an Ethernet MAC address,
instead of relying on a U-Boot-provided or random address.

This v4 reworks the approach into a generic NVMEM framework with no vendor
code in the SPI NOR core:
 - The SPI NOR core now exposes the entire SFDP as a generic read-only
   NVMEM device, rooted at a new "sfdp" child node of the flash.
 - A new NVMEM layout driver (drivers/nvmem/layouts/) locates the
   Microchip vendor parameter table at runtime and presents the EUI-48 as
   a "mac-address" cell.
 - Arbitrary parameters can be read with a standard fixed-layout
   (known offset) or with an nvmem-layout parser (location discovered at runtime).

Changes in v4:
 - Rework per v3 review: remove the vendor-specific SFDP handling from the
   SPI NOR core; expose the whole SFDP as a generic read-only NVMEM device
   and move the EUI extraction into an nvmem-layout driver.
 - Introduce a new nvmem-layout driver to discover the vendor-table location
   at runtime; no offset hardcoded in the device tree.
 - Describe the SFDP via a dedicated "sfdp" subnode (compatible
   "jedec,sfdp"), which also resolves the v3 dtbs_check "Unevaluated
   properties ('nvmem-layout')" warning.
 - Reverse the stored EUI bytes into canonical MAC order.
 - Enable the layout in sama5_defconfig.

 Changes in v3:
 - 2/3 - add support to update the QSPI partition into 'fixed-partition'
   binding in sama5d27_wlsom1
 - 3/3 - add nvmem-layout in qspi node for EUI48 MAC Address and nvmem cell
   properties for macb node in sama5d27_wlsom1

Changes in v2:
 - 1/3 - parse the SST vendor table, read and store the addresses
  into a resource - managed space. Register the addresses
  into NVMEM framework
 - 2/3 - add support to update the QSPI partition into 'fixed-partition'
  binding

v3: https://lore.kernel.org/linux-arm-kernel/20250521070336.402202-1-manikandan.m@microchip.com/

Manikandan Muralidharan (7):
  dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via
    NVMEM
  dt-bindings: nvmem: layouts: add Microchip/SST SFDP EUI layout
  mtd: spi-nor: sfdp: expose the SFDP as a read-only NVMEM device
  nvmem: layouts: add Microchip/SST SFDP EUI layout driver
  ARM: dts: microchip: sama5d27_wlsom1: use fixed-partitions for QSPI
    flash
  ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
  ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout

 .../bindings/mtd/jedec,spi-nor.yaml           |  18 ++
 .../layouts/microchip,sst26vf-sfdp-eui.yaml   |  60 ++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 MAINTAINERS                                   |   6 +
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   |  61 +++---
 .../dts/microchip/at91-sama5d27_wlsom1_ek.dts |   2 +
 arch/arm/configs/sama5_defconfig              |   1 +
 drivers/mtd/spi-nor/core.c                    |   5 +
 drivers/mtd/spi-nor/core.h                    |   1 +
 drivers/mtd/spi-nor/sfdp.c                    |  83 ++++++++
 drivers/nvmem/layouts/Kconfig                 |  10 +
 drivers/nvmem/layouts/Makefile                |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c      | 182 ++++++++++++++++++
 13 files changed, 409 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0


