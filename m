Return-Path: <netdev+bounces-121563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB295DA88
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D4C1F22B74
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B90847C;
	Sat, 24 Aug 2024 02:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C498460
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465802; cv=none; b=qdwkLOqwYtvNuhKRpy+wRfcEAK4ib7O8hyA6cqJob91HwQ22Rz7KSUUf3+Xq9dKBOdYgVrj4riIOfkgqOM1hrr9nyyQ528/Me5y65pUiHnPVbi9khwPsXgze/H1+bEmLu3DLttMrthtHQF4ipm1LFn3iRNjYANoZbrdZHy07Sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465802; c=relaxed/simple;
	bh=yRE/A/acsPIUR4+3Q99T/xggfooaG9SvfzD/gmNUVWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bRqRO/6wcUjOO7kJZHeqtp3Ob54KbMLdc0eoFSBAVcZG9gpFDAEeS2RTpNrUlbb8Lwsgx+dtN4CHd0XolVqDVgjOzIKa9khXF2qCpzCpnMOjwC7JYMoy0OdHp9smVTcSfUYcTbrGG/dS9XwHfJWbzlPP6pu5xEuOjExDkzf4Az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrL9R0lJwzhXtv;
	Sat, 24 Aug 2024 10:14:35 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id E124F18007C;
	Sat, 24 Aug 2024 10:16:36 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 10:16:36 +0800
Message-ID: <0e6320d8-937f-41f2-8302-cf573aa2a273@huawei.com>
Date: Sat, 24 Aug 2024 10:16:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] net: Delete some redundant judgments
To: Petr Machata <petrm@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <gnault@redhat.com>, <b.galvani@gmail.com>,
	<alce@lafranque.net>, <shaozhengchao@huawei.com>, <horms@kernel.org>,
	<j.granados@samsung.com>, <linux@weissschuh.net>, <judyhsiao@chromium.org>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <87y14nidbs.fsf@nvidia.com>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <87y14nidbs.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500016.china.huawei.com (7.185.36.70) To
 kwepemd500012.china.huawei.com (7.221.188.25)


Hi,
在 2024/8/23 21:16, Petr Machata 写道:
> 
> Li Zetao <lizetao1@huawei.com> writes:
> 
>> This patchset aims to remove some unnecessary judgments and make the
>> code more concise. In some network modules, rtnl_set_sk_err is used to
>> record error information, but the err is repeatedly judged to be less
>> than 0 on the error path. Deleted these redundant judgments.
> 
> What you call "judgments" would be usually called "conditionals" or
> "conditional statements", "judged less than zero" would be probably
> "compared to zero". I think the commit messages are reasonably clear
> despite this, so I'd leave it be unless others push back. But it's worth
> keeping in mind for future contributions.
Thanks you, I will take your advice.

Thanks,
Li Zetao.

