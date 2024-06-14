Return-Path: <netdev+bounces-103630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF72908D77
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464AC289B86
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21110D51C;
	Fri, 14 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VLtPlm38"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E971107B6;
	Fri, 14 Jun 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375611; cv=none; b=EG4vzG9iRUmzGZMcFmjQ8d0Ml2cwhzXYuDl6wHM0Kl6LYlxP5b7W0bbeAavKtFOjdQzHK4jbBN4+Kk0MT1pxRBM2YO6Qqb7QSJXRJrxbWICeBDzGXl2bB9olPND4JwVzzHgVrnXU3eQeW68PnCtGZ7gTEjAEeL1CnnkJkmoULyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375611; c=relaxed/simple;
	bh=AcRAxAoyH4WPbHLe0vulxYJCcAVateoH9C9veYtFfgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U3wZAqpEwE/mJ36BYCh9oFpg0BU3DLt2vyTM/QX91DGSwQuEoZ0F/fBUjJYTw2pi52qK94pt7c+WJkFjL+GqCnphR9vY0i1xTROL4x0pL3sGuSo1Gw4a1OhgFtKxLc7B5vOSJ6NvIkGOQpp7dfsYQItQipn81ZT+CFA9Zend1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VLtPlm38; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F01741C000B;
	Fri, 14 Jun 2024 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=95y7WBvw2tiKz2nNdi0RVJ6/9i6j6Kbk35j2uEz1F7A=;
	b=VLtPlm38x+P3jJSZHGFw2EZIr6P4YePooxycATz7/YcjXwOML1LvrK11LSLRSDY5vOKc48
	z/EOHb5QfHYpnMYndf1dyxR/K4RgsODA+vIe3WJUymFilsNJ4m87Ywf2WPr3vkxyeJQTN6
	pkO/hu9laBrgM7auzFL3gDBWEaF9rT8+l0ML4+udoLjPFMCf96vQ+MVRKI5v/JHoQ97Bcg
	vBtR0qz/cqiwzlswYjTWBqyoYCWsZQX2168f7u6zAMDeNzKEu8vCKM0bmb29BAcNWjBUKa
	t4MZbR+hsz3nu7MbM0AvUiYw65YM+dh3MtMpUuY9TImWgQ9NhcPPtQZsFegedw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3 0/7] net: pse-pd: Add new PSE c33 features
Date: Fri, 14 Jun 2024 16:33:16 +0200
Message-Id: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKxUbGYC/3XNTQ7CIBAF4Ks0rMVQfmzrynsY0wCdWhKFBhBrm
 t5dZGNcuJjFy8v7ZkUBvIGAjtWKPCQTjLM5sF2F9CTtFbAZckaUUE44FXgEGR8e+tl97gm+13L
 GdQsdUbKhHVcob2cPo1mKe0YWIrawRHTJzWRCdP5VHqa69MUWtPtjpxoTTDRX9SA6wVR7Us7Fm
 7F77e7FTPTrHEjzz6HZ0YRpOoBqmVS/zrZtb8Bka3wOAQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

Changes in v3:
- Use u32 instead of u8 size for c33 pse extended state and substate.
- Reformat the state and substate enumeration to follow Oleksij proposal which
  is more IEEE 802.3 standard compliant
- Sent the first patch standalone in net.
- Link to v2: https://lore.kernel.org/r/20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com

Changes in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
- Modify the pd-92x0behavior in case of setting the current out of the
  available ranges. Report an error now.
- Link to v1: https://lore.kernel.org/r/20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (7):
      net: ethtool: pse-pd: Expand C33 PSE status with class, power and extended state
      netlink: specs: Expand the PSE netlink command with C33 new features
      net: pse-pd: pd692x0: Expand ethtool status message
      net: pse-pd: Add new power limit get and set c33 features
      net: ethtool: Add new power limit get and set features
      netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
      net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks

 Documentation/netlink/specs/ethtool.yaml     |  40 ++++
 Documentation/networking/ethtool-netlink.rst |  45 +++++
 drivers/net/pse-pd/pd692x0.c                 | 292 ++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c                | 172 +++++++++++++++-
 include/linux/ethtool.h                      |  16 ++
 include/linux/pse-pd/pse.h                   |  42 ++++
 include/uapi/linux/ethtool.h                 | 212 +++++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |   5 +
 net/ethtool/pse-pd.c                         |  69 ++++++-
 9 files changed, 874 insertions(+), 19 deletions(-)
---
base-commit: 94720a40bd1c6de0780f90f4f68d76be1d2c6bd8
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


