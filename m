Return-Path: <netdev+bounces-165892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313EA33A8D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD473A5452
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED020B7F1;
	Thu, 13 Feb 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovk7ETsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B93201034;
	Thu, 13 Feb 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437356; cv=none; b=AhTIBad3YzKiOqTZ9gnAXhRdOJqCZhTz8BDmXbTph+vGKgAFnf18895f0Qc2Bc2Iv4hP3GNYl6f/uyo+lLocswt1Pdn9mG1qCQTVs12Dg0EhOOUVZ0ZM17ZUpa5JmrMQKipmjMhgewybd2yo3PXKN2bC5MR1CupgvzoPHi02bFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437356; c=relaxed/simple;
	bh=ua5WVx0I54fdUo13pJ7VbTe7xfRZawQhzWzOpvpRg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgIkicS0g2kRpSoyZAYhpAmhpLTebWnXJ1VPm3aeMVvJkmOUtrVHWdmc91s1AkfvjEydLutfEe0/tJhXm0mjwsZaLqhfT4zZfD/c5fFKCs45BVXgZGSW5s/VSKhyVa+m+RtdZb37ojYm+jTwtHQ1oBjGwNpAu5dZ0u2CbuhmB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovk7ETsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C5CC4CED1;
	Thu, 13 Feb 2025 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437355;
	bh=ua5WVx0I54fdUo13pJ7VbTe7xfRZawQhzWzOpvpRg1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovk7ETsketUvOyZ4x0M+tYWtrM8P3TrEw/+n7GF9T7YrLRxw4AU7ZYRDEoljujezS
	 AKAc9XP9P+4gbCsas1wjAxVjcDzy1n9OxHHIYQYAth2nefLNJ80T9nIW5uXdpF3wG1
	 k+3IVIBYeMLwk9p5EPtOFaGJMp8zZ8mHFmu6M+XfuNXOWQ4Wg7AIhNyEHk6rKwfO8k
	 pyZTIOox8EtBXITKJ/+Xmd38PoDvVB+fo+c01WaH9XzzEphXk6c/Nbe6K9ZtvuQl0r
	 9E7+muEApvu00wTzkXK1KkMAMOv2PE9BdEneOA87POE8P1eJwnZjCBKal4Ga2PEtEG
	 iqnncWVcn/HKQ==
Date: Thu, 13 Feb 2025 10:02:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 08/10] arm64: dts: st: introduce stm32mp21 SoCs family
Message-ID: <20250213-accurate-acoustic-mushroom-a0dfbd@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-8-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-8-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:21:02PM +0100, Amelie Delaunay wrote:
> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> STM32MP21 family is composed of 3 SoCs defined as following:
> 
> -STM32MP211: common part composed of 1*Cortex-A35, common peripherals
> like SDMMC, UART, SPI, I2C, parallel display, 1*ETH ...
> 
> -STM32MP213: STM32MP211 + a second ETH, CAN-FD.
> 
> -STM32MP215: STM32MP213 + Display and CSI2.
> 
> A second diversity layer exists for security features/ A35 frequency:
> -STM32MP21xY, "Y" gives information:
>  -Y = A means A35@1.2GHz + no cryp IP and no secure boot.
>  -Y = C means A35@1.2GHz + cryp IP and secure boot.
>  -Y = D means A35@1.5GHz + no cryp IP and no secure boot.
>  -Y = F means A35@1.5GHz + cryp IP and secure boot.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/stm32mp211.dtsi  | 130 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/st/stm32mp213.dtsi  |   9 +++
>  arch/arm64/boot/dts/st/stm32mp215.dtsi  |   9 +++
>  arch/arm64/boot/dts/st/stm32mp21xc.dtsi |   8 ++
>  arch/arm64/boot/dts/st/stm32mp21xf.dtsi |   8 ++
>  5 files changed, 164 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..d384359e0ea16e2593795ff48d4a699324c8ca75
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
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
> +		arm,smc-id = <0xbc000000>;
> +		status = "disabled";
> +	};
> +
> +	clocks {
> +		ck_flexgen_08: ck-flexgen-08 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <64000000>;
> +		};
> +
> +		ck_flexgen_51: ck-flexgen-51 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		scmi: scmi {
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
> +		};
> +	};
> +
> +	intc: interrupt-controller@4ac00000 {

MMIO nodes belong to the soc.

> +		compatible = "arm,cortex-a7-gic";
> +		#interrupt-cells = <3>;
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
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&intc>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,no-tick-in-suspend;
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <2>;
> +		interrupt-parent = <&intc>;
> +		ranges = <0x0 0x0 0x0 0x0 0x80000000>;

ranges is the second property. See DTS coding style.

> +		dma-ranges = <0x0 0x0 0x80000000 0x1 0x0>;
> +
> +		rifsc: bus@42080000 {
> +			compatible = "simple-bus";
> +			reg = <0x42080000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <2>;
> +			ranges;

and here is third.

> +			dma-ranges;
> +
> +			usart2: serial@400e0000 {

Although addresses seem wrong. How bus could start at 0x4208 but device
at 0x400e?

> +				compatible = "st,stm32h7-uart";
> +				reg = <0x400e0000 0x0 0x400>;
> +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ck_flexgen_08>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		syscfg: syscon@44230000 {
> +			compatible = "st,stm32mp25-syscfg", "syscon";

Which soc is this? DTSI says stm32mp211, commit STM32MP21, but
compatible xxx25?

> +			reg = <0x44230000 0x0 0x10000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/st/stm32mp213.dtsi b/arch/arm64/boot/dts/st/stm32mp213.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..22cdedd9abbf4efac2334d497618daa6cc76727b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp213.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +#include "stm32mp211.dtsi"
> +
> +/ {
> +};
> diff --git a/arch/arm64/boot/dts/st/stm32mp215.dtsi b/arch/arm64/boot/dts/st/stm32mp215.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..d2c63e92b3cc15ec64898374fd2e745a9c71eb6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp215.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +#include "stm32mp213.dtsi"
> +
> +/ {
> +};

What is the point of this file exactly?

> diff --git a/arch/arm64/boot/dts/st/stm32mp21xc.dtsi b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..39507a7564c8488647a3276eb227eb5f446359e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
> + */
> +
> +/ {
> +};

And this and others.

Best regards,
Krzysztof


