Return-Path: <netdev+bounces-138934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288289AF792
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1031C21884
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432118A6AA;
	Fri, 25 Oct 2024 02:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64922B64B
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824104; cv=none; b=g2ly5rVQMi4fL6pZlRmL6f6nTRpGEZIiArOgqmmShyUh7LMcFCAWN+zKOOqE4Nwe66z7YeVxGm3erLVJB1TL09K1hLxSD17jfJx+XvoSRc4fqcaXUXQs+86K//0STs/fbZKkhbATbteo5PXrjh8JsjArfK8gNC4EX6ie6QHojWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824104; c=relaxed/simple;
	bh=YLrBgO/XgzYXB+D2+FCvBdd2B8LIU7GK68REM7lPx1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TV2SXCkfW/TVPP7V6/sFBt5fOBWQdtexxg4Ro/QtTfNyu54l66D+ODG+v7AQ5cPcAD7QcTtKAEkynV9SWXoEGpxqd002dNizzOOjzixQqH8Yqbirc9YEjtmEI9wb9N/GpumPPnsBeRAzID5HU+ArHaoHkTZktsgAo/rLRVqdA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZRr95vC0z1ynGG;
	Fri, 25 Oct 2024 10:41:45 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3707C180044;
	Fri, 25 Oct 2024 10:41:38 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 10:41:37 +0800
Message-ID: <9ed41df0-7d35-4f64-87d7-e0717d9c172b@huawei.com>
Date: Fri, 25 Oct 2024 10:41:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before
 of_find_node_by_name()
To: Andrew Lunn <andrew@lunn.ch>
CC: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<kory.maincent@bootlin.com>, <horms@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<chenjun102@huawei.com>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-2-zhangzekun11@huawei.com>
 <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/10/24 19:56, Andrew Lunn 写道:
> On Thu, Oct 24, 2024 at 09:59:08AM +0800, Zhang Zekun wrote:
>> of_find_node_by_name() will decrease the refcount of the device_node.
>> So, get the device_node before passing to it.
> 
> This seems like an odd design. Why does it decrement the reference
> count?
> 
> Rather than adding missing of_node_get() everywhere, should we be
> thinking about the design and fixing it to be more logical?
> 
> 	Andrew

Hi, Andrew,

of_find* API is used as a iterater of the for loop defined in 
"include/linux/of.h", which is already wildly used. I think is 
reasonable to put the previous node when implement a loop, besides, the 
functionality has been documented before the definiton of of_find* APIs.
The logical change of these series of APIs would require a large number 
of conversions in the driver subsys, and I don't think it it necessary.

Thanks,
Zekun

