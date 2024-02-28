Return-Path: <netdev+bounces-75642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B3D86AC56
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E561C243A5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F67F47F;
	Wed, 28 Feb 2024 10:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CBF7E599
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117146; cv=none; b=AhkKkOMXVPwSc7tI5QU47SkepFlyCSB31cSlLdJAiMVfiFUGsqTvl7mVHk35qmqccZpEFWv7MmrILXTfaectk4E2ZC45T/wObvis0gxRr51+5UwigzYEx9cMwmKaKQJc58Jsw8n75bmAXOdB5m9bfNsUGX4zbw/PhPRm65g9rUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117146; c=relaxed/simple;
	bh=n8uBlupi2YR0Vu1WNe5FUAMPBYUuT/RYZk5MiGM7YPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvi0rUialKBBXBGQrSEKl6GTC2A6C+rtCRAQaodO0koWiuusCPEFzD8WKpfo58LYuFuBYatg1j6fe32Z1YFThj8MwfYNgoVCtx0uxvP5hb8E7c3WvE6t+zcEHEZfXNySAQYaFb8gQyPDH0nCIjuEU1WahO/0Q6bTPfqN/kzi2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.193])
	by gateway (Coremail) with SMTP id _____8DxaOjVDt9lfl8SAA--.27114S3;
	Wed, 28 Feb 2024 18:45:41 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.193])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OTUDt9li8JJAA--.65518S3;
	Wed, 28 Feb 2024 18:45:41 +0800 (CST)
Message-ID: <f0aca3d8-3581-44c3-9b64-348b1572807e@loongson.cn>
Date: Wed, 28 Feb 2024 18:45:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, horms@kernel.org, fancer.lancer@gmail.com,
 netdev@vger.kernel.org
References: <20240221103514.968815-1-siyanteng@loongson.cn>
 <20240222191220.0507a4de@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240222191220.0507a4de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx8OTUDt9li8JJAA--.65518S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF18Ww17WFWUtFWrur13Jrc_yoWkXrc_WF
	4a9Fn8Wan8CFWFywsxKFy5urZY9F1DWr18XF9Ygaya93y7Jws3Xryv9r95Xr1kur4fuFn8
	Crn3tFn7J342qosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=


在 2024/2/23 11:12, Jakub Kicinski 写道:
> On Wed, 21 Feb 2024 18:35:14 +0800 Yanteng Si wrote:
>> This is just a trivial fix for a typo in a comment, no functional
>> changes.
>>
>> Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
> Fixes is reserved for functional bugs, let's leave it out
> for a typo correction.

OK!

I will remove it.

Thanks,

Yanteng

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
>
>>   #define DMA_CHAN_BASE_ADDR		0x00001100
>>   #define DMA_CHAN_BASE_OFFSET		0x80
>>   


