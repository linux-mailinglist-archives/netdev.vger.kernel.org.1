Return-Path: <netdev+bounces-112738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045A93AF07
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049321F22BE4
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590E152511;
	Wed, 24 Jul 2024 09:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347013BC26
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813106; cv=none; b=TEdy55t6PUTFvEAo2PFu27teMVzVQbgW8fJPRb5DsHoIvawTyMKGWZMK5BLth3ZLf391OQt4KWd7rCS3T5aQ7Kg/LrZD9F4iddSo1kWOgm281/HsvHhBaDpClROAmL/EZGbIR4boljcXulxbS81eZ3gL2K2xfgqiQcJ41KaefkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813106; c=relaxed/simple;
	bh=Xj/ULcZ4QSjzJD4y/akXTAyPFT3wq9UFjPObWYtBJzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCp3bfFxDqmQdV2X7nT6B3buXDtCUtVYLBMGF+mpAE0R4TTbuteZYuPnqya27Jbpb547viIyY02z4Gg9ACLiYQzr3++yof705uOMdwlEn8fG9xzVOETPQbdYOi/PtxCh88MPq2r9E6RxMUbgDJWrUQSiY5X9Gv0pQn1c081elO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.124])
	by gateway (Coremail) with SMTP id _____8Cxd+lryKBm++IAAA--.1946S3;
	Wed, 24 Jul 2024 17:24:59 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx08RmyKBm0BVXAA--.51401S3;
	Wed, 24 Jul 2024 17:24:55 +0800 (CST)
Message-ID: <928bd40f-3bbe-4038-be51-30e1b3bf40ec@loongson.cn>
Date: Wed, 24 Jul 2024 17:24:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v15 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, si.yanteng@linux.dev,
 Huacai Chen <chenhuacai@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
 <210517d4a8a2b63fd0aa9e57b1df91fcfe64fc2a.1721645682.git.siyanteng@loongson.cn>
 <20240722153049.GB15209@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240722153049.GB15209@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx08RmyKBm0BVXAA--.51401S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW5Kw17Cr4rCr1rGw45WFWfWFX_yoWxWwcE93
	W2yrn5WF15JrnYkw15Wr13Za9YqrWFgF1rCF9rKFWku3Z2qr4rArs8Cr1xtF13Gw18AF98
	Wr1xtr4fA34kXosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcRwZDUUUU


在 2024/7/22 23:30, Simon Horman 写道:
> ...
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>> +{
>> +	struct stmmac_priv *priv = apriv;
>> +	struct mac_device_info *mac;
>> +	struct stmmac_dma_ops *dma;
>> +	struct loongson_data *ld;
>> +	struct pci_dev *pdev;
>> +
>> +	ld = priv->plat->bsp_priv;
>> +	pdev = to_pci_dev(priv->device);
> nit: pdev is set but otherwise unused.
>
>       Flagged by allmodconfig W=1 builds

Thanks! I will drop it in v15.


Thanks,

Yanteng


