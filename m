Return-Path: <netdev+bounces-125460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD896D23E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D3E1F2A5C3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66722194A42;
	Thu,  5 Sep 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDRcAJDa"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00216624
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525294; cv=none; b=JxYY5F3HBz5XKaHq54Zr7/SpwmjlXgJVDWYCrrHVjPk5n4sFTxBJ/0ZpIEHI0OqLUEkC6F87L7sJEYawu46NYWOIvT92feyaBel5bV95SqJOGXV1h2b7ZPN/vpIQz40KWXUIUfdydJXxJDSBHtPpSnyx8oqRCZ0nwZmBy/aH8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525294; c=relaxed/simple;
	bh=sTr1Lfj1aJ/OMFjrc4SDxcCQ5H7z88vOggiogUDTwg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxSwDqN1wFS7E7iYMj/odEZf4axyYQTa5WuD2+CUvwMQJp5Yys+M3v8Hw6I0CqhwXh2c38liTm+FwXpItLtBo/pU2UBy7t+IHZspXRWh7ANrDJnCDPz2PY6J6g3O01PldsiNfI74fNc8AuQbkyXOnBHotfpAyFKussotNbS5RRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDRcAJDa; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac14161a-33e9-4fa0-8e8c-1d7ea42afc56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725525288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpKqoyEDXS+7LzZyuCwjRobe87Pe8NnppAqy2EUNLuQ=;
	b=pDRcAJDa7m1JEf2OgxZDaTksq0LOyhVyXQTLTc+li76kq3xsgAJIDOgZLpn4uYqXPgbDky
	3LYLu94r2j3ZTZlv7Nd4Bu4iDtiosASK1XP3ufjPAxx7Dr4S3TzH23q1Rt4gQW0N3NFZrw
	5e7jnlDWC82twPtttCjPpLVAOXG0em8=
Date: Thu, 5 Sep 2024 09:34:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Jason Xing <kerneljasonxing@gmail.com>, Vadim Fedorenko <vadfed@meta.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-2-vadfed@meta.com>
 <CAL+tcoAO=0g0mkmgODzNWLJZgRxNvJiXM7=DgoCgdbFsJ0cJEg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoAO=0g0mkmgODzNWLJZgRxNvJiXM7=DgoCgdbFsJ0cJEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2024 09:24, Jason Xing wrote:
> Hello Vadim,
> 
> On Wed, Sep 4, 2024 at 7:32 PM Vadim Fedorenko <vadfed@meta.com> wrote:
> [...]
>> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
>> index a2c66b3d7f0f..1c38536350e7 100644
>> --- a/include/uapi/linux/net_tstamp.h
>> +++ b/include/uapi/linux/net_tstamp.h
>> @@ -38,6 +38,13 @@ enum {
>>                                   SOF_TIMESTAMPING_LAST
>>   };
>>
>> +/*
>> + * The highest bit of sk_tsflags is reserved for kernel-internal
>> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING*
>> + * values do not reach this reserved area
> 
> I wonder if we can add the above description which is quite useful in
> enum{} like this:
> 
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index a2c66b3d7f0f..2314fccaf51d 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -13,7 +13,12 @@
>   #include <linux/types.h>
>   #include <linux/socket.h>   /* for SO_TIMESTAMPING */
> 
> -/* SO_TIMESTAMPING flags */
> +/* SO_TIMESTAMPING flags
> + *
> + * The highest bit of sk_tsflags is reserved for kernel-internal
> + * SOCKCM_FLAG_TS_OPT_ID.
> + * SOCKCM_FLAG_TS_OPT_ID = (1 << 31),
> + */
>   enum {
>          SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
>          SOF_TIMESTAMPING_TX_SOFTWARE = (1<<1),
> 
> to explicitly remind the developers not to touch 1<<31 field. Or else,
> it can be very hard to trace who occupied the highest field in the
> future at the first glance, I think.
> 
> [...]

That's a bit contradictory to Willem's comment about not exposing
implementation details to UAPI headers, which I think makes sense.

I will move the comment to the definition area of SOCKCM_FLAG_TS_OPT_ID
and will try to add meaningful message to BUILD_BUG_ON() to make it
easier for developers to understand the problem.

>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index f26841f1490f..9b87d23314e8 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>>          cork->base.gso_size = ipc6->gso_size;
>>          cork->base.tx_flags = 0;
>>          cork->base.mark = ipc6->sockc.mark;
>> +       cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
>>          sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
>> +       if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
>> +               cork->base.flags |= IPCORK_TS_OPT_ID;
>>
>>          cork->base.length = 0;
>>          cork->base.transmit_time = ipc6->sockc.transmit_time;
>> @@ -1433,7 +1436,7 @@ static int __ip6_append_data(struct sock *sk,
>>          bool zc = false;
>>          u32 tskey = 0;
>>          struct rt6_info *rt = dst_rt6_info(cork->dst);
>> -       bool paged, hold_tskey, extra_uref = false;
>> +       bool paged, hold_tskey = false, extra_uref = false;
>>          struct ipv6_txoptions *opt = v6_cork->opt;
>>          int csummode = CHECKSUM_NONE;
>>          unsigned int maxnonfragsize, headersize;
>> @@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
>>                          flags &= ~MSG_SPLICE_PAGES;
>>          }
>>
>> -       hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> -                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>> -       if (hold_tskey)
>> -               tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +       if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> +           READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {
> 
> s/SOCKCM_FLAG_TS_OPT_ID/SOF_TIMESTAMPING_OPT_ID/
> In case you forget to change here :)

Yeah, I've fixed this one already, but thanks!

> 
>> +               if (cork->flags & IPCORK_TS_OPT_ID) {
>> +                       tskey = cork->ts_opt_id;
>> +               } else {
>> +                       tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +                       hold_tskey = true;
>> +               }
>> +       }
>>
>>          /*
>>           * Let's try using as much space as possible.
>> --
>> 2.43.5
>>


