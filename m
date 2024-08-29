Return-Path: <netdev+bounces-123305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B229647C1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFD3B224F2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD911AD419;
	Thu, 29 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4648gqF"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA431190663
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940834; cv=none; b=BSOy55Bz3mw2AICCFGE0vIrILmUTbIWED74tNUag3Hn+bFJbo4It/shTCivnz4UNZG+lQ5FGyGr72jACZlrP8+SYj3q3x0goAfqSwT8+zb3c50g1n7DNv3WK+IMrW3vJEr2lV1jNBosgxfBqpAxmE24XA16Ws0m1pJlITJRGwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940834; c=relaxed/simple;
	bh=OG2Qx9qjg+5TqAxHyq4IYoZ17Yy6uE3T0ZSr+LtLeig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4Yyog44WFxIFCskruwDEinJPOLPxPgcZpR2dp9no4plRwkDVpq2t0k2jxvGbFB/Jt0vS9GODuQDtjs2lS+T60Rp2wMKv5kiKcaWfxcolKNYNgzlA69N6vaNUI9l18rl1HqJJrMcQ/VEn8R8bN+hG6LrMw1/VUUO8Ta5UtMoK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4648gqF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfe033f1-cc61-4be3-a59d-e6b623591cc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724940828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky5AKH+sYm5csAWGIdNwLE+rMxmAV8rakEJ7TtHVg0Q=;
	b=u4648gqFbyYCZp1U14Jv8zAvyot/XBl84KGoS+dCvwD3+d+yIpq+vG1d/Ir0QTF9TqJqOP
	/55ZitESMTFLT7Gzu/SeSmbpNtPfDxkGsHiBjhFN7d3p00XvcBjqzTsNnb67P0D+yrQJBa
	IYPTYDsEi2+Ctw9Rim91AmoI/GtM5hU=
Date: Thu, 29 Aug 2024 15:13:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in
 control message
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240829000355.1172094-1-vadfed@meta.com>
 <66d0783ca3dc4_3895fa2946a@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d0783ca3dc4_3895fa2946a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/08/2024 14:31, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>> timestamps
> 
> +1 on the feature. Few minor points only.
> 
> Not a hard requirement, but would be nice if there was a test,
> e.g., as a tools/testing/../txtimestamp.c extension.

Sure, I'll add some tests in the next version.


>> and packets sent via socket. Unfortunately, there is no way
>> to reliably predict socket timestamp ID value in case of error returned
>> by sendmsg [1].
> 
> Might be good to copy more context from the discussion to explain why
> reliable OPT_ID is infeasible. For UDP, it is as simple as lockless
> transmit. For RAW, things like MSG_MORE come into play.

Ok, I'll add it, thanks!

>> This patch adds new control message type to give user-space
>> software an opportunity to control the mapping between packets and
>> values by providing ID with each sendmsg. This works fine for UDP
>> sockets only, and explicit check is added to control message parser.
>> Also, there is no easy way to use 0 as provided ID, so this is value
>> treated as invalid.
> 
> This is because the code branches on non-zero value in the cookie,
> else uses ts_key. Please make this explicit. Or perhaps better, add a
> bit in the cookie so that the full 32-bit space can be used.

Adding a bit in the cookie is not enough, I have to add another flag to
inet_cork. And we are running out of space for tx flags, 
inet_cork::tx_flags is u8 and we have only 1 bit left for SKBTX* enum.
Do you think it's OK to use this last bit for OPT_ID feature?

>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   include/net/inet_sock.h           |  1 +
>>   include/net/sock.h                |  1 +
>>   include/uapi/asm-generic/socket.h |  2 ++
>>   net/core/sock.c                   | 14 ++++++++++++++
>>   net/ipv4/ip_output.c              | 11 +++++++++--
>>   net/ipv6/ip6_output.c             | 11 +++++++++--
>>   6 files changed, 36 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>> index 394c3b66065e..7e8545311557 100644
>> --- a/include/net/inet_sock.h
>> +++ b/include/net/inet_sock.h
>> @@ -174,6 +174,7 @@ struct inet_cork {
>>   	__s16			tos;
>>   	char			priority;
>>   	__u16			gso_size;
>> +	u32			ts_opt_id;
>>   	u64			transmit_time;
>>   	u32			mark;
>>   };
> 
> Ah there's a hole here. Nice!
> 
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index f51d61fab059..73e21dad5660 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>>   	u64 transmit_time;
>>   	u32 mark;
>>   	u32 tsflags;
>> +	u32 ts_opt_id;
>>   };
>>   
>>   static inline void sockcm_init(struct sockcm_cookie *sockc,
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..db3df3e74b01 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -135,6 +135,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SCM_TS_OPT_ID		78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 468b1239606c..918cb6a0dcba 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2859,6 +2859,20 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   			return -EINVAL;
>>   		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
>>   		break;
>> +	case SCM_TS_OPT_ID:
>> +		/* allow this option for UDP sockets only */
>> +		if (!sk_is_udp(sk))
>> +			return -EINVAL;
>> +		tsflags = READ_ONCE(sk->sk_tsflags);
>> +		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
>> +			return -EINVAL;
>> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
>> +			return -EINVAL;
>> +		sockc->ts_opt_id = get_unaligned((u32 *)CMSG_DATA(cmsg));
> 
> Is the get_unaligned here needed? I don't usually see that on
> CMSG_DATA accesses. Even though they are indeed likely to be
> unaligned.

Well, maybe you are right and we don't need get_unaligned for u32
here, at least SO_MARK uses direct access. I have no strong opinion.

>> +		/* do not allow 0 as packet id for timestamp */
>> +		if (!sockc->ts_opt_id)
>> +			return -EINVAL;
>> +		break;
>>   	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index b90d0f78ac80..f1e6695cafd2 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
>>   
>>   	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>>   		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>> -	if (hold_tskey)
>> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +	if (hold_tskey) {
>> +                if (cork->ts_opt_id) {
>> +                        hold_tskey = false;
>> +                        tskey = cork->ts_opt_id;
>> +                } else {
>> +                        tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +                }
>> +	}
>>   
>>   	/* So, what's going on in the loop below?
>>   	 *
>> @@ -1324,6 +1330,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>>   	cork->mark = ipc->sockc.mark;
>>   	cork->priority = ipc->priority;
>>   	cork->transmit_time = ipc->sockc.transmit_time;
>> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
>>   	cork->tx_flags = 0;
>>   	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
>>   
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index f26841f1490f..602064250546 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -1401,6 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>>   	cork->base.gso_size = ipc6->gso_size;
>>   	cork->base.tx_flags = 0;
>>   	cork->base.mark = ipc6->sockc.mark;
>> +	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
>>   	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
>>   
>>   	cork->base.length = 0;
>> @@ -1545,8 +1546,14 @@ static int __ip6_append_data(struct sock *sk,
>>   
>>   	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>>   		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>> -	if (hold_tskey)
>> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +	if (hold_tskey) {
>> +		if (cork->ts_opt_id) {
>> +			hold_tskey = false;
>> +			tskey = cork->ts_opt_id;
>> +		} else {
>> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +		}
>> +	}
>>   
>>   	/*
>>   	 * Let's try using as much space as possible.
>> -- 
>> 2.43.5
>>
> 
> 


