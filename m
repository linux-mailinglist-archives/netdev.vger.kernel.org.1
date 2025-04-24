Return-Path: <netdev+bounces-185775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77EA9BB29
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5434A271F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AA22170B;
	Thu, 24 Apr 2025 23:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A1A93D;
	Thu, 24 Apr 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536852; cv=none; b=WtCKPsv4E1gS4KYHgACvVOBN66Q3A4zUF0GqocqtIQJ5eukPPyIt/FQRBztI+0emwKE0sYzzzcLvwWjouxLco4jokaq7YuONCTqdQtVVGdMqNwl3hJYV9AXaVj2s0ygH7H5ag8OAZsmN+Ha3OtVxBXA81y9dTBaMUf8w3fcj51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536852; c=relaxed/simple;
	bh=N4jW3VnF6lQU+lm5lYfa5xJbQYoyDpUDVIHaXmX3tL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POmSnxhr7Gi5LzyWz4B+Kzul7R0V3uMBTBlwlv+ZKA1Hd4ErDW/dtmAh9+pn4wtCpuMCo/YcIcOtUrkcGSptsq1YDNzKNSdd50XXscN48niDfsvTn1QgwzyNI6Gti1LTHwuUOx8I0tonqsAstHpastB5CSPM0Y5CCdmNou4hf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C472F;
	Thu, 24 Apr 2025 16:20:43 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6653F59E;
	Thu, 24 Apr 2025 16:20:46 -0700 (PDT)
Date: Fri, 25 Apr 2025 00:19:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet
 MAC
Message-ID: <20250425001945.48473374@minigeek.lan>
In-Reply-To: <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
	<20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
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

On Thu, 24 Apr 2025 18:08:41 +0800
Yixun Lan <dlan@gentoo.org> wrote:

> Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> including the A527/T527 chips. MAC0 is compatible to the A64 chip which
> requires an external PHY. This patch only add RGMII pins for now.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Thanks, looks good now!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe9d783e32f6d61a74ef7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			rgmii0_pins: rgmii0-pins {
> +				pins = "PH0", "PH1", "PH2", "PH3", "PH4",
> +				       "PH5", "PH6", "PH7", "PH9", "PH10",
> +				       "PH14", "PH15", "PH16", "PH17", "PH18";
> +				allwinner,pinmux = <5>;
> +				function = "emac0";
> +				drive-strength = <40>;
> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins = "PF0" ,"PF1", "PF2", "PF3", "PF4", "PF5";
>  				allwinner,pinmux = <2>;
> @@ -409,6 +418,15 @@ i2c5: i2c@2503400 {
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
> @@ -521,6 +539,28 @@ ohci1: usb@4200400 {
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
> +			pinctrl-0 = <&rgmii0_pins>;
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


