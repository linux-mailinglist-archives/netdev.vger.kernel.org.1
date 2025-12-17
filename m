Return-Path: <netdev+bounces-245146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBACC87CA
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF5930A477B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C134678D;
	Wed, 17 Dec 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="C+oXNFCc"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FE3451AA;
	Wed, 17 Dec 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976529; cv=none; b=amxUYumcCMDkZiaaVwq/1xwTOfq3mt1qFrn34tJ8N25gbjH530M+2qLyauQtLueNsdptpMdag3pp7Js8RjRxqQ0/qSd6tIlIEjPwGGAv00sdAlYXcJuzS75NTJMoQvFcu6/wo2RSmc5iihorazJTYmTvTi10XX7iGO/CEs5Z3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976529; c=relaxed/simple;
	bh=qCzVZQzuBUhcKrdr3i5HGoKQonpCi+4q03mjkRYS6qE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aCuARRTGo01r0yX1ijp9WrDW9FyDw4iv0ec5nmZZ7JI0+DiF98uEajxvPoWnn8fjoCUvPFw4jUVFkVL5Be7vG4ZjBoUNkZ9HRdosY3601jUgzWaKY+DnGrW0xgirW+i9kLY/Xx9V7tyuLDVL+2ajLts0O/gdIOQwX4gfQ1AdZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=C+oXNFCc; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qCzVZQzuBUhcKrdr3i5HGoKQonpCi+4q03mjkRYS6qE=;
	b=C+oXNFCc19FDH0lJFkNr09ZI4BxiTi/+CGUYnF9EsOQFoF6rICjSpSwOBSz5NP5TggDivbaBt
	mwvrqySjH6naq4yDj4ZpeG81NlNuwN2LXXzA5txJsYxvK1i/C07mYDtWVCtuvx0vSWyvz5wlsJ+
	aclQGGQf3CG530E5qYOxSjg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dWYlq3kdgzpSvn;
	Wed, 17 Dec 2025 20:59:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E226C140137;
	Wed, 17 Dec 2025 21:02:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 21:02:03 +0800
Message-ID: <6aed6675-fd0c-45fe-9780-d05156df639f@huawei.com>
Date: Wed, 17 Dec 2025 21:02:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 4/6] net: hibmcge: support get phy_leds_reg
 from spec register
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-5-shaojijie@huawei.com>
 <38e441ce-b67f-4ddb-940b-1e737a45225c@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <38e441ce-b67f-4ddb-940b-1e737a45225c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/16 15:19, Andrew Lunn wrote:
> On Mon, Dec 15, 2025 at 08:57:03PM +0800, Jijie Shao wrote:
>> support get phy_leds_reg from spec register,
> What is the spec register?

These are some MAC and PHY-related properties, such as MTU specifications, MDIO frequency, etc.,
similar to the properties in the device tree.
However, these properties come from the BAR space registers.

Thanks,
Jijie Shao


