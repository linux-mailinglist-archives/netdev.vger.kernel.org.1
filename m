Return-Path: <netdev+bounces-165895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71295A33A98
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95A0165136
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999D20C48D;
	Thu, 13 Feb 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByHxqda+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B920C021;
	Thu, 13 Feb 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437429; cv=none; b=JXwiafWDGnNBZAQx408owNmrsv6fxLYe92RoLNfYRuz82ZZH4okAN52uzIDCdTrGxoXL8s4alm6JJHkKkGWP+9gAo8C6jv291h3nLLn2JO1zBxih8omleQegneibD30n5W7NQTwawXZAHg83xp3B0cpRm2T0JZoB9ick16MrZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437429; c=relaxed/simple;
	bh=IEPqyHTmr/nEf5lzsdVqV6RZ6BK9t/GQNcR6dYu4yrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0JhWoDZfzP/we4Tfv5ZyjNUt4a4qv749dkF/HCnirW4vQn6+fecZEZHFHVppRGGmyZQw/pFlIsCT2KIvkWZR92CWyLw0FmoKgsRchuRw32D3s7XL2tr8y77BBLpniGwRwIKpO6K9BDwGN92SRDHTwuC7jtwfm0x4sr9cy65fJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByHxqda+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B1FC4CED1;
	Thu, 13 Feb 2025 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437428;
	bh=IEPqyHTmr/nEf5lzsdVqV6RZ6BK9t/GQNcR6dYu4yrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByHxqda+ehRnaFPRonkLDaCEP+8wA8PDPmvtoI2kdc+H7EAdvKyssJPdy+PmxOtos
	 xMsV+8ETqyHhHrYjpmNITbkVUfC6AwL0KbP2G9cw5GWfdSdHi1FbFRaLo5N+g3x2ar
	 WdsnpPfFtOl0q39m8O7+n56EpxRkckOhoKdBmbejCXUXDdaXkqPOhARMok7i5NZofa
	 kGheN/6yX7f4NqMYQUVPf3MYCjl9wJAgIV1+KP8cvvM3ug96f3M4UXsxL6ddGJvZy7
	 X2vqqOP/9tD69TKAIGsXR9DNCjUC2t5KpbyTNlE2289kmf2j5V9l4L0FAZ61tYVYHA
	 Ri9dCCdVanrPA==
Date: Thu, 13 Feb 2025 10:03:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 06/10] arm64: dts: st: add stm32mp235f-dk board support
Message-ID: <20250213-truthful-accurate-gaur-bd118f@krzk-bin>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-6-e8ef1e666c5e@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-6-e8ef1e666c5e@foss.st.com>

On Mon, Feb 10, 2025 at 04:21:00PM +0100, Amelie Delaunay wrote:
> Add STM32MP235F Discovery Kit board support. It embeds a STM32MP235FAK
> SoC, with 4GB of LPDDR4, 2*USB typeA, 1*USB3 typeC, 1*ETH, wifi/BT
> combo, DSI HDMI, LVDS connector ...
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/Makefile           |   1 +
>  arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 115 ++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/Makefile b/arch/arm64/boot/dts/st/Makefile
> index 0cc12f2b1dfeea6510793ea26f599f767df77749..06364152206997863d0991c25589de73c63494fb 100644
> --- a/arch/arm64/boot/dts/st/Makefile
> +++ b/arch/arm64/boot/dts/st/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_STM32) += \
> +	stm32mp235f-dk.dtb \
>  	stm32mp257f-dk.dtb \
>  	stm32mp257f-ev1.dtb
> diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..08e330d310749506c5b0e7a1fb2f80dfa134400a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
> + * Author: Amelie Delaunay <amelie.delaunay@foss.st.com> for STMicroelectronics.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include "stm32mp235.dtsi"
> +#include "stm32mp23xf.dtsi"
> +#include "stm32mp25-pinctrl.dtsi"
> +#include "stm32mp25xxak-pinctrl.dtsi"
> +
> +/ {
> +	model = "STMicroelectronics STM32MP235F-DK Discovery Board";
> +	compatible = "st,stm32mp235f-dk", "st,stm32mp235";
> +
> +	aliases {
> +		serial0 = &usart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button-user-1 {
> +			label = "User-1";
> +			linux,code = <BTN_1>;
> +			gpios = <&gpioc 5 GPIO_ACTIVE_HIGH>;
> +			status = "okay";

Where is it disabled?

> +		};
> +
> +		button-user-2 {
> +			label = "User-2";
> +			linux,code = <BTN_2>;
> +			gpios = <&gpioc 11 GPIO_ACTIVE_HIGH>;
> +			status = "okay";

Same question

> +		};
> +	};

Best regards,
Krzysztof


