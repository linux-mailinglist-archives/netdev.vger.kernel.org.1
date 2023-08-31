Return-Path: <netdev+bounces-31631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DF78F202
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9B2816A4
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140318C33;
	Thu, 31 Aug 2023 17:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE438F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 17:35:50 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E94E5F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:35:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso19571cf.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503347; x=1694108147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uku/weMEXqhuzWY8O1+6L5fKITh2iy6GllAMUj+CWD0=;
        b=oyMrK3p1vzE3AWYYsdbiwhjf+0+S/1WHDaR6CCh10XBYvicnxDrAGL1IVnUtVsxfoM
         Lat8IK5lePG/ZQJb+3cSbQsmKiV4pnCzuk/D37+9qVgopiBU8C9mPBqCTrRVtxGyFkSV
         08nE6WgkUO5xAWO2JHrc5MtccpW2nryMRl58Bo8MMZrPSCW8ZHAnYW82CsweohcJVwkd
         m2mGnaho8+WXvxw+p9uVbMTj0X7FpB5kgri/fyK48iQNpVkxiZdDqejtkzpjJm9K2otR
         nN2QJ6cSqIouDIn5IY4UZ0fhCV5TeTx5BfOsO/G3jUe3aw/bTY5d0FkW1/I9K8NS/GEH
         n96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503347; x=1694108147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uku/weMEXqhuzWY8O1+6L5fKITh2iy6GllAMUj+CWD0=;
        b=B7bzyjGgmVNlMbNSwI4Xn//pWkhTjxiqP6AmymKDeRYRgdblMSbqREpsC1jbtxMu80
         vBCetxekB7oA72RMrC3LUQJzTIEGvZqHpKpuS2Mk6+b+9a97WRRU90U0yQSDz7brsegY
         V8ex5RLXa5ezg5YgWd+06hJtvL+dGT+SL2appmj+Pgp5Zmjloq4VLJ75LjD96Z1V4xp2
         Xj0ToU1HAlFre9hiO8g3eIDRNhytsgz55KbaWoR4T4YYZQdY1Qa4IzU161LSef+D6oZE
         Cmru4/5lnDISOvcsD/o59JIYfPMPcwyDD7unHLRe+J8nrg5uj1mVUia8zlMs6E5Tb2MO
         dstw==
X-Gm-Message-State: AOJu0YxxkEZ4V43QjKTS/Hg7nGrXSXNJcwrtGD33QJH8Kbftb7S1kUys
	wLvBvDtTsBUBs9zGdbeOPxNadC63snQ0YvdRf7nW9g==
X-Google-Smtp-Source: AGHT+IFP7S2oXSw9UWmxZzEt/y9Fr1ISXh+lzqhj1ScDDmPl0garYaAnJvIsQnoBT0mJHaknCPbmEFc85IMXioec0Xk=
X-Received: by 2002:ac8:7f0a:0:b0:410:8ba3:21c7 with SMTP id
 f10-20020ac87f0a000000b004108ba321c7mr18399qtk.18.1693503347419; Thu, 31 Aug
 2023 10:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831172322.668507-1-prohr@google.com>
In-Reply-To: <20230831172322.668507-1-prohr@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 31 Aug 2023 10:35:34 -0700
Message-ID: <CANP3RGc87hhELARJkss=D4ZbUpFhKTEX-Eca+SCNXLU7csYQ6Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 10:23=E2=80=AFAM Patrick Rohr <prohr@google.com> wr=
ote:
>
> This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
> lifetime derivation mechanism.
>
> RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
> Advertisement PIO shall be ignored if it less than 2 hours and to reset
> the lifetime of the corresponding address to 2 hours. An in-progress
> 6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
> looking to remove this mechanism. While this draft has not been moving
> particularly quickly for other reasons, there is widespread consensus on
> section 4.2 which updates RFC4862 section 5.5.3e.
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Jen Linkova <furry@google.com>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 11 ++++++++
>  include/linux/ipv6.h                   |  1 +
>  net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
>  3 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index a66054d0763a..7f21877e3f78 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
>                 - enabled if accept_ra is enabled.
>                 - disabled if accept_ra is disabled.
>
> +ra_pinfo_rfc4862_5_5_3e - BOOLEAN
> +       Use RFC4862 Section 5.5.3e to determine the valid lifetime of
> +       an address matching a prefix sent in a Router Advertisement
> +       Prefix Information Option.
> +
> +       - If enabled, RFC4862 section 5.5.3e is used to determine
> +         the valid lifetime of the address.
> +       - If disabled, the PIO valid lifetime will always be honored.
> +
> +       Default: 1
> +
>  accept_ra_rt_info_min_plen - INTEGER
>         Minimum prefix length of Route Information in RA.
>
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 5883551b1ee8..f90cf8835ed4 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -35,6 +35,7 @@ struct ipv6_devconf {
>         __s32           accept_ra_min_hop_limit;
>         __s32           accept_ra_min_lft;
>         __s32           accept_ra_pinfo;
> +       __s32           ra_pinfo_rfc4862_5_5_3e;
>         __s32           ignore_routes_with_linkdown;
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         __s32           accept_ra_rtr_pref;
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 47d1dd8501b7..1ac23a37e8eb 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -204,6 +204,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly=
 =3D {
>         .accept_ra_min_hop_limit=3D 1,
>         .accept_ra_min_lft      =3D 0,
>         .accept_ra_pinfo        =3D 1,
> +       .ra_pinfo_rfc4862_5_5_3e =3D 1,
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         .accept_ra_rtr_pref     =3D 1,
>         .rtr_probe_interval     =3D 60 * HZ,
> @@ -265,6 +266,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_m=
ostly =3D {
>         .accept_ra_min_hop_limit=3D 1,
>         .accept_ra_min_lft      =3D 0,
>         .accept_ra_pinfo        =3D 1,
> +       .ra_pinfo_rfc4862_5_5_3e =3D 1,
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         .accept_ra_rtr_pref     =3D 1,
>         .rtr_probe_interval     =3D 60 * HZ,
> @@ -2657,22 +2659,23 @@ int addrconf_prefix_rcv_add_addr(struct net *net,=
 struct net_device *dev,
>                         stored_lft =3D ifp->valid_lft - (now - ifp->tstam=
p) / HZ;
>                 else
>                         stored_lft =3D 0;
> -               if (!create && stored_lft) {
> +
> +               /* RFC4862 Section 5.5.3e:
> +                * "Note that the preferred lifetime of the
> +                *  corresponding address is always reset to
> +                *  the Preferred Lifetime in the received
> +                *  Prefix Information option, regardless of
> +                *  whether the valid lifetime is also reset or
> +                *  ignored."
> +                *
> +                * So we should always update prefered_lft here.
> +                */
> +               update_lft =3D !create && stored_lft;
> +
> +               if (update_lft && in6_dev->cnf.ra_pinfo_rfc4862_5_5_3e) {
>                         const u32 minimum_lft =3D min_t(u32,
>                                 stored_lft, MIN_VALID_LIFETIME);
>                         valid_lft =3D max(valid_lft, minimum_lft);
> -
> -                       /* RFC4862 Section 5.5.3e:
> -                        * "Note that the preferred lifetime of the
> -                        *  corresponding address is always reset to
> -                        *  the Preferred Lifetime in the received
> -                        *  Prefix Information option, regardless of
> -                        *  whether the valid lifetime is also reset or
> -                        *  ignored."
> -                        *
> -                        * So we should always update prefered_lft here.
> -                        */
> -                       update_lft =3D 1;
>                 }
>
>                 if (update_lft) {
> @@ -6846,6 +6849,15 @@ static const struct ctl_table addrconf_sysctl[] =
=3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dointvec,
>         },
> +       {
> +               .procname       =3D "ra_pinfo_rfc4862_5_5_3e",
> +               .data           =3D &ipv6_devconf.ra_pinfo_rfc4862_5_5_3e=
,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         {
>                 .procname       =3D "accept_ra_rtr_pref",
> --
> 2.42.0.283.g2d96d420d3-goog

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

Obviously 'ra_pinfo_rfc4862_5_5_3e' isn't a particularly pretty name...
But we couldn't come up with anything that was better.
In particular it shouldn't start with 'accept_ra_' since it's not
relevant to actually accepting it.
Similarly it shouldn't end in _lft since it's a boolean and not a
length of time...

As for why we want to be able to disable it:
The existing 2hours is extremely arbitrary.
It was added to prevent security attacks from rogue RAs expiring things.
However, any network without RA guard (which would prevent this attack)
is already susceptible to so many other possible RA attacks, that it
just doesn't matter.
What it does do however, is prevent expiring client devices ip/route inform=
ation
when the upstream configuration of a router changes (cable modem
reconnects, etc).

Unfortunately the old behaviour has to stay the default, to pass some
certification tests...
(until the RFC actually gets updated)

Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

