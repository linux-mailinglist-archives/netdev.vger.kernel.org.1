Return-Path: <netdev+bounces-155201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E204A0171D
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16C27A1570
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A51CCB4A;
	Sat,  4 Jan 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZElRm/dP"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF615622E;
	Sat,  4 Jan 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029730; cv=none; b=S+BsArDz+G71OS562Ko1MNJycii5MYkI/uafW1+c4nvY7iPIxSaxFGJc3SG6LN8d080ZuA5cgOI67q9LLSd0IwRJt3WWtI2Oty0vLKiAacJjz4MR1bN/r3YBSM3CazNxL+To1fi9n5Qe/pM/HSZm29JrohET4P8Z4/uHujRNBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029730; c=relaxed/simple;
	bh=RRdrq518hxdeyT/stcSEEqy5yKMu7rkVxmPrcMbC84s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O4hJpYZ3Zl8Tld8yesddvFg73R+c8rsh7K9h1pKrr6+BZDxdxrfp0wG6TwNqdIzAT7RIp+pYkf2oqbkpJLu6DG6GoLLrZv3e6BbWQQTWNLTc0cnD8P1DsKoERtqT30VZrhiXb+1EKkfhYGJeLgH8K+VE27VQHPz8wrdSxbuUVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZElRm/dP; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C8F840002;
	Sat,  4 Jan 2025 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nkb7TACNxPUTa9SfnvNPwm5VqzmLvKI0DDN4OmdnzcI=;
	b=ZElRm/dPQ8JEkJ8T/NcjqlN+yBz5CF+RsPpsm3KwGXrTrWIRQVS/p+ikTl0XCX8QG9JJxv
	ZllD+3ypryuz8/OKukDm+zjBjnxrD3P2w9T+0h/Z7i/f6FWs21jR6GYnJoi7BPDFVGlWvX
	cikg5iqTYglhNddXbC5aLOmxk1dMnc7NMVTobdjagQZERfR58ISCw7yBblC14u9bPMZMlz
	J4DTfEiiI5FeXg1Du8jDyAZ1EKmcRNvHdizlHJAk90NqNW5F9tM91qUE+Szhyxrgk+Adje
	3EJBfYzjTUM5DUJ9VF41AZX3KV56GYWlcCFvDjaeS1OnLJR8gZBHqarqxYgiGw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 00/14] Arrange PSE core and update TPS23881 driver
Date: Sat, 04 Jan 2025 23:27:25 +0100
Message-Id: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM21eWcC/x2MwQqDMBAFf0X23EAM0UJ/pRTZ6ovuJQmbtAjiv
 xs8DszMQQUqKPTqDlL8pUiKDfpHR/PGcYWRpTE56wbbW2++3gRw/SmmnDCx6m09ebF+dMFxALU
 4K4Ls9/hNEdVE7JU+53kBAYqVMXIAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch includes several improvements to the PSE core for better
implementation and maintainability:

- Move the conversion between current limit and power limit from the driver
  to the PSE core.
- Update power and current limit checks.
- Split the ethtool_get_status callback into multiple callbacks.
- Add support for PSE device index.
- Fix PSE PI of_node detection.

Additionally, the TPS23881 driver has been updated to support power
limit and measurement features, aligning with the new PSE core
functionalities.

This patch series is the first part of the budget evaluation strategy
support patch series sent earlier:
https://lore.kernel.org/netdev/20250104161622.7b82dfdf@kmaincent-XPS-13-7390/T/#t

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (14):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: Avoid setting max_uA in regulator constraints
      net: pse-pd: Add power limit check
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
      net: pse-pd: tps23881: Add missing configuration register after disable
      net: pse-pd: Use power limit at driver side instead of current limit
      net: pse-pd: Split ethtool_get_status into multiple callbacks
      net: pse-pd: Remove is_enabled callback from drivers
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Add support for PSE device index
      net: ethtool: Add support for new PSE device index description
      regulator: core: Resolve supply using of_node from regulator_config
      net: pse-pd: Fix missing PI of_node description

 Documentation/netlink/specs/ethtool.yaml       |   5 +
 Documentation/networking/ethtool-netlink.rst   |   4 +
 drivers/net/pse-pd/pd692x0.c                   | 224 ++++++------
 drivers/net/pse-pd/pse_core.c                  | 206 ++++++++----
 drivers/net/pse-pd/pse_regulator.c             |  23 +-
 drivers/net/pse-pd/tps23881.c                  | 449 ++++++++++++++++++++-----
 drivers/regulator/core.c                       |  39 ++-
 include/linux/ethtool.h                        |  38 +++
 include/linux/pse-pd/pse.h                     | 114 ++++---
 include/uapi/linux/ethtool_netlink.h           |   1 -
 include/uapi/linux/ethtool_netlink_generated.h |   1 +
 net/ethtool/pse-pd.c                           |  12 +-
 12 files changed, 794 insertions(+), 322 deletions(-)
---
base-commit: 58eeb5a55bf1203cc6c01adc4cecbdc23ed2cc64
change-id: 20250104-b4-feature_poe_arrange-7ad0462f2afe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


