Return-Path: <netdev+bounces-183468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24FA90C12
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AF21886B08
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57F224225;
	Wed, 16 Apr 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eP4xPZhw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EC18DB05;
	Wed, 16 Apr 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830972; cv=none; b=k5oLwMxUWjGod/FlU2cKWL7ZsG/lra+uA7oAjUmuj2D7IdaM9YPz+BAgqC2oZC3yTNurYyv9MyINu1BKeB2mhoLn7W01zmeMucUXgnRGw2211yWIEw4xyHsupK5/qK0ap4O+a08DoivLZdNzMTfJHHqoRBLAGEsVTHt0fKETNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830972; c=relaxed/simple;
	bh=eZDCeJusl4YvbrBel3CeklONB/zaP1h9uSVKYJI0z14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy/Qf9VocfX3eTXWpjCs+kl8XALmgPiMy1FLt3ItOoqr2owrO/Hc7Na9MPH9tD7HOQZUUgEVB2OnfCrHZxIPZJWm2gOOSKkNCZ9boQZ+6MQVnf3s1gh74KKaaWIoqIveTXNZ4dbOpPQ4f/g9MObnVaRjg/Z/tzKyPOgg768j4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eP4xPZhw; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744830959; x=1745435759; i=wahrenst@gmx.net;
	bh=0Fyt/wURX/mltb2vqUsAYfg/uzruTniev2Ppmgs5KiI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eP4xPZhwayV0qRsC4b25Q49LyEmZGMIlxbn9IzUHLF43ECpS5F3GNPWeuVaBalLY
	 Pkum6P20lJTMECwXPfP+T5h7/Jxml7vLwhSRkYN2S7uLZ6LUg+U/doWhJJpjUJ4Iz
	 lT6+DhibvxkeaBtgLoiNyRZcsWut24xOaqVgFsKSV4QfQKJcN/zPPjsr7EOCYT+C0
	 PsJv0RPrzPWB02AQPugJfT/bXXFLXc3deonlEfAqDFXE4OkZUTPRJeHiC2tJFuoQ4
	 mvwOgPZjyMpXuYLqBk3Kj6gI1zDbaI7EgXVtWXRWhFSlIfiLi6Xcr1BZbTaN+gXux
	 ugH1G0Ag3bUFajgGIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1uV54z2DPi-00SFjX; Wed, 16
 Apr 2025 21:15:59 +0200
Message-ID: <06c21281-565a-4a2e-a209-9f811409fbaf@gmx.net>
Date: Wed, 16 Apr 2025 21:15:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 2/6] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2
 switch description
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-3-lukma@denx.de>
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
In-Reply-To: <20250414140128.390400-3-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhR9yFAQqeXq7tpo+BVlY5V6At1F7eSbQwtC+8DLgGgYcEvaPHB
 YvRBP+brt1418Jxot0UdwrAqCK2iHeWbVVeu/W+QF1JjsSKAUQdASGGg2F7wPIJ2gjJ6bpV
 1Tw1MMpTcSqqOIRQXRMEUSfAXjDDhHOl0Wx6y1gtomCstmu2i1ezvWAJie7VDPvLPZALLUf
 UygcwzAsl6PjV/KG51dUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XlsGXYRQO+Q=;Kai+BO1wU8iAl1JoOXLDwr47/iz
 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

Hi Lukasz,

Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> The current range of 'reg' property is too small to allow full control
> of the L2 switch on imx287.
>
> As this IP block also uses ENET-MAC blocks for its operation, the addres=
s
> range for it must be included as well.
>
> Moreover, some SoC common properties (like compatible, clocks, interrupt=
s
> numbers) have been moved to this node.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> ---
> Changes for v2:
> - adding extra properties (like compatible, clocks, interupts)
>
> Changes for v3:
> - None
>
> Changes for v4:
> - Rename imx287 with imx28 (as the former is not used in kernel anymore)
>
> Changes for v5:
> - None
> ---
>   arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nx=
p/mxs/imx28.dtsi
> index bbea8b77386f..a0b565ffc83d 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
> @@ -1321,8 +1321,12 @@ mac1: ethernet@800f4000 {
>   			status =3D "disabled";
>   		};
>  =20
> -		eth_switch: switch@800f8000 {
> -			reg =3D <0x800f8000 0x8000>;
> +		eth_switch: switch@800f0000 {
> +			compatible =3D "nxp,imx28-mtip-switch";
> +			reg =3D <0x800f0000 0x20000>;
> +			interrupts =3D <100>, <101>, <102>;
> +			clocks =3D <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> +			clock-names =3D "ipg", "ahb", "enet_out", "ptp";
>   			status =3D "disabled";
from my understanding of device tree this file should describe the=20
hardware, not the software implementation. After this change the switch=20
memory region overlaps the existing mac0 and mac1 nodes.

Definition in the i.MX28 reference manual:
ENET MAC0 ENET 0x800F0000 - 0x800F3FFF 16KB
ENET MAC1 ENET 0x800F4000 - 0x800F7FFF 16KB
ENT Switch SWITCH 0x800F8000 - 0x800FFFFF 32KB

I'm not the expert how to solve this properly. Maybe two node references=
=20
to mac0 and mac1 under eth_switch in order to allocate the memory=20
regions separately.

Sorry, if i missed a possible discussion about this before.

Regards
>   		};
>   	};


