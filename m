Return-Path: <netdev+bounces-152711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AF9F586F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DE8188911C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548F1FA15E;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmUw9iBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE76208CA
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=lQW/DY29esaciEWhgXbtobZ5NGPq3dQmAN4fCrq8nv3HxntcjoThhqhRjA0DeP/dG2TpbYjhjchfsXaq5ym7BmD4o/sR9u5bzuXXyA4LaRntvWOWZ2ah/SbZkP1I4h14LcGg56oK9ereagOnRSYAmjN1S64/kcoTjQLp7FxW2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=9sUdCk3J2Rtd9ajWzP8R/ayZ93QxhWtrG0DQwm5u75c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eg6qUdq0AOvVb6h+ATp0nVSkCBZO5+Gg4kPQQ7grgIy8DdyobvSEl/1NnBCnzPhbZbeaauEI0rxz45XqDT92mwu2l/VtvGW5m+B/YlZqspfIww6PAXER64fAF81X+bXSuXYH6rWK60GX3vn97+ZK3/Wmuk3g4LEbMlFhtpN+a+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmUw9iBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD78BC4CED3;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469658;
	bh=9sUdCk3J2Rtd9ajWzP8R/ayZ93QxhWtrG0DQwm5u75c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rmUw9iBEa2NkSJZjc3ddm1nYC/CJvh2MXi21M6G09IGBdPOs/uG5nZg23YuN+hWGu
	 RozKUhip+xcWzrVSNOwQMY4q9etvTKpq34pqJAFsSyi2OvDadJL/S0ddKZbxZ6nC5f
	 ck8mYKK6rswPe0LYqMIdkUASDhbeCXRSSD0EdTB4nw9xc5XrhSbW6j2TDgQY+wc97p
	 jpBkhbpkPcTmspk6mHYPI8/mNbZULenn99Pjah5/sdhWGlqABz4jETqBvjrnDk7ctZ
	 nCl/519honpMNzwFeQBCiiILgWfalDORrSvJOIHRl5xuGApaeQuxdPlKu4lYwqUtcP
	 i4xnSmcZxIZ/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A0E7717F;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Subject: [PATCH net-next v3 0/7] net: tn40xx: add support for AQR105 based
 cards
Date: Tue, 17 Dec 2024 22:07:31 +0100
Message-Id: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPoYWcC/x2MywqDMBAAf0X23IU8qmh/pXhY40b34FqSIIL47
 017HIaZCzIn4Qyv5oLEh2TZtYJ/NBBW0oVR5srgjHtaZzssOrTW4OEJXYjB9u3c9SZCDT6Jo5z
 /2RuUCyqfBcZqJsqMUyIN62+2kSjc9xews51IfQAAAA==
X-Change-ID: 20241216-tn9510-v3a-2cfc185d680f
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=3336;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=9sUdCk3J2Rtd9ajWzP8R/ayZ93QxhWtrG0DQwm5u75c=;
 b=39tBlHhuhEEU8Sz1DNp1inQo2hLovUzrsv3QQwwkmGu3LALWlBkb4+RVn6vbX5f3aBQnhL48E
 97j1YlxdeS4AyLrAr9VChSHNuBv1aaJQ8wfoq67FWj31qUJlTNguJup
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
which combine a TN4010 MAC with an Aquantia AQR105.
It is an update of the patch series "net: tn40xx: add support for AQR105
based cards",
v1: https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc2-1726082106356@3c-app-gmx-bs04/
v2: https://lore.kernel.org/netdev/trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07/
addressing review comments and generally cleaning up the series.

The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).

Changes v1 -> v2:
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

Changes v2 -> v3:
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

---
Hans-Frieder Vogt (7):
      net: phy: Add swnode support to mdiobus_scan
      net: phy: aquantia: add probe function to aqr105 for firmware loading
      net: phy: aquantia: search for firmware-name in fwnode
      net: phy: aquantia: add essential functions to aqr105 driver
      net: tn40xx: create software node for mdio and phy and add to mdiobus
      net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
      net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards

 drivers/net/ethernet/tehuti/tn40.c           |  14 ++-
 drivers/net/ethernet/tehuti/tn40.h           |  30 +++++
 drivers/net/ethernet/tehuti/tn40_mdio.c      |  67 ++++++++++-
 drivers/net/phy/aquantia/aquantia_firmware.c |   7 +-
 drivers/net/phy/aquantia/aquantia_main.c     | 169 +++++++++++++++++++++++----
 drivers/net/phy/mdio_bus.c                   |  14 +++
 6 files changed, 271 insertions(+), 30 deletions(-)
---
base-commit: 860dbab69ad8d07a91117ed9c9eb5fb64adf7e0e
change-id: 20241216-tn9510-v3a-2cfc185d680f

Best regards,
-- 
Hans-Frieder Vogt <hfdevel@gmx.net>



