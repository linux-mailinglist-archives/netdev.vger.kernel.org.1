Return-Path: <netdev+bounces-101702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDE18FFD1B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F07128243E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F945C06;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ow+EMRjp"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13901C2AF;
	Fri,  7 Jun 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745441; cv=none; b=IQRov6c2oowe4LM5+QrgSW/yN0ZdMifDkd+D0ivmhXwdoxM59wy+7sDoGjbOTmWykLVumWKQ2oc09oXpVgV9D4FOwU0iTPPFdG2HsJFJLJ7DZguU4j5De4Iwdj8X1VIXclZyTrO6Bm1GoFf5xvJxxipC5snDqkY7tEHfRgzFMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745441; c=relaxed/simple;
	bh=I7dGnuQJiK2CvEOG9kLQhbKFh6VzuIq7y1wWMbdusP0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oO0KOi48idVYiYN2kdM4QiB7QoYqabUfA54BqzAq755cUwfZp7vjeg/ZQTm2h2lvOBGAlUztcileBLD7NerOCMDI1kRvFAaXV08/1I2eW645Jaeu7s6EaymvYph5MXV9H+bpi5l5QR6xFF0Dmjg+jk96ywDTL5kVkwP1pu2McP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ow+EMRjp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ACAC4000A;
	Fri,  7 Jun 2024 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVZaeJ7ov8Q4H8A8zYRzgBLW0YPPkgkDaWGaynlwq8M=;
	b=ow+EMRjpjUDhhs/GUIK/l856KA5gAKofv0wXJHvGy1iGL1e249/c5ZPWHjm5xmyUqDakD9
	l3iKwHCjnTzT0bVsCb6o266RzKIdGpcKheRttNhRixqaDblh4qVC4cCPAh6NMuKbqdEX8T
	KSE1z7FEkbPLBsJwpZpN+0ZfZctdF7+nWjn4WiQ+S53ca/CqD7bTxg29UbF1P8xX+/QGlV
	xKW3vUFbByumCDfn2RfD0D8sKV/q91dCYSOzBUXtVtJMyN+RMYFK58PaO7YTGqoiJaVtNG
	S4tteuyYKF1nwRsGItLMKbfnFYnVB79c/wl/2e+kPHAc5PEBtbo5o8M90Z7+Eg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/8] net: pse-pd: Add new PSE c33 features
Date: Fri, 07 Jun 2024 09:30:17 +0200
Message-Id: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAm3YmYC/3WNQQ7CIBREr9L8tRhAiMWV9zBNA/TXkig0gLWm6
 d1F9i5m8TKZNxskjA4TXJoNIi4uueAL8EMDdtL+jsQNhYFTLqjgkoyo8ytiP4df3hh7q2fCWlT
 U6DNXwkDZzhFHt1bvDTxm4nHN0JVmcimH+KmHC6t9dUuu/rgXRiihVhg2SCVPpr2aEPLD+aMNT
 +j2ff8CNDKOVMYAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

Jakub could you check if patchwork works correctly with this patch series.

Changes in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
- Modify the pd-92x0behavior in case of setting the current out of the
  available ranges. Report an error now.
- Link to v1: https://lore.kernel.org/r/20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (8):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP
      net: ethtool: pse-pd: Expand C33 PSE status with class, power and extended state
      netlink: specs: Expand the PSE netlink command with C33 new features
      net: pse-pd: pd692x0: Expand ethtool status message
      net: pse-pd: Add new power limit get and set c33 features
      net: ethtool: Add new power limit get and set features
      netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
      net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks

 Documentation/netlink/specs/ethtool.yaml |  25 +++
 drivers/net/pse-pd/pd692x0.c             | 283 ++++++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c            | 172 +++++++++++++++++--
 include/linux/ethtool.h                  |  11 ++
 include/linux/pse-pd/pse.h               |  46 ++++-
 include/uapi/linux/ethtool.h             |  41 +++++
 include/uapi/linux/ethtool_netlink.h     |   5 +
 net/ethtool/pse-pd.c                     |  69 +++++++-
 8 files changed, 631 insertions(+), 21 deletions(-)
---
base-commit: c7309fc9b716c653dc37c8ebcdc6e9132c370076
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


