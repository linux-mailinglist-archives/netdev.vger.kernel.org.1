Return-Path: <netdev+bounces-122707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1E962465
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA03F1C20B3F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4916630F;
	Wed, 28 Aug 2024 10:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069815854A;
	Wed, 28 Aug 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839970; cv=none; b=ggav7+/LX890kbtDlzpifoimj0NqX2wLfDIyHcdH9uzniuTTlD4sIu6fSd8+65JK0P33WNauuj5lFIJhW9uIMG3IS0XWkQSgL20ek0zfakFqIcBdVNWBOcN7RrDiNf9B59OcR0MZ9o9wfQeTCrSN9aHMw86xyaD/JM55S5hP7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839970; c=relaxed/simple;
	bh=X8RJJ/vaLQPD3WTubZZIPP+JuPrMkOIPbFs0XWLVNHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZfi0FSBd9XeT0lBuBnb88eA9AMM1q7A4mPH/qPFJzo0KLczTuRtBzBGfpXYri7egYvUSSXxnW9hwv5rNH9c8faceSbBVQHjN/ntrgJDZJ4Kphmj3ok/iijyRDuaQo2IHppkJ03EJJ9tQIUvbXa6xLiXz0FOpGuk7J69GvfN8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv0bL5tmvz9sRy;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g7nm2FoFxJLY; Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv0bL4szYz9sRs;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93F5A8B78F;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gnorZT8uKGam; Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55FEA8B764;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Message-ID: <27fc0052-c7d6-455b-933c-4b1dc6f4a95b@csgroup.eu>
Date: Wed, 28 Aug 2024 12:12:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: ethernet: fs_enet: convert to SPDX
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
 <20240828095103.132625-2-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828095103.132625-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 11:50, Maxime Chevallier a écrit :
> The ENET driver has SPDX tags in the header files, but they were missing
> in the C files. Change the licence information to SPDX format.

AFAIK you have to CC linux-spdx@vger.kernel.org for this kind of change.

> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 5 +----
>   drivers/net/ethernet/freescale/fs_enet/mac-fcc.c      | 5 +----
>   drivers/net/ethernet/freescale/fs_enet/mac-fec.c      | 5 +----
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c      | 5 +----
>   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c  | 5 +----
>   drivers/net/ethernet/freescale/fs_enet/mii-fec.c      | 5 +----
>   6 files changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index cf392faa6105..5bfdd43ffdeb 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
>    *
> @@ -9,10 +10,6 @@
>    *
>    * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
>    * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> index e2ffac9eb2ad..add062928d99 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * FCC driver for Motorola MPC82xx (PQ2).
>    *
> @@ -6,10 +7,6 @@
>    *
>    * 2005 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> index cdc89d83cf07..f75acb3b358f 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Freescale Ethernet controllers
>    *
> @@ -6,10 +7,6 @@
>    *
>    * 2005 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> index 9e89ac2b6ce3..29ba0048396b 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Ethernet on Serial Communications Controller (SCC) driver for Motorola MPC8xx and MPC82xx.
>    *
> @@ -6,10 +7,6 @@
>    *
>    * 2005 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
> index f965a2329055..2e210a003558 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
>    *
> @@ -6,10 +7,6 @@
>    *
>    * 2005 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
> index 7bb69727952a..93d91e8ad0de 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
>    *
> @@ -6,10 +7,6 @@
>    *
>    * 2005 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>    */
>   
>   #include <linux/module.h>

