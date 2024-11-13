Return-Path: <netdev+bounces-144297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074249C67C1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 04:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A8C1F25F41
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBE16A382;
	Wed, 13 Nov 2024 03:21:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E85137772;
	Wed, 13 Nov 2024 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468098; cv=none; b=E0NQUixftCJuyzlkcwdm6hCvCqU2SsGgOYwoPwAn/VvUuelTMJiqbG9H7W0VVSMZ7PhLb55zg98kU7LSsII5aMhVywlCNHXbYixgtDLfurDZ0tjPmYpQFSEdwpAhIZRu/RnDaKYnUOhUMnWp0n2OEIC75U4bVXNxNAXWgXLypKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468098; c=relaxed/simple;
	bh=oCeLhmECjCfjJPmJQCew1r3IUZo+nKxsTur8WxSCoR0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sK87KOiCdgdPIFB6jnO1AezBoIBieZDjzNo00a3s7pquzn4Pxongl445qbnGsjKio5YDa12kGa4Mv+ZLl8zQughwRKu7VncrcI+qw2Ede0XPYhbo2OYG6GKiHHISaeBQmRajWpPA3HBgLf2AaubFJcb3YKbVGITGqHGcO4mcfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xp7np3bt7zQstp;
	Wed, 13 Nov 2024 11:20:14 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DDFA51400FF;
	Wed, 13 Nov 2024 11:21:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 11:21:27 +0800
Message-ID: <b6c69eb6-f689-4ff8-bdc2-804e2a4b6c3e@huawei.com>
Date: Wed, 13 Nov 2024 11:21:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 0/7] There are some bugfix for the HNS3
 ethernet driver
To: Simon Horman <horms@kernel.org>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
 <20241112170813.GS4507@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241112170813.GS4507@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/13 1:08, Simon Horman wrote:
> On Thu, Nov 07, 2024 at 09:30:16PM +0800, Jijie Shao wrote:
>> There's a series of bugfix that's been accepted:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=d80a3091308491455b6501b1c4b68698c4a7cd24
>>
>> However, The series is making the driver poke into IOMMU internals instead of
>> implementing appropriate IOMMU workarounds. After discussion, the series was reverted:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568
>>
>> But only two patches are related to the IOMMU.
>> Other patches involve only the modification of the driver.
>> This series resends other patches.
> Hi Jijie Shao,
>
> Cover letters for patch-sets for Networking do make it into git history,
> e.g. This cover letter [1] became this commit [2]. So please consider a
> subject that will be more meaningful there.
>
> e.g. [PATCH net v2 0/7] net: hns3: implement IOMMU workarounds


Okay, no problem. I'll pay more attention to this.

Thanks
Jijie Shao

>
> Thanks!
>
> [1] [PATCH net v2 0/3] virtio/vsock: Fix memory leaks
>      https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
> [2] 20bbe5b80249 ("Merge branch 'virtio-vsock-fix-memory-leaks'")
>      https://git.kernel.org/netdev/net/c/20bbe5b80249
>
> ...

