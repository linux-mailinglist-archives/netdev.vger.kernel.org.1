Return-Path: <netdev+bounces-93152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336028BA4F0
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 03:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0E21F22EE5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F7DDC0;
	Fri,  3 May 2024 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sj4Ds6Rt"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075E8F47
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700111; cv=none; b=JRz5sCT/dqyxXW5ivGEIPkH9IdtrjFUton2N0a9rOfDI46lyfn+Ooeb5e6FqQzHc3x5Ke0L24csk7+ScEFd3j5AmtZ7owyVn7mV3gmR71SKXVfaBJJV/VcK9eFwuF1LP0k72NEKLXHQMmw9D8LE9UpFms4CfXZHzVGalI69Fex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700111; c=relaxed/simple;
	bh=chZsNMrhJXmyK1K058MWsuP+ZJXH+HJDh37GOwngCyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvSYbwePc269HxFFVirN20eVOpoW7SS2fdmzAZP6Pw5SOkgJ4ryMxzLfZLOuEhVu0de1j4OZlfMpTUwQxq6+dQZy3BpIwGLBb4+h4A7+Pw1lpFYmHlDonOAPwh+mh2I21qPMOzZYobzzzNDKlYOeBeMonqBiwC4u9/X6m7haK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sj4Ds6Rt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 05E61882D0;
	Fri,  3 May 2024 03:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714700106;
	bh=lRMYB608pHOQXaroRp+MnXD7SNgMYXh4kgpmuAotReU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sj4Ds6RtjmU3x8OKabJ/q3FfNh8kQELK6WkANoGVv0apZCMCZL+tGSbAfZaS7T5DM
	 8vTtaueMLABvCrJc3Lxxi26W18/ugd5oYNO8H70xiW6IgtX+Iyk+ro11sOcb+JDuAX
	 ETFapHY8RDy3Ctv60PXqHEhuWrhkwJukIdn7f3ejrVrsNshfRndFxedAAyhXK3IqY1
	 okPqaYMtmwBd8A8HGJvlO+d3Q/LHnILTjB8CRVT6s1LPVOdiploE3UIAmm2F+MrSUo
	 lufkaM0SFksVGtmDpD4exdcuUsxuz/1skpvFQkYkTdQMeNV+/CrWqjS5DM87CuYbBW
	 KsNFpMkmVpKrw==
Message-ID: <86a14471-4bda-471d-ab08-90d4ccd0802d@denx.de>
Date: Fri, 3 May 2024 02:47:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Queue RX packets in IRQ handler
 instead of disabling BHs
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240430194401.118950-1-marex@denx.de>
 <20240430191042.05aad656@kernel.org>
 <CANn89iLKQjD1bxbirwtvzxsfOa-i2qRTGHYH_8_8O-xCusypQQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CANn89iLKQjD1bxbirwtvzxsfOa-i2qRTGHYH_8_8O-xCusypQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/1/24 4:39 AM, Eric Dumazet wrote:
> On Wed, May 1, 2024 at 4:10 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 30 Apr 2024 21:43:34 +0200 Marek Vasut wrote:
>>> diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
>>> index 31f75b4a67fd7..f311074ea13bc 100644
>>> --- a/drivers/net/ethernet/micrel/ks8851.h
>>> +++ b/drivers/net/ethernet/micrel/ks8851.h
>>> @@ -399,6 +399,7 @@ struct ks8851_net {
>>>
>>>        struct work_struct      rxctrl_work;
>>>
>>> +     struct sk_buff_head     rxq;
>>>        struct sk_buff_head     txq;
>>>        unsigned int            queued_len;
>>
>> One more round, sorry, this structure has a kdoc, please fill in
>> the description for the new member.
> 
> Alternative is to use a local (automatic variable on the stack) struct
> sk_buff_head,
> no need for permanent storage in struct ks8851_net

I think that's even better, done in V3 + addressed feedback from Jakub.

