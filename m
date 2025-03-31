Return-Path: <netdev+bounces-178425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E02A76FB0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE037A2BCC
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979E21B199;
	Mon, 31 Mar 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mFeBsIAX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00C211A0D;
	Mon, 31 Mar 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454429; cv=none; b=ab3OLttx6hoNvXCyc17oeNYOe/M4JRiFi2hrHbcFC4hcODzvS6Ip8dwKZMqwrJgtssKq1cZ7TH50eQYWTHah4BRIgog1AZ84HlGWMj2weE/0GLhIgAYfoYpFIIzBapJR3sC0m2OgYgcukTRX7Fujhd6wE1o1AwQZ3ZhacHlnsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454429; c=relaxed/simple;
	bh=PlrihfsL/iZRpUfrFlCaZmov095QgqCWLSORVYV/ihg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyvvTEZlgCtu7P0qntOJ9uTaJjJcH3lKrcQm2DWVNCbr5Vb4boaBqztDDahq2E7TDkL4bqhgCywUE2RxNEy8FfXiEkePAcJbpM05+UkaEfcnDsmMuU3l11GXoY354eXpVVoqw2NQvmjbEUJvGtM9rOse76eMJ4E1quE9PzuC4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mFeBsIAX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743454420; x=1744059220; i=wahrenst@gmx.net;
	bh=BGj82tf9Mp2x5Z3lm2XdVGaG3rt90dpcYkMRje+nnZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mFeBsIAXJtBlM/KEVCvYnGjFSN/m/2wX3B70U4nZoDmz4q/8jccaBX2E+LYC14Ah
	 neCQwvImYgMeDWtjvYSSSYhTB8rQrGGtfAUTWxzvBtZ5CNeWiu3zPIENXM869/8N0
	 K5SPIxb4gmWZc6tTC0YhWTNVJMs5/4feXITn0XkypaTuRFeEMC1PeuQUQjwSAJtk0
	 FSZoyXeME4DOrcUV9WS1JW+X9hJG8rFcnZE8w75LuOL4jlVU6qd4ZqLQsoxs9fdYL
	 GrUMSqIAgl6y9jyJg97fFRoQCmNuT8FwXhK1YeDGXQJ5Jth6jtjNPfWxB/wqgUC/3
	 tbMd3G4qDWIb5FPyyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1tz59h14jJ-007itT; Mon, 31
 Mar 2025 22:53:40 +0200
Message-ID: <7fa1b5c7-d5c5-45be-af6d-ae97a76eccae@gmx.net>
Date: Mon, 31 Mar 2025 22:53:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-4-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250331103116.2223899-4-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+eNl4OeqKicEhNwhiaUjdW/jGjhCXiaMai7JhNVTztgHvdDBSkz
 FzM/OlxMiBn3oIZATVurxpzexM6uCSV01ehGMlcaJJcmP2ePh+lMPNopFk2Oks0hq3XPawC
 7J6oQx9jX1rmuBX/EfTrrEkd4Zpxet6vPHklepkvtUO9q+dJ1jPR2/09jnXXCOozYEnXOEs
 pDGf+czhp30jTgGnG4WCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8P+HPtSfB2E=;PTv+e5yvv7a2DF91AqM4nM7xWMc
 U5SAavi1zpuX5zXFkcT3fyYSlsQSmCeID16Eqs3YISEKLDt804+4raCQBzyyYrX0lv8mhdx9K
 H7DSMTztYm6Tff1P4PpU6uKOS4Ute4O+2dSqi3XmoKwK7I/4K6PHGK7TfITu8zITFEQc0n0IR
 yC+X/CJCpx+EwP3HAJxGOTGf9u8oRLl7IWAeT9wNVRcDTlKsFJvTP2mYl8OJG3CHPJBeCarfP
 4unlIpk86MHkOhZNTx82d9yiI+bxVGXc2EKm+6cSWUxrJTS/RmfMVBzbGsukXLDtyUzdhFr9W
 kMDOG/R7H0cfU9VNPgl1sZkqa3ht52lfGmRe9VKzij8RlhpmvZenHeCctLEyESszHKGGyvMNE
 4t5UVV6xQlR/bZJ0ULpodrl3BQswRy1aN3EkLxI7cMoJ0tk7gge8j8GKcQk11HIbZSGJ7BA5t
 uBtMLYWCrmaaIRc75bFlxKoD1dVs+Xun9FmALTXhvKjp6VOQaia9xHO/i3WOBasjAV8/mUSDP
 JhASgBLx8rIz1xiVI1SxkUlkd1jLe5kZukBNv53NW3U/3QQ20N8mGK/hDQBaPfdVgKFbOYtCy
 9P35KCrLhDoj/py1M7a4TDSIi0P+2aS2fuMAM1PFEdODCoVsF8ruPBP+i2b1FRSum+oha75bD
 YfQWXCj/c4rXsGjqJKfft1/dyii9kAYaU51ymLxwEESQMIQWH43RRevSJO5HbXLUZXr8CU5XG
 2biooe+AB+JZzrTIfhiiCxpxtlGVQuiJxeL+nogBocXNXFOlrRexyBkAXaaO39/OKTvY02Eo3
 plleYoR/wU+SFCSs9jo3+S9rLTIs+vedhKJDgnm+04a1tkL3oXI4En4vr8BxdYjxxei2OpXlT
 MV3PU61r+cChvvh5My727WZfV9wsTvcNkDobMU26r/VeGSQW5UiAiu9Mk2v3PfXp7vswWx7SI
 xPt5irHGZ+x2KHi3sfHfcYYtGqrFLFojXcrU1p/GWhvZ1Pnt0kdRg5Ldf3BYSGcx7hErbpFuz
 PqxrxJ3eNXTNaqcGiIgWLbHtOapfNjLad1I9uyxC39PwcUWK6fuoRAENE1lnOW8oqOKaK4Uzu
 eLA3gRx11CTsTGyIjRHAR8DNqDo9nSxrpzqeGuA3fVMAfYDdukbDwXyhi0RiGaunOXbo0ZUfD
 GApDLXEuQPKubu3Swmtte9TpO1f3m1LCfHUCae8VrVqzOkZYDoFvxbAzkeUxKdNhasMITkPG7
 98BEgRJOYy7O2WQ7zVhMXmyi3weJhl1PjJkgfyWxKPOmXh5n3u5Jv64czXHmCv6vJgS25fXOd
 tQHrX3BH5O5c8k/GLAEvXPahe/6jBzjRe/u/3Yrp3BRvPU3yk/6+1zQgolu/w6SZLDwUzvhcq
 U2oPxLehLPX6aPo7JP+2HGpBekqzv6evrbhSJooS++TONF319+TwTNGOPvHl4L73kuaxZJO+B
 5tT/jv/cNq6XAHWoAmGb4f62Ewew=

Hi,

Am 31.03.25 um 12:31 schrieb Lukasz Majewski:
> The description is similar to the one used with the new CPSW driver.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Remove properties which are common for the imx28(7) SoC
> - Use mdio properties to perform L2 switch reset (avoid using
>    deprecated properties)
>
> Changes for v3:
> - Replace IRQ_TYPE_EDGE_FALLING with IRQ_TYPE_LEVEL_LOW
> - Update comment regarding PHY interrupts s/AND/OR/g
> ---
>   arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 54 +++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts=
/nxp/mxs/imx28-xea.dts
> index 6c5e6856648a..8642578fddf3 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> @@ -5,6 +5,7 @@
>    */
>
>   /dts-v1/;
> +#include<dt-bindings/interrupt-controller/irq.h>
>   #include "imx28-lwe.dtsi"
>
>   / {
> @@ -90,6 +91,59 @@ &reg_usb_5v {
>   	gpio =3D <&gpio0 2 0>;
>   };
>
> +&eth_switch {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mac0_pins_a>, <&mac1_pins_a>;
> +	phy-supply =3D <&reg_fec_3v3>;
> +	status =3D "okay";
> +
> +	ethernet-ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		mtip_port1: port@1 {
> +			reg =3D <1>;
> +			label =3D "lan0";
> +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> +			phy-mode =3D "rmii";
> +			phy-handle =3D <&ethphy0>;
> +		};
> +
> +		mtip_port2: port@2 {
> +			reg =3D <2>;
> +			label =3D "lan1";
> +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> +			phy-mode =3D "rmii";
> +			phy-handle =3D <&ethphy1>;
> +		};
> +	};
> +
> +	mdio_sw: mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		reset-gpios =3D <&gpio3 21 0>;
i'm a huge fan of the polarity defines, which makes it easier to understan=
d.

Btw since you introduced the compatible in the DTS of a i.MX28 board, it
would be nice to also enable the driver in mxs_defconfig.

Regards
> +		reset-delay-us =3D <25000>;
> +		reset-post-delay-us =3D <10000>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			reg =3D <0>;
> +			smsc,disable-energy-detect;
> +			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
> +			/* line to handle both, their interrupts (OR'ed) */
> +			interrupt-parent =3D <&gpio4>;
> +			interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg =3D <1>;
> +			smsc,disable-energy-detect;
> +			interrupt-parent =3D <&gpio4>;
> +			interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
> +};
> +
>   &spi2_pins_a {
>   	fsl,pinmux-ids =3D <
>   		MX28_PAD_SSP2_SCK__SSP2_SCK


