Return-Path: <netdev+bounces-192137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54BABEA01
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C13AA03F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9E1C6FFB;
	Wed, 21 May 2025 02:44:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2F4430;
	Wed, 21 May 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747795444; cv=none; b=fdmvwvGhIePKNxq8QN25y0AwkOehFjUPIuezcIqYU6qkM49A1Zhk/outCy76IHKyUj6KazhrBGDToXhr+By/G8ylLvkykrXBl0TgOaywX+RhatlCh2KjVcDbq+68cU/i3z8zmZpSmlB0kdadkuwQCJyAj2keqq5qDFIf5KS4VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747795444; c=relaxed/simple;
	bh=w0I01Ih4JN5gWqMKM+HRudVSOARN3WgI0i002YJCtdw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lZE7iu11p7jQ2bbWD19Dl4AJpbU4VebzXvR9FtvRGQ03WUFHfDlbrXCvAkCcUqNyoPEDfWmndCmg9Qdk9F5KLAB3o0fvuLS66RcT+bXO80xOg6X8bSOtRVqp+mpBIBI5FrZACWZJhTPlMuDaWbz8jSPT64RoKixuyGT//8hEXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4b2Fxm21hRzQkR6;
	Wed, 21 May 2025 10:39:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EEFD3140337;
	Wed, 21 May 2025 10:43:43 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 May 2025 10:43:43 +0800
Message-ID: <e35be8e7-9956-46fb-9a8f-d09506465d61@huawei.com>
Date: Wed, 21 May 2025 10:43:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, "horms@kernel.org" <horms@kernel.org>,
	"lanhao@huawei.com" <lanhao@huawei.com>, "wangpeiyang1@huawei.com"
	<wangpeiyang1@huawei.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: Add error handling for VLAN filter
 hardwareconfiguration
To: Wentao Liang <vulab@iscas.ac.cn>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250517141514.800-1-vulab@iscas.ac.cn>
 <3f03a8d0-c056-4c46-8f98-a5b5f48c6159@huawei.com>
 <682BD774.007007.29338@cstnet.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <682BD774.007007.29338@cstnet.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/5/20 9:14, Wentao Liang wrote:
>
> > Are there any real functional problems?
>
> > Would you please tell me your test cases? I'm going to try to reproduce the problem.
>
> Hi,
>
> I found this problem by static analysis and manual auditing. I believe 
> there should be add a check just like the other call of 
> hclge_set_vlan_filter_hw(). If the check is useless, could you please 
> tell me the detailed reason.
>
Hi Wentao,
  
Thanks for your reply.

I checked the code, and found that the purpose of all two places called hclge_rm_vport_vlan_table() now is just to update the vlan list,
never do clear the vlan entry in hardware. So I prefer to remove the parameter 'is_write_tbl' from hclge_rm_vport_vlan_table(),
and remove the hclge_set_vlan_filter_hw() calling in it.

Thanks,
Jijie Shao

> Thanks,
>
> Wentao Liang.
>

