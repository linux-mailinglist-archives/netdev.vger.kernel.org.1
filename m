Return-Path: <netdev+bounces-263800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADewMWwjqGl3ogAAu9opvQ
	(envelope-from <netdev+bounces-263800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:19:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEAF1FF99B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7D0303EC3A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906A23F26A;
	Wed,  4 Mar 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MVhNYwAR"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F336884
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626673; cv=none; b=QZkqC752cQIB75y+ZDO6WsAOsVe40e9zrP1MOQznuoLUm4RZs0lVXFvK6PAEP+gbhVrfJshiKYy4iUwX449EB8+Bh+/J0e9xTvPAqltU3uN577TagWpJ2dFb+O1ddQrgx1agh1f7u0F2aDrQuNRuTsZPb4SpPyXG6x4cLoleWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626673; c=relaxed/simple;
	bh=POCV8JaymNScyiai3RphyoFmi0IjfXAolvC5ruoI32k=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lBFa359I8ayFT7UOLiOMfi3e4rSI9/6bs1Nk1vovw3iYz5ksVBBcHy6rQ3mt/wI1A408Qs5Yg9yy9jnvkIHJQsjmhEtdqY+cQKL498XEAuco8Cy+sZezbTlEvI2/sfjFUImsHgVk72pnqWGYArEnLkwTSEse4hmTVujlH0qus1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MVhNYwAR; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WTCkzXr8IJyYwxxrufKTwxw++AWw05Y+lvv/LZr2SbU=;
	b=MVhNYwARwZFJqby7/VOJtPXWC7CasZNm99haPHGSKK2hYltR4JsOZu5QkDxNKllaa+ISsfRjf
	oIEDZzEyGNwzDdXR4N98HyomdB5McqY6rbqFs4vzj4wrKsfuDKnBowZ1VePA9acr1iUsO6apGVc
	uPnnGT3iQ/ekdZiAVq6NhDE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fQs485NWzzcZyH;
	Wed,  4 Mar 2026 20:12:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 86584202D3;
	Wed,  4 Mar 2026 20:17:38 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 4 Mar 2026 20:17:37 +0800
Message-ID: <259cd032-2ccb-452b-8524-75bc7162e138@huawei.com>
Date: Wed, 4 Mar 2026 20:17:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>
Subject: Re: [PATCH net 04/11] MAINTAINERS: remove Salil Mehta from HiSilicon
 network drivers
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
References: <20260303215339.2333548-1-kuba@kernel.org>
 <20260303215339.2333548-5-kuba@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260303215339.2333548-5-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: ACEAF1FF99B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263800-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,hisilicon.com:url,linuxtag.org:email]
X-Rspamd-Action: no action


on 2026/3/4 5:53, Jakub Kicinski wrote:
> We have not seen tags from Salil for HiSilicon network drivers
> in over 5 years. He is active upstream in other subsystems
> (KVM/ARM64 vCPU hotplug). Jian Shen and Jijie Shao are active
> in HNS3, and the review coverage is good (55%).

Hi Jakub,

Thanks for the update. I would like to clarify that Salil is a co-author of HNS3/HNS driver
and still remains our active MAINTAINER.

Based in our Cambridge, UK office, Salil has been away for extended periods recently due to a challenging personal situation.
This explains his recent lack of tags or direct networking contributions; he was outside the UK for much of this time
and had limited access to our Cambridge hardware labs. However, he continued to contribute to other areas like virtualization
where hardware dependency (especially the extensive hardware setup required for networking) was not an factor.

Despite his limited availability, he has been reviewing code in the background and working with our HQ team on HNS3 enhancements,
including performance improvements and XDP support. Many of these patches are currently pending and will be submitted soon.
We expect him to return to full capacity in mid-March, and his networking expertise remains deeply valued by Huawei.

We request that you keep him on the MAINTAINER list so he remains in the loop for all HNS3/HNS driver communications.

Thanks for your understanding.

Best regards,
Jijie Shao


>
> Subsystem HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
>    Changes 69 / 125 (55%)
>    Last activity: 2026-02-06
>    Jian Shen <shenjian15@huawei.com>:
>      Author 6d2f142b1e4b 2026-02-06 00:00:00 22
>      Tags 6d2f142b1e4b 2026-02-06 00:00:00 26
>    Salil Mehta <salil.mehta@huawei.com>:
>    Jijie Shao <shaojijie@huawei.com>:
>      Author 6a0fc0ea61bd 2026-01-27 00:00:00 19
>      Tags 6d2f142b1e4b 2026-02-06 00:00:00 97
>    Top reviewers:
>      [30]: horms@kernel.org
>      [12]: andrew@lunn.ch
>      [10]: arnd@arndb.de
>      [5]: michal.swiatkowski@linux.intel.com
>      [4]: jacob.e.keller@intel.com
>    INACTIVE MAINTAINER Salil Mehta <salil.mehta@huawei.com>
>
> Subsystem HISILICON NETWORK SUBSYSTEM DRIVER
>    Changes 108 / 200 (54%)
>    Last activity: 2026-02-06
>    Jian Shen <shenjian15@huawei.com>:
>      Author 6d2f142b1e4b 2026-02-06 00:00:00 22
>      Tags 6d2f142b1e4b 2026-02-06 00:00:00 26
>    Salil Mehta <salil.mehta@huawei.com>:
>    Top reviewers:
>      [52]: horms@kernel.org
>      [17]: shaojijie@huawei.com
>      [16]: andrew@lunn.ch
>      [10]: arnd@arndb.de
>      [6]: jacob.e.keller@intel.com
>      [6]: michal.swiatkowski@linux.intel.com
>    INACTIVE MAINTAINER Salil Mehta <salil.mehta@huawei.com>
>
> Add Salil to CREDITS as the initial author of HNS3.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Cc: shenjian15@huawei.com
> Cc: salil.mehta@huawei.com
> Cc: shaojijie@huawei.com
> ---
>   MAINTAINERS | 2 --
>   CREDITS     | 4 ++++
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49eb81ec3709..b9b8a7695ddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11527,7 +11527,6 @@ F:	drivers/bus/hisi_lpc.c
>   
>   HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
>   M:	Jian Shen <shenjian15@huawei.com>
> -M:	Salil Mehta <salil.mehta@huawei.com>
>   M:	Jijie Shao <shaojijie@huawei.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> @@ -11542,7 +11541,6 @@ F:	drivers/net/ethernet/hisilicon/hibmcge/
>   
>   HISILICON NETWORK SUBSYSTEM DRIVER
>   M:	Jian Shen <shenjian15@huawei.com>
> -M:	Salil Mehta <salil.mehta@huawei.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   W:	http://www.hisilicon.com
> diff --git a/CREDITS b/CREDITS
> index d74c8b2b7ed3..98aaf196567a 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2770,6 +2770,10 @@ E: merker@linuxtag.org
>   D: DECstation framebuffer drivers
>   S: Germany
>   
> +N: Salil Mehta
> +E: salil.mehta@huawei.com
> +D: Upstreaming of the HiSilicon HNS3 network driver
> +
>   N: Michael Meskes
>   E: meskes@debian.org
>   P: 1024/04B6E8F5 6C 77 33 CA CC D6 22 03  AB AB 15 A3 AE AD 39 7D

