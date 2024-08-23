Return-Path: <netdev+bounces-121226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663AE95C3A3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244D8282632
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40C364AB;
	Fri, 23 Aug 2024 03:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4C3717F;
	Fri, 23 Aug 2024 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382869; cv=none; b=rINtcSl5i+4ZGlePvGXOI8tHyir20E+WsONhDffvGGDSb+3JwT86vTpdOeKj4Az+rSQwyubDoMQyV13fK78w7entePBRk2bJjJfljeNhd7QsMNihJIWBXHnkUje6KpXBQvVxNnbdQJbDRYdvJe/ZZIgnUPipjufFBeFyqXP3/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382869; c=relaxed/simple;
	bh=Dik13fO6l+IddL8N5N3a5FAK8zIEEnxnqYxZ5d68gYI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c1ZMzxmeyQhplx9JpRZaGKVNCw65Lur8NJ26KgIV/3/pU5Y4+Z5UERz1d9x/nHZWEsbKdDGaUtaalrkhSNlsgT6W3xTuZKvAJU+jdprJSoV7SXTPZL9y5T1rNm1M/t6ZdymcTX8m+kaa3Vv/0hpVbYBx0n3wCGUHKfBBdKSLK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqlW6156mzpStK;
	Fri, 23 Aug 2024 11:12:50 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 167AE18005F;
	Fri, 23 Aug 2024 11:14:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:14:22 +0800
Message-ID: <81cbefc2-1cf1-4684-b4b1-5610ee02a8a2@huawei.com>
Date: Fri, 23 Aug 2024 11:14:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 02/11] net: hibmcge: Add read/write registers
 supported through the bar space
To: Andrew Lunn <andrew@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-3-shaojijie@huawei.com>
 <2548f41a-4910-4b60-9433-87714f594e82@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <2548f41a-4910-4b60-9433-87714f594e82@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/23 0:04, Andrew Lunn wrote:
>>   static int hbg_pci_init(struct pci_dev *pdev)
>>   {
>> @@ -56,10 +62,15 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = hbg_init(priv);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = devm_register_netdev(dev, netdev);
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "failed to register netdev\n");
>>   
>> +	set_bit(HBG_NIC_STATE_INITED, &priv->state);
> There is a potential race here. Before devm_register_netdev() even
> returns, the linux stack could be sending packets. You need to ensure
> nothing actual needs HBG_NIC_STATE_INITED when the interface is
> operating, because it might not be set yet.
>
> In general, such state variables are not needed. If registration
> failed, probe failed, and the driver will be unloaded. If registration
> succeeded and other functions are being used, registration must of
> been successful.
>
> 	Andrew

HBG_NIC_STATE_INITED is not used in TX or RX.
We want to be able to use it in function reset and FLR(not including in this patch set).

There is a time gap between pci_init and register_netdev.
Therefore, HBG_NIC_STATE_INITED is introduced to judge whether probe is complete.

	Jijie Shao


