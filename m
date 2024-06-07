Return-Path: <netdev+bounces-101844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83890042A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4721228BA9E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80E194C7C;
	Fri,  7 Jun 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WPcE9Vzq"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E07193090;
	Fri,  7 Jun 2024 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764907; cv=none; b=UPqnw0BQ/gyJavC6I5ECO2g9guJzbe3SPU4nUEq/4++xhF7cYfK3EuUgZ5iHJFvKRhmH1Yb+p0Q5ZD3fAJtUDbWn+ugv1W8DhIwC3ygsTOwIl2D3sK3rRBK3aO2Ik+XHUQ4B4dhzuc2nzAEg674gx6hCZ42jwSZatzeq7MxR4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764907; c=relaxed/simple;
	bh=ueQLqvfxS8iUthbLZJGnuX1gcFPmAKY0JNt/ouyFFsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnX8cHJJxq04v+iO1X27SHFWoQ+sLn5o/NROxyJc02Q737wkcPoadH3MXoBr+4bVpRAuHgQwZF7hYNRy+lH7CmZu74nU2iuyyfM1Fk9nz8yYHE033/5nCoZO2at6sz/WQeWL/3n8lZ2xlL1Sm17sx6FUk3Kv6u5vQWtZvzS5cqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WPcE9Vzq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0BFDD87FFB;
	Fri,  7 Jun 2024 14:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764899;
	bh=dLyJBZqHf76+ChB4CcC6G4HDf+CMmtyIIIHG7RFXt4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WPcE9VzqTN0zrI4noJOx9HQUp51f4aUcGe7g3aaP8cl9TMlMsIRkST9g5asihJjm3
	 k22Xgt1EgJy9/K1EMt5BUiZZXODBq1WcQ3YOfntVVCyn02I/kqftREQV4m4myWjIm+
	 iS69pw41jRRnt9Mw/PB9HQYCOYf+jLk+LUdjyDOZBt07pFWyUc5FqVNKgBPmoEAaIq
	 M8+7dWf+kWA9lGOBZe7aebpdfB4aLb9ahFnISLOgGQDITXwZnCxA5VD/4mogNYVjsp
	 xPypTq87yVAYo7xPfDBsGJ9iA4cF6NKz1DhtPd+ensSXMddFcNVbctBwC3lvQ51m7m
	 jlYH805gKeAQw==
Message-ID: <6f44537a-3d60-46f5-a159-919cc2a144ec@denx.de>
Date: Fri, 7 Jun 2024 14:48:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] net: stmmac: dwmac-stm32: add management of
 stm32mp13 for stm32
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-9-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607095754.265105-9-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 11:57 AM, Christophe Roullier wrote:

[...]

> @@ -224,11 +225,18 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>   {
>   	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>   	u32 reg = dwmac->mode_reg;
> -	int val;
> +	int val = 0;

Is the initialization really needed ? It seems the switch-case below 
does always initialize $val .

>   	switch (plat_dat->mac_interface) {
>   	case PHY_INTERFACE_MODE_MII:
> -		val = SYSCFG_PMCR_ETH_SEL_MII;
> +		/*
> +		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
> +		 * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
> +		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
> +		 * supports only MII, ETH_SELMII is not present.
> +		 */
> +		if (!dwmac->ops->is_mp13)  /* Select MII mode on STM32MP15xx */
> +			val |= SYSCFG_PMCR_ETH_SEL_MII;
>   		break;
>   	case PHY_INTERFACE_MODE_GMII:
>   		val = SYSCFG_PMCR_ETH_SEL_GMII;

[...]

This way of adding MP13 support definitely looks much better.

Also, split the series, drivers/ stuff for netdev (and make sure to 
include the net-next patch prefix , git send-email 
--subject-prefix="net-next,PATCH") , DTs for linux-arm-kernel , config 
patch also for linux-arm-kernel .

