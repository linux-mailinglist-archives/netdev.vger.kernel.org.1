Return-Path: <netdev+bounces-118509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625A951D1B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0AD1C21974
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579621B32AD;
	Wed, 14 Aug 2024 14:30:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A121B1402;
	Wed, 14 Aug 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645815; cv=none; b=HxhLfiUgZuXr5hOU1jzJHWEvCngxyEq8Y9a9Ebi53wvJtC66WWyH//iSTqnrC4fMBgcTDeYWrACQVZixrUlOazNQ2z791Ha7YeRVS13ybr6JAYXdL/qhR4K4VtvqlN3ZygZXXLjpG2d/0a3d7l0PBHLat6UuGTLnQn+p3iX0VX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645815; c=relaxed/simple;
	bh=n9p6CYuUaSziX61kgwIUw8zWxo61GMlbBRHeSDxJ4X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loruQyTlZ14Q3sxBIS9I3nM+yXWLZPeqFg6usXySNgIiJjl+kvCeLcKA19+eeI+ml9NLO5n1lRS0/9PVz7E6HXJEveV5my7sLOX+6cynG/pLRzEQzF9wdZpWrTpwYJDCIu27MipwPTO+y0R8CJkv2AXR0sB8QYPmasQnAk2Te6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkVyq3vW0z9sPd;
	Wed, 14 Aug 2024 16:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWEwU_4D6iVa; Wed, 14 Aug 2024 16:30:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkVyq2Kd8z9rvV;
	Wed, 14 Aug 2024 16:30:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D0298B775;
	Wed, 14 Aug 2024 16:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ly2_tQL1cWNV; Wed, 14 Aug 2024 16:30:11 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 04FA28B764;
	Wed, 14 Aug 2024 16:30:09 +0200 (CEST)
Message-ID: <9404b230-b9b7-4e0e-8573-621e3e55ed47@csgroup.eu>
Date: Wed, 14 Aug 2024 16:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 05/14] net: ethtool: Allow passing a phy
 index for some commands
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
 <20240709063039.2909536-6-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> Some netlink commands are target towards ethernet PHYs, to control some
> of their features. As there's several such commands, add the ability to
> pass a PHY index in the ethnl request, which will populate the generic
> ethnl_req_info with the passed phy_index.
> 
> Add a helper that netlink command handlers need to use to grab the
> targeted PHY from the req_info. This helper needs to hold rtnl_lock()
> while interacting with the PHY, as it may be removed at any point.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   Documentation/networking/ethtool-netlink.rst |  7 +++
>   include/uapi/linux/ethtool_netlink.h         |  1 +
>   net/ethtool/netlink.c                        | 57 +++++++++++++++++++-
>   net/ethtool/netlink.h                        | 28 ++++++++++
>   4 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 3ab423b80e91..a6ea3716315f 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -57,6 +57,7 @@ Structure of this header is
>     ``ETHTOOL_A_HEADER_DEV_INDEX``  u32     device ifindex
>     ``ETHTOOL_A_HEADER_DEV_NAME``   string  device name
>     ``ETHTOOL_A_HEADER_FLAGS``      u32     flags common for all requests
> +  ``ETHTOOL_A_HEADER_PHY_INDEX``  u32     phy device index
>     ==============================  ======  =============================
>   
>   ``ETHTOOL_A_HEADER_DEV_INDEX`` and ``ETHTOOL_A_HEADER_DEV_NAME`` identify the
> @@ -81,6 +82,12 @@ the behaviour is backward compatible, i.e. requests from old clients not aware
>   of the flag should be interpreted the way the client expects. A client must
>   not set flags it does not understand.
>   
> +``ETHTOOL_A_HEADER_PHY_INDEX`` identifies the Ethernet PHY the message relates to.
> +As there are numerous commands that are related to PHY configuration, and because
> +there may be more than one PHY on the link, the PHY index can be passed in the
> +request for the commands that needs it. It is, however, not mandatory, and if it
> +is not passed for commands that target a PHY, the net_device.phydev pointer
> +is used.
>   
>   Bit sets
>   ========
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index 6d5bdcc67631..c5af23139e63 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -134,6 +134,7 @@ enum {
>   	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
>   	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
>   	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
> +	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
>   
>   	/* add new constants above here */
>   	__ETHTOOL_A_HEADER_CNT,
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index cb1eea00e349..7b95571a6efb 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -2,6 +2,7 @@
>   
>   #include <net/sock.h>
>   #include <linux/ethtool_netlink.h>
> +#include <linux/phy_link_topology.h>
>   #include <linux/pm_runtime.h>
>   #include "netlink.h"
>   #include "module_fw.h"
> @@ -31,6 +32,24 @@ const struct nla_policy ethnl_header_policy_stats[] = {
>   							  ETHTOOL_FLAGS_STATS),
>   };
>   
> +const struct nla_policy ethnl_header_policy_phy[] = {
> +	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
> +	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
> +					    .len = ALTIFNAMSIZ - 1 },
> +	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
> +							  ETHTOOL_FLAGS_BASIC),
> +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
> +};
> +
> +const struct nla_policy ethnl_header_policy_phy_stats[] = {
> +	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
> +	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
> +					    .len = ALTIFNAMSIZ - 1 },
> +	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
> +							  ETHTOOL_FLAGS_STATS),
> +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
> +};
> +
>   int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
>   			enum ethnl_sock_type type)
>   {
> @@ -119,7 +138,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>   			       const struct nlattr *header, struct net *net,
>   			       struct netlink_ext_ack *extack, bool require_dev)
>   {
> -	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy)];
> +	struct nlattr *tb[ARRAY_SIZE(ethnl_header_policy_phy)];
>   	const struct nlattr *devname_attr;
>   	struct net_device *dev = NULL;
>   	u32 flags = 0;
> @@ -134,7 +153,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>   	/* No validation here, command policy should have a nested policy set
>   	 * for the header, therefore validation should have already been done.
>   	 */
> -	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy) - 1, header,
> +	ret = nla_parse_nested(tb, ARRAY_SIZE(ethnl_header_policy_phy) - 1, header,
>   			       NULL, extack);
>   	if (ret < 0)
>   		return ret;
> @@ -175,11 +194,45 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>   		return -EINVAL;
>   	}
>   
> +	if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> +		if (dev) {
> +			req_info->phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
> +		} else {
> +			NL_SET_ERR_MSG_ATTR(extack, header,
> +					    "phy_index set without a netdev");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	req_info->dev = dev;
>   	req_info->flags = flags;
>   	return 0;
>   }
>   
> +struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
> +					const struct nlattr *header,
> +					struct netlink_ext_ack *extack)
> +{
> +	struct phy_device *phydev;
> +
> +	ASSERT_RTNL();
> +
> +	if (!req_info->dev)
> +		return NULL;
> +
> +	if (!req_info->phy_index)
> +		return req_info->dev->phydev;
> +
> +	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
> +	if (!phydev) {
> +		NL_SET_ERR_MSG_ATTR(extack, header,
> +				    "no phy matching phyindex");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return phydev;
> +}
> +
>   /**
>    * ethnl_fill_reply_header() - Put common header into a reply message
>    * @skb:      skb with the message
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index 46ec273a87c5..4db16048f8d4 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -251,6 +251,9 @@ static inline unsigned int ethnl_reply_header_size(void)
>    * @dev:   network device the request is for (may be null)
>    * @dev_tracker: refcount tracker for @dev reference
>    * @flags: request flags common for all request types
> + * @phy_index: phy_device index connected to @dev this request is for. Can be
> + *	       0 if the request doesn't target a phy, or if the @dev's attached
> + *	       phy is targeted.
>    *
>    * This is a common base for request specific structures holding data from
>    * parsed userspace request. These always embed struct ethnl_req_info at
> @@ -260,6 +263,7 @@ struct ethnl_req_info {
>   	struct net_device	*dev;
>   	netdevice_tracker	dev_tracker;
>   	u32			flags;
> +	u32			phy_index;
>   };
>   
>   static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
> @@ -267,6 +271,27 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
>   	netdev_put(req_info->dev, &req_info->dev_tracker);
>   }
>   
> +/**
> + * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
> + *			    if any. Must be called under rntl_lock().
> + * @req_info:	The ethnl request to get the phy from.
> + * @header:	The netlink header, used for error reporting.
> + * @extack:	The netlink extended ACK, for error reporting.
> + *
> + * The caller must hold RTNL, until it's done interacting with the returned
> + * phy_device.
> + *
> + * Return: A phy_device pointer corresponding either to the passed phy_index
> + *	   if one is provided. If not, the phy_device attached to the
> + *	   net_device targeted by this request is returned. If there's no
> + *	   targeted net_device, or no phy_device is attached, NULL is
> + *	   returned. If the provided phy_index is invalid, an error pointer
> + *	   is returned.
> + */
> +struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
> +					const struct nlattr *header,
> +					struct netlink_ext_ack *extack);
> +
>   /**
>    * struct ethnl_reply_data - base type of reply data for GET requests
>    * @dev:       device for current reply message; in single shot requests it is
> @@ -409,9 +434,12 @@ extern const struct ethnl_request_ops ethnl_rss_request_ops;
>   extern const struct ethnl_request_ops ethnl_plca_cfg_request_ops;
>   extern const struct ethnl_request_ops ethnl_plca_status_request_ops;
>   extern const struct ethnl_request_ops ethnl_mm_request_ops;
> +extern const struct ethnl_request_ops ethnl_phy_request_ops;
>   
>   extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
>   extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
> +extern const struct nla_policy ethnl_header_policy_phy[ETHTOOL_A_HEADER_PHY_INDEX + 1];
> +extern const struct nla_policy ethnl_header_policy_phy_stats[ETHTOOL_A_HEADER_PHY_INDEX + 1];
>   extern const struct nla_policy ethnl_strset_get_policy[ETHTOOL_A_STRSET_COUNTS_ONLY + 1];
>   extern const struct nla_policy ethnl_linkinfo_get_policy[ETHTOOL_A_LINKINFO_HEADER + 1];
>   extern const struct nla_policy ethnl_linkinfo_set_policy[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL + 1];

