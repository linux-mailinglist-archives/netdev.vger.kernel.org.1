Return-Path: <netdev+bounces-244193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876FCB219D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C531E306CA2E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780830504A;
	Wed, 10 Dec 2025 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iA+Hwa5b"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117928FFF6;
	Wed, 10 Dec 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348763; cv=none; b=Z1xasrVwAdWqVv2556T5ShajoD1HKT+Wk+OGfbg4DOla/x/3TOQpvKNTN1CwSwZ/6TfOo2dL78aMpnXxMYMbe6Pccjmw7cnnx3nwubiC9sumh48+U+LLq26ePZ7u0JOovui2WsvWwP4ByBs+jipX409TZUqc63DWzfRfjhvBmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348763; c=relaxed/simple;
	bh=gFZeTqy46XkGIaK+kVw8NY5fGKFAGzuwzkvqpKgIGOI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=poxVP88kt8sNYNXfnLILhhrFvxDBiT4eki0R6Th2YH4LLIkVBuOJaCKZb0CpiRZsq4sEeybtJ5S2G+DhCYNQeMO1Eu+D2vRKEuCI4VcKOwK4//aJHIqX8Y9CfAwedXnYbpQvbMPSELG9Zd13LPTGfotxNFRyTcVI19KVIH9yC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iA+Hwa5b; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gFZeTqy46XkGIaK+kVw8NY5fGKFAGzuwzkvqpKgIGOI=;
	b=iA+Hwa5bd8gJQGN0qq54JzZDgNXISDKG1PkiNqPXxHcjb3QteStjQhlwq/am9biFUZ0q06m4U
	Zg19mocvs2X/9MN2FVkrF3wxlvAmpHa02slKN1kBotsDfGGKFHl5Ss19PJ39/eY7Cy6B8nR2frM
	f5t7rNX5vy6OXeMdk7H0BOY=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dR5cD6X0dzLlTc;
	Wed, 10 Dec 2025 14:37:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E35191A0188;
	Wed, 10 Dec 2025 14:39:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Dec 2025 14:39:12 +0800
Message-ID: <0db6625e-db77-4042-a0cc-43e1ed003d10@huawei.com>
Date: Wed, 10 Dec 2025 14:39:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<lantao5@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: add VLAN id validation before using
To: Simon Horman <horms@kernel.org>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
 <20251209133825.3577343-4-shaojijie@huawei.com>
 <aThTRWe3iHB7HQAZ@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aThTRWe3iHB7HQAZ@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/10 0:50, Simon Horman wrote:
> On Tue, Dec 09, 2025 at 09:38:25PM +0800, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> Currently, the VLAN id may be used without validation when
>> receive a VLAN configuration mailbox from VF. It may cause
>> out-of-bounds memory access once the VLAN id is bigger than
>> 4095.
>>
>> Fixes: fe4144d47eef ("net: hns3: sync VLAN filter entries when kill VLAN ID failed")
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Hi Jijie,
>
> Can you clarify that the (only) oob access is to vlan_del_fail_bmap?
>
> If so, I agree with this change and that the problem was introduced in
> the cited commit. But I think it would be worth mentioning vlan_del_fail_bmap
> in the commit message.
>
Yes, the length of vlan_del_fail_bmap is BITS_TO_LONGS(VLAN_N_VID).
Therefore, vlan_id needs to be checked to ensure it is within the range of VLAN_N_VID.

I will add this in V2

Thanks,
Jijie Shao


> ...
>

