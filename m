Return-Path: <netdev+bounces-155148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E3A01425
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 12:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F0188467D
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD81B6CE0;
	Sat,  4 Jan 2025 11:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2519B5B8
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735990685; cv=none; b=sdUWIBE11sAodD7s7WFpUq58g+Ypip8uT4ChPZQXmmIzig4lbLAtFAAIlDA3mhPcsNTcAZ71/HbPD9HU/Fy0+O9jo5zKW2IT0Akrtxp2amj7bpDONvZykGhDPaeEEt75UKBeitAAMdw04OgFpLq+fWbk3y3VvVh7tGvLbzqO0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735990685; c=relaxed/simple;
	bh=hTfBgmtas93Tnli5iqk31hrfU/i+fFrxcy5u7ARi5CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxHvLU192W8oeb8pGpvSOVa1hCWc7gPrzEFFheGdaOSAIj3dLDlMffsK5cw3Os26jTQNJ/4D6ZpyF924hLhIMtvZMx8uIVPIYeIj8qshkgXDO6o1ZD02xJKNrB9wPPhlO1ey7zSzPigjTOr3N0iqHkkJDtYZx7qevhLDVvBoZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tU2Sm-0003tQ-95; Sat, 04 Jan 2025 12:37:04 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tU2Si-006pEi-0V;
	Sat, 04 Jan 2025 12:37:00 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tU2Si-003pVb-2a;
	Sat, 04 Jan 2025 12:37:00 +0100
Date: Sat, 4 Jan 2025 12:37:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v4 00/27] Add support for PSE budget evaluation
 strategy
Message-ID: <Z3kdXIbKDLF1nP3f@pengutronix.de>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

please, split this patch set. Some of them can be already taken. The
upper limit for the patch set is 15 patches.

Regards,
Oleksij

On Fri, Jan 03, 2025 at 10:12:49PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series brings support for budget evaluation strategy in the PSE
> subsystem. PSE controllers can set priorities to decide which ports should
> be turned off in case of special events like over-current.
> 
> I have added regulator maintainers to have their opinion on adding power
> budget regulator constraint see patches 17 and 18.
> There are also a core regulator change along the way patch 16.
> I suppose I will need to merge them through the regulator tree.
> Will it be possible to create an immutable tag to have this PSE series
> based on them?
> 
> This patch series adds support for two budget evaluation strategy.
> 1. Static Method:
> 
>    This method involves distributing power based on PD classification.
>    It’s straightforward and stable, the PSE core keeping track of the
>    budget and subtracting the power requested by each PD’s class.
> 
>    Advantages: Every PD gets its promised power at any time, which
>    guarantees reliability.
> 
>    Disadvantages: PD classification steps are large, meaning devices
>    request much more power than they actually need. As a result, the power
>    supply may only operate at, say, 50% capacity, which is inefficient and
>    wastes money.
> 
> 2. Dynamic Method:
> 
>    To address the inefficiencies of the static method, vendors like
>    Microchip have introduced dynamic power budgeting, as seen in the
>    PD692x0 firmware. This method monitors the current consumption per port
>    and subtracts it from the available power budget. When the budget is
>    exceeded, lower-priority ports are shut down.
> 
>    Advantages: This method optimizes resource utilization, saving costs.
> 
>    Disadvantages: Low-priority devices may experience instability.
> 
> The UAPI allows adding support for software port priority mode managed from
> userspace later if needed.
> 
> The patch series is based on this fix merged in net:
> https://lore.kernel.org/netdev/20241220170400.291705-1-kory.maincent@bootlin.com/
> 
> Several Reviewed-by have been removed due to the changes.
> 
> Thanks Oleksij for your pointers.
> 
> Patches 1-9: Cosmetics.
> Patch 10: Adds support for last supported features in the TPS23881 drivers.
> Patches 11,12: Add support for PSE index in PSE core and ethtool.
> Patches 12-14: Add support for interrupt event report in PSE core, ethtool
> 	     and ethtool specs.
> Patch 15: Adds support for interrupt and event report in TPS23881 driver.
> Patch 16: Fix regulator resolve supply
> Patches 17,18: Add support for power budget in regulator framework.
> Patch 19: Cosmetic.
> Patches 20,21: Add support for PSE power domain in PSE core and ethtool.
> Patches 22,23: Add support for port priority in PSE core, ethtool and
> 	       ethtool specs.
> Patches 24,25: Add support for port priority in PD692x0 drivers.
> Patches 26,27: Add support for port priority in TPS23881 drivers.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Changes in v4:
> - Remove disconnection policy.
> - Rename port priority mode to budget evaluation strategy.
> - Add cosmetic changes in PSE core.
> - Add support for port priority in PD692x0 driver.
> - Link to v3: https://lore.kernel.org/r/20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com
> 
> Changes in v3:
> - Move power budget to regulator core.
> - Add disconnection policies with PIs using the same priority.
> - Several fixes on the TPS23881 drivers.
> - Several new cosmetic patches.
> - Link to v2: https://lore.kernel.org/r/20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com
> 
> Changes in v2:
> - Rethink the port priority management.
> - Add PSE id.
> - Add support for PSE power domains.
> - Add get power budget regulator constraint.
> - Link to v1: https://lore.kernel.org/r/20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com
> 
> ---
> Kory Maincent (27):
>       net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
>       net: pse-pd: Avoid setting max_uA in regulator constraints
>       net: pse-pd: Add power limit check
>       net: pse-pd: tps23881: Simplify function returns by removing redundant checks
>       net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
>       net: pse-pd: tps23881: Add missing configuration register after disable
>       net: pse-pd: Use power limit at driver side instead of current limit
>       net: pse-pd: Split ethtool_get_status into multiple callbacks
>       net: pse-pd: Remove is_enabled callback from drivers
>       net: pse-pd: tps23881: Add support for power limit and measurement features
>       net: pse-pd: Add support for PSE device index
>       net: ethtool: Add support for new PSE device index description
>       net: ethtool: Add support for ethnl_info_init_ntf helper function
>       net: pse-pd: Add support for reporting events
>       net: pse-pd: tps23881: Add support for PSE events and interrupts
>       regulator: core: Resolve supply using of_node from regulator_config
>       regulator: Add support for power budget description
>       regulator: dt-bindings: Add regulator-power-budget property
>       net: pse-pd: Fix missing PI of_node description
>       net: pse-pd: Add support for PSE power domains
>       net: ethtool: Add support for new power domains index description
>       net: pse-pd: Add support for getting budget evaluation strategies
>       net: ethtool: Add PSE new budget evaluation strategy support feature
>       net: pse-pd: pd692x0: Add support for PSE PI priority feature
>       dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
>       net: pse-pd: tps23881: Add support for static port priority feature
>       dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description
> 
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   12 +-
>  .../bindings/net/pse-pd/ti,tps23881.yaml           |    6 +
>  .../devicetree/bindings/regulator/regulator.yaml   |    5 +
>  Documentation/netlink/specs/ethtool.yaml           |   52 +
>  Documentation/networking/ethtool-netlink.rst       |   94 ++
>  drivers/net/mdio/fwnode_mdio.c                     |   26 +-
>  drivers/net/pse-pd/pd692x0.c                       |  423 ++++++--
>  drivers/net/pse-pd/pse_core.c                      | 1029 ++++++++++++++++++--
>  drivers/net/pse-pd/pse_regulator.c                 |   23 +-
>  drivers/net/pse-pd/tps23881.c                      |  799 +++++++++++++--
>  drivers/regulator/core.c                           |  128 ++-
>  drivers/regulator/of_regulator.c                   |    3 +
>  include/linux/ethtool.h                            |   47 +
>  include/linux/ethtool_netlink.h                    |    9 +
>  include/linux/pse-pd/pse.h                         |  171 +++-
>  include/linux/regulator/consumer.h                 |   21 +
>  include/linux/regulator/driver.h                   |    2 +
>  include/linux/regulator/machine.h                  |    2 +
>  include/uapi/linux/ethtool.h                       |   54 +
>  include/uapi/linux/ethtool_netlink.h               |    1 -
>  include/uapi/linux/ethtool_netlink_generated.h     |   15 +
>  net/ethtool/common.c                               |   12 +
>  net/ethtool/common.h                               |    2 +
>  net/ethtool/netlink.c                              |    7 +-
>  net/ethtool/netlink.h                              |    2 +
>  net/ethtool/pse-pd.c                               |   98 +-
>  net/ethtool/strset.c                               |    5 +
>  27 files changed, 2698 insertions(+), 350 deletions(-)
> ---
> base-commit: 2e22297376fe1aa562799c774c3baac9b6db238b
> change-id: 20240913-feature_poe_port_prio-a51aed7332ec
> 
> Best regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

