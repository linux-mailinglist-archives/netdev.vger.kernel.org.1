Return-Path: <netdev+bounces-107583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F296791B9F7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5F71C2369C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43D149C76;
	Fri, 28 Jun 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F997nCRi"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCA149C7C;
	Fri, 28 Jun 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563544; cv=none; b=VZ6H5hkjQE5ne60hSzGiMxrYw+YAhCr/6aBkkXjtykvZVrOjqOW12uGC07GMk3Pfg3uom3gLphP8pK3h7MSvc/txdwtaf2DNtZZ9DhPJTrDBTIog+pEwZTx3qQtKCQvTTpaqIGhPmwSy5Bd0qfgHYlnAjEOI3G/GfLkm/lPHD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563544; c=relaxed/simple;
	bh=vl26mRC3di+UCbJtKug1halZlylXNm19OTQsSGdfuOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPhYwWpPdBpBWiI4b8ZshKXxbGJ64cHX1z8AUSwH969IG3jptjlvhUqpdxLHODdj09z0w6x0ikjSDq5DqEmXfhLfo/TC2pwf+s2libmIL/Yy9ZDoXbUpj/uLc8wx1iVILJxfL/vJuME/8jCaUR4ykw9FU2IYLpN77FfSWvpoAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F997nCRi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08B9D40003;
	Fri, 28 Jun 2024 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719563540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7yLiDevD/Nc8XFJFThpg8VP1XNSiEOrZXCh6SdDmkqM=;
	b=F997nCRiiE/hvYqQmgl/+s5WXL0lyveQQPd1FZeiIU+eupPjuq6avjD6NJkwKlV5TyGTdK
	pYETOCavooKnROh6ns0fHSgB1j6AeJMg1QiuQJBYTqGvWcd/i5YzElB+s3jqGuutK/XHXP
	A8myQRavjxeAaLb8RPPXPSrHavQNzk2FnQ9S1qeJ+5X7Fl/ZqeM9NwDXpBexvnfAwk3huv
	JwjCyxIiDwS+rdSSSi0S3umq2n5DPix4U21TNSJ+uB6zeVSy2A0p8J7O8Z2jyteVVptFNR
	z+wgGkWoVCgdLF1pYc5rwHeLTrvbX9dJSP8ld8tQnaFytVVgc8YO4ZQ2dnabXQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 0/7] net: pse-pd: Add new PSE c33 features
Date: Fri, 28 Jun 2024 10:31:53 +0200
Message-Id: <20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPl0fmYC/3XQz2oDIRAG8FcJnmvRUaPbU9+jhOCfSSO0urjWp
 IR991ovTQl7mMPHx/wG5kYWLBEX8rK7kYItLjGnHtTTjvizTe9IY+iZAAPJJCh6Qlu/Ch7n/Ds
 XLEdvZ8oNTsxZDZN0pO/OBU/xOtw3krDShNdKDr05x6Xm8j0ONj76YSuYNuzGKaPMS8eDmpRw5
 tXlXD9ievb5c5gN/pw901sOdMcz4SGgM8K6R0fcOVxuOaI7FvbaSNRGcP7oyDtn82dNdscxw4W
 1Qemg/jvruv4AJ8Ziop4BAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
 Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

Changes in v5:
- Fix few nitpick.
- Link to v4: https://lore.kernel.org/r/20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com

Changes in v4:
- Made few update in PSE extended state an substate.
- Add support for c33 pse power limit ranges.
- Few changes in the specs and the documentation.
- Link to v3: https://lore.kernel.org/r/20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com

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

 Documentation/netlink/specs/ethtool.yaml     |  58 +++++
 Documentation/networking/ethtool-netlink.rst |  87 +++++++-
 drivers/net/pse-pd/pd692x0.c                 | 317 ++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c                | 172 ++++++++++++++-
 include/linux/ethtool.h                      |  20 ++
 include/linux/pse-pd/pse.h                   |  51 +++++
 include/uapi/linux/ethtool.h                 | 191 ++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |  12 +
 net/ethtool/pse-pd.c                         | 119 +++++++++-
 9 files changed, 997 insertions(+), 30 deletions(-)
---
base-commit: f203f9086d3b3718bc63782a56218c7122f07db3
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


