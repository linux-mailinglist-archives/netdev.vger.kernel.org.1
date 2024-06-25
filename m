Return-Path: <netdev+bounces-106462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF49167F1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EB4283D55
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA35156646;
	Tue, 25 Jun 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LiThNMBf"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFC14831F;
	Tue, 25 Jun 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318843; cv=none; b=IVvu/js4A/4MURAsnUKNcRZhBl8kQM2DtVawqJ7xuot9uvrm/C2wqbyj/qtCfmbH1/ovQspS6qzlpws9E613W2a551sKw3TAMZRjhOdxYDxEBHCrpNVUPi3nzjvO9l2FYegDijo4dm2Wdi2w0fppq9Nk07SufZYrfsCEBCnHnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318843; c=relaxed/simple;
	bh=0vTeA1bjmNtGwXezcaqYRAXYF1NLqC2a3D2GgKkavV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eDIlOyswpzer4MaMoz2tz1VZEnPsKGFiAd2WB+6u2NM7Kdyhi2E/o0FbAMO4e20NKSyJPazcKfAgr3w+HjTDtzP16V2KfXo4/5rNDHNpcuwPrf6WCTHq1zERszvnKn1nVjiFVJPBkdzEsRdO4ncAk4XiTv8yoTiI3bh7QHMutuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LiThNMBf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CA676000B;
	Tue, 25 Jun 2024 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5T/QIU/cETq1tlbuFPd7ryLw8O87C9B+H47qdJAHXJw=;
	b=LiThNMBfzuMK6mm3vhRR/TdofVz4kMZM/w9/xsV3jU7O1+dZpRRX7eKHBE0aAwIxns+uWG
	N1fw63F40/enhl4UuSYsZ3NwQDvQz0zo0XqsjGOgTHKpQ2XfrTXWBRvXcp5SBaURYDcxIV
	mwwe4yMIl0nXyYZ1RXKNqCiRktcCR+yHVDO3xOi42FDSiQ2Muwn8rAeSLhziG4KF9c9pSl
	1F9XYuQu+nYV+TyNKyNFOMKkRsKtP2AyGqjF2sU8ZxqxcnXLR+aUqqvRva5A6M/Tke+p8F
	INpEOppFM1NU613Pve+uOHLSW8wK+j8uwkyvYqmi+Ujo6H80bqTm23x/pnIw8A==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v4 0/7] net: pse-pd: Add new PSE c33 features
Date: Tue, 25 Jun 2024 14:33:45 +0200
Message-Id: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACm5emYC/3XNQQ7CIBAF0KsY1mJgoJa68h7GNEBHJVFoKFaN6
 d1FNmpMF7P4+flvnmTA6HAgm8WTRBzd4ILPQS4XxJ60PyJ1Xc4EGEgmoaIH1Okase3D+24YW6t
 7yhU2zOgaGmlI3vYRD+5e3B3xmKjHeyL73JzckEJ8lIcjL32xK2hm7JFTRpmVhndVUwmjtiaEd
 HZ+ZcOlmCN8nDWr5xzIjmXCQodGCW3+HfHlcDnniOxoWNdKYq0E57/ONE0vpk9+0VYBAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

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
base-commit: b98d89947d124c8ca9150b32fdc0c5fb099243cf
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


