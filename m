Return-Path: <netdev+bounces-88974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381698A9250
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E151B1F229DD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8254BE2;
	Thu, 18 Apr 2024 05:16:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4648EDF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417376; cv=none; b=ZjOmqOZYjcbigFfi8NwinYyzAaYduzxqYN9lJAb7ogUmD0fswVXpkoINbBLOLRUc0rq7YsSMC6Htrf2ytQzg/hMdiI3Wqmewzf3otGFI7Lxt7zQfghqYqbje/htfY/k60WGFeiHeAbZXESoLDd3U47Vvw4UaxobmMWqG3kk6L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417376; c=relaxed/simple;
	bh=QXb4wfZdFyC0PlFFW6jUdWfeCTExzNuhS+4xIkJTWk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc5QFb2c2jbChx8Lg1zZn+LfWJ0c62/B9u23srpWp2dUIGF+kvuRe/s4g15Z/BokCmwGmavZ1+WYh4hLE0z9zjwfgbomOf/PcnlcGusH3+hS0bLxFeCCDhl4QdZnod8VxkwJN1WUCL1rxO+4Y8tmPtnG9MYYCeEqbgSXvq5m0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxF+iarCBmkR0pAA--.7597S3;
	Thu, 18 Apr 2024 13:16:10 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhOWrCBm47h+AA--.55874S3;
	Thu, 18 Apr 2024 13:16:07 +0800 (CST)
Message-ID: <60f200a1-457a-4d15-8885-5fe0ee7ae24b@loongson.cn>
Date: Thu, 18 Apr 2024 13:16:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/6] stmmac: Add Loongson platform support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <dkwz2xigkqnly6twu6akseerb3huxet56jultptjlaoapwgdt2@2va3q7isbhne>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <dkwz2xigkqnly6twu6akseerb3huxet56jultptjlaoapwgdt2@2va3q7isbhne>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhOWrCBm47h+AA--.55874S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFWfGF4xZryUCFyfArWftFc_yoWfurg_uw
	4YyF17G34kAa1vkF4IkF1ktF4vq3yIqw1jgry8Za17Jw1ayF4kXr4kW34xWw1rJ3y8AF95
	ur43tF4qyws7uosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU


在 2024/4/13 02:34, Serge Semin 写道:
>> Changes:
>>
>> * passed the CI
>>    <https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch
>>    /checkpatch.sh>
>> * reverse xmas tree order.
>> * Silence build warning.
>> * Re-split the patch.
>> * Add more detailed commit message.
>> * Add more code comment.
>> * Reduce modification of generic code.
>> * using the GNET-specific prefix.
>> * define a new macro for the GNET MAC.
>> * Use an easier way to overwrite mac.
>> * Removed some useless printk.
>>
> Thanks you very much for taking my notes into account and resubmitting
> the patchset. I'll get back to reviewing your series within 2-5 days.

Thanks for your patience. if you don't mind, how about reviewing them in 
v12?


I'm already working on v12, which is a minor version update, and I'm 
going to

rebase my patch and make some minor changes about splitting to silence

some warnings.


Thanks,

Yanteng




