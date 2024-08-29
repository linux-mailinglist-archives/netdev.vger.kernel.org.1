Return-Path: <netdev+bounces-123045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD896387B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71391C22598
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9D3FE4A;
	Thu, 29 Aug 2024 02:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A850284;
	Thu, 29 Aug 2024 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899941; cv=none; b=rFcbo9jEhbpclu8A6PX3cN1NKVDpejm5Fy3g+y3j7k0EjANFyqi8uIyH0IY1ZopEwpVod3DJImGuQT94ePRDs+9KTIEw+0aynSUF9Og56HW9K+2RO4FFO+cQMp0a7rI6qsZcc05tLUhECQElM3IvW2mP+yCVk0jEzEv3ByUJXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899941; c=relaxed/simple;
	bh=otMLFNxZa8v8dsmNz+y9FeauflsX+DV6VvMzYSJEvsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ANORawol0srCO/NbumBcBzTZwL420+YaptHdw1FtWczpLwLZGx10CLIBvYAxkPgpONtryK3vvlPk9Tp8TLqjBh3p8AS7rTBs1uMrGP9yVWodKoVNpvxB6S6xHxTTM5LoVPIc4ppn9m9Qq/aMDOgH7aui0udiivMpBtSbpTrhSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvQmN19Vtz1S8w4;
	Thu, 29 Aug 2024 10:52:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E29DE140203;
	Thu, 29 Aug 2024 10:52:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 10:52:15 +0800
Message-ID: <7a1e386c-8750-1cad-de11-57deea22864f@huawei.com>
Date: Thu, 29 Aug 2024 10:52:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 05/13] net: phy: Fix missing of_node_put() for
 leds
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-6-ruanjinjie@huawei.com>
 <66cf4618f313_34a7b1294bb@willemb.c.googlers.com.notmuch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <66cf4618f313_34a7b1294bb@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/28 23:45, Willem de Bruijn wrote:
> Jinjie Ruan wrote:
>> The call of of_get_child_by_name() will cause refcount incremented
>> for leds, if it succeeds, it should call of_node_put() to decrease
>> it, fix it.
>>
>> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Fixes should go to net. Should not be part of this series?

However, they have context dependency. If one is merged, the other needs
to be rebased.


