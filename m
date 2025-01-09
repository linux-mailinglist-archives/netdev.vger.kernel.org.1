Return-Path: <netdev+bounces-156845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC5A07FEC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EABC7A28E6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BEA1A9B38;
	Thu,  9 Jan 2025 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rQZq5oQK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3313B2B8;
	Thu,  9 Jan 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447903; cv=none; b=D5JBzWqXEGPwnzXPhl7FRYQ7RJbL5PIgXbKctxR0RXnCWF02erhjUlHMc6FFhzx64Xoqdc5K/jnHXn17HXYP2Nf/4NSWUH+I2b6tdFegPCxKLTUaY/HZkiwxUMka6SeXJGF04t+suSq1X2S6ReEkJl4+froTJE/F4TIGtd71c+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447903; c=relaxed/simple;
	bh=3beYjMhSJaOr4cvKfxRV0js+xV1+RIWvdMPbZLdkq1c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=j+Rg42k+y+H+mDsEy2DInw/JUB/uUdPHEoDhWZifxf77Cvbm6+iFzficSRFiqsc4Ut+RLT6IV95ldR7NZz0+U9FkFpjgEYhy0gr/7Fi75dUbXpAFx9m/Iq6uSuXkYepAjcw1Gu7bk6F399qkRcxpSbx9VkfCyYjnT6SmKPaU650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rQZq5oQK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447901; x=1767983901;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=3beYjMhSJaOr4cvKfxRV0js+xV1+RIWvdMPbZLdkq1c=;
  b=rQZq5oQKTbgFxes8VwOKJ2G6KLqXtz2hqFf9nvapkvQ01qnWaHVwhqhs
   +bNUuFekS7BOQDfxM/Og0ogR0kgXy4soza+4c65pTK8SgMCUSpd1w+474
   TdS9cee/LiXtneDYp02cuj18f8lWN2lhgz5O7eHMEpzv45UqSImXO5WrY
   ZwC+5S1R0goMvvXytx8G0v30wb3Zepef1BKGE/oQv8uQ5NM8UTelgtD0f
   MbtUms3PID11kxPMpJ3GWafv2lZm3bh0U1yZxsDJrpzauRUVErfC6JbPU
   LEECqOoayHFCN/85jXVqmluCi9u6IIFQSzoysX05yk83l7EhhSeJKLnoQ
   w==;
X-CSE-ConnectionGUID: lYxo9VQwQ0yequjZYTYLoQ==
X-CSE-MsgGUID: XJ3zDsrzR7OJpunoJAADUA==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007556"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:05 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:02 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/6] net: lan969x: add FDMA support
Date: Thu, 9 Jan 2025 19:37:52 +0100
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAXgGcC/x2N0QqDMAwAf0XyvICKFd2vjD2kNVsDWyZp0YL47
 +v2eBzcHZDYhBNcmwOMN0ny0QrdpYEQSZ+MslSGvu1d27UjppWsOHyRzuNcMO2SQ8TFZGNDh66
 nYeTg3TBNUCOr8UPKf3AD5YzKJcO9Gk+J0RtpiL/Bm0ThPL9aG0HOkQAAAA==
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
Patch #4: Move consumption of SKB's to xmit()
Patch #5: Ops out a few functions that differ on the two platforms
Patch #6: Add FDMA implementation for lan969x

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (6):
      net: sparx5: enable FDMA on lan969x
      net: sparx5: split sparx5_fdma_{start(),stop()}
      net: sparx5: activate FDMA tx in start()
      net: sparx5: move SKB consumption to xmit()
      net: sparx5: ops out certain FDMA functions
      net: lan969x: add FDMA implementation

 drivers/net/ethernet/microchip/sparx5/Kconfig      |   1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   4 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   6 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 408 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  67 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  19 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  28 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |   6 +-
 9 files changed, 510 insertions(+), 32 deletions(-)
---
base-commit: 3e5908172c05ab1511f2a6719b806d6eda6e1715
change-id: 20250106-sparx5-lan969x-switch-driver-5-52a46ecb5488

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


