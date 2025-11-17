Return-Path: <netdev+bounces-239185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A650C6531E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F8367A68
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B894284889;
	Mon, 17 Nov 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B07iGtlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75925783C;
	Mon, 17 Nov 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396946; cv=none; b=iRbf+XxHXgQ3AOkxR+/rdpizxGjYrypNmgSzucd5B5BkYEK771vJP100sO0I8gD3zegGy1aNFI/DQwCWTt0vxt8b8cDtEXX3E8PnATEvXWH2MQPYHHDkYWYLWFHrJ730z2KLnUdpaFuupQSp8/4mnXpuVBTwK2DU0hBraV5qIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396946; c=relaxed/simple;
	bh=1JgwqFGykbb+DdJXxG3Sbi0wrOn0sAtkl9O9ReZsJY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCbKVuxyu0mKeOdwhfMBw+VC1jWFXcuEvyYKzdpZz793CoiUTzoIFfxgeQs8iJro3rDsNHDgt0OPM+eJWyc7tQA4HTPcugwruRaCM0AINK2hvSZoUYH+m11f10mF2tiNdOiY721ZvMJDwh2rByeFDyrhImpnWEJ8RXDGN4gXvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B07iGtlM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 600BAC12659;
	Mon, 17 Nov 2025 16:28:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CE17606B9;
	Mon, 17 Nov 2025 16:29:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25DD910371CD5;
	Mon, 17 Nov 2025 17:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763396939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/8rEW52ZU9jTKfpuvDFTdL+kX6XiF8shmrFAuzoUCN4=;
	b=B07iGtlMJWrYwgQE63pUV04vqaTdwRisXlDLcymQKIIHpyvaB+rYKHj+czIMgU8OZHT0nL
	g45G1IoHOTuxK63Rha1ROlAHciNwo5ixMMZgIhTY/IZJI0xQgTi9efpzvgFlhZNZJD9S8u
	feq4sTelgz6Enm59XNRQvsjchafAnV4WnID8TjDgRDRN2G1QJJvhDELU8lq+I8t+XN7xRn
	1QpK9mqrOV++XwstKL+IG5YNhgtsfo8mstbd/2cL1liWFdwnisWTEKPvFHrbl3Adkqc6Pb
	6Zj2TtxNYhjfNxl1YWocnBmGPafr2gMkdUfiGePiWWWX+AdVlqqi1Bk/9fV97g==
Message-ID: <fed4309a-af05-4222-b9af-2ff8c655f3df@bootlin.com>
Date: Mon, 17 Nov 2025 17:28:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 4/5] net: dsa: microchip: Free previously
 initialized ports on init failures
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
 <20251117-ksz-fix-v4-4-13e1da58a492@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251117-ksz-fix-v4-4-13e1da58a492@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Bastien,

On 17/11/2025 14:05, Bastien Curutchet (Schneider Electric) wrote:
> If ksz_pirq_setup() fails after at least one successful port
> initialization, the goto jumps directly to the global irq freeing,
> leaking the resources of the previously initialized ports.
> 
> Fix the goto jump to release all the potentially initialized ports.
> Remove the no-longer used out_girq label.
> 
> Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index a622416d966330187ee062b2f44051ddf4ce2a78..2b6f7abea00776fafff0c1774cab297a7ef261da 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3035,7 +3035,7 @@ static int ksz_setup(struct dsa_switch *ds)
>  		dsa_switch_for_each_user_port(dp, dev->ds) {
>  			ret = ksz_pirq_setup(dev, dp->index);
>  			if (ret)
> -				goto out_girq;
> +				goto out_pirq;
>  
>  			if (dev->info->ptp_capable) {
>  				ret = ksz_ptp_irq_setup(ds, dp->index);
> @@ -3083,10 +3083,8 @@ static int ksz_setup(struct dsa_switch *ds)
>  			if (dev->ports[dp->index].pirq.domain)
>  				ksz_irq_free(&dev->ports[dp->index].pirq);
>  		}
> -	}
> -out_girq:
> -	if (dev->irq > 0)
>  		ksz_irq_free(&dev->girq);
> +	}
>  
>  	return ret;
>  }
> 

Looking at the code, I think it's still not enough, but feel free
to correct me.

In ksz_setup(), in one single loop we do :

dsa_switch_for_each_user_port(dp, dev->ds) {
	ksz_pirq_setup();

	ksz_ptp_irq_setup();
}

However when anything fails in the above loop, we jump straight
to out_pirq, which doesn't clean the ptpirq :(

Maxime





