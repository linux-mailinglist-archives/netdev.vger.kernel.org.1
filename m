Return-Path: <netdev+bounces-132657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C92992B7D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5201F2357D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF731D279C;
	Mon,  7 Oct 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lUf62wZa"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF21D26FE;
	Mon,  7 Oct 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303566; cv=none; b=WFYG+VP2TLHbNsDGRMNBB+geaSXcJsAMK+NnhK2AIjo/6Iaz6XnK+PUv9e2QMZzhN/ut788Lmu+jMTQFqvagcCMOv7MnLWGucfPItV+u7WCs/aGLQq0HHMqj8L8eLAmUTWm6dzNA4FF4bpZfelDXfBt7XlOzqRH94iDq0VimmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303566; c=relaxed/simple;
	bh=shVT950uDJWSwE4LubJ+eT48En49Cd3esGWXKZXocl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YJm7iBf7X8fobfVQrl4qblf3Gm/g8BZKMz1cL1XbG/xCk1pyErmyFvma7ydAA7ZYFwMPgoJuq8QAu0GtNQfapg4W7+So2jYHyIBL7g741P60mTU0qoCJe7ZZjHND4LPiL9PQmNtVi1wsBGGKxZQeD2W8ZSylDGw21rAAcQ4GxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lUf62wZa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50D8E20002;
	Mon,  7 Oct 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728303556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o58zTIA9rwsmTRMvOE90N9ILQSMy9IJu6Imt2m2o+zI=;
	b=lUf62wZarKfcfW1n+J9O+Fdh/fYiYYSmjdr09ej7yfWWIQxpISv+gZJ/ruddLtvJqAg3Vu
	Z308opoIvrUsw8UQpHsLzaa8TKNSsTIZrOyuJjo+B7NOeYYtSN3eTNz9m+mxTWthZIEeEw
	v6CVoZmsilR+bF39pYR62F6yQf2ToPGA/1c+3bGkfc0Y/CUqThEUNUFVBLz5oP5JG6iQIG
	oa7hH3txXUZrdNJea6fh4cIXZrchfHa2Xdnx3gGyxKObsnny6aP+eYDC8gLcbcMs+7UHwR
	8KPfvI+4mg3PkNFURuOncQkuYKa/5sHDw40hSd5G9wPXxl9p9wlR5jA4YlD3Rw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next v2 0/2] Add support for new features in C33
 PSE
Date: Mon, 07 Oct 2024 14:18:48 +0200
Message-Id: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKjRA2cC/3WNQQ6DIBREr2L+ujSIVkJXvUdjjMq3klg+AWptj
 HcvZd/FLCYz82aHgN5ggGuxg8fVBEM2GXEqYJx7+0BmdPIguKi55IpN2MeXx87RT2/03dg7dmk
 GrWSjtagkpK3zOJktc++AcY5EC7O4RWhTOpsQyX/y6VrmTuarUvzhryXjrFYKK62VarS8DURxM
 fY80hPa4zi+5aNMVsoAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series adds support for several new features to the C33 PSE commands:
- Get the Class negotiated between the Powered Device and the PSE
- Get Extended state and substate
- Get the Actual power
- Configure the power limit
- Get the Power limit ranges available

It also updates the manual accordingly.

Example:
$ ethtool --set-pse eth1 c33-pse-avail-pw-limit 18000
$ ethtool --show-pse eth1
PSE attributes for eth1:
Clause 33 PSE Admin State: enabled
Clause 33 PSE Power Detection Status: disabled
Clause 33 PSE Extended State: Group of mr_mps_valid states
Clause 33 PSE Extended Substate: Port is not connected
Clause 33 PSE Available Power Limit: 18000
Clause 33 PSE Power Limit Ranges:
        range:
                min 15000
                max 18100
        range:
                min 30000
                max 38000
        range:
                min 60000
                max 65000
        range:
                min 90000
                max 97500

This series requisites the c33 PSE documentation support patch sent
mainline:
https://lore.kernel.org/r/20240911-fix_missing_doc-v2-1-e2eade6886b9@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Add missing c33-pse-avail-pw-limit help usage.
- Remove patch 2 which gets merged.
- Link to v1: https://lore.kernel.org/r/20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com

---
Kory Maincent (2):
      ethtool: pse-pd: Expand C33 PSE with several new features
      ethtool.8: Add documentation for new C33 PSE features

 ethtool.8.in     |  36 ++++++++
 ethtool.c        |   1 +
 netlink/pse-pd.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
---
base-commit: 96aad731275fb4e48e01da697882241e6a0cc198
change-id: 20240709-feature_poe_power_cap-56bd976dd237

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


