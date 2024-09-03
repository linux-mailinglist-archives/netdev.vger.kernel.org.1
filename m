Return-Path: <netdev+bounces-124516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F417969D28
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE93284419
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38141C9854;
	Tue,  3 Sep 2024 12:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E71CEAC4;
	Tue,  3 Sep 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365649; cv=none; b=O4aqUpE+FDZLQk5m/86GBbJqe/0dOsb/CPVk/4a2i10PquAyNn9RK+RhqyQ7CeiKbAkm3lLWtjKnxbgB8p6SHA0+uXvti3uK5UPFkHvskagx7sSjeB9Trq/OxDOdAtkEVOEIsjgBlzadS4v/6CPEdA7KPsuGi3yHElDa5eCcrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365649; c=relaxed/simple;
	bh=uo3J5vdSL9Nj+lyqUX2ohj9VwlQQPdz8v3pBjh5S/Xc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ead+PVWwuEcErfQqnk/GS6OAo3/pzJhr3zdOLJRlwE2nCkWaQsw0b/IQ4Ibh4rvNYDPFdFQdZ4xLcIXmFWCU4BmtDq/2eT4r+as6Td5EfZuVW5ikfFgNHwHQo9doX5uY0eRMoNNlppD2Soi1Dq4Qm2C7itrUdR6+Fyw0q4lpKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wyky21ZfNzgYvm;
	Tue,  3 Sep 2024 20:11:54 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 015CF1402CC;
	Tue,  3 Sep 2024 20:14:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 20:13:59 +0800
Message-ID: <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
Date: Tue, 3 Sep 2024 20:13:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
 <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/3 19:59, Paolo Abeni wrote:
> On 8/30/24 14:15, Jijie Shao wrote:
> [...]
>> +static int hbg_mdio_wait_ready(struct hbg_mac *mac)
>> +{
>> +#define HBG_MDIO_OP_TIMEOUT_US        (1 * 1000 * 1000)
>> +#define HBG_MDIO_OP_INTERVAL_US        (5 * 1000)
>
> Minor nit: I find the define inside the function body less readable 
> than placing them just before the function itself.

These two macros are only used in this function.
Is it necessary to move them to the header file?

>
>> +
>> +    struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
>> +    u32 cmd;
>> +
>> +    return readl_poll_timeout(priv->io_base + 
>> HBG_REG_MDIO_COMMAND_ADDR, cmd,
>> +                  !FIELD_GET(HBG_REG_MDIO_COMMAND_START_B, cmd),
>> +                  HBG_MDIO_OP_INTERVAL_US,
>> +                  HBG_MDIO_OP_TIMEOUT_US);
>> +}
>
> [...]> +static void hbg_phy_adjust_link(struct net_device *netdev)
>> +{
>> +    struct hbg_priv *priv = netdev_priv(netdev);
>> +    struct phy_device *phydev = priv->mac.phydev;
>
> Minor nit: please respect the reverse x-mas tree order

Here, I need to get the *priv first, so I'm not following the reverse x-mas tree order here.
I respect the reverse x-mas tree order everywhere else.

	Thanks,
	Jijie Shao


