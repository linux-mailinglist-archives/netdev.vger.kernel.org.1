Return-Path: <netdev+bounces-291731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD8UKu24FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:14:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493085D8766
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6247F30B8772
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB463ADB98;
	Tue, 26 May 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GqlNqL72"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C521638D;
	Tue, 26 May 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807560; cv=none; b=kSQHWifXSi4PYXLxUC3lkgdGG1WDHz2JmBh/F3whgSx9S74zxm5et6KWqdFLlOg9Jg0x7AHUotJwXbUstREGWvMn8IDHsd5/CG2bRLq+BIkiTn50pql1GyKKC/cnkAFR5uv4W6ZMBnny09WNXVevKbajA6r0rkatqSYmc5oL894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807560; c=relaxed/simple;
	bh=iUP6wrb3pFcKOuTBHFbKtXby6NSizpZ3dLcO4teW898=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QBxUOrvOvd3UOQ1/wZJsjQBeFWq3SBRR4hQofK7BM4cDhrh7xEIH0H2Amv9Tyzai9dik92L/xfDEsNHTa2jDltB7Cg8vS2zMPqtEz7du/ofMXsMdzsqC8TTLH834jnPsDXV15+0dWH1OxrwaqsoqdUCABNEddQtRJRxqrd/452I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GqlNqL72; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779807556;
	bh=iUP6wrb3pFcKOuTBHFbKtXby6NSizpZ3dLcO4teW898=;
	h=From:Subject:Date:To:Cc:From;
	b=GqlNqL72FVMbzLr8weNkSLN7zNmZOlSoG+dVwci0m0m6yLXumb28Kq0fNvUmwGHE+
	 CGwSXOcZyx47ffCI2pmXvuwwndOkv5stnKQdgZBvTog19kTPE5aZP9taFjYs7WhPvz
	 LdKorawObBh2ijWzXa+tNf17fKV/vb9w59YQpyjgA8Kzhu4VyCyZhkqNPyspZOODgD
	 LAviJu5hDjltcOsdUcPDje3zGxhzShNqfG+yVE3DnCE1xGI4FTcsq+Ww9GmQ0byV36
	 Pm+lX7XsAgQ6+ctpnrM0iyYSOzKqJY6KXGZ0BilXKB9IPN4ibEbaMfU02p88AzkmXu
	 Y5t2LpjYryrIQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8809E17E0CF3;
	Tue, 26 May 2026 16:59:15 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v5 0/6] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
Date: Tue, 26 May 2026 16:58:05 +0200
Message-Id: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTWrDMBAF4KsYrauin5HjZNV7lC7G1qgWJJYjK
 SYl+O5V1UBDCV4OM++bd2OJoqfEDs2NRVp88mEqg3lp2DDi9Enc2zIzJVQrtNAcreXoYxiR49R
 1QvJ0mecQMzc7awAQ0JFlJT9Hcv5a7Xc2UeYTXTP7+N1EOl/Ks3xf95iID+F08vnQ7IUVmkgNx
 g71fvQph/hVSy6yBu59YKPPIrngAgmIDCq3t29DOB6xDxFfy6sqL+pBU+2WpoomEZRt+1YY4Z5
 p+k8zUm1p+kcj22sg3WqkZxo8aEpuaVA16PTOakEO/mvrun4DcvFq7OoBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779807555; l=9316;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=iUP6wrb3pFcKOuTBHFbKtXby6NSizpZ3dLcO4teW898=;
 b=uzqZUHGFFDeBZNzRubLSNVpsQlA5Ft0SiaPDVDw76xee5k5MByragWyCq7Fj1bMpctGm3irYD
 efsJw+5z6aRBa0NqQWR6rl4WA8qNiT+YFL5ReQx4Qy+/xDhhiSd0Dnf
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 493085D8766
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

The series is based on net-next kernel tree (sha1: 90d03ee2c5dc) and
I have tested it on Mediatek Genio 720-EVK board (that integrates an
Airoha AN8801RIN/A Ethernet PHY) with early board hardware enablement
patches.

[1]: https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v6.6/drivers/net/phy/an8801.c

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Changes in v5:
- Rebased on net-next (90d03ee2c5dc)
- Fixed in patch 1 missing unevaluatedProperties/additionalProperties
  to resolve dt_binding_check issues
- Reworked in patch 5 overflow handling when writing LED_BLINK_DUR
  register value in an8801r_led_blink_set (sashiko-nipa and
  sashiko.dev)
- Reworked an8801r_led_brightness_set to disable blinking first before
  setting led state (sashiko-dev)
- Added led index validity check in an8801r_led_hw_control_get
  (sashiko-nipa)
- Added attached_dev and mac adress validity check in
  an8801r_set_wol (sashiko-nipa)
- Reworked ternary operation syntax to make it more explicit in
  an8801r_led_hw_control_set (sashiko-nipa)
- Removed unused AN8801_LED_DURATION_UNIT_US definition (sashiko-nipa)
- Fixed AN8801_RGMII_RXDELAY_DEFAULT definition comment (sashiko-nipa)
- Fixed typo in an8801r_suspend (sashiko-nipa)
- Removed in patch 6 the speed restore action on an8801_buckpbus_reg_rmw
  error to restore v3 behaviour in an8801r_read_status (sashiko-nipa and
  sashiko-dev)
- Link to v4: https://lore.kernel.org/r/20260521-add-airoha-an8801-support-v4-0-1e4837d30ef4@collabora.com

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

 .../devicetree/bindings/net/airoha,an8801.yaml     |  120 ++
 drivers/net/phy/Kconfig                            |   12 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/air_an8801.c                       | 1156 ++++++++++++++++++++
 drivers/net/phy/air_en8811h.c                      |  316 +-----
 drivers/net/phy/air_phy_lib.c                      |  213 ++++
 drivers/net/phy/air_phy_lib.h                      |   39 +
 7 files changed, 1600 insertions(+), 258 deletions(-)
---
base-commit: 90d03ee2c5dc5f7ee11da90e8eb6868dcbee177b
change-id: 20260303-add-airoha-an8801-support-57d544a4afed

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


