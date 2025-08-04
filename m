Return-Path: <netdev+bounces-211595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A0B1A4FF
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8809A3B1392
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340A26F463;
	Mon,  4 Aug 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ieC+jPHW"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751F242D70;
	Mon,  4 Aug 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318005; cv=none; b=VeT0b03cxOnaxS7b/ZlJvY/335ZKPdS3jx1Rf+Vw4KwLQUa/fvIprvGltxTSWCmRggiYWHdtJC6TRj6ybRP/EcYSOP0jQaUe/QXbSJIAxO/oF4rM1HEESi5r9Y1UOEiEi2p1WNdxWYrw5+3vOoXP9fWD+841WgqaR+KaVtM9vxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318005; c=relaxed/simple;
	bh=6Xq6lWAgsDQe8fpl2VHDMWoTzwPSyCoMukrEfer0HQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsuaukHfy7rk+jI/phSCPBIvDwvIbzVH0K4hrfVCmcmtEVl5Y/tXveectbTd7kEti81CSZqN82LKgbYQa1/9oSnCSDggta/XUFniqHwvVvGJlYFdZJKpTXAJ5GOpqbzHxGeucqLxOssU8d84Y3wzRBvDeX6uNlp5XThTHlsrSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ieC+jPHW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754318001;
	bh=6Xq6lWAgsDQe8fpl2VHDMWoTzwPSyCoMukrEfer0HQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ieC+jPHWLIqpcxWfiCI5ZBZF3lrt/PH7DpOrmBy8SUmxy4WSdvO9+9kiobgrXV1tz
	 tQCcYzC8rKK4R51vxyToNhsfOT/jp80c1fsSBVbhmorKH9DW6Yyc2dKJLAxYoSn2+y
	 9D0VZfkrdcleIjglnbOI6hx9NshSa7RQpsbKOP0sGUTgDIBjOefS9yVi0fALn54Y14
	 Cst3AeNQHTbRnQM47bwRLEQ93kLYBkSzB5sD302LkDVLPHgHRQGZVPQtqsbsLERtjZ
	 UV3x9C+WKLvvIFYYrT1qIfXO6EcyTj2CcvdlkCzMWN8UImFXt59okWn/Im7I7RUcx/
	 Pxa4l8u68V5Tw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ABD2E17E154C;
	Mon,  4 Aug 2025 16:33:20 +0200 (CEST)
Message-ID: <061374da-fa6e-4074-9451-1b3722217188@collabora.com>
Date: Mon, 4 Aug 2025 16:33:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/27] clk: mediatek: clk-mux: Add ops for mux gates
 with HW voter and FENC
To: Krzysztof Kozlowski <krzk@kernel.org>, Laura Nao
 <laura.nao@collabora.com>, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com, =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?=
 <nfraprado@collabora.com>
References: <20250730105653.64910-1-laura.nao@collabora.com>
 <20250730105653.64910-6-laura.nao@collabora.com>
 <29ad5f60-6148-4e9b-8498-83a30a520536@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <29ad5f60-6148-4e9b-8498-83a30a520536@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/08/25 16:05, Krzysztof Kozlowski ha scritto:
> On 30/07/2025 12:56, Laura Nao wrote:
>>   
>>   	clk_mux->regmap = regmap;
>> +	clk_mux->regmap_hwv = regmap_hwv;
>>   	clk_mux->data = mux;
>>   	clk_mux->lock = lock;
>>   	clk_mux->hw.init = &init;
>> @@ -268,6 +329,7 @@ int mtk_clk_register_muxes(struct device *dev,
>>   			   struct clk_hw_onecell_data *clk_data)
>>   {
>>   	struct regmap *regmap;
>> +	struct regmap *regmap_hwv;
>>   	struct clk_hw *hw;
>>   	int i;
>>   
>> @@ -277,6 +339,13 @@ int mtk_clk_register_muxes(struct device *dev,
>>   		return PTR_ERR(regmap);
>>   	}
>>   
>> +	regmap_hwv = mtk_clk_get_hwv_regmap(node);
>> +	if (IS_ERR(regmap_hwv)) {
> 
> This is either buggy or fragile. mtk_clk_get_hwv_regmap() returns NULL
> or valid pointer... or error? IS_ERR_OR_NULL is not the wait to go.
> 
> Choose one - IS_ERR or NULL, preferrably the first, since you must
> handle deferred probe.
> 

if regmap_hwv == NULL -> there is no HWV for *this* clock
if regmap_hwv == -ERROR -> there is a HWV for *this* clock, but something
                            went wrong, we have to return the error.

>> +		pr_err("Cannot find hardware voter regmap for %pOF: %pe\n",
>> +		       node, regmap_hwv);
>> +		return PTR_ERR(regmap_hwv);
>> +	}
>> +
>>   	for (i = 0; i < num; i++) {
>>   		const struct mtk_mux *mux = &muxes[i];
>>   
>> @@ -286,7 +355,7 @@ int mtk_clk_register_muxes(struct device *dev,
>>   			continue;
>>   		}
>>   
>> -		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
>> +		hw = mtk_clk_register_mux(dev, mux, regmap, regmap_hwv, lock);
> 
> So NULL is passed and stored... are you sure this is 100% backwards
> compatible?
> 

Yes, it is. This got tested on multiple legacy SoCs in our lab.

> 
> 
> Best regards,
> Krzysztof



