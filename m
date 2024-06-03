Return-Path: <netdev+bounces-100244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70F8D8506
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE071C214E4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A8130499;
	Mon,  3 Jun 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uStSg/jn"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896B84D0D;
	Mon,  3 Jun 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425014; cv=none; b=GqFkmY5RbXDmA0z66icxtJSCcVp4XM3AJ8TLqt/xItBy0QRmDuQs5tYwP958BX9hdzGeFR+8qRaJ0Usz/2Wk/Q+CsypIc6WCIAVv5NT/FY5dreWjRm71RkVK1RejbiwFvsZjOouAYjepTqUCinptCmIRBcWJW7BizWbnA7Y5t7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425014; c=relaxed/simple;
	bh=fpmoUK2H6tvR6dTlRqHFmjnB6Vo+VzFiAEvoTxviDfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRif2l1uw58gI111T5TIjVJUFgYoIx/30+Yegl/43WP8S3N6wM74UhiUGGVm2G2dOTrGFYnIvSrONXofhqTIZusxFJ9xVgDGuEMtyvsi8AZLxZBe/adUa0B5NWh48AcEzMrcLDdgdYaBUK1Z1gfkeApsdSdxcxlUhyjHynpbp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uStSg/jn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 91FCE88300;
	Mon,  3 Jun 2024 16:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425010;
	bh=m86V0QMGLbIXBNVPgpq4zgvcbfPKGNmP9UXboElbxH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uStSg/jnZ6E/C6COoby9j+cWGeyJz9pdhBomPfkPzFe8WGsBb4mt9X9hiHLUBhtWH
	 ZhQHlfljo75njWGcaZMDffXvmtI5E/rMi9P99cfthO3g1g+StwAYS1llNf00FVJ8z+
	 gb6Nds/JdcP8OVCI0fLm4KT4Vo9Rup83HximVlgGmIlm99AxNZD8z8bAtpjGZIIZ+e
	 NoNNPotmT3m50qinKILd+TqA2Pfgl/iUPr6lqvfPzycBWsIB6w0lXX2VAAH/JkYMnO
	 f+at09+oxGjWsitkgqkHgmaXqXssN/RLlmUKoXn4+Yxn8FHVYFpdQNy6uDWpmaTWMB
	 dja6M5sbrejpg==
Message-ID: <29b79c7d-7ff6-40fb-97be-7198a0e9d437@denx.de>
Date: Mon, 3 Jun 2024 15:08:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] ARM: dts: stm32: add ethernet1 for
 STM32MP135F-DK board
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-11-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240603092757.71902-11-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 11:27 AM, Christophe Roullier wrote:
> Ethernet1: RMII with crystal
> PHY used is SMSC (LAN8742A)
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> index 567e53ad285fa..cebe9b91eced9 100644
> --- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> @@ -19,6 +19,7 @@ / {
>   	compatible = "st,stm32mp135f-dk", "st,stm32mp135";
>   
>   	aliases {
> +		ethernet0 = &ethernet1;
>   		serial0 = &uart4;
>   		serial1 = &usart1;
>   		serial2 = &uart8;
> @@ -141,6 +142,29 @@ &cryp {
>   	status = "okay";
>   };
>   
> +&ethernet1 {
> +	status = "okay";
> +	pinctrl-0 = <&eth1_rmii_pins_a>;
> +	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	max-speed = <100>;

Is this needed ? RMII cannot go faster than 100 .

Also, keep the list sorted alphabetically , P goes after M .

> +	phy-handle = <&phy0_eth1>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +
> +		phy0_eth1: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id0007.c131";
> +			reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;

Extra space between = and < , please drop.

