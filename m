Return-Path: <netdev+bounces-145218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC059CDB83
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8049228324F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E918F2DF;
	Fri, 15 Nov 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dk/ckOrE"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B518C322;
	Fri, 15 Nov 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662785; cv=none; b=c/Kp3QqNTI9zMb5y60OjPtl3bgMb93o9ANnidGbRGiaJZtT0Q1cT68GLx38ZaW/DSNoMNw/YJFsyyZxOoyarmq2vvj/w6uekYbuv0jEbtOcm3NEvpoyNP1XGqUnSmDD4cjkzyhD0l/vqCC6uRDb/BaAR+fKmeQmxUj1V9XgclM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662785; c=relaxed/simple;
	bh=Guw0XR5d0BgTLqHT6YoapFxf8RK2MKtxRUr39yYdodE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/swisNbej9wqzgPRmwzY4ZrDsDlKdET9Y2TmniWGb0LgemlzE+FWuAu1LNOf13R8uKOaZ5RYg3TusI/qOzFNghrRn61c/lP5WQwXxH1+AhqjYWdNQQUKErtRZPk9IvpbN/tkC21GGfCT+qPhLuM6GQexXLWa97AHhFV/77JIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dk/ckOrE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731662781;
	bh=Guw0XR5d0BgTLqHT6YoapFxf8RK2MKtxRUr39yYdodE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dk/ckOrE/DWFWJW2vFRsRgMJ4FhMTQHBkF0Bi4nB+DpsWTTjAmh9Q9kjgGJH7cQDu
	 9lwZwx4FUcJ3AgkXiTSlKhM4aK+cvrd8ghAok0SA0WFCWI+UP3qk1dNVoFRyNCmHKI
	 lzn4f3P+bsYz0ekZ4OJAnrTTo30iuGgyIIqXEmTaQg05KbQOKuT9Nx7qLpNJJVNlSn
	 cYCZYf4afyyG1Jy5Tb1XqEMf2k3ieULQd1mI/gBeQrpGVS/LQv83IL64YbqE6PPJ3z
	 0DUFF9OpXm3FyEe3ZgRRqSihuGp6Vxn/nMYcGkC8XwXIeJEUa27WVZWZkmJX6SdZom
	 7bgfL8C5k/7SA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C76117E35D1;
	Fri, 15 Nov 2024 10:26:20 +0100 (CET)
Message-ID: <c681604b-d439-4815-b1d9-ad435b85b5be@collabora.com>
Date: Fri, 15 Nov 2024 10:26:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Set mediatek,mac-wol on
 DWMAC node for all boards
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Michael Walle <mwalle@kernel.org>, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
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
 <bdbfb1db-1291-4f95-adc9-36969bb51eb4@collabora.com>
 <d441b614-0b71-410f-af4e-30cb164d9cd5@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d441b614-0b71-410f-af4e-30cb164d9cd5@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/11/24 20:22, Nícolas F. R. A. Prado ha scritto:
> On Thu, Nov 14, 2024 at 10:26:34AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 09/11/24 16:16, Nícolas F. R. A. Prado ha scritto:
>>> Due to the mediatek,mac-wol property previously being handled backwards
>>> by the dwmac-mediatek driver, its use in the DTs seems to have been
>>> inconsistent.
>>>
>>> Now that the driver has been fixed, correct this description. All the
>>> currently upstream boards support MAC WOL, so add the mediatek,mac-wol
>>> property to the missing ones.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   | 1 +
>>>    arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  | 1 +
>>>    arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1 +
>>>    3 files changed, 3 insertions(+)
>>>
>>
>> ..snip..
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> index 31d424b8fc7cedef65489392eb279b7fd2194a4a..c12684e8c449b2d7b3b3a79086925bfe5ae0d8f8 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> @@ -109,6 +109,7 @@ &eth {
>>>    	pinctrl-names = "default", "sleep";
>>>    	pinctrl-0 = <&eth_default_pins>;
>>>    	pinctrl-1 = <&eth_sleep_pins>;
>>> +	mediatek,mac-wol;
>>
>> The demo board has the same WoL capability as the EVK, so you can avoid adding the
>> mac-wol property here.
> 
> Not sure I follow... If we omit the property here it will use PHY WOL instead,
> while the genio 1200 EVK has the property, so it will be using MAC WOL, so
> they're already the same and omitting will make them behave differently...
> 
> Let me recap to make sure we're all on the same page:
> 
> This was the WOL configuration for each board before this series:
> MAC mt2712-evb.dts
> MAC mt8195-demo.dts
> PHY mt8395-genio-1200-evk.dts
> MAC mt8395-kontron-3-5-sbc-i1200.dts
> PHY mt8395-radxa-nio-12l.dts
> PHY mt8390-genio-700-evk.dts
> 
> After patch 1, they all get inverted:
> PHY mt2712-evb.dts
> PHY mt8195-demo.dts
> MAC mt8395-genio-1200-evk.dts
> PHY mt8395-kontron-3-5-sbc-i1200.dts
> MAC mt8395-radxa-nio-12l.dts
> MAC mt8390-genio-700-evk.dts
> 
> And after patch 2, the remaining PHY ones are set to MAC:
> MAC mt2712-evb.dts
> MAC mt8195-demo.dts
> MAC mt8395-genio-1200-evk.dts
> MAC mt8395-kontron-3-5-sbc-i1200.dts
> MAC mt8395-radxa-nio-12l.dts
> MAC mt8390-genio-700-evk.dts
> 
> The only board I have in hands and am able to test is mt8390-genio-700-evk.dts,
> which requires MAC WOL to work. For the others, your feedback on v1 was that
> they should all be set to MAC WOL. Except for mt2712, which you were not sure
> about, but it was already set to MAC WOL so we're keeping the same behavior.
> 
> That's how we got to adding mediatek,mac-wol to mt8195-demo.dts,
> mt8395-kontron-3-5-sbc-i1200.dts and mt2712-evb.dts. Let me know if there has
> been some misunderstanding.
> 

No, it's me getting confused about the current status - and I'm sorry about that.

So just ignore me saying "we can avoid adding" - we can't.
This commit is definitely needed.

Cheers,
Angelo

> Thanks,
> Nícolas
> 
>>
>>>    	status = "okay";
>>>    	mdio {
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
>>> index e2e75b8ff91880711c82f783c7ccbef4128b7ab4..4985b65925a9ed10ad44a6e58b9657a9dd48751f 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
>>> @@ -271,6 +271,7 @@ &eth {
>>>    	pinctrl-names = "default", "sleep";
>>>    	pinctrl-0 = <&eth_default_pins>;
>>>    	pinctrl-1 = <&eth_sleep_pins>;
>>> +	mediatek,mac-wol;
>>
>> I'm mostly sure that Kontron's i1200 works the same as the EVK in regards to WoL.
>>
>> Michael, I recall you worked on this board - can you please confirm?
>>
>> Thanks,
>> Angelo
>>




