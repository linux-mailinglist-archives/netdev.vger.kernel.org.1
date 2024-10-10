Return-Path: <netdev+bounces-134283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F189989AF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6134D1F26376
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612D1CBEA8;
	Thu, 10 Oct 2024 14:26:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3611CB30D;
	Thu, 10 Oct 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570411; cv=none; b=Ehe5G+zGlCZH05Sl9uosIJVWv/+KNC9MYobST+q4ZnbtFBOscFjVGoGinbE6h0vPP81jFDJFeuuw7iSaliNyoPIUPsFoVwohnbVC1ivbjFFLXCOs7wF8V51keZgVm//3ZXG0eLsJxNXP4csbEv+qT8ve0LVWci7cTJdZbwrcRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570411; c=relaxed/simple;
	bh=SjpHo2r565oK1J7WeBRjj8r9SFROJI5wWuuwE2pqOjk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rYlQwFiSALbHi9PPES5XMVAfk0/ffRn0X2sDkBl4oBYWKs0e3NC5A7PzCY4ZVrD9xrAY2Wbp9Tc7EEND5TjsdP3pEAPCqxEqsmx9jMCrFEem8KJ9Xl4NoXOtDrFqFn2v/mDruz1jdRQiBtvsU2ydieR03b5sjSKHfz9s8NvFsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPX962Y1JzyS3h;
	Thu, 10 Oct 2024 22:25:30 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id DF1AA180AB7;
	Thu, 10 Oct 2024 22:26:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:26:46 +0800
Message-ID: <2fe76f24-90f8-4c6a-8e67-eb5c6bf0c46f@huawei.com>
Date: Thu, 10 Oct 2024 22:26:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V11 net-next 10/10] net: hibmcge: Add maintainer for
 hibmcge
To: Jakub Kicinski <kuba@kernel.org>
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-11-shaojijie@huawei.com>
 <20241009193717.7b02e215@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241009193717.7b02e215@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/10 10:37, Jakub Kicinski wrote:
> On Tue, 8 Oct 2024 10:23:58 +0800 Jijie Shao wrote:
>> +W:	http://www.hisilicon.com
> The W is for driver information, please put something more relevant
> here or remove the W entry.

Okay, I think it's more appropriate to remove it.


