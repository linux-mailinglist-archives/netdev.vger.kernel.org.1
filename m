Return-Path: <netdev+bounces-118516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE31951D29
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0977283504
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE11B32DC;
	Wed, 14 Aug 2024 14:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA618C910;
	Wed, 14 Aug 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645953; cv=none; b=svJhBwVPxP9aiTv3Uw6AzMcg5JnV5Z9VkoZTemO5vNUM7uLDxYlTQ96ymuAvMO4F37xWlhd4XSQFAMoAFVYzN99KHrL4WiDlJawhUJqXt7nvk7N5UraW4IHGTB95q3qiOH0JhPu9DYThAm8CH91QDQxN+wSnYRImt8lNzajh024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645953; c=relaxed/simple;
	bh=rnIspg/b+qNCmw2AmmawRk7u35BmHzC9w5njJ6FuKHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNsdqZNyBBrjx0y/IOk1peQ4aTkMUgZ9jmjgnBwqGT7THO1dUCo6SYkj9p29LUZqs/+aeWjL8/1K87ItLuktWZEA1O+5XjpWi7QrVIZcaDBxvAqakRx+ARQVaQaOz8asMyXyE77rQnhkIeMep/NuWWpd8q/WQ586gfHlRbbmwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW1T3NRZz9sRk;
	Wed, 14 Aug 2024 16:32:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TPikG9QZIQBi; Wed, 14 Aug 2024 16:32:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW1T2VWwz9rvV;
	Wed, 14 Aug 2024 16:32:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 42FB98B775;
	Wed, 14 Aug 2024 16:32:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id i-V6Luc4qD0H; Wed, 14 Aug 2024 16:32:29 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 253618B764;
	Wed, 14 Aug 2024 16:32:28 +0200 (CEST)
Message-ID: <0855ecf2-3059-4daa-9553-e6afe556da3b@csgroup.eu>
Date: Wed, 14 Aug 2024 16:32:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 12/14] net: ethtool: strset: Remove
 unnecessary check on genl_info
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
 Romain Gantois <romain.gantois@bootlin.com>,
 kernel test robot <lkp@intel.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-13-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-13-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> All call paths coming from genetlink initialize the genl_info structure,
> so that command handlers may use them.
> 
> Remove an un-needed check for NULL when crafting error messages in the
> strset command. This prevents smatch from assuming this pointer may be
> NULL, and therefore warn if it's being used without a NULL check.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Simon Horman <horms@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202407030529.aOYGI0u2-lkp@intel.com/

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   net/ethtool/strset.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
> index c678b484a079..56b99606f00b 100644
> --- a/net/ethtool/strset.c
> +++ b/net/ethtool/strset.c
> @@ -289,8 +289,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
>   		for (i = 0; i < ETH_SS_COUNT; i++) {
>   			if ((req_info->req_ids & (1U << i)) &&
>   			    data->sets[i].per_dev) {
> -				if (info)
> -					GENL_SET_ERR_MSG(info, "requested per device strings without dev");
> +				GENL_SET_ERR_MSG(info, "requested per device strings without dev");
>   				return -EINVAL;
>   			}
>   		}

