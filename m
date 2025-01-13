Return-Path: <netdev+bounces-157866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2186A0C1A8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065611658F7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783B1CD213;
	Mon, 13 Jan 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ufr3NXF0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BB1CBE94;
	Mon, 13 Jan 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797013; cv=none; b=Fw+utkNciXSv4YjjKRl9l6MqEIHJiK37SDkGu0XhlRe0Vr8CtATcFkOv858viSwzTyFxymnlyhRHkmdx1EPr7ZrjIal+d60u5NW4Dspgxxlloj67+exoEnK7iP/8Hbwefrjb3l14Wh9ng616u9SrUQfuzJl9iqW3/d0tjU/2ECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797013; c=relaxed/simple;
	bh=ZBgcmgeXhqAq+4It4G7OLJFKW5gmvl7N+d8m/V4d8qg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EnbGSjhJzt8N6+0fdYY+6wxY0kk0jVBZTKxaouaBvepXpd0GbdnDBN36Ml8vdpvpuin4M+6Qvb/Sl6FHM8sU34rmZX2zGy1KrHmXR6ZCErq1b1PtG4cKZu72lvya66D0KPFTZVb+oB9dzKOs/vDofwk0q3xzMnLMdqXlq0u1YCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ufr3NXF0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736797012; x=1768333012;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ZBgcmgeXhqAq+4It4G7OLJFKW5gmvl7N+d8m/V4d8qg=;
  b=Ufr3NXF03Cv6J0ZzyRvYu8xD41/o2rM8FZEore0ajj50F3gFBU7baRHy
   XmHsR5t/8giEF9DG7IzGzfP68QrGfzdbLwmO2DWbXbEgnR1JLxjmqssXo
   EJHxIgYPYr6J50XedjS9Yxn2lke2PK88beRgs2A2egvp9EXgTmvTZFDNA
   PanOoN8Ig9TUhTNm0aRAmr+92ARrBNL3AVvEfggxKHO79uOS8JT3S4Hv4
   D4Q14SEdq3PttuWnBXaIXJeyXiFyGSYwzo/uRm4XbvEImiCd6+jUHrf9z
   QficYrrL9SkkYPA5Tu0iIWvqrhrgRHhiIabnt67ToeIS3uB/r6TAe4m2B
   w==;
X-CSE-ConnectionGUID: 4DuCEr1pTqyIbpjtrGnA+g==
X-CSE-MsgGUID: 7KULwLI4Qqa/5V2pjNyVxg==
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="267757600"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 12:36:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 12:36:19 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 Jan 2025 12:36:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/5] net: lan969x: add FDMA support
Date: Mon, 13 Jan 2025 20:36:04 +0100
Message-ID: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRrhWcC/4WOwQ6CMBBEf8Xs2TUUaAOe/A/DoZTVbiKFbAliC
 P9uId49TiZv3qwQSZgiXE8rCM0ceQgp5OcTOG/Dk5C7lCHPcp2pzGAcrSwaXzbUpl4wvnlyHjv
 hmQQ16tyWhlyry6qCNDIKPXg5BHcINGGgZYImNa2NhK3Y4Pwu6C2HHfAcp0E+x6FZHdjPXf9zz
 wozVEVnuqrUikxx69nJ4DyPFzf00Gzb9gWMCa0v8QAAAA==
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

== Description:

This series is the last of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts has been split into multiple series:

        1) Prepare the Sparx5 driver for lan969x (merged)

        2) Add support for lan969x (same basic features as Sparx5
           provides excl. FDMA and VCAP, merged).

        3) Add lan969x VCAP functionality (merged).

        4) Add RGMII support (merged).

    --> 5) Add FDMA support.

== FDMA support:

The lan969x switch device uses the same FDMA engine as the Sparx5 switch
device, with the same number of channels etc. This means we can utilize
the newly added FDMA library, that is already in use by the lan966x and
sparx5 drivers.

As previous lan969x series, the FDMA implementation will hook into the
Sparx5 implementation where possible, however both RX and TX handling
will be done differently on lan969x and therefore requires a separate
implementation of the RX and TX path.

Details are in the commit description of the individual patches

== Patch breakdown:

Patch #1: Enable FDMA support on lan969x
Patch #2: Split start()/stop() functions
Patch #3: Activate TX FDMA in start()
Patch #4: Ops out a few functions that differ on the two platforms
Patch #5: Add FDMA implementation for lan969x

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Dropped patch 4/6. Added a conditional check in 5/5 instead. This
  check makes sure SKB's are not freed in xmit() on lan969x, but rather
  the TX completion loop.

- Added 'struct net_device' to xmit() prototypes.

- Removed duplicate dcb_reload in NAPI poll loop 

- Link to v1:
  https://lore.kernel.org/r/20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com

---
Daniel Machon (5):
      net: sparx5: enable FDMA on lan969x
      net: sparx5: split sparx5_fdma_{start(),stop()}
      net: sparx5: activate FDMA tx in start()
      net: sparx5: ops out certain FDMA functions
      net: lan969x: add FDMA implementation

 drivers/net/ethernet/microchip/sparx5/Kconfig      |   1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   4 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   7 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 406 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  68 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  19 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  32 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  11 +-
 9 files changed, 518 insertions(+), 33 deletions(-)
---
base-commit: 7d0da8f862340c5f42f0062b8560b8d0971a6ac4
change-id: 20250106-sparx5-lan969x-switch-driver-5-52a46ecb5488

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


