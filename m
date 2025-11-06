Return-Path: <netdev+bounces-236232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80025C39EEE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4E31A425A2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6E2E4258;
	Thu,  6 Nov 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1a3WepO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED314E2E2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422604; cv=none; b=Zw0WmUTcxoBtmtZZrNf1gPoMz2gsK1rY2pWvoOXm2yUUtZKQyxFfQ8L/LmyhK5cJrOuohdBcg1Dcm2khE7WD9417iCFalmEba+Zo/S/lPKlBpZajQkWDpEVrCPUWuj8Ft1bjdkyUw4DdBsvSJ2j2wUteHE7DeBrVIKYdE6SGV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422604; c=relaxed/simple;
	bh=Z4OgPtaDhkNm3Omg7+xAcWwcme6n538Igbs+UiMoS9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNajongzbVgSD7QktvcD5Qg0q+YXa5WfGDN0Lb8I2WNmCW2i2+kJiIUdmqCO04cVXkWc9cnPYigWp7n4eVa+fLA2JQnaQ3C1N+wBL390nVJbscc2LdA5EPIKWeTbHYhAO6DcZUAx4mFhVnm/+1HHnxseqdhAlYm/crk/o04BOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1a3WepO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CC160C0FA85;
	Thu,  6 Nov 2025 09:49:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D256D6068C;
	Thu,  6 Nov 2025 09:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74FAF1185082B;
	Thu,  6 Nov 2025 10:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762422600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mm64gM8EXxiCL6h3Shnl5SuMXJZ/nOwqbkGzDPWYn9E=;
	b=L1a3WepOX0khJ/Ur85az6tTXBpWZEK6J3cxK9BR4VanbsnRCJAPCgMjbP9n1/cQAqS9W/y
	80NmkjLcdsCoDMu3nR4a2wIJXck4IgFqHKldChNWb8dq4vQGYb6KXAjOLzUIki1xazaQvu
	5CRQeViz8SsJILlwtGKgWP+0CYKkOp3K7cL9BtJiE1joAtQUKdnj0bZK6e3qvfYXe5lwRT
	ic2C2OTTNCUcYZU/MHwD2IC1EGDbdN7UYu/OivteDmiujRxBszMrGplq/wQxRIMU3atPo0
	h3/JvgD9im0KBT3bqnum8wMp5G617rq5Rmi82aByxxrZYMeef8Sh8SyRi7V1GQ==
Message-ID: <a51db9ea-a6e9-476d-915a-2aa532fa3392@bootlin.com>
Date: Thu, 6 Nov 2025 10:49:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/11] net: stmmac: ingenic: move
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
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
 <E1vGdWf-0000000ClnO-03pS@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGdWf-0000000ClnO-03pS@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 05/11/2025 14:26, Russell King (Oracle) wrote:
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


