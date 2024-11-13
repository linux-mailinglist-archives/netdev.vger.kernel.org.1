Return-Path: <netdev+bounces-144587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C479C9C7D5B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84111285513
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E02071FA;
	Wed, 13 Nov 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ps/yNT5b"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D61CAAC;
	Wed, 13 Nov 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532327; cv=none; b=DvxYmjuUk/P0NZ++nQr7XMRO+h/kGmJgC6LKxCV6aGzYxCAb33jUGDdHRTI2nVrqNwmADG+uBVHrtA3xSDu8/nrZ2q4AEdeXdOP57XM0UL79s1YUHWXPJ/fhNMWVrQm0BRO/b97VpLA8bVi4aQhw3Xx9TNQy1edAN5OmBr7dk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532327; c=relaxed/simple;
	bh=MiOA+h2WEfYvSK6LWO85YbpCELWFRGGFH0WIAFxXeZc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LANgu8PShrpqGdhfpy8OIImboBzJFizGJiuHYRdBG1eb4zECVLydfhfNNH8maQ5IEJgIrEZdRkDwTtrcph/ZDqxjXUtl+/FLhC0dPZY87LPG2Vi0rps2V2GOXJKsBW+q5zQJuPB9kHt3ULklullN63Mt8tSh/HiNflgN+Z7yG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ps/yNT5b; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731532326; x=1763068326;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=MiOA+h2WEfYvSK6LWO85YbpCELWFRGGFH0WIAFxXeZc=;
  b=ps/yNT5bfYo9qlc1lHrS0D68/0gIS3pM+Doo+HGKh/LEIctOhdY1AtYM
   ZLLHx4FzF9LSUMzEiIpIlF/bY0tHNbKkAR/UdAJVioayq3utu9bHJBS65
   5HBraTNyYFADXhW7Sx1lq2fGudi9p9alB5PxIHICwXcH1ghp4iYFImosk
   hUabUiTpH8bccdKMiDe/rcQwQ9PDdwcE05SFaZTa7r8BTYiB0zxSoCtja
   GtY0hGppNrl/+zH4jJUHQwn4Q7y8NS8eIG3NvkS7VawHYGhQkjerxWpTn
   J1JZ9yEHVMfIGRUosJRxk7Gd9NNltGn8R2y4GOVihv+yshrE4Q4OeBBjX
   g==;
X-CSE-ConnectionGUID: KA3skogJTWSLY1V4ky2YAQ==
X-CSE-MsgGUID: iVpW/84nSha1vD/zEH2PYA==
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="265427892"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 14:12:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Nov 2024 14:11:34 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 13 Nov 2024 14:11:31 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/8] net: lan969x: add RGMII support
Date: Wed, 13 Nov 2024 22:11:08 +0100
Message-ID: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwVNWcC/4WOzQqDMBCEX0X23C1G419PfY/iIca1WahRNmIt4
 rtXpfceh+Gbb1YIJEwBbtEKQjMHHvwekksE1hn/JOR2z5DEiVYq1hhGI0uGL+OrvFowvHmyDlv
 hmQQ1tlnVFGUS6zIzsI+MQh0vp+ABnib0tExQ701jAmEjxlt3CHrD/gAch2mQz3loVif2c+f/3
 LPCGLuiK1KV6zRv2nvPVgbreLzaoYd627YvYI63bfEAAAA=
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
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

The lan969x switch device includes two RGMII interfaces (port 28 and 29)
supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.

Details are in the commit description of the patches.

== Patch breakdown:

Patch #1 does some preparation work.

Patch #2 adds new function: is_port_rgmii() to the match data ops.

Patch #3 uses the is_port_rgmii() in a number of places.

Patch #4 uses the phy_interface_mode_is_rgmii() in a number of places.

Patch #5 adds checks for RGMII PHY modes in sparx5_verify_speeds().

Patch #6 adds registers required to configure RGMII.

Patch #7 adds RGMII implementation.

Patch #8 document RGMII delays.

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

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
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
Daniel Machon (8):
      net: sparx5: do some preparation work
      net: sparx5: add function for RGMII port check
      net: sparx5: use is_port_rgmii() throughout
      net: sparx5: use phy_interface_mode_is_rgmii()
      net: sparx5: verify RGMII speeds
      net: lan969x: add RGMII registers
      net: lan969x: add RGMII implementation
      dt-bindings: net: sparx5: document RGMII MAC delays

 .../bindings/net/microchip,sparx5-switch.yaml      |  20 ++
 drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |   5 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |  10 +
 .../net/ethernet/microchip/lan969x/lan969x_rgmii.c | 237 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |   3 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 +++--
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
 11 files changed, 488 insertions(+), 28 deletions(-)
---
base-commit: 12079a59ce52e72a342c49cfacf0281213fd6f32
change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


