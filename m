Return-Path: <netdev+bounces-169349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2686A438BC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2497AC254
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D0263F2F;
	Tue, 25 Feb 2025 09:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0A263C78;
	Tue, 25 Feb 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474051; cv=none; b=YhACgZeQ5e9pQLQQkEk38ldZZUDm8OVc3vegzU0IO2fNep+VVNygBJG9czPZMUegqxoySrRhfxzolpP8Cb6+vR4Z1sVNmx8H7KhG9f8sDf/yvw+kZcoLQFxD/QlhR5dIKRoBcvR7MgYz+Gj71iaJ7l/SzqoGcl7PvuuweQzV1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474051; c=relaxed/simple;
	bh=qGBjq6b2fG50Vfe++nNQj/3aecjsAcg52cqNqgJAvNM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GGQcqD5Il38RSg2vPNpTfiqLXLAhlBZ6BbvytNGZLBEONqGzg94XpJQiM+g3TXptoSw6R3fhvQ2k5JUgfOTxJaW+JeQKmhj6aEvkZvGcsiss0F6RMEEfw7PTjDGdrohM9CGLVVnKKhpebVJ3UmppHhhJPxh+3KUbJXeRjPbBxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z2BKG67Xrzdb8g;
	Tue, 25 Feb 2025 16:56:02 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D32941402C3;
	Tue, 25 Feb 2025 17:00:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 17:00:45 +0800
Message-ID: <641ddf73-3497-433b-baf4-f7189384d19b@huawei.com>
Date: Tue, 25 Feb 2025 17:00:45 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250224190937.05b421d0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/25 11:09, Jakub Kicinski wrote:
> On Fri, 21 Feb 2025 19:55:22 +0800 Jijie Shao wrote:
>> +#define HBG_SUPPORT_FEATURES (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
> these are tx not rx


Yes, the processing of the driver tx checksum is received along with the xmit() function, and here it's just set features.
I may need to explain this in the commit log.

>
>> +			     NETIF_F_RXCSUM)
> I don't see you setting the checksum to anything other than NONE

When receiving packets, MAC checks the checksum by default. This behavior cannot be disabled.
If the checksum is incorrect, the MAC notifies the driver through the descriptor.

If checksum offload is enabled, the driver drops the packet.
Otherwise, the driver set the checksum to NONE and sends the packet to the stack.

Thanks,
Jijie Shao



