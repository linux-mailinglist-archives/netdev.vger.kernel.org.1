Return-Path: <netdev+bounces-170480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C468A48D9C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B49B16E0F5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD64409;
	Fri, 28 Feb 2025 01:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708B29A2;
	Fri, 28 Feb 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704697; cv=none; b=H9vxIoU9p1iOrrUb/2aONFnBgZtzQ5MaM0FgT1S19neiJj2MIqDkF5ZuisrzGLHdWJKlxdRrGLI4R/sDz1s8dFLNlRdzSSMMeFg7+0Of9pBsVnP9igrksB0F5xT5EP/uMxAXDj8IGXsjiiRE6JZC3UEWGF4iWopj22Sz2nvoLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704697; c=relaxed/simple;
	bh=O+Sc7JEncLXs8OMrX6PMtFN47nfFazZvHFbK66KJAqY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DBqLgNL5uFX2DYjjEytg0XND3SSd/QsGkVbgXDLl+xpB2RJCWDvg7oq/vvvzF29e3FMclMdSe1KvbCpMbgAdXbXN22uvT+2awT/1tKWd9heFc/W7JD0FiMFC8ZRnOSlowH/ImUBkalOAexHMR9dkXrYRaaOwjWGZBxNkJvDSbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z3qfd6dFDz9w77;
	Fri, 28 Feb 2025 09:01:45 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C6961403A0;
	Fri, 28 Feb 2025 09:04:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 09:04:50 +0800
Message-ID: <69aae0dd-78f4-47e0-bb86-1d314588e7ad@huawei.com>
Date: Fri, 28 Feb 2025 09:04:49 +0800
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
 <11198621-5c04-4a00-a69e-165e22ebf0e8@huawei.com>
 <20250227064708.7811dfa7@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250227064708.7811dfa7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/27 22:47, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 19:28:25 +0800 Jijie Shao wrote:
>> rx checksum offload enable:
>> 	device check ok ->  CHECKSUM_UNNECESSARY -> stack
>> 	device check fail ->  drop
> Don't drop packets on csum validation failure.
> The stack can easily handle packets with bad csum.
> And users will monitor stack metrics for csum errors.
> Plus devices are wrong more often than the stack.

OK, I'll modify this in the v4 and modify the statistics as well.

Thanks,
Jijie Shao



