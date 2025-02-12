Return-Path: <netdev+bounces-165416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51DA31EEE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829ED3A97CC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115A1FF1B7;
	Wed, 12 Feb 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2u+pa9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468101FBEA6;
	Wed, 12 Feb 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341632; cv=none; b=QTtPhzF5Ah9qHeJY0hiITBTwbrBwUPdjj1vYngIZ2yjJQFOTSY6MWFSrBj0sArQWjLvR0axq9Daxq7WuoF5BhC+GIAx66s3OUvIQUu/j1gNTcbET6JHp9idVx6G2miyrFhNclONAmysl2f0byJcctqvaoajHA0K7VUU2ZkCkfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341632; c=relaxed/simple;
	bh=1/zhjK+0+G05v1hwwn5tz/H+8Cz4vmPRU7clBN3k0ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNSptziFxPq6H6XF5WtnqlOK1qoa0x/TqTPDJeBZS5LAPESU8GpVl1ie+NwPNwgIXEAiDFMLZqVwH+h2xNdhHtRxQkkPuwLEnzOZv0JXxIavCSuVsTFBRzk9uSt7Dyxl+5ZfAaRirLg5XdK4jfidDAxDCtouKgqjUwlS+AmcCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2u+pa9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F6C4CEE6;
	Wed, 12 Feb 2025 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739341631;
	bh=1/zhjK+0+G05v1hwwn5tz/H+8Cz4vmPRU7clBN3k0ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j2u+pa9v36ZbhRZph5rV/yE+zheeNljbSA2hCK+QxpqUUozTROOu+Bp9e9rPsiCn4
	 sr/F2tK6INMhPIZHrkjHpv/yxCHNwYrsM+87zlpR119ozsWj1qVRrCYlXouW0KM8W4
	 CQR6VyZyoMu8gqW16WkpKAebx/0UiE8DIPWFsHGgqX9w/f6KStjHuQaWA3TaVQnBm3
	 NV/kFzuXc1SiT0U9sZz0+JGhp0Bo+Ds8/saVBFz20xn9tx3GXscJj15FDGXCD0aJL4
	 BG11EpfhoMYdyx7SIPli3YJUVgVKGqVRDm1/mm/Yv3o+k4aL5Sc1l+OQaJwLQhtaEW
	 3qW5TzMlSD/lA==
Message-ID: <66b554f0-e11c-4801-9a5e-2ccb85a105fe@kernel.org>
Date: Wed, 12 Feb 2025 07:27:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/16] net: airoha: Introduce PPE
 initialization via NPU
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-13-dba60e755563@kernel.org>
 <20250211-fanatic-smoky-wren-f0dcc9@krzk-bin> <Z6t7SuFurbGwJjt_@lore-desk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z6t7SuFurbGwJjt_@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 17:31, Lorenzo Bianconi wrote:
>> On Sun, Feb 09, 2025 at 01:09:06PM +0100, Lorenzo Bianconi wrote:
>>> +static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
>>> +{
>>> +	struct airoha_npu_core *core = core_instance;
>>> +	struct airoha_npu *npu = core->npu;
>>> +	int c = core - &npu->cores[0];
>>> +	u32 val;
>>> +
>>> +	airoha_npu_rmw(npu, REG_WDT_TIMER_CTRL(c), 0, WDT_INTR_MASK);
>>> +	val = airoha_npu_rr(npu, REG_WDT_TIMER_CTRL(c));
>>> +	if (FIELD_GET(WDT_EN_MASK, val))
>>> +		schedule_work(&core->wdt_work);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +struct airoha_npu *airoha_npu_init(struct airoha_eth *eth)
>>> +{
>>> +	struct reserved_mem *rmem;
>>> +	int i, irq, err = -ENODEV;
>>> +	struct airoha_npu *npu;
>>> +	struct device_node *np;
>>> +
>>> +	npu = devm_kzalloc(eth->dev, sizeof(*npu), GFP_KERNEL);
>>> +	if (!npu)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	npu->np = of_parse_phandle(eth->dev->of_node, "airoha,npu", 0);
>>> +	if (!npu->np)
>>> +		return ERR_PTR(-ENODEV);
>>
>> Why? The property is not required, so how can missing property fail the
>> probe?
> 
> similar to mtk_wed device, airoha_npu is not modeled as a standalone driver,
> but it is part of the airoha_eth driver. If you think it is better, I can
> rework it implementing a dedicated driver for it. What do you think?


Whether it is separate or not, does not matter. Behavior in both cases
would be the same so does not answer my question. But below does however:

> 
>>
>> This is also still unnecessary ABI break without explanation/reasoning.
> 
> At the moment if airoha_npu_init() fails (e.g. if the npu node is not present),
> it will not cause any failure in airoha_hw_init() (so in the core ethernet
> driver probing).


Indeed, it will fail airoha_ppe_init() but airoha_ppe_init() is not
fatal. You will have dmesg errors though, so this should be probably
dev_warn.

> 
>>
>>> +
>>> +	npu->pdev = of_find_device_by_node(npu->np);
>>> +	if (!npu->pdev)
>>> +		goto error_of_node_put;
>>
>> You should also add device link and probably try_module_get. See
>> qcom,ice (patch for missing try_module_get is on the lists).
> 
> thx for the pointer, I will take a look to it.
> 
>>
>>> +
>>> +	get_device(&npu->pdev->dev);
>>
>> Why? of_find_device_by_node() does it.
> 
> ack, I will fix it.
> 
>>
>>> +
>>> +	npu->base = devm_platform_ioremap_resource(npu->pdev, 0);
>>> +	if (IS_ERR(npu->base))
>>> +		goto error_put_dev;
>>> +
>>> +	np = of_parse_phandle(npu->np, "memory-region", 0);
>>> +	if (!np)
>>> +		goto error_put_dev;
>>> +
>>> +	rmem = of_reserved_mem_lookup(np);
>>> +	of_node_put(np);
>>> +
>>> +	if (!rmem)
>>> +		goto error_put_dev;
>>> +
>>> +	irq = platform_get_irq(npu->pdev, 0);
>>> +	if (irq < 0) {
>>> +		err = irq;
>>> +		goto error_put_dev;
>>> +	}
>>> +
>>> +	err = devm_request_irq(&npu->pdev->dev, irq, airoha_npu_mbox_handler,
>>> +			       IRQF_SHARED, "airoha-npu-mbox", npu);
>>> +	if (err)
>>> +		goto error_put_dev;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
>>> +		struct airoha_npu_core *core = &npu->cores[i];
>>> +
>>> +		spin_lock_init(&core->lock);
>>> +		core->npu = npu;
>>> +
>>> +		irq = platform_get_irq(npu->pdev, i + 1);
>>> +		if (irq < 0) {
>>> +			err = irq;
>>> +			goto error_put_dev;
>>> +		}
>>
>> This is all confusing. Why are you requesting IRQs for other - the npu -
>> device? That device driver is responsible for its interrupts, not you
>> here. This breaks encapsulation. And what do you do if the other device
>> starts handling interrupts on its own? This is really unexpected to see
>> here.
> 
> As pointed out above, there is no other driver for airoha_npu at the moment,
> but I am fine to implement it.

I see. The second driver is there - syscon - just provided by MFD core.
It also looks like the NPU is some sort of mailbox, so maybe NPU should
not have been syscon in the first place, but mailbox?



Best regards,
Krzysztof

