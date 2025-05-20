Return-Path: <netdev+bounces-191828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73133ABD777
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A703B127E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1C27BF83;
	Tue, 20 May 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BH8osOYN"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E714F9FB;
	Tue, 20 May 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742118; cv=none; b=NRAYfEIA3avj2VaIqr8jgSqyQTeQlma+cjIK5rhqVbQWaEPZa5eTk+5sFOkMzSeODlEUv2PVvXIlglj3yP8BhlEa+kCJ2RrkO4pqS87XamVeLnprpD6N5PPEOU62yqL7+AD5KiS0KKfZMMmnzJeATZMsMa+fcEYGUvY1jyEYgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742118; c=relaxed/simple;
	bh=5RUqzLMaMG5lBzncssnhHrZkrCiokJ9qjd2PNJ/2yKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3AqRaX21Vq1eXQgmCn3diyHxH1p6JhgCneRP732evaaknqrm/2WCZHuw+yxdn8cjNMZhqssBHivNUG+QoDRt28hzkwFRshftOGeibpf5Xmar56RtWLInkxlu/A01b8eHl76uynsyWfN65TkethdAR6pJ1l+xeRBjr/iXLGC7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BH8osOYN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747742114;
	bh=5RUqzLMaMG5lBzncssnhHrZkrCiokJ9qjd2PNJ/2yKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BH8osOYNE7umJPQkBEZqyCmHfgRY16TdRs2HA7tz8P7i5G1ORAwxVBwf5J7EaHD7t
	 XtvvFJRY/KMIdb+/byxSxyM77NPEozPuxAz1Og+VhFJrz9BYTCdW+UvHcX3810mpmZ
	 X6FJlJdKPEZdbkKNoLxZa7xxiC9Y54n8tyYqvsyfijatmWygpWMCyAChgviL3OvgBq
	 4gJfIB1QsnR7ftaC6l9v4nZBNtVtbAlbH6lMTatgsRIu7XivtkIVwqqDgZw1EXIjXy
	 HaK5Bz7V5dyqHytCdpCxpx6gNex0rlT0egjiajJfzypwdb7dr3ieooKjIaVcIw0l9y
	 MF/SBS8B/IyQQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3AE0D17E0E2D;
	Tue, 20 May 2025 13:55:13 +0200 (CEST)
Message-ID: <c83aa789-662a-455d-a535-237d42df3eb9@collabora.com>
Date: Tue, 20 May 2025 13:55:12 +0200
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
 <7a563716-a7c6-446d-b66d-bc71c6207ef6@collabora.com>
 <4BEF26F3-957D-4BB4-BF7B-69DCFCC513DC@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4BEF26F3-957D-4BB4-BF7B-69DCFCC513DC@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/05/25 13:53, Frank Wunderlich ha scritto:
> Am 20. Mai 2025 13:27:23 MESZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 16/05/25 20:01, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add cci devicetree node for cpu frequency scaling.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 33 +++++++++++++++++++++++
>>>    1 file changed, 33 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> index ab6fc09940b8..64466acb0e71 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> @@ -12,6 +12,35 @@ / {
>>>    	#address-cells = <2>;
>>>    	#size-cells = <2>;
>>>    +	cci: cci {
>>> +		compatible = "mediatek,mt8183-cci";
>>
>> While you can keep the mediatek,mt8183-cci fallback, this needs its own compatible
>> as "mediatek,mt7988-cci", therefore, I had to drop this patch from the ones that I
>> picked.
>>
>> Please add the new compatible both here and in the binding.
> 
> Ok,but you have to drop last one too (add proc-supply) else there are build-errors.
> 

Many many thanks for the reminder, but yes, I already dropped that one too ;-)

>> Cheers,
>> Angelo
>>
> 
> 
> regards Frank


