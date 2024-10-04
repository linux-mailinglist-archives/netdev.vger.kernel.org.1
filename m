Return-Path: <netdev+bounces-132043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD969903EA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0BD1C20EBA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA562141D2;
	Fri,  4 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kE2d4ug5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467EC2141A0;
	Fri,  4 Oct 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048036; cv=none; b=eU8tQyrY9jBBcq9gX2HX+gOxUdDw9KoHeBFpIkXIH/y1wbiEEJLd1eBJAg7sN76TidOjPppa2zbImXy2bUjFXnB2iL7cSThEoqt32VHiGzJ0ps4PO08tURhvv6BXzFsDYEEmXYx7RiF61Pyj+pr+ixIwJXmvwmJ7fsL1UceI+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048036; c=relaxed/simple;
	bh=dMlQpXZxmtYu9oYAJGj42LF3x9VRU4K35wpBuxaERJs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Plb5uZwq8raDgMbxaIUyFbrNn06xbGXAM3DxrDds/EI+UeEzbCr2s1uyneG+IYlZ4sj0213OwR2Blm36F74RgSiWX7/1xG0T2YEyGEvxkyVP0tU3JdHXsdU0BMimgTd7FU0/YInB7JIFObql2Baux802a9iU3T1Xm7Cp/rXRmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kE2d4ug5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048034; x=1759584034;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dMlQpXZxmtYu9oYAJGj42LF3x9VRU4K35wpBuxaERJs=;
  b=kE2d4ug5WubR9EQBs9m8W78BJKXTdvQXzmMGa83ppC9aSOjZWIOS0lfO
   VSe7XFdcrRojIMttz+G86yhxqYfQTpmP7F0+xHagN82VvUcdyhw2YOO4B
   u/sDEFgQ7rs/Rm+S1VReoCKkujj3yyeGfWCd7u5bZgWAvzmIt5y21VXby
   8V0bltJ+ylDmHob0ZZ0mwKM16rRsbPEByanaRXzSqIBcbriRyPjQUut7s
   ZB+1mAKklo+uyGMgau5Vb8I6K+Qp5t78JHQQ0Nd2CrXZsqJpQmZNPQHd+
   G9R2p8pccCWbwDcSl6ukWruPNruwUBFxMU7gGnm50J5PqU4O1SV4bqnfo
   A==;
X-CSE-ConnectionGUID: wYEhTCIITtS2MLde76jJ4w==
X-CSE-MsgGUID: M/y/7YsLSOiN6GF6kCG5Sg==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602241"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:02 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:19:59 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 00/15] net: sparx5: prepare for lan969x switch
 driver
Date: Fri, 4 Oct 2024 15:19:26 +0200
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7r/2YC/4WOQQ6CMBBFr2Jm7ZjSaBFX3sOwKNPBTiKFTAliD
 HcXuIDLn5/33/9CZhXOcDt8QXmSLH1agz0egKJPT0YJawZr7NlUtsTmjHnwOl/w5VPlqhnzW0a
 KGFQmVgwthYsty9aXBtaVQbmVeTc8IPGIiecR6rVpfGZs1CeKm6HzkjYgSh57/eyPpmLHNnlhT
 PFXPhVo8EruWrk2EDt374S0pyjDifoO6mVZfmxaO6nzAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
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

Patch #1        adds private match data

Patch #2        adds register macro indirection layer

Patch #3-#4     does some preparation work

Patch #5-#7     adds chip constants and updates the code to use them

Patch #8-#13    adds and uses ops for handling functions differently on the
                two platforms.

Patch #14       adds and uses a macro for branching out on the chip type.

Patch #15 (NEW) redefines macros for internal ports and PGID's.

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
To: ast@fiberby.net
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:

  Version 2 primarily handles the dropped SPX5_CONST() macro. Now
  functions access the constants directly using the sparx5->data->consts
  variable. This has the side-effect of dropping one patch, which is no
  longer required (#3 in v1), and adding a new patch that handles internal ports
  and PGID's (patch #15 in v2).

- Removed the SPX5_CONST macro and the use of it from patches #6, #7 and
  #8 in v1.

- Removed GADDR(), GSIZE() etc. macros from sparx5_main_regs.h. Instead
  the macros access the regs variable directly.

- Patch #3 in v1 is dropped (no need to rename spx5 to sparx5 anymore)

- Added patch #15 in v2. This patch changes the internal port and PGID
  values to be offsets and adds helpers to get them.

- Added the Reviewed-by tag of Jacob Keller to certain patches.

- Link to v1: https://lore.kernel.org/r/20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com

---
Daniel Machon (15):
      net: sparx5: add support for private match data
      net: sparx5: add indirection layer to register macros
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
      net: sparx5: redefine internal ports and PGID's as offsets

 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |   56 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |    5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   34 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   10 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  228 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  130 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 4469 +++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    8 +-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   76 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   23 +-
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |   49 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   44 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |    8 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  219 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  244 ++
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |   15 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   33 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |    8 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   47 +-
 26 files changed, 3531 insertions(+), 2226 deletions(-)
---
base-commit: 3a39d672e7f48b8d6b91a09afa4b55352773b4b5
change-id: 20240927-b4-sparx5-lan969x-switch-driver-dfcd5277fa70

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


