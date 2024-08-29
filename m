Return-Path: <netdev+bounces-123040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B2963832
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655EEB23154
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698834CE5;
	Thu, 29 Aug 2024 02:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B041C71;
	Thu, 29 Aug 2024 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898581; cv=none; b=CvfCZGWdjQfMg37uehp8gWB047Skq1JtfXyoCS+Bf0j+b0qwpnu3N6EovFriQ2j4bR9LvkyEo/mh2rqhlwL845SAS9xeVHicLdy6BV1iWzzJJMJhJvF/A/cv9v8bsIK9t/iryNgqyAtc+qqBv7dExGqNgCQT5CMZqJjOnUo798Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898581; c=relaxed/simple;
	bh=hACEn4Z4Mb+ZnX5+j/CA2+UG9MzE+WMhS4j94taGCGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kUJSsSjEqEu2lqfq6yL6b51FKtvHqZwJPLfVbOapTPOTVBsST8tdi4laD5/sdDEnHgpK/XP2H94HcUIH5xs2gNhcAUYDe6mfXbX7WB5vhhBdItLHgBlaYBkAlc5Hqf/apI/72Gh5clymgoaWJ+7I65BhSlSrvFnpAa5YGbVEDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvQ8r6wKtz20n3V;
	Thu, 29 Aug 2024 10:24:44 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BD531400FD;
	Thu, 29 Aug 2024 10:29:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 10:29:33 +0800
Message-ID: <5fbe123d-99d1-1b48-4c84-fe8e1b0cf109@huawei.com>
Date: Thu, 29 Aug 2024 10:29:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 01/13] net: stmmac: dwmac-sun8i: Use
 for_each_child_of_node_scoped()
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <woojung.huh@microchip.com>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>,
	<justin.chen@broadcom.com>, <sebastian.hesselbarth@gmail.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<ansuelsmth@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-2-ruanjinjie@huawei.com>
 <52435305-d134-4cee-8660-f7bf60206ddf@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <52435305-d134-4cee-8660-f7bf60206ddf@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/28 22:17, Andrew Lunn wrote:
> On Wed, Aug 28, 2024 at 11:23:31AM +0800, Jinjie Ruan wrote:
>> Avoid need to manually handle of_node_put() by using
>> for_each_child_of_node_scoped(), which can simplfy code.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> index cc93f73a380e..8c5b4e0c0976 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> @@ -774,7 +774,7 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
>>  static int get_ephy_nodes(struct stmmac_priv *priv)
>>  {
>>  	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
>> -	struct device_node *mdio_mux, *iphynode;
>> +	struct device_node *mdio_mux;
>>  	struct device_node *mdio_internal;
>>  	int ret;
> 
> Networking uses reverse Christmas tree. Variables are sorted, longest
> first, shortest last. So you need to move mdio_mux after
> mdio_internal.

Right, it will look more clear.

> 
> The rest looks O.K.
> 
> 
>     Andrew
> 
> ---
> pw-bot: cr

