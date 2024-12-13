Return-Path: <netdev+bounces-151775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B69F0D72
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE28E169337
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97A1E048C;
	Fri, 13 Dec 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S+l8Phye"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E638DE1;
	Fri, 13 Dec 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097292; cv=none; b=H6Ab10xOmoMMTok7qhj+fB6vlw+MugKTdSuX+GWR7zP8XNh5bFyVTYMkncTgUaQbLS+JF6dxm4xGekgw9GN3i+2UzKRbtm7DCADW5FqyxbDIkVNh6FVHvW9NQGBxTQD3qvtOdygAUKIjrI7Qt66KhawgbuWJASL0si6vXrjTHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097292; c=relaxed/simple;
	bh=zhRKhkXM9NV1IvPbodM/PpN5XKo5eHA3bD2RJIcWmUA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eGL42TZL5j1v8i8AsbFSRmwKqkoizaQEBRbqZ+IJ2rfmdBVnwGl5gH/XTp4hMw++8aVQjVVGveWOW0D65WL5eR/oXhKz2kqncMZyn4y5MifmUQYxQpQDCcpY+gI+JlHI4pOLq6OZgAzq4eupnoieZkFVhkvA9ECtUfeNLNhtwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S+l8Phye; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734097290; x=1765633290;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=zhRKhkXM9NV1IvPbodM/PpN5XKo5eHA3bD2RJIcWmUA=;
  b=S+l8PhyendLrLbjbqw0/mlQGms0O5BDs40QupdavJMGXzfHHmDzJEI3b
   heTk2cmoLuy75xBVN5Tlwv/EnDB583EImhib6ByrRzgn0rAsRVBCRqJHl
   SBaD+GzMNqV5ZfFRBLPj8kErn2Ie1mYmzGm7xNxhkkCXMraKwpjYcPfgq
   1xFbnzVXL1tlwObkG8n/XYlkiJQ5y48RbO7//ewk96DMmY7FODVnVNlgB
   Ik4i1kLM2AMVurmUhYwWJRjC1iK4uA2ERxXNB5dAR3RjVdw3xer6+GjDn
   ljs/lUKSCgLpTxdOfdGJGvIh8j9J2H2SNprph6eS2DojfVP9XP7pdBn+J
   Q==;
X-CSE-ConnectionGUID: +Dz6lc3EQgqK8+CPf2Bkrw==
X-CSE-MsgGUID: 7b3ndOfnTk6UYN4rKutt3w==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="202965468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 06:41:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 06:41:16 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 06:41:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v4 0/9] net: lan969x: add RGMII support
Date: Fri, 13 Dec 2024 14:40:59 +0100
Message-ID: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGs5XGcC/4XOS2rEMAyA4asMXlfFjp2Hu+o9yiz8UGpB4wQ7u
 BmG3L2e0MVQClkKoe/XnWVMhJm9Xe4sYaFMc6yDerkwF0z8RCBfZ9bwRgnBFeTFpK2FLxN1pzf
 I37S6AD5RwQQKfKttPzRcDa1hFVkSjrQdgQ8WcYWI28qudWNNRrDJRBcegclQfBwEyuucbsdDR
 Rxnv+3urF0EcBj7sZeiU7Kz/n0il2YXaHl183RUS/NECnlKNpXk3urBOK47L/4j5TM5nJKyktL
 hiNhij9L8Jfd9/wG9QZsWlwEAAA==
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
	<robert.marko@sartura.hr>
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
base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


