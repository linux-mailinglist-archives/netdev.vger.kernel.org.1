Return-Path: <netdev+bounces-200264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EDAE4001
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4312617A47B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781023C4F3;
	Mon, 23 Jun 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nlCFAT4q"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE471F542E;
	Mon, 23 Jun 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681325; cv=none; b=CBRmeoMwLD6XtBCc2hn5RFWRrHlixKkKDAfT1a8ta2xxjhkapvaKu8sgUYuPw7V0+btUW2j6v14YT6stLUk7Kk7qPran1qqEvlIcOPvHIoa+9GLSkyagDqM5fvHNY/hqCTPcHDjl9BJS88muCzfr6/XfhsSiWZsj5AZOaJtCBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681325; c=relaxed/simple;
	bh=BX3kWGffKwR8jKbbugtulEnXj6o/sd8kiTE3A0kY6pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ja20Sag3KoPMTfbD3ZxqeXIVdIBS1eM7FHrjYjz+IQSGEfhYcEjcfKFmH6s0WspOY913pEa//B93Xx8M27IcAO8Ht5PUEd84tvm7pLA8L0H12IxkEcpp4rA7ScyXQJG5GHukvGInEaXz6HcAti+WnPNgHLlSka7g1YAlt1pv2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nlCFAT4q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750681322;
	bh=BX3kWGffKwR8jKbbugtulEnXj6o/sd8kiTE3A0kY6pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlCFAT4qrsm8CJbwA6C9jm53wiNm1n1d/wI2w8xmVhuIRTPHk06c68q4u4nMFKm+n
	 T3RYFwA4sQatd9lOioQGhKgiY1kRNkjFqN0DkadumCvSCKtFp7vJlLiY0jZQ/GFYCv
	 OwHXaKXhfzxdmTtDvbg6qySKVx/CdGeM8Iwr9Xkm8unsdLe6M4pA/Hruzscf3CA9cv
	 Y4MiotqPf3FEuQUFRYKDrQPakNIFMHv6VxGBm2NPrqqEkTgE5+P9PAuOwa+9sEkYnf
	 0mzckR8pSS/VBtF4pEVra+r4X4uVNfk62V+chyGPdfeaYHRSgpUrfprijXC6tEvIqn
	 GkpvbbRQMwTmw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1349417E0FDB;
	Mon, 23 Jun 2025 14:22:01 +0200 (CEST)
Message-ID: <dfbd00bd-37bd-425a-aa98-e536b2a3f2d4@collabora.com>
Date: Mon, 23 Jun 2025 14:22:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/30] dt-bindings: reset: Add MediaTek MT8196 Reset
 Controller binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Laura Nao
 <laura.nao@collabora.com>, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250623102940.214269-1-laura.nao@collabora.com>
 <20250623102940.214269-30-laura.nao@collabora.com>
 <2bc23bcf-0021-44dd-ae42-9ef0e95e3b32@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2bc23bcf-0021-44dd-ae42-9ef0e95e3b32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/06/25 14:13, Krzysztof Kozlowski ha scritto:
> On 23/06/2025 12:29, Laura Nao wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Add a binding for the PEXTP0/1 and UFS reset controllers found in
>> the MediaTek MT8196 Chromebook SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   .../reset/mediatek,mt8196-resets.h            | 26 +++++++++++++++++++
> 
> This belongs to the binding doc.
> 
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h
>>
>> diff --git a/include/dt-bindings/reset/mediatek,mt8196-resets.h b/include/dt-bindings/reset/mediatek,mt8196-resets.h
>> new file mode 100644
>> index 000000000000..1a01b2b01f7f
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt8196-resets.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
> 
> Wrong license, use standard ones.

Oh WHOOOOOPS! No idea how that happened.

Laura, can you please change this to (GPL-2.0-only OR BSD-2-Clause)?

Thanks!

Cheers,
Angelo

> 
> Best regards,
> Krzysztof



