Return-Path: <netdev+bounces-118518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B7951D2B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3352F1C25334
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A71B32D5;
	Wed, 14 Aug 2024 14:33:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4501B1402;
	Wed, 14 Aug 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645994; cv=none; b=WzM5NdeK63mS8GuZi6NVtK3oQWdZckIcADHPb4XU2gst3RXBogUXUShb9G/uBq6tGFf+XBLOZ2n1IH8t0PK0JuOQe87k4Bt8NFcpGAowjCdeUUQCf+Tv3Qrj06a7c10Qbrk/4d6LdKmW46Lo4oWRs7w+VcnYnlbAFliluiW4wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645994; c=relaxed/simple;
	bh=f/0TfDpNr3ka2QfzeJ9gHh9Tdz+8tmTzkovrfCZCu4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5htLIn2jxdU/MdKNfRo7gigASHpoV+hNWuuMT6wrSdcAbigiQoDOgxUkWDZAncnsgd3VCbgHxUxVC7w/a194hZtvuGhdCn/aH/TY4t8ZA8XPKSoUCQvSMCxh0iJ7cpi7A821IwD0+l2hSDcrAI7Drv+yzdUZZnrw8ZLpMTEhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW2H4MNzz9sPd;
	Wed, 14 Aug 2024 16:33:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xj1D524CbZhN; Wed, 14 Aug 2024 16:33:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW2H3Cv9z9rvV;
	Wed, 14 Aug 2024 16:33:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C71D8B775;
	Wed, 14 Aug 2024 16:33:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id tBvz--HUkUlN; Wed, 14 Aug 2024 16:33:11 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3525C8B764;
	Wed, 14 Aug 2024 16:33:10 +0200 (CEST)
Message-ID: <ff993b7e-d52e-4a66-9b89-a3b711fcee3d@csgroup.eu>
Date: Wed, 14 Aug 2024 16:33:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 14/14] Documentation: networking: document
 phy_link_topology
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-15-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-15-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> The newly introduced phy_link_topology tracks all ethernet PHYs that are
> attached to a netdevice. Document the base principle, internal and
> external APIs. As the phy_link_topology is expected to be extended, this
> documentation will hold any further improvements and additions made
> relative to topology handling.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   Documentation/networking/ethtool-netlink.rst  |   3 +
>   Documentation/networking/index.rst            |   1 +
>   .../networking/phy-link-topology.rst          | 121 ++++++++++++++++++
>   3 files changed, 125 insertions(+)
>   create mode 100644 Documentation/networking/phy-link-topology.rst
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index d9f0c0dba1e5..81ddb750c1f9 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2189,10 +2189,13 @@ Retrieve information about a given Ethernet PHY sitting on the link. The DO
>   operation returns all available information about dev->phydev. User can also
>   specify a PHY_INDEX, in which case the DO request returns information about that
>   specific PHY.
> +
>   As there can be more than one PHY, the DUMP operation can be used to list the PHYs
>   present on a given interface, by passing an interface index or name in
>   the dump request.
>   
> +For more information, refer to :ref:`phy_link_topology`
> +
>   Request contents:
>   
>     ====================================  ======  ==========================
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index d1af04b952f8..c71b87346178 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -91,6 +91,7 @@ Contents:
>      operstates
>      packet_mmap
>      phonet
> +   phy-link-topology
>      pktgen
>      plip
>      ppp_generic
> diff --git a/Documentation/networking/phy-link-topology.rst b/Documentation/networking/phy-link-topology.rst
> new file mode 100644
> index 000000000000..4dec5d7d6513
> --- /dev/null
> +++ b/Documentation/networking/phy-link-topology.rst
> @@ -0,0 +1,121 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _phy_link_topology:
> +
> +=================
> +PHY link topology
> +=================
> +
> +Overview
> +========
> +
> +The PHY link topology representation in the networking stack aims at representing
> +the hardware layout for any given Ethernet link.
> +
> +An Ethernet interface from userspace's point of view is nothing but a
> +:c:type:`struct net_device <net_device>`, which exposes configuration options
> +through the legacy ioctls and the ethtool netlink commands. The base assumption
> +when designing these configuration APIs were that the link looks something like ::
> +
> +  +-----------------------+        +----------+      +--------------+
> +  | Ethernet Controller / |        | Ethernet |      | Connector /  |
> +  |       MAC             | ------ |   PHY    | ---- |    Port      | ---... to LP
> +  +-----------------------+        +----------+      +--------------+
> +  struct net_device               struct phy_device
> +
> +Commands that needs to configure the PHY will go through the net_device.phydev
> +field to reach the PHY and perform the relevant configuration.
> +
> +This assumption falls apart in more complex topologies that can arise when,
> +for example, using SFP transceivers (although that's not the only specific case).
> +
> +Here, we have 2 basic scenarios. Either the MAC is able to output a serialized
> +interface, that can directly be fed to an SFP cage, such as SGMII, 1000BaseX,
> +10GBaseR, etc.
> +
> +The link topology then looks like this (when an SFP module is inserted) ::
> +
> +  +-----+  SGMII  +------------+
> +  | MAC | ------- | SFP Module |
> +  +-----+         +------------+
> +
> +Knowing that some modules embed a PHY, the actual link is more like ::
> +
> +  +-----+  SGMII   +--------------+
> +  | MAC | -------- | PHY (on SFP) |
> +  +-----+          +--------------+
> +
> +In this case, the SFP PHY is handled by phylib, and registered by phylink through
> +its SFP upstream ops.
> +
> +Now some Ethernet controllers aren't able to output a serialized interface, so
> +we can't directly connect them to an SFP cage. However, some PHYs can be used
> +as media-converters, to translate the non-serialized MAC MII interface to a
> +serialized MII interface fed to the SFP ::
> +
> +  +-----+  RGMII  +-----------------------+  SGMII  +--------------+
> +  | MAC | ------- | PHY (media converter) | ------- | PHY (on SFP) |
> +  +-----+         +-----------------------+         +--------------+
> +
> +This is where the model of having a single net_device.phydev pointer shows its
> +limitations, as we now have 2 PHYs on the link.
> +
> +The phy_link topology framework aims at providing a way to keep track of every
> +PHY on the link, for use by both kernel drivers and subsystems, but also to
> +report the topology to userspace, allowing to target individual PHYs in configuration
> +commands.
> +
> +API
> +===
> +
> +The :c:type:`struct phy_link_topology <phy_link_topology>` is a per-netdevice
> +resource, that gets initialized at netdevice creation. Once it's initialized,
> +it is then possible to register PHYs to the topology through :
> +
> +:c:func:`phy_link_topo_add_phy`
> +
> +Besides registering the PHY to the topology, this call will also assign a unique
> +index to the PHY, which can then be reported to userspace to refer to this PHY
> +(akin to the ifindex). This index is a u32, ranging from 1 to U32_MAX. The value
> +0 is reserved to indicate the PHY doesn't belong to any topology yet.
> +
> +The PHY can then be removed from the topology through
> +
> +:c:func:`phy_link_topo_del_phy`
> +
> +These function are already hooked into the phylib subsystem, so all PHYs that
> +are linked to a net_device through :c:func:`phy_attach_direct` will automatically
> +join the netdev's topology.
> +
> +PHYs that are on a SFP module will also be automatically registered IF the SFP
> +upstream is phylink (so, no media-converter).
> +
> +PHY drivers that can be used as SFP upstream need to call :c:func:`phy_sfp_attach_phy`
> +and :c:func:`phy_sfp_detach_phy`, which can be used as a
> +.attach_phy / .detach_phy implementation for the
> +:c:type:`struct sfp_upstream_ops <sfp_upstream_ops>`.
> +
> +UAPI
> +====
> +
> +There exist a set of netlink commands to query the link topology from userspace,
> +see ``Documentation/networking/ethtool-netlink.rst``.
> +
> +The whole point of having a topology representation is to assign the phyindex
> +field in :c:type:`struct phy_device <phy_device>`. This index is reported to
> +userspace using the ``ETHTOOL_MSG_PHY_GET`` ethtnl command. Performing a DUMP operation
> +will result in all PHYs from all net_device being listed. The DUMP command
> +accepts either a ``ETHTOOL_A_HEADER_DEV_INDEX`` or ``ETHTOOL_A_HEADER_DEV_NAME``
> +to be passed in the request to filter the DUMP to a single net_device.
> +
> +The retrieved index can then be passed as a request parameter using the
> +``ETHTOOL_A_HEADER_PHY_INDEX`` field in the following ethnl commands :
> +
> +* ``ETHTOOL_MSG_STRSET_GET`` to get the stats string set from a given PHY
> +* ``ETHTOOL_MSG_CABLE_TEST_ACT`` and ``ETHTOOL_MSG_CABLE_TEST_ACT``, to perform
> +  cable testing on a given PHY on the link (most likely the outermost PHY)
> +* ``ETHTOOL_MSG_PSE_SET`` and ``ETHTOOL_MSG_PSE_GET`` for PHY-controlled PoE and PSE settings
> +* ``ETHTOOL_MSG_PLCA_GET_CFG``, ``ETHTOOL_MSG_PLCA_SET_CFG`` and ``ETHTOOL_MSG_PLCA_GET_STATUS``
> +  to set the PLCA (Physical Layer Collision Avoidance) parameters
> +
> +Note that the PHY index can be passed to other requests, which will silently
> +ignore it if present and irrelevant.

