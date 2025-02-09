Return-Path: <netdev+bounces-164400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E1A2DBDD
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EEE163D0E
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9014B092;
	Sun,  9 Feb 2025 09:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313F13BC35
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739094605; cv=none; b=TgWeVDaKg+vvI+xXVCFO3EXiN6a+FEOLKCPYKVHaAoYuSbjyFkZf75T/cVLs5lGrxwwHeXug+N4tXa3HxCkFnEESDeIwEm8/0+VfuewovWad8qbxoK84x758QYp+5u/+YmztYcBQKFWHRIZNo3KH+WjGDq8vtYqyBaibqqSDa98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739094605; c=relaxed/simple;
	bh=SdldE1rsjy8RfHD9TTHjtKO95k/CZZCtoRAWlss9pS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkkDHqBPgAE4DwKZZm8yYyj6UsGf7QLAsfjjDw6e5rQWIz/Nrm+uPzIwca+6Ao4m8CNgQxbTVvC9YaVoma3TmBPK/3LCgL1E9TWUriTGBoD1l+FR18xVZ0K94dQ5r3hDmCWqPw76Y3W/cnL9Fa2HC6gZSUECEH72A0iBRB6ZKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YrMpP1Dw5z9sRr;
	Sun,  9 Feb 2025 10:28:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDi-BSp373Uq; Sun,  9 Feb 2025 10:28:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YrMpP0PSMz9sRk;
	Sun,  9 Feb 2025 10:28:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F275D8B764;
	Sun,  9 Feb 2025 10:28:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id lJDIllVd9YL8; Sun,  9 Feb 2025 10:28:44 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C8D78B763;
	Sun,  9 Feb 2025 10:28:44 +0100 (CET)
Message-ID: <0203253b-4bda-4e66-b7e6-e74300c44c80@csgroup.eu>
Date: Sun, 9 Feb 2025 10:28:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT
 definitions
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <11be8192-b722-4680-9d1c-3e4323afc27f@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <11be8192-b722-4680-9d1c-3e4323afc27f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/02/2025 à 22:14, Heiner Kallweit a écrit :
> Both identical definitions of PHY_INIT_TIMEOUT aren't used,
> so remove them.

Would be good to say when it stopped being used, ie which commit or 
commits removed its use.

Also why only remove PHY_INIT_TIMEOUT ? For instance PHY_FORCE_TIMEOUT 
also seems to be unused. PHY_CHANGE_TIME as well.

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/freescale/ucc_geth.h | 1 -
>   include/linux/phy.h                       | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
> index 38789faae..03b515240 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.h
> +++ b/drivers/net/ethernet/freescale/ucc_geth.h
> @@ -890,7 +890,6 @@ struct ucc_geth_hardware_statistics {
>   							   addresses */
>   
>   #define TX_TIMEOUT                              (1*HZ)
> -#define PHY_INIT_TIMEOUT                        100000
>   #define PHY_CHANGE_TIME                         2
>   
>   /* Fast Ethernet (10/100 Mbps) */
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3028f8abf..9cb86666c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -293,7 +293,6 @@ static inline long rgmii_clock(int speed)
>   	}
>   }
>   
> -#define PHY_INIT_TIMEOUT	100000
>   #define PHY_FORCE_TIMEOUT	10
>   
>   #define PHY_MAX_ADDR	32


