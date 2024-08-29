Return-Path: <netdev+bounces-123050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D79638C5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331AB1C21AC0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39423A1DA;
	Thu, 29 Aug 2024 03:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D932DDA6;
	Thu, 29 Aug 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902026; cv=none; b=u0BCOFGRm7yFuGL+BdNIWC2bfSvZna8bCDvLNLQnpUSipSX4d3tOj73RJiPCufG9Rb7Gwf4bwMfIa0/GvhyUKrfNPiodJobl/YXHozDejjZiVmT6/NjGiIWo3NeXQqILlBh1MrDswFfW2MQZtrFL+629lLF7L9DdbApgGb6pX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902026; c=relaxed/simple;
	bh=ZpZR9epJcdcp1YBej++duiEWeU1hJTKjIBNMmpppcvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PwZWfuCa3mIGxpRfmmokhAAuTEB09CEeijefEHDzoJl4JCrB+lGI/ffJqEwkR4f+48rG6c8Cw9dtrs9dZ7hZStb8IaDU/L3G+Fv0BlZeBFwR/qE/Q47t2odNcA9mgpRVjh2reh42fbhhly8qaLmr2x6FMVCypLlkxl4mhCYI6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WvRWm3J4Bz18MpC;
	Thu, 29 Aug 2024 11:26:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 85A8C1401F2;
	Thu, 29 Aug 2024 11:27:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 11:27:00 +0800
Message-ID: <b5b7346d-83ea-846a-1187-3d39ee5177f3@huawei.com>
Date: Thu, 29 Aug 2024 11:26:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 00/13] net: Simplified with scoped function
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
 <6092e318-ae0c-44f6-89fa-989a384921b7@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <6092e318-ae0c-44f6-89fa-989a384921b7@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/28 22:32, Andrew Lunn wrote:
> On Wed, Aug 28, 2024 at 11:23:30AM +0800, Jinjie Ruan wrote:
>> Simplify with scoped for each OF child loop and __free(), as well as
>> dev_err_probe().
>>
>> Changes in v2:
>> - Subject prefix: next -> net-next.
>> - Split __free() from scoped for each OF child loop clean.
>> - Fix use of_node_put() instead of __free() for the 5th patch.
> 
> I personally think all these __free() are ugly and magical. Can it
> somehow be made part of of_get_child_by_name()? Add an
> of_get_child_by_name_func_ref() which holds a reference to the node
> for the scope of the function?

Yes, that is a good idea, and the __free() doesn't look as readable as
or_each_*child_of_node_scoped().

> 
> for_each_available_child_of_node_scoped() is fine. Once you have fixed
> all the reverse christmas tree, please submit them. But i would like
> to see alternatives to __free(), once which are less ugly.

Thank you!

> 
> 	Andrew
> 
> ---
> pw-bot: cr
> 

