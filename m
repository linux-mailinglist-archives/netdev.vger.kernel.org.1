Return-Path: <netdev+bounces-116350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA294A188
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDBE1F21550
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F81C3F3C;
	Wed,  7 Aug 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ei3dL8UY"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECA18D63E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015139; cv=none; b=e2ueefDXgRkO5/HUQRS8U5HCpvfeUa4RJgodCcTwasfdwEzD+wpMLFBIM9nYC0RGDXODNNKDUq42kPmDVqqzCP7RQNm5TePpH6Use7F3NlPVHmU7GZY6C2oSwg4DDTrnm3KDNeU0sWCTKAcwI7B820S/LpLAGq2NEGuGaxuod6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015139; c=relaxed/simple;
	bh=2QIHR2kJAVhkBeY7dHCHU70xMpYIs4IqgjrdyMSN9bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5apVGy9LtRz9MQPbNU/9DJgk1OIxB5msA1HHOK5kACmE9S8WFFlC4qGg6LhiuCdj+Jn4IvUMtCl4aBQwX+SSNy9fVdI/2/FT0diJkF90bQU6LZTlwvH2OwZBhyvpktplUATMJ8p2C9przKjHfY2xkGZSQ6uHlVIkESiY7lXph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ei3dL8UY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c395c10-e3df-4880-9a22-371993a0806a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723015134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag8nate+OX/vp8V0wuJT7TBTXGOfj6F04L3aoBC00rM=;
	b=ei3dL8UYIVit0CaEWkRU73VY2EVt1eUn4CHfxBYlsX1GLCoZhIvJVa+RVMqIAvwCtajnj0
	j9AIdbzxxoeYteiBx8YynFs1B9XgVkG0OIvVRqdofJqz/r6IVoYon5QTLZ6GSJlC3Q7K6d
	aUoZkRmwt/0nFLYVr4DPGU4XvHAGHzM=
Date: Wed, 7 Aug 2024 15:18:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v16 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
To: Simon Horman <horms@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, Huacai Chen <chenhuacai@loongson.cn>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>
 <20240806151712.GX2636630@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <20240806151712.GX2636630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/6 23:17, Simon Horman 写道:
> On Tue, Aug 06, 2024 at 07:00:22PM +0800, Yanteng Si wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> ...
>
>> @@ -214,12 +532,15 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>>   {
>>   	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>>   	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	struct loongson_data *ld;
> minor nit: ld is not used in this patch or patchset; it can be removed

Thanks! I have let ld->loongson_id come back.


Thanks,

Yanteng

>
> ...

