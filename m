Return-Path: <netdev+bounces-136133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A49A079C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0632828147E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA4206E66;
	Wed, 16 Oct 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k5Thxby6"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57691DE3C9;
	Wed, 16 Oct 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075307; cv=none; b=KCBjuIygowRA0bZW0ZmeNmEyWWynaDVru4D5CkQzcvIzS6Lre8kzjlqjsbHNN0VnwxzGepMT9xzPJbjK713DOz6eQ1swR7QEHdm4LMa/HUyjNUGdl6hvEbbe9v/Pe0r6cVjEIiZcyIJ7cL6/z+QkIWpljNvtC187z0TbvFuAIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075307; c=relaxed/simple;
	bh=heW2gSjWmQF9M4ji5o3r7Gfvxeg1F4J8kCossJjMnSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgTdTITEciQhM9/vWHwWC/SdYEyVzqFSnQx1A9ow/CHWFxT9YK+nLf2ZYql1zjN332WNGBdGGWuET8C/hw+AQFu3d/htCJVcVjV5LL8oJQAP8Dd94hIUQDYoonYR3LZb68/Kpbtyfi32WCULlphLEPeWGcWJVFsCoFpfsFHvzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k5Thxby6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729075304;
	bh=heW2gSjWmQF9M4ji5o3r7Gfvxeg1F4J8kCossJjMnSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5Thxby6dFoix1wv0Vi/LR5UCYus34KMbreWE84je5yfyimTaBFBccyUA4fpDjI8j
	 k0uGuas2YCbC5bUwLyKrQCKFgnzmNajtih74LiQTAl6kIINfs3Aaa5sA5KsaqC7Ixg
	 mi4gc1zU8IdptodAWw0mojB8xYkDDkRMGxH6Veh9eyAtjIy8p6AZV+093BYr1bwgwx
	 ZElAaM9OITqwcAwslN9SafT/yLQxakn1415Iea84Ai1N4vBTvZ8uQZv3X6RdVqZUAe
	 uErS7owM/BG1r1LQX1FIpoMaJ4npffCuIt4rgnt/UqfECkxvIRumjcMxd0ePHlNDWt
	 J71ydL0Z3jCpg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43AE817E139E;
	Wed, 16 Oct 2024 12:41:43 +0200 (CEST)
Message-ID: <85f0b520-95dd-4ad3-a1a9-544e00089533@collabora.com>
Date: Wed, 16 Oct 2024 12:41:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>
References: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
 <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/10/24 20:15, Nícolas F. R. A. Prado ha scritto:
> Enable ethernet on the Genio 700 EVK board. It has been tested to work
> with speeds up to 1000Gbps.
> 
> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
> [Cleaned up to pass dtbs_check, follow DTS style guidelines, and split
> between mt8188 and genio700 commits]
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index 0a6c9871b41e5f913740e68853aea78bc33d02aa..73e34e98726d36785e8b2cef73f532b6bb07c97f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -24,6 +24,7 @@ / {
>   
>   	aliases {
>   		serial0 = &uart0;
> +		ethernet0 = &eth;
>   	};
>   
>   	chosen {
> @@ -845,6 +846,30 @@ pins-wifi-enable {
>   	};
>   };
>   
> +&eth {
> +	phy-mode ="rgmii-rxid";
> +	phy-handle = <&ethernet_phy0>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default_pins>;
> +	pinctrl-1 = <&eth_sleep_pins>;

> +	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 10000 10000>;
> +	mediatek,tx-delay-ps = <2030>;
> +	mediatek,mac-wol;

	mediatek,mac-wol;
	mediatek,tx-delay-ps = <2030>;
	snps,reset-delays-us = <0 10000 10000>;
	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;

Cheers,
Angelo

> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet_phy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-id001c.c916";
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
>   &pmic {
>   	interrupt-parent = <&pio>;
>   	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
> 



