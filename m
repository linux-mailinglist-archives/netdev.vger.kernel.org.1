Return-Path: <netdev+bounces-173075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DEA57168
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861711673BE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE79253357;
	Fri,  7 Mar 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="GnM3im4z"
X-Original-To: netdev@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A6253F06
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374964; cv=none; b=N9kZ7aeuMq953F8Cr8/DcjdYMuFNK95jrse5HG3DsAOjISE09DOzddLrYurJ4JnbmtHCatLfgKIxX8CDXmVYRhZFkiKleHyQOtobkIDHCrWhTlYqXCH4nnsJpLb1RpWBDN8EBvf83BQoFbQyn75VKpmDTuzMjBQwV10sSoFD8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374964; c=relaxed/simple;
	bh=GexECdyv/eXHysswI3gD960gVjSAHLQ4D0+HToYu81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEsUU1NRferyGiEegb5nVHHiWUoiLkdeBVJ6pIkeYSqCEOqxuEwyCP0mn6SEP2rDN/N5pqWNg01Az5fF+dWslgYvl5EkM6N1g/pnQ88wNsITnQ1M1WcVuM/Ev6sfmM3519Gr+TEFtU8fnBMmYqZJtU2BOzD/xfcqUiTp87OyClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=GnM3im4z; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C2gQz8qIIksPV+SXU8BuX+fzAWzB6chvdQTiMZ8Spqc=; b=GnM3im4zo2dieBeSA5oc6LrJdB
	UjxPBABIbVEOsWwj7wfzOgr0/5AiUCiAWQjpzMdF7RsMSIo7vwXgGk3gBX3vx8pZoH/FleH8lB4Hy
	BjcOvzgg0KhcVZ5gNj09Fj2SQJALhhUEGJDvKO5j5OoC9FxD5nq4Qy6kIkiATwQxzhe8=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tqdAk-000000006YC-4ABz;
	Fri, 07 Mar 2025 20:15:51 +0100
Message-ID: <3c9efd22-03b3-4368-b3c2-cdf349032832@engleder-embedded.com>
Date: Fri, 7 Mar 2025 20:15:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for PHY
 loopback
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
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <4a48d205-5026-4ec9-aa8b-bc1459641d33@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 07.03.25 17:27, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 06:58:20AM +0100, Gerhard Engleder wrote:
>> On 04.03.25 21:00, Gerhard Engleder wrote:
>>> On 04.03.25 17:15, Jakub Kicinski wrote:
>>>> On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
>>>>> The current IOCTL interface is definitely too limiting for what Lee
>>>>> will need. So there is a netlink API coming soon. Should Gerhard and
>>>>> Jijie try to shoehorn what they want into the current IOCTL handler,
>>>>> or help design the netlink API? How can selftest.c be taken apart and
>>>>> put back together to make it more useful? And should the high level
>>>>> API for PRBS be exported through it, making it easier to use for any
>>>>> netdev?
>>>>
>>>> As we think about this let's keep in mind that selftests are generic,
>>>> not PHY-centric. Even if we can pass all link settings in there are
>>>> other innumerable params people may want in the future.
>>>
>>> My patchset can be divided into two parts:
>>> 1) Extend phy_loopback() to select a defined speed
>>> 2) Extend tsnep selftests to get some in-kernel test coverage for the
>>>      phy_loopback() extension
>>>
>>> This discussion is related to the selftest rework of the second part.
>>> Would it be ok to put the first part into a separate patchset, as this
>>> changes make sense and work even without the selftests?
>>
>> Andrew, is it ok to put phy_loopback() extension to a separate patch
>> set?
> 
> Without the selftest part, the phy loopback changes go unused. We
> don't normally add APIs without a user. So i would say no, it should
> be all or nothing. I don't think it will cause many problems if these
> patches need to wait a while, a rebase should be easy, this area of
> phylib is pretty stable.

Why no user? The tsnep driver is the user to get loopback again working
after 6ff3cddc365b ("net: phylib: do not disable autoneg for fixed
speeds >= 1G"). The phy_loopback changes are used by
tsnep_phy_loopback().

Thanks to your comments it is also an improvement of the loopback
behavior, as now loopback signals the new speed like a normal link up.

Gerhard

