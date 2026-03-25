Return-Path: <netdev+bounces-271449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPG+Ocuaw2myrwQAu9opvQ
	(envelope-from <netdev+bounces-271449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DDD321556
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF35D3043D51
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AA63264C4;
	Wed, 25 Mar 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yLXahFgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D25315785;
	Wed, 25 Mar 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426803; cv=none; b=RaSmYydz8EbsHytevl/wJjEZsPyBntAt7+h1ngkG/E4rWp1LzYUmzZxPrHn5av+DFjDOIKL0Q9ElRnpIWoEHL5DfYvLkzibJTUvbv/l7VxBa8iY/Z3gcjBUH3VoL59RZFyvJEW6lPBVyVIlCx7+nr7lwBl1lj2uBX++jPysghJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426803; c=relaxed/simple;
	bh=gsDm4WF4pL8na/65eQUn4rHkylqNGUFb7nWI0/g2IpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTZ+unn+xliWwpZ34o4XMqQ9M2GWIegSc+6BSi1IGKGxBa2RsDN10ecGteaCHSnIWLikq0JOFI6Lo9dnlsQSLX9GgnWHxiCDGk/b/FecBJKEQpQQCnItwVbzldvpXTcotXrrJkG/aJGZAUZfpN6IITqbhlVNaLwLoxjZaX+844k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yLXahFgb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 074BC4E427EC;
	Wed, 25 Mar 2026 08:19:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7015601A1;
	Wed, 25 Mar 2026 08:19:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A5B610451365;
	Wed, 25 Mar 2026 09:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774426795; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=hzYSpvmynSZF5iySjwjQNue0ZZet+2NAuSfaHGrfiSs=;
	b=yLXahFgboQFGUyVvEpyFRFF2V6dNgyTBO8K3F6fLTpjmtOF+BIal1Z4QdTlUoXzu9BK/fX
	8ku0Qa6GYcmrYj0gHejzgxFfh7YT9S5FGjRXiCLsff1GmvbipNwSrt8V4SuRqrxKG9jryR
	TCkSmmABivJITBiyYS2HhoYWJdNTotOG/YxrMVuDvUH30+maM8VEDIlvdCTq4k4THkvyPN
	yWekgrkKrM1WXmv8lK4RHGQsl+lgEKSKjKchfSrBXpA5uQkfKQE3FJXavSDenhLxi45H+e
	xCvjsZ0mlkEc+DZCCgZLpbQ72Hii/Kn61SL+wMNt/I5seIV4Jp9JGLOaX9YInQ==
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
Subject: [PATCH net-next v8 00/10] net: phy_port: SFP modules representation and phy_port listing
Date: Wed, 25 Mar 2026 09:19:25 +0100
Message-ID: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271449-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: A9DDD321556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello everyone,

Here's V8 for the phy_port netlink interface (get-only for now).

The highlights of V8 are a fix in the phy_sfp_connect_phy() port
tracking, and more importantly the correction of issues identified by
Jakub during review. The rest is the same :)

This work extends on the recent addition of phy_port representation to enable
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
	Vacant: yes
	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
	Port type: sfp

- Get Combo-ports supported modes, on each port :

# ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Vacant: no
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full

	Port type: mdi

Port for eth1:
	Port id: 2
	Vacant: yes
	Supported MII interfaces : 10gbase-r
	Port type: sfp

- Get Achievable linkmodes on a SFP module (combo port with a DAC in the
SFP cage)

# ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Vacant: no
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi

Port for eth1:
	Port id: 2
	Vacant: no
	Supported MII interfaces : 10gbase-r
	Port type: sfp

Port for eth1:
	Port id: 3
	Vacant: no
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

Changelog :

Changes in v8:
 - Set the new phydev.has_sfp_mod_phy field when we're sure that no
   errors occured
 - Fix formatting of the copyright info in ethnl port
 - Use a policy to validate the range of port_id
 - Use GENL_REQ_ATTR_CHECK
 - alpha-sort headers
 - use u32 in netlink messages
 - return better error codes
 - don't check the skb len, the core does that

Changes in V7:
V7: https://lore.kernel.org/all/20260309152747.702373-1-maxime.chevallier@bootlin.com/
 - Changed the port cleanup path to use list_for_each_entry_continue_reverse
 - Adjusted the cleanup path in phylink for the port vacant state
 - Pass the right cmd for the netlink dump message

Changes in V6:
V6: https://lore.kernel.org/r/20260304145444.442334-1-maxime.chevallier@bootlin.com
 - Added some comments in th mod_port cleanup
 - changed some kmalloc to kmalloc_obj
 - Removed some phy_link_topo_del_port that wasn't needed

Changes in V5:
V5: https://lore.kernel.org/r/20260205092317.755906-1-maxime.chevallier@bootlin.com
 - Fixed a check on a potentially un-initialized pointer, reported by
   Simon
 - Fixed a documentation formatting issue
 - Remove a stray pr_info
 - Rebased on net-next

Changes in V4:
V4 : https://lore.kernel.org/netdev/20260203172839.548524-1-maxime.chevallier@bootlin.com/
 - Add a cleanup patch for the of port parsing
 - Added a match to sync the port's linkmodes with the PHY's for OF
   ports
 - Added RTNL assert in the port_get topo helper
 - nullify the bus port for phylink support
 - Fix some typos

Changes in V3:
V3: https://lore.kernel.org/netdev/20260201151249.642015-1-maxime.chevallier@bootlin.com/
 - Remove the sfp bus ops for nophy, and use .module_start() as
   suggested by Russell
 - Added missing cleanup for the topology, as per AI review
 - Fixed a few typos as per Romain's review
 - Changed "occupied" to "vacant" as per Romain's review
 - Added missing checks for null ports, per AI review

Changes in V2:
V2: https://lore.kernel.org/netdev/20260128204526.170927-1-maxime.chevallier@bootlin.com/
 - Fix the cleanup path of phy_link_topo_add_phy, as per AI review
 - Fix the cleanup path of phy_sfp_probe, as per AI review
 - Fix the call-site of the disconnect_nophy sfp bus ops, per AI review
 - Fix the netdev-less case uin phylink, per AI review
 - Fix the prototype of phy_link_topo_get_port for the stubs
 - Dropped patch 11. It ended-up breaking 'allnoconfig', so instead we
   built a phy_interface_names array in net/ethtool/netlink.c
 - Fix an ethool-netlink spec discrepancy with the type of an attribute
 - Fix the size computation in the netlink port API
 - Fix the cleanup path in the netlink port API

V1: https://lore.kernel.org/netdev/20260127134202.8208-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (10):
  net: phy: phy_link_topology: Add a helper for opportunistic alloc
  net: phy: phy_link_topology: Track ports in phy_link_topology
  net: phylink: Register a phy_port for MAC-driven SFP busses
  net: phy: Create SFP phy_port before registering upstream
  net: phy: Represent PHY-less SFP modules with phy_port
  net: phylink: Represent PHY-less SFP modules with phy_port
  net: phy: phy_port: Store information about a MII port's vacant state
  net: phy: phy_link_topology: Add a helper to retrieve ports
  netlink: specs: Add ethernet port listing with ethtool
  net: ethtool: Introduce ethtool command to list ports

 Documentation/netlink/specs/ethtool.yaml      |  50 +++
 Documentation/networking/ethtool-netlink.rst  |  35 ++
 MAINTAINERS                                   |   1 +
 drivers/net/phy/phy-caps.h                    |   2 +
 drivers/net/phy/phy_caps.c                    |  26 ++
 drivers/net/phy/phy_device.c                  | 156 +++++++-
 drivers/net/phy/phy_link_topology.c           |  82 +++-
 drivers/net/phy/phylink.c                     | 132 ++++++-
 include/linux/phy.h                           |   6 +
 include/linux/phy_link_topology.h             |  39 ++
 include/linux/phy_port.h                      |   6 +
 .../uapi/linux/ethtool_netlink_generated.h    |  19 +
 net/core/dev.c                                |   1 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/netlink.c                         |  25 ++
 net/ethtool/netlink.h                         |   8 +
 net/ethtool/port.c                            | 368 ++++++++++++++++++
 17 files changed, 928 insertions(+), 30 deletions(-)
 create mode 100644 net/ethtool/port.c

-- 
2.49.0


