Return-Path: <netdev+bounces-204909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FAEAFC76A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E57168A29
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C52265CC2;
	Tue,  8 Jul 2025 09:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C8266B67;
	Tue,  8 Jul 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968259; cv=none; b=WUMEBGxmZwKWXlQwYLZcM/1ASfubVo3XwyER1ExBBZPTN5SLUKItJvBy2qDUyV2BHCCkaWQ3VvhXa37XyXZeGhkExfiTQoWHSm0XAHdtQPY9E3UVnhOHeEOOFS8pL9fUtmOw9eg4G1ExOEhRyNadiUmLKbt7LZDN4WuuUzsCIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968259; c=relaxed/simple;
	bh=2eu5s8VoKRnSj6Fq1XRT5mEFWqsss2QcY2xiIuHGw44=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nxbHRJPNLnOTpuy+xh7hI/IfOercRZR5eFGNCF1O4DV2vcnSvU1AX37nyvZIY8EoeldMpWvbwvVyLfQTZAZZBZE+vO5DchsA7iKSQrr3QMTJSCadlTjIQ2FiZXT9amv/CLMLNT8YfWLVgYjEz9YyQtALqwMbx0mtvF4+Ti+u3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bbwlt6LWlz2FbNW;
	Tue,  8 Jul 2025 17:28:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 680571A016C;
	Tue,  8 Jul 2025 17:30:52 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 17:30:51 +0800
Message-ID: <f12322f7-d873-4c2d-b614-3fb40cf9ab4f@huawei.com>
Date: Tue, 8 Jul 2025 17:30:51 +0800
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
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/4] net: hns3: fix concurrent setting vlan filter
 issue
To: Simon Horman <horms@kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-2-shaojijie@huawei.com>
 <20250704155216.GF41770@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250704155216.GF41770@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/4 23:52, Simon Horman wrote:
> On Wed, Jul 02, 2025 at 09:08:58PM +0800, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> The vport->req_vlan_fltr_en may be changed concurrently by function
>> hclge_sync_vlan_fltr_state() called in periodic work task and
>> function hclge_enable_vport_vlan_filter() called by user configuration.
>> It may cause the user configuration inoperative. Fixes it by protect
>> the vport->req_vlan_fltr by vport_lock.
>>
>> Fixes: fa6a262a2550 ("net: hns3: add support for VF modify VLAN filter state")
> I think the commit sited above is for the VF driver, whereas this
> patch addresses PF driver code. I think the following is the
> correct tag:

Yeah, I will fix it in v2.

Thanks,
Jijie Shao

>
> Fixes: 2ba306627f59 ("net: hns3: add support for modify VLAN filter state")
>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Otherwise, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>
>

