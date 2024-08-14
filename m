Return-Path: <netdev+bounces-118517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A9951D2A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F0B1F25CC5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D01B372F;
	Wed, 14 Aug 2024 14:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570651B32CB;
	Wed, 14 Aug 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645972; cv=none; b=iD0r4L0s5I7+ksjn8sQ4CSMxkNcs9PU6JoMBW6xv8+/bMhFUnLxVtL01P2iXP9zhDtW2gdX4jLKNKAyt9O8WY4kFYYBDgtF6OmWPbEZbf/2Bhor6Vtw225z4W/CyiE5/PjuRpypU8FBHIBGcvtbg1buuv0CrOVWVMEg1/lUr3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645972; c=relaxed/simple;
	bh=f1qR4+W0bFzKAUighdHabx93fRIPniAA+0cxh4e5ZZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4wrwan/nOEXiQV4GQOQbjiWA81hNXt+y+iG0XzRtzniaLiHVfTINKKoJnnGV4KttFu/8YKfM6+J73aDAy3DBeGOSDscgHvDzcJdL96BIGUT1rPzIXGD1mPyQAFrpiazsmH+7aECr/5MpxJM9pOEyKyLtPIJSgGBaE7Hhqyjp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW1s4fb7z9sPd;
	Wed, 14 Aug 2024 16:32:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vk-uOKUeF9V5; Wed, 14 Aug 2024 16:32:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW1s3jltz9rvV;
	Wed, 14 Aug 2024 16:32:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B7258B775;
	Wed, 14 Aug 2024 16:32:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jrcfJuP41QLs; Wed, 14 Aug 2024 16:32:49 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 42C8B8B764;
	Wed, 14 Aug 2024 16:32:48 +0200 (CEST)
Message-ID: <dc89e5ea-8495-4f1b-a86b-f49f7ac8bd22@csgroup.eu>
Date: Wed, 14 Aug 2024 16:32:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 13/14] net: ethtool: strset: Allow querying
 phy stats by index
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
 <20240709063039.2909536-14-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-14-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
> from the ethnl request to allow query phy stats from each PHY on the
> link.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   net/ethtool/strset.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
> index 56b99606f00b..b3382b3cf325 100644
> --- a/net/ethtool/strset.c
> +++ b/net/ethtool/strset.c
> @@ -126,7 +126,7 @@ struct strset_reply_data {
>   
>   const struct nla_policy ethnl_strset_get_policy[] = {
>   	[ETHTOOL_A_STRSET_HEADER]	=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   	[ETHTOOL_A_STRSET_STRINGSETS]	= { .type = NLA_NESTED },
>   	[ETHTOOL_A_STRSET_COUNTS_ONLY]	= { .type = NLA_FLAG },
>   };
> @@ -233,17 +233,18 @@ static void strset_cleanup_data(struct ethnl_reply_data *reply_base)
>   }
>   
>   static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
> -			      unsigned int id, bool counts_only)
> +			      struct phy_device *phydev, unsigned int id,
> +			      bool counts_only)
>   {
>   	const struct ethtool_phy_ops *phy_ops = ethtool_phy_ops;
>   	const struct ethtool_ops *ops = dev->ethtool_ops;
>   	void *strings;
>   	int count, ret;
>   
> -	if (id == ETH_SS_PHY_STATS && dev->phydev &&
> +	if (id == ETH_SS_PHY_STATS && phydev &&
>   	    !ops->get_ethtool_phy_stats && phy_ops &&
>   	    phy_ops->get_sset_count)
> -		ret = phy_ops->get_sset_count(dev->phydev);
> +		ret = phy_ops->get_sset_count(phydev);
>   	else if (ops->get_sset_count && ops->get_strings)
>   		ret = ops->get_sset_count(dev, id);
>   	else
> @@ -258,10 +259,10 @@ static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
>   		strings = kcalloc(count, ETH_GSTRING_LEN, GFP_KERNEL);
>   		if (!strings)
>   			return -ENOMEM;
> -		if (id == ETH_SS_PHY_STATS && dev->phydev &&
> +		if (id == ETH_SS_PHY_STATS && phydev &&
>   		    !ops->get_ethtool_phy_stats && phy_ops &&
>   		    phy_ops->get_strings)
> -			phy_ops->get_strings(dev->phydev, strings);
> +			phy_ops->get_strings(phydev, strings);
>   		else
>   			ops->get_strings(dev, id, strings);
>   		info->strings = strings;
> @@ -279,6 +280,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>   	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
>   	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
>   	struct net_device *dev = reply_base->dev;
> +	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	unsigned int i;
>   	int ret;
>   
> @@ -296,6 +299,13 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>   		return 0;
>   	}
>   
> +	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
> +				      info->extack);
> +
> +	/* phydev can be NULL, check for errors only */
> +	if (IS_ERR(phydev))
> +		return PTR_ERR(phydev);
> +
>   	ret = ethnl_ops_begin(dev);
>   	if (ret < 0)
>   		goto err_strset;
> @@ -304,7 +314,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>   		    !data->sets[i].per_dev)
>   			continue;
>   
> -		ret = strset_prepare_set(&data->sets[i], dev, i,
> +		ret = strset_prepare_set(&data->sets[i], dev, phydev, i,
>   					 req_info->counts_only);
>   		if (ret < 0)
>   			goto err_ops;

