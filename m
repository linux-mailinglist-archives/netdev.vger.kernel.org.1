Return-Path: <netdev+bounces-118513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C2951D22
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A182C1C24BB4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D441B32D2;
	Wed, 14 Aug 2024 14:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519726BFB5;
	Wed, 14 Aug 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645897; cv=none; b=TiuVHBjpYbTfaJTfbFZgFtvjHkJlOKGHrEFK8t3U8bXWIDbt7PLYqlIOlUbC2CO1Cx8lCh9DIDz9gA0GpXQOkmeAQ/avLpGkxq1mkpQ5sSTF5KN7zk+zJV19IXKXRgCQ161tn8ZMd6Bg69iwO8wVKDZ8Mql6Q8Z5p6s7Bh3YUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645897; c=relaxed/simple;
	bh=LNhiI9uy8P+E0BuRMbJgo5aLV1XbJlZgKjFILC3OJXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luI5dMAMtkELzmCDDPe+JF5KHPW73mgp5yaHxxHXpvGYvNm6Cws2euDkxz6lbI9lkXcMS1uj90CHCZ+0HTytKoBmd/+nXvQGQlBOJUwWWZevFgybtV7L/3NscGbYVIaHdJkjMEivw/SKgMtHNY17LLrUjd4DtYXwC1G5mkK5GXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW0Q6jVzz9sPd;
	Wed, 14 Aug 2024 16:31:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDz2V66-OaH6; Wed, 14 Aug 2024 16:31:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW0Q5Scrz9rvV;
	Wed, 14 Aug 2024 16:31:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A79818B775;
	Wed, 14 Aug 2024 16:31:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id GmZTgVk-2gxk; Wed, 14 Aug 2024 16:31:34 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 859358B764;
	Wed, 14 Aug 2024 16:31:33 +0200 (CEST)
Message-ID: <bbb40362-4552-44d2-aaae-b8b1729efc26@csgroup.eu>
Date: Wed, 14 Aug 2024 16:31:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 09/14] net: ethtool: plca: Target the command
 to the requested PHY
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
 <20240709063039.2909536-10-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> PLCA is a PHY-specific command. Instead of targeting the command
> towards dev->phydev, use the request to pick the targeted PHY.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   net/ethtool/plca.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
> index b1e2e3b5027f..d95d92f173a6 100644
> --- a/net/ethtool/plca.c
> +++ b/net/ethtool/plca.c
> @@ -25,7 +25,7 @@ struct plca_reply_data {
>   
>   const struct nla_policy ethnl_plca_get_cfg_policy[] = {
>   	[ETHTOOL_A_PLCA_HEADER]		=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   };
>   
>   static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
> @@ -58,10 +58,14 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
>   	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
>   	struct net_device *dev = reply_base->dev;
>   	const struct ethtool_phy_ops *ops;
> +	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	int ret;
>   
> +	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
> +				      info->extack);
>   	// check that the PHY device is available and connected
> -	if (!dev->phydev) {
> +	if (IS_ERR_OR_NULL(phydev)) {
>   		ret = -EOPNOTSUPP;
>   		goto out;
>   	}
> @@ -80,7 +84,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
>   	memset(&data->plca_cfg, 0xff,
>   	       sizeof_field(struct plca_reply_data, plca_cfg));
>   
> -	ret = ops->get_plca_cfg(dev->phydev, &data->plca_cfg);
> +	ret = ops->get_plca_cfg(phydev, &data->plca_cfg);
>   	ethnl_ops_complete(dev);
>   
>   out:
> @@ -129,7 +133,7 @@ static int plca_get_cfg_fill_reply(struct sk_buff *skb,
>   
>   const struct nla_policy ethnl_plca_set_cfg_policy[] = {
>   	[ETHTOOL_A_PLCA_HEADER]		=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   	[ETHTOOL_A_PLCA_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
>   	[ETHTOOL_A_PLCA_NODE_ID]	= NLA_POLICY_MAX(NLA_U32, 255),
>   	[ETHTOOL_A_PLCA_NODE_CNT]	= NLA_POLICY_RANGE(NLA_U32, 1, 255),
> @@ -141,15 +145,17 @@ const struct nla_policy ethnl_plca_set_cfg_policy[] = {
>   static int
>   ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
>   {
> -	struct net_device *dev = req_info->dev;
>   	const struct ethtool_phy_ops *ops;
>   	struct nlattr **tb = info->attrs;
>   	struct phy_plca_cfg plca_cfg;
> +	struct phy_device *phydev;
>   	bool mod = false;
>   	int ret;
>   
> +	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
> +				      info->extack);
>   	// check that the PHY device is available and connected
> -	if (!dev->phydev)
> +	if (IS_ERR_OR_NULL(phydev))
>   		return -EOPNOTSUPP;
>   
>   	ops = ethtool_phy_ops;
> @@ -168,7 +174,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
>   	if (!mod)
>   		return 0;
>   
> -	ret = ops->set_plca_cfg(dev->phydev, &plca_cfg, info->extack);
> +	ret = ops->set_plca_cfg(phydev, &plca_cfg, info->extack);
>   	return ret < 0 ? ret : 1;
>   }
>   
> @@ -191,7 +197,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
>   
>   const struct nla_policy ethnl_plca_get_status_policy[] = {
>   	[ETHTOOL_A_PLCA_HEADER]		=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>   };
>   
>   static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
> @@ -201,10 +207,14 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
>   	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
>   	struct net_device *dev = reply_base->dev;
>   	const struct ethtool_phy_ops *ops;
> +	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>   	int ret;
>   
> +	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
> +				      info->extack);
>   	// check that the PHY device is available and connected
> -	if (!dev->phydev) {
> +	if (IS_ERR_OR_NULL(phydev)) {
>   		ret = -EOPNOTSUPP;
>   		goto out;
>   	}
> @@ -223,7 +233,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
>   	memset(&data->plca_st, 0xff,
>   	       sizeof_field(struct plca_reply_data, plca_st));
>   
> -	ret = ops->get_plca_status(dev->phydev, &data->plca_st);
> +	ret = ops->get_plca_status(phydev, &data->plca_st);
>   	ethnl_ops_complete(dev);
>   out:
>   	return ret;

