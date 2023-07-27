Return-Path: <netdev+bounces-21919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF972765463
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F092282339
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09C16439;
	Thu, 27 Jul 2023 12:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC0FBFA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:52:22 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF435AD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:52:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so281981cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690462328; x=1691067128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbxwpGLeivztqxhT2pHp7OuwmFwsVMzhXAPdU1zv9GA=;
        b=Lvt2cKI9qFID5RbTZBmLZjRkz9/TwbH5efMSCwbgg7Rhwksk8666j/QVe88nc7sOvL
         x0RqujN8l8EpxLlfgcSUIp6SWDZMz55FA5ylBXGCxJRflXMXYhNVx9Tp9icffxvuNsWi
         rt16IcN8mgnG7LbmUatpCjxBMLgZSgLAPWo2LSJWizs2vgJSa9Lt5Awz251+ipzxQfcI
         Nwmlqf7pQYKreyvpvRIxpzf9pQHiB+UYwOtZOwpavGC0Y/RRwpNJIOPmYL93l1qMYwBK
         J8Ogoe+L9O1ZUuCTHxtmklX2oXiDWNw54ILWsYE/oXuLMyWkUhQNPNY4NhhtkCI6ObDk
         I41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690462328; x=1691067128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbxwpGLeivztqxhT2pHp7OuwmFwsVMzhXAPdU1zv9GA=;
        b=ABCWL1FqT/EnG66rPhejMEy7Ul55isAkgsiGzV/hcSqYQFQb/ZxuRTRiilTyDNEDrI
         Tuov+UBa8luLwd4G0hU8h8bpl2yE+myPbpqSJjYGI0mT3TxWfgtlabS3ss9GbAfM4y3F
         BiNo3vnHck8cJ3nE0W4X5VZ0mTDJLcsP0YbXjNogCXQOIKaGJGLgWgQ/ROizDsQln7vh
         8H7/TCxThbJpZsj0CLztwRFv2kne/xsXH3mmTUuogvLjbQM2kFewI0MpkF+zHCnnmZc8
         zP8suM6GeoLCJJM5bbHID7wRV0BFw/c5TEFzEqyaFKfgooVifRCg6oSQ8TR6dvrdRzNP
         +tIw==
X-Gm-Message-State: ABy/qLa0mPh11PW8hlyQ+eBvKyoJu1wUuiGFx1i9sPjXyLvkXt6B8a10
	gZyjFFQaAHN/dVCySieY5CgZiY/plfS+JJRAuvwCeA==
X-Google-Smtp-Source: APBJJlGMB1mkXIvDQVCrQP5SaakFkJG9H8POfSzZ1z72Mb5c+IZJCcHQxDsDa2F59AbrsX/GTQ1cPVxyboKJrAkykJc=
X-Received: by 2002:a05:622a:349:b0:3f6:97b4:1a4d with SMTP id
 r9-20020a05622a034900b003f697b41a4dmr168798qtw.23.1690462327659; Thu, 27 Jul
 2023 05:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726230701.919212-1-prohr@google.com>
In-Reply-To: <20230726230701.919212-1-prohr@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 27 Jul 2023 14:51:55 +0200
Message-ID: <CANP3RGfYiAyXTp4yPX42eOSsob0Hzt50+6X6UwRpwYajPvdUqw@mail.gmail.com>
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
To: Patrick Rohr <prohr@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 1:07=E2=80=AFAM Patrick Rohr <prohr@google.com> wro=
te:
>
> accept_ra_min_rtr_lft only considered the lifetime of the default route
> and discarded entire RAs accordingly.
>
> This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> applies the value to individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
>
> In order for the sysctl to be useful to Android, it should really apply
> to all lifetimes in the RA, since that is what determines the minimum
> frequency at which RAs must be processed by the kernel. Android uses
> hardware offloads to drop RAs for a fraction of the minimum of all
> lifetimes present in the RA (some networks have very frequent RAs (5s)
> with high lifetimes (2h)). Despite this, we have encountered networks
> that set the router lifetime to 30s which results in very frequent CPU
> wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> WiFi firmware) entirely on such networks, it seems better to ignore the
> misconfigured routers while still processing RAs from other IPv6 routers
> on the same network (i.e. to support IoT applications).
>
> The previous implementation dropped the entire RA based on router
> lifetime. This turned out to be hard to expand to the other lifetimes
> present in the RA in a consistent manner; dropping the entire RA based
> on RIO/PIO lifetimes would essentially require parsing the whole thing
> twice.
>
> Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  8 ++++----
>  include/linux/ipv6.h                   |  2 +-
>  include/uapi/linux/ipv6.h              |  2 +-
>  net/ipv6/addrconf.c                    | 14 ++++++++-----
>  net/ipv6/ndisc.c                       | 27 +++++++++++---------------
>  5 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 37603ad6126b..a66054d0763a 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2288,11 +2288,11 @@ accept_ra_min_hop_limit - INTEGER
>
>         Default: 1
>
> -accept_ra_min_rtr_lft - INTEGER
> -       Minimum acceptable router lifetime in Router Advertisement.
> +accept_ra_min_lft - INTEGER
> +       Minimum acceptable lifetime value in Router Advertisement.
>
> -       RAs with a router lifetime less than this value shall be
> -       ignored. RAs with a router lifetime of 0 are unaffected.
> +       RA sections with a lifetime less than this value shall be
> +       ignored. Zero lifetimes stay unaffected.
>
>         Default: 0
>
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 0295b47c10a3..5883551b1ee8 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -33,7 +33,7 @@ struct ipv6_devconf {
>         __s32           accept_ra_defrtr;
>         __u32           ra_defrtr_metric;
>         __s32           accept_ra_min_hop_limit;
> -       __s32           accept_ra_min_rtr_lft;
> +       __s32           accept_ra_min_lft;
>         __s32           accept_ra_pinfo;
>         __s32           ignore_routes_with_linkdown;
>  #ifdef CONFIG_IPV6_ROUTER_PREF
> diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
> index 8b6bcbf6ed4a..cf592d7b630f 100644
> --- a/include/uapi/linux/ipv6.h
> +++ b/include/uapi/linux/ipv6.h
> @@ -198,7 +198,7 @@ enum {
>         DEVCONF_IOAM6_ID_WIDE,
>         DEVCONF_NDISC_EVICT_NOCARRIER,
>         DEVCONF_ACCEPT_UNTRACKED_NA,
> -       DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
> +       DEVCONF_ACCEPT_RA_MIN_LFT,
>         DEVCONF_MAX
>  };
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 19eb4b3d26ea..7f7d2b677711 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -202,7 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly=
 =3D {
>         .ra_defrtr_metric       =3D IP6_RT_PRIO_USER,
>         .accept_ra_from_local   =3D 0,
>         .accept_ra_min_hop_limit=3D 1,
> -       .accept_ra_min_rtr_lft  =3D 0,
> +       .accept_ra_min_lft      =3D 0,
>         .accept_ra_pinfo        =3D 1,
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         .accept_ra_rtr_pref     =3D 1,
> @@ -263,7 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_m=
ostly =3D {
>         .ra_defrtr_metric       =3D IP6_RT_PRIO_USER,
>         .accept_ra_from_local   =3D 0,
>         .accept_ra_min_hop_limit=3D 1,
> -       .accept_ra_min_rtr_lft  =3D 0,
> +       .accept_ra_min_lft      =3D 0,
>         .accept_ra_pinfo        =3D 1,
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         .accept_ra_rtr_pref     =3D 1,
> @@ -2727,6 +2727,10 @@ void addrconf_prefix_rcv(struct net_device *dev, u=
8 *opt, int len, bool sllao)
>                 return;
>         }
>
> +       if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lf=
t) {
> +               return;
> +       }
> +
>         /*
>          *      Two things going on here:
>          *      1) Add routes for on-link prefixes
> @@ -5598,7 +5602,7 @@ static inline void ipv6_store_devconf(struct ipv6_d=
evconf *cnf,
>         array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
>         array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarri=
er;
>         array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
> -       array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_l=
ft;
> +       array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
>  }
>
>  static inline size_t inet6_ifla6_size(void)
> @@ -6793,8 +6797,8 @@ static const struct ctl_table addrconf_sysctl[] =3D=
 {
>                 .proc_handler   =3D proc_dointvec,
>         },
>         {
> -               .procname       =3D "accept_ra_min_rtr_lft",
> -               .data           =3D &ipv6_devconf.accept_ra_min_rtr_lft,
> +               .procname       =3D "accept_ra_min_lft",
> +               .data           =3D &ipv6_devconf.accept_ra_min_lft,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dointvec,
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 29ddad1c1a2f..eeb60888187f 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1280,8 +1280,6 @@ static enum skb_drop_reason ndisc_router_discovery(=
struct sk_buff *skb)
>         if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
>                 return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
>
> -       lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
> -
>         if (!ipv6_accept_ra(in6_dev)) {
>                 ND_PRINTK(2, info,
>                           "RA: %s, did not accept ra for dev: %s\n",
> @@ -1289,13 +1287,6 @@ static enum skb_drop_reason ndisc_router_discovery=
(struct sk_buff *skb)
>                 goto skip_linkparms;
>         }
>
> -       if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_=
lft) {
> -               ND_PRINTK(2, info,
> -                         "RA: router lifetime (%ds) is too short: %s\n",
> -                         lifetime, skb->dev->name);
> -               goto skip_linkparms;
> -       }
> -
>  #ifdef CONFIG_IPV6_NDISC_NODETYPE
>         /* skip link-specific parameters from interior routers */
>         if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
> @@ -1336,6 +1327,14 @@ static enum skb_drop_reason ndisc_router_discovery=
(struct sk_buff *skb)
>                 goto skip_defrtr;
>         }
>
> +       lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
> +       if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_lft)=
 {
> +               ND_PRINTK(2, info,
> +                         "RA: router lifetime (%ds) is too short: %s\n",
> +                         lifetime, skb->dev->name);
> +               goto skip_defrtr;
> +       }
> +
>         /* Do not accept RA with source-addr found on local machine unles=
s
>          * accept_ra_from_local is set to true.
>          */
> @@ -1499,13 +1498,6 @@ static enum skb_drop_reason ndisc_router_discovery=
(struct sk_buff *skb)
>                 goto out;
>         }
>
> -       if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_=
lft) {
> -               ND_PRINTK(2, info,
> -                         "RA: router lifetime (%ds) is too short: %s\n",
> -                         lifetime, skb->dev->name);
> -               goto out;
> -       }
> -
>  #ifdef CONFIG_IPV6_ROUTE_INFO
>         if (!in6_dev->cnf.accept_ra_from_local &&
>             ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
> @@ -1530,6 +1522,9 @@ static enum skb_drop_reason ndisc_router_discovery(=
struct sk_buff *skb)
>                         if (ri->prefix_len =3D=3D 0 &&
>                             !in6_dev->cnf.accept_ra_defrtr)
>                                 continue;
> +                       if (ri->lifetime !=3D 0 &&
> +                           ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_=
min_lft)
> +                               continue;
>                         if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_in=
fo_min_plen)
>                                 continue;
>                         if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_in=
fo_max_plen)
> --
> 2.41.0.487.g6d72f3e995-goog

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

Patrick and I have spoken about this at length, and this (ignoring low
lifetime portions of the RA) seems like the best approach...

(though I will admit that I'm not super knowledgeable about IPv6 RAs
and this particular code)

