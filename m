Return-Path: <netdev+bounces-218626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045FB3DADF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C05167FCF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44E2676C9;
	Mon,  1 Sep 2025 07:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8C264F9F;
	Mon,  1 Sep 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710908; cv=none; b=gzj9HMwFQi/MZjhmqfGGf6JK3HSDw1yEM+ABO6P46qGYM+02JilF4n2S1HrMbFMF/ksyze93tH0mzRKNvLdHitVg9f7lSjBDvCjZxvmPa3nZ5FVOwTkrRUKS+QaJ72rFosAPfw3WGR9/KjyiAGCnATGKwG4qEswmw6TtVhPjPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710908; c=relaxed/simple;
	bh=ZrdXRcJt4j8oZnNfOvY+77amPNFzlC9tn1RrwxxmdS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oJ/LLa++n2pd1RT1O2/0stn4wQHLoMefWCzCukr6GCSlU7gU53W+Qd4iN6rTtLk5ImfVB5Pkofpe8QMo8c2hHk9z6aOhLqkB0Ve5nYhYAoJ6imoLKFTlVPyCgBbOmFvAThRY6lSL5ZwddtwtZtP5T0Xcz/tVaybx54Bi8q7yRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cFg9n6yfsz14MnD;
	Mon,  1 Sep 2025 15:14:53 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 200BA140202;
	Mon,  1 Sep 2025 15:15:03 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 15:15:02 +0800
Message-ID: <879f09d3-1984-4de5-8eb5-7209c1cbf196@huawei.com>
Date: Mon, 1 Sep 2025 15:15:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ipv6: annotate data-races around
 devconf->rpl_seg_enabled
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
	<alex.aring@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250827081243.1701760-1-yuehaibing@huawei.com>
 <20250829192737.680488a9@kernel.org>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250829192737.680488a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/30 10:27, Jakub Kicinski wrote:
> On Wed, 27 Aug 2025 16:12:43 +0800 Yue Haibing wrote:
>> Also initializes extra1 and extra2 to SYSCTL_ZERO and SYSCTL_ONE
>> respectively to avoid negative value writes, which may lead to
>> unexpected results in ipv6_rpl_srh_rcv().
> 
> By unexpected results you mean that min() is intended to return 0
> when either value is zero, but if one of the values is negative it
> will in fact return non-zero?

Yes，this is exact.
> 
> That's a fair point, but I'm not sure whether we should be sending
> that up as a fix. It's more of a sanity check that prevents
> unintentional misconfiguration.. Please split this patch into two
> separate ones, and send the minmax one without a Fixes tag.
> Please include more of the explanation I have provided in the first
> paragraph in the commit message, "unexpected results" is too vague
> by itself.
Ok, thanks, will split and resend with this.
> 

