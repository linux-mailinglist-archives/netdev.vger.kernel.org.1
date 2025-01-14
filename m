Return-Path: <netdev+bounces-157946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E849FA0FEB6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD5165E3F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38523026F;
	Tue, 14 Jan 2025 02:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD71C28E;
	Tue, 14 Jan 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821378; cv=none; b=txADFv0vdZaKWRU+7dSRMTi5tgwq5NvvhLs9j0TprUEGBgN4mnnVpwX0IzE6N+SBBhzAaINTU0p6bTAc1pdq6YJ7B33iypsxAV2hlvNmf1hwxlyX3jYwIaEHCHl6CO1q8AEXxG8hFED2Z8ufw5GKdC7DqVVjQG4UHgn9b8nquPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821378; c=relaxed/simple;
	bh=pYb34rK5k562Yj5BCnzi5OkVcgnaIbFhOsGpPdugyI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdU8ID1FDW5F3WfiiyN1qXK1qNTdZMHH+KywG4uFnyLpuHF7DWypkM82RtSiDdNMo04TK1JOXDPP8nYk0aa1ENqoSKv/uye+Tmk/6tWRkK6TCj+LuVR4jqyFLJrKKcX5yfITLyH9nGhEY2FrgTaFvDF8ojfEI9/IytMWlRP2o2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae8ae.dynamic.kabel-deutschland.de [95.90.232.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 55E1861E64780;
	Tue, 14 Jan 2025 03:22:03 +0100 (CET)
Message-ID: <d9fc5212-9710-449e-90b9-a195305d990f@molgen.mpg.de>
Date: Tue, 14 Jan 2025 03:21:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com, schung@nuvoton.com,
 peppe.cavallaro@st.com, yclu4@nuvoton.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
 <e7041d36-9bc7-482a-877d-6d8f549c0ada@lunn.ch>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e7041d36-9bc7-482a-877d-6d8f549c0ada@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,


Thank you for your quick reply.


Am 14.01.25 um 21:16 schrieb Andrew Lunn:
>>> +#define NVT_MISCR_RMII          BIT(0)
>>> +
>>> +/* 2000ps is mapped to 0x0 ~ 0xF */
>>
>> Excuse my ignorance: What is ps?
> 
> picoseconds. An RGMII link needs a 2ns delay between the clock line
> and the data lines. Some MACs allow you to tune the delay they can
> insert, in this case in steps of 2ns / 16.

Thank you for the clarification. Maybe it’s my English, but I didn’t 
deduce this from how the comment is worded. I do not have a better idea 
either.

>>> +#define NVT_PATH_DELAY_DEC      134
>>> +#define NVT_TX_DELAY_MASK       GENMASK(19, 16)
>>> +#define NVT_RX_DELAY_MASK       GENMASK(23, 20)
>>> +
>>> +struct nvt_priv_data {
>>> +	struct platform_device *pdev;
>>> +	struct regmap *regmap;
>>> +};
>>> +
>>> +static struct nvt_priv_data *
>>> +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct nvt_priv_data *bsp_priv;
>>> +	phy_interface_t phy_mode;
>>> +	u32 tx_delay, rx_delay;
>>
>> Please append the unit to the variable name.
> 
> Which is trick, because they are in units of 2000/16 of a picosecond.

Understood. Maybe a comment could be added?


Kind regards,

Paul

