Return-Path: <netdev+bounces-168741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742B2A4071A
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E765F3A4839
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF0207A26;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USvuCD3i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CD1E990D;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=eiYrViSoU+I7QY+FYYLfpk2KVX0KkVANwv+bDUyfpYsSIqXsVlpGO1dUwpol9o7BaFQMoO6wiwmogv8sMnOkua1poTWusuN8P5H+LYTPrSW7Fx+gVUfVrvzRrbrFisFGMXOdgOtLc1jwvfzh1Z+rzqov/cmRPv14ReW57hd6x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=rpBgNJ8tgnDrWZnhBR0r6ELzBvy/EYm7qgnjIHEZaR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dJo1hmL7GLoM0Juo2kRda5clZH5L6uvVNGZT22yaI/WbxCP73Vr2xPVjgXlHykU1M2F6o1kyY2MssQa7DjYSWRHLe+7tvQ+dewDsJWYdDZKAVv600rmiw5YgtaDVqdmNnS9xHEiSpn3Ig9ItRofFaPX3YZ8fuRZr6LIYKvkcF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USvuCD3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8264C4CED1;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217801;
	bh=rpBgNJ8tgnDrWZnhBR0r6ELzBvy/EYm7qgnjIHEZaR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=USvuCD3iHJBtgV9bo/4m8TyQ1YEaUbFAdgWwlGLfVqVW4KnnXCM0uqsir3B6/6DR9
	 VGORMwD32t4AdHn3y/tqVXWMbP5N7o1AbWiGKrX1JEUk+jCFC2LoE6g6PlcR9Pw/7g
	 v4sMgCBQ3y7dyXJA/wYdKO/q0NrmAXsEIYW9H39fGlkj4KsSEYrPJHdJMucuDbjCyk
	 QnmCJwG5csYqJ2XpQjCJWkb2kzEjx3s0aAUgLpo5HMUuK6tpzwU6x2+e5DGU7+ox7h
	 JXUIT9BVMP+BZEm8aWJbSj1MMG1rpUy7J+hUsWwRLej8jAuCOZWVv1/khSK7so9FV2
	 4aQ65q8Uj2bfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD081C021B2;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Subject: [PATCH net-next v5 0/7] net: tn40xx: add support for AQR105 based
 cards
Date: Sat, 22 Feb 2025 10:49:27 +0100
Message-Id: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeduWcC/1XNQQ6DIBCF4asY1qUBVNSueo+mi1EGZSE2QIiN8
 e5F0qR2OZl879+IR2fQk1uxEYfReLPYdNSXggwT2BGpUekmgomKCy5psF3NGY0lUDHogbe1ki3
 TJIGXQ23WPPYgFgO1uAbyTJ8ePNLegR2mY2wGYw8wGR8W987xWGb27TTnTiwpo5WqUUstW4nsP
 s7rNQXydqxOUPA/WCWoQGvddj000Pzgvu8ffiTArfwAAAA=
X-Change-ID: 20241216-tn9510-v3a-2cfc185d680f
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=4309;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=rpBgNJ8tgnDrWZnhBR0r6ELzBvy/EYm7qgnjIHEZaR8=;
 b=BM7Od9afPYzOlw2zXeXD5dap++F0scfoMv07HKY8xYRLVHrLtedZpSV1qUJjMvRzhE8i/PUYf
 VmnyvVrFZY/B8ZN9BtbAKIraWwNcr6Cs2dbQtfZcBK4mFxANukNP5RJ
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
which combine a TN4010 MAC with an Aquantia AQR105.
It is an update of the patch series "net: tn40xx: add support for AQR105
based cards", addressing review comments and generally cleaning up the series.

The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).

---
Changes in v5:
- changed version because "b4 send --resend v4" did not succeed
- used opportunity to rebaseline to net-next
- only source code change is merging a split string in tn40_mdio.c, removing
  a warning from b4 prep --check
- changed format of cover letter in line with b4 (sequence of changes from
  latest to oldest)
- Link to v4: https://lore.kernel.org/r/20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net

Changes in v4:
- use separate aqr105 specific functions instead of adding aqr105 functionality
  in common functions, with need of "chip generation" parameter
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- make generation and cleanup of swnodes more symmetric
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- add MDIO/PHY software nodes only for devices that have an aqr105 PHY
  (suggested by FUJITA Tomonori <fujita.tomonori@gmail.com>)
- Link to v3: https://lore.kernel.org/r/20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net

Changes in v3:
- aquantia_firmware: remove call to of_property_read_string. It should be
  called from the more generic function device_property_read_string
- add more AQR105-specific function, to support proper advertising and auto-
  negotiation
- re-organize the patches about the mdio speed and TN40_REG_MDIO_CMD_STAT,
  skipping the 1MHz intermediate speed step
- re-organized the sequence of the patches:
    1. changes to the general support functions (net/phy/mdio_bus.c)
    2. changes to the aquantia PHY driver
    3. changes to the tn40xx MAC driver, required to support the TN9510 cards
- Link to v2: https://lore.kernel.org/netdev/trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07/

Changes in v2:
- simplify the check for a firmware-name in a swnode in the aquantia PHY driver
(comment from Andrew Lunn)
- changed the software node definition to an mdio node with phy child nodes, to
be more in line with a typical device tree definition (also comment from
Andrew Lunn)
This also solves the problem with several TN4010-based cards that FUJITA
Tomonori reported
- clarified the cleanup calls, now calling fwnode_handle_put instead of
software_node_unregister (comment by FUJITA Tomonori)
- updated the function mdiobus_scan to support swnodes (following hint of
Andrew Lunn)
- remove the small patch to avoid failing after aqr_wait_reset_complete, now
that a proper patch by Vladimir Oltean is available
- replace setting of bit 3 in TN40_REG_MDIO_CMD_STAT by calling of
tn40_mdio_set_speed (suggestion by FUJITA Tomonori)
- cleaning up the distributed calls to set the MDIO speed in the tn40xx driver
- define supported PCI-IDs including subvendor IDs to prevent loading on
unsupported card
- Link to v1: https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc2-1726082106356@3c-app-gmx-bs04/

---
Hans-Frieder Vogt (7):
      net: phy: Add swnode support to mdiobus_scan
      net: phy: aquantia: add probe function to aqr105 for firmware loading
      net: phy: aquantia: search for firmware-name in fwnode
      net: phy: aquantia: add essential functions to aqr105 driver
      net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus
      net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
      net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards

 drivers/net/ethernet/tehuti/tn40.c           |   9 +-
 drivers/net/ethernet/tehuti/tn40.h           |  31 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c      |  80 ++++++++-
 drivers/net/phy/aquantia/aquantia_firmware.c |   7 +-
 drivers/net/phy/aquantia/aquantia_main.c     | 243 ++++++++++++++++++++++++++-
 drivers/net/phy/mdio_bus.c                   |  14 ++
 6 files changed, 375 insertions(+), 9 deletions(-)
---
base-commit: bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
change-id: 20241216-tn9510-v3a-2cfc185d680f

Best regards,
-- 
Hans-Frieder Vogt <hfdevel@gmx.net>



