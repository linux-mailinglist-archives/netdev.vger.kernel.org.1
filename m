Return-Path: <netdev+bounces-200267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3896CAE408E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168AE3A6864
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAE24DCF8;
	Mon, 23 Jun 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GwEn1t03"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB3248883;
	Mon, 23 Jun 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682009; cv=none; b=ADnlm1X9TEuyeq58wmZJoeogNADez/RoCA/ahzrmlBVi5FalcomRCrC3PfM9boZkqGA9cwstN3Z65bJ2vRR2shxYO5m3XJeE+qLLKjtC1wx2oI6zEdD5ULd9Tk6gWuMknz3wlR0YIRLo3WE3ClcCIHy5r2eUKitdx8CuEG8v92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682009; c=relaxed/simple;
	bh=WaDo2VjuGWUJif4F4F5rmWUyOyYzy9Md9CqJKUmOAlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsBGnr3MrGFK3MMDQNbxOIFvOSe2Q9quRxsHe8YEV4pHUkCAOJU6p1r2Bq1ekW3xZCLUFMTzC/qvCncpvzN6eSTgOg+PrmliRwi3z0lmnWICJLuuwC0LdojSSyFO10PB5KAkV4jr9i9eWMixO0JlltK6+BNXpPvCW+a+4SY0yDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GwEn1t03; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750682006;
	bh=WaDo2VjuGWUJif4F4F5rmWUyOyYzy9Md9CqJKUmOAlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwEn1t03W2xslPqY+JSc+nqh27zLnSDo5JzMbiCjMzDii8k2dCfUQrAP6TDHGpyOk
	 Zoh0XCIedaFFESIy41gEpfo3PQqeWmso6TBDQ+z6W6vPRcqfVT2jDM2i+ROgKtacQA
	 xHz7birge5qTDmPcL8vP7qdOqdaoRA545TV5SGbT7oM/0x58XKTg7KIQkI0z716ek0
	 KKulX8gimq7y7ip/G4+pvMr2Thu1JOvcNmwk4NDX81Px+nxNfzuvJONm1ACL1MMLJX
	 fjPBR3IELUuxu5cGVVndGaBdELp9LA1ZaQ54VSPrtYYDhqKligrrLhQjGwmMc+JKjC
	 yZEniMLIx/h4w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2EFE117E090E;
	Mon, 23 Jun 2025 14:33:25 +0200 (CEST)
Message-ID: <b7b78f8c-b70f-424c-90b8-eeb0eda50041@collabora.com>
Date: Mon, 23 Jun 2025 14:33:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/30] clk: mediatek: mt8196: Add UFS and PEXTP0/1 reset
 controllers
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
 <20250623102940.214269-31-laura.nao@collabora.com>
 <d1802074-5472-475c-94b6-a0667e353208@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d1802074-5472-475c-94b6-a0667e353208@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/06/25 14:14, Krzysztof Kozlowski ha scritto:
> On 23/06/2025 12:29, Laura Nao wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Add definitions to register the reset controllers found in the
>> UFS and PEXTP clock controllers.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt8196-pextp.c  | 36 ++++++++++++++++++++++++
>>   drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 25 ++++++++++++++++
>>   2 files changed, 61 insertions(+)
> 
> You just added these files. Don't add incomplete driver just to fix it
> later. Add complete driver.
> 
> Patch should be squashed.

Laura, feel free to squash the patches.

Cheers,
Angelo

> 
> Best regards,
> Krzysztof


