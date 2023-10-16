Return-Path: <netdev+bounces-41506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15E7CB274
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2C1C2034D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF333997;
	Mon, 16 Oct 2023 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RXZxHFGF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0931A70
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:25:44 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60526E1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697480733; x=1698085533; i=wahrenst@gmx.net;
 bh=3/ON7I3LZ8x2C0p3GLrrWIJmHCRpz9LGGnbxlJL8lco=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RXZxHFGF9XlP1Itqee/CZ+bVAEEjhjiTLkAZZEVy1RcCMm5JO0Cbj12rzutGGYdHqcIRH8/LL5f
 kTN3ihn6TgsLS4PGdqzR0VqGxXNcnawl/mw8SoVAeZPjdbnP1FF7oeLgbrEIF6OXoqFQvI1+LyWc9
 yTEvuqTJng+f5TjYBcvorJz8hQjABWu8VA5CvUVtYl4HXqTV6VCZnP1ncUxel6Q7MY07yujg9VO1S
 puKV8fdciFI4OcQz/nG+v1JgxxCMShjGJm39uy0IlboI2duydFc/sikNn9axU7WihZUsrcBTTubS8
 KT9Q2nvqOj1RF4SipXV2Pcx+dOc2M8yS6hRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1qsBIa0FW5-000HyD; Mon, 16
 Oct 2023 20:25:33 +0200
Message-ID: <76a0c751-c827-4b6e-b27f-ced3ba2834fb@gmx.net>
Date: Mon, 16 Oct 2023 20:25:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
Content-Language: en-US
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
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=2ES69tTDJRziw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GN46GLwkUyOpFJU23lryt1Dd5IH5huPjcl5yOVWE+4Bln3NBKJj
 7D8GX31UmjtzJfur+uhLfRL4cLbjKxJ+4ClYPgkv/Z2G5grrZIoNf7+8EjwWmxg4fjQh4TX
 xAI/vM7pv1prEOXclfnH90HqAsZW5p1QWyVCvAaBWimaQWYIZ1ExjnYz25coYYemq7krvas
 q8rEAOufToEeCVOAnpCfQ==
UI-OutboundReport: notjunk:1;M01:P0:fs1TsRK4P7Q=;cV9Jy61WmwlIDcG6Egnt38HIlTg
 XWdOEY4JCQr/6WmD5Id+ReH0bM1KlmZiTOfdYUwtMDQl9tfNWu0G1DOR2dDvGeRChkE6LEaX3
 CXDYFfYC1i7gnCqgmEDvKSli3EzvQkp1gl4IW+mXrsR/syvnLpexXSr4D0XKox4lgX/D6Wmyk
 WM2QHykMdFu8YlZPHG2hiXBNXzJ1purDHnEmRoBkaPRYGR35xoJb52ZuTQhErVzswEQF76W26
 N6T+WytHGKj/h1ruv4VNkyqmdXIxNrqWduT0hJU/bilNNRbMj+un6mP9/sZCWp5oIw4uQLva9
 psceYssd/fMSIcX0mnkeHAXzTG8ffoE9wkEeAFwFCQ9sg3rTpyI2gDiKteNURV0rVA6eU6+23
 pCn/VVEJbHeWNJ1ZoH3G7TErk0Y/6tvFYGg5bn7V1nO7Bc4K1dJn/4aN+/vy+WRbr/Mc5SXw5
 3Xs6Nk57flnYo1RVCZb1vC+P70ihS8jQODV3c7bq4DrFqRdkExwkS1kWWio+3CCtVA4QigDPV
 zY8IhUgk6zURyA+gZJE4pJC+FGDWUuqcfNd9lECm9EH3OBf9DiEjhCb8kU4tevR9In7WKl3z9
 tFzs5fYHutSrN6/TS3p5s5FIJAA01Y1kBmWiKNubzYt7w7w/0XMU/6iPAVi9E2f6jOWi8/ksW
 /HggaPmQ6Z2cLpmIaKj3lrLuZYg1qgioX/iwnwFBv1LNzEmjHoMRixaApsjwzEcNbcBvN+ZcO
 ikScSP3BXFKCdGZa0RpqxzYWeXIyOFgHlgxs7CisPH4XwDrzT3IORxVoBCldStAdvxeV9tew4
 PpVInVMvcqPrNL3eggjW25l6+FFX7aY97nPkmgvsA0rUvxupeKSZZldjrsb5r2pRhYxvOYVVI
 L/X7kPDZzJxjz7CEG1Daqj3wiB/L1IQ2S5I0qKlhItAGq4LnPtmt51BYQhBtLzss4NWH3Gh16
 7EL15w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

Am 16.10.23 um 12:35 schrieb Eric Dumazet:
> On Mon, Oct 16, 2023 at 11:49=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> Speaking of TSQ, it seems an old change (commit 75eefc6c59fd "tcp:
> tsq: add a shortcut in tcp_small_queue_check()")
> has been accidentally removed in 2017 (75c119afe14f "tcp: implement
> rb-tree based retransmit queue")
>
> Could you try this fix:
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec844092=
8e22a290712f0b6b
> 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
>          return true;
>   }
>
> +static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
> +{
> +       const struct rb_node *node =3D sk->tcp_rtx_queue.rb_node;
> +
> +       /* No skb in the rtx queue. */
> +       if (!node)
> +               return true;
> +
> +       /* Only one skb in rtx queue. */
> +       return !node->rb_left && !node->rb_right;
> +}
> +
>   /* TCP Small Queues :
>    * Control number of packets in qdisc/devices to two packets / or ~1 m=
s.
>    * (These limits are doubled for retransmits)
> @@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock
> *sk, const struct sk_buff *skb,
>                  limit +=3D extra_bytes;
>          }
>          if (refcount_read(&sk->sk_wmem_alloc) > limit) {
> -               /* Always send skb if rtx queue is empty.
> +               /* Always send skb if rtx queue is empty or has one skb.
>                   * No need to wait for TX completion to call us back,
>                   * after softirq/tasklet schedule.
>                   * This helps when TX completions are delayed too much.
>                   */
> -               if (tcp_rtx_queue_empty(sk))
> +               if (tcp_rtx_queue_empty_or_single_skb(sk))
>                          return false;
>
>                  set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);

This patch applied on top of Linux 6.1.49, TSO on, gso_max_size 65535,
CONFIG_HZ_100=3Dy

root@tarragon:/boot# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size:=C2=A0 192 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 59714 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 11.5 MBytes=C2=A0 96.5 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 11.4 MBytes=C2=A0 95.4 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 11.4 MBytes=C2=A0 95.4 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 113 MBytes=C2=A0 94.4 Mbits/sec

The figures are comparable to disabling TSO -> Good

Thanks

