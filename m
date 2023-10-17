Return-Path: <netdev+bounces-41839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BB7CBFF2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FC5B20F8B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C38405FF;
	Tue, 17 Oct 2023 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SuylpcJH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1AC405F4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:53:30 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672198
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697536394; x=1698141194; i=wahrenst@gmx.net;
 bh=dOSp/RzfzVSHZYaaUsOOg1/di9z7FadK6GjF7oedhH4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SuylpcJHkF4vpInRBlW3Pc6oV8mfelyHSGg239KLm4XDaPHi5uIsXebyajbV1WYV8zjsO/pejaF
 zQn+5TKbH/5HcLnE7BejGXxtHPMv5zJZ3aDoMIBWi5CmBDIyQBtJcmzKUmkAHF+nRP6e+GL71ufci
 iM/vQ/C245uyBQ2Tn8EgU4Ug913PkoE7zxt5QhXkvsXEG22L4EJEML6uzt+1U31w1mX7KosD0IBtg
 Aaa3LTsdFI13TjcbX4ffmN+3iXk5tug7R/6S+pff6PfSdA9lmZ6nAG9Ltwmlx4ojBN00CyLaFbAHD
 fiKem/89wJmjq87/cZXVvFRQXKFN4eAbLeLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1r8HhY3Wn3-00K73N; Tue, 17
 Oct 2023 11:53:13 +0200
Message-ID: <ea9578d1-be40-48ab-b9d3-826bb5006756@gmx.net>
Date: Tue, 17 Oct 2023 11:53:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org,
 Yuchung Cheng <ycheng@google.com>
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
 <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net>
 <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
 <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
 <CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=2ES69tTDJRziw@mail.gmail.com>
 <76a0c751-c827-4b6e-b27f-ced3ba2834fb@gmx.net>
 <CANn89i+6VuixihW4YyHntjj_GOKOOyXt8hHF8TJtB3bm07CZ6w@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CANn89i+6VuixihW4YyHntjj_GOKOOyXt8hHF8TJtB3bm07CZ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:062Zkpg3cv6G1FCFlWIL9cFrwvOdzMoa/clPgev5vXZSsXVKtyt
 kUZVkx7+ICFrHhnxbhGEST4NcBkxXMMulArQC6WKO8vkfpAAlMwtwuXZ26OGA+NoohcxE8t
 MRcS5oWZECW3/QeLIvWNRpQbNdzNhvHFx+LMWV+Pat1M5yV0AGkZ4T8con0nfYSoD5VSJ8E
 ujJc9hS97CUthmQx5EqlA==
UI-OutboundReport: notjunk:1;M01:P0:EJPRPk9YkSA=;RkVLXfEhRg5p9OCg6v+hvL7uKq2
 noDcQg0zzLzAkG63FfBVvoLnFz8wYRrjUhzI8N6tk+RzYuFNxf6R5lXVSOZsfbWo9RWWzbicl
 pl/9HIC7xPX7RCWl+VeTl6Tz8sDRpuJkjVgOLNAiGf2jKrcrXe2/dDt9wDAcNRPnjD/7kDnOT
 pbG5UHTE6MSqE8UUCDGVQF/mqYEa6i78wjbaReii74W+ABhDbk3QA2IX8sb500OdR+KzKbjMn
 xGVlRDtg4QiiXWsD6rfp+fYNn0Kjk2YCJYFRGzKvIqgFDnvPwfIynj9aq19CyMegjXVwDOkMY
 iqqJyAXJMV3gn6KfGtSn/oVVJZDaWVG8/s4fglZOaSh4BdmTf75La3F+QKBX46yleB+X7sR2N
 B4rUiOWOpuK9HdUqG07FR4FX7V/oYsYodSdMIKpW69nzUTyDPzAlBmOiJlAq3PjxpETq0C+RD
 kx9t+yWEqJ7b2ZD+M9pmmw46chlZI+9G1Qa1PtvEyUwMEcGrZzH6xMcVI9re7OD8uCtRCrlzB
 ZuxrFa2d8p2Jrp5HCSIbS9UO/l2qjre9S8iQyJPtlvDq5N5pWqyJVA5mTUqu6E9JO4ug5lZ7n
 JQh4hf0ZjIY0mRQdfTj9myWBR8+qJ6BT11l3HUiAkMnnAYmDb0eAvOG2D5q3SiCGqXKuINONF
 4IO7OnILpW62egqxGQQl3J4G0szaN1I+5MZNeaZxoOd0TUNqzlr4iI80RWj4biMdXGAc9L++q
 XfW3TJnGaVnro8hvnHW+m2w64poI8Ow7DiVBnBeWcC7DCmB5Jb/5Qmsw7eI961N66EQUnacC8
 cEWnd/hxHpeYMVGOg+lO830GaH2xaDjwP1EijDcFFNPvQZp/dpLopdwh2U5tjAFfFYQNqBx/C
 N8FZnmF22Kdc26T+ss/CLjCQbhbu6iBS+BaCx4hFR8QMNw4PrAdL2rs0K3lrmduQ1cMEbj2Hn
 e/2shKGZhtJj9sKPrLDcOnmgfr4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

Am 16.10.23 um 20:47 schrieb Eric Dumazet:
> On Mon, Oct 16, 2023 at 8:25=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>> Hi Eric,
>>
>> Am 16.10.23 um 12:35 schrieb Eric Dumazet:
>>> On Mon, Oct 16, 2023 at 11:49=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
>>> Speaking of TSQ, it seems an old change (commit 75eefc6c59fd "tcp:
>>> tsq: add a shortcut in tcp_small_queue_check()")
>>> has been accidentally removed in 2017 (75c119afe14f "tcp: implement
>>> rb-tree based retransmit queue")
>>>
>>> Could you try this fix:
>>>
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec8440=
928e22a290712f0b6b
>>> 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
>>>           return true;
>>>    }
>>>
>>> +static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
>>> +{
>>> +       const struct rb_node *node =3D sk->tcp_rtx_queue.rb_node;
>>> +
>>> +       /* No skb in the rtx queue. */
>>> +       if (!node)
>>> +               return true;
>>> +
>>> +       /* Only one skb in rtx queue. */
>>> +       return !node->rb_left && !node->rb_right;
>>> +}
>>> +
>>>    /* TCP Small Queues :
>>>     * Control number of packets in qdisc/devices to two packets / or ~=
1 ms.
>>>     * (These limits are doubled for retransmits)
>>> @@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock
>>> *sk, const struct sk_buff *skb,
>>>                   limit +=3D extra_bytes;
>>>           }
>>>           if (refcount_read(&sk->sk_wmem_alloc) > limit) {
>>> -               /* Always send skb if rtx queue is empty.
>>> +               /* Always send skb if rtx queue is empty or has one sk=
b.
>>>                    * No need to wait for TX completion to call us back=
,
>>>                    * after softirq/tasklet schedule.
>>>                    * This helps when TX completions are delayed too mu=
ch.
>>>                    */
>>> -               if (tcp_rtx_queue_empty(sk))
>>> +               if (tcp_rtx_queue_empty_or_single_skb(sk))
>>>                           return false;
>>>
>>>                   set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
>> This patch applied on top of Linux 6.1.49, TSO on, gso_max_size 65535,
>> CONFIG_HZ_100=3Dy
>>
>> root@tarragon:/boot# iperf -t 10 -i 1 -c 192.168.1.129
>> ------------------------------------------------------------
>> Client connecting to 192.168.1.129, TCP port 5001
>> TCP window size:  192 KByte (default)
>> ------------------------------------------------------------
>> [  3] local 192.168.1.12 port 59714 connected with 192.168.1.129 port 5=
001
>> [ ID] Interval       Transfer     Bandwidth
>> [  3]  0.0- 1.0 sec  11.5 MBytes  96.5 Mbits/sec
>> [  3]  1.0- 2.0 sec  11.4 MBytes  95.4 Mbits/sec
>> [  3]  2.0- 3.0 sec  11.1 MBytes  93.3 Mbits/sec
>> [  3]  3.0- 4.0 sec  11.2 MBytes  94.4 Mbits/sec
>> [  3]  4.0- 5.0 sec  11.1 MBytes  93.3 Mbits/sec
>> [  3]  5.0- 6.0 sec  11.2 MBytes  94.4 Mbits/sec
>> [  3]  6.0- 7.0 sec  11.2 MBytes  94.4 Mbits/sec
>> [  3]  7.0- 8.0 sec  11.1 MBytes  93.3 Mbits/sec
>> [  3]  8.0- 9.0 sec  11.4 MBytes  95.4 Mbits/sec
>> [  3]  9.0-10.0 sec  11.2 MBytes  94.4 Mbits/sec
>> [  3]  0.0-10.0 sec   113 MBytes  94.4 Mbits/sec
>>
>> The figures are comparable to disabling TSO -> Good
>>
>> Thanks
> Great. I suspect a very slow TX completion from fec then.
>
> Could you use the following bpftrace program while your iperf is running=
 ?
unfortuntely there is no bpftrace and most of its dependencies on my
platform. I looked at some guides and it seems to have a lot of (build)
dependencies. On a PC this won't be a problem, but on my ARM platform
there is only 1 GB eMMC space left.

Before investing a lot of time to get bpftrace running, is there an
alternative solution?
>
> .bpftrace -e '
> k:__dev_queue_xmit {
>   $skb =3D (struct sk_buff *)arg0;
>   if ($skb->fclone =3D=3D 2) {
>    @start[$skb] =3D nsecs;
>   }
> }
> k:__kfree_skb {
>   $skb =3D (struct sk_buff *)arg0;
>   if ($skb->fclone =3D=3D 2 && @start[$skb]) {
>    @tx_compl_usecs =3D hist((nsecs - @start[$skb])/1000);
>    delete(@start[$skb]);
>   }
> }
> END { clear(@start); }'


