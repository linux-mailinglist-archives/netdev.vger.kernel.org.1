Return-Path: <netdev+bounces-90557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3D8AE7BF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AD628CDA8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0EE1350FE;
	Tue, 23 Apr 2024 13:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9F1353E1
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878195; cv=none; b=Env0waNopvCOwjevXzrSqXnB3is/qDX5efSDujv3DKtK/qF5qJSgZWb8W4C5k35Ai5Uf2gKmPlE4At7nrZVLssb8t7/gLSeYKK5IaPMGmQEoXBJrwGfPAWJws3pqQ4XZCe2Sr4IPoPsxb6fGbiwm6ds6prOLZx49vTxWvIgg5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878195; c=relaxed/simple;
	bh=6ceTl5apsBHxZGd9gwFeoCFLDzw4NAy6noJzhqNCAKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4nyw6PHA9cOU82aDrQlBRRJSjLNOxZUgjBm0nHD55efc9en0H/TT10IEKQEIchZcnIuMChnu+OOzf2rsGxnQH/6aGKCro2jhXYP3cfKgkQZBNIefntEOrw3Y1ZHtR7a9qnUfLvzJoEWHQshPllHz8Lpsid6g3XrTlN3Bqq5t/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxJvCttCdmSWUBAA--.7996S3;
	Tue, 23 Apr 2024 21:16:29 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrdyptCdmvmACAA--.9834S3;
	Tue, 23 Apr 2024 21:16:28 +0800 (CST)
Message-ID: <3bd0c0d3-324b-4e74-ac8a-0bf6f66ee33e@loongson.cn>
Date: Tue, 23 Apr 2024 21:16:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
 <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxrdyptCdmvmACAA--.9834S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF43tw1xCryfKFWDKrWfWFX_yoW3Wrb_Xa
	y7G3W8XryUtwnY9w4qkFyfAa4DXFyDtFnxtFW2qanrCrn3Xr13Ars0grZ2ga18uw1xGF1U
	uw1fCw1avrn7AosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0DGYPUUUUU==

Hi Serge,

在 2024/4/18 22:01, Serge Semin 写道:
> Once again. Please replace this with simpler solution:
>
> static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
> +					   struct plat_stmmacenet_data *plat,
> +					   struct stmmac_resources *res)
> +{
> +	int i, ret, vecs;
> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;

Referring to the msi spec, the number of vectors should be the power of 
two, so let's:


vecs = roundup_pow_of_two(plat->rx_queues_to_use + 
plat->tx_queues_to_use + 1);

or

vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);


? :)


Thanks,

Yanteng



