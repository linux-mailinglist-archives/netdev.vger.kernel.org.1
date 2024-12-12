Return-Path: <netdev+bounces-151381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C59EE814
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71E31888365
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6C2135B0;
	Thu, 12 Dec 2024 13:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55009748D;
	Thu, 12 Dec 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011688; cv=none; b=gSvJEh/hQmYKBva+P1hcPB2N/YzNSSR9fN/cKB7rIpoxmxE0G66MM9J6M7WSW7OFjPohSt0fO0+LQ+sRr0yyhRXzl+wFfnd0Bt5xhgKxHnTt5SA61F+0ycFSFDKZHnupDAZrLAvoDHmhHY3aNsxD7dSRJmuKQkDOjIaQ6uhYv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011688; c=relaxed/simple;
	bh=JTJstfVZmGcCjYN5hCh7J5Ce/BQqj4f8zm6cngXTYoM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LlAFn0T64dHtX088E1xD0X7O9fWEQ23zCgDvcxspa0xzUOFjgToOC9YCSpVOjBNQkXfzaYjSWBu0AOrYaAIlstG5vgXlPqC289j09kwsDHtTXoJyyuT8UOpEHylpRYkwHki3EBbnz02Qe03fBuR3rCWX0nrxUWOv/yH3QWhva8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y8DSL3nKhz21mm5;
	Thu, 12 Dec 2024 21:52:50 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 96B0B1400FD;
	Thu, 12 Dec 2024 21:54:36 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 21:54:35 +0800
Message-ID: <265739c7-b7d4-4539-ac10-dce0839a4b53@huawei.com>
Date: Thu, 12 Dec 2024 21:54:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
 <20241210134855.2864577-2-shaojijie@huawei.com>
 <20241211194122.26d6b38b@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241211194122.26d6b38b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/12 11:41, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 21:48:49 +0800 Jijie Shao wrote:
>> +#define hbg_get_bool_str(state) ((state) ? "true" : "false")
> If you're defining a wrapper for this you're better off using
> str_true_false()

Sure, use it in next version

Thanks,
Jijie Shao


