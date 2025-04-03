Return-Path: <netdev+bounces-178948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50849A799BE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FFE1725CB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAE156C72;
	Thu,  3 Apr 2025 01:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60E13D503;
	Thu,  3 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644055; cv=none; b=nihSLT3atD9BZq29zH1JYR53GxHQVuYo4c2BinqSSW3hhMKbPlAAkMMyvFDWg3/vaSFPYcv67OUSsvPoUMOtl9bLt3Gc3ltFthjeqk/4RBkduKBo3H1fOgvyVbfRsyw8fPF1Wy5UOjSGHrGDNmh01PzNPMV6xxsrQiCNvnm9/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644055; c=relaxed/simple;
	bh=BqmQv2Bb2GUtEz8m3NrTfutbOAskOytXYSYECJC/8bk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZN1QUlemYlFxFy6qJyDTrsSl+I0m1kI3grW4scP+aFnk5zCYPCvJLQuPlaCXN5DuF4zzfXMWTn6JTWhNbBazRkFc+CZh03kQOfWfB8Dy/di4aZqg40n2kwzPXKCt0ouxCvawp91DhhYaGH46z2KtuHAQz/UqgG7vKgMS24zFSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZSkhR5dLdzHrJr;
	Thu,  3 Apr 2025 09:30:47 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 621351400CF;
	Thu,  3 Apr 2025 09:34:08 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 09:34:07 +0800
Message-ID: <816331a8-d6f9-4fb2-b9d7-3d51da303fe8@huawei.com>
Date: Thu, 3 Apr 2025 09:34:06 +0800
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
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/7] net: hibmcge: fix incorrect pause frame
 statistics issue
To: Simon Horman <horms@kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-2-shaojijie@huawei.com>
 <20250402185604.GU214849@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250402185604.GU214849@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/4/3 2:56, Simon Horman wrote:
> On Wed, Apr 02, 2025 at 09:38:59PM +0800, Jijie Shao wrote:
>> The driver supports pause frames,
>> but does not pass pause frames based on rx pause enable configuration,
>> resulting in incorrect pause frame statistics.
> I think it would be worth explaining why pause frames need
> to be passed through in order for statistics to be correct.
> I.e. which entity is passing them through to which other
> entity that counts them.

Yeah，This is the behavior of the MAC controller.
I'll describe it in v2

Thank you.
Jijie Shao

>
>> This patch fixes this problem.
>>
>> Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ...
>

