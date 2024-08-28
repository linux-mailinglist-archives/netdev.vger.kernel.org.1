Return-Path: <netdev+bounces-122717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10999624E5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4872841A9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2716B720;
	Wed, 28 Aug 2024 10:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208A1684B4;
	Wed, 28 Aug 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840866; cv=none; b=gRNISbVpJK3TQrHMBac+29yx7Vxds2iYzmlw9El0plkA119XhcK5OTh61dZwCj30xuAuARBT4yDasTeKYPBFFMrPnkbxWprjkXhBV3tccxiXyQdU2hqmvw5bnmtS8b+5F0xOez9uCD05Ay5kjE9Ge702Piqg4jompyQX5e1fa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840866; c=relaxed/simple;
	bh=huXmjRiW3j314C61u2zxWWGkGlPndQoW15cKOvK93gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OE7lecCsYrpThW/NXJ5RgdUQNc6/uEI/b48P8yXMW8mlt+xYWzFg3urxXINmtrmq7OdVQg5bPWzdn2kLEVBrpnNNbNtsA7KWg2oPJrJEORDbxlh2mhV9RY0ZE1Qn/LIOBGQzzo+zCA0XjZxkbF6+2BBLGXy1XHPse2kpzR1IE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv0wb19Lrz9sRy;
	Wed, 28 Aug 2024 12:27:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id atgXkts7Rrq7; Wed, 28 Aug 2024 12:27:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv0wb0BKxz9sRs;
	Wed, 28 Aug 2024 12:27:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E6DFF8B78F;
	Wed, 28 Aug 2024 12:27:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kG13dQI6O_yt; Wed, 28 Aug 2024 12:27:42 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AA2E98B764;
	Wed, 28 Aug 2024 12:27:42 +0200 (CEST)
Message-ID: <7d62064e-c303-4d74-b213-a29ce16dbb39@csgroup.eu>
Date: Wed, 28 Aug 2024 12:27:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: ethernet: fs_enet: fcc: use macros for
 speed and duplex values
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
 <20240828095103.132625-6-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828095103.132625-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 11:51, Maxime Chevallier a écrit :
> The PHY speed and duplex should be manipulated using the SPEED_XXX and
> DUPLEX_XXX macros available. Use it in the fcc, fec and scc MAC for fs_enet.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/net/ethernet/freescale/fs_enet/mac-fcc.c | 4 ++--
>   drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 2 +-
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> index add062928d99..056909156b4f 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> @@ -361,7 +361,7 @@ static void restart(struct net_device *dev)
>   
>   	/* adjust to speed (for RMII mode) */
>   	if (fpi->use_rmii) {
> -		if (dev->phydev->speed == 100)
> +		if (dev->phydev->speed == SPEED_100)
>   			C8(fcccp, fcc_gfemr, 0x20);
>   		else
>   			S8(fcccp, fcc_gfemr, 0x20);
> @@ -387,7 +387,7 @@ static void restart(struct net_device *dev)
>   		S32(fccp, fcc_fpsmr, FCC_PSMR_RMII);
>   
>   	/* adjust to duplex mode */
> -	if (dev->phydev->duplex)
> +	if (dev->phydev->duplex == DUPLEX_FULL)
>   		S32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
>   	else
>   		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> index f75acb3b358f..855ee9e3f042 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> @@ -309,7 +309,7 @@ static void restart(struct net_device *dev)
>   	/*
>   	 * adjust to duplex mode
>   	 */
> -	if (dev->phydev->duplex) {
> +	if (dev->phydev->duplex == DUPLEX_FULL) {
>   		FC(fecp, r_cntrl, FEC_RCNTRL_DRT);
>   		FS(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD enable */
>   	} else {
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> index 29ba0048396b..9e5e29312c27 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> @@ -338,7 +338,7 @@ static void restart(struct net_device *dev)
>   	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
>   
>   	/* Set full duplex mode if needed */
> -	if (dev->phydev->duplex)
> +	if (dev->phydev->duplex == DUPLEX_FULL)
>   		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
>   
>   	/* Restore multicast and promiscuous settings */

