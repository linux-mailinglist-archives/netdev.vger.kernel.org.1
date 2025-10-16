Return-Path: <netdev+bounces-229895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23FBE1EA4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A90F19A7E22
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29772517AA;
	Thu, 16 Oct 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhdy/LOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6D2D46B2
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599565; cv=none; b=dDbd9Xfa6iI/7MXnwMpsaTQFKplhUuaDQ7+3AF1J+qAjKkcPePWnPFCuAKuos1fZlKisW8oBsYsJszQBXGxs1S4+qimjc7RVftXqMLmOr6Vapy4Lot5P5ogqPmi44STPxDenSpixBuxV5X8dPYvbYWgp22BMSjG1J/MYWaJcbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599565; c=relaxed/simple;
	bh=sybAJFBCSgX05g0edVzHl+gxJZtDke+jlMEnnuVUKBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acZ/LIdroWY3ujy4MO+0FQhfl0kkwFKEE/ahKEE7DXSTo0XQ/0vQn5o0rjHifY+jZfD+Ygg6EJhnGsAifx8bzp8jL1BjZyNQv2ygT42d7dtjyLpUGGFMRW7ShBy+e+kJg2Chhb9zdRmgjvCrwWFSOGiprVEaqpEdiAkYYEA6t00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nhdy/LOF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 367DB4E410F3;
	Thu, 16 Oct 2025 07:26:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F17706062C;
	Thu, 16 Oct 2025 07:26:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC9F1102F22AA;
	Thu, 16 Oct 2025 09:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760599560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FHZj/DgqA8o4wPCtAZaC2EX3z/hRb2lVa/qz3oUIQRY=;
	b=nhdy/LOFyku5r+RwonmgR91X0cHcHLcLhRrjVm5kKUxu2v9THrznH6afS9BZkAmFUncu5e
	OynM1Ju3DnbJRv+4/9sklTJe8eGxLry2C//BG8Tx9gI0VwR+h9dj/g2Jc1vBXmPz72yAPT
	6qv3iHGKZCXL4h4MkZXL3CnZy/OoHw0cQ9v6KrvXwLeGCOZEPMx2Gu4PUcLFZSsuMBjnmT
	o7N6jWIXgY8nlfU5UbRkcvMvBh0J/dBvwgyYQDhVLrbAgMyjQfVGPKCPWsuWqo4K98x7Kg
	iAKm8zzQMXqzzPnarxCkuH8bn0lXohtGhpo6oJG/KQGm6/LXPiO3W1stqwijag==
Message-ID: <ade8145a-b236-4190-8289-2a44c6df0fa4@bootlin.com>
Date: Thu, 16 Oct 2025 09:25:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: stmmac: rearrange tc_init()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945Y-0000000Ameb-2gDI@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v945Y-0000000Ameb-2gDI@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 15/10/2025 18:10, Russell King (Oracle) wrote:
> To make future changes easier, rearrange the use of dma_cap->l3l4fnum
> vs priv->flow_entries_max.
> 
> Always initialise priv->flow_entries_max from dma_cap->l3l4fnum, then
> use priv->flow_entries_max to determine whether we allocate
> priv->flow_entries and set it up.
> 
> This change is safe because tc_init() is only called once from
> stmmac_dvr_probe().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 97e89a604abd..ef65cf511f3e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -262,10 +262,10 @@ static int tc_init(struct stmmac_priv *priv)
>  	unsigned int count;
>  	int ret, i;
>  
> -	if (dma_cap->l3l4fnum) {
> -		priv->flow_entries_max = dma_cap->l3l4fnum;
> +	priv->flow_entries_max = dma_cap->l3l4fnum;
> +	if (priv->flow_entries_max) {
>  		priv->flow_entries = devm_kcalloc(priv->device,
> -						  dma_cap->l3l4fnum,
> +						  priv->flow_entries_max,
>  						  sizeof(*priv->flow_entries),
>  						  GFP_KERNEL);
>  		if (!priv->flow_entries)


