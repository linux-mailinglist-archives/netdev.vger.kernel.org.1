Return-Path: <netdev+bounces-236238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0098AC3A0D1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01663B90E7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582527FB0E;
	Thu,  6 Nov 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="unwm1zfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A72DA760
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423123; cv=none; b=DCaJMbJtZGGawi6X0VVLybf3MacKlObile1HGB5ZfWjqWBHD3naSM8fysHWzj6LrzvKy/TsuIBUKPlpe1StuTRRKYHvVcgLm1XbbUJlSOhvEi7Jr/V9tTpPzT+fMMeupwNxsWQFLf/htFlIa6KefZ5wN2Y98gPGNsn4nLWuS00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423123; c=relaxed/simple;
	bh=xXRi65L1iXHmMf/zF2iFn4jGxxGU/Uaz/JUq/W2Qiec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7qjT/arscQyzppc7j73SewyDGI8clio45Em41hdOr1YgfqlJvaPqSUdWD6GSDWigz6ds6/8gS4Cm73Oobkm7sD8h84vGPaFIHLf55UHDz/bTGAbhOV+LJNJraQ2nSFhP2b+BzVxpQh0fLYfVe7NGROvzUtMjjyg4iGtMFjpdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=unwm1zfq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E73B4E41562;
	Thu,  6 Nov 2025 09:58:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D70A76068C;
	Thu,  6 Nov 2025 09:58:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93FF611850798;
	Thu,  6 Nov 2025 10:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0xPwKSiR+8qRIcjkMOf4GQBuNI5KSYXz+hCD8bwMBFQ=;
	b=unwm1zfqRBi+OJfuCQcPAavSk8jiei0QPcox1LFunOUFkp+7zt4Mwq1DVZ3izAOMimnhSE
	4eGDJydu1rqz3vP6wwkiS+C2zWxJWrRtDI9hNLRikhL3KwofuXk5IvB9jaREq+EZsbppAA
	0od94fTyO7HbhZaW2En/k4QZv4crcxTzYMOU2k8wvKRqy6Q/a4jF93UBTekDnClA/VY6O7
	mTrTJCjUDMWBX8jr2oNRmeozWPBvSu5jq5wiskBJNZTUsNROEpxZ1e+fY2TXsyhO0qasc1
	Cy1OWOzcVvXyFi0Z4te4UeiRXwmoSL52ZyZDBv2exvyZQRO7A4PZJcIc9BDNvw==
Message-ID: <9a6614b1-7df6-4f40-b62a-e8df9f38637c@bootlin.com>
Date: Thu, 6 Nov 2025 10:58:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] net: stmmac: ingenic: move
 ingenic_mac_init()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <E1vGvnz-0000000DWoJ-3KxL@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvnz-0000000DWoJ-3KxL@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:57, Russell King (Oracle) wrote:
> Move ingenic_mac_init() to between variant specific set_mode()
> implementations and ingenic_mac_probe(). No code changes.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index c1670f6bae14..8d0627055799 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -71,20 +71,6 @@ struct ingenic_soc_info {
>  	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
>  };
>  
> -static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
> -{
> -	struct ingenic_mac *mac = bsp_priv;
> -	int ret;
> -
> -	if (mac->soc_info->set_mode) {
> -		ret = mac->soc_info->set_mode(mac->plat_dat);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
> @@ -234,6 +220,20 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> +static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
> +{
> +	struct ingenic_mac *mac = bsp_priv;
> +	int ret;
> +
> +	if (mac->soc_info->set_mode) {
> +		ret = mac->soc_info->set_mode(mac->plat_dat);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ingenic_mac_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat_dat;


