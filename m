Return-Path: <netdev+bounces-125917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37A96F429
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A0F1C23488
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA31CB313;
	Fri,  6 Sep 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGWSOVtu"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253613AA38
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625266; cv=none; b=BD237wnz+COVH0f5jngBtn3XrcYTG1sqw+xitkNg4wU+UReoxMkg7omd/ZJcUngSkJcdMOezrSeVVoG54Tjk/zSjQCwEbaltqdFD9zZzaXDdCMSoaz8vGxpK1MVXKZz0XfxLH+jVWtGxQCg/zeWNDQDLCsdB9CcFoT+AKYmaELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625266; c=relaxed/simple;
	bh=Rr13Z8k1b3FjVmwJi0vvfFQ6x8KPCL7KckW6VL8OY5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEdAsenHlCw8hBwi6qkQJ0jrfh5evxdAFfzAyHGQG874N/1tWQNZh5B20ruxR7WhQLm40r5aaaN5Ag5AJOvNMzc1cr83VPy+b9m/5P+jpfT88VUBUpPctgxnWHvio7Jt61+Pc0AriBv2LPCJBqVpOxi/B/9Iy1MaSEDOvoZjem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGWSOVtu; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725625260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=402T8vQFZZDNQBHdcEvP6vREqeCh7T+9Ue7TW/CHFlE=;
	b=HGWSOVtujjV6plvvV+CbohdMAJ+NnvWyUFaLAkOeU33/8EBlgRT9Wk/IkyVzh1ASv68c+M
	tyjyLLVFOy+/J7u+zfpCm6mRmbfACCa81ClO/xfzzgyzfpQJZFYdqhEbJlSgK8WpbnGV8I
	gmhi4TTEAXPd5zJXdBCRdEtnNxmyy1I=
Date: Fri, 6 Sep 2024 13:20:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/4] net_tstamp: add SCM_TS_OPT_ID for TCP
 sockets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
 <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2024 17:39, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 04/09/2024 12:31, Vadim Fedorenko wrote:
>>> TCP sockets have different flow for providing timestamp OPT_ID value.
>>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>    net/ipv4/tcp.c | 13 +++++++++----
>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 8a5680b4e786..5553a8aeee80 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
>>>    }
>>>    EXPORT_SYMBOL(tcp_init_sock);
>>>    
>>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>>>    {
>>>    	struct sk_buff *skb = tcp_write_queue_tail(sk);
>>> +	u32 tsflags = sockc->tsflags;
>>>    
>>>    	if (tsflags && skb) {
>>>    		struct skb_shared_info *shinfo = skb_shinfo(skb);
>>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>>>    		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
>>>    		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
>>>    			tcb->txstamp_ack = 1;
>>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
>>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
>>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
>>> +				shinfo->tskey = sockc->ts_opt_id;
>>> +			else
>>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>>> +		}
>>>    	}
>>>    }
>>>    
>>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>    
>>>    out:
>>>    	if (copied) {
>>> -		tcp_tx_timestamp(sk, sockc.tsflags);
>>> +		tcp_tx_timestamp(sk, &sockc);
>>>    		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
>>>    	}
>>>    out_nopush:
>>
>> Hi Willem,
>>
>> Unfortunately, these changes are not enough to enable custom OPT_ID for
>> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
>> flow:
>>
>> tcp_skb_collapse_tstamp()
>> tcp_fragment_tstamp()
>> tcp_gso_tstamp()
>>
>> I believe the last one breaks tests, but the problem is that there is no
>> easy way to provide the flag of constant tskey to it. Only
>> shinfo::tx_flags are available at the caller side and we have already
>> discussed that we shouldn't use the last bit of this field.
>>
>> So, how should we deal with the problem? Or is it better to postpone
>> support for TCP sockets in this case?
> 
> Are you sure that this is a problem. These functions pass on the
> skb_shinfo(skb)->ts_key from one skb to another.

Yes, you are right, the problem is in a different place.

__skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
value:

	if (sk_is_tcp(sk))
		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);

It happens because of assumption that for TCP sockets shinfo::tskey will
have sequence number and the logic has to recalculate it back to the
bytes sent. The same logic exists in all TCP TX timestamping functions
(mentioned in the previous mail) and may trigger some unexpected
behavior. To fix the issue we have to provide some kind of signal that
tskey value is provided from user-space and shouldn't be changed. And we
have to have it somewhere in skb info. Again, tx_flags looks like the
best candidate, but it's impossible to use. I'm thinking of using
special flag in tcp_skb_cb - gonna test more, but open for other
suggestions.




