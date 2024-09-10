Return-Path: <netdev+bounces-126815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78199972979
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149CAB20C78
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B585176AD0;
	Tue, 10 Sep 2024 06:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA167265;
	Tue, 10 Sep 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949586; cv=none; b=h7RrFki8FbhkFxjuJJLBp0K/o3W6qoh7RqGhjA4veTQS5XA6hSMuf9+/M/dfd1Eps7m2vVFFTm0ItHUqq+xKht28qY1BoODsDMAOKIEU/kSo6EEjBP6TTPsdY7l28l4kcPfGwHCX1xUrSWwANY+rKxSAVeU5awuq9ydaAJT65tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949586; c=relaxed/simple;
	bh=/qmfKFmLdvMow1NT8OvtMXM3ryx2ZK8H+ypz/oi4Gdc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KrjtpQdrJQ1+ZMEUQrWt24PPybm0Bsro0LBPmr37pfmqkq/DsRecGk4fy1PPyYaQ5y6Tw7fpgHIqh5CyKLSiISR07kzq015yRtN3NPV9sswAwITiPtRjInHp4R+MfpAWPUy+I6+VfrnNvztfCj/7kn4omxFv9tvH+aByanxhKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X2txM5Dmvz1S9qq;
	Tue, 10 Sep 2024 14:25:43 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 216801A016C;
	Tue, 10 Sep 2024 14:26:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 14:26:11 +0800
Message-ID: <8f17b1be-cf69-4701-ab62-40141b1cbf99@huawei.com>
Date: Tue, 10 Sep 2024 14:26:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <zhuyuan@huawei.com>,
	<forest.zhouchang@huawei.com>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
To: Andrew Lunn <andrew@lunn.ch>
References: <20240909023141.3234567-1-shaojijie@huawei.com>
 <20240909023141.3234567-6-shaojijie@huawei.com>
 <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
 <116bff77-f12f-43f0-8325-b513a6779a55@huawei.com>
 <fec0a530-64d9-401c-bb43-4c5670587909@lunn.ch>
 <1a7746a7-af17-43f9-805f-fd1cbd24e607@huawei.com>
 <49166f60-bf25-4313-bacb-496103086d40@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <49166f60-bf25-4313-bacb-496103086d40@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/9 22:48, Andrew Lunn wrote:
>> No, HBG_NIC_STATE_OPEN is not intended to ensure that hbg_net_open() and
>> hbg_net_stop() are mutually exclusive.
>>
>> Actually, when the driver do reset or self-test(ethtool -t or ethtool --reset or FLR).
>> We hope that no other data is transmitted or received at this time.
> That is an invalid assumption. You could be receiving line rate
> broadcast traffic for example, because there is a broadcast storm
> happening.
>
> I assume for testing, you are configuring a loopback somewhere? PHY
> loopback or PCS loopback? I've seen some PHYs do 'broken' loopback
> where egress traffic is looped back, but ingress traffic is also still
> received. Is this true for your hardware? Is this why you make this
> assumption?
>
> What is your use case for ethtool --reset? Are you working around
> hardware bugs? Why not simply return -EBUSY if the user tries to use
> --reset when the interface is admin up. You then know the interface is
> down, you don't need open/close to be re-entrant safe.
>
> Same for testing. Return -ENETDOWN if the user tries to do self test
> on an interface which is admin down.
>
> 	Andrew

Good idea. I'll remove priv->state first in v9. We'll discuss this 
internally. Thank you very much. Jiji Shao


