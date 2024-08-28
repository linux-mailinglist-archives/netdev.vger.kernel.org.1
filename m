Return-Path: <netdev+bounces-122563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77740961BA6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1F61C23090
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B63FBA7;
	Wed, 28 Aug 2024 01:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BA381C2;
	Wed, 28 Aug 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810350; cv=none; b=CNtYgA4soOom4YfRsviAoKpUgjkHbD1npTWGWmz368xwJhr4ckWRNnRM2LN36vRVJrzdPibJkzGN5TkHOSdPWB7QafjkXMRA6ZSWiFlfwfK+22gbKHp445JNhJ+YJ1xdUFXNOIgT3DWEBSxdcusQtGA9qD1I6/X5e71pZnppeWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810350; c=relaxed/simple;
	bh=QyRuj8Nm/mbXT0Sw4sPv6wypvA1tLwBqlNFwNq32mFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pm3Q5ee0LyQyC6+AvW/m1tf2TPWL5fYS2hiEhCu0jS3JnIHHBB/4eBQdsdeeM7Uk6GiB1S3GxA1Vj65I56kClKfIcRPRfIDlkFSaHQfklCxc4sPoKi5Y158MqMfqYWtImPEPSzhuDxDerRhEL1w1ddI0Qm2oFOuCRNEyZoVQRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtnYt3qjFz1HHbh;
	Wed, 28 Aug 2024 09:55:46 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id DA27F1A016C;
	Wed, 28 Aug 2024 09:59:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 09:59:04 +0800
Message-ID: <d17ad357-773f-84de-e408-25d5d3b372ef@huawei.com>
Date: Wed, 28 Aug 2024 09:59:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 0/7] net: Simplified with scoped function
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
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
 <a5e18595-ede9-4a02-8aa5-a270d7d7a5d6@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <a5e18595-ede9-4a02-8aa5-a270d7d7a5d6@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/27 20:44, Andrew Lunn wrote:
> On Tue, Aug 27, 2024 at 03:52:12PM +0800, Jinjie Ruan wrote:
>> Simplify with scoped for each OF child loop and __free().
> 
> The Subject: should be [PATCH net-next], not -next. The CI looks at
> this to decide which tree it belongs to. It issues a warning because
> what you used does not match anything.

Thank you! I'll fix it.

> 
> 	Andrew

