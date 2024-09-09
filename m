Return-Path: <netdev+bounces-126694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9139723C8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B91B21101
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE218A6AB;
	Mon,  9 Sep 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JCcWSZxp"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D66175D20
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914259; cv=none; b=sQF7KLRkLn4NfhNd3d/s6WcCpJn1/yJurakYmgBgDNB0IkSoLJCsinr+t0LuxwE2ZOdDlmHMYyT5xE/+tpmDIFV24EpBIoIKoDHLPF8AvRtG5a9NcmF03sai78y0T8x/BGFXHhgrhFn741Ycn8C2/QuoVcgeVX7LWojE7xh1L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914259; c=relaxed/simple;
	bh=y4P+CeHWawU9fLO8RpYZMNG9QOOzG+598Y6PkRdmZZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDrAz08RVtrfJ65ifLaNAOB7Nsp54TjA0C+e73S2JGeUUMTBe8zjBuktH4v7pM8VSEWm3mTm9l6mm2Koun8E4+4DeVZT9/M9T+nY8axkizVO+pQXclbQUrJby21P3BXMESYU29IE7maivejnBT1kNls85980slIzMYv3H+4BESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JCcWSZxp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40eab0d1-f35d-4a96-91c5-a9d050bdf236@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725914254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQU6hjCl2R0mkn2FFbcRJb56iASoJ55y19Nseth7f3A=;
	b=JCcWSZxpP7wfcsNBbhYm9+1Tl/rBdQ/K1D4hhtG9A7lUSUI0DFIDnQ/+a08paIM2TSiGUL
	eUkmnT0o6xJyS5hEK32vJa9i28imWGT/5zbdBk+aAnO78ilAV6azfRHELbeePrwX1khH/l
	dGEptJLW+dJA8+sOm9WGL9SuLRJkLAs=
Date: Mon, 9 Sep 2024 21:37:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/3] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240909165046.644417-1-vadfed@meta.com>
 <20240909165046.644417-4-vadfed@meta.com>
 <66df354bbd9e9_3d0302945@willemb.c.googlers.com.notmuch>
 <5358489d-faff-4f0a-bf47-f5b45127e9e6@linux.dev>
 <66df5b295992c_7296f294db@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66df5b295992c_7296f294db@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2024 21:31, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 09/09/2024 18:50, Willem de Bruijn wrote:
>>> Vadim Fedorenko wrote:
>>>> Extend txtimestamp test to run with fixed tskey using
>>>> SCM_TS_OPT_ID control message for all types of sockets.
>>>>
>>>> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>> ---
>>>>    tools/include/uapi/asm-generic/socket.h    |  2 +
>>>>    tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>>>>    tools/testing/selftests/net/txtimestamp.sh | 12 +++---
>>>>    3 files changed, 47 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
>>>> index 54d9c8bf7c55..281df9139d2b 100644
>>>> --- a/tools/include/uapi/asm-generic/socket.h
>>>> +++ b/tools/include/uapi/asm-generic/socket.h
>>>> @@ -124,6 +124,8 @@
>>>>    #define SO_PASSPIDFD		76
>>>>    #define SO_PEERPIDFD		77
>>>>    
>>>> +#define SCM_TS_OPT_ID		78
>>>> +
>>>>    #if !defined(__KERNEL__)
>>>>    
>>>>    #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>>>> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
>>>> index ec60a16c9307..bdd0eb74326c 100644
>>>> --- a/tools/testing/selftests/net/txtimestamp.c
>>>> +++ b/tools/testing/selftests/net/txtimestamp.c
>>>> @@ -54,6 +54,10 @@
>>>>    #define USEC_PER_SEC	1000000L
>>>>    #define NSEC_PER_SEC	1000000000LL
>>>>    
>>>> +#ifndef SCM_TS_OPT_ID
>>>> +# define SCM_TS_OPT_ID 78
>>>> +#endif
>>>
>>> This should not be needed. And along with the uapi change above means
>>> the test will be broken on other platforms.
>>>
>>> (SO|SCM)_TXTIME ostensibly has the same issue and does not do this.
>>
>> I had the same feeling, but apparently I wasn't able to build tests
>> without this addition. Looks like selftests rely on system's uapi rather
>> the one provided in tool/include/uapi.
> 
> Right, as they should.
> 
> make headers_install will install headers by default under $KSRC/usr
> 
> tools/testing/selftests/net/Makefile has
> 
> CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
> 
> Haven't tried, but I assume this will pick up the right header
> depending on the arch.

I see, thanks!
I'll respin (in usual 24 hours timeout) the series with nits fixes and 
will remove this ifdefs in selftests.

>> With SCM_TXTIME it worked because the option was added back in 2018 in
>> 80b14dee2bea ("net: Add a new socket option for a future transmit
>> time.") by Richard while tests were added in 2019 by yourself in
>> af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ").
>>
>> Though selftests do miss uapi for other architectures, it might be a
>> good reason to respin the series, but fixing selftests infra is a bit
>> different story, I believe... I may try to fix it and post another
>> series.
> 
> 


