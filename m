Return-Path: <netdev+bounces-126024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8A96F9E2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D10C2856EB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635371D31B8;
	Fri,  6 Sep 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ul12t6dN"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0F282ED
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643631; cv=none; b=sTcVC/Qi1Y6QtBhkdRonj5yx0iD/SqbO0C8LPGx+em9Rb+jx64AEsK38gU3eRBFGL9SyIZr0Am+0CXFv1B3YmQV9FTuiGRwYOlxBoJ3LqP1bkrqhJzkqLa4F2Cu3BZL3j8JNgqUgD9fsVLzFzqlc9Q32LesTMBp+d1jZ/Xcghzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643631; c=relaxed/simple;
	bh=Xl9GhYfH33n8+vrvQQByZM+HhAj2WaK6ParsMKtSHbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2mI7//6R9QuTjKabBYxt5ewvSL/QXfMCdT/Hf1vZ0Li2AsD8+7NZgGyeWmlLB8vkT/QvPAHfnJjRJyy5n0fSx+Wql/fvcD829IJ5e/EXxcicuZyfTw+dnRYmTr2yCbd0TuZoaY9C0H71RIE/EkXs58fwRS22Hb3bneN/4Hztjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ul12t6dN; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f17d828-5d0f-4050-be4b-8840feb8de76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725643625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVHMVg2i3Sgc9zlacM0Rr3Aexo5lbdLJRO1gCLW9714=;
	b=ul12t6dNieyKCi76aywADX/VGQkh7S/Omcu2TyEqrsts89gnyoQghOqLpYWUIMjnDYmmTV
	SU0hUs+pvC1vgp0usAyP4ZTAJ0AoTtbt2E8EzY9DTejaABVu9c7+eeHR7aItgYD+Vq2A1/
	mGYA2LvQqS16QmUUFhX1PHvkfSjpox0=
Date: Fri, 6 Sep 2024 18:27:00 +0100
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
 <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
 <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/09/2024 16:25, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 05/09/2024 17:39, Willem de Bruijn wrote:
>>> Vadim Fedorenko wrote:
>>>> On 04/09/2024 12:31, Vadim Fedorenko wrote:
>>>>> TCP sockets have different flow for providing timestamp OPT_ID value.
>>>>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
>>>>>
>>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>>> ---
>>>>>     net/ipv4/tcp.c | 13 +++++++++----
>>>>>     1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>>>> index 8a5680b4e786..5553a8aeee80 100644
>>>>> --- a/net/ipv4/tcp.c
>>>>> +++ b/net/ipv4/tcp.c
>>>>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
>>>>>     }
>>>>>     EXPORT_SYMBOL(tcp_init_sock);
>>>>>     
>>>>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>>>>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>>>>>     {
>>>>>     	struct sk_buff *skb = tcp_write_queue_tail(sk);
>>>>> +	u32 tsflags = sockc->tsflags;
>>>>>     
>>>>>     	if (tsflags && skb) {
>>>>>     		struct skb_shared_info *shinfo = skb_shinfo(skb);
>>>>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>>>>>     		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
>>>>>     		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
>>>>>     			tcb->txstamp_ack = 1;
>>>>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
>>>>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>>>>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
>>>>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
>>>>> +				shinfo->tskey = sockc->ts_opt_id;
>>>>> +			else
>>>>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>>>>> +		}
>>>>>     	}
>>>>>     }
>>>>>     
>>>>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>>>     
>>>>>     out:
>>>>>     	if (copied) {
>>>>> -		tcp_tx_timestamp(sk, sockc.tsflags);
>>>>> +		tcp_tx_timestamp(sk, &sockc);
>>>>>     		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
>>>>>     	}
>>>>>     out_nopush:
>>>>
>>>> Hi Willem,
>>>>
>>>> Unfortunately, these changes are not enough to enable custom OPT_ID for
>>>> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
>>>> flow:
>>>>
>>>> tcp_skb_collapse_tstamp()
>>>> tcp_fragment_tstamp()
>>>> tcp_gso_tstamp()
>>>>
>>>> I believe the last one breaks tests, but the problem is that there is no
>>>> easy way to provide the flag of constant tskey to it. Only
>>>> shinfo::tx_flags are available at the caller side and we have already
>>>> discussed that we shouldn't use the last bit of this field.
>>>>
>>>> So, how should we deal with the problem? Or is it better to postpone
>>>> support for TCP sockets in this case?
>>>
>>> Are you sure that this is a problem. These functions pass on the
>>> skb_shinfo(skb)->ts_key from one skb to another.
>>
>> Yes, you are right, the problem is in a different place.
>>
>> __skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
>> provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
>> value:
>>
>> 	if (sk_is_tcp(sk))
>> 		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
>>
>> It happens because of assumption that for TCP sockets shinfo::tskey will
>> have sequence number and the logic has to recalculate it back to the
>> bytes sent. The same logic exists in all TCP TX timestamping functions
>> (mentioned in the previous mail) and may trigger some unexpected
>> behavior. To fix the issue we have to provide some kind of signal that
>> tskey value is provided from user-space and shouldn't be changed. And we
>> have to have it somewhere in skb info. Again, tx_flags looks like the
>> best candidate, but it's impossible to use. I'm thinking of using
>> special flag in tcp_skb_cb - gonna test more, but open for other
>> suggestions.
> 
> Ai, that is tricky. tx_flags is full/scarce indeed.
> 
> CB does not persist as the skb transitions between layers.
> 
> The most obvious solution would be to set the flag in sk_tsflags
> itself. But then the cmsg would no long work on a per request basis:
> either the socket uses OPT_ID with counter or OPT_ID_CMSG.
> 
> Good that we catch this now before the ABI is finalized.
> 
> If necessary TCP semantics can diverge from datagrams. So we could
> punt on this. But it's not ideal.

I have done proof of concept code which uses hwtsamp as a storage for
custom tskey in case of TCP:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a52638363ea5..40ed49e61bf7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5414,8 +5414,6 @@ static void __skb_complete_tx_timestamp(struct 
sk_buff *skb,
         serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
         if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
                 serr->ee.ee_data = skb_shinfo(skb)->tskey;
-               if (sk_is_tcp(sk))
-                       serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
         }

         err = sock_queue_err_skb(sk, skb);
@@ -5450,6 +5448,8 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
          * but only if the socket refcount is not zero.
          */
         if (likely(refcount_inc_not_zero(&sk->sk_refcnt))) {
+               if (sk_is_tcp(sk) && (READ_ONCE(sk->sk_tsflags) & 
SOF_TIMESTAMPING_OPT_ID) && skb_hwtstamps(skb)->hwtstamp)
+                       skb_shinfo(skb)->tskey = 
(u32)skb_hwtstamps(skb)->hwtstamp;
                 *skb_hwtstamps(skb) = *hwtstamps;
                 __skb_complete_tx_timestamp(skb, sk, SCM_TSTAMP_SND, 
false);
                 sock_put(sk);
@@ -5509,6 +5509,12 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
                 skb_shinfo(skb)->tskey = skb_shinfo(orig_skb)->tskey;
         }

+       if (sk_is_tcp(sk) && (tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+               if (skb_hwtstamps(orig_skb)->hwtstamp)
+                       skb_shinfo(skb)->tskey = 
(u32)skb_hwtstamps(orig_skb)->hwtstamp;
+               else
+                       skb_shinfo(skb)->tskey -= 
atomic_read(&sk->sk_tskey);
+       }
         if (hwtstamps)
                 *skb_hwtstamps(skb) = *hwtstamps;
         else
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d3decc13a99..1a161a2155b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -488,9 +488,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct 
sockcm_cookie *sockc)
                         tcb->txstamp_ack = 1;
                 if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
                         if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
-                               shinfo->tskey = sockc->ts_opt_id;
-                       else
-                               shinfo->tskey = TCP_SKB_CB(skb)->seq + 
skb->len - 1;
+                               skb_hwtstamps(skb)->hwtstamp = 
sockc->ts_opt_id;
+                       shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
                 }
         }
  }


Looks like we can add u32 tskey field in skb_shared_hwtstamps and reuse
it. netdev_data field is only used on RX timestamp side, so should be
fine to reuse. WDYT?


