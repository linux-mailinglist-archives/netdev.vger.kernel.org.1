Return-Path: <netdev+bounces-143863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390889C499A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE13C1F25C78
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03681BD032;
	Mon, 11 Nov 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akaAap7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C719E81F;
	Mon, 11 Nov 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366755; cv=none; b=LrT0LjBHuaeYZThwI3UtpCc2HhfiOPzoV1Ees627w39AL81lt8K/pus68QjnFPVkrLG8T/u4agxER0PHjxTzh/zuYF0/F/E52CZUzAIqcMa6H6hXeIpKmPii4U5QwhuzIWnSJULEPVvNfziZ+sRVwnSM7cFHOGraLxLZCJmlyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366755; c=relaxed/simple;
	bh=c2g2mVYOajF7xw474Vvv14L9F6H7JqDPHmvCzYZBW+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLi4hRozcsY54dNs1Cr8HIgPcTXSPRYHse7hB8Dnjl+TQp8PDU4IcPRQAJodvOnje+XWSrHEXUyswg8rRJ5R14tMk9m0zPDZq8Tf2Z8ONYERPCC9/GB44MAv2mvLLcMdqzaJ1R/OQYB3z4o/BsBMOjbKVFYKEVgsf1RRmfFOTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akaAap7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501D4C4CECF;
	Mon, 11 Nov 2024 23:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731366754;
	bh=c2g2mVYOajF7xw474Vvv14L9F6H7JqDPHmvCzYZBW+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akaAap7bZdCcvghRXU632ZbWWRwnTy59vjWaBmnnyZbf8AO2RDw5ekYivtSVo2dWg
	 S9rGhKJ8u3Q+yonVwLRJSSNiNyoJEK3Ytk6xBT9VqiMnNnqXA37bQ4g8ORN//JNohc
	 IxqSiLGeNJBRJ21ehsDNbEJTF475jxohKGQ3w0sfW7LYVwiDqvsH1yECLdKt48ePdq
	 x7rEBEUzIOhEW3cshNMWsL3VZpMJdiXNrv0dmo9kZynMCSTXdtuXgsDNtCt2kBTQpV
	 GXIwZ9AvHkXlOzX8RaI7xF65X5fFzHk/BNmFIsnz3WRsP4Ejqm3mGRaGKOJvAcw/nK
	 eAcVUfv7RAz5Q==
Date: Mon, 11 Nov 2024 15:12:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 08/10] net: ethtool: tsinfo: Add support
 for reading tsinfo for a specific hwtstamp provider
Message-ID: <20241111151232.6827f48b@kernel.org>
In-Reply-To: <20241030-feature_ptp_netnext-v19-8-94f8aadc9d5c@bootlin.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-8-94f8aadc9d5c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 14:54:50 +0100 Kory Maincent wrote:
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 0d62363dbd9d..a50cddd36b6d 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -745,12 +745,45 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
>  	return 0;
>  }
>  
> +int ethtool_get_ts_info_by_phc(struct net_device *dev,
> +			       struct kernel_ethtool_ts_info *info,
> +			       struct hwtstamp_provider *hwtstamp)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	int err = 0;
> +
> +	memset(info, 0, sizeof(*info));
> +	info->cmd = ETHTOOL_GET_TS_INFO;
> +	info->phc_qualifier = hwtstamp->qualifier;
> +	info->phc_index = -1;
> +
> +	if (!netdev_support_hwtstamp(dev, hwtstamp))
> +		return -ENODEV;
> +
> +	if (ptp_clock_from_phylib(hwtstamp->ptp) &&
> +	    phy_has_tsinfo(ptp_clock_phydev(hwtstamp->ptp)))
> +		err = phy_ts_info(ptp_clock_phydev(hwtstamp->ptp), info);
> +
> +	if (ptp_clock_from_netdev(hwtstamp->ptp) && ops->get_ts_info)
> +		err = ops->get_ts_info(dev, info);

Is it not possibly to cleanly fold this into __ethtool_get_ts_info()?
looks like half of this function is a copy/paste.

> +	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
> +				 SOF_TIMESTAMPING_SOFTWARE;
> +
> +	return err;
> +}

> +++ b/net/ethtool/ts.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _NET_ETHTOOL_TS_H
> +#define _NET_ETHTOOL_TS_H
> +
> +#include "netlink.h"
> +
> +struct hwtst_provider {
> +	int index;
> +	u32 qualifier;
> +};
> +
> +static const struct nla_policy
> +ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
> +		NLA_POLICY_MIN(NLA_S32, 0),
> +	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
> +		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
> +};
> +
> +static inline int ts_parse_hwtst_provider(const struct nlattr *nest,

why not just put it in tsinfo.c and call it from the tsconfig.c; 
or vice versa ??

> +					  struct hwtst_provider *hwtst,
> +					  struct netlink_ext_ack *extack,
> +					  bool *mod)
> +{
> +	struct nlattr *tb[ARRAY_SIZE(ethnl_ts_hwtst_prov_policy)];
> +	int ret;
> +
> +	ret = nla_parse_nested(tb,
> +			       ARRAY_SIZE(ethnl_ts_hwtst_prov_policy) - 1,
> +			       nest,

> +	if (req->hwtst.index != -1) {
> +		struct hwtstamp_provider hwtstamp;

please name the hwtstamp_provider variables something more sensible
Maybe tsprov or hwprov? We already call the timestamps and the config
hwtstamp. It makes the code much harder to read.

> -	if (ts_info->phc_index >= 0)
> +	if (ts_info->phc_index >= 0) {
> +		/* _TSINFO_HWTSTAMP_PROVIDER */
> +		len += 2 * nla_total_size(sizeof(u32));

and a nest?

>  		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
> +	}
>  	if (req_base->flags & ETHTOOL_FLAG_STATS)
>  		len += nla_total_size(0) + /* _TSINFO_STATS */
>  		       nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STAT_CNT;

> +	reply_data->base.dev = NULL;
> +	if (!ret && ehdr)
> +		genlmsg_end(skb, ehdr);
> +	else
> +		genlmsg_cancel(skb, ehdr);

please use goto and a separate path for error handling
clarity > LoC


