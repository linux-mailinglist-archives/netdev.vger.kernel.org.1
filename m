Return-Path: <netdev+bounces-144753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC69C8639
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64308B24D18
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10751E7C2D;
	Thu, 14 Nov 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hsoLDJmr"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EC1D1724;
	Thu, 14 Nov 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576399; cv=none; b=O5AIHOQoRmVy5S7jgLPlEZTkkZ7JYEOLrmYs+9xuEPAE+LPDWUoae8eV3wXqP4SSB5wKVNOCdUwrsCmw/GomRvaEL5dtgg13Ipxhgw+vG7IiEldhLOhGoRevC5za1ogNs4x2zs/pjFKVYgnSq3Qt06UWvXbPbbfbha9tw0uARdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576399; c=relaxed/simple;
	bh=bYzcUGF7hCrjkXL1fsayWn1/CBgbO0ZZ6aSmChTaQt8=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=N4nnW4lnTJ5HaM7TSOIBhFH/Y36pseU3fkjUHWer03Os8iNh9gZZ5iP1nUv4wXZKBpokYc3+ULZb7ZDe+5aPiHjvR7tP9DTlQPxbop8Vo253gPA+vUXxZLqy8nkJ09MIVJ9bb1Cu6KU92e/zMzqXBIDkw9oGdwd9Xy0tTtKKekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hsoLDJmr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731576395;
	bh=bYzcUGF7hCrjkXL1fsayWn1/CBgbO0ZZ6aSmChTaQt8=;
	h=Date:Subject:Cc:References:From:To:In-Reply-To:From;
	b=hsoLDJmrvZeIQPuX9zZPHFsDVyqts0ZNfONnp53S0u1wSY4gI6SNQatZNdXS/iRJD
	 Zzn+MsQrvvhsXlrZHcySjYGxTqvBvHGZgOcPMlirFAhjcJ48nOAgcaD5EqyV35JXFT
	 T30pWXchhQ5ftFf5GwhU/kQtFKMsOobGjucg+lHsaP03toFfGTVzagCQXx8ecx4fZb
	 OCX9KjbSp7uJ1diSutOUC7BX4VkisUZN3bQdZQYABhfBFXyLI2pII5cbs415p4qG+5
	 qF/hN6djXJyHw91lytp8g16N6MOFI5u81O35Jmcbn++WL3e6Y5BHxwHpX4EDfQuaI1
	 fPTWvybugzk+Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9893117E1522;
	Thu, 14 Nov 2024 10:26:34 +0100 (CET)
Message-ID: <bdbfb1db-1291-4f95-adc9-36969bb51eb4@collabora.com>
Date: Thu, 14 Nov 2024 10:26:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Set mediatek,mac-wol on
 DWMAC node for all boards
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Biao Huang <biao.huang@mediatek.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
 <20241109-mediatek-mac-wol-noninverted-v2-2-0e264e213878@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Michael Walle <mwalle@kernel.org>
In-Reply-To: <20241109-mediatek-mac-wol-noninverted-v2-2-0e264e213878@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/11/24 16:16, Nícolas F. R. A. Prado ha scritto:
> Due to the mediatek,mac-wol property previously being handled backwards
> by the dwmac-mediatek driver, its use in the DTs seems to have been
> inconsistent.
> 
> Now that the driver has been fixed, correct this description. All the
> currently upstream boards support MAC WOL, so add the mediatek,mac-wol
> property to the missing ones.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   | 1 +
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  | 1 +
>   arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1 +
>   3 files changed, 3 insertions(+)
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> index 31d424b8fc7cedef65489392eb279b7fd2194a4a..c12684e8c449b2d7b3b3a79086925bfe5ae0d8f8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -109,6 +109,7 @@ &eth {
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&eth_default_pins>;
>   	pinctrl-1 = <&eth_sleep_pins>;
> +	mediatek,mac-wol;

The demo board has the same WoL capability as the EVK, so you can avoid adding the
mac-wol property here.

>   	status = "okay";
>   
>   	mdio {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> index e2e75b8ff91880711c82f783c7ccbef4128b7ab4..4985b65925a9ed10ad44a6e58b9657a9dd48751f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> @@ -271,6 +271,7 @@ &eth {
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&eth_default_pins>;
>   	pinctrl-1 = <&eth_sleep_pins>;
> +	mediatek,mac-wol;

I'm mostly sure that Kontron's i1200 works the same as the EVK in regards to WoL.

Michael, I recall you worked on this board - can you please confirm?

Thanks,
Angelo


