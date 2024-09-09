Return-Path: <netdev+bounces-126680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35297230C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF881C20D90
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC41836D9;
	Mon,  9 Sep 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxi8jAZ8"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D0171066
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911981; cv=none; b=tUgtFvqgwlhw7+XTKcGYgj31Qvdqz4FwBBO9Jp6ifoTlLEd4ZxwWOAH1a2l1R1I4nUcKq+SOsqAEWAgjcGW0O5R6i615qVOYPEW+Vaq86t3AxC+vy6p21BSGEMBuotHbussiKoWMg7QVdH/KIln92oC3eIIl1pN3C9ZjwRlQb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911981; c=relaxed/simple;
	bh=cGbdBU+9eJIS4sYcHpMykyc3fBB8akTpPof5uquRCjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdjO56G2Mgbmo2F5tLTvT4rLwdqiuEPif8UYdxWQslkTF3W7ceHl0I40uei8Ws48u+7iIoZ3xUczICWiDtGhANDdto2D/SFOeIysX2soERA7PzIaLLrsxEw8PwJoQvJ7JFT9/tGbKyA1suaJUE28H0piLJgHtSfM+EvEgpussBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxi8jAZ8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5358489d-faff-4f0a-bf47-f5b45127e9e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725911976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R080w09NZjJvzIa5Afx1V1eJEaVDM+cmlus3QbJS5mY=;
	b=dxi8jAZ8NIbV9W8IfkoH5vvz0mpnAE4ZZRLH43D9Wxauq9sXhmOLnTtrlarbPgRa339NPe
	ibStLuucutn+xSjWjb+F7EfR8qlJYpNkUtAs/j1OFGDqtljUe9FsMn1e585bftsE2CT60S
	Km/KDSKvjgFzEHXEi+1UKz8UjsZBqt0=
Date: Mon, 9 Sep 2024 20:59:30 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66df354bbd9e9_3d0302945@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2024 18:50, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> Extend txtimestamp test to run with fixed tskey using
>> SCM_TS_OPT_ID control message for all types of sockets.
>>
>> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   tools/include/uapi/asm-generic/socket.h    |  2 +
>>   tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>>   tools/testing/selftests/net/txtimestamp.sh | 12 +++---
>>   3 files changed, 47 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
>> index 54d9c8bf7c55..281df9139d2b 100644
>> --- a/tools/include/uapi/asm-generic/socket.h
>> +++ b/tools/include/uapi/asm-generic/socket.h
>> @@ -124,6 +124,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SCM_TS_OPT_ID		78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
>> index ec60a16c9307..bdd0eb74326c 100644
>> --- a/tools/testing/selftests/net/txtimestamp.c
>> +++ b/tools/testing/selftests/net/txtimestamp.c
>> @@ -54,6 +54,10 @@
>>   #define USEC_PER_SEC	1000000L
>>   #define NSEC_PER_SEC	1000000000LL
>>   
>> +#ifndef SCM_TS_OPT_ID
>> +# define SCM_TS_OPT_ID 78
>> +#endif
> 
> This should not be needed. And along with the uapi change above means
> the test will be broken on other platforms.
> 
> (SO|SCM)_TXTIME ostensibly has the same issue and does not do this.

I had the same feeling, but apparently I wasn't able to build tests
without this addition. Looks like selftests rely on system's uapi rather
the one provided in tool/include/uapi.
With SCM_TXTIME it worked because the option was added back in 2018 in
80b14dee2bea ("net: Add a new socket option for a future transmit 
time.") by Richard while tests were added in 2019 by yourself in
af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ").

Though selftests do miss uapi for other architectures, it might be a
good reason to respin the series, but fixing selftests infra is a bit
different story, I believe... I may try to fix it and post another
series.

