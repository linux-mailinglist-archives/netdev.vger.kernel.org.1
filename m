Return-Path: <netdev+bounces-170205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD26A47C33
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1CD3A43A5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82B22A1D2;
	Thu, 27 Feb 2025 11:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5384215F45;
	Thu, 27 Feb 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655720; cv=none; b=S0Gnierkkj7jmpp5zGGXEJ1Z38DmogZUAz2w18JWI2QeGNjNu/E2BE6jbySABPlM90mPkt7juKj4PVHrcZymBHLz/dJjsHAgeqfMUZ5/EXfM2I8mqK3vrcJkko9QmNYB27XPXP4DB2085GWXufowDc/MrxScRp263FkKZSMogN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655720; c=relaxed/simple;
	bh=AVYD9G/Hnh2E9vpPCeJsnf+TDieaShVmNKOLUm8dk3U=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=om9b/RseMbYRzOm2ZmRT6U+hIJ3FDlKRVGTWzNyQk8D1XvABh6DnrvkDgg85ymarPYdFzwiPNyvbizWBnJGQ1qCEY4UOJmxMbiMPGUXMVKvlkYnzZb/F001V5eYAn5yFrDS+XGnkR0+9GCsj9F6kfqBl61wmgIvDoIkYiaWHQIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z3TZS6Vq3zTn7b;
	Thu, 27 Feb 2025 19:26:56 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AF5FB140133;
	Thu, 27 Feb 2025 19:28:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 19:28:27 +0800
Message-ID: <11198621-5c04-4a00-a69e-165e22ebf0e8@huawei.com>
Date: Thu, 27 Feb 2025 19:28:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 2/6] net: hibmcge: Add support for rx checksum
 offload
To: Jakub Kicinski <kuba@kernel.org>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
 <20250221115526.1082660-3-shaojijie@huawei.com>
 <20250224190937.05b421d0@kernel.org>
 <641ddf73-3497-433b-baf4-f7189384d19b@huawei.com>
 <20250225082306.524e8d6a@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250225082306.524e8d6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/26 0:23, Jakub Kicinski wrote:
> On Tue, 25 Feb 2025 17:00:45 +0800 Jijie Shao wrote:
>>>> +			     NETIF_F_RXCSUM)
>>> I don't see you setting the checksum to anything other than NONE
>> When receiving packets, MAC checks the checksum by default. This behavior cannot be disabled.
>> If the checksum is incorrect, the MAC notifies the driver through the descriptor.
>>
>> If checksum offload is enabled, the driver drops the packet.
>> Otherwise, the driver set the checksum to NONE and sends the packet to the stack.
> Dropping packets with bad csum is not correct.
> Packets where device validated L4 csum should have csum set
> to UNNECESSARY, most likely. Please read the comment in skbuff.h

Hi, is it ok below:

rx checksum offload enable:
	device check ok ->  CHECKSUM_UNNECESSARY -> stack
	device check fail ->  drop
	
rx checksum offload disable:
	device check ok ->  CHECKSUM_NONE -> stack
	device check fail ->  CHECKSUM_NONE -> stack

Thanks
Jijie Shao






