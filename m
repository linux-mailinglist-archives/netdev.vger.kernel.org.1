Return-Path: <netdev+bounces-171828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C3A4EE00
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EB93AA4D3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B801F63D6;
	Tue,  4 Mar 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="rCPitnJa"
X-Original-To: netdev@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166C1FA243
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118442; cv=none; b=oJUfQl49WR41tMsqC8QJUF1TUo+9t8RI/L0JrJAFScNi7K5N1OZmSz5ASDfs7ll9XV9QDOI5XuVH6Em6Mwyp02j8ucfKoICtHNFTi3LWcM+Mwl4z4LQ3rirzofqfDnTyReuJ+lDqQaTwuMp/nJ8z0KYCdITYDiBH7F7NwsAWy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118442; c=relaxed/simple;
	bh=CX39I5OeaX9sp2H2PEK3tF0kltrytxZjf4cYDJGYg6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igmwVquhImpP+E3lZj4I3IIdJZSFLVjMZvvTI4XTZAJRwCR4QAv5iuMmA3RL0NC5qsEY6dPDGm7k4vFJcUv8ljWvxlf/uU5/hCnC9dMHyCTPeGVRr3k1QX9SMPUESfRIZvq193nri08uDyDrpGqyWohl4JmoisS7Pr4XlE2TSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=rCPitnJa; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7dM1cYlCKaPVj012wBMKZgOzWHvXw147ReawTFwiLZ8=; b=rCPitnJaUdLtddn+0ug4SMGHnO
	/N9LRIfGo4gnDB7Brau3rYr/CSXPYI6jKo7Kq9q0/Fch8zE4yxCM2gjKZ+6zN8nSNARWAWGKtzaPf
	+ZYyk49Dp3A991XDyoz1aqO2BhsHgcQIC4iqSPlbzn81YYp5UwxsZNWr8Ei6Lz7bnYls=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tpYRM-000000007cl-0kmJ;
	Tue, 04 Mar 2025 21:00:32 +0100
Message-ID: <1d56eaf3-4d8c-40da-8a10-a287f09553e6@engleder-embedded.com>
Date: Tue, 4 Mar 2025 21:00:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for PHY
 loopback
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Jijie Shao <shaojijie@huawei.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, ltrager@meta.com,
 linux@armlinux.org.uk
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
 <20250227203138.60420-3-gerhard@engleder-embedded.com>
 <20250303173500.431b298e@kernel.org>
 <3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
 <20250304081502.7f670381@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250304081502.7f670381@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 04.03.25 17:15, Jakub Kicinski wrote:
> On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
>> The current IOCTL interface is definitely too limiting for what Lee
>> will need. So there is a netlink API coming soon. Should Gerhard and
>> Jijie try to shoehorn what they want into the current IOCTL handler,
>> or help design the netlink API? How can selftest.c be taken apart and
>> put back together to make it more useful? And should the high level
>> API for PRBS be exported through it, making it easier to use for any
>> netdev?
> 
> As we think about this let's keep in mind that selftests are generic,
> not PHY-centric. Even if we can pass all link settings in there are
> other innumerable params people may want in the future.

My patchset can be divided into two parts:
1) Extend phy_loopback() to select a defined speed
2) Extend tsnep selftests to get some in-kernel test coverage for the
    phy_loopback() extension

This discussion is related to the selftest rework of the second part.
Would it be ok to put the first part into a separate patchset, as this
changes make sense and work even without the selftests?

For the selftests IMO Jijie Shao and me should try to extend
net/core/selftests in a generic way for both drivers. There shall not be
multiple "send, receive and check skb" implementations in various
drivers. Andrew suggested to make the selftests generic enough to let
others benefit. To prove that, Jijie Shao needs to be able to use the
new selftest sets.

For me it is ok to keep back these selftests until a new netlink API is
available. I feel not comfortable to design a new netlink API as I have
no need to make the selftests configurable by user space like Lee
Trager.

So what to do with these selftests?
Hold back until new netlink API?
Rework them to only support the "send, receive and check skb" case
without any PHY stuff and use it in tsnep and hibmcge?
Keep them as they are as new test sets and parameters can be added
in the future if needed?

Gerhard

