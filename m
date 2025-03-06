Return-Path: <netdev+bounces-172310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10039A5427C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450D316371D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47919ABDE;
	Thu,  6 Mar 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="utTZLGjp"
X-Original-To: netdev@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB31990AB
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240716; cv=none; b=W9Qdnk7X4b32SNDkCOm1o7fcVyZg99azCkLqxR1BSGdBIi5hqDQI6S/VdAqDd85l0tMqE3faJOSkt9olo3aw5nt5iXLz+7/pFpVXuk3nAfqP7avajbi192Q8aLs5JDkoVH6KABgN37BqEChrR+ptbsY53+Ryk9Pal0YDEvp1uvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240716; c=relaxed/simple;
	bh=Y08lWFxfA5ZlJUChl1E72aaDMswb15rPqcsmkR3up5k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwLPRfTacb+y7fw9485pt2LFFdEi5g1k1uUqYJwmrCjuNo4aVOqdLMPVbEJ8SSfEiNQD5FKN+my4QLy1tRMofYa6X9NdU3ad1aIOjnBK9Z7Ek179wqiVQn3t5U8n5r2jmB2iwPUyN6FHMXefXfdA1ZCKtfojl4q+kJ0BU/lQlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=utTZLGjp; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X6uZZ65dWYF2R7ySVJMz4QMU1p0W/AuEGwp2A2yX2IA=; b=utTZLGjpipmRp6elf3ETViOJ5B
	HwonXrPwmGzdFHO0MxOtQTwMDu8xCkA2yrwEg8vqzBLItdI6zhWdXztMM1GlXJkZarxJeKVtdDbWS
	SJWk0YvjM/CEfhas2O/EAuTnzT2M/KQLi5FCPHvnmoAeYl9J//UtN/DpUtgmR3rxE2UY=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tq4FS-00000000375-0AOM;
	Thu, 06 Mar 2025 06:58:22 +0100
Message-ID: <53b21122-f077-46f6-8059-d1d87f66a3e7@engleder-embedded.com>
Date: Thu, 6 Mar 2025 06:58:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for PHY
 loopback
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, ltrager@meta.com,
 linux@armlinux.org.uk, Jakub Kicinski <kuba@kernel.org>,
 Jijie Shao <shaojijie@huawei.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
 <20250227203138.60420-3-gerhard@engleder-embedded.com>
 <20250303173500.431b298e@kernel.org>
 <3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
 <20250304081502.7f670381@kernel.org>
 <1d56eaf3-4d8c-40da-8a10-a287f09553e6@engleder-embedded.com>
Content-Language: en-US
In-Reply-To: <1d56eaf3-4d8c-40da-8a10-a287f09553e6@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 04.03.25 21:00, Gerhard Engleder wrote:
> On 04.03.25 17:15, Jakub Kicinski wrote:
>> On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
>>> The current IOCTL interface is definitely too limiting for what Lee
>>> will need. So there is a netlink API coming soon. Should Gerhard and
>>> Jijie try to shoehorn what they want into the current IOCTL handler,
>>> or help design the netlink API? How can selftest.c be taken apart and
>>> put back together to make it more useful? And should the high level
>>> API for PRBS be exported through it, making it easier to use for any
>>> netdev?
>>
>> As we think about this let's keep in mind that selftests are generic,
>> not PHY-centric. Even if we can pass all link settings in there are
>> other innumerable params people may want in the future.
> 
> My patchset can be divided into two parts:
> 1) Extend phy_loopback() to select a defined speed
> 2) Extend tsnep selftests to get some in-kernel test coverage for the
>     phy_loopback() extension
> 
> This discussion is related to the selftest rework of the second part.
> Would it be ok to put the first part into a separate patchset, as this
> changes make sense and work even without the selftests?

Andrew, is it ok to put phy_loopback() extension to a separate patch
set?

Gerhard

