Return-Path: <netdev+bounces-240747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F4C78EE5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A64035742B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C0311C39;
	Fri, 21 Nov 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n5935cNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393342E093A
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726654; cv=none; b=sbwQiIkCLX7t7/j0Y1Qd+p0enHBgu78F30+RKnJ2rOUE4F0FTWK5V3NFr08Lc+GG+HnzTCyaoCnuDqKDoq/Jy4+GEzKiKlg/XYrCIEd4skMgLC6yX0uoQT4QZ8n2LOxNQJmlgbHlrRPNVehWop/9UCebM2EGOM42Hb2w2C5cVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726654; c=relaxed/simple;
	bh=dz9VKLn0WQmLrrBOnOtOHsQhLdntAvihYrX2caW9MZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glmLF3e/XNIh+1shi5R7StbrAmcxH0Vpr8hejdTT+s03GCIdvoLGEdhXiUaFkho+L8yXtPxgbgF8csO8KPUF7HYVHNOfYysqpkS32nr3AveY2kZlzNlk7g00aWhFWecyGVmAP/bmaLhW2CId41V8W9LOcna7EOdvjr+mjNy2lG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n5935cNg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 65ACB1A1C7F;
	Fri, 21 Nov 2025 12:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A6D760719;
	Fri, 21 Nov 2025 12:04:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA70310371CF6;
	Fri, 21 Nov 2025 13:04:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763726647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qn8oEqQjcmd6CEjxpqT3b2zYZp/Y/5mbvScnLweKkFw=;
	b=n5935cNgfgt/0SF2ev9crcoHzpfkF0g6foJM3k7UmpMwTDk86jFs3UAeEj1LqKVdKITqwQ
	EbJ9O/jKx4bmFHRpuN9JwYl2EXIcGxJXmIxDm9ToYFTBPCdaAJfRI8lC3ly77Zklij9e12
	Gay1jhrRaWeniUh8nV42T8Wb/211FDXCW7Ui2lu3tSSYWKG6oAZ5iD7w+wuYlp1+cZYbxu
	qFl19DUhLy3KRzA+FnsTwrNuBUhVd5e3Jwilo65wWaptX5rkLQtyzhmc9xW53zTwicKpaL
	81/pe2Wk49SR/i7igajQHrxFt6dKwfw0QVnz2OxaV6LCtXBzHMzFTWBgMtiFHw==
Message-ID: <0423d36b-05fa-4a2b-858c-e6ef5ff1560d@bootlin.com>
Date: Fri, 21 Nov 2025 13:03:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: move stmmac_mac_finish() after
 stmmac_mac_config()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vMNoX-0000000FTBd-3Oup@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vMNoX-0000000FTBd-3Oup@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 21/11/2025 10:52, Russell King (Oracle) wrote:
> Keep the functions and initialisers in the same order that they exist
> in phylink_mac_ops. This is the preferred order for phylink methods
> as it arranges the configuration methods by called order.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 970c670fc302..d16e522c1e7d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -932,7 +932,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
>  	if (priv->plat->mac_finish)
> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
> +		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> +				       interface);

This is just a line wrap, I don't really see the connexion with the
commit log :( Some missing hunks in the commit maybe ?

Maxime

>  
>  	return 0;
>  }


