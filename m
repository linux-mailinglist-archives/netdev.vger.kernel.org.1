Return-Path: <netdev+bounces-201723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD12AEAC45
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA217B1A8F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64178F36;
	Fri, 27 Jun 2025 01:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DA3FF1;
	Fri, 27 Jun 2025 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986842; cv=none; b=N/qQJclAS7QYWPfybNp4RxefWeAFDyISQevd7/TzDYw+qvCMA8HsryGKd0vKcEjCTMFprfYw47vz3Yp3AUA+eKz1RrEMG0LHimZWWIlouY/ag+gSETPJBKCR1Oa2EnceUyUj7wsgC1AdjWc0rZawIEqPQA7+c9H+b4PyyImV/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986842; c=relaxed/simple;
	bh=E9qOIjaeUyDj/QW736gI7kwyOLH47uPnBzOmDJkTJzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lVXZorDWva4gvo7AEY5Th/MfpTTI1rjFwyMG2mFl2NDrlOFPVsEMc+9E2fU9PW+dJ6X9U031leNqfaTYyvkyWD18S5R0NsrPel7JwheRvia/JIeobNeXPaOzIE6nUM4J1HUQCJTEBwsb8N9CH0gpAq3C1Nv6JypxTRyrDY0nURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bSyBQ4Gmyz10XJq;
	Fri, 27 Jun 2025 09:09:18 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id A9F57180080;
	Fri, 27 Jun 2025 09:13:56 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Jun 2025 09:13:55 +0800
Message-ID: <eedc1f82-1f99-421c-9b92-2155e5991a7f@huawei.com>
Date: Fri, 27 Jun 2025 09:13:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: add sysctl ndisc_debug
To: Ido Schimmel <idosch@idosch.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250624125115.3926152-1-wangliang74@huawei.com>
 <aFq2s3SnM1lzuGHb@shredder>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aFq2s3SnM1lzuGHb@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/6/24 22:31, Ido Schimmel 写道:
> On Tue, Jun 24, 2025 at 08:51:15PM +0800, Wang Liang wrote:
>> Ipv6 ndisc uses ND_PRINTK to print logs. However it only works when
>> ND_DEBUG was set in the compilation phase. This patch adds sysctl
>> ndisc_debug, so we can change the print switch when system is running and
>> get ipv6 ndisc log to debug.
> Is there a good reason to do this instead of using dynamic debug? Note
> that we will never be able to remove this sysctl.
>
> Users of vanilla kernels can only see the messages printed with 'val'
> being 0 or 1. Maybe convert them to call net_{err,warn}_ratelimited()
> instead of ND_PRINTK() and convert the rest to net_dbg_ratelimited() so
> that users will be able to enable / disable them during runtime via the
> dynamic debug interface?
Hi! Thanks for your review!

Yes, you are right. Dynamic debug is indeed a better choice.

I will use it to replace sysctl in v2.

------
Best regards
Wang Liang

