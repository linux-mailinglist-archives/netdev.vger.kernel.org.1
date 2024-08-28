Return-Path: <netdev+bounces-122716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9499624D9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC8C1F2165C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232715B98E;
	Wed, 28 Aug 2024 10:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128E86250;
	Wed, 28 Aug 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840749; cv=none; b=ezVB/zsUHE4yXmxRAEUc+jQfoCc6LSn0RWXU+YtY34AjEMd5ql0d6OKQrqHY/4PHnggK64u+4Ji3iBpfXxZlT1M/oajPUtDsit7/pLjl924K53wHRQtaMt4l+CWvGLXF56J+lyb3yoVUQFLgFeFf/8Ax13x4NCc14keBYTIbYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840749; c=relaxed/simple;
	bh=JVHznT6bcFHg9YxsqvQTnr/LL9HRHAtz4npSyzepqeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPjhtHAAH19hjOS7WvV5tNOq4NlR1ChnoDBZhMTyF2oMpJJNkzH49DwTgY42ajmpbuaG7X+T0fgPsMszm1BAjHCp7PQ8UhYLOS5yUJ1oqiZ0qdfV9jdkVB5EwoywHP35ffbVHZNqz7VlZv7k6ZLnDBXkhr+/Xg/ZvTRiNchgs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv0tL2JWkz9sRy;
	Wed, 28 Aug 2024 12:25:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0csFDQsZFCn; Wed, 28 Aug 2024 12:25:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv0tL1PSXz9sRs;
	Wed, 28 Aug 2024 12:25:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 168FC8B78F;
	Wed, 28 Aug 2024 12:25:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hrt9wAXyhJ1B; Wed, 28 Aug 2024 12:25:46 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BB88F8B764;
	Wed, 28 Aug 2024 12:25:45 +0200 (CEST)
Message-ID: <cbe686fb-9bcf-4f25-ab26-a5330d10ad99@csgroup.eu>
Date: Wed, 28 Aug 2024 12:25:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: ethernet: fs_enet: drop unused phy_info
 and mii_if_info
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
 <20240828095103.132625-5-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828095103.132625-5-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 11:51, Maxime Chevallier a écrit :
> There's no user of the struct phy_info, the 'phy' field and the
> mii_if_info in the fs_enet driver, probably dating back when phylib
> wasn't as widely used.  Drop these from the driver code.

Seems like they haven't been used since commit 5b4b8454344a ("[PATCH] 
FS_ENET: use PAL for mii management")

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet.h | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> index abe4dc97e52a..781f506c933c 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> @@ -92,14 +92,6 @@ struct fs_ops {
>   	void (*tx_restart)(struct net_device *dev);
>   };
>   
> -struct phy_info {
> -	unsigned int id;
> -	const char *name;
> -	void (*startup) (struct net_device * dev);
> -	void (*shutdown) (struct net_device * dev);
> -	void (*ack_int) (struct net_device * dev);
> -};
> -
>   /* The FEC stores dest/src/type, data, and checksum for receive packets.
>    */
>   #define MAX_MTU 1508		/* Allow fullsized pppoe packets over VLAN */
> @@ -153,10 +145,7 @@ struct fs_enet_private {
>   	cbd_t __iomem *cur_rx;
>   	cbd_t __iomem *cur_tx;
>   	int tx_free;
> -	const struct phy_info *phy;
>   	u32 msg_enable;
> -	struct mii_if_info mii_if;
> -	unsigned int last_mii_status;
>   	int interrupt;
>   
>   	int oldduplex, oldspeed, oldlink;	/* current settings */

