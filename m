Return-Path: <netdev+bounces-173763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE071A5B952
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16E47A283E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21061EEA23;
	Tue, 11 Mar 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="d2bDrcIq"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DA211C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675158; cv=none; b=WjtHzwvB82wFJwoA2647OL1ycamsuYq2V2siP/iq4BuKyORBX7i3re1aEQoTtpB+rRWb2sXA4dxpE0opn9M80uTy3eAHXq9UkKFucZrxxEJVM7srmEiD1NHivftB5YQHvf7tT5zYB8ibMy4vHhPIOpRJqATv2vmJej2y4Cp9qFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675158; c=relaxed/simple;
	bh=XG1c1cGStfPdiBuwzXojaWrRiC1+oYBctLpWG9xbIyI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=piFug4CmMacvFdwMTT2ukK4i6rSQes/mHbyEuqLPNB0mYIg+XWcIEUG8v2YRwfNSXSAtt0oaeAKc5PepEmg4/u9AAHh1owEDnHaFXp39ReExQJ02CBg7r0xmQYSOWMfhguC8PnQsmEM5FAyJimQ+49D6/EwQUNws3MjKp72M1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=d2bDrcIq; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=02DYpvLHJAWv22fy1EHfiqsfExWfji2mzzpVDA64zQQ=; b=d2bDrcIqgMGCxQ/7GxH/oerAd9
	7mLzeGIxIHCMfE+PQiU6omUO6pumXQzHbIy0Ud0BpwaJR0e+lTgoroZr36ubHgBHeHO0etoCq6w9u
	s+BDJTBms74mVpoO1fENUPerb6FxvYJ/zjBDMmgxrowcaIQ3s1tGT7/vtDUs0QnLcT9U=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1trsKk-000000001YN-1bVc;
	Tue, 11 Mar 2025 06:39:18 +0100
Message-ID: <0034e97b-db94-48f9-9a89-838f1ea4e479@engleder-embedded.com>
Date: Tue, 11 Mar 2025 06:39:17 +0100
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
 <53b21122-f077-46f6-8059-d1d87f66a3e7@engleder-embedded.com>
 <4a48d205-5026-4ec9-aa8b-bc1459641d33@lunn.ch>
 <3c9efd22-03b3-4368-b3c2-cdf349032832@engleder-embedded.com>
Content-Language: en-US
In-Reply-To: <3c9efd22-03b3-4368-b3c2-cdf349032832@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 07.03.25 20:15, Gerhard Engleder wrote:
> On 07.03.25 17:27, Andrew Lunn wrote:
>> On Thu, Mar 06, 2025 at 06:58:20AM +0100, Gerhard Engleder wrote:
>>> On 04.03.25 21:00, Gerhard Engleder wrote:
>>>> On 04.03.25 17:15, Jakub Kicinski wrote:
>>>>> On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
>>>>>> The current IOCTL interface is definitely too limiting for what Lee
>>>>>> will need. So there is a netlink API coming soon. Should Gerhard and
>>>>>> Jijie try to shoehorn what they want into the current IOCTL handler,
>>>>>> or help design the netlink API? How can selftest.c be taken apart and
>>>>>> put back together to make it more useful? And should the high level
>>>>>> API for PRBS be exported through it, making it easier to use for any
>>>>>> netdev?
>>>>>
>>>>> As we think about this let's keep in mind that selftests are generic,
>>>>> not PHY-centric. Even if we can pass all link settings in there are
>>>>> other innumerable params people may want in the future.
>>>>
>>>> My patchset can be divided into two parts:
>>>> 1) Extend phy_loopback() to select a defined speed
>>>> 2) Extend tsnep selftests to get some in-kernel test coverage for the
>>>>      phy_loopback() extension
>>>>
>>>> This discussion is related to the selftest rework of the second part.
>>>> Would it be ok to put the first part into a separate patchset, as this
>>>> changes make sense and work even without the selftests?
>>>
>>> Andrew, is it ok to put phy_loopback() extension to a separate patch
>>> set?
>>
>> Without the selftest part, the phy loopback changes go unused. We
>> don't normally add APIs without a user. So i would say no, it should
>> be all or nothing. I don't think it will cause many problems if these
>> patches need to wait a while, a rebase should be easy, this area of
>> phylib is pretty stable.
> 
> Why no user? The tsnep driver is the user to get loopback again working
> after 6ff3cddc365b ("net: phylib: do not disable autoneg for fixed
> speeds >= 1G"). The phy_loopback changes are used by
> tsnep_phy_loopback().
> 
> Thanks to your comments it is also an improvement of the loopback
> behavior, as now loopback signals the new speed like a normal link up.

Is it ok for you the put the phy_loopback() extension with loopback fix
for the tsnep driver to a separate patch set?

Gerhard

