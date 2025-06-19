Return-Path: <netdev+bounces-199439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE7AE04ED
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E9F3B54A9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D110259CB9;
	Thu, 19 Jun 2025 11:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D7258CF7;
	Thu, 19 Jun 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334362; cv=none; b=mV1nVLepeGiHPfJeM1EiKbRwYuLk00NHe5/bvP0k8glK+IF4B2+tBunOExP6gnd76AVI7xbVRHDYZ1kyp3H8ScyDAauCQWyRQg4XO5W+IiYpLqwAekOrOFrOWJEIAB8W9NpUyEoDKprtTnMamnWilVYk7VyzHVi+1k99kiXtTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334362; c=relaxed/simple;
	bh=iVqwSJOrUUKdU3YweV0T+6fhDKrE8tyv1LFowiLtiDA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B0+OR/rBrmpYHt8b/ikK81SuzvImbqQUEm4d8fCNGUtgHiGKN8F0ZK0QWQ3vJe7HkZpbVN2hH5NhRADLPySwiY632YwXRZuHFkqEgY9An1wtwj4BD7zveo0xSD3LFfWsxermlw4rW5rNYxsxV5oUlvt7PXsb579DaThRVGBFMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bNJvQ2X10zdbfY;
	Thu, 19 Jun 2025 19:55:14 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 75EA5180B43;
	Thu, 19 Jun 2025 19:59:09 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 19:59:08 +0800
Message-ID: <5a23d321-307a-4f4a-a2cf-9c8dcf001dbb@huawei.com>
Date: Thu, 19 Jun 2025 19:59:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH V2 net-next 8/8] net: hns3: clear hns alarm: comparison of
 integer expressions of different signedness
To: Simon Horman <horms@kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-9-shaojijie@huawei.com>
 <20250618112924.GL1699@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250618112924.GL1699@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/18 19:29, Simon Horman wrote:
> On Tue, Jun 17, 2025 at 09:02:55AM +0800, Jijie Shao wrote:
>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>
>> A static alarm exists in the hns and needs to be cleared.
> I'm curious to know if you used a tool to flag this.

Sorry, the last reply was not cc to netdev...

Some internal tools, and then there are the compiler options, such as -Wsign-compare.

>
>> The alarm is comparison of integer expressions of different
>> signedness including 's64' and 'long unsigned int',
>> 'int' and 'long unsigned int', 'u32' and 'int',
>> 'int' and 'unsigned int'.
>>
>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
>>   .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 22 +++++++-------
>>   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +-
>>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  4 +--
>>   .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 13 ++++----
>>   .../hisilicon/hns3/hns3pf/hclge_main.c        | 30 +++++++++----------
>>   .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +++--
>>   .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
>>   .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
>>   .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  2 +-
>>   .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
>>   11 files changed, 44 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
>> index 4ad4e8ab2f1f..37396ca4ecfc 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
>> @@ -348,7 +348,7 @@ static int hclge_comm_cmd_csq_clean(struct hclge_comm_hw *hw)
>>   static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
>>   {
>>   	u32 head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
>> -	return head == hw->cmq.csq.next_to_use;
>> +	return head == (u32)hw->cmq.csq.next_to_use;
> Can the type of next_to_use be changed to an unsigned type?
> It would be nice to avoid casts.

Today I plan to modify the next_to_use type,
but I found that if next_to_use is changed to u32,
it will cause many other places to need to synchronously change the variable type.
At a glance, there are dozens of places.

Therefore, I am considering whether this part can remain unchanged.

Thanks
Jijie Shao



