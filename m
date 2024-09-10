Return-Path: <netdev+bounces-126993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2897391C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF58286530
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C2191F94;
	Tue, 10 Sep 2024 13:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401518E11;
	Tue, 10 Sep 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976451; cv=none; b=ixzzWpkxljJzQLbUzQDCZM3GXFEoPv+PAedi1jd3BwN+6MaMj1Km35/ShGnatdvHXIoJYTz9nb4EftGOSYjmWLJrebMwL+omvI92wbmBIug85VL5GdnZr8OuFMRB6JGdM3QvAq89fb0M9/35uOTQX3evVxIoIeqgDlawHmlzJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976451; c=relaxed/simple;
	bh=NU/iu1qh7Qskzs+ak+G1JrBHFNUodngO70+yxvQpSCw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NsLi08nUtS7X2hc+5/Yahk+5+wRsgaskzVUCusqkZ4Ce6gc2EOWpmMJ2iyY1ie4kxRSEMn5vy25aC0EG4tuJS/XtWSN3LOIJ+mc/fcYU6n16yS5fqs2YSJKgnA3bqpnsRLXYrXQfXpb8rlPmgK9nFtQcU6xhCDv1pJ6NOqTV4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X34pb60SQz1HJQB;
	Tue, 10 Sep 2024 21:50:31 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AAEF140138;
	Tue, 10 Sep 2024 21:54:06 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 21:54:05 +0800
Message-ID: <2c876485-3094-41d7-a6cf-d4c9aaaf0b3d@huawei.com>
Date: Tue, 10 Sep 2024 21:54:04 +0800
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
Subject: Re: [PATCH V9 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-4-shaojijie@huawei.com>
 <5a6f372d-31c3-482d-8925-d2a039643256@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5a6f372d-31c3-482d-8925-d2a039643256@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/10 20:21, Andrew Lunn wrote:
> On Tue, Sep 10, 2024 at 03:59:34PM +0800, Jijie Shao wrote:
>> this driver using phy through genphy device.
> As far as i can see, there is nothing here which limits you to
> genphy. The hardware could use any PHY driver which phylib has. In
> general, we don't recommend genphy, it is just a fallback driver which
> might work, but given the complexity of modern PHYs, also might not.
>
> What PHY do you actually have on the board?
>
> 	Andrew

We use YT8521，phylib already has this driver.
Therefore, when CONFIG_MOTORCOMM_PHY is enabled, the PHY driver is automatically used.

Thuis description is a bit misleading and I'll fix it in the next version.
I think I might need to add a dependency on CONFIG_MOTORCOMM_PHY in Kconfig

Thanks
	Jijie Shao




