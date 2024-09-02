Return-Path: <netdev+bounces-124305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4902968E81
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63817284DC2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C631A3020;
	Mon,  2 Sep 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiTZZRHs"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E831A3A9C
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725306062; cv=none; b=Grk/E7IASikC0T2+K1lIBqEVsulLomwe32Qxf+Z3JyYp4+jprJgAF/t5anAbKrasC3iY6Nn+7IrgjpNoCP/teFvGQfNw9BW/wMtTvuyUwtUjt2lhYcGqgaEZ4V3MatX8yv/OS4nfvY1xU13lZMfA+QuKUJVLHNa+0aMjgKd/hOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725306062; c=relaxed/simple;
	bh=+rdbypgY3jruO8sE9yBRH6AGrE22Yb3NCyy217HIEW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvZbQ4UWMfyZ7Fhu06cGiVL4qPMi/rWgUjI4+vZT45yNkfxGnNJJ+BNO6aWbPLvZbi/eZiZPYsfvUzOmzKKLpz4UEEQNolhcWBuLkX9/r4KLb0yUmJgnJWKB6IPZ/tSj7TgS4B9wAG1OT8wHxtHnicqtVJ9u5XVqRBlH5Qq2+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiTZZRHs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d79442d-438b-4960-8daf-2f178a210e64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725306058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzlbDAITDcuk5laa7erkI5zpP+0Kg4IbsqcaefXueeg=;
	b=UiTZZRHsuSc8MRAEUmv9Wg+WBbofEbxwc4D7FWoj3EYkH7/dho4Ue1Rk99211ovpiSY7Rg
	60z2LtQABr8O55H1sufxuPyERI5Lfv/Gzg7nBMUr1hFdtQbGIJeCrrLGeyvaAqb0o7g9DY
	aGmj3cIFhPIUvvcKtOlqZZpI7KSzifE=
Date: Mon, 2 Sep 2024 20:40:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
References: <20240902130937.457115-1-vadfed@meta.com>
 <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
 <66d5def0ca56_66cf629420@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d5def0ca56_66cf629420@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2024 16:51, Willem de Bruijn wrote:
> Jason Xing wrote:
>> On Mon, Sep 2, 2024 at 9:09 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>>
>>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>>> timestamps and packets sent via socket. Unfortunately, there is no way
>>> to reliably predict socket timestamp ID value in case of error returned
>>> by sendmsg. For UDP sockets it's impossible because of lockless
>>> nature of UDP transmit, several threads may send packets in parallel. In
>>> case of RAW sockets MSG_MORE option makes things complicated. More
>>> details are in the conversation [1].
>>> This patch adds new control message type to give user-space
>>> software an opportunity to control the mapping between packets and
>>> values by providing ID with each sendmsg. This works fine for UDP
>>> sockets only, and explicit check is added to control message parser.
>>>
>>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>   Documentation/networking/timestamping.rst | 14 ++++++++++++++
>>>   arch/alpha/include/uapi/asm/socket.h      |  4 +++-
>>>   arch/mips/include/uapi/asm/socket.h       |  2 ++
>>>   arch/parisc/include/uapi/asm/socket.h     |  2 ++
>>>   arch/sparc/include/uapi/asm/socket.h      |  2 ++
>>>   include/net/inet_sock.h                   |  4 +++-
>>>   include/net/sock.h                        |  1 +
>>>   include/uapi/asm-generic/socket.h         |  2 ++
>>>   include/uapi/linux/net_tstamp.h           |  3 ++-
>>>   net/core/sock.c                           | 12 ++++++++++++
>>>   net/ethtool/common.c                      |  1 +
>>>   net/ipv4/ip_output.c                      | 16 ++++++++++++----
>>>   net/ipv6/ip6_output.c                     | 16 ++++++++++++----
>>>   13 files changed, 68 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
>>> index 5e93cd71f99f..93b0901e4e8e 100644
>>> --- a/Documentation/networking/timestamping.rst
>>> +++ b/Documentation/networking/timestamping.rst
>>> @@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
>>>     among all possibly concurrently outstanding timestamp requests for
>>>     that socket.
>>>
>>> +  With this option enabled user-space application can provide custom
>>> +  ID for each message sent via UDP socket with control message with
>>> +  type set to SCM_TS_OPT_ID::
>>> +
>>> +    struct msghdr *msg;
>>> +    ...
>>> +    cmsg                        = CMSG_FIRSTHDR(msg);
>>> +    cmsg->cmsg_level            = SOL_SOCKET;
>>> +    cmsg->cmsg_type             = SO_TIMESTAMPING;
>>> +    cmsg->cmsg_len              = CMSG_LEN(sizeof(__u32));
>>> +    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
>>> +    err = sendmsg(fd, msg, 0);
>>> +
>>> +
>>>   SOF_TIMESTAMPING_OPT_ID_TCP:
>>>     Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
>>>     timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
>>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
>>> index e94f621903fe..0698e6662cdf 100644
>>> --- a/arch/alpha/include/uapi/asm/socket.h
>>> +++ b/arch/alpha/include/uapi/asm/socket.h
>>> @@ -10,7 +10,7 @@
>>>    * Note: we only bother about making the SOL_SOCKET options
>>>    * same as OSF/1, as that's all that "normal" programs are
>>>    * likely to set.  We don't necessarily want to be binary
>>> - * compatible with _everything_.
>>> + * compatible with _everything_.
>>>    */
>>>   #define SOL_SOCKET     0xffff
>>>
>>> @@ -140,6 +140,8 @@
>>>   #define SO_PASSPIDFD           76
>>>   #define SO_PEERPIDFD           77
>>>
>>> +#define SCM_TS_OPT_ID          78
>>> +
>>>   #if !defined(__KERNEL__)
>>>
>>>   #if __BITS_PER_LONG == 64
>>> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
>>> index 60ebaed28a4c..bb3dc8feb205 100644
>>> --- a/arch/mips/include/uapi/asm/socket.h
>>> +++ b/arch/mips/include/uapi/asm/socket.h
>>> @@ -151,6 +151,8 @@
>>>   #define SO_PASSPIDFD           76
>>>   #define SO_PEERPIDFD           77
>>>
>>> +#define SCM_TS_OPT_ID          78
>>> +
>>>   #if !defined(__KERNEL__)
>>>
>>>   #if __BITS_PER_LONG == 64
>>> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
>>> index be264c2b1a11..c3ab3b3289eb 100644
>>> --- a/arch/parisc/include/uapi/asm/socket.h
>>> +++ b/arch/parisc/include/uapi/asm/socket.h
>>> @@ -132,6 +132,8 @@
>>>   #define SO_PASSPIDFD           0x404A
>>>   #define SO_PEERPIDFD           0x404B
>>>
>>> +#define SCM_TS_OPT_ID          0x404C
>>> +
>>>   #if !defined(__KERNEL__)
>>>
>>>   #if __BITS_PER_LONG == 64
>>> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
>>> index 682da3714686..9b40f0a57fbc 100644
>>> --- a/arch/sparc/include/uapi/asm/socket.h
>>> +++ b/arch/sparc/include/uapi/asm/socket.h
>>> @@ -133,6 +133,8 @@
>>>   #define SO_PASSPIDFD             0x0055
>>>   #define SO_PEERPIDFD             0x0056
>>>
>>> +#define SCM_TS_OPT_ID            0x0057
>>> +
>>>   #if !defined(__KERNEL__)
>>>
>>>
>>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>>> index 394c3b66065e..2161d50cf0fd 100644
>>> --- a/include/net/inet_sock.h
>>> +++ b/include/net/inet_sock.h
>>> @@ -174,6 +174,7 @@ struct inet_cork {
>>>          __s16                   tos;
>>>          char                    priority;
>>>          __u16                   gso_size;
>>> +       u32                     ts_opt_id;
>>>          u64                     transmit_time;
>>>          u32                     mark;
>>>   };
>>> @@ -241,7 +242,8 @@ struct inet_sock {
>>>          struct inet_cork_full   cork;
>>>   };
>>>
>>> -#define IPCORK_OPT     1       /* ip-options has been held in ipcork.opt */
>>> +#define IPCORK_OPT             1       /* ip-options has been held in ipcork.opt */
>>> +#define IPCORK_TS_OPT_ID       2       /* timestmap opt id has been provided in cmsg */
>>>
>>>   enum {
>>>          INET_FLAGS_PKTINFO      = 0,
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index f51d61fab059..73e21dad5660 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -1794,6 +1794,7 @@ struct sockcm_cookie {
>>>          u64 transmit_time;
>>>          u32 mark;
>>>          u32 tsflags;
>>> +       u32 ts_opt_id;
>>>   };
>>>
>>>   static inline void sockcm_init(struct sockcm_cookie *sockc,
>>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>>> index 8ce8a39a1e5f..db3df3e74b01 100644
>>> --- a/include/uapi/asm-generic/socket.h
>>> +++ b/include/uapi/asm-generic/socket.h
>>> @@ -135,6 +135,8 @@
>>>   #define SO_PASSPIDFD           76
>>>   #define SO_PEERPIDFD           77
>>>
>>> +#define SCM_TS_OPT_ID          78
>>> +
>>>   #if !defined(__KERNEL__)
>>>
>>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>>> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
>>> index a2c66b3d7f0f..e2f145e3f3a1 100644
>>> --- a/include/uapi/linux/net_tstamp.h
>>> +++ b/include/uapi/linux/net_tstamp.h
>>> @@ -32,8 +32,9 @@ enum {
>>>          SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
>>>          SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>>>          SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
>>> +       SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
>>
>> I'm not sure if the new flag needs to be documented as well? After
>> this patch, people may search the key word in the documentation file
>> and then find nothing.
>>
>> If we have this flag here, normally it means we can pass it through
>> setsockopt, so is it expected? If it's an exception, I reckon that we
>> can forbid passing/setting this option in sock_set_timestamping() and
>> document this rule?
> 
> Good point, thanks.
> 
> It must definitely not be part of SOF_TIMESTAMPING_MASK. My bad for
> suggesting without giving it much thought.
> 
> The bit is kernel-internal. No need to even mention it in user-facing
> documentation. But anyone reading net_tstamp.h might wonder what it
> does.
> 
> It should not even be in a UAPI header, but in an internal one.
> Probably include/net/sock.h, near SK_FLAGS_TIMESTAMP.
> 
> Maybe we can reserve bit 31 in u32 sk_tsflags. And if we ever have
> to double that flag size, it can move up to 63, as it is not UAPI in
> any way. This is a workaround to having a separate flags field in
> sockcm_cookie.
> 
> And have a BUILD_BUG_ON if SOF_TIMESTAMPING_LAST reaches this reserved
> region.

Yeah, I was also thinking of it not being UAPI, that's why I tried to
avoid it in my RFC using 0 as a reserved value. Do you think
SK_FLAGS_CMSG_TS_OPT_ID is good naming for it?

Thanks,
Vadim

