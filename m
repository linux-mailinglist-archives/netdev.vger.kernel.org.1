Return-Path: <netdev+bounces-165897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71DCA33AB0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D23A9C2C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2955211A3C;
	Thu, 13 Feb 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXfOiApS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0888211A19;
	Thu, 13 Feb 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437729; cv=none; b=rcbIgXabJJ2yfMqbEupzcCuBqhWxxMJH3lx/dveIZExKqNaeKvd5LB85hMPi6PiuM4MZVySW8pFSPz6gJtuxCN/EgpPPUN3zmzN+TFYtc8JYs8SWvu9zogk4r5/aCddkDIFS2BsIoM41KzHfr2kuj6RdzdJpWC/OB2WkuLOln1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437729; c=relaxed/simple;
	bh=GIUlT9LC1ocTQlyq1ULMc6PUaVMG6RnWLIb/+PjLhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps1uHrBRK8yDhWPnS7PZ2HtpVtNI1z9dwqevHimdw+6gs/s//IbenGHIqRWLJBRbG4PCMHexx21n5INmIufwSSztMTZ0FIz6ArlNn35KIZxw1ZcKC4OE4F2F74X+9S+5UGifqhdoddpDaWZUkwoxdaXn1IL33QcnB8B3uOwmoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXfOiApS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16921C4CEED;
	Thu, 13 Feb 2025 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437729;
	bh=GIUlT9LC1ocTQlyq1ULMc6PUaVMG6RnWLIb/+PjLhqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXfOiApS4CvYmByz2sWdMw+soFywSC19cqDepOvB0PcH14Q6cVXWVQoRd3TBsxD8W
	 5L51snHJgowUfNjJVq1kanTsMQRbzDzbWbXir5oA4Ys9DT4bGskWAbU/NTfYR8SJOX
	 NST7rnPvIjPbafyYgvCm3XxSccEHcXHHMrznyfPJB34tkz77b0sg7So+WUJy0SeBrx
	 WUu9HUmFIuE+n1k+Z3SSkuRynCJNFkbz1XUVKp4i3skAuVIrkyFITQh0wT9NEC0uNU
	 cSJdxb9X+kOkHMSOwN/z0WrO2wwbs0Zl8R9Lc9asejqL+UfTpBx+88ZlDhgNeyU1tQ
	 reyVY3lOp4tcw==
Date: Thu, 13 Feb 2025 10:08:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 04/10] arm64: dts: st: introduce stm32mp23 SoCs family
Message-ID: <20250213-intrepid-peridot-dinosaur-c5d0bc@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-4-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-4-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:20:58PM +0100, Amelie Delaunay wrote:
> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> STM32MP23 family is composed of 3 SoCs defined as following:
> 
> -STM32MP231: common part composed of 1*Cortex-A35, common peripherals
> like SDMMC, UART, SPI, I2C, parallel display, 1*ETH ...
> 
> -STM32MP233: STM32MP231 + 1*Cortex-A35 (dual CPU), a second ETH, CAN-FD.
> 
> -STM32MP235: STM32MP233 + GPU/AI and video encode/decode, DSI and LDVS
> display.
> 
> A second diversity layer exists for security features/ A35 frequency:
> -STM32MP23xY, "Y" gives information:
>  -Y = A means A35@1.2GHz + no cryp IP and no secure boot.
>  -Y = C means A35@1.2GHz + cryp IP and secure boot.
>  -Y = D means A35@1.5GHz + no cryp IP and no secure boot.
>  -Y = F means A35@1.5GHz + cryp IP and secure boot.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/stm32mp231.dtsi  | 1216 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/st/stm32mp233.dtsi  |   94 +++
>  arch/arm64/boot/dts/st/stm32mp235.dtsi  |   16 +
>  arch/arm64/boot/dts/st/stm32mp23xc.dtsi |    8 +
>  arch/arm64/boot/dts/st/stm32mp23xf.dtsi |    8 +
>  5 files changed, 1342 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..ee93f5412096a7cd30b228b85a5280a551fbfaf4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
> @@ -0,0 +1,1216 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/regulator/st,stm32mp25-regulator.h>
> +#include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a35";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a35-pmu";
> +		interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>;
> +		interrupt-parent = <&intc>;
> +	};
> +
> +	arm_wdt: watchdog {
> +		compatible = "arm,smc-wdt";
> +		arm,smc-id = <0xb200005a>;
> +		status = "disabled";
> +	};
> +
> +	clocks {

Drop

> +		clk_dsi_txbyte: txbyteclk {

Use consistent naming style. Either prefix or suffix. Or better, use
what is recommended.

See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1

> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <0>;
> +		};
> +
> +		clk_rcbsec: clk-rcbsec {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <64000000>;
> +		};
> +	};
> +
> +	firmware {
> +		optee: optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +
> +		scmi {
> +			compatible = "linaro,scmi-optee";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			linaro,optee-channel-id = <0>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			scmi_reset: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +
> +			scmi_voltd: protocol@17 {
> +				reg = <0x17>;
> +
> +				scmi_regu: regulators {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					scmi_vddio1: regulator@0 {
> +						reg = <VOLTD_SCMI_VDDIO1>;
> +						regulator-name = "vddio1";
> +					};
> +					scmi_vddio2: regulator@1 {
> +						reg = <VOLTD_SCMI_VDDIO2>;
> +						regulator-name = "vddio2";
> +					};
> +					scmi_vddio3: regulator@2 {
> +						reg = <VOLTD_SCMI_VDDIO3>;
> +						regulator-name = "vddio3";
> +					};
> +					scmi_vddio4: regulator@3 {
> +						reg = <VOLTD_SCMI_VDDIO4>;
> +						regulator-name = "vddio4";
> +					};
> +					scmi_vdd33ucpd: regulator@5 {
> +						reg = <VOLTD_SCMI_UCPD>;
> +						regulator-name = "vdd33ucpd";
> +					};
> +					scmi_vdda18adc: regulator@7 {
> +						reg = <VOLTD_SCMI_ADC>;
> +						regulator-name = "vdda18adc";
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	intc: interrupt-controller@4ac00000 {

Part of Soc most likely.

> +		compatible = "arm,cortex-a7-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <1>;
> +		interrupt-controller;
> +		reg = <0x0 0x4ac10000 0x0 0x1000>,
> +		      <0x0 0x4ac20000 0x0 0x2000>,
> +		      <0x0 0x4ac40000 0x0 0x2000>,
> +		      <0x0 0x4ac60000 0x0 0x2000>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {

All labels are always lowercase.

> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cluster {
> +			#power-domain-cells = <0>;
> +			power-domains = <&RET_PD>;
> +		};
> +
> +		RET_PD: power-domain-retention {
> +			#power-domain-cells = <0>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&intc>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
> +		always-on;
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupt-parent = <&intc>;
> +		ranges = <0x0 0x0 0x0 0x80000000>;

Same comments as for all other patches.

> +
> +		hpdma: dma-controller@40400000 {
> +			compatible = "st,stm32mp25-dma3";
> +			reg = <0x40400000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&scmi_clk CK_SCMI_HPDMA1>;
> +			#dma-cells = <3>;
> +		};
> +
> +		hpdma2: dma-controller@40410000 {
> +			compatible = "st,stm32mp25-dma3";
> +			reg = <0x40410000 0x1000>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&scmi_clk CK_SCMI_HPDMA2>;
> +			#dma-cells = <3>;
> +		};
> +
> +		hpdma3: dma-controller@40420000 {
> +			compatible = "st,stm32mp25-dma3";
> +			reg = <0x40420000 0x1000>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&scmi_clk CK_SCMI_HPDMA3>;
> +			#dma-cells = <3>;
> +		};
> +
> +		rifsc: bus@42080000 {
> +			compatible = "st,stm32mp25-rifsc", "simple-bus";
> +			reg = <0x42080000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#access-controller-cells = <1>;
> +			ranges;
> +
> +			i2s2: audio-controller@400b0000 {

Confusing: device has address outside of the bus. What does the bus
address represent?

> +				compatible = "st,stm32mp25-i2s";
> +				reg = <0x400b0000 0x400>;
> +				#sound-dai-cells = <0>;
> +				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&rcc CK_BUS_SPI2>, <&rcc CK_KER_SPI2>;
> +				clock-names = "pclk", "i2sclk";
> +				resets = <&rcc SPI2_R>;
> +				dmas = <&hpdma 51 0x43 0x12>,
> +				       <&hpdma 52 0x43 0x21>;
> +				dma-names = "rx", "tx";
> +				access-controllers = <&rifsc 23>;
> +				status = "disabled";
> +			};
> +

...

> +			sdmmc1: mmc@48220000 {
> +				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
> +				arm,primecell-periphid = <0x00353180>;
> +				reg = <0x48220000 0x400>, <0x44230400 0x8>;
> +				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&rcc CK_KER_SDMMC1 >;
> +				clock-names = "apb_pclk";
> +				resets = <&rcc SDMMC1_R>;
> +				cap-sd-highspeed;
> +				cap-mmc-highspeed;
> +				max-frequency = <120000000>;
> +				access-controllers = <&rifsc 76>;
> +				status = "disabled";
> +			};
> +
> +			ethernet1: ethernet@482c0000 {
> +				compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
> +				reg = <0x482c0000 0x4000>;
> +				reg-names = "stmmaceth";
> +				interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;

Why extended?

> +				interrupt-names = "macirq";
> +				clock-names = "stmmaceth",
> +					      "mac-clk-tx",
> +					      "mac-clk-rx",
> +					      "ptp_ref",
> +					      "ethstp",
> +					      "eth-ck";

...

> +		rcc: clock-controller@44200000 {
> +			compatible = "st,stm32mp25-rcc";
> +			reg = <0x44200000 0x10000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			clocks = <&scmi_clk CK_SCMI_HSE>,
> +				<&scmi_clk CK_SCMI_HSI>,
> +				<&scmi_clk CK_SCMI_MSI>,
> +				<&scmi_clk CK_SCMI_LSE>,
> +				<&scmi_clk CK_SCMI_LSI>,
> +				<&scmi_clk CK_SCMI_HSE_DIV2>,
> +				<&scmi_clk CK_SCMI_ICN_HS_MCU>,
> +				<&scmi_clk CK_SCMI_ICN_LS_MCU>,
> +				<&scmi_clk CK_SCMI_ICN_SDMMC>,
> +				<&scmi_clk CK_SCMI_ICN_DDR>,
> +				<&scmi_clk CK_SCMI_ICN_DISPLAY>,
> +				<&scmi_clk CK_SCMI_ICN_HSL>,
> +				<&scmi_clk CK_SCMI_ICN_NIC>,
> +				<&scmi_clk CK_SCMI_ICN_VID>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_07>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_08>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_09>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_10>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_11>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_12>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_13>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_14>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_15>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_16>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_17>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_18>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_19>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_20>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_21>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_22>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_23>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_24>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_25>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_26>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_27>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_28>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_29>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_30>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_31>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_32>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_33>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_34>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_35>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_36>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_37>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_38>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_39>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_40>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_41>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_42>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_43>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_44>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_45>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_46>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_47>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_48>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_49>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_50>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_51>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_52>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_53>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_54>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_55>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_56>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_57>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_58>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_59>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_60>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_61>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_62>,
> +				<&scmi_clk CK_SCMI_FLEXGEN_63>,
> +				<&scmi_clk CK_SCMI_ICN_APB1>,
> +				<&scmi_clk CK_SCMI_ICN_APB2>,
> +				<&scmi_clk CK_SCMI_ICN_APB3>,
> +				<&scmi_clk CK_SCMI_ICN_APB4>,
> +				<&scmi_clk CK_SCMI_ICN_APBDBG>,
> +				<&scmi_clk CK_SCMI_TIMG1>,
> +				<&scmi_clk CK_SCMI_TIMG2>,
> +				<&scmi_clk CK_SCMI_PLL3>,
> +				<&clk_dsi_txbyte>;
> +				access-controllers = <&rifsc 156>;
> +		};
> +
> +		exti1: interrupt-controller@44220000 {
> +			compatible = "st,stm32mp1-exti", "syscon";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x44220000 0x400>;
> +			interrupts-extended =

Why extended?

> +				<&intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
> +				<&intc GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
> +				<&intc GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,						/* EXTI_20 */
> +				<&intc GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
> +				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,
> +				<&intc GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
> +				<&intc GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
> +				<0>,
> +				<0>,
> +				<0>,
> +				<0>,
> +				<0>,
> +				<0>,
> +				<0>,
> +				<0>,
> +				<&intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,						/* EXTI_60 */
> +				<&intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,
> +				<0>,
> +				<&intc GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,
> +				<0>,
> +				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,
> +				<&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
> +				<0>,
> +				<&intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> +				<0>,						/* EXTI_80 */
> +				<0>,
> +				<0>,
> +				<&intc GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
> +				<&intc GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		syscfg: syscon@44230000 {
> +			compatible = "st,stm32mp25-syscfg", "syscon";
> +			reg = <0x44230000 0x10000>;
> +		};
> +
> +		pinctrl: pinctrl@44240000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;

Please fix coding style everywhere here.


> +			compatible = "st,stm32mp257-pinctrl";
> +			ranges = <0 0x44240000 0xa0400>;
> +			interrupt-parent = <&exti1>;
> +			st,syscfg = <&exti1 0x60 0xff>;
> +			pins-are-numbered;
> +

...

> diff --git a/arch/arm64/boot/dts/st/stm32mp23xc.dtsi b/arch/arm64/boot/dts/st/stm32mp23xc.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..e33b00b424e1207dc6212e75235785f8c61e5055
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp23xc.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +

What is the point of this file?

Best regards,
Krzysztof


