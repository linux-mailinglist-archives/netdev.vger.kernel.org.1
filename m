Return-Path: <netdev+bounces-168506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0BA3F2FA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350FC7033B3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43023202F95;
	Fri, 21 Feb 2025 11:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E75202F65;
	Fri, 21 Feb 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137697; cv=none; b=M600hbQKYhEWyKrUxNfSdZfXBHZ0cX1M+qnnkULGSOYdZknt25Uwk7DL6Cfal6ZTAGNnCau3RgkPKeCPrc1MPHgHU+Z4XjZB/hNmsMe3CeDK7os8ZyEpQnDWVeOtz2yE796PFPXqrY1hDXJHaxUw4wO0DR5UUnoUK0qhbt+qR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137697; c=relaxed/simple;
	bh=Id1fAptqrUosRWS3N6q0jDxo6pmOozUPfyTOPAECM94=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQD182DugQka0tdBPQn6QgCnxjbsNP412quC5giqjpnmRIejUNlNhBOzcYx2u4IfpaHLbV88sHkZzUkl7HSV5Ro0o4a+2Fu/k9j6QjVWfLEcsi7Wk1Klqm9NOYCZRGqjcxJRpDjx/17nt/kVCG6PPXkQXW64J2j93+rNgQsO9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yznxj50vhz2Jx93;
	Fri, 21 Feb 2025 19:30:49 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 162F71A016C;
	Fri, 21 Feb 2025 19:34:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 19:34:46 +0800
Message-ID: <09f9ae9e-6ccc-485d-a066-c13be64e7f99@huawei.com>
Date: Fri, 21 Feb 2025 19:34:46 +0800
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
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 1/6] net: hibmcge: Add dump statistics
 supported in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
 <20250218085829.3172126-2-shaojijie@huawei.com>
 <20250220151710.78f4893f@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250220151710.78f4893f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/21 7:17, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 16:58:24 +0800 Jijie Shao wrote:
>> Subject: [PATCH v2 net-next 1/6] net: hibmcge: Add dump statistics supported in this module
> In addition to addressing my comment about fix_features please
> also remove the "in this module" from all patch titles.

okay

>
> Other than that code LGTM.
>

