Return-Path: <netdev+bounces-121212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C195C363
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541E81C2261D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076481EF1D;
	Fri, 23 Aug 2024 02:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA7171D8;
	Fri, 23 Aug 2024 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381150; cv=none; b=mSjGIS840/PwBRa/k8WV7ZXY0hotk6fpvsB5qXzX4JmMyLhx5cWFYA4i7Hisa2pO6qunIp8dKl8Dy0zfNTthnK2Szj/52wVkDQzWT6qaOnKsdLD2UzdHYSXJkJ7BHlgx026kBi6mOf8hTfg+PCYxuZqsOz6PfMkRzqeY81KY+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381150; c=relaxed/simple;
	bh=uSY8VPNuSo2Cq8rVnrvetx/pXEJZg9zVkUrD+yCsXHw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oh82ouVpA36pW8P0ae8qD5YfY5p+qAIcU7QiksMchfG9zbiF/va4oFY0WHgFk2N7yzmbvYRv0SbNHW7NFR0UeCUj6sJAlO5EHDXqfvF8wFakGkUl/oP1rkPEN4WOtbKhTlVw8j7O6hLjsKI05sTWuphBTTpaiX04CVTjdAEbSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqkvm4Pghz2Cn1G;
	Fri, 23 Aug 2024 10:45:40 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 11D241A0188;
	Fri, 23 Aug 2024 10:45:45 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 10:45:43 +0800
Message-ID: <37dd6262-615f-455b-873d-8cce71f5b455@huawei.com>
Date: Fri, 23 Aug 2024 10:45:43 +0800
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
Subject: Re: [PATCH V3 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-4-shaojijie@huawei.com>
 <7f8679f7-5450-438c-98d7-06ca09cebbcd@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7f8679f7-5450-438c-98d7-06ca09cebbcd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/23 0:13, Andrew Lunn wrote:
>> +void hbg_phy_start(struct hbg_priv *priv)
>> +{
>> +	if (!priv->mac.phydev)
>> +		return;
>> +
>> +	phy_start(priv->mac.phydev);
>> +}
>> +
>> +void hbg_phy_stop(struct hbg_priv *priv)
>> +{
>> +	if (!priv->mac.phydev)
>> +		return;
>> +
>> +	phy_stop(priv->mac.phydev);
> Can this condition priv->mac.phydev not be true? The mdio bus setup
> and connecting to the PHY seems to be unconditional. If it fails, the
> driver fails to probe.
>
> 	Andrew

Yes, these two functions are called during open or down.
so phy is definitely not be NULL. Therefore, this judgment can be deleted.

Thanks,
	Jijie Shao


