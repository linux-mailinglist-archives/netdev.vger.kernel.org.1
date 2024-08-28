Return-Path: <netdev+bounces-122712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABC96249B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1CF1C24273
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAA169382;
	Wed, 28 Aug 2024 10:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F58168489;
	Wed, 28 Aug 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840335; cv=none; b=MZyme0z+MoeAz4dZ/mc/yqN48ghAj+t/DOdsrxxgHbg8hyNrZFZ8xTLLZVBgqTj0IG/bHuNV0VHkFjsHh7ZNPBRgd8skJT+Yy7b8SXDw024iO7GCFs2vNLpdh34ZYh5GbOk/h0Fwep6aFRiAEJCy9bgBzmf80SISEjDb33GgRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840335; c=relaxed/simple;
	bh=76yP45lTQsYzgwmytYtHMj0baj7C0seddbIc1mDNeEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfd03wyFqnSM8YFpEat9yQXDEK0S0aiuWelhomfB2xNydDV7bzirDdaNZoUfnO2FPj/qRiDCoKFAtXsiO690QpDcbQWh0qbrWsp3wBfClVTOUqs30AMuf/ThkLZN1V6El11fWTmVjucsTwq9BEz4ZyEgJ7VSEFR5Tu+T8AHMNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv0kM5zJMz9sRy;
	Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wconnBVW9-Lt; Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv0kM5B9Sz9sRs;
	Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A05508B78F;
	Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id E3dYZevYEYVw; Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CE418B764;
	Wed, 28 Aug 2024 12:18:51 +0200 (CEST)
Message-ID: <cdea1768-b44c-4bf5-931b-10f9357ed4cb@csgroup.eu>
Date: Wed, 28 Aug 2024 12:18:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: ethernet: fs_enet: drop the
 .adjust_link custom fs_ops
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
 <20240828095103.132625-4-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828095103.132625-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 11:50, Maxime Chevallier a écrit :
> There's no in-tree user for the fs_ops .adjust_link() function, so we
> can always use the generic one in fe_enet-main.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 7 +------
>   drivers/net/ethernet/freescale/fs_enet/fs_enet.h      | 1 -
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index 2b48a2a5e32d..caca81b3ccb6 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&fep->lock, flags);
> -
> -	if (fep->ops->adjust_link)
> -		fep->ops->adjust_link(dev);
> -	else
> -		generic_adjust_link(dev);
> -
> +	generic_adjust_link(dev);
>   	spin_unlock_irqrestore(&fep->lock, flags);
>   }
>   
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> index 21c07ac05225..abe4dc97e52a 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> @@ -77,7 +77,6 @@ struct fs_ops {
>   	void (*free_bd)(struct net_device *dev);
>   	void (*cleanup_data)(struct net_device *dev);
>   	void (*set_multicast_list)(struct net_device *dev);
> -	void (*adjust_link)(struct net_device *dev);
>   	void (*restart)(struct net_device *dev);
>   	void (*stop)(struct net_device *dev);
>   	void (*napi_clear_event)(struct net_device *dev);

