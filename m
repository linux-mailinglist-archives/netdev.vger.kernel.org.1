Return-Path: <netdev+bounces-109455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D61928861
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949031F21EEE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9B14885E;
	Fri,  5 Jul 2024 12:06:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B390145B0F
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181204; cv=none; b=JH3qI85LpkM7SYkjsiXO4qnbfHTHVlCeUv+lvWZbEGJjWXDkmCxQGCZxP5BmkmazL5oUou8Kut/aV/kqn7aWMChATGdoQwjelzc1T9o21h6DevAnCVi6iMNHn2t8MydS2vsFlb/rSSGZ5yZxc/RCRvwcm2DKERjjI4xgzavzBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181204; c=relaxed/simple;
	bh=askavZaSASAsmwQnrbj8xu8KTgvG24k0Z5fCPWDC+yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVlFoUcSlATdMVmVz+VNBEGXyOgfKnXL90LXRg6lAxLnRpE63jJSWniXi8pxYZ7ARfqSXEJBSo0zzQMzcwzvrZAGoH/+vJ4RL68m3TiSZhkqGo/IrxndcMIcIhylaCk1p4AYgB2nCPo2bvKALo+h4a1UYfcX/rAmtx0bneTVDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8CxruvK4Ydm50oBAA--.3962S3;
	Fri, 05 Jul 2024 20:06:34 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqsbI4Ydm7Fo8AA--.8432S3;
	Fri, 05 Jul 2024 20:06:33 +0800 (CST)
Message-ID: <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>
Date: Fri, 5 Jul 2024 20:06:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8CxqsbI4Ydm7Fo8AA--.8432S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFWfWFyrWF1kWryUKrWDJrc_yoWftrX_Zr
	98u34kGa1xCa1kXw4a93s5XrZ8tFZxGF17Zr95tr47A3Z7ZF47Xan7CF4xZr9xt3y2yFnx
	ursakw1xZrWUZosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4cdbUUUUU

>>> But if you aren't comfortable with such naming we can change the
>>> macro to something like:
>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
>> is a little better?
>>
> Well, I don't have a strong opinion about that in this case.
> Personally I prefer to have the shortest and still readable version.
> It decreases the probability of the lines splitting in case of the
> long-line statements or highly indented code. From that perspective
> something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
> the driver currently don't have such cases, we can use any of those
> name. But it's better to be of such length so the code lines the name
> is utilized in wouldn't exceed +80 chars.

Okay.

I added an indent before 0xXX and left three Spaces before the comment,

which uses huacai's MULTICHAN and doesn't exceed 80 chars.


Thanks,

Yanteng


