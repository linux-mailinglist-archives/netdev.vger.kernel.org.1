Return-Path: <netdev+bounces-253879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBXROifCeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:48:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0A9518D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F456306C9FD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906535A95C;
	Tue, 27 Jan 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sh7/BsHm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659C359FB6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521343; cv=none; b=qCCA3wsoxVcCf4egalcsVMi30PiUeId5ogXj0H/PZqDZBx0UfbWLzmBgZQaOOwL1hSVm8ihvHCHUudcFKZEGUoVbRnBRjuH7oaWbud59CDIWFGWhSilQnToxtPc744ZTQFuCKJx7HHEfaysgucr887B6Yrb0F/mylv/feirOO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521343; c=relaxed/simple;
	bh=DB9kEdPNCukofrnc0NQOSFwRY85g+LWgn59ph42lBvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ9bdUgHlLq6XZEhd44hlUYPZcieJrO5dTKYSU/wdV9SaXWv+mEnXPtNYV1QE17/WZvWwcv19AbZCcVkHPznztgMPtCxPiX4oRE6nbfosbX8aO9ygqdtDx2xvqicY18s2/VECNVs1HSa72D5F9ghkYzAvRoZ4+3YhYXh/Wl2uzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sh7/BsHm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 723BAC211C0;
	Tue, 27 Jan 2026 13:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C9F0606F5;
	Tue, 27 Jan 2026 13:42:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2FD6119A864C;
	Tue, 27 Jan 2026 14:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521338; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=oKlXBMUh5ZhX/zwuswGc13LoRx5lpPr3lRXPECma5Ek=;
	b=sh7/BsHmT5al/NZJ/LsO/PLqT65iZvw9/smYulxgS2H8xH7N29a5kKTFu3YmQGG2IroZVX
	IjW+NekKAl6YBF097DHNn9xk/iF9WmGx0CPYAyWsgd+dcsK81fWc8PrBoxNcLOmXspqMvj
	vuXo9rt6xFQ5azIWffscz6ZcB6qINie98rUVm33C3kueCPlaszZgftsai0j4wnGmvZEJW+
	+o/lZjDM9yvMgMiz6sMQvlI/tefR1ZEFgavOg8uAH9e8RiWEmREN8ITAbFkWZK3S8Rcyut
	j2IXJnoRu9jGFBHZ8SBLfKy6GvyiUs6ywXs7BK7TRjmvfY0FOCq8/VMi1Aguyw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next 00/13] net: phy_port: SFP modules representation and phy_port listing
Date: Tue, 27 Jan 2026 14:41:48 +0100
Message-ID: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-253879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 81E0A9518D
X-Rspamd-Action: no action

Hello everyone,

This series is another step towards dealing with multi-port interfaces.

It build on the recent addition of phy_port representation to enable
listing the front-facing ports of an interface. For now, we don't control
these ports, we merely list their presence and their capabilities.

As the most common use-case of multi-port interfaces is combo-ports that
provide both RJ45 and SFP connectors on a single MAC, there's a lot of
SFP stuff in this series.

This series is in 2 main parts. The first one aims at representing the
SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
by far the most common cases for multi-connector setups.

The second part is the netlink interface to list those ports, now that
most use-cases are covered.

Let's see what we can do with some examples of the new ethtool API :

- Get MII interfaces supported by an empty SFP cage :

# ethtool --show-ports eth3

Port for eth3:
	Port id: 1
	Occupied: no
	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
	Port type: sfp


- Get Combo-ports supported modes, on each port :

# ethtool --show-ports eth0

Port for eth0:
	Port id: 1
	Occupied: no
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Half 1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi

Port for eth0:
	Port id: 2
	Occupied: no
	Supported MII interfaces : 10gbase-r
	Port type: sfp
	

- Get Achievable linkmodes on a SFP module (combo port with a DAC in the
SFP cage)

# ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Occupied: no
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Half 1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi

Port for eth1:
	Port id: 2
	Occupied: yes
	Supported MII interfaces : 10gbase-r
	Port type: sfp

Port for eth1:
	Port id: 3
	Occupied: no
	Supported link modes:  10000baseCR/Full
	Port type: mdi

Note that here, we have 3 ports :
 - The Copper port
 - The SFP Cage itself, marked as 'occupied'
 - The SFP module

This series builds on top of phy_port and phy_link_topology to allow
tracking the ports of an interface. We maintain a list of supported
linkmodes/interfaces on each port, which allows for fine-grained
reporting of each port's capability.

What this series doesn't do :
 - We don't support selecting which port is active. This is the next step.
 - We only support PHY-driven combo ports. The end-goal of this whole
   journey that started with phy_link_topology is to get support for MII
   muxes, such as the one we have on the Turris Omnia. This will eventually
   be upstreamed as well.

If you want to play around with it, here's [1] the patched ethtool that I've
been using to produce the outputs above.

Thanks !

Maxime

[1] : https://github.com/minimaxwell/ethtool/tree/mc/ethtool_port

Maxime Chevallier (13):
  net: phy: phy_port: Correctly recompute the port's linkmodes
  net: phy: phy_link_topology: Add a helper for opportunistic alloc
  net: phy: phy_link_topology: Track ports in phy_link_topology
  net: phylink: Register a phy_port for MAC-driven SFP busses
  net: phy: Create SFP phy_port before registering usptream
  net: sfp: Add a sfp-bus ops when connecting a module without PHY
  net: phy: Represent PHY-less SFP modules with phy_port
  net: phylink: Represent PHY-less SFP modules with phy_port
  net: phy: phy_port: Store information about a MII port's occupancy
  net: phy: phy_link_topology: Add a helper to retrieve ports
  net: phy: store phy_modes in a static array
  netlink: specs: Add ethernet port listing with ethtool
  net: ethtool: Introduce ethtool command to list ports

 Documentation/netlink/specs/ethtool.yaml      |  50 +++
 Documentation/networking/ethtool-netlink.rst  |  35 ++
 MAINTAINERS                                   |   1 +
 drivers/net/phy/phy-caps.h                    |   2 +
 drivers/net/phy/phy_caps.c                    |  26 ++
 drivers/net/phy/phy_device.c                  | 104 ++++-
 drivers/net/phy/phy_link_topology.c           |  80 +++-
 drivers/net/phy/phy_port.c                    |   9 +-
 drivers/net/phy/phylink.c                     | 121 ++++++
 drivers/net/phy/sfp-bus.c                     |  20 +
 drivers/net/phy/sfp.c                         |  12 +
 drivers/net/phy/sfp.h                         |   2 +
 include/linux/phy.h                           |  88 +----
 include/linux/phy_link_topology.h             |  34 ++
 include/linux/phy_port.h                      |   5 +
 include/linux/sfp.h                           |   5 +
 .../uapi/linux/ethtool_netlink_generated.h    |  19 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/common.c                          |  44 +++
 net/ethtool/netlink.c                         |  11 +
 net/ethtool/netlink.h                         |   5 +
 net/ethtool/port.c                            | 373 ++++++++++++++++++
 22 files changed, 943 insertions(+), 105 deletions(-)
 create mode 100644 net/ethtool/port.c

-- 
2.49.0


