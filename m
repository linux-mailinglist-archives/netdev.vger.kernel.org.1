Return-Path: <netdev+bounces-153688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1EB9F938E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F888164DE2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57926215F7F;
	Fri, 20 Dec 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2FDMGRgN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1A1E50B;
	Fri, 20 Dec 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702560; cv=none; b=Yq0F+ujKW3kmNnTiClvdDRERxqD+BCL7gvVuyVwQ0jIOSM9bXRGvnYG2JMbpU+PXDqIaRtm4uV6mlvBFZUAdU2NTRVyfZV+4O4FbbMHkAfeYfG8XjBQGhN/8Y0UWwnxrv7T14lEwHhob1bgNfZo5F5WXeLjtpvFNxNU+NrIxbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702560; c=relaxed/simple;
	bh=DJqB9T4Cn7pUwzkT4atNAK0XjNt3zrURlaVQr6egu7k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cwEuekZyiJg3Iw3QIPkyjPwuc2jVEt/lKHl+PI4QpXiZ/2wGL8Y57Q3y/eAi1h/5RVQ7HdEag43SQU+tu0grXCTWF4YgHno3FFfRhhfsMbKk5YlykhJpgVmntKqkBQvjzXXUA3usTTEej9GzMfN+hl7KRqZtbeAz2QpMaXyk79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2FDMGRgN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702558; x=1766238558;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DJqB9T4Cn7pUwzkT4atNAK0XjNt3zrURlaVQr6egu7k=;
  b=2FDMGRgNf0UJTZFaa9Ur9kNYr0QYB0bJ5eRcnwzj6HBHuAjZueDPucPb
   evi4nGaY4v9hBLNvB2zETQAeFLj4UXzJBGiq/PK5BHcyAsaTt8j8bQJDB
   i5b6XF4IVoQGlBGFkDwLtOxcsVD5Dx99uGPe9gQqx1N6geXj9pb/yPVn5
   1GV7a8oI+Fz3v1YUoBpRIBoPH5eemWLpf/cXMj6oFuZq0QtiVmz8SOm9I
   D6EB7nVl79cPsxFEFVJa/paui3/V/63yzk78XwoK8p0Lt4EUl0cz9dYCr
   q78uS37X6UF2p4YdKVUUYUA0wB0RXlb0hs/Qa4DKGFqCG4+JJNpLKDCjU
   w==;
X-CSE-ConnectionGUID: RUDE3qXGTIK0i20iY0tGeQ==
X-CSE-MsgGUID: Sm0QUGH2T/u486dHcQ0zCA==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="39551349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:48:51 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:48:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v5 0/9] net: lan969x: add RGMII support
Date: Fri, 20 Dec 2024 14:48:39 +0100
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALd1ZWcC/43OzWrDMAzA8VcpPk/DX4njnvYeowfHVhbB4gQ7p
 Bkl7z43DFZGITsKod9fN5YxEWZ2Pt1YwoUyjbEM1cuJ+d7FDwQKZWaSSy0E15Anl9YKPl20tV0
 hX2n2PYRECybQECrbmkZy3VSOFWRK2NG6B95ZxBkirjO7lE3rMkKbXPT9PTA4iveDnvI8pq/9o
 UXsZz/t+qi9CODQmc4oUWtVt+FtIJ9G39P06sdhry7ygRTqkJSF5KG1jfPc1kE8I9Uj2RySqpD
 KY4dYoUHlnpH6l5T/+FIXMghnpLdeG6H/ktu2fQNuTbE+6gEAAA==
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14-dev

== Description:

This series is the fourth of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts is split into multiple series (might change a
bit as we go along):

        1) Prepare the Sparx5 driver for lan969x (merged)

        2) Add support for lan969x (same basic features as Sparx5
           provides excl. FDMA and VCAP, merged).

        3) Add lan969x VCAP functionality (merged).

    --> 4) Add RGMII support.

        5) Add FDMA support.

== RGMII support:

The lan969x switch device includes two RGMII port interfaces (port 28
and 29) supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.

== Patch breakdown:

Patch #1 does some preparation work.

Patch #2 adds new function: is_port_rgmii() to the match data ops.

Patch #3 uses the is_port_rgmii() in a number of places.

Patch #4 makes sure that we do not configure an RGMII device as a
         low-speed device, when doing a port config.

Patch #5 makes sure we only return the PCS if the port mode requires
         it.

Patch #6 adds checks for RGMII PHY modes in sparx5_verify_speeds().

Patch #7 adds registers required to configure RGMII.

Patch #8 adds RGMII implementation.

Patch #9 documents RGMII delays in the dt-bindings.

Details are in the commit description of the individual patches

To: UNGLinuxDriver@microchip.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Russell King <linux@armlinux.org.uk>
To: jacob.e.keller@intel.com
To: robh@kernel.org
To: krzk+dt@kernel.org
To: conor+dt@kernel.org
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: robert.marko@sartura.hr

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v5:

- Updated tags received on the list. No other changes to commits. Patch
  6/9 from v4 is kept, since it is required in order for RGMII port
  config to not fail. The cleanup of the sparx5_port_verify_speed()
  function will be deferred to another series (see comments on patch 6/9
  from previous version).

- Link to v4:
  https://lore.kernel.org/r/20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com

Changes in v4:

- Split patch #4 in v3 into two patches, where the new patch #5 handles
  PCS selection, by returning the PCS only for ports that require it.

- Got rid of the '|' symbol for {rx,tx}-internal-delay-ps property
  description in the dt-bindings (patch #9).

- Link to v3: https://lore.kernel.org/r/20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com

Changes in v3:

v2 was kindly tested by Robert Marko. Not carrying the tag to v3 since
we have changes to the handling of the delays.

- Modified lan969x_rgmii_delay_config() to not apply any MAC delay when
  the {rx,tx}-internal-delay-ps properties are missing or set to 0
  (patch #7).

- Removed 'required' constraint from {rx-tx}-internal-delay-ps
  properties. Also added description and default value (Patch #8).

- Link to v2: https://lore.kernel.org/r/20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com

Changes in v2:

  Most changes are in patch #7. RGMII implementation has been moved to
  it's own file lan969x_rgmii.c.

  Details:

    - Use ETH_P_8021Q and ETH_P_8021AD instead of the Sparx5 provided
      equivalents (patch #7).
    - Configure MAC delays through "{rx,tx}-internal-delay-ps"
      properties (patch #7).
    - Add selectors for all the phase shifts that the hardware supports
      (instead of only 2.0 ns, patch #7).
    - Add selectors for all the port speeds (instead of only 1000 mbps.)
    - Document RGMII delays in dt-bindings.

  - Link to v1: https://lore.kernel.org/r/20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com

---
Daniel Machon (9):
      net: sparx5: do some preparation work
      net: sparx5: add function for RGMII port check
      net: sparx5: use is_port_rgmii() throughout
      net: sparx5: skip low-speed configuration when port is RGMII
      net: sparx5: only return PCS for modes that require it
      net: sparx5: verify RGMII speeds
      net: lan969x: add RGMII registers
      net: lan969x: add RGMII implementation
      dt-bindings: net: sparx5: document RGMII delays

 .../bindings/net/microchip,sparx5-switch.yaml      |  18 ++
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   5 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |  10 +
 .../microchip/sparx5/lan969x/lan969x_rgmii.c       | 224 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |  14 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 ++++--
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
 11 files changed, 484 insertions(+), 29 deletions(-)
---
base-commit: b73e56f16250c6124f8975636f1844472f6fd450
change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


