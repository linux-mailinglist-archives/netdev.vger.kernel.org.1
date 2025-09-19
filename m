Return-Path: <netdev+bounces-224672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDCB87F84
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AFB1C864A4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703B02882A8;
	Fri, 19 Sep 2025 06:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9C225779;
	Fri, 19 Sep 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262079; cv=none; b=jY1sU/VNTg/eiuzBZlTCgLKzdK9nqLugArtX5ZzQMWDKr05/9DbX/iVaWeDFxZWB1SDzoP7SA/QYs4L2b/byHpaXChET2MiZTv07M4vUzK7HyQyJfkY8B2qllzA1rZ8khAK4kxoH8Y6GjWNbWH50WOOPmOsUwOBcG+9p8GjCEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262079; c=relaxed/simple;
	bh=hbhuV7aeox1o2fdIgInq9Tkb2Qwf2AVg9cScK/j+cXA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AuE32buqIafYaLbLTJ5pmPgSSjqr/TBbAkgOzzGuO59DptlNiqmGhaQzV1e9ld9YnNLZwfCb7bjSYIrWuSaxj1Y6mRHmOIM3Sa7pclv1L+VAj/xPOU8INs0UcJqstZwf+nI7i50g59/oyXMcfeAJ9z47kLHrJ5GfQtlRxYXufwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cShlB6Bd2z13MkW;
	Fri, 19 Sep 2025 14:03:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B70180080;
	Fri, 19 Sep 2025 14:07:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 14:07:45 +0800
Message-ID: <59d9add5-a4f5-4ee2-9fd8-a2ced4cbe0d4@huawei.com>
Date: Fri, 19 Sep 2025 14:07:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<huangdengdui@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: use user configure after hardware
 reset when using kernel PHY
To: Andrew Lunn <andrew@lunn.ch>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
 <20250917122954.1265844-4-shaojijie@huawei.com>
 <5188066d-fcd2-41e7-bd8a-ae1dfbdd7731@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5188066d-fcd2-41e7-bd8a-ae1dfbdd7731@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/9/18 1:11, Andrew Lunn wrote:
> On Wed, Sep 17, 2025 at 08:29:54PM +0800, Jijie Shao wrote:
>> When a reset occurring
> Why would a reset occur? Is it the firmware crashing?
>
>> Consider the case that reset was happened consecutively.
> Does that mean the firmware crashed twice in quick succession?
>
>       Andrew

Actually, We can trigger a reset by ethtool:
ethtool --reset ethx...



