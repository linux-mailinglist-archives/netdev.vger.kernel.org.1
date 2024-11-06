Return-Path: <netdev+bounces-142506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A459BF61E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AA528418A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90853207A12;
	Wed,  6 Nov 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zQPEz+6t"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942920721D;
	Wed,  6 Nov 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920647; cv=none; b=Z8fpgWo230SwqELpJNdg4eK3xKRUbngMzh0G3h7BjVfQJu94JZqpWxASvyvkwia3RRBZutxiRtJFhoNk8TufwBzfuGkfnB/qcfFQgLe5QiBWYp8Nnl8qUj+c3rBtNx4EPPddaUebRotJN0z2ia1ye2LA2wRfd6rR3skbgm6DQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920647; c=relaxed/simple;
	bh=SiQEeSRkNADgB7z1FpkMKnsPf6At/dTxDrBLVodmNgk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=oG6/MS/0EQrIDj5OJ3GcciysS8+Qefv2knytHsujgDLMh95+7kqmmzt/+XBoWPws+mZrg5GI+c5DrcqnLaR89ahmuojGx09pz6ygIFx7BYRJCkbwI8aETvoxX04ooqnFpjrjmUAl09sLZgoqItRcM6rnNiwFHiVP+dO0TnHebLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zQPEz+6t; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730920645; x=1762456645;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SiQEeSRkNADgB7z1FpkMKnsPf6At/dTxDrBLVodmNgk=;
  b=zQPEz+6t17r38vEkWMY2ztteUYxvz3849ikdNGtUolzQchWVygbaqQwV
   ag3n1mMAIfNFNhqgDw/dlbtUlppeZLp96FOYQpWLo4m+fxjtZgpzloDUE
   CLekBC2+cCeJ41yxt1Jrp0w6gyK2blxiuO7UEkYpzyTITmpm5btlSvaTS
   KYyQkkfAwkbkxloqNVTq6H0TgupqUu/zHoRsj2wDmkDTBIkR0fGeOfi5G
   WAfnZNg8HhWwJUCgij/kRFfEr0Z2uvm/qm3i5gg50ocwqgJ9i6LZRnONz
   daMRbh0VBZ9bbt7WsblTw+sLg8vxCW7IiQ4dySi64k39HYeIf78P4hOcP
   A==;
X-CSE-ConnectionGUID: Pj5H9ORUSlaljgmVr541Mw==
X-CSE-MsgGUID: FNMV5KrAQpmxk4FeLuDC3w==
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34481046"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 12:17:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 12:17:03 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 12:17:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/7] net: lan969x: add RGMII support
Date: Wed, 6 Nov 2024 20:16:38 +0100
Message-ID: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbAK2cC/x2N0QrCMAwAf2Xk2UBXOt38FdlDtkYb0DjSMQtj/
 2718Ti42yGzCWe4NjsYb5LlrRXaUwNzIn0wSqwM3vnQti5gXshKh0/S4TwUzB9Z54TRZGPDgLE
 bpkvvXeg7ghpZjO9S/oMbKK+oXFYYq5koM05GOqff4EWicBxf+ExRcJEAAAA=
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
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

Patch #7 adds RGMII configuration function and uses it.

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
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (7):
      net: sparx5: do some preparation work
      net: sparx5: add function for RGMII port check
      net: sparx5: use is_port_rgmii() throughout
      net: sparx5: use phy_interface_mode_is_rgmii()
      net: sparx5: verify RGMII speeds
      net: lan969x: add RGMII registers
      net: lan969x: add function for configuring RGMII port devices

 drivers/net/ethernet/microchip/lan969x/lan969x.c   | 109 ++++++++++++++++
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |   5 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 +++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   6 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |   3 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 ++++----
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
 8 files changed, 329 insertions(+), 30 deletions(-)
---
base-commit: 157a4881225bd0af5444aab9510e7b6da28f2469
change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


