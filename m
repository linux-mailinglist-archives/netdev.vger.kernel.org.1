Return-Path: <netdev+bounces-155097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED61A00FB9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B53A5CB3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED081C1F30;
	Fri,  3 Jan 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QsQ8vLRH"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1531BEF83;
	Fri,  3 Jan 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938959; cv=none; b=vF4hAYAQ4qAILsOZC0+qzWtauA4qAJdNxhHNKkB/i+OFPgr8wiJ8sufMJ07UxvkTU4843cgqdewfgPPzlWJiYqgkcA7OZNNkzBOR7YlZE9FR5M3qcrhng8xCjjHRnLOjPt7g0AkOkZzmOVUu17kQ4wpzBwVnjYHfSnmqKW3/pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938959; c=relaxed/simple;
	bh=kcAZRzJ09qOnHJz47crxthcw+XQ/lH0Xc7WAPcOpNNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iT0zEAOm7X46I72+gGdBiQTeB+aa2aRLEWG8md9ZnKREF6AXvmlYL3gIbJzUfazerOUmgs7OjBCBENRvKoQGVblRg4sa8b4HyEVpbdxdiOPgO17cGG3t9BA2KOHY0mrgy78u26NFi4SmvLNT3I94yZhvj1zpBgoziLGZ1n01oHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QsQ8vLRH; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D9D01C07B4;
	Fri,  3 Jan 2025 21:13:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7805FF803;
	Fri,  3 Jan 2025 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qY3eoVMjgYIvaukOPrAVKW1vnJosilRL0r6Tj+PkWns=;
	b=QsQ8vLRHAhVpjW7cUUMHaJuqTxR/LP+onPe4iXMN+1iKnAVTQpk/LSnj0gPzod1mztq65s
	2Cwwka16wz13xaiEvMhqLFh5KOJX6Is2Rlcwb8EqMuQoUIWmdxwqBleCpmZcqOYnbvdRkW
	IAPlHM3tIFzkYJEviZIc/M8KubYlrLHY/PIJjW8jF0DFxpBJ+JcE7YErhy1D4DTkKQEgSO
	4OmJ5+K+k+ilEqa/kAI6HwaCwG15qU77vs9Oc5g+RUNJQfFDiQCLKXjFjK64GyNFmpkP8E
	MwdvAvPSCd0grrVhIiJHFXsM4Sda1cu2w6nUq0+/CpnF+uLltB6lqnXXKRi/Ug==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v4 00/27] Add support for PSE budget evaluation
 strategy
Date: Fri, 03 Jan 2025 22:12:49 +0100
Message-Id: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANJSeGcC/3XNQQ7CIBAF0KsY1mJggFJceQ9jDLZTS6LQUGw0T
 e8u7UaN6WIWPz//zUh6jA57st+MJOLgehd8DnK7IVVr/RWpq3MmwEAywwVt0KZHxHMX5ovp3EU
 XqFXcYq2FAKxI3nYRG/dc3CPxmKjHZyKn3LSuTyG+locDX/rZ5ozBij1wyqguNVOy0RJrdbiEk
 G7O76pwX8wBvhzB1hzIjlHKFACIUtt/R3wcDnzNEdkpBRjT2MIUuvp1pml6AzUPvrpWAQAA
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series brings support for budget evaluation strategy in the PSE
subsystem. PSE controllers can set priorities to decide which ports should
be turned off in case of special events like over-current.

I have added regulator maintainers to have their opinion on adding power
budget regulator constraint see patches 17 and 18.
There are also a core regulator change along the way patch 16.
I suppose I will need to merge them through the regulator tree.
Will it be possible to create an immutable tag to have this PSE series
based on them?

This patch series adds support for two budget evaluation strategy.
1. Static Method:

   This method involves distributing power based on PD classification.
   It’s straightforward and stable, the PSE core keeping track of the
   budget and subtracting the power requested by each PD’s class.

   Advantages: Every PD gets its promised power at any time, which
   guarantees reliability.

   Disadvantages: PD classification steps are large, meaning devices
   request much more power than they actually need. As a result, the power
   supply may only operate at, say, 50% capacity, which is inefficient and
   wastes money.

2. Dynamic Method:

   To address the inefficiencies of the static method, vendors like
   Microchip have introduced dynamic power budgeting, as seen in the
   PD692x0 firmware. This method monitors the current consumption per port
   and subtracts it from the available power budget. When the budget is
   exceeded, lower-priority ports are shut down.

   Advantages: This method optimizes resource utilization, saving costs.

   Disadvantages: Low-priority devices may experience instability.

The UAPI allows adding support for software port priority mode managed from
userspace later if needed.

The patch series is based on this fix merged in net:
https://lore.kernel.org/netdev/20241220170400.291705-1-kory.maincent@bootlin.com/

Several Reviewed-by have been removed due to the changes.

Thanks Oleksij for your pointers.

Patches 1-9: Cosmetics.
Patch 10: Adds support for last supported features in the TPS23881 drivers.
Patches 11,12: Add support for PSE index in PSE core and ethtool.
Patches 12-14: Add support for interrupt event report in PSE core, ethtool
	     and ethtool specs.
Patch 15: Adds support for interrupt and event report in TPS23881 driver.
Patch 16: Fix regulator resolve supply
Patches 17,18: Add support for power budget in regulator framework.
Patch 19: Cosmetic.
Patches 20,21: Add support for PSE power domain in PSE core and ethtool.
Patches 22,23: Add support for port priority in PSE core, ethtool and
	       ethtool specs.
Patches 24,25: Add support for port priority in PD692x0 drivers.
Patches 26,27: Add support for port priority in TPS23881 drivers.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v4:
- Remove disconnection policy.
- Rename port priority mode to budget evaluation strategy.
- Add cosmetic changes in PSE core.
- Add support for port priority in PD692x0 driver.
- Link to v3: https://lore.kernel.org/r/20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com

Changes in v3:
- Move power budget to regulator core.
- Add disconnection policies with PIs using the same priority.
- Several fixes on the TPS23881 drivers.
- Several new cosmetic patches.
- Link to v2: https://lore.kernel.org/r/20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com

Changes in v2:
- Rethink the port priority management.
- Add PSE id.
- Add support for PSE power domains.
- Add get power budget regulator constraint.
- Link to v1: https://lore.kernel.org/r/20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com

---
Kory Maincent (27):
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
      net: ethtool: Add support for ethnl_info_init_ntf helper function
      net: pse-pd: Add support for reporting events
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      regulator: core: Resolve supply using of_node from regulator_config
      regulator: Add support for power budget description
      regulator: dt-bindings: Add regulator-power-budget property
      net: pse-pd: Fix missing PI of_node description
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add support for getting budget evaluation strategies
      net: ethtool: Add PSE new budget evaluation strategy support feature
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
      net: pse-pd: tps23881: Add support for static port priority feature
      dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   12 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |    6 +
 .../devicetree/bindings/regulator/regulator.yaml   |    5 +
 Documentation/netlink/specs/ethtool.yaml           |   52 +
 Documentation/networking/ethtool-netlink.rst       |   94 ++
 drivers/net/mdio/fwnode_mdio.c                     |   26 +-
 drivers/net/pse-pd/pd692x0.c                       |  423 ++++++--
 drivers/net/pse-pd/pse_core.c                      | 1029 ++++++++++++++++++--
 drivers/net/pse-pd/pse_regulator.c                 |   23 +-
 drivers/net/pse-pd/tps23881.c                      |  799 +++++++++++++--
 drivers/regulator/core.c                           |  128 ++-
 drivers/regulator/of_regulator.c                   |    3 +
 include/linux/ethtool.h                            |   47 +
 include/linux/ethtool_netlink.h                    |    9 +
 include/linux/pse-pd/pse.h                         |  171 +++-
 include/linux/regulator/consumer.h                 |   21 +
 include/linux/regulator/driver.h                   |    2 +
 include/linux/regulator/machine.h                  |    2 +
 include/uapi/linux/ethtool.h                       |   54 +
 include/uapi/linux/ethtool_netlink.h               |    1 -
 include/uapi/linux/ethtool_netlink_generated.h     |   15 +
 net/ethtool/common.c                               |   12 +
 net/ethtool/common.h                               |    2 +
 net/ethtool/netlink.c                              |    7 +-
 net/ethtool/netlink.h                              |    2 +
 net/ethtool/pse-pd.c                               |   98 +-
 net/ethtool/strset.c                               |    5 +
 27 files changed, 2698 insertions(+), 350 deletions(-)
---
base-commit: 2e22297376fe1aa562799c774c3baac9b6db238b
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


