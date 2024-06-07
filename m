Return-Path: <netdev+bounces-101847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10D900434
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658871C2409B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3B198E73;
	Fri,  7 Jun 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qIudx6tl"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A41974FD;
	Fri,  7 Jun 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764911; cv=none; b=ugZPNc+GJ01w+t0pEM/U2GhEPQ8H0OtY5g1P2Dd3UYjT0zCCJDqRZFUb68u+NAYkEihYY3xWh2agrIt6ct8BPhtWitbZSndoR3UZri/eSvhbWtuidC63bP8hLlVidh9WWTFNDtiKh3s16m7qNNXra/rWe9dKiKnw/YMNVakit6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764911; c=relaxed/simple;
	bh=5NWcVpNKympvjmY4ZAfbn8fpM87+EGDnRtTmadAXs2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGbDFS/Z4/XxIN8GY+jtuudPAfTozfrk1J+SPg/fOvKVIjaB9uVn8G+cUM16m+EKltlY+eVw1Dmdu1u8oWSbci6kTz+WCv+70+Yae7ZaPAEOci8tEJxFezjunusPwMBFOr+Z0orh3YiS/LvCQIOd6WFKdIKWM5x4hOGQx7UFlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qIudx6tl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3FE458843A;
	Fri,  7 Jun 2024 14:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764903;
	bh=P0S/4deZxZJMtdvuT/iptKgogzJiQ+NI/Cuim8aAx14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qIudx6tlhV1mJzqBeYZgsgKF0cBsiZfsJWaaZp1q+f1Ld9EPcv+p+INR1aeq1RBJa
	 dplIhKaAlyfG0vCnCYsHWZnMnA5KfseZzghJa4vtxHY1axDZufbv61KbeB4fpfRpBR
	 wVE0IyYu/RFuTAOmDi2xX7eg8A8E5p54aGJn0N83YIOT/Tj3xuuwgoHbQeDVHQtlzq
	 yFrc+3GkcVUicRUNfK2AhYcCmgkizEvLaXLAr1syNvjXqLUSDqjjelG+OXZAP68cLF
	 iYX23iJURj0ozm9EP/BczYi1QlQpbAawemXqPk4vOtDQScDSCofgfCiIGVgM0C4PaD
	 2FK8zbhmrrqFg==
Message-ID: <bcb7d95c-9ad3-4b10-b435-cec148aae061@denx.de>
Date: Fri, 7 Jun 2024 14:50:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl
 support
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
 <20240607095754.265105-13-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607095754.265105-13-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 11:57 AM, Christophe Roullier wrote:
> Enable MCP23S08 I/O expanders to manage Ethernet phy

PHY in capitals .

> reset in STM32MP135F-DK board.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 86bf057ac3663..9758f3d41ad70 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -469,6 +469,7 @@ CONFIG_SPI_XILINX=y
>   CONFIG_SPI_SPIDEV=y
>   CONFIG_SPMI=y
>   CONFIG_PINCTRL_AS3722=y
> +CONFIG_PINCTRL_MCP23S08=y
>   CONFIG_PINCTRL_MICROCHIP_SGPIO=y
>   CONFIG_PINCTRL_OCELOT=y
>   CONFIG_PINCTRL_PALMAS=y

Send this as separate patch, this can go in right away.

