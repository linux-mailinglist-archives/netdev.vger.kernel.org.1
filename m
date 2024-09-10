Return-Path: <netdev+bounces-126994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B088973934
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15FA1F21C6A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE527192D65;
	Tue, 10 Sep 2024 13:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C318CBE0;
	Tue, 10 Sep 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976742; cv=none; b=iFcIqxkDKrj6lNZfmBXvWfwDDfAinQg5U/unMlVy5n446/7SHcsAlyvH1XY6UI2yPOAT1dVOu1qvuaf49MV5Zf+cwhiwy5Fo397A68qYfNpQxNqbz0erO12fM1Xb4e1est88y+JDjO1FvA3BUrzBcEgUk5MmRJDn+VmJ4XFJAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976742; c=relaxed/simple;
	bh=vC8+0dtE1Ak34JQ6TJKuVQR4r4Z+jDwvOunjcpBt75Y=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mdy7FTPqUGW8keNsUwd5iUcryYhcvUuzlVc9uky20h9RXe4ppMgidiw2NA8T3DDLnkXAs9jhjTvDwgM8RAKQcdea7YLeccqZXZEFbUu3Ly4xrTtajZpQaRUXuqrfGDjHUzSvknZ6j4VVHX/HckKFnFfStgyTPuzQnNksasT6Qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X34zQ3P4WzyRdD;
	Tue, 10 Sep 2024 21:58:10 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E7C0140158;
	Tue, 10 Sep 2024 21:58:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 21:58:54 +0800
Message-ID: <817b7a3e-5e77-46bc-9918-e4eb1d322d31@huawei.com>
Date: Tue, 10 Sep 2024 21:58:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V9 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
To: Andrew Lunn <andrew@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-6-shaojijie@huawei.com>
 <a863646c-adc0-4d16-aad3-158702dfef45@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <a863646c-adc0-4d16-aad3-158702dfef45@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/10 20:34, Andrew Lunn wrote:
> On Tue, Sep 10, 2024 at 03:59:36PM +0800, Jijie Shao wrote:
>> +
>> @@ -88,6 +181,10 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	if (ret)
>>   		return ret;
>>   
>> +	netdev->max_mtu = priv->dev_specs.max_mtu;
>> +	netdev->min_mtu = priv->dev_specs.min_mtu;
>> +	hbg_change_mtu(priv, HBG_DEFAULT_MTU_SIZE);
> It does not help that you added added HBG_DEFAULT_MTU_SIZE in a
> previous patch, but as far as i see, it is just ETH_DATA_LEN.
>
> Please use the standard defines, rather than adding your own. It makes
> the code a lot easier to understand, it is not using some special
> jumbo size by default, it is just the plain, boring, normal 1500
> bytes.
>
>      Andrew
>
The value of HBG_DEFAULT_MTU_SIZE is also 1500.
So，ETH_DATA_LEN can also be used.

Sorry I didn't notice ETH_DATA_LEN  before, I'll use it in V10.

Thanks,
	Jijie Shao




