Return-Path: <netdev+bounces-249361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A529BD173C5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E0CE302E301
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906F37FF51;
	Tue, 13 Jan 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhGdNeqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBD3793B4
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292203; cv=none; b=LDJC3FZcmLgCpA4xii4U51UkqxtR++ZaPOC9QSRLcN1ChQGYqj/Jcb1B0IlnUo+pu95xYgKdlxdRCSnUuNc4dYDjd80ITp4aPCDtRzal9mg9/QkXEY/oop9DZenXmJXGXB6ri0/ca15A4juIsVTmEys7rHToHz+hvs5RggwLVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292203; c=relaxed/simple;
	bh=WKitexKaSSkTVjDc2mcrqkYcv2xu7PPmPUPNSNt8lrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbdUhuXTALuOtbtLcgi9LUQ4bBKQBxyVZPbq8QluwlJ+yyGVBQM48UpVnzXKsNBQ80nif3ljkVyAM3Q9OGYPQy5X6ly9p9TJtCloMgZZKkc0GGP5Hpiw709W6YczPdlZjzzPfMp9WijnmUQGjLsaWVsRTHSG+YIxnzhO6lK3lm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nhGdNeqa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6B96C20878;
	Tue, 13 Jan 2026 08:16:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E5CC60732;
	Tue, 13 Jan 2026 08:16:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C142103C816C;
	Tue, 13 Jan 2026 09:16:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768292198; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DFTdcQRu3RLZAeHzvdzPMi9ROu5HP5BsElgCTN/ghV8=;
	b=nhGdNeqaXVycptEVEE4Yc70hcOUGXufWSKfT8wu4gtRcq1WzO1mSuNqGnQFH2LGDr2R+gP
	6ElUs7mWC8j5+vUMk8Jyr/8fNmuzbIOxmd+Bztwe6wY8eZjbNTC6GB7GP2uIFtJ5J+05Cf
	sgkSlBt2PzCMDjl5/ImNyT4Or2uf35cbaplHI7XuXn5p7Ehq/BsQrjCGlSLyE4An5kAI2l
	3DhD+QBqlcyfBivJT/baNrVvco2aAs3v1gRLQrXIGSYe0vHULlTT1UphRZRG40TFq34Ya/
	dnMljSfbdtH6HFcDz+KX0iPsfhao+Etf+jb8FNXBXl78/mdzC/FNAWy9YttLQg==
Message-ID: <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
Date: Tue, 13 Jan 2026 09:16:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: freescale: ucc_geth: Return early when TBI found
 can't be found
To: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pei Xiao <xiaopei01@kylinos.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Dan Carpenter <dan.carpenter@linaro.org>, kernel test robot <lkp@intel.com>
References: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 13/01/2026 08:43, Maxime Chevallier wrote:
> In ucc_geth's .mac_config(), we configure the TBI block represented by a
> struct phy_device that we get from firmware.
> 
> While porting to phylink, a check was missed to make sure we don't try
> to access the TBI PHY if we can't get it. Let's add it and return early
> in case of error
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202601130843.rFGNXA5a-lkp@intel.com/
> Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Heh that's what I get from sending patches while having mild fever, the
patch title is all wrong and should be :

net: freescale: ucc_geth: Return early when TBI PHY can't be found

I'll wait for the 24h cooldown, grab some honey + milk and resend after :)

Maxime

> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index affd5a6c44e7..131d1210dc4a 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -1602,8 +1602,10 @@ static void ugeth_mac_config(struct phylink_config *config, unsigned int mode,
>  			pr_warn("TBI mode requires that the device tree specify a tbi-handle\n");
>  
>  		tbiphy = of_phy_find_device(ug_info->tbi_node);
> -		if (!tbiphy)
> +		if (!tbiphy) {
>  			pr_warn("Could not get TBI device\n");
> +			return;
> +		}
>  
>  		value = phy_read(tbiphy, ENET_TBI_MII_CR);
>  		value &= ~0x1000;	/* Turn off autonegotiation */


