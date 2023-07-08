Return-Path: <netdev+bounces-16203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C664674BCC2
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490941C210E9
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CC1FCC;
	Sat,  8 Jul 2023 08:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E015BF
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 08:07:37 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FAE1FC4
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:07:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401f4408955so72351cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688803656; x=1691395656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJMT9RfmJdFj+qWRA0V7YVTuva1K49YKbnZ4HBpKTpA=;
        b=e6voY0CR9DtH8LGe9l6VCDujLe19lPWT+chXTxlymWFXbbY2bj9FcEfnaJTGm1nbIB
         jHVFnQMArYeJjRrIK/C6whr9g5GXamVM+wVaf3Jf1b+U/YkaCnGx3a4IQKITEpgcr01I
         BlMt8PMZp3qSk53m/M1PP6/tWkLDE1AcyA0FexB3g0NfuzSw32Rn+RDpfuSopLZ1Q/o5
         xYA7McGdNqyOBXBnKXNChjZoYyHeYZD+btoOVQl1K+RKpBx1qHbe9xzYH57nrxuC251D
         4i39CWve4fAQ+Hkd3cZ8tUMW3HKFHoXM8V3EUGOMH0b1FCaUUKLh3npxoIz6+Lae7q6x
         BG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688803656; x=1691395656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJMT9RfmJdFj+qWRA0V7YVTuva1K49YKbnZ4HBpKTpA=;
        b=fIOnRlfa3Oj2EimPKNuXVVL8G3iHelNQyomUM+BA09Be7SyK4Nbh+AQDIva7BzkEdm
         Vngd81gJPq4/wUNewb9iXeCkvgns763UypHJUBXu+5UXeMva8kFQq2XPFNXVvMKOpqHx
         vTB5YV5HtDSAzWF0wxcp6DAy9M8uGgK5R4G6VUxg8qKdqlkRl92Mk1Jb+8W0ScjjA8hP
         oCuYuZ4IxYwThELKATIgeEOxS36sdJJ03cyjEzkKriNlDBn1Bpw7gRvmy6C32AHYmyA+
         zifpHSIiI/O4Nfs0kUXvinxu5qmWsGJfqEVajCfPovN4tekJJsqzaov6PGTD8MTQTpuW
         XmDg==
X-Gm-Message-State: ABy/qLZfye6dML241DAp9AYrsz9NCM534fcGZlPLSZx83/LDzs41KVR/
	zKsEiFEqOZY5LPFBYBTRPjsy5UTyGINzQSO5QWvNfw==
X-Google-Smtp-Source: APBJJlEhsZUAmeKN1xGjf/JDQ2M4yLH1+fjBdCpffMQE1qOMOeZZTbtj4OuM/SqSyZjz18EWJcj8+xxCAxdpFXxlX10=
X-Received: by 2002:a05:622a:1a8b:b0:3f9:b81c:3a0f with SMTP id
 s11-20020a05622a1a8b00b003f9b81c3a0fmr58724qtc.17.1688803655654; Sat, 08 Jul
 2023 01:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230708014327.87547-1-kuniyu@amazon.com>
In-Reply-To: <20230708014327.87547-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Jul 2023 10:07:24 +0200
Message-ID: <CANn89iKSEvBo0jBBFpps=qiZB9=+KCU1+TWqWJhpuPrB6YLWcQ@mail.gmail.com>
Subject: Re: [PATCH v3 net] icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev
 in icmp6_dev().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Wang Yufen <wangyufen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 3:43=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> has the link-local address as src and dst IP and will be forwarded to
> an external IP in the IPv6 Ext Hdr.
>
> For example, the script below generates a packet whose src IP is the
> link-local address and dst is updated to 11::.
>
>   # for f in $(find /proc/sys/net/ -name *seg6_enabled*); do echo 1 > $f;=
 done
>   # python3
>   >>> from socket import *
>   >>> from scapy.all import *
>   >>>
>   >>> SRC_ADDR =3D DST_ADDR =3D "fe80::5054:ff:fe12:3456"
>   >>>
>   >>> pkt =3D IPv6(src=3DSRC_ADDR, dst=3DDST_ADDR)
>   >>> pkt /=3D IPv6ExtHdrSegmentRouting(type=3D4, addresses=3D["11::", "2=
2::"], segleft=3D1)
>   >>>
>   >>> sk =3D socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)
>   >>> sk.sendto(bytes(pkt), (DST_ADDR, 0))
>
> For such a packet, we call ip6_route_input() to look up a route for the
> next destination in these three functions depending on the header type.
>
>   * ipv6_rthdr_rcv()
>   * ipv6_rpl_srh_rcv()
>   * ipv6_srh_rcv()
>
> If no route is found, ip6_null_entry is set to skb, and the following
> dst_input(skb) calls ip6_pkt_drop().
>
> Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
> as the input device is the loopback interface.  Then, we have to check if
> skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
> for ip6_null_entry.
>
>
> Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device wi=
th address")
> Reported-by: Wang Yufen <wangyufen@huawei.com>
> Closes: https://lore.kernel.org/netdev/c41403a9-c2f6-3b7e-0c96-e1901e605c=
d0@huawei.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
> v3:
>   * Fix Closes: link
>
> v2: https://lore.kernel.org/netdev/20230708002145.64069-1-kuniyu@amazon.c=
om/
>   * Add Reviewed-by
>   * s/fib6_null_entry/ip6_null_entry/g
>
> v1: https://lore.kernel.org/netdev/20230706233024.63730-1-kuniyu@amazon.c=
om/
> ---
>  net/ipv6/icmp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 9edf1f45b1ed..65fa5014bc85 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -424,7 +424,10 @@ static struct net_device *icmp6_dev(const struct sk_=
buff *skb)
>         if (unlikely(dev->ifindex =3D=3D LOOPBACK_IFINDEX || netif_is_l3_=
master(skb->dev))) {
>                 const struct rt6_info *rt6 =3D skb_rt6_info(skb);
>
> -               if (rt6)
> +               /* The destination could be an external IP in Ext Hdr (SR=
v6, RPL, etc.),
> +                * and ip6_null_entry could be set to skb if no route is =
found.
> +                */
> +               if (rt6 && rt6->rt6i_idev)
>                         dev =3D rt6->rt6i_idev->dev;
>         }

Reviewed-by: Eric Dumazet <edumazet@google.com>

