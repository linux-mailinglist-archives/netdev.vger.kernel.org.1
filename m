Return-Path: <netdev+bounces-124584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3F96A0E7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA01C23C81
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AE13DB88;
	Tue,  3 Sep 2024 14:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D713D245;
	Tue,  3 Sep 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374557; cv=none; b=qz3RJtn0EkPunDLUvzRxZwkRGWdOmLjNWsF10H/xCfhbvHvyuoqLDqf9k23yc4PLnI5gyhq6pBEpoWCt2XZFlB7YTlI4gAAKmiDNDIVBWOLVyeaHa0lAFz2isA1qpbrF5G32p+G270LFItg/LVdHquQn8luabBOYRSv1bB7IKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374557; c=relaxed/simple;
	bh=QVAQadzZN7dIsvX86EstxepsgBuqnKqx1hRRg0yNJQM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PgyZbil2Yy0wzR0Q/6pztkmgEjUE1J5XodFcWt6xeaMGC2bUmwCCjlYIOnhy2Pp+QQ+IshUgmhgX4yP4lDpsk6by/EZOZiH4qzSAi3R/FLl9BvURDFds5UbdCSx/2uc2nzlNy2yTtrkusgXbWCwva337dB4EgofbND9Imbl2dQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WypB76npgz69Sr;
	Tue,  3 Sep 2024 22:37:35 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 82BD818010A;
	Tue,  3 Sep 2024 22:42:32 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 22:42:31 +0800
Message-ID: <08462a25-ddd0-4f78-a373-14b822bd7706@huawei.com>
Date: Tue, 3 Sep 2024 22:42:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
 <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
 <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
 <58fe658a-ab77-40fb-b24c-59c5cf2645d6@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <58fe658a-ab77-40fb-b24c-59c5cf2645d6@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/3 21:15, Andrew Lunn wrote:
> On Tue, Sep 03, 2024 at 08:13:58PM +0800, Jijie Shao wrote:
>> on 2024/9/3 19:59, Paolo Abeni wrote:
>>> On 8/30/24 14:15, Jijie Shao wrote:
>>> [...]
>>>> +static int hbg_mdio_wait_ready(struct hbg_mac *mac)
>>>> +{
>>>> +#define HBG_MDIO_OP_TIMEOUT_US        (1 * 1000 * 1000)
>>>> +#define HBG_MDIO_OP_INTERVAL_US        (5 * 1000)
>>> Minor nit: I find the define inside the function body less readable than
>>> placing them just before the function itself.
>> These two macros are only used in this function.
>> Is it necessary to move them to the header file?
> Put them at the top of the .c file. That is pretty much standard in C.
>
> 	Andrew

ok， Thanks!


