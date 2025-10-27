Return-Path: <netdev+bounces-233078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BAC0BD49
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4363B80EA
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 05:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7E2D47E2;
	Mon, 27 Oct 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qJjEJF6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BED198A11;
	Mon, 27 Oct 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543438; cv=none; b=rLa1x5Lr0qyyxOjgM6632Gh3lF82cENki4Ok3p0cUr7ta8idjG+Hh3jx27AvScuFJsXrVxv9LMM+TzUubof7cf8C/ZD2we9WHj7WWwrGYyPGeUz3AGjukZGuMZWEoN4/K7Il40hoorVvrr8h3/Pvu2i9ZQoqoMCRlL+8Z985GFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543438; c=relaxed/simple;
	bh=bvmH6+soryGKZ5gEos9mE85vYchLmLIzCBHYBswlpVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig5Ec88iod3eVHHaZTjJv5yDThUBGuZhwgyYUe2TwT1AxayUiXkQiQpyw3IfN4+KlDqqjV9Vm3SegyOTSe3gciSNbDBdB90qrxusMl5yOOUDYpS0C30bXcsgMHTj1L2k9T/Ms908jrr9DRVP5S+X6ktnKXNYeQS946xNn0qBB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qJjEJF6F; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=r7WBuk2/uLe2meaXUWqKZJpLgBzXsYM73eCP13b2d4g=;
	b=qJjEJF6FhjYwipyWgYF0kUsgDCasEyNzCOv7vo1X68rIkAYLFtV3qPemM05Tp8
	uwSHK9cGgIyuCXG9hdvXGGtzDnqUA0aXRqWyoaEE5+m8LrA/w8x/sGZLgAri3Gzy
	Jdn+4uCIhd1MRKPJyw8tjiX3Q87EX/N6eeQ7qGIdhtNcc=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCXXyDOBP9ok5+5AA--.1347S3;
	Mon, 27 Oct 2025 13:36:17 +0800 (CST)
Date: Mon, 27 Oct 2025 13:36:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: jan.petrous@oss.nxp.com
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: Add GMAC Ethernet for S32G2 EVB
 and RDB2 and S32G3 RDB3
Message-ID: <aP8Ezk_zjo-NZCD4@dragon>
References: <20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com>
X-CM-TRANSID:M88vCgCXXyDOBP9ok5+5AA--.1347S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr4kCryruw1kWF48Jr17GFg_yoWxKFy7pF
	97Ca93Xr1Igr12vasIg3Wkur90yws5Kr15urnFvrWjyr4avr9Ivr13JrsxWw10qFs8Ww4U
	ZFnYvFn7C3ZxXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpCJQUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhFPtGj-BNEzBQAA38

On Mon, Oct 06, 2025 at 06:31:28PM +0200, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Add support for the Ethernet connection over GMAC controller connected to
> the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
> 
> The mentioned GMAC controller is one of two network controllers
> embedded on the NXP Automotive SoCs S32G2 and S32G3.
> 
> The supported boards:
>  * EVB:  S32G-VNP-EVB with S32G2 SoC
>  * RDB2: S32G-VNP-RDB2
>  * RDB3: S32G-VNP-RDB3
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 50 ++++++++++++++++++++++++-
>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 21 ++++++++++-
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 19 ++++++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi        | 50 ++++++++++++++++++++++++-
>  arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 21 ++++++++++-
>  5 files changed, 157 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index d167624d1f0c..d06103e9564e 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -3,7 +3,7 @@
>   * NXP S32G2 SoC family
>   *
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright 2017-2021, 2024 NXP
> + * Copyright 2017-2021, 2024-2025 NXP
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -738,5 +738,53 @@ gic: interrupt-controller@50800000 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  		};
> +
> +		gmac0: ethernet@4033c000 {

Please sort devices in order of unit-address.

> +			compatible = "nxp,s32g2-dwmac";
> +			reg = <0x4033c000 0x2000>, /* gmac IP */
> +			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			snps,mtl-rx-config = <&mtl_rx_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_setup>;
> +			status = "disabled";
> +
> +			mtl_rx_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <5>;
> +
> +				queue0 {
> +				};

We usually have newline between nodes.

> +				queue1 {
> +				};
> +				queue2 {
> +				};
> +				queue3 {
> +				};
> +				queue4 {
> +				};
> +			};
> +
> +			mtl_tx_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <5>;
> +
> +				queue0 {
> +				};
> +				queue1 {
> +				};
> +				queue2 {
> +				};
> +				queue3 {
> +				};
> +				queue4 {
> +				};
> +			};
> +
> +			gmac0mdio: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "snps,dwmac-mdio";
> +			};
> +		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index c4a195dd67bf..f020da03979a 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright 2019-2021, 2024 NXP
> + * Copyright 2019-2021, 2024-2025 NXP
>   */
>  
>  /dts-v1/;
> @@ -15,6 +15,7 @@ / {
>  
>  	aliases {
>  		serial0 = &uart0;
> +		ethernet0 = &gmac0;

Sort aliases in alphabetical order.

Shawn

>  	};
>  
>  	chosen {
> @@ -43,3 +44,21 @@ &usdhc0 {
>  	no-1-8-v;
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&rgmiiaphy4>;
> +	status = "okay";
> +};
> +
> +&gmac0mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* KSZ 9031 on RGMII */
> +	rgmiiaphy4: ethernet-phy@4 {
> +		reg = <4>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index 4f58be68c818..b9c2f964b3f7 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -16,6 +16,7 @@ / {
>  	aliases {
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> +		ethernet0 = &gmac0;
>  	};
>  
>  	chosen {
> @@ -77,3 +78,21 @@ &usdhc0 {
>  	no-1-8-v;
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&rgmiiaphy1>;
> +	status = "okay";
> +};
> +
> +&gmac0mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* KSZ 9031 on RGMII */
> +	rgmiiaphy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index be3a582ebc1b..e31184847371 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
> - * Copyright 2021-2024 NXP
> + * Copyright 2021-2025 NXP
>   *
>   * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>   *          Ciprian Costea <ciprianmarian.costea@nxp.com>
> @@ -883,6 +883,54 @@ gic: interrupt-controller@50800000 {
>  			      <0x50420000 0x2000>;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		gmac0: ethernet@4033c000 {
> +			compatible = "nxp,s32g2-dwmac";
> +			reg = <0x4033c000 0x2000>, /* gmac IP */
> +			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			snps,mtl-rx-config = <&mtl_rx_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_setup>;
> +			status = "disabled";
> +
> +			mtl_rx_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <5>;
> +
> +				queue0 {
> +				};
> +				queue1 {
> +				};
> +				queue2 {
> +				};
> +				queue3 {
> +				};
> +				queue4 {
> +				};
> +			};
> +
> +			mtl_tx_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <5>;
> +
> +				queue0 {
> +				};
> +				queue1 {
> +				};
> +				queue2 {
> +				};
> +				queue3 {
> +				};
> +				queue4 {
> +				};
> +			};
> +
> +			gmac0mdio: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "snps,dwmac-mdio";
> +			};
> +		};
>  	};
>  
>  	timer {
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> index e94f70ad82d9..4a74923789ae 100644
> --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
> - * Copyright 2021-2024 NXP
> + * Copyright 2021-2025 NXP
>   *
>   * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
>   */
> @@ -18,6 +18,7 @@ aliases {
>  		mmc0 = &usdhc0;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> +		ethernet0 = &gmac0;
>  	};
>  
>  	chosen {
> @@ -93,3 +94,21 @@ &usdhc0 {
>  	disable-wp;
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&rgmiiaphy1>;
> +	status = "okay";
> +};
> +
> +&gmac0mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* KSZ 9031 on RGMII */
> +	rgmiiaphy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> 
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-nxp-s32g-boards-2d156255b592
> 
> Best regards,
> -- 
> Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> 
> 


