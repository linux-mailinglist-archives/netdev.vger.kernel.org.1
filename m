Return-Path: <netdev+bounces-56915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8838811553
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646731C21026
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4A2F505;
	Wed, 13 Dec 2023 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/mYYwcE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE425B9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:55:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso10850a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702479353; x=1703084153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RImoo4HyvxM/5Q7C9e5kxCbGV6orrP8ED3ilIUk7zeA=;
        b=A/mYYwcEmyMUIs9vmTOBUPZXJ1yeZ5lPyYKBtpMK7ioUj2V+rYztWuhCCzqFee3sRR
         wt6FsC/krpt1Ar+nmU3L/VeLpF/CBfJb6gQXJuGnIhjtl3VVNYbbK/Skav89vVlTLCAv
         OtEcgsIJil+ZHztcbFfrrWT4M8pb6fHLicb6zVuwLwcWyozdqNJwVRTa1Blfnh527ZW7
         KstnHvW7c+7BF0qwPO4R/DMpF9W9OyYocyL+Z/hHVWkqJqC0MEweAaltXUMVtUwU5NmS
         4ondLLPdzVZgCYavNQQiUF+qAt2dawznaomvcFX+n6Ti0Hulmd3MfV0n3/VG9Jp6NTN5
         kNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479353; x=1703084153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RImoo4HyvxM/5Q7C9e5kxCbGV6orrP8ED3ilIUk7zeA=;
        b=M4Le1qIias5eEX6V6hnkVpW4zz3PVFe//j+zKM4QpMQH/cDlgXYJpQzEEP3R84xU6M
         eVdk1HMkCwqFOoUsy81/e8nihWhMU8k2qQHvmLOsPiCC4SyPdAi1tg6Aov0rNmJxpYrE
         5ykTvDytxHvt7wYdguTIJN2z072v16LrVw6yh52vFlk5DhagvKntq/uxiczaeT5ACEKL
         qcrQzVM0zMf4y8wie+en33mcg1mlbZNaQXAc7xrGXSvg+/kye57i8WIAVJyek8baRS2P
         bj0v5NOVSbmI2QirberR7LzxpWzSOrE3aM+UcOOIGZmwxaxyu+707UKWempQ5wF2nWJG
         IBMA==
X-Gm-Message-State: AOJu0YxppeDG7wA74r5K20Qn9nmM/UVxN2DRDd/uZ9xVmKEgZ4QS/mIh
	nppIpCerSXDoek/NZ93b0CxSTrAJNuuusPQESwnQA8I2CcV1914IN32CmQ==
X-Google-Smtp-Source: AGHT+IFOMVJccgC6gEe3EZFBerhRYBVaMPsYQB5SVNSS7UwxavojZUkQW4aquYxI+xho3rbKimqe/r07EnrDzhIPCu0=
X-Received: by 2002:a50:c082:0:b0:54c:9996:7833 with SMTP id
 k2-20020a50c082000000b0054c99967833mr496058edf.7.1702479353051; Wed, 13 Dec
 2023 06:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac24d9b6-bfff-4700-a301-d4bd0dbb9313@gmail.com>
In-Reply-To: <ac24d9b6-bfff-4700-a301-d4bd0dbb9313@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 15:55:41 +0100
Message-ID: <CANn89iKEL4ZhL0BkRiY+5vnUQ6vC=eJ=J+gGFg6+CJ7QL8oOjQ@mail.gmail.com>
Subject: Re: [PATCH net] ipmr: support IP_PKTINFO on cache report IGMP msg
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:35=E2=80=AFPM Leone Fernando <leone4fernando@gmai=
l.com> wrote:
>
> In order to support IP_PKTINFO on those packets, we need to call
> ipv4_pktinfo_prepare, so introduced minor changes to this
> function to support this flow.
>
> When sending mrouted/pimd daemons a cache report IGMP msg, it is
> unnecessary to set dst on the newly created skb.
> It used to be necessary on older versions until
> commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
> changed the way IP_PKTINFO struct is been retrieved.
>

Given this is a 12 years old bug, I would rather target net-next tree.

> Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
> ---
>  include/net/ip.h       | 10 +++++++++-
>  net/ipv4/ip_sockglue.c | 25 ++++++++++++++++---------
>  net/ipv4/ipmr.c        | 12 +++++-------
>  net/ipv4/raw.c         |  2 +-
>  net/ipv4/udp.c         |  2 +-
>  5 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index b31be912489a..1b40b7386c56 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -767,7 +767,15 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct n=
et_device *dev);
>   *     Functions provided by ip_sockglue.c
>   */
>
> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb);
> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *iskb,
> +                       struct sk_buff *oskb);
> +
> +
> +static inline void ipv4_pktinfo_input_prepare(const struct sock *sk, str=
uct sk_buff *skb)
> +{
> +       ipv4_pktinfo_prepare(sk, skb, NULL);
> +}
> +
>  void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
>                          struct sk_buff *skb, int tlen, int offset);
>  int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index d7d13940774e..fb26963e3869 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1364,19 +1364,26 @@ int do_ip_setsockopt(struct sock *sk, int level, =
int optname,
>  /**
>   * ipv4_pktinfo_prepare - transfer some info from rtable to skb
>   * @sk: socket
> - * @skb: buffer
> + * @iskb: input buffer
> + * @oskb: out buffer
>   *
>   * To support IP_CMSG_PKTINFO option, we store rt_iif and specific
>   * destination in skb->cb[] before dst drop.
>   * This way, receiver doesn't make cache line misses to read rtable.
>   */
> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *iskb,
> +                         struct sk_buff *oskb)

This looks more complicated than needed.

I am pretty sure we can fix the bug without touching this function...

>  {
> -       struct in_pktinfo *pktinfo =3D PKTINFO_SKB_CB(skb);
> +       struct in_pktinfo *pktinfo =3D PKTINFO_SKB_CB(iskb);
>         bool prepare =3D inet_test_bit(PKTINFO, sk) ||
>                        ipv6_sk_rxinfo(sk);
>
> -       if (prepare && skb_rtable(skb)) {
> +       if (oskb) {
> +               memcpy(oskb->cb, iskb->cb, sizeof(iskb->cb));
> +               pktinfo =3D PKTINFO_SKB_CB(oskb);
> +       }
> +
> +       if (prepare && skb_rtable(iskb)) {
>                 /* skb->cb is overloaded: prior to this point it is IP{6}=
CB
>                  * which has interface index (iif) as the first member of=
 the
>                  * underlying inet{6}_skb_parm struct. This code then ove=
rlays
> @@ -1386,20 +1393,20 @@ void ipv4_pktinfo_prepare(const struct sock *sk, =
struct sk_buff *skb)
>                  * (e.g., process binds socket to eth0 for Tx which is
>                  * redirected to loopback in the rtable/dst).
>                  */
> -               struct rtable *rt =3D skb_rtable(skb);
> -               bool l3slave =3D ipv4_l3mdev_skb(IPCB(skb)->flags);
> +               struct rtable *rt =3D skb_rtable(iskb);
> +               bool l3slave =3D ipv4_l3mdev_skb(IPCB(iskb)->flags);
>
>                 if (pktinfo->ipi_ifindex =3D=3D LOOPBACK_IFINDEX)
> -                       pktinfo->ipi_ifindex =3D inet_iif(skb);
> +                       pktinfo->ipi_ifindex =3D inet_iif(iskb);
>                 else if (l3slave && rt && rt->rt_iif)
>                         pktinfo->ipi_ifindex =3D rt->rt_iif;
>
> -               pktinfo->ipi_spec_dst.s_addr =3D fib_compute_spec_dst(skb=
);
> +               pktinfo->ipi_spec_dst.s_addr =3D fib_compute_spec_dst(isk=
b);
>         } else {
>                 pktinfo->ipi_ifindex =3D 0;
>                 pktinfo->ipi_spec_dst.s_addr =3D 0;
>         }
> -       skb_dst_drop(skb);
> +       skb_dst_drop(iskb);
>  }
>
>  int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt=
val,
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 9e222a57bc2b..6ed7c88743f9 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1025,6 +1025,10 @@ static int ipmr_cache_report(const struct mr_table=
 *mrt,
>         struct sk_buff *skb;
>         int ret;
>
> +       mroute_sk =3D rcu_dereference(mrt->mroute_sk);
> +       if (!mroute_sk)
> +               return -EINVAL;
> +
>         if (assert =3D=3D IGMPMSG_WHOLEPKT || assert =3D=3D IGMPMSG_WRVIF=
WHOLE)
>                 skb =3D skb_realloc_headroom(pkt, sizeof(struct iphdr));
>         else
> @@ -1069,7 +1073,7 @@ static int ipmr_cache_report(const struct mr_table =
*mrt,
>                 msg =3D (struct igmpmsg *)skb_network_header(skb);
>                 msg->im_vif =3D vifi;
>                 msg->im_vif_hi =3D vifi >> 8;
> -               skb_dst_set(skb, dst_clone(skb_dst(pkt)));
> +               ipv4_pktinfo_prepare(mroute_sk, pkt, skb);

All we need is to call ipv4_pktinfo_prepare(sk, pkt);
then copy pkt->cb to skb->cb ?

>                 /* Add our header */
>                 igmp =3D skb_put(skb, sizeof(struct igmphdr));
>                 igmp->type =3D assert;
> @@ -1079,12 +1083,6 @@ static int ipmr_cache_report(const struct mr_table=
 *mrt,
>                 skb->transport_header =3D skb->network_header;
>         }
>
> -       mroute_sk =3D rcu_dereference(mrt->mroute_sk);
> -       if (!mroute_sk) {
> -               kfree_skb(skb);
> -               return -EINVAL;
> -       }
> -
>         igmpmsg_netlink_event(mrt, skb);
>
>         /* Deliver to mrouted */
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 27da9d7294c0..cde60c8deed4 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -292,7 +292,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buf=
f *skb)
>
>         /* Charge it to the socket. */
>
> -       ipv4_pktinfo_prepare(sk, skb);
> +       ipv4_pktinfo_input_prepare(sk, skb);
>         if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
>                 kfree_skb_reason(skb, reason);
>                 return NET_RX_DROP;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 89e5a806b82e..3e5a418c96c3 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2169,7 +2169,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, s=
truct sk_buff *skb)
>
>         udp_csum_pull_header(skb);
>
> -       ipv4_pktinfo_prepare(sk, skb);
> +       ipv4_pktinfo_input_prepare(sk, skb);
>         return __udp_queue_rcv_skb(sk, skb);
>
>  csum_error:
> --
> 2.34.1
>

