Return-Path: <netdev+bounces-138455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E499ADAA7
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A366C281211
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC3139597;
	Thu, 24 Oct 2024 03:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D012FC52;
	Thu, 24 Oct 2024 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741562; cv=none; b=VlJj2akSAg9DHrnVf3zwykU0CzNIRNNr+enZuea9VugKxjORXMSe+m1vY7ZZhdTKH5QCIRf+QqTsgQYrTLF8hzdgq9IL2wqH2WgX4ic/35drWANhHNdauOSd6EBfXn90Tjy33bRYw1Ay0vSr5Fnftpo2oyLCCffLujJLW/6yIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741562; c=relaxed/simple;
	bh=quzQhG4z+ZyJcahn0vyg7NrJ+kjdlMP2EyludXd4Oxs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NMGMhd08JT+hjQsbm4PkQA8j2Rx016cH1AuIXMtEvNx9qvRyigtthJZAhuocMQ+JT6Zu61hRq9nfUFmC2rPXbfku3sTLRf1/VgULNN78nwMF8yeK9B20Qt9mUI/70K/mkSTLXR3OMZYLJr4QD3JNxJDvcnUFw6ytb6TuA6T6qhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XYsGL5x3yz1T98J;
	Thu, 24 Oct 2024 11:43:54 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EEF11800E2;
	Thu, 24 Oct 2024 11:45:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 11:45:56 +0800
Message-ID: <891519a9-9635-4a6f-804a-5b4c0d7637d9@huawei.com>
Date: Thu, 24 Oct 2024 11:45:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/7] net: hibmcge: Add pauseparam supported in
 this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-6-shaojijie@huawei.com>
 <ea2caab1-1bf9-47b3-96a8-6c1c92fbc83b@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ea2caab1-1bf9-47b3-96a8-6c1c92fbc83b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/23 22:15, Andrew Lunn wrote:
>> +static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
>> +				      struct ethtool_pauseparam *param)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(net_dev);
>> +
>> +	if (param->autoneg) {
>> +		netdev_err(net_dev, "autoneg unsupported\n");
>> +		return -EOPNOTSUPP;
>> +	}
> Not being able to do it is not an error, so there is no need for the
> netdev_err().

Ok, Thanks!

>
>
>      Andrew
>
> ---
> pw-bot: cr
>

