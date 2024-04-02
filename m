Return-Path: <netdev+bounces-84129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA60895AF3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D323DB244B2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6150215A4A9;
	Tue,  2 Apr 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KX/tMefD"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECE14B067
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079787; cv=none; b=DWpTvLxEOyFbXWxw4GjyEopfNTQGI7/RGcJRwv7ThdSISNTYaF1ue7cvciyosI3IEO4vcYCCyfI/soi8CJumiNNmwaxxeGs5sfSTcHcC09YvmUDCjrPk8bnXXzMMIO/f8HLMIs4IfzKE5iJkgcoBie8E7Ijiu9FGNe9j67IEaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079787; c=relaxed/simple;
	bh=qULtEbwf7vQUHN1n4fM/eLDPXBWHRFBAWL7nqHwMEzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u14HBYH2e3xVqWl6F2QDL+KHHYlQdAOvRd2+LPdvOfbv4rP5U5kCMocxakZNYrGTHcuxg/htw5Z3F2ql+FWeWbcC+pl7QjUH5w75v23w+P3KCViBMY/s5SGalZOH4GV/8E92wHwHJ6fGKaiCb42y5751Yq+BoVrMwfEF3y7XDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KX/tMefD; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3DB6487E9D;
	Tue,  2 Apr 2024 19:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712079783;
	bh=Ahr+5711Jce761c0X40FLjs6XFIBuoUhD5QP3kko5no=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KX/tMefDw8UfH1a9CndtlJDyLoUorULm3wao99kHh4EiZxiXt7bbD2oqTKBL8GLu0
	 LI+QrVp4xtsuQYaywy7Ovo80BSDIsqGbgZugT5MhB9T+JHImyrNxT2F73ZQ6X6IrdJ
	 I6kaCWsDkJ92BAUVKcRPFG6YlP0/RUKqv9pJiWKOgeQ71kTtexuvje2y2G4/3+ZOPV
	 iD6lSxWcsWdDiyE/AcdibREbC4nRtgPTntKBrd5ZE0WADIkNlZhqq4g/zjAZduNrwn
	 qM6tiy4ghv7L/GK6dcGCxgPBGJ7dTpczplSx7p/hHghTEjdL9KgasyslnqRPnTs9rd
	 CfrOcOjsiPkzQ==
Message-ID: <37aef988-4bb3-4175-a9a8-28559706d981@denx.de>
Date: Tue, 2 Apr 2024 19:29:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] net: ks8851: Handle softirqs at the
 end of IRQ thread to fix hang
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
 <20240401041810.GA1639126@maili.marvell.com>
 <09dd9be4-a59e-472f-81fc-7686121a18bf@denx.de>
 <MWHPR1801MB191894EAC71A311B0115C69AD33F2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <MWHPR1801MB191894EAC71A311B0115C69AD33F2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/1/24 4:13 PM, Ratheesh Kannoth wrote:
>> From: Marek Vasut <marex@denx.de>
>> To: Ratheesh Kannoth <rkannoth@marvell.com>
>> Cc: netdev@vger.kernel.org; David S. Miller <davem@davemloft.net>; Uwe
>> This test here has been taken from net/core/dev.c netif_rx() , it is the same
>> one used there around __netif_rx() invocation.
>>
>>>>    	struct ks8851_net *ks = _ks;
>>>>    	unsigned handled = 0;
>>>>    	unsigned long flags;
>>>>    	unsigned int status;
>>>>
>>>> +	if (need_bh_off)
>>>> +		local_bh_disable();
>>> This threaded irq's thread function (ks8851_irq()) will always run in process
>> context, right ?
>>
>> I think so.
>>
>>> Do you need "if(need_bh_off)" loop?
> My bad. Typo. I meant "if (need_bh_off) statement"; not "loop".
> 
>> It is not a loop, it is invoked once. It is here to disable BHs so that the
>> net_rx_action BH wouldn't run until after the spinlock protected section of the
>> IRQ handler. Te net_rx_action may end up calling ks8851_start_xmit_par,
>> which must be called with the spinlock released, otherwise the system would
>> lock up.
> I understand that. My question - will there be a case (currently, without this patch)  ks8851_irq()
> Is called after disabling local BH.  If it is always called without disabled, can we avoid "if" statement.
> altogether?

Aha, I think that makes sense and yes, we can drop the if statement 
altogether. I'll add that into V2.

