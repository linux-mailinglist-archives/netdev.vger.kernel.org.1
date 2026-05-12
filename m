Return-Path: <netdev+bounces-286945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7HqJJrGtAmpTvgEAu9opvQ
	(envelope-from <netdev+bounces-286945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E549751995C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658F5301E5A0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C52F9984;
	Tue, 12 May 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pbz1IkRo"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501841754;
	Tue, 12 May 2026 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560430; cv=none; b=cH66SNpgLgO9uGmBCUIpxLN9COHMmb+UbljRoEGbIwLgVC+C315WcVzr1sZHYd1clEMXdYGQ/DZXQt9dG0V5/gaxt5Pbu0tqZ+ejZEmiVo31cWGZB/7J++Swlr/fDe7eFNcKSVnBPiu9Q7YL5T0vBHHdMn4RA/uMhIpBgPIiCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560430; c=relaxed/simple;
	bh=MWhaDdak5r98qO1rolBpIOh2PBCTRceavWLUZ9x9mwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZnuyDNf8b96WwQsq2rHFkmCbK7lTXjyMeIXn41BbZ8r6TkmFwPwRbsn3nbR6FDVb3rRbf4BN1HDU0VZRbCw3nKCk1HEich/AwFPnMMIOUVo2XEYT90KL+65aBrrlGEucbIunkuH0/Q/iaD0jXwAn87/6Qwnwv9YNmmQnYzo+mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pbz1IkRo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778560426;
	bh=MWhaDdak5r98qO1rolBpIOh2PBCTRceavWLUZ9x9mwc=;
	h=From:Subject:Date:To:Cc:From;
	b=pbz1IkRoxHMmyP/RE7fwIQLtsXRqGR54tiKENMif+OLYz+4D06l5aJ7Fv4L6hnrkP
	 sqJDpqR2Lsqg75FbLHSM7yqeDj++jgMFk46o3FQY6sNSDvPsnExUShQxvazgem7RSb
	 PEHyIegYT7IAMJliv5jGy4vrmYpfJITp7XU6O0CkAUVB+r3fDiDCvhwx64bnDDY040
	 /ygu7jZ8Y0Ay4Rq6JUfV4SGBGYgwUHPc77zPvN+g2iJI7cwxQNmQFjFu1ceXT1H8c0
	 NA6ZdLjEAzoNXJQkxBNXh78MxhizGHQMOoimOCOFEHsgpn7MOzFNYNLydTScyrE0t5
	 guEUDwbtkd9AQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91F0417E138B;
	Tue, 12 May 2026 06:33:45 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v3 0/6] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
Date: Tue, 12 May 2026 06:33:17 +0200
Message-Id: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PPW7DMAwF4KsYmquC+rWdqfcoOlASXQtILFdSj
 BSB717BzVB0yEg88OPjnRXKkQo7dXeWaYslpqUN6qVjfsblk3gMbWYSpAUFimMIHGNOM3JchgE
 EL9d1Tbly0wejNWqcKLC2v2aa4u2w39lClS90q+zjN8n0dW3H6iN2WIj7dLnEeuqs6o2AcTQgg
 4AJEK1zyshekbHeDADea1J4WHMsNeXv44FNHNijq37SdRMcOCBpIoNyGsObT+czupTxtdU45E3
 +0aR9psmmCdQyWGfBwPRf2/f9B53aGStqAQAA
X-Change-ID: 20260303-add-airoha-an8801-support-57d544a4afed
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778560425; l=6457;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=MWhaDdak5r98qO1rolBpIOh2PBCTRceavWLUZ9x9mwc=;
 b=MCT/Uk6d/XTnHRWJ7I81wDSbc/QuFA8e74dVkyCR+SbWOCllj7CPBvnWPGRAEXv6nYZ+ibK+o
 pVpKy1u7SKMAj+eLZP5WUQVLtByJabsKtjElWE9CfpT6HN0wfiCRvxb
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Queue-Id: E549751995C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[148.251.105.195:received,100.90.174.1:received,100.64.0.131:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url]
X-Rspamd-Action: no action

This series introduces the Airoha AN8801R Gigabit Ethernet PHY initial
support.

The Airoha AN8801R is a low power single-port Ethernet PHY Transceiver
with Single-port serdes interface for 1000Base-X/RGMII.
This chip is compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE
802.3(u,ab) and supports:
  - Energy Efficient Ethernet (802.3az)
  - Full Duplex Control Flow (802.3x)
  - auto-negotiation
  - crossover detect and autocorrection,
  - Wake-on-LAN with Magic Packet
  - Jumbo Frame up to 9 Kilobytes.
This PHY also supports up to three user-configurable LEDs, which are
usually used for LAN Activity, 100M, 1000M indication.

The series provides the devicetree binding and the driver that have been
written by AngeloGioacchino Del Regno, based on downstream
implementation ([1]). The driver allows setting up PHY LEDs, 10/100M,
1000M speeds, and Wake on LAN and PHY interrupts.

Since v2, the series also adds the air_phy_lib library, which goal is to
share common code between air_en8811h and air_an8801 drivers, and its use
in them. The first shared functions are the existing BuckPbus register
accessors and air_phy_read/write_page functions coming from air_en8811h
driver.

The series is based on net-next kernel tree (sha1: 63751099502d) and
I have tested it on Mediatek Genio 720-EVK board (that integrates an
Airoha AN8801RIN/A Ethernet PHY) with early board hardware enablement
patches.

[1]: https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v6.6/drivers/net/phy/an8801.c

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Changes in v3:
- Rebased on net-next (7e0cccae6b45)
- Updated patch 1 to describe the function-enumator property for the
  LEDs and its possible values
- Modified patch 2 to add missing includes in air_phy_lib source and
  header files
- Split patch 3 in two so that the api call renames in air_en8811h
  driver is done in a separate patch
- Simplified return code handling in several functions
- Fixed return code handling in several functions detected by AI
  peer-reviews (netdev-ai or sashiko)
- Added additional interrupt enabled check before enabling/disabling 
  link changed interrupt in an8801r_suspend/resume callbacks
- Fixed register mask for GPIO LED selection register in
  an8801r_led_init function
- Fixed potential uninitialized variable in an8801r_led_polarity_set
  function
- Fixed LED blink register settings in an8801r_led_blink_set function
- Split an8801r_read_status function implementation in a separate patch
  as requested and add comment to describe why the link mode register
  needed to be modified after reading the link speed.
- Link to v2: https://lore.kernel.org/r/20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com

Changes in v2:
- Rebased on net-next (d1e59a4697371)
- Fixed dt-bindings to remove the leds property from the required ones and
  add wakeup-source as valid property
- Added new reviewed-by trailer for dt_bindings
- Added new patches (2 and 3) to create air_phy_lib, to share common code
  between air_en8811h and air_an8801 drivers and use it in air_en8811h.
- Remove custom BuckPBus register accessor functions and definitions from
  air_an8801 and use the ones from air_phy_lib. It also fixes a build
  issue on v1 due to an uninitialized variable used in
  __air_buckpbus_reg_read, that is now removed from driver code
- Added air_an8801_probe function to allocate the newly added private
  data structure and detect if the PHY is wakeup capable and the interrupt
  can be registered as a wakeup IRQ, and perform the needed actions
- Added an8801r_suspend and an8801r_resume functions to perform specific
  actions when WoL is enabled (reset its status, enable/disable the Link
  Changed interrupt) and call the genphy_suspend/resume functions if
  needed
- Modified an8801r_get_wol to return WoL is not supported if the PHY
  device is not wakeup capable
- Modified an8801r_set_wol to return EOPNOTSUPP error code if the PHY
  device is not wakeup capable, and to update the wakeup flag according
  to WoL mode
- Modified an8801r_config_init to remove EEE disabling and replace
  __phy_write use by phy_write_paged
- Reworked an8801r_rgmii_delay_config and its subfunctions to fix a
  double return use in PHY_INTERFACE_MODE_RGMII_ID case, replace the
  magic value use for default TX and RX delay and handle better the
  enable/disable the inserted delays for all RGMII modes
- Merged an8801r_did_interrupt function in an8801r_handle_interrupt
- Modified the an8801r_handle_interrupt processing to process differently
  the Magic Packet (to notify system wakeup) and the Link Changed
  interrupt (to notify PHY state machine)
- Splitted the reset WoL status part from an8801r_ack_interrupt and fix
  an issue that in some random cases made WAKEUP_CTL1 register lose the
  Magic Packet WoL settings
- Modified an8801r_of_init_leds function so it does not return an error
  if the leds configuration is not present in devicetree
- Removed feature field and add PHY_ALWAYS_CALL_SUSPEND flag in
  airoha_driver data structure

- Link to v1: https://lore.kernel.org/r/20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com

---
AngeloGioacchino Del Regno (2):
      dt-bindings: net: Add support for Airoha AN8801/R GbE PHY
      net: phy: Introduce Airoha AN8801/R Gigabit Ethernet PHY driver

Louis-Alexis Eyraud (4):
      net: phy: Add Airoha phy library for shared code
      net: phy: air_phy_lib: Factorize BuckPBus register accessors
      net: phy: Rename Airoha common BuckPBus register accessors
      net: phy: air_an8801: ensure maximum available speed link use

 .../devicetree/bindings/net/airoha,an8801.yaml     |   85 ++
 drivers/net/phy/Kconfig                            |   12 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/air_an8801.c                       | 1119 ++++++++++++++++++++
 drivers/net/phy/air_en8811h.c                      |  316 +-----
 drivers/net/phy/air_phy_lib.c                      |  212 ++++
 drivers/net/phy/air_phy_lib.h                      |   39 +
 7 files changed, 1527 insertions(+), 258 deletions(-)
---
base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
change-id: 20260303-add-airoha-an8801-support-57d544a4afed

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


