Return-Path: <netdev+bounces-124059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1C967C40
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9547B1C20E62
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D5558BA;
	Sun,  1 Sep 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wfhNTdPq"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C132B9DA
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224139; cv=none; b=ng3x4+wHJ51Maldz9PFkoF6i9XsPuwZWDj5xUB9lclNLBoznoJ8vVlup8rBINop7qUG/Id7PAWNXGqLQcaUxQahGuwN3ePBXZFOkSKiNjh36fObXQxtD2CO8zWpYdqpgmRnL2s0WlejMMARmdwPZ/VoSFbBnthe8N+jn19WcGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224139; c=relaxed/simple;
	bh=R1xFv5V6r/m42YElr36NwnhOmqyccs1C/CBlerLZ6OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVzwR5SpAYspC3x/XcxhBiI/GM3kXI+lCJYmUAMjWwcrBQvFE9rzPiub1VzGjpXuMZnaL+nc/K86unBFKsXYuEcwcQ9GeAjsCIZAVd1Wdt4Aa2Is26MYhwxzVuRwPc7DMeXaTquJ2VcSsHWTZwBIFkBsbsrC7z47ezjbM2v6xgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wfhNTdPq; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9bf6919-32f0-48f5-9339-e8fa8b4f94b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725224134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yERWEL0DbfGn+AeOTTMxyay4mVCAFTleOSjBjg00yCo=;
	b=wfhNTdPqoBUt+ZAxrjRk2WZVhJxwxUv9+3OcpMgHGGjb0WOc1Ee807I75/qar0H15SS/zi
	1LgYp2Z/A7OUKQTjArJY0zsPs3ukOcerlxm/VZfFNSOy7XAHL7C/EZ3DKqIBPonJNWPeup
	HPznLA02Yjo/Ec837fD8c5pR7McwxXk=
Date: Sun, 1 Sep 2024 21:55:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Willem de Bruijn <willemb@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20240829204922.1674865-1-vadfed@meta.com>
 <66d1df11a42fc_3c08a2294a5@willemb.c.googlers.com.notmuch>
 <e3bddd1e-d0a8-40f9-ba95-b19cbbb57560@linux.dev>
 <CA+FuTSe1DXY04rpwaaVvK0qFgq3owUtjTiRrVTTCUuUsR0UKyw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CA+FuTSe1DXY04rpwaaVvK0qFgq3owUtjTiRrVTTCUuUsR0UKyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30/08/2024 22:07, Willem de Bruijn wrote:
> On Fri, Aug 30, 2024 at 1:11 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 30/08/2024 16:02, Willem de Bruijn wrote:
>>> Vadim Fedorenko wrote:
>>>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>>>> timestamps and packets sent via socket. Unfortunately, there is no way
>>>> to reliably predict socket timestamp ID value in case of error returned
>>>> by sendmsg. For UDP sockets it's impossible because of lockless
>>>> nature of UDP transmit, several threads may send packets in parallel. In
>>>> case of RAW sockets MSG_MORE option makes things complicated. More
>>>> details are in the conversation [1].
>>>> This patch adds new control message type to give user-space
>>>> software an opportunity to control the mapping between packets and
>>>> values by providing ID with each sendmsg. This works fine for UDP
>>>> sockets only, and explicit check is added to control message parser.
>>>>
>>>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>> ---
>>>>    include/net/inet_sock.h           |  4 +++-
>>>>    include/net/sock.h                |  1 +
>>>>    include/uapi/asm-generic/socket.h |  2 ++
>>>>    include/uapi/linux/net_tstamp.h   |  1 +
>>>>    net/core/sock.c                   | 12 ++++++++++++
>>>>    net/ipv4/ip_output.c              | 13 +++++++++++--
>>>>    net/ipv6/ip6_output.c             | 13 +++++++++++--
>>>>    7 files changed, 41 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>>>> index 394c3b66065e..2161d50cf0fd 100644
>>>> --- a/include/net/inet_sock.h
>>>> +++ b/include/net/inet_sock.h
>>>> @@ -174,6 +174,7 @@ struct inet_cork {
>>>>       __s16                   tos;
>>>>       char                    priority;
>>>>       __u16                   gso_size;
>>>> +    u32                     ts_opt_id;
>>>>       u64                     transmit_time;
>>>>       u32                     mark;
>>>>    };
>>>> @@ -241,7 +242,8 @@ struct inet_sock {
>>>>       struct inet_cork_full   cork;
>>>>    };
>>>>
>>>> -#define IPCORK_OPT  1       /* ip-options has been held in ipcork.opt */
>>>> +#define IPCORK_OPT          1       /* ip-options has been held in ipcork.opt */
>>>> +#define IPCORK_TS_OPT_ID    2       /* timestmap opt id has been provided in cmsg */
>>>>
>>>>    enum {
>>>>       INET_FLAGS_PKTINFO      = 0,
>>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>>> index f51d61fab059..73e21dad5660 100644
>>>> --- a/include/net/sock.h
>>>> +++ b/include/net/sock.h
>>>> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>>>>       u64 transmit_time;
>>>>       u32 mark;
>>>>       u32 tsflags;
>>>> +    u32 ts_opt_id;
>>>>    };
>>>>
>>>>    static inline void sockcm_init(struct sockcm_cookie *sockc,
>>>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>>>> index 8ce8a39a1e5f..db3df3e74b01 100644
>>>> --- a/include/uapi/asm-generic/socket.h
>>>> +++ b/include/uapi/asm-generic/socket.h
>>>> @@ -135,6 +135,8 @@
>>>>    #define SO_PASSPIDFD               76
>>>>    #define SO_PEERPIDFD               77
>>>>
>>>> +#define SCM_TS_OPT_ID               78
>>>> +
>>>>    #if !defined(__KERNEL__)
>>>>
>>>>    #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>>>> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
>>>> index a2c66b3d7f0f..081b40a55a2e 100644
>>>> --- a/include/uapi/linux/net_tstamp.h
>>>> +++ b/include/uapi/linux/net_tstamp.h
>>>> @@ -32,6 +32,7 @@ enum {
>>>>       SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
>>>>       SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>>>>       SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
>>>> +    SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
>>>>
>>>>       SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
>>>>       SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
>>>
>>> Update SOF_TIMESTAMPING_LAST
>>
>> Got it
>>
>>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>>> index 468b1239606c..560b075765fa 100644
>>>> --- a/net/core/sock.c
>>>> +++ b/net/core/sock.c
>>>> @@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>>>                       return -EINVAL;
>>>>               sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
>>>>               break;
>>>> +    case SCM_TS_OPT_ID:
>>>> +            /* allow this option for UDP sockets only */
>>>> +            if (!sk_is_udp(sk))
>>>> +                    return -EINVAL;
>>>> +            tsflags = READ_ONCE(sk->sk_tsflags);
>>>> +            if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
>>>> +                    return -EINVAL;
>>>> +            if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
>>>> +                    return -EINVAL;
>>>> +            sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
>>>> +            sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
>>>> +            break;
>>>>       /* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>>>>       case SCM_RIGHTS:
>>>>       case SCM_CREDENTIALS:
>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>> index b90d0f78ac80..65b5d9f53102 100644
>>>> --- a/net/ipv4/ip_output.c
>>>> +++ b/net/ipv4/ip_output.c
>>>> @@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
>>>>
>>>>       hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>>>>                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>>>> -    if (hold_tskey)
>>>> -            tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>>>> +    if (hold_tskey) {
>>>> +            if (cork->flags & IPCORK_TS_OPT_ID) {
>>>> +                    hold_tskey = false;
>>>> +                    tskey = cork->ts_opt_id;
>>>> +            } else {
>>>> +                    tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>>>> +            }
>>>> +    }
>>>>
>>>>       /* So, what's going on in the loop below?
>>>>        *
>>>> @@ -1324,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>>>>       cork->mark = ipc->sockc.mark;
>>>>       cork->priority = ipc->priority;
>>>>       cork->transmit_time = ipc->sockc.transmit_time;
>>>> +    cork->ts_opt_id = ipc->sockc.ts_opt_id;
>>>>       cork->tx_flags = 0;
>>>>       sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
>>>> +    if (ipc->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
>>>> +            cork->flags |= IPCORK_TS_OPT_ID;
>>>>
>>>>       return 0;
>>>>    }
>>>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>>>> index f26841f1490f..91eafef85c85 100644
>>>> --- a/net/ipv6/ip6_output.c
>>>> +++ b/net/ipv6/ip6_output.c
>>>> @@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>>>>       cork->base.gso_size = ipc6->gso_size;
>>>>       cork->base.tx_flags = 0;
>>>>       cork->base.mark = ipc6->sockc.mark;
>>>> +    cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
>>>>       sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
>>>> +    if (ipc6->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
>>>> +            cork->base.flags |= IPCORK_TS_OPT_ID;
>>>>
>>>>       cork->base.length = 0;
>>>>       cork->base.transmit_time = ipc6->sockc.transmit_time;
>>>> @@ -1545,8 +1548,14 @@ static int __ip6_append_data(struct sock *sk,
>>>>
>>>>       hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>>>>                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>>>> -    if (hold_tskey)
>>>> -            tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>>>> +    if (hold_tskey) {
>>>> +            if (cork->flags & IPCORK_TS_OPT_ID) {
>>>> +                    hold_tskey = false;
>>>> +                    tskey = cork->ts_opt_id;
>>>> +            } else {
>>>> +                    tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>>>> +            }
>>>> +    }
>>>
>>> Setting, then clearing hold_tskey is a bit weird. How about
>>>
>>> if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>>>       READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
>>>           if (cork->flags & IPCORK_TS_OPT_ID) {
>>>                    tskey = cork->ts_opt_id;
>>>           } else {
>>>                    tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>>>                    hold_tskey = true;
>>>           }
>>> }
>>
>> Yeah, looks ok, I'll change it this way, thanks!
>>
>> Can you please help me with kernel test robot report? I don't really get
>> how can SCM_TS_OPT_ID be undefined if I added it the exact same place
>> where other option are defined, like SCM_TXTIME or SO_MARK?
> 
> Both bot reports mention arch-alpha.
> 
> Take a look at the patch that introduced SCM_TXTIME. That is defined
> and used in the same locations.
> 
> UAPI socket.h definitions need to be defined separate for various
> archs. I also missed this.

Thanks, Willem, now I found all the definitions.

> Btw, for a next version please also document the new feature in
> Documentation/networking/timestamping.rst

Yep, I'll make series of 3 patches then. Will try to stick into section
1.3.3 Timestamp Options.

> And let's keep it on the list.

Sure, I accidentally removed the list..

