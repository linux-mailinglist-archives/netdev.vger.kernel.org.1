Return-Path: <netdev+bounces-186121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA0A9D3F5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0473ADBF8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD7224AFC;
	Fri, 25 Apr 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="EIqyTlxX"
X-Original-To: netdev@vger.kernel.org
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D5224AE6;
	Fri, 25 Apr 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615405; cv=none; b=BNyHMBQcN5wQWspbP05WEU371LZwzy3waP5IayAJ3iAeYpD95wlB2u3KPqzB2Ag+qST8DJxgrcR78OM3c/JhFQxCGnxziGuuDBlxpIsiAQonxZuMbmqly0+Fne9RDdXb15I4Jv3Ussti1uBah0ZLm/tpSYZmw0KA0NXrS4CR3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615405; c=relaxed/simple;
	bh=i7IbPiakB7vpTLjK9gupk8hrsHLDntK7oG/06/Usdak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ylj2Zho7EK4CkKNzUYBoIcRKi/a/FOHSVQ6rWbdgrTF74cF0tToK1g09Iwq+/QGTsQ+rMUq8t3sm6rxUyQNjIGcsZzQ/sDvipfIEvuWZ8fevmWHMAF+sqi1nrcE1a9oFMrB6leVWSa1gcaciEAJ/vPNsSb3pavH4pODM0EHOg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=EIqyTlxX; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U2PlbSYJoDqGmlBnxEFPhzu2SoY19RbUjb4TC95q0os=; b=EIqyTlxX3Nc8I3nDrfhAQrxBF1
	iFoESpbBgtB7fFarOuSBVC4vSpLvEjSUfpTT0/pBGvYSUqp+t/dIOHxHjcaPOuDDLBCz/qqyAc5a7
	/UupZVwcTgYGbu8Dd6WRyA9kXC/JAaJWqa/hh864eVu3hPa56NRo0Tq60+5umqBr2cE8=;
Received: from [188.22.4.210] (helo=[10.0.0.160])
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1u8PSV-000000006I9-2m9q;
	Fri, 25 Apr 2025 22:15:39 +0200
Message-ID: <31a7c481-0b0c-4a46-9eb9-983f88ca137e@engleder-embedded.com>
Date: Fri, 25 Apr 2025 22:15:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: selftest: add net_selftest_custom()
 interface
To: Jijie Shao <shaojijie@huawei.com>
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250421134358.1241851-1-shaojijie@huawei.com>
 <20250421134358.1241851-2-shaojijie@huawei.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250421134358.1241851-2-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 21.04.25 15:43, Jijie Shao wrote:
> In net/core/selftests.c,
> net_selftest() supports loopback tests.
> However, the loopback content of this interface is a fixed common test
> and cannot be expanded to add the driver's own test.
> 
> In this patch, the net_selftest_custom() interface is added
> to support driver customized loopback tests and
> extra common loopback tests.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>   include/net/selftests.h |  61 +++++++++++++
>   net/core/selftests.c    | 188 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 245 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/selftests.h b/include/net/selftests.h
> index e65e8d230d33..a36e6ee0a41f 100644
> --- a/include/net/selftests.h
> +++ b/include/net/selftests.h
> @@ -4,6 +4,48 @@
>   
>   #include <linux/ethtool.h>
>   
> +#define NET_TEST_NETIF_CARRIER		BIT(0)
> +#define NET_TEST_FULL_DUPLEX		BIT(1)
> +#define NET_TEST_TCP			BIT(2)
> +#define NET_TEST_UDP			BIT(3)
> +#define NET_TEST_UDP_MAX_MTU		BIT(4)
> +
> +#define NET_EXTRA_CARRIER_TEST		BIT(0)
> +#define NET_EXTRA_FULL_DUPLEX_TEST	BIT(1)
> +#define NET_EXTRA_PHY_TEST		BIT(2)

What is the difference between NET_TEST_NETIF_CARRIER and
NET_EXTRA_CARRIER_TEST? Aren't these the same tests?

> +struct net_test_entry {
> +	char name[ETH_GSTRING_LEN];
> +
> +	/* can set to NULL */
> +	int (*enable)(struct net_device *ndev, bool enable);
> +
> +	/* can set to NULL */
> +	int (*fn)(struct net_device *ndev);
> +
> +	/* if flag is set, fn() will be ignored,
> +	 * and will do test according to the flag,
> +	 * such as NET_TEST_UDP...
> +	 */
> +	unsigned long flags;

Looks limited, this interface does not scale as the bits in flags are
limited.

> +};
> +
> +#define NET_TEST_E(_name, _enable, _flags) { \
> +	.name = _name, \
> +	.enable = _enable, \
> +	.fn = NULL, \
> +	.flags = _flags }
> +
> +#define NET_TEST_ENTRY_MAX_COUNT	10

I expect that you have to eliminate this limitation too.

> +struct net_test {
> +	/* extra tests will be added based on this flag */
> +	unsigned long extra_flags;

Why this extra_flags to trigger tests? AFAIU the same tests can be
triggered with entries.

> +
> +	struct net_test_entry entries[NET_TEST_ENTRY_MAX_COUNT];
> +	/* the count of entries, must <= NET_TEST_ENTRY_MAX_COUNT */
> +	u32 count;
> +};

You try to make net selftests more usable for drivers. I also tried
that, but Andrew Lunn argumented for controlling the selftests some
user space interface is expected. IMO the situation has not changed.

https://lore.kernel.org/netdev/20250227203138.60420-3-gerhard@engleder-embedded.com/T/#md5e4ac1ca41adbdb43755d3c189aa8b8228bf8c9

Gerhard

