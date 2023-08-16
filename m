Return-Path: <netdev+bounces-28027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2D77E01D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD41C20F19
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76599101E6;
	Wed, 16 Aug 2023 11:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66271DF57
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:15:34 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D62708
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:15:14 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-791b8525b59so2076815241.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184514; x=1692789314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrUZzV9P7VR48aAVxgZ3COT0FhuTOFIvlaXknTOpcA8=;
        b=RJq/Ce3kyDiRJW9n+SOGWVDLNuV7JDjmnTf64M0lCNAxcHAzNFP1MQoUvZhw2KKSJF
         4KZdsygggdQPBCCca1WHth7CC8GsO8qrPKsyyMDBn90Lp1gJxaiYtVV0JOrJt6KW1XIx
         Od40J77SFRfs1ttgE+omfJ4blXFHYH2vf0AFeDjzuvdg4QYxwQdkncFAKef85Xh88PnX
         lJwzP9Wt3rvYFpqoOH7sQDZnFg4LMSi60Wq/xUQOdZqljmkV7dbXTXOqhzOvwYOTEXEO
         FCKXUkcpOwv1x8b2KTL8mMLaP5w/5Rg87oDmnLjYq++T0PhTch2Te7Yaw6INgvHosXKH
         S2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184514; x=1692789314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrUZzV9P7VR48aAVxgZ3COT0FhuTOFIvlaXknTOpcA8=;
        b=e59zNrofeb6196Ao8G4DYh4fAmK1wKH5U3VFnlGJgPUQCV0pUOI10sQiLvVX9GHjr/
         nK3SkG1xpSI7LEWiUXi8xpJ0lTCAnr0XhTJJ/8FgS8EH+PI2ic3HpyhAC2pediDzyCfQ
         iA2iuzpwwtGsLWG1MJcraUwk+gG/J2I6uKLL/WaPSFg2o3qIyQEQoOO6GlaldoWS4VY7
         aNobv1aflSZSEbbKL1hzHWhSCJIe+EFJaEKsr5CFAHxezBGV0Lr9JeudSf+dQCTVpCMo
         uFaJBd+W8tdGcDS5+MZsJlUOmXFHPB5dx0bo3ONYA/XBAcxy59ZF/g55CajrIWO3Ki2B
         p0PA==
X-Gm-Message-State: AOJu0YwYFTEok/TmY5pEn5sy83/8b8razAkhfH9Zh58PkhZBP2m2B4H0
	pnOVRaGHvHdCf5cCGuXql0NR6kSGP5wONt3nVK0vtlk6juI=
X-Google-Smtp-Source: AGHT+IENSFaGuGEi+hTionc7LXDjwmSaYJQTiqWGGwmUf1//bvExisR8WWUJ+rPk3FYUU1Uiiv0wmnf3nEsWv0xDW/E=
X-Received: by 2002:a67:e210:0:b0:440:ab90:7c95 with SMTP id
 g16-20020a67e210000000b00440ab907c95mr1301579vsa.9.1692184513810; Wed, 16 Aug
 2023 04:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1692172297.git.antony.antony@secunet.com> <36dc1203db9169f553797a6e2d2a46265f19dd8b.1692172297.git.antony.antony@secunet.com>
In-Reply-To: <36dc1203db9169f553797a6e2d2a46265f19dd8b.1692172297.git.antony.antony@secunet.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 16 Aug 2023 14:15:01 +0300
Message-ID: <CAHsH6GuttG3=7cWzQBhZm--zznTBK=1jVafTmo+qDRxD-YYrEw@mail.gmail.com>
Subject: Re: [PATCH v4 ipsec-next 2/3] xfrm: Support GRO for IPv4 ESP in UDP encapsulation.
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Antony,

On Wed, Aug 16, 2023 at 12:57=E2=80=AFPM Antony Antony
<antony.antony@secunet.com> wrote:
>
> From: Steffen Klassert <steffen.klassert@secunet.com>
>
> This patch enables the GRO codepath for IPv4 ESP in UDP encapsulated
> packets. Decapsulation happens at L2 and saves a full round through
> the stack for each packet. This is also needed to support HW offload
> for ESP in UDP encapsulation.
>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  include/net/gro.h       |  2 +-
>  include/net/xfrm.h      |  4 ++
>  net/ipv4/esp4_offload.c |  6 ++-
>  net/ipv4/udp.c          | 16 ++++++-
>  net/ipv4/xfrm4_input.c  | 98 ++++++++++++++++++++++++++++++++---------
>  5 files changed, 103 insertions(+), 23 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index a4fab706240d..41c12c5d1ea1 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -29,7 +29,7 @@ struct napi_gro_cb {
>         /* Number of segments aggregated. */
>         u16     count;
>
> -       /* Used in ipv6_gro_receive() and foo-over-udp */
> +       /* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
>         u16     proto;
>
>         /* jiffies when first packet was created/queued */
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 33ee3f5936e6..e980f442ddcd 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1671,6 +1671,8 @@ void xfrm_local_error(struct sk_buff *skb, int mtu)=
;
>  int xfrm4_extract_input(struct xfrm_state *x, struct sk_buff *skb);
>  int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
>                     int encap_type);
> +struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_hea=
d *head,
> +                                       struct sk_buff *skb);

Why does this function need to be declared twice in this file?

>  int xfrm4_transport_finish(struct sk_buff *skb, int async);
>  int xfrm4_rcv(struct sk_buff *skb);
>
> @@ -1711,6 +1713,8 @@ int xfrm6_output(struct net *net, struct sock *sk, =
struct sk_buff *skb);
>  void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu);
>  int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
>  int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
> +struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_hea=
d *head,
> +                                       struct sk_buff *skb);
>  int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval,
>                      int optlen);
>  #else
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index 77bb01032667..34ebfdf0e986 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -32,6 +32,7 @@ static struct sk_buff *esp4_gro_receive(struct list_hea=
d *head,
>         int offset =3D skb_gro_offset(skb);
>         struct xfrm_offload *xo;
>         struct xfrm_state *x;
> +       int encap_type =3D 0;
>         __be32 seq;
>         __be32 spi;
>
> @@ -69,6 +70,9 @@ static struct sk_buff *esp4_gro_receive(struct list_hea=
d *head,
>
>         xo->flags |=3D XFRM_GRO;
>
> +       if (NAPI_GRO_CB(skb)->proto =3D=3D IPPROTO_UDP)
> +               encap_type =3D UDP_ENCAP_ESPINUDP;
> +
>         XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 =3D NULL;
>         XFRM_SPI_SKB_CB(skb)->family =3D AF_INET;
>         XFRM_SPI_SKB_CB(skb)->daddroff =3D offsetof(struct iphdr, daddr);
> @@ -76,7 +80,7 @@ static struct sk_buff *esp4_gro_receive(struct list_hea=
d *head,
>
>         /* We don't need to handle errors from xfrm_input, it does all
>          * the error handling and frees the resources on error. */
> -       xfrm_input(skb, IPPROTO_ESP, spi, 0);
> +       xfrm_input(skb, IPPROTO_ESP, spi, encap_type);
>
>         return ERR_PTR(-EINPROGRESS);
>  out_reset:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index aa32afd871ee..337607b17ebd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2681,6 +2681,17 @@ void udp_destroy_sock(struct sock *sk)
>         }
>  }
>
> +static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short =
family,
> +                                      struct udp_sock *up)
> +{
> +#ifdef CONFIG_XFRM
> +       if (up->gro_enabled && encap_type =3D=3D UDP_ENCAP_ESPINUDP) {
> +               if (family =3D=3D AF_INET)
> +                       up->gro_receive =3D xfrm4_gro_udp_encap_rcv;
> +       }
> +#endif
> +}
> +
>  /*
>   *     Socket option code for UDP
>   */
> @@ -2730,12 +2741,14 @@ int udp_lib_setsockopt(struct sock *sk, int level=
, int optname,
>                 case 0:
>  #ifdef CONFIG_XFRM
>                 case UDP_ENCAP_ESPINUDP:
> +                       set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, up=
);
> +                       fallthrough;
>                 case UDP_ENCAP_ESPINUDP_NON_IKE:
>  #if IS_ENABLED(CONFIG_IPV6)
>                         if (sk->sk_family =3D=3D AF_INET6)
>                                 up->encap_rcv =3D ipv6_stub->xfrm6_udp_en=
cap_rcv;
> -                       else
>  #endif
> +                       if (sk->sk_family =3D=3D AF_INET)

Why is this change needed?

>                                 up->encap_rcv =3D xfrm4_udp_encap_rcv;
>  #endif
>                         fallthrough;
> @@ -2773,6 +2786,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, =
int optname,
>                         udp_tunnel_encap_enable(sk->sk_socket);
>                 up->gro_enabled =3D valbool;
>                 up->accept_udp_l4 =3D valbool;
> +               set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family,=
 up);
>                 release_sock(sk);
>                 break;
>
> diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
> index ad2afeef4f10..b57f477c745e 100644
> --- a/net/ipv4/xfrm4_input.c
> +++ b/net/ipv4/xfrm4_input.c
> @@ -17,6 +17,8 @@
>  #include <linux/netfilter_ipv4.h>
>  #include <net/ip.h>
>  #include <net/xfrm.h>
> +#include <net/protocol.h>
> +#include <net/gro.h>
>
>  static int xfrm4_rcv_encap_finish2(struct net *net, struct sock *sk,
>                                    struct sk_buff *skb)
> @@ -72,14 +74,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int as=
ync)
>         return 0;
>  }
>
> -/* If it's a keepalive packet, then just eat it.
> - * If it's an encapsulated packet, then pass it to the
> - * IPsec xfrm input.
> - * Returns 0 if skb passed to xfrm or was dropped.
> - * Returns >0 if skb should be passed to UDP.
> - * Returns <0 if skb should be resubmitted (-ret is protocol)
> - */
> -int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> +static int __xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, b=
ool pull)
>  {
>         struct udp_sock *up =3D udp_sk(sk);
>         struct udphdr *uh;
> @@ -90,8 +85,8 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff=
 *skb)
>         __be32 *udpdata32;
>         __u16 encap_type =3D up->encap_type;
>
> -       /* if this is not encapsulated socket, then just return now */
> -       if (!encap_type)
> +       /* if unknown encap_type then just return now */
> +       if (encap_type !=3D UDP_ENCAP_ESPINUDP && encap_type !=3D UDP_ENC=
AP_ESPINUDP_NON_IKE)

This change is unclear to me - the patch adds support for GRO on
UDP_ENCAP_ESPINUDP.
How can we now get other encap types here? and why wasn't the old condition=
 ok?

>                 return 1;
>
>         /* If this is a paged skb, make sure we pull up
> @@ -110,7 +105,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_bu=
ff *skb)
>         case UDP_ENCAP_ESPINUDP:
>                 /* Check if this is a keepalive packet.  If so, eat it. *=
/
>                 if (len =3D=3D 1 && udpdata[0] =3D=3D 0xff) {
> -                       goto drop;
> +                       return -EINVAL;
>                 } else if (len > sizeof(struct ip_esp_hdr) && udpdata32[0=
] !=3D 0) {
>                         /* ESP Packet without Non-ESP header */
>                         len =3D sizeof(struct udphdr);
> @@ -121,7 +116,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_bu=
ff *skb)
>         case UDP_ENCAP_ESPINUDP_NON_IKE:
>                 /* Check if this is a keepalive packet.  If so, eat it. *=
/
>                 if (len =3D=3D 1 && udpdata[0] =3D=3D 0xff) {
> -                       goto drop;
> +                       return -EINVAL;
>                 } else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_h=
dr) &&
>                            udpdata32[0] =3D=3D 0 && udpdata32[1] =3D=3D 0=
) {
>
> @@ -139,7 +134,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_bu=
ff *skb)
>          * protocol to ESP, and then call into the transform receiver.
>          */
>         if (skb_unclone(skb, GFP_ATOMIC))
> -               goto drop;
> +               return -EINVAL;
>
>         /* Now we can update and verify the packet length... */
>         iph =3D ip_hdr(skb);
> @@ -147,24 +142,87 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_=
buff *skb)
>         iph->tot_len =3D htons(ntohs(iph->tot_len) - len);
>         if (skb->len < iphlen + len) {
>                 /* packet is too small!?! */
> -               goto drop;
> +               return -EINVAL;
>         }
>
>         /* pull the data buffer up to the ESP header and set the
>          * transport header to point to ESP.  Keep UDP on the stack
>          * for later.
>          */
> -       __skb_pull(skb, len);
> -       skb_reset_transport_header(skb);
> +       if (pull) {
> +               __skb_pull(skb, len);
> +               skb_reset_transport_header(skb);
> +       } else {
> +               skb_set_transport_header(skb, len);
> +       }
>
>         /* process ESP */
> -       return xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, encap_type);
> -
> -drop:
> -       kfree_skb(skb);
>         return 0;
>  }
>
> +/* If it's a keepalive packet, then just eat it.
> + * If it's an encapsulated packet, then pass it to the
> + * IPsec xfrm input.
> + * Returns 0 if skb passed to xfrm or was dropped.
> + * Returns >0 if skb should be passed to UDP.
> + * Returns <0 if skb should be resubmitted (-ret is protocol)
> + */
> +int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +       int ret;
> +
> +       ret =3D __xfrm4_udp_encap_rcv(sk, skb, true);
> +       if (!ret)
> +               return xfrm4_rcv_encap(skb, IPPROTO_ESP, 0,
> +                                      udp_sk(sk)->encap_type);
> +
> +       if (ret < 0) {
> +               kfree_skb(skb);
> +               return 0;
> +       }
> +
> +       return ret;
> +}
> +
> +struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_hea=
d *head,
> +                                       struct sk_buff *skb)
> +{
> +       int offset =3D skb_gro_offset(skb);
> +       const struct net_offload *ops;
> +       struct sk_buff *pp =3D NULL;
> +       int ret;
> +
> +       offset =3D offset - sizeof(struct udphdr);
> +
> +       if (!pskb_pull(skb, offset))
> +               return NULL;
> +
> +       rcu_read_lock();
> +       ops =3D rcu_dereference(inet_offloads[IPPROTO_ESP]);
> +       if (!ops || !ops->callbacks.gro_receive)
> +               goto out;
> +
> +       ret =3D __xfrm4_udp_encap_rcv(sk, skb, false);
> +       if (ret)
> +               goto out;
> +
> +       skb_push(skb, offset);
> +       NAPI_GRO_CB(skb)->proto =3D IPPROTO_UDP;
> +
> +       pp =3D call_gro_receive(ops->callbacks.gro_receive, head, skb);
> +       rcu_read_unlock();
> +
> +       return pp;
> +
> +out:
> +       rcu_read_unlock();
> +       skb_push(skb, offset);
> +       NAPI_GRO_CB(skb)->same_flow =3D 0;
> +       NAPI_GRO_CB(skb)->flush =3D 1;
> +
> +       return NULL;
> +}
> +
>  int xfrm4_rcv(struct sk_buff *skb)
>  {
>         return xfrm4_rcv_spi(skb, ip_hdr(skb)->protocol, 0);
> --
> 2.30.2
>

