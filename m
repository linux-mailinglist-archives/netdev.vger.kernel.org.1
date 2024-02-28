Return-Path: <netdev+bounces-75653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C586ACD3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3331F26661
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28112C520;
	Wed, 28 Feb 2024 11:19:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6C12A149
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119186; cv=none; b=r84VLEa32pyEw6M/780/HFEu/i/EqeRI6b/uNyKB1jPQZz/xkGa0Wa20k6M56KOowiyQ0O36ro4vReZXPhk1oYAali3dQWJ2ZAjJH0vgzGxoue3IG16xHC9aAFnv+cWW7eEnx/dRSesS+BUMq6h+0vC5bZYhCzlsABByWj0Efa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119186; c=relaxed/simple;
	bh=n1RBUUfBvEjS5koRMWsUb5DXDsYInlV1w6yBnz1QjSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ5DcA4nPCW0MAYlV69FxnnEbshV+XGclfNAPXxbgB3SKASdoHRs/Chdok+niLlE9PmymleP9n0poEaeYvgoCqxKHgWrSDjcX6s1SM0rwwHEFDXrVBghvmjlfrj9MeCkQdNNHuyQ3OGxvBi4fpP9XYLfZxZ8df3YaoxIxsD41Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.193])
	by gateway (Coremail) with SMTP id _____8AxjuvOFt9lKmESAA--.46275S3;
	Wed, 28 Feb 2024 19:19:42 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.193])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjhPMFt9lVMtJAA--.9450S3;
	Wed, 28 Feb 2024 19:19:41 +0800 (CST)
Message-ID: <c68c505c-0f70-4d6a-80b6-c6e9d4ae01ac@loongson.cn>
Date: Wed, 28 Feb 2024 19:19:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, horms@kernel.org, fancer.lancer@gmail.com,
 netdev@vger.kernel.org
References: <20240221103514.968815-1-siyanteng@loongson.cn>
 <20240222191220.0507a4de@kernel.org>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240222191220.0507a4de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjhPMFt9lVMtJAA--.9450S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF18Ww17WFWUtFWrur13Jrc_yoWkJFXEgF
	4a9FnxWw45CF4FywsxKFy5urZY9F1DWr18Xrn5Kaya93y7Jws3Xryv9rykXr1kWr4fZFn8
	Crn3tFn7J347tosvyTuYvTs0mTUanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsyxRDUUUU


在 2024/2/23 11:12, Jakub Kicinski 写道:
> On Wed, 21 Feb 2024 18:35:14 +0800 Yanteng Si wrote:
>> This is just a trivial fix for a typo in a comment, no functional
>> changes.
>>
>> Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
> Fixes is reserved for functional bugs, let's leave it out
> for a typo correction.
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> index 358e7dcb6a9a..9d640ba5c323 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> @@ -92,7 +92,7 @@
>>   #define DMA_TBS_FTOV			BIT(0)
>>   #define DMA_TBS_DEF_FTOS		(DMA_TBS_FTOS | DMA_TBS_FTOV)
>>   
>> -/* Following DMA defines are chanels oriented */
>> +/* Following DMA defines are channels oriented */
> I'm not a native speaker but I'd spell it "... are channel-oriented"
> With a hyphen, channel not channels.

OK.


Thanks,

Yanteng

>>   #define DMA_CHAN_BASE_ADDR		0x00001100
>>   #define DMA_CHAN_BASE_OFFSET		0x80
>>   


