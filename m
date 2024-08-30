Return-Path: <netdev+bounces-123561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4296550A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EB281B1D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAC157E62;
	Fri, 30 Aug 2024 02:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A52139D1E
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983396; cv=none; b=UBWBOYMtOAkZFB9WL6e9E2Q+jDYtPwMKlJSRmXyNCPVRS60jRUvD4+nWT7593ZvPjGu8j4Xak9iak2Qei6FByw8ti6Jd+zRwTPbQuNKx99lt9ddV/Lp4xX1xYaEaqZkN5vHxgogTtmqFBJLKX1o7Mg9c4+JeU7eC2+AYyzL1rjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983396; c=relaxed/simple;
	bh=DgmROvqmgkTcyZ2ygqOSZvy3I+dgBHZB2+ldPHzhU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TF78xX/QeUaPzr5Tm/z1B1EJMep5XCDaWPF/iO/SwcRoG5sOlCx630mVbw2BH9D7nlhgZKqPrwMGSsdYnH+LAeDyTrCEQuzFVplNk0ci9Uw2RzqAE/sWCWzWEAYe3T2uK4cmRb7RQkI+BimjSMrkPSitW7JpFiKs9GqopKEZ1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww1dG6JdBz2Dbc4;
	Fri, 30 Aug 2024 10:02:58 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 47C7C1A0188;
	Fri, 30 Aug 2024 10:03:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 10:03:10 +0800
Message-ID: <bb3adb21-c39d-7873-8eb0-32ba5591adad@huawei.com>
Date: Fri, 30 Aug 2024 10:03:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v3 00/13] net: Simplified with scoped function
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <woojung.huh@microchip.com>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>,
	<justin.chen@broadcom.com>, <sebastian.hesselbarth@gmail.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>,
	<mcoquelin.stm32@gmail.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<ansuelsmth@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<krzk@kernel.org>, <jic23@kernel.org>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <25cef928-6b26-447e-8106-77db0aa5954b@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <25cef928-6b26-447e-8106-77db0aa5954b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/29 20:43, Andrew Lunn wrote:
> On Thu, Aug 29, 2024 at 02:31:05PM +0800, Jinjie Ruan wrote:
>> Simplify with scoped for each OF child loop and __free(), as well as
>> dev_err_probe().
> 
> I said the for_each_child_of_node_scoped() parts are fine. The
> __free() parts are ugly, and i would like to reject them. So please
> post just the for_each_child_of_node_scoped() parts for merging, while
> we discuss what to do about __free().

Sure.

> 
>     Andrew
> 
> ---
> pw-bot: cr

