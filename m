Return-Path: <netdev+bounces-100709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8378FBA4B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937E02871FC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB16149DE1;
	Tue,  4 Jun 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="C4ugqekL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32E1494D0;
	Tue,  4 Jun 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522031; cv=none; b=sRpQgDuGDXffDeQP3JbsIE2+Vr2ci7uon4a3wTr8G0BRhysB9hkDKlcmmXFWo2NktSld9eRMCjBeVaatlepuzjA24VQ3YMVxjktOYnQaY9C2LZLcXhST8RFNGDU7cjXghFbO3UkHqsbekIECfNe9ESdrNmUHdbHwTRAAY3A/umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522031; c=relaxed/simple;
	bh=Fw+R07Uhx4jBtZPSjYVknFQtrMkWMAZeU8GC561sY68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fbpx5YBrU1xBjj+ICqVuTmmlNXiz0haznoVBma3f+d0IVqNUE42JvVmKTatDt0ndWT1X977Xq9/i81XuZrR4c4l+Z+0Sq+joYVZD+FunadK+uhwT/7JWS1C/feSzOu91sSNb+c87jDxRp0h2vyU4Fh1pVY4hygICDPXXderuVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=C4ugqekL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 92E1D8850A;
	Tue,  4 Jun 2024 19:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717522028;
	bh=4f1pYqXRizqyxIM/L7FfRjUNFGAWVe3AOXcygF3r6BE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C4ugqekL9DcBNfDMt7BMGmAnOJSHo8y5Sf9xjnQU5JxMTAc/w4Bg7RHuEwHQn4j7/
	 tNNw3i8rS/9BpqfHrY8i1pt+HsfimWrhDbil1RYTwBuSAEVVj4MgWN1TlVXwX6sv0j
	 AyW6bBuVAidz+I4xRsH7UjBuaXls9j3KoEaFq6tquqRzun9MLYOWDtfRH/7CV8QeBX
	 GUi3vTWXAiTcpksuFnTMo0yC+Eo408n3eeTcB1BRazMJO9/TT55LLbMwIpiLuIxYcu
	 o8C/G+xu+beETeQJHeLB9K6ld43u9V4cMENN7W7xIfw+JJ5fk0irtUsElPECL/YZ99
	 7MzmQLpYiMHfA==
Message-ID: <e8e69a34-b9b2-4b4c-9b2e-079c7a23b756@denx.de>
Date: Tue, 4 Jun 2024 18:49:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
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
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-9-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604143502.154463-9-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/4/24 4:34 PM, Christophe Roullier wrote:
> Both instances ethernet based on GMAC SNPS IP on stm32mp13.
> GMAC IP version is SNPS 4.20.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp131.dtsi | 38 ++++++++++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp133.dtsi | 31 +++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
> index 6704ceef284d3..9d05853ececf7 100644
> --- a/arch/arm/boot/dts/st/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
> @@ -979,6 +979,12 @@ ts_cal1: calib@5c {
>   			ts_cal2: calib@5e {
>   				reg = <0x5e 0x2>;
>   			};
> +			ethernet_mac1_address: mac1@e4 {
> +				reg = <0xe4 0x6>;
> +			};
> +			ethernet_mac2_address: mac2@ea {
> +				reg = <0xea 0x6>;
> +			};
>   		};
>   
>   		etzpc: bus@5c007000 {
> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>   				status = "disabled";
>   			};
>   
> +			ethernet1: ethernet@5800a000 {
> +				compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +				reg = <0x5800a000 0x2000>;
> +				reg-names = "stmmaceth";
> +				interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&exti 68 1>;
> +				interrupt-names = "macirq", "eth_wake_irq";
> +				clock-names = "stmmaceth",
> +					      "mac-clk-tx",
> +					      "mac-clk-rx",
> +					      "ethstp",
> +					      "eth-ck";
> +				clocks = <&rcc ETH1MAC>,
> +					 <&rcc ETH1TX>,
> +					 <&rcc ETH1RX>,
> +					 <&rcc ETH1STP>,
> +					 <&rcc ETH1CK_K>;
> +				st,syscon = <&syscfg 0x4 0xff0000>;
> +				snps,mixed-burst;
> +				snps,pbl = <2>;
> +				snps,axi-config = <&stmmac_axi_config_1>;
> +				snps,tso;
> +				access-controllers = <&etzpc 48>;

Please keep the list of properties sorted.

> +				status = "disabled";
> +
> +				stmmac_axi_config_1: stmmac-axi-config {
> +					snps,wr_osr_lmt = <0x7>;
> +					snps,rd_osr_lmt = <0x7>;
> +					snps,blen = <0 0 0 0 16 8 4>;

Sort here too.

> +				};
> +			};
> +
>   			usbphyc: usbphyc@5a006000 {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
> index 3e394c8e58b92..09c7da1a2eda8 100644
> --- a/arch/arm/boot/dts/st/stm32mp133.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
> @@ -67,5 +67,36 @@ channel@18 {
>   				label = "vrefint";
>   			};
>   		};
> +
> +		ethernet2: ethernet@5800e000 {
> +			compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +			reg = <0x5800e000 0x2000>;
> +			reg-names = "stmmaceth";
> +			interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clock-names = "stmmaceth",
> +				      "mac-clk-tx",
> +				      "mac-clk-rx",
> +				      "ethstp",
> +				      "eth-ck";
> +			clocks = <&rcc ETH2MAC>,
> +				 <&rcc ETH2TX>,
> +				 <&rcc ETH2RX>,
> +				 <&rcc ETH2STP>,
> +				 <&rcc ETH2CK_K>;
> +			st,syscon = <&syscfg 0x4 0xff000000>;
> +			snps,mixed-burst;
> +			snps,pbl = <2>;
> +			snps,axi-config = <&stmmac_axi_config_2>;
> +			snps,tso;
> +			access-controllers = <&etzpc 49>;

Sort here too.

> +			status = "disabled";
> +
> +			stmmac_axi_config_2: stmmac-axi-config {
> +				snps,wr_osr_lmt = <0x7>;
> +				snps,rd_osr_lmt = <0x7>;
> +				snps,blen = <0 0 0 0 16 8 4>;

Sort here too.

[...]

