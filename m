Return-Path: <netdev+bounces-101846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E4900432
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3085828C07E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B3197A68;
	Fri,  7 Jun 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ywRycXCm"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04B195990;
	Fri,  7 Jun 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764911; cv=none; b=NVDomysDYttiJx2ZBjZXclCtwY5Jw6ppEYmQ4kMCz7IqtOtC6h+pmop7Jhu9PmtVo1enJeihC/xpy/pMiu5Z3tiTxzy54y1eAot45f/jz40WwfLLH6acZt5l39UZ4gCmJIMXJIXGqp4mAi0lgcimpSyKRZKp9HIGEkIONEueOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764911; c=relaxed/simple;
	bh=UuBM8Xz97yEk76VltZa3LLHOiN+6wlsp5+H6GB3LX2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihQ4qOz3eoIIZRivJHWixn8X7U4FjKWCadfJYa3Ww64lftnDLKEW0PTq0FMY6tJJo/GWfQCEa2PCDRWdJ6GAobFvuSc+KgVhm6fy5zHUsGOFILhp7zItTLHQd2g62wol7mj8zEAZg0GKlckwGq8uNCdQKsWEQfXKdMENd3dr0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ywRycXCm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CF90A88428;
	Fri,  7 Jun 2024 14:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764902;
	bh=H3pD+wrDGfjdRYDIP++BQRs9a9wH8JWsXe+QrM1Swu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ywRycXCmxPSHsQukLDZQCBQkIQtomx8KYEyGQJ8ekmFP+ZWlCBBaKAUdXLXWB5NXs
	 ynQryKbGm3yFWafgDo+n+Zf6080pAMbOZebo3Nxw01QOaImiQy36DDogCBOfUKIcgp
	 5qTwVPwadGJ91KBIwWGQpW12zdUff2g/OmsHdZWepNGjS7unpRuqItCzE+goKJETaF
	 1QKqtKTdDvFdkZyFvySPQ83u7vNojgRLPbCvFdxo+a6FOVeOE2e6i3xiW4DU8uQI5p
	 e+9cOB/vxytjMEiFmbiCsw9uBbrct1h0ZlGtO1yaDKL8j2FZgIhudw27qSy+ZqFtkI
	 P2C836a/ueOdA==
Message-ID: <5b1a7185-2273-40e9-8451-ba9add689637@denx.de>
Date: Fri, 7 Jun 2024 14:49:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] ARM: dts: stm32: add ethernet1 for
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
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-12-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607095754.265105-12-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 11:57 AM, Christophe Roullier wrote:
> Ethernet1: RMII with crystal
> Ethernet2: RMII with no cristal, need "phy-supply" property to work,
> today this property was managed by Ethernet glue, but should be present
> and managed in PHY node. So I will push second Ethernet in next step.
> 
> PHYs used are SMSC (LAN8742A)
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> index 567e53ad285fa..16e91b9d812d8 100644
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
> @@ -141,6 +142,28 @@ &cryp {
>   	status = "okay";
>   };
>   
> +&ethernet1 {
> +	status = "okay";
> +	pinctrl-0 = <&eth1_rmii_pins_a>;
> +	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	phy-handle = <&phy0_eth1>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +
> +		phy0_eth1: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id0007.c131";
> +			reset-gpios = <&mcp23017 9 GPIO_ACTIVE_LOW>;
> +			reg = <0>;


Keep the list sorted.

