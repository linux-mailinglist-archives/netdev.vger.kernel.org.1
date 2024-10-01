Return-Path: <netdev+bounces-130890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E508498BE6F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8EE1C23C56
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01811C57BC;
	Tue,  1 Oct 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BCGcDjs9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BD17C9E;
	Tue,  1 Oct 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790688; cv=none; b=IxJf2RWQRkemjcI5kEDZzr5MbDkeA8Yqb/+ehYY81XQbUO1xPAAwRORgIATRuNWq0SZj4ygUC41hlPxGcFTXLaqVoRLRkL12R/yeGJKNOgpbnyPELdtt1j8CmE1a17kezCdKSj8MiMer83xo+jK8D7VJyRMeAzVEDM3wqc2tKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790688; c=relaxed/simple;
	bh=3M+QtmIsCGyib62lW2XLY2EtmomiGuLWz3+4DYGzV0E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MEAcMfBgGHki6d3cnH/a2RSwNjtA0PpD+hXxB1dcnJTvnjtjXUbsXZ6xrrRzR75N9DxtOQhlamjzXwMuZ3eXgfpgH7YtT568gDhEVmYTKDoM8GR6BU1THY4lUyGfmGN8c9jicIcVY13JsAPsWx30tTdhuKbiFOW7/1dv9Lubu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BCGcDjs9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790686; x=1759326686;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=3M+QtmIsCGyib62lW2XLY2EtmomiGuLWz3+4DYGzV0E=;
  b=BCGcDjs9IrnphHVUSr6lJh/uaiNyFHo4d/XQ0kWYhimHiY2gFr2Y4raJ
   QYXlS+86Yi+qq3Fs3SYqV+wMf4j/7Xtq4Z8fetGKpvE3IPkVt1Z1rf52B
   bAAlJxJw9wZQlYGdJGzqCZIEhpi1gSpo1fW/hAd/92Gljoeru37Y4u1Kr
   me0Rz0Ga832HncGpUl6JBPhH+qJZUyW9DzSguYfd4H3s6qJx53Kix43yj
   OlXr87XEb67N5xSEG6xENPSZDHAAuSHQ6q/PGUIKxLD/absY0Igdx0lIi
   X08QwJSIcBU91vm97WLRe0k2wwJmlhRDtLUsyIk1YO/riXirtu4A78TQi
   A==;
X-CSE-ConnectionGUID: xZlwFxFMQxGj0XznyNUoig==
X-CSE-MsgGUID: 4duBAORFSXWE8c3OiqWikg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057479"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:50:59 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:50:56 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 00/15] net: sparx5: prepare for lan969x switch
 driver
Date: Tue, 1 Oct 2024 15:50:30 +0200
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACb++2YC/x2N0QrCMAwAf2Xk2UAtm2X+iviQtZkNaBzpmIWxf
 7f6eBzc7VDYhAtcux2MNyny1gbnUwcxkz4YJTUG73zvRh9w6rEsZHXAJ+l4GSuWj6wxYzLZ2DD
 NMQ0+hJmCg1ZZjGep/8MNlFdUrivcm5moME5GGvPv8CJROI4vq2ZDlZIAAAA=
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

== Description:

This series is the first of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts is split into multiple series (might change a
bit as we go along):

    1) Prepare the Sparx5 driver for lan969x (this series)
    2) Add support lan969x (same basic features as Sparx5 provides +
       RGMII, excl.  FDMA and VCAP)
    3) Add support for lan969x FDMA
    4) Add support for lan969x VCAP

== Lan969x in short:

The lan969x Ethernet switch family [1] provides a rich set of
switching features and port configurations (up to 30 ports) from 10Mbps
to 10Gbps, with support for RGMII, SGMII, QSGMII, USGMII, and USXGMII,
ideal for industrial & process automation infrastructure applications,
transport, grid automation, power substation automation, and ring &
intra-ring topologies. The LAN969x family is hardware and software
compatible and scalable supporting 46Gbps to 102Gbps switch bandwidths.

== Preparing Sparx5 for lan969x:

The lan969x switch chip reuses many of the IP's of the Sparx5 switch
chip, therefore it has been decided to add support through the existing
Sparx5 driver, in order to avoid a bunch of duplicate code. However, in
order to reuse the Sparx5 switch driver, we have to introduce some
mechanisms to handle the chip differences that are there.  These
mechanisms are:

    - Platform match data to contain all the differences that needs to
      be handled (constants, ops etc.)

    - Register macro indirection layer so that we can reuse the existing
      register macros.

    - Function for branching out on platform type where required.

In some places we ops out functions and in other places we branch on the
chip type. Exactly when we choose one over the other, is an estimate in
each case.

After this series is applied, the Sparx5 driver will be prepared for
lan969x and still function exactly as before.

== Patch breakdown:

Patch #1     adds private match data

Patch #2     adds register macro indirection layer

Patch #3-#5  does some preparation work

Patch #6-#8  adds chip constants and updates the code to use them

Patch #9-#14 adds and uses ops for handling functions differently on the
             two platforms.

Patch #15    adds and uses a macro for branching out on the chip type

[1] https://www.microchip.com/en-us/product/lan9698

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: horatiu.vultur@microchip.com
To: jensemil.schulzostergaard@microchip.com
To: UNGLinuxDriver@microchip.com
To: Richard Cochran <richardcochran@gmail.com>
To: horms@kernel.org
To: justinstitt@google.com
To: gal@nvidia.com
To: aakash.r.menon@gmail.com
To: jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (15):
      net: sparx5: add support for private match data
      net: sparx5: add indirection layer to register macros
      net: sparx5: rename *spx5 to *sparx5 in a few places
      net: sparx5: modify SPX5_PORTS_ALL macro
      net: sparx5: add *sparx5 argument to a few functions
      net: sparx5: add constants to match data
      net: sparx5: use SPX5_CONST for constants which already have a symbol
      net: sparx5: use SPX5_CONST for constants which do not have a symbol
      net: sparx5: add ops to match data
      net: sparx5: ops out chip port to device index/bit functions
      net: sparx5: ops out functions for getting certain array values
      net: sparx5: ops out function for setting the port mux
      net: sparx5: ops out PTP IRQ handler
      net: sparx5: ops out function for DSM calendar calculation
      net: sparx5: add is_sparx5 macro and use it throughout

 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |   41 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |    5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   33 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |    6 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |    6 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  198 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  111 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 4128 +++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |    8 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    |   24 +-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   71 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   23 +-
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |   45 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |    6 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |    8 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  219 ++
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  244 ++
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |   15 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   53 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |    8 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   44 +-
 25 files changed, 3191 insertions(+), 2118 deletions(-)
---
base-commit: 3a39d672e7f48b8d6b91a09afa4b55352773b4b5
change-id: 20240927-b4-sparx5-lan969x-switch-driver-dfcd5277fa70

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


