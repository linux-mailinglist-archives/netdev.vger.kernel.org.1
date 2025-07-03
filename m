Return-Path: <netdev+bounces-203629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A762AF68BD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CEB3A90D4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C9238150;
	Thu,  3 Jul 2025 03:36:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB022376E1;
	Thu,  3 Jul 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751513805; cv=none; b=tYk2T79/yH4xj/XauMzq2bp0e7sp4LwWe/IZULAbn/vkFTH+Dhl5gN6jUuIw1N6KR3502V9VxAasoAFKBVYQ6FM1X06ihvurLQLdW3r1E1gNXubPliiWLQw+XVVyQ7JgLMi6lHBprVqR30ZWigUkpTfCc/DmeTskgDVpmHZe7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751513805; c=relaxed/simple;
	bh=qufCM+a9ttb0lswuL1Vr+9sSMDwIKtcoIE0s5xR/GiE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XDi9MCqy+Rw45aHQSqu2dk6/Pn97+jdgqEzT0Q44sHVOO4GoooZNTVNA3ml72Cjn8EbV/QX7wY2Dq3Ljc+Q41lIIirrjsgPtKEh6v//yxszQArHPFeyTWIoYSprKl3/qz82inoc7S6OCD/8meZTJBnsABkU07AmFNoDlnV+ajA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXj7c4WKJz2BdV7;
	Thu,  3 Jul 2025 11:34:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AFF21A016C;
	Thu,  3 Jul 2025 11:36:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 11:36:38 +0800
Message-ID: <cb9826e0-8366-4b34-abce-fedd5882ba00@huawei.com>
Date: Thu, 3 Jul 2025 11:36:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] There are some bugfix for the HNS3 ethernet
 driver
To: Jakub Kicinski <kuba@kernel.org>
References: <20250702125731.2875331-1-shaojijie@huawei.com>
 <f3994ddd-9b9b-4bbb-bba4-89f7b4ae07f7@huawei.com>
 <20250702072301.51deaf72@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250702072301.51deaf72@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/2 22:23, Jakub Kicinski wrote:
> On Wed, 2 Jul 2025 21:07:19 +0800 Jijie Shao wrote:
>> on 2025/7/2 20:57, Jijie Shao wrote:
>>> There are some bugfix for the HNS3 ethernet driver
>> Sorry, ignore this patch set, they should be sent to net not net-next ...
> You still should have waited 24h per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html


Okay, I'll take note of that. Thank you.



