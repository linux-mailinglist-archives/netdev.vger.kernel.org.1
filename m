Return-Path: <netdev+bounces-95951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABE8C3E58
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB04C28309F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068DC147C91;
	Mon, 13 May 2024 09:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABF219E7
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593679; cv=none; b=SlIpiW0rWAh9/UXA8c6QkEEyL4u+wDkrjvEmU4bXrp/sC4W/gfSfEozc+s2OoYcZAxEJsIa/iIdh7Rmq5+NIvNMchophK35Ihq5GUyY1hWPE9kO9NAnAS1ya1kEK92V4vtErk8XuSdegQI/MDdnoVjVo4K4r5zkVpNDFcQfDdno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593679; c=relaxed/simple;
	bh=ZyfRWPSjR4U6Lsfd1UdQ0Bgsy33e4N3tzjGgRiNffTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdnhQeg0L6x60x6vA5oXONupMH7tO6cLE8TLJ4KB8kjeK1W+TuC7iVfriwbZIopGIVuODNyo/DPy+m6CScJaqR1AsQ4uO+RcKWU+SjJHCApw8Lp1/P4LSWyhnOVS76xQJwG4MnCLN2LHLgzuVJjSJv/2c2DW8ExAchbjKVQgsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8DxPOvL4UFm1CAMAA--.23124S3;
	Mon, 13 May 2024 17:47:55 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxP1XJ4UFmwMocAA--.34784S3;
	Mon, 13 May 2024 17:47:54 +0800 (CST)
Message-ID: <87557791-ca0e-48e6-a47f-1247fbba4c85@loongson.cn>
Date: Mon, 13 May 2024 17:47:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop
 useless platform data
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <37949d69a2b35018dd418f5ee138abf217a82550.1714046812.git.siyanteng@loongson.cn>
 <wpr6eabfksol2sqmvifnivndnixberpoexcoskq5vbknvvadq3@4thpqbkkcyh5>
 <d6swg4bxrzvs7cpn3hd6xfji2cr6vnb7z7fvd4dkuyrufm4el7@qj3minrgctyt>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <d6swg4bxrzvs7cpn3hd6xfji2cr6vnb7z7fvd4dkuyrufm4el7@qj3minrgctyt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxP1XJ4UFmwMocAA--.34784S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyrAryrCr1fCw1ktFyDCFX_yoW8Xw1kpr
	93C3Z8JF1DJrWjy3s5Aw1DZF93Zr97tr1DCr95Gr97AayqgF1rZr47GrWYyrZFyr4DCF1S
	vF4Iqa4DZa98ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/5/3 22:47, Serge Semin 写道:
> On Fri, May 03, 2024 at 01:55:38PM +0300, Serge Semin wrote:
>> On Thu, Apr 25, 2024 at 09:04:35PM +0800, Yanteng Si wrote:
>>> The multicast_filter_bins is initialized twice, it should
>>> be 256, let's drop the first useless assignment.
>> Please drop the second plat_stmmacenet_data::multicast_filter_bins
>> init statement and just change the first one to initializing the
>> correct value - 256. Thus you'll have
>> 1. the multicast and unicast filters size inits done in the same place;
>> 2. the in-situ comments preserved (it's not like they're that much
>> helpful, but seeing the rest of the lines have a comment above it
>> would be nice to have the comment preserved here too);
>> 3. dropped the statement closely attached to the return statement
>> (in kernel it's a widespread practice to separate the return
>> statement with an empty line).
>>
>> The unit 1. is the main reason of course.
>>
>> A bit more readable commit log would be:
>>
>> "The plat_stmmacenet_data::multicast_filter_bins  field is twice
>> initialized in the loongson_default_data() method. Drop the redundant
>> initialization, but for the readability sake keep the filters init
>> statements defined in the same place of the method."
> [PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop useless platform data
>
> The patch subject is too generic. Just make it:
>
> [PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init

OK, Thanks!


Thanks,

Yanteng


