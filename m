Return-Path: <netdev+bounces-176860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC1A6C9BF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AA116C512
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301561F9F70;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ8tuJcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146D78F32;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=UxuHClYsfd9PcXLB3eWvzNNej21UvflC8j2R+KB1Hh8a8qpWPQfQHGaWD9piXwm0EvsEsAMpGXp+b/cX/e8yWFVT7/8FNFt2D5TZuYHOWYWyl1k65HAdQMPz3fFkBiiVCDnWyoINVEPQ3S99/t0MZjorD9lTg6K2WmBAxveLfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=dy7hnpEpmljpvnmL7VUaERJFKqdCMUh00qJI84ZH+hY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XpeQJOAEfrvnfKZWzpGKhfmM4JvA0Rgw4SgfogMigg+cUOYmh1Yhh4xAeF5RO9BAOsXntvza8LedunaDXEX5Azf8vZnVgQuTOAwJiowrFchMsZUAt5l7XA8hY9fUEqlMD5ncgQ7W2JZGCYOVzpK2m9bUMBxsjOjSH+8cJoixzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ8tuJcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70EDCC4CEDD;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=dy7hnpEpmljpvnmL7VUaERJFKqdCMUh00qJI84ZH+hY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LQ8tuJcNcRoakCH+5YNtfGQ22Wn5A0UfA5vBvDxjJMieBP7sa6UqVY0QwFc1AaVdq
	 Ow0yE4mic34YRXq8DA6rLgZQCwIINe5fG4rkVNvqokt9bsJzQow3YrrmUs1PzAsj7a
	 v2zQynJ327MNH+yn/GgcQuqJNHHNd+I/ALKV00V1pRV0UR2H8T8Yd209t5j+kXMjjW
	 DtPIA/RMIIFSu0zBZPBL5U+6cR9GcnrepUjX1CVjTznp0ubz3mHIMVFKz85JZLhspO
	 9Od5S2n8mBd/ehx0Ox8izUAkl86VEbL8rMsLkqc8ZQcZISGjbHYqGUDhgKS4xqlanN
	 NUk9vueWQxfRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B836C35FFC;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Subject: [PATCH net-next v7 0/7] net: tn40xx: add support for AQR105 based
 cards
Date: Sat, 22 Mar 2025 11:45:51 +0100
Message-Id: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+U3mcC/1XNTW7DIBCG4atErEs1/ENXvUfVBTZDzCIkAgu5i
 nz3EqtVwnI0er73TiqWhJV8nO6kYEs1XXM/zNuJzIvPZ6Qp9Jtw4JJxpumanWJAm/CUz3FmVgV
 tIZIObgVj2o6xL5JxpRm3lXz3z+Qr0qn4PC+PsYtP+QGWVNdr+TniTRzsr2NeO01QoDIojDpqq
 xE+z5ftvQeO7SZfIGcDlB0GH2O0bvLGmxGqf6iAcz5A1aFzQiuQBgW4EeonFMwOUHdowXoH1gU
 upyfc9/0XHJhj424BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=5168;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=dy7hnpEpmljpvnmL7VUaERJFKqdCMUh00qJI84ZH+hY=;
 b=b2krxJvHp5+OhOArQcSFecb2wM4Tk2k+Uo9UyRO0v0MSxwvczVKs3kSNbk9Ca0NsfM92qR9W9
 GKlKin1KN6KCkD+DvT0F4xxh7/XCpQt1kg5DOeoRxzh5xqybcUkUiok
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
Changes in v7:
- change function name aqr105_config_speed to aqr105_setup_forced, in line with
  naming of generic functions
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- replace device id 0x4025 with symbolic name PCI_DEVICE_ID_TEHUTI_TN9510
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- because of last change, remove the Reviewed-by: entries for PATCH 7/7
- Link to v6: https://lore.kernel.org/r/20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net

Changes in v6:
- rebaseline to net-next
- remove unneeded loop timing ability advertisment in aquantia_main.c
  (highlighted by Maxime Chevallier <maxime.chevallier@bootlin.com>)
- add failure path in tn40_mdio.c if device_add_software_node fails
  (suggested by Ratheesh Kannoth <rkannoth@marvell.com>)
- Link to v5: https://lore.kernel.org/r/20250222-tn9510-v3a-v5-0-99365047e309@gmx.net

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
 drivers/net/ethernet/tehuti/tn40.h           |  33 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c      |  84 +++++++++-
 drivers/net/phy/aquantia/aquantia_firmware.c |   7 +-
 drivers/net/phy/aquantia/aquantia_main.c     | 240 ++++++++++++++++++++++++++-
 drivers/net/phy/mdio_bus.c                   |  14 ++
 6 files changed, 378 insertions(+), 9 deletions(-)
---
base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
change-id: 20241216-tn9510-v3a-2cfc185d680f

Best regards,
-- 
Hans-Frieder Vogt <hfdevel@gmx.net>



