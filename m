Return-Path: <netdev+bounces-185347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FEA99D33
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410281942F40
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BF339A1;
	Thu, 24 Apr 2025 00:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEE18AE2;
	Thu, 24 Apr 2025 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455459; cv=none; b=de8FZwQBz0OC//bOC/BOrp5FeAV3CagbEGoBayHziDF+AUwDeJ91dWvKukx1tjJ+O0M4xMSoJ/YowMKEreoM5V7rgO/6evW9AZTnRuyh/dulSP5G+5tMecJPm1/UEQUiHGTOQCrrTWNA0/Tdq+U5BJ8DLbiqd4gmW2oOA1h4QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455459; c=relaxed/simple;
	bh=dcuOAJR3RzXjILHwlij2pVe8ISZbOyZg+wgmmxRGDGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBMvSmA5QaL58rxDaCilw86qFujQWQcGy1XsRJvyhpA1EOkYnuNWC9OR5b5ikVDoGI+Te+mNQV5SfOsKmdAXsDnWlxupADIGLormaycJWW8tyu5z0LLLnTsnyxu7X1wk5zlqCRgEAJtC+EXlGecovmdkCzdijJmRJ55eaEIVn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ED171063;
	Wed, 23 Apr 2025 17:44:12 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84733F59E;
	Wed, 23 Apr 2025 17:44:14 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:43:14 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
Message-ID: <20250424014314.146e088f@minigeek.lan>
In-Reply-To: <20250423-01-sun55i-emac0-v1-3-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-3-46ee4c855e0a@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 22:03:24 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi Yixun,

thanks for sending those patches!

> Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> including the A527/T527 chips.

maybe add here that MAC0 is compatible to the A64, and requires an
external PHY. And that we only add the RGMII pins for now.

> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 42 ++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index ee485899ba0af69f32727a53de20051a2e31be1d..c3ba2146c4b45f72c2a5633ec434740d681a21fb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -126,6 +126,17 @@ pio: pinctrl@2000000 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			emac0_pins: emac0-pins {

Both the alias and the node name should contain rgmii instead of emac0,
as the other SoCs do, I think:
			rgmii0_pins: rgmii0-pins {

> +				pins = "PH0", "PH1", "PH2", "PH3",
> +					"PH4", "PH5", "PH6", "PH7",
> +					"PH9", "PH10","PH13","PH14",
> +					"PH15","PH16","PH17","PH18";

I think there should be a space behind each comma, and the
first quotation marks in each line should align.

PH13 is EPHY-25M, that's the (optional) 25 MHz output clock pin, for
PHYs without a crystal. That's not controlled by the MAC, so I would
leave it out of this list, as also both the Avaota and the Radxa don't
need it. If there will be a user, they can add this separately.

> +				allwinner,pinmux = <5>;
> +				function = "emac0";
> +				drive-strength = <40>;
> +				bias-pull-up;

Shouldn't this be push-pull, so no pull-up?

The rest looks correct, when compared to the A523 manual.

Cheers,
Andre

> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
>  				allwinner,pinmux = <2>;
> @@ -409,6 +420,15 @@ i2c5: i2c@2503400 {
>  			#size-cells = <0>;
>  		};
>  
> +		syscon: syscon@3000000 {
> +			compatible = "allwinner,sun55i-a523-system-control",
> +				     "allwinner,sun50i-a64-system-control";
> +			reg = <0x03000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +		};
> +
>  		gic: interrupt-controller@3400000 {
>  			compatible = "arm,gic-v3";
>  			#address-cells = <1>;
> @@ -521,6 +541,28 @@ ohci1: usb@4200400 {
>  			status = "disabled";
>  		};
>  
> +		emac0: ethernet@4500000 {
> +			compatible = "allwinner,sun55i-a523-emac0",
> +				     "allwinner,sun50i-a64-emac";
> +			reg = <0x04500000 0x10000>;
> +			clocks = <&ccu CLK_BUS_EMAC0>;
> +			clock-names = "stmmaceth";
> +			resets = <&ccu RST_BUS_EMAC0>;
> +			reset-names = "stmmaceth";
> +			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emac0_pins>;
> +			syscon = <&syscon>;
> +			status = "disabled";
> +
> +			mdio0: mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		r_ccu: clock-controller@7010000 {
>  			compatible = "allwinner,sun55i-a523-r-ccu";
>  			reg = <0x7010000 0x250>;
> 


