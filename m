Return-Path: <netdev+bounces-191823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376BABD6BE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE917AA3E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D6276032;
	Tue, 20 May 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8SRquc/"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F810E4;
	Tue, 20 May 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740449; cv=none; b=mW75xLirzjpV47Oe7fAxNmZSXdEu6iXExKtySRH/wkevyhnT9DoOqdtpPw6q32oeYxDp8WnkrPmVrylznxuRJWjfTI4Io8X8aV8VIvUZ5fBk52iMX7cAYXzYMMUgflFgmkAHdDH/1nbwgjD1r/PK6671GxE20wf3gJAPV5k/Toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740449; c=relaxed/simple;
	bh=F8a6adaotmO9OFJk2lV6zJwLtEE1bNQqk3sdSWmUODU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gjrasrm/DmJIMxtiS4HsVShPmI9hj2ix38U94RbMUPy/ZniGTaytsSGbOQGNJnkNEJoUXmRXreVPaqDkL02/x0047rfsP0TOYFML53ipRb7ApY1xoi8N1SRHBJLRDcKBtwxlF9m/8qnRvZGyVh6PQdxDD43eHAtAtvS84G/qdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8SRquc/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747740445;
	bh=F8a6adaotmO9OFJk2lV6zJwLtEE1bNQqk3sdSWmUODU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P8SRquc/6RmoHWKXfMC2MT4Sn7ljY4RBbPhkcOcQhdXZGtrP8Fogm9M1uF7Q788oT
	 2ILTvSGALDAITwCMLhIiQ8UCK7Urew5Go0Ec0U+9AV4epkUXSvdAfaeke0psbGaibE
	 eb0BpNpsx3Z9UvzEU13Hx8che2VE3ZpRzEFtCjakFxVqug05oXEwY4dRyUDSPyxXg8
	 pMGmjfNS9i4Mn67v3Lzp7y1ySHoCAKKaDWnAebNRyMNnmyf8Pcn7B9vkxIapgo5tOl
	 YavD0qx5ieU9Ku39uxV/OvxJQDUkJsH3NZBXOllcNQ3Q2fkZbwoqCxinhCrBtoYjdf
	 vcRqi6I2hPm4g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D0F2217E0E89;
	Tue, 20 May 2025 13:27:23 +0200 (CEST)
Message-ID: <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
Date: Tue, 20 May 2025 13:27:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] arm64: dts: mediatek: mt7988: add cci node
To: Frank Wunderlich <linux@fw-web.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250516180147.10416-1-linux@fw-web.de>
 <20250516180147.10416-8-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250516180147.10416-8-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/05/25 20:01, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add cci devicetree node for cpu frequency scaling.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 33 +++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index ab6fc09940b8..64466acb0e71 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -12,6 +12,35 @@ / {
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	cci: cci {
> +		compatible = "mediatek,mt8183-cci";

While you can keep the mediatek,mt8183-cci fallback, this needs its own compatible
as "mediatek,mt7988-cci", therefore, I had to drop this patch from the ones that I
picked.

Please add the new compatible both here and in the binding.

Cheers,
Angelo

> +		clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
> +			 <&topckgen CLK_TOP_XTAL>;
> +		clock-names = "cci", "intermediate";
> +		operating-points-v2 = <&cci_opp>;
> +	};
> +
> +	cci_opp: opp-table-cci {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp-480000000 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <850000>;
> +		};
> +		opp-660000000 {
> +			opp-hz = /bits/ 64 <660000000>;
> +			opp-microvolt = <850000>;
> +		};
> +		opp-900000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <850000>;
> +		};
> +		opp-1080000000 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <900000>;
> +		};
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -25,6 +54,7 @@ cpu0: cpu@0 {
>   				 <&topckgen CLK_TOP_XTAL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> +			mediatek,cci = <&cci>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -36,6 +66,7 @@ cpu1: cpu@1 {
>   				 <&topckgen CLK_TOP_XTAL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> +			mediatek,cci = <&cci>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -47,6 +78,7 @@ cpu2: cpu@2 {
>   				 <&topckgen CLK_TOP_XTAL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> +			mediatek,cci = <&cci>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -58,6 +90,7 @@ cpu3: cpu@3 {
>   				 <&topckgen CLK_TOP_XTAL>;
>   			clock-names = "cpu", "intermediate";
>   			operating-points-v2 = <&cluster0_opp>;
> +			mediatek,cci = <&cci>;
>   		};
>   
>   		cluster0_opp: opp-table-0 {



