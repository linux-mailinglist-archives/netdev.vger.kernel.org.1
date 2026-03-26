Return-Path: <netdev+bounces-272006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCy6BFoixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CB334FD9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E743010B94
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF973C344E;
	Thu, 26 Mar 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f4wEmmvT"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86A34C81E;
	Thu, 26 Mar 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526733; cv=none; b=nQndLnyr5kImcJrfXLE1Ofj41zUq7fTGEEtWInWwxpBmBzLLvIs1tNvQfGP5AV7/QLBuzi/2ZgLsIprlemk7guFUYgyLwy5w9wnufvWt0vnpiYcDDGjneggoD7XEr2Zd+2BlSCsKR0LgxD133herUy0K/3YiCF0Y9z1k0MJbdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526733; c=relaxed/simple;
	bh=WsRvRfGS7kj5nGC1UujX10ZyLUt0WSnoAgn65iDtQRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WWNdYzga61NuijteKeNC6XhH69fB5bJPPNH9vvFV1Us9FdsG33f34YATWG7UDWRnMvr7G7QD8V+oSB8leA6cbzgNTXKAcvkZEN00c6d9F0BpdCVmXG2RXPbqCelx7hqtX7oKGKVJwS9QVN2NBYeCOtWpy6vkaEOlnir28Vhi19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f4wEmmvT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774526730;
	bh=WsRvRfGS7kj5nGC1UujX10ZyLUt0WSnoAgn65iDtQRo=;
	h=From:Subject:Date:To:Cc:From;
	b=f4wEmmvTNTYbeWgKquj3lxcRdCX8ihgdjkvREWueMDki1YzMMpPUxLkHa1xzsdWqV
	 K+0T1DE7qDoxINbbVnjFF+wohMMkgQKrelko0uwrYR7FLXxSf40dWZ4WLhmoVgUaG8
	 9Q/GC7GjAxsTDxEEJodPVevOBWXWqI38kkmkkFOMx07BksCIS0BukgNZuLTF8weuM3
	 DgxrojUj8ym+iHSlrqtlVqDU/AuEfiyBpAGaaDg/d4mcgqVt/A88lfsFxiKAZwtWDv
	 8hAVdzSPIOIGsPwjnYZ6GeBpqG7sXB2suXJeaaJ0w6ra5YKnNkB2lqXkMnxNxnlVOp
	 e+JmDprY5mTTw==
Received: from yukiji.home (lfbn-idf1-1-2269-27.w92-151.abo.wanadoo.fr [92.151.67.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E2DB217E607F;
	Thu, 26 Mar 2026 13:05:29 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next v2 0/4] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
Date: Thu, 26 Mar 2026 13:04:11 +0100
Message-Id: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Pwa6CMBBFf4V07by00FJw5X+8uBiYQZpoi20lv
 hj+3QZdv+XNzZx75iUSR8dJHKuXiLy65IIvoT5UYpzRXxgclSxqWbeykQ0gEaCLYUZA33VSQXo
 sS4gZjCWjNWqcmES5XyJP7rmzf4XnDJ6fWZw/TeT7o4zlbz1gYhjD7ebysSLFpkfd9raxqmdtu
 oFH25GURLa1ZNEOaNW0s2aXcoh/+wOr2mFfV/2P66pAgkTWzAbrqafTGK5XHELEn6Ihztu2vQH
 lV++RHAEAAA==
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774526729; l=5132;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=WsRvRfGS7kj5nGC1UujX10ZyLUt0WSnoAgn65iDtQRo=;
 b=J1uYoT2YSzWNSMzFuYWO8ua1BGrBYOvu2zwx3Juhqu93tsWeBJMU9kEHtMSBQPDHysJNNcFyn
 mB68hODK5UfBcir5Lz5aOz5TeDxjPRm7e/0WzesdZjiRN4wjOBNUi88
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272006-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,collabora.com:dkim,collabora.com:email,collabora.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE2CB334FD9
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

The series is based on net-next kernel tree (sha1: d1e59a4697371) and
I have tested it on Mediatek Genio 720-EVK board (that integrates an
Airoha AN8801RIN/A Ethernet PHY) with early board hardware enablement
patches.

[1]: https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v6.6/drivers/net/phy/an8801.c

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
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

Louis-Alexis Eyraud (2):
      net: phy: Add Airoha phy library for shared code
      net: phy: air_phy_lib: Factorize BuckPBus register accessors

 .../devicetree/bindings/net/airoha,an8801.yaml     |   85 ++
 drivers/net/phy/Kconfig                            |   12 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/air_an8801.c                       | 1115 ++++++++++++++++++++
 drivers/net/phy/air_en8811h.c                      |  316 +-----
 drivers/net/phy/air_phy_lib.c                      |  210 ++++
 drivers/net/phy/air_phy_lib.h                      |   37 +
 7 files changed, 1519 insertions(+), 258 deletions(-)
---
base-commit: d1e59a46973719e458bec78d00dd767d7a7ba71f
change-id: 20260303-add-airoha-an8801-support-57d544a4afed

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


