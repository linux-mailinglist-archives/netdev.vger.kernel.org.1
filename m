Return-Path: <netdev+bounces-125126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAB96BF7D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F3728ACFB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9B21DB53B;
	Wed,  4 Sep 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SO0xPeDI"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4531DA61A
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458530; cv=none; b=lU94BTSgnKwmAOE+h8eU/42+yffBJD3/3HdPWKQj4kw3LhAl4lqiYpo1p3pLOMMNtoMFabi0Pg197xNuCHT5YRHcVZS614gXbC/PF4FmPULMC38RUj/ae0ssU6qSNh4yxxU3xTjmodELAPbzKcrYOX9H7tS0qR0aOA79DBf4l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458530; c=relaxed/simple;
	bh=nZ1JhRKZYppIHwzXTxXLaZEWHe53BZJTkznCdgncZRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1VrEzAQRXC5DkrQRF5k6/ChTR5sCKfaKruzXF0VtZvt8BC9H2hVfBMhY6nViRXbFhSVh7w7FsU4ZnLZPs8FdWI2GDfE169cgjZnssK5Vkb8SzSGRZ6lz+ph3KUvESWdYBHKqL94qJMHGq4bK62O1lgBId+WfgM2ezBJgCGEwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SO0xPeDI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <422daa04-5bf6-4538-81d6-0c140cfd0f91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725458524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/oyNIkPDz08jk7iOx123fRz4cvS6ZK8Kwavn+KezKM=;
	b=SO0xPeDI8fBrbPEKSKBlkoS/n6wqiAHjRA4HvTr84UhsBuoyRgMxC+pYYCpfdlICRCsaLE
	bI0UmFY6DwyhDdJH1FTc/j3wCKDsKLUUaLMn709ZST3mGIckRc6qPd4o+RRbRRrv+BbgWE
	dTv5kilTUg8rJRBfizLrxaPJD+zRYls=
Date: Wed, 4 Sep 2024 15:01:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-2-vadfed@meta.com>
 <CAL+tcoDp5F57cZNsHrTAHE=Uqth89MsTyRC35CabTGJWY+vS_w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoDp5F57cZNsHrTAHE=Uqth89MsTyRC35CabTGJWY+vS_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 14:56, Jason Xing wrote:
> Hello Vadim,
> 
> On Wed, Sep 4, 2024 at 7:32 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>> timestamps and packets sent via socket. Unfortunately, there is no way
>> to reliably predict socket timestamp ID value in case of error returned
>> by sendmsg. For UDP sockets it's impossible because of lockless
>> nature of UDP transmit, several threads may send packets in parallel. In
>> case of RAW sockets MSG_MORE option makes things complicated. More
>> details are in the conversation [1].
>> This patch adds new control message type to give user-space
>> software an opportunity to control the mapping between packets and
>> values by providing ID with each sendmsg for UDP sockets.
>> The documentation is also added in this patch.
>>
>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   Documentation/networking/timestamping.rst | 13 +++++++++++++
>>   arch/alpha/include/uapi/asm/socket.h      |  2 ++
>>   arch/mips/include/uapi/asm/socket.h       |  2 ++
>>   arch/parisc/include/uapi/asm/socket.h     |  2 ++
>>   arch/sparc/include/uapi/asm/socket.h      |  2 ++
>>   include/net/inet_sock.h                   |  4 +++-
>>   include/net/sock.h                        |  2 ++
>>   include/uapi/asm-generic/socket.h         |  2 ++
>>   include/uapi/linux/net_tstamp.h           |  7 +++++++
>>   net/core/sock.c                           |  9 +++++++++
>>   net/ipv4/ip_output.c                      | 18 +++++++++++++-----
>>   net/ipv6/ip6_output.c                     | 18 +++++++++++++-----
>>   12 files changed, 70 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
>> index 5e93cd71f99f..e365526d6bf9 100644
>> --- a/Documentation/networking/timestamping.rst
>> +++ b/Documentation/networking/timestamping.rst
>> @@ -193,6 +193,19 @@ SOF_TIMESTAMPING_OPT_ID:
>>     among all possibly concurrently outstanding timestamp requests for
>>     that socket.
>>
>> +  The process can optionally override the default generated ID, by
>> +  passing a specific ID with control message SCM_TS_OPT_ID::
>> +
>> +    struct msghdr *msg;
>> +    ...
>> +    cmsg                        = CMSG_FIRSTHDR(msg);
>> +    cmsg->cmsg_level            = SOL_SOCKET;
>> +    cmsg->cmsg_type             = SCM_TS_OPT_ID;
>> +    cmsg->cmsg_len              = CMSG_LEN(sizeof(__u32));
>> +    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
>> +    err = sendmsg(fd, msg, 0);
>> +
>> +
>>   SOF_TIMESTAMPING_OPT_ID_TCP:
>>     Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
>>     timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
>> index e94f621903fe..99dec81e7c84 100644
>> --- a/arch/alpha/include/uapi/asm/socket.h
>> +++ b/arch/alpha/include/uapi/asm/socket.h
>> @@ -140,6 +140,8 @@
>>   #define SO_PASSPIDFD           76
>>   #define SO_PEERPIDFD           77
>>
>> +#define SCM_TS_OPT_ID          78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
>> index 60ebaed28a4c..bb3dc8feb205 100644
>> --- a/arch/mips/include/uapi/asm/socket.h
>> +++ b/arch/mips/include/uapi/asm/socket.h
>> @@ -151,6 +151,8 @@
>>   #define SO_PASSPIDFD           76
>>   #define SO_PEERPIDFD           77
>>
>> +#define SCM_TS_OPT_ID          78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
>> index be264c2b1a11..c3ab3b3289eb 100644
>> --- a/arch/parisc/include/uapi/asm/socket.h
>> +++ b/arch/parisc/include/uapi/asm/socket.h
>> @@ -132,6 +132,8 @@
>>   #define SO_PASSPIDFD           0x404A
>>   #define SO_PEERPIDFD           0x404B
>>
>> +#define SCM_TS_OPT_ID          0x404C
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
>> index 682da3714686..9b40f0a57fbc 100644
>> --- a/arch/sparc/include/uapi/asm/socket.h
>> +++ b/arch/sparc/include/uapi/asm/socket.h
>> @@ -133,6 +133,8 @@
>>   #define SO_PASSPIDFD             0x0055
>>   #define SO_PEERPIDFD             0x0056
>>
>> +#define SCM_TS_OPT_ID            0x0057
>> +
>>   #if !defined(__KERNEL__)
>>
>>
>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>> index 394c3b66065e..f01dd273bea6 100644
>> --- a/include/net/inet_sock.h
>> +++ b/include/net/inet_sock.h
>> @@ -174,6 +174,7 @@ struct inet_cork {
>>          __s16                   tos;
>>          char                    priority;
>>          __u16                   gso_size;
>> +       u32                     ts_opt_id;
>>          u64                     transmit_time;
>>          u32                     mark;
>>   };
>> @@ -241,7 +242,8 @@ struct inet_sock {
>>          struct inet_cork_full   cork;
>>   };
>>
>> -#define IPCORK_OPT     1       /* ip-options has been held in ipcork.opt */
>> +#define IPCORK_OPT             1       /* ip-options has been held in ipcork.opt */
>> +#define IPCORK_TS_OPT_ID       2       /* ts_opt_id field is valid, overriding sk_tskey */
>>
>>   enum {
>>          INET_FLAGS_PKTINFO      = 0,
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index f51d61fab059..c6554ad82961 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -952,6 +952,7 @@ enum sock_flags {
>>   };
>>
>>   #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
>> +#define SOCKCM_FLAG_TS_OPT_ID  BIT(31)
>>
>>   static inline void sock_copy_flags(struct sock *nsk, const struct sock *osk)
>>   {
>> @@ -1794,6 +1795,7 @@ struct sockcm_cookie {
>>          u64 transmit_time;
>>          u32 mark;
>>          u32 tsflags;
>> +       u32 ts_opt_id;
>>   };
>>
>>   static inline void sockcm_init(struct sockcm_cookie *sockc,
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..db3df3e74b01 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -135,6 +135,8 @@
>>   #define SO_PASSPIDFD           76
>>   #define SO_PEERPIDFD           77
>>
>> +#define SCM_TS_OPT_ID          78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
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
>> + */
>> +static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));
> 
> I saw some error occur in the patchwork:
> 
> ./usr/include/linux/net_tstamp.h:46:36: error: expected ‘)’ before ‘!=’ token
>     46 | static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));
>        |                                    ^~~
>        |                                    )
> make[5]: *** [../usr/include/Makefile:85:
> usr/include/linux/net_tstamp.hdrtest] Error 1
> make[4]: *** [../scripts/Makefile.build:485: usr/include] Error 2
> make[3]: *** [../scripts/Makefile.build:485: usr] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/home/nipa/net-next/wt-1/Makefile:1925: .] Error 2
> make[1]: *** [/home/nipa/net-next/wt-1/Makefile:224: __sub-make] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> Please see the link:
> https://netdev.bots.linux.dev/static/nipa/886766/13790642/build_32bit/stderr
> https://netdev.bots.linux.dev/static/nipa/886766/13790640/build_32bit/stderr
> 
> Thanks,
> Jason

Hmm, that's interesting.. Looks like some inconsistency in compilers.
I'll re-check it, thanks Jason.

