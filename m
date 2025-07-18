Return-Path: <netdev+bounces-208063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BDB09929
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 03:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99083563E3C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E83398B;
	Fri, 18 Jul 2025 01:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E387208A7;
	Fri, 18 Jul 2025 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802410; cv=none; b=jI88tInI9XDHcuz2KWQlX14hu1hriNu76a+F8ZeUoiuSKKUcgdP/yyd3ocGAgwKrAY3Tks7RT1E8HIa4oo9vxdKuMUoiJVmhZuH2kta5nwuk3qtyK3HoZtbBsqEIOayyJZFEtCouI2A5hZ4ONN/DTjydNr2+DXjpsFZt2Pgi1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802410; c=relaxed/simple;
	bh=7Q5fO1jqokwVGteCeI378rmLEpn8TEGfBuai5VF3SC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UWXuewXr+2J633OgqpYrAQMssO1Pr87HwFWe07Pkl+O7VWSx84VWdtx8X0gvdTW8sWeSmWb9rh52Ug4knm3QUY2yziMtEzdG/QGntnZUf8N/im96sGXisFDwMIQPxSQn/7tC926ZP4qW7MEhYiZMHz6uGONARlsUivZqa0x7yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bjslh463Bz27j27;
	Fri, 18 Jul 2025 09:34:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B336140295;
	Fri, 18 Jul 2025 09:33:25 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 09:33:24 +0800
Message-ID: <f332bc85-4220-4285-9c26-b053bcac5f02@huawei.com>
Date: Fri, 18 Jul 2025 09:33:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: mcast: Delay put pmc->idev in mld_del_delrec():
 manual merge
To: Matthieu Baerts <matttbe@kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <ap420073@gmail.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>
References: <20250714141957.3301871-1-yuehaibing@huawei.com>
 <8cc52891-3653-4b03-a45e-05464fe495cf@kernel.org>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <8cc52891-3653-4b03-a45e-05464fe495cf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/17 22:41, Matthieu Baerts wrote:
> Hi Yue, Paolo, Jakub,
> 
> On 14/07/2025 16:19, Yue Haibing wrote:
>> pmc->idev is still used in ip6_mc_clear_src(), so as mld_clear_delrec()
>> does, the reference should be put after ip6_mc_clear_src() return.
> 
> FYI, I got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
> 
>   ae3264a25a46 ("ipv6: mcast: Delay put pmc->idev in mld_del_delrec()")
> 
> and this one from 'net-next':
> 
>   a8594c956cc9 ("ipv6: mcast: Avoid a duplicate pointer check in
> mld_del_delrec()")
> 
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.

Sorry for the inconvenience.
> 
> The conflict has been resolved on our side[1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
> 
> Regarding this conflict, the patch from net has been applied at a
> slightly different place after the code refactoring from net-next.
> 

This resolution looks good to me.

> Rerere cache is available in [2].
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/commit/ec9d9e40de20
> [2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/fe71
> 
> Cheers,
> Matt

