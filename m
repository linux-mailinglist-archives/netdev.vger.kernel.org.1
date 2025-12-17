Return-Path: <netdev+bounces-245139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD08CC7B57
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4068F303C9C4
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8B2737E7;
	Wed, 17 Dec 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HuygHyOC"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3601A9FAC;
	Wed, 17 Dec 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976111; cv=none; b=gmzjsfl10eePbqLs5vEuQ2aJeE6FQ5378z7txqNKndV1u2S0SeAApo0Zo1kMpks0SaSBgpOZcxdixoKzQMJwGvxpVlupmEyLFFXB0384tQGfvEQ/WIOAXQVGf+Y/FaPi5LjaP7ON41nZlea6YTAGkM0+OrR8B0m0lvYZq9i5BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976111; c=relaxed/simple;
	bh=9OYJu7NQ6Jyui/nscSQIbad7plIfuJIL8N+ZEqAkeEs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GocS+s2d9APcnJ+GYMA3WUwwe3wv0oYSc8teX4BFWo+GpZN4OyC2yTi2Khuj4YIwtzBh3b5YqQXswPdIuQh2ec5bM5WaUgp/HyHQtjtgLBAHMck126yiX2ZjNxfpQg66NW28IICkpB1axZarq4DPE/N7IBs5vWMg3tgC5HzJJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HuygHyOC; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vGKscwXMKJ29Xox2XUVNkSMhP5dbp3pjHaG4+qsnogI=;
	b=HuygHyOC493r6mlc8PJXTT4eWnSwS6BOA5dIbWyGiGZB1M01Xx7wsW9VI4Eewb8Boeq8xi69Y
	GhSdNonlWK141CZlFzkESJxo3R4vWGEwYcHVmRVtalOFZSDLyiIQkEu9bwVQC24LNM3AxkKXwaj
	D3wzIszoaWMPduRPRKRfzBo=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dWYcH3xV2z12LDy;
	Wed, 17 Dec 2025 20:52:47 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EFCB18048C;
	Wed, 17 Dec 2025 20:55:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 20:55:00 +0800
Message-ID: <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
Date: Wed, 17 Dec 2025 20:54:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/16 15:09, Andrew Lunn wrote:
> On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
>> The node of led need add new property: rules,
>> and rules can be set as:
>> BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)
> Please could you expand this description. It is not clear to my why it
> is needed. OF systems have not needed it so far. What is special about
> your hardware?

I hope to configure the default rules.
Currently, the LED does not configure rules during initialization; it uses the default rules in the PHY registers.
I would like to change the default rules during initialization.


Some of our boards have only one LED, and we want to indicate both link and active(TX and RX) status simultaneously.

Thanks,
Jijie Shao

>
> Also, it looks like you are expanding the DT binding, so you need to
> update the binding .yaml file.
>
> 	Andrew

