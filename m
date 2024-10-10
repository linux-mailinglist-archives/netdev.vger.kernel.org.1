Return-Path: <netdev+bounces-134282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA7998984
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F4A286476
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A411CB526;
	Thu, 10 Oct 2024 14:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D41CEAD8;
	Thu, 10 Oct 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570334; cv=none; b=XsHX469KXqsPc48JQN7bWwATxsVMtKTFuTN4SI0oN/tdgqVs5+aE21xjwZw6SdbZYW3wKbzGU1D2Wpd+mxXckz55Wnm7JmfkmLwtiNYrjWKndVCGJI9fSqQyB4JHD0wG3ltK/vbyp9nCsyBWM7fk8Gxy+sbjxsL/p5U+JDiZiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570334; c=relaxed/simple;
	bh=2pq+PCaKW13OcGj/QHrGroHyRrC3F1xj885ZlE5cY8c=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J6DgEYAT6ku9bTHcNvyk32CZj0Xii+OCUqiIdFVSvrDnSmadxfFzcCbl9k4GQ2czt0pmnqexSWhqt4l6G6tniwUGKXYvKClT+muIHLIzSDph/U6dNUTVE35MbXcR+Iu7r/hrihh1byYoTJLMulnIXWFUeiIvD2c+UwomLfNdY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XPX8N0nHhzCt8W;
	Thu, 10 Oct 2024 22:24:52 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D210180105;
	Thu, 10 Oct 2024 22:25:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:25:28 +0800
Message-ID: <ff5ce467-321a-4037-b643-65ff4151d092@huawei.com>
Date: Thu, 10 Oct 2024 22:25:28 +0800
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
Subject: Re: [PATCH V11 net-next 00/10] Add support of HIBMCGE Ethernet Driver
To: Jakub Kicinski <kuba@kernel.org>
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241009193641.17015e59@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241009193641.17015e59@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/10 10:36, Jakub Kicinski wrote:
> On Tue, 8 Oct 2024 10:23:48 +0800 Jijie Shao wrote:
>> This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.
>>
>> This patch set includes basic Rx/Tx functionality. It also includes
>> the registration and interrupt codes.
>>
>> This work provides the initial support to the HIBMCGE and
>> would incrementally add features or enhancements.
> Please wrap the code at 80 chars.
> We still prefer the 80 char limit in networking.
> Use ./scripts/checkpatch.pl --strict --max-line-length=80

Thanks,I will fix it in v12


