Return-Path: <netdev+bounces-290271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOUFOv3ADmrXBwYAu9opvQ
	(envelope-from <netdev+bounces-290271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 067635A0F6C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A169301155B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC135E1C8;
	Thu, 21 May 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DZ1AUFDZ"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B53624B2;
	Thu, 21 May 2026 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351764; cv=none; b=uyU82jcyLAevZuTTHUKP8vbRj2oNFRZbJLNr7MBJ0sfvUkXjapfZJQHrD7NyfBENRBXn6lFgZr2qS/AszNFCTIPW1NdhHRnABMCHMXOAxfJEeI1DRkYSv0j8h1GCJDC70fHbWoCwrsD8miy12Cu+fsFAK1Y14bXI+ifEO6JwsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351764; c=relaxed/simple;
	bh=id9lJPyfSluCWG1v7s+8XJ8u/iOKLj6FMKOfglz9ups=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PUM4L7zK7oVcAu24mbFE6na/wsl1YOIT2vIL5gKfmI+SwfwX4Nc0H+jDgwFdq+pxzrdsXwgCW4uGslYjTaV9xYQpD/XlMdeVRL5pQL5BRSqpYA/osOzYjqEmj/nnjY8H2Au3ju5kXu/gJuo4EeNRGgiN6fcEcmOgMrrPTL//5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DZ1AUFDZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779351752;
	bh=id9lJPyfSluCWG1v7s+8XJ8u/iOKLj6FMKOfglz9ups=;
	h=From:Subject:Date:To:Cc:From;
	b=DZ1AUFDZDuff1FRxszSwe2QinUKngJ+hJ/bu7uesd5XJwxFIqXMgAzzniP4rim8/A
	 XK3FZZhnxB2KEbJ/mxJInjybgiZ4rpJWeQ1Zx5zy0WGF2lHCL81c4US9hgnJE12Ap5
	 M5IWFwNxK7fEG6+Y1bceu8utexf6lFoPJ+FB3sYX2Ox4yWxMGrJgZlB3ia38BQnlGU
	 qeFZmZAW2iLjgnTTUHyOBBJ2R/rZu0MS65eLJebsU8tiVkTvRyTomDeArHcIN+7L1a
	 6gwZtyqcQ5WmjbzW38I1rg1lMOsOxxbfPmhQl4hv01bZRdPRfcBdjUoL/0zgfJZ+ed
	 ONKPyXGbsmQVw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA01017E091C;
	Thu, 21 May 2026 10:22:30 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v4 0/6] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
Date: Thu, 21 May 2026 10:21:53 +0200
Message-Id: <20260521-add-airoha-an8801-support-v4-0-1e4837d30ef4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTU7DMBAF4KtEXjPI/wldcQ/EYhJPiKU2DrYbt
 apy9xpTCYRQlqOZ9827sUTRU2KH5sYirT75MJdBPzVsmHD+IPCuzExyabniCtA5QB/DhIBz13E
 B6bwsIWYwrTNao8aRHCv5JdLoL9V+YzNlmOmS2fv3JtLnuTzLj3WPiWAIp5PPh6ZT3HVtK5DUU
 O8nn3KI11pyFTXw6KN3+qwCOHAkTWRQji/udQjHI/Yh4nN5VeVV/tKk3dNk0QRq6WxvueHjf5r
 60YyQe5r60sj1SpOyCumvtm3bHb2yn/icAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779351750; l=8154;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=id9lJPyfSluCWG1v7s+8XJ8u/iOKLj6FMKOfglz9ups=;
 b=sHz8PXzzQRETATuaB2kHkBNTdMIbdJ+mzqEgau8XE3uKWRLvTcS1RQ3/QWfElAl3/3c1Dw6aW
 YPsiqGTh4JPARr+hMGvVn6S1KxxbeBlPGLCFKBGCEfNboKW2BpnXiC/
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290271-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gitlab.com:url,sashiko.dev:url,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: 067635A0F6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

The series is based on net-next kernel tree (sha1: 830d8771ae3c) and
I have tested it on Mediatek Genio 720-EVK board (that integrates an
Airoha AN8801RIN/A Ethernet PHY) with early board hardware enablement
patches.

[1]: https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v6.6/drivers/net/phy/an8801.c

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Changes in v4:
- Rebased on net-next (830d8771ae3c)
- Added in patch 1 the missing function-enumator property description,
  that should already have been present in v3
- Modified patch 1 and patch 5 subjects to use AN8801R and not AN8801/R
  (detected by sashiko-nipa)
- Modified patch 3 to add missing wordpath.h include (detected by
  sashiko.dev)
- Modified patch 5 to use NSEC_PER_MSEC definition instead of hardcoded
  value in an8801r_led_blink_ms_to_hw
- Removed unnecessary RGMII_DELAY_STEP_MASK mask operation in
  an8801r_rgmii_rxdelay and an8801r_rgmii_txdelay
- Removed extra empty line in an8801r_led_hw_control_set
- Improved AN8801_RGMII_TX/RXDELAY_DEFAULT definition comments 
- Fixed inverted GENMASK arguments in AN8801_WAKE_OUT_WIDTH
  definition (detected by sashiko-nipa)
- Fixed possible overflow when writing LED_BLINK_DUR register value
  in an8801r_led_blink_set (detected by sashiko-nipa and sashiko.dev)
- Modified the an8801r_handle_interrupt to allow the WAKE_MAGICPKT and
  WAKE_LNKCHG interrupts handling in the same call
  (detected by sashiko-nipa and sashiko.dev)
- Add extra check in an8801r_set_wol to reject unsupported modes
  (detected by sashiko-nipa)
- Fixed supported led trigger detection in an8801r_led_trig_to_hw
  (detected by sashiko.dev)
- Fixed possible uninitialized return value in an8801r_of_init_leds
  (detected by sashiko-nipa and sashiko.dev)
- Modified patch 6 to fix possible cases where the link mode register value
  might not be updated (detected by sashiko-nipa)
- Added new reviewed-by trailers
- Link to v3: https://lore.kernel.org/r/20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com

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
      dt-bindings: net: Add support for Airoha AN8801R GbE PHY
      net: phy: Introduce Airoha AN8801R Gigabit Ethernet PHY driver

Louis-Alexis Eyraud (4):
      net: phy: Add Airoha phy library for shared code
      net: phy: air_phy_lib: Factorize BuckPBus register accessors
      net: phy: Rename Airoha common BuckPBus register accessors
      net: phy: air_an8801: ensure maximum available speed link use

 .../devicetree/bindings/net/airoha,an8801.yaml     |  116 ++
 drivers/net/phy/Kconfig                            |   12 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/air_an8801.c                       | 1144 ++++++++++++++++++++
 drivers/net/phy/air_en8811h.c                      |  316 +-----
 drivers/net/phy/air_phy_lib.c                      |  213 ++++
 drivers/net/phy/air_phy_lib.h                      |   39 +
 7 files changed, 1584 insertions(+), 258 deletions(-)
---
base-commit: 830d8771ae3c7bc90a62dde76a6556e612529fbc
change-id: 20260303-add-airoha-an8801-support-57d544a4afed

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


