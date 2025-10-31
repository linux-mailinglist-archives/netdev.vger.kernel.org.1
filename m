Return-Path: <netdev+bounces-234660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35681C257FF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E2D5625FC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EFE34B682;
	Fri, 31 Oct 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fz+gedH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296A1F37D4
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919534; cv=none; b=nimRe4JO+1gaBuY2I6pioFH7SAG6sFPDNRf0HXP59fDt6ZgMVLPuPPrOKzQBcKeBgl7zMmwvPZekkHI4GfhW9fB8kWiDrn969mqea2AfjtHmqFE9EM46Eny08g25oWUzTRLXljrGIB8XSDRZ4ym+eHQslShLuaGjHjrruAnQkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919534; c=relaxed/simple;
	bh=zzVlqW9hueD8hoeNeOTWFaheBheTqIFRhvAiJ5OyXvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEdfYQWctN7qknVgh/rljBttaFkNWEz0fVbaN+Mg8ZEDtEJYmPpvyRofLfdDJxs3nXhrCMuPC9vCuZ77kB2BTkT+vNzkH5ui+HiwcxzYOgCRyOHMBrZE+2EzPFxAtW0uG22mGfUPjNCCPlbjcyt8H4S1sM7nrZbdAVvWjXaWECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fz+gedH/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 759121A1751;
	Fri, 31 Oct 2025 14:05:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49A0B60704;
	Fri, 31 Oct 2025 14:05:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52D671181802A;
	Fri, 31 Oct 2025 15:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761919528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MN4LGdyaF3Stts7YNtw3SrpLzrqRulD1HBAMpz3BSCw=;
	b=fz+gedH/0XIjpPd9R60mnvB89JedvPNybQstaMf83GBkQoB7683iJRPxXblxf+B525AxMm
	NKlJH+AwNarLLohcqmZotsvviPKHt1DhfmYuxCOHd4am3+fSL8vyPx9TGq9oUO2MGYQU9q
	4eirpZfcpgMkjHevamAoxVhZFvJqK3sVi597uAMoaeKvXBMlQbkkoVeFnHACZDF4jTKPo4
	M4cU3pxAC7qjr/ZggkShk/1edkyiuX0EcQOS1oHR61QOvYiqifUu/4Ww/UoFPmh/u4m77j
	q5sSkfqQScsGxVdGPVDtpCVYiSRY5nmj8XbPoMPKH8ATlRDWldDIbQzSwVkDeg==
Message-ID: <d7ebdab4-64ab-472d-9bb8-87fa30092c4d@bootlin.com>
Date: Fri, 31 Oct 2025 15:05:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: microchip: Fix a link check in
 ksz9477_pcs_read()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Tristram Ha <tristram.ha@microchip.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aQSz_euUg0Ja8ZaH@stanley.mountain>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aQSz_euUg0Ja8ZaH@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Dan,

On 31/10/2025 14:05, Dan Carpenter wrote:
> The BMSR_LSTATUS define is 0x4 but the "p->phydev.link" variable
> is a 1 bit bitfield in a u32.  Since 4 doesn't fit in 0-1 range
> it means that ".link" is always set to false.  Add a !! to fix
> this.
> 
> Fixes: e8c35bfce4c1 ("net: dsa: microchip: Add SGMII port support to KSZ9477 switch")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Interesting issue. I was able to confirm that your patch is
correct by testing on ksz9477 (p->phydev.link stays at 0 no matter
what without this fix), but I was wondering why things weren't
broken even with this bug.

The first thing is that this path is only taken when using 1000BaseX
on that port. I've tested with 1000BaseX, and I'm still getting link
up. That's because we don't do anything at all with p->phydev.link.

The "val" value is returned, and interpreted by the pcs-xpcs.c driver,
who correctly uses "!!(val & BMSR_LSTATUS)", reports the link state to
phylink, and link shows as up/down as expected.

Looking at the code, it seems that p->phydev is almost completely useless,
and is merely used to store the current speed/link/duplex settings.

So all in all your patch is correct and can be merged, but it doesn't
fix a real bug, and the long term thing to do would simply be to get
rid of p->phydev...

Maybe someone from Microchip can comment on that and why we have that
p->phydev, and can we safely remove that ? We could replace it with
3 fields in ksz_port : link, speed and duplex.

Maxime

> ---
> This is from a new static checker warning Harshit and I wrote.  Untested.
> 
>  drivers/net/dsa/microchip/ksz9477.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index d747ea1c41a7..cf67d6377719 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -244,7 +244,7 @@ static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
>  				p->phydev.link = 0;
>  			}
>  		} else if (reg == MII_BMSR) {
> -			p->phydev.link = (val & BMSR_LSTATUS);
> +			p->phydev.link = !!(val & BMSR_LSTATUS);
>  		}
>  	}
>  


