Return-Path: <netdev+bounces-31632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7078F22E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8672816AE
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E521193A2;
	Thu, 31 Aug 2023 17:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75411CB6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 17:51:40 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33170CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:51:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so24721cf.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693504297; x=1694109097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL363UP+X08CP1u4/jkii0Y5PhdpBWqZba2oMsOXP/s=;
        b=pfP70gP4H/dQq3y+AwT7FXqjrCS/PBTOCt6QVPrha0vGL4pwE3I5FkMWfgR/5v9twp
         eicimj439Fw+GykEnk2OZ22PV5L+ACY8628uKOrgewBn/WA8rXzO8agXoOWT/ltmWvSQ
         R2Oj9ixAOx66tmtLxaL2cQGgQeZ+C0WHtC/WBgTgUiD1yZ9BNLVmYoQZWd5uiH/Xr7Ax
         8QnL5dkoUyErptUwcDKAl+wZOgkCGTJRATpgAZRpEbiHx8pEAIytzv5QZV3wgTf4lUdq
         tBXBTw6SJavyBOOXlxDfG7bqw+GjcNjhLc08msJhyuZ0L4PCPw8jB+XtknGB4dnz1p+b
         7X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504297; x=1694109097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL363UP+X08CP1u4/jkii0Y5PhdpBWqZba2oMsOXP/s=;
        b=FxYEm6DfMXcRv1hB1rzZ7rXi9xbtIC9oexPlUFDHOpSiA7DjBEAtcfLeI5rfdlFt1f
         lY68jmo0+diXyqG6ayTPW4GWpv/m3DLFse7yXYqjnRCkbxnL1xY7lCrtHOH55w3o84Ov
         5gEE2JAA4PGAbSek8mxd5yoGYxlRgbf9+invk36FoUoyIwOqiSdRrlS8pml53VHG+y7I
         r0KzvNZVETU8KVWnrpNeZwNDwlJfZnuJDjY8FL7uR/1VuMQqgtRAeylfshkVHoxYRcz+
         xcNMtVlH0+JvmdX89vK/eJplBExhucrFLT4GuFrBq6N45aQhc8g49N9I7v4N1/Ub1WvP
         sPBg==
X-Gm-Message-State: AOJu0YzKxHhjNzveQsFWDcUmUrf3py4v70jiX3LyyrfPy3xtXzxnSjaB
	V69uR9ipnVLyjVadSpWGVGwpjCwM34BsJq4pGdSP5g==
X-Google-Smtp-Source: AGHT+IGWmO0jYObm2TBxTEbMeNFkfJqtK79++nWqnUmyX/FhKWLis1S1X/s1C7LRFZ4IyKqZzJ1Wr6gghEdAQr+s0yc=
X-Received: by 2002:a05:622a:7:b0:40f:db89:5246 with SMTP id
 x7-20020a05622a000700b0040fdb895246mr21082qtw.21.1693504297202; Thu, 31 Aug
 2023 10:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831172322.668507-1-prohr@google.com> <CANP3RGc87hhELARJkss=D4ZbUpFhKTEX-Eca+SCNXLU7csYQ6Q@mail.gmail.com>
In-Reply-To: <CANP3RGc87hhELARJkss=D4ZbUpFhKTEX-Eca+SCNXLU7csYQ6Q@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 31 Aug 2023 10:51:25 -0700
Message-ID: <CANP3RGfxOn=8JYJNUiPOH884PpONbWnOLm5pKA-zr29D1vEM7g@mail.gmail.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 10:35=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
>
> On Thu, Aug 31, 2023 at 10:23=E2=80=AFAM Patrick Rohr <prohr@google.com> =
wrote:
> >
> > This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
> > lifetime derivation mechanism.
> >
> > RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
> > Advertisement PIO shall be ignored if it less than 2 hours and to reset
> > the lifetime of the corresponding address to 2 hours. An in-progress
> > 6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currentl=
y
> > looking to remove this mechanism. While this draft has not been moving
> > particularly quickly for other reasons, there is widespread consensus o=
n
> > section 4.2 which updates RFC4862 section 5.5.3e.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Cc: Jen Linkova <furry@google.com>
> > Signed-off-by: Patrick Rohr <prohr@google.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst | 11 ++++++++
> >  include/linux/ipv6.h                   |  1 +
> >  net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
> >  3 files changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index a66054d0763a..7f21877e3f78 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
> >                 - enabled if accept_ra is enabled.
> >                 - disabled if accept_ra is disabled.
> >
> > +ra_pinfo_rfc4862_5_5_3e - BOOLEAN
> > +       Use RFC4862 Section 5.5.3e to determine the valid lifetime of
> > +       an address matching a prefix sent in a Router Advertisement
> > +       Prefix Information Option.
> > +
> > +       - If enabled, RFC4862 section 5.5.3e is used to determine
> > +         the valid lifetime of the address.
> > +       - If disabled, the PIO valid lifetime will always be honored.
> > +
> > +       Default: 1
> > +
> >  accept_ra_rt_info_min_plen - INTEGER
> >         Minimum prefix length of Route Information in RA.
> >
> > diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> > index 5883551b1ee8..f90cf8835ed4 100644
> > --- a/include/linux/ipv6.h
> > +++ b/include/linux/ipv6.h
> > @@ -35,6 +35,7 @@ struct ipv6_devconf {
> >         __s32           accept_ra_min_hop_limit;
> >         __s32           accept_ra_min_lft;
> >         __s32           accept_ra_pinfo;
> > +       __s32           ra_pinfo_rfc4862_5_5_3e;
> >         __s32           ignore_routes_with_linkdown;
> >  #ifdef CONFIG_IPV6_ROUTER_PREF
> >         __s32           accept_ra_rtr_pref;
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 47d1dd8501b7..1ac23a37e8eb 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -204,6 +204,7 @@ static struct ipv6_devconf ipv6_devconf __read_most=
ly =3D {
> >         .accept_ra_min_hop_limit=3D 1,
> >         .accept_ra_min_lft      =3D 0,
> >         .accept_ra_pinfo        =3D 1,
> > +       .ra_pinfo_rfc4862_5_5_3e =3D 1,
> >  #ifdef CONFIG_IPV6_ROUTER_PREF
> >         .accept_ra_rtr_pref     =3D 1,
> >         .rtr_probe_interval     =3D 60 * HZ,
> > @@ -265,6 +266,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read=
_mostly =3D {
> >         .accept_ra_min_hop_limit=3D 1,
> >         .accept_ra_min_lft      =3D 0,
> >         .accept_ra_pinfo        =3D 1,
> > +       .ra_pinfo_rfc4862_5_5_3e =3D 1,
> >  #ifdef CONFIG_IPV6_ROUTER_PREF
> >         .accept_ra_rtr_pref     =3D 1,
> >         .rtr_probe_interval     =3D 60 * HZ,
> > @@ -2657,22 +2659,23 @@ int addrconf_prefix_rcv_add_addr(struct net *ne=
t, struct net_device *dev,
> >                         stored_lft =3D ifp->valid_lft - (now - ifp->tst=
amp) / HZ;
> >                 else
> >                         stored_lft =3D 0;
> > -               if (!create && stored_lft) {
> > +
> > +               /* RFC4862 Section 5.5.3e:
> > +                * "Note that the preferred lifetime of the
> > +                *  corresponding address is always reset to
> > +                *  the Preferred Lifetime in the received
> > +                *  Prefix Information option, regardless of
> > +                *  whether the valid lifetime is also reset or
> > +                *  ignored."
> > +                *
> > +                * So we should always update prefered_lft here.
> > +                */
> > +               update_lft =3D !create && stored_lft;
> > +
> > +               if (update_lft && in6_dev->cnf.ra_pinfo_rfc4862_5_5_3e)=
 {
> >                         const u32 minimum_lft =3D min_t(u32,
> >                                 stored_lft, MIN_VALID_LIFETIME);
> >                         valid_lft =3D max(valid_lft, minimum_lft);
> > -
> > -                       /* RFC4862 Section 5.5.3e:
> > -                        * "Note that the preferred lifetime of the
> > -                        *  corresponding address is always reset to
> > -                        *  the Preferred Lifetime in the received
> > -                        *  Prefix Information option, regardless of
> > -                        *  whether the valid lifetime is also reset or
> > -                        *  ignored."
> > -                        *
> > -                        * So we should always update prefered_lft here=
.
> > -                        */
> > -                       update_lft =3D 1;
> >                 }
> >
> >                 if (update_lft) {
> > @@ -6846,6 +6849,15 @@ static const struct ctl_table addrconf_sysctl[] =
=3D {
> >                 .mode           =3D 0644,
> >                 .proc_handler   =3D proc_dointvec,
> >         },
> > +       {
> > +               .procname       =3D "ra_pinfo_rfc4862_5_5_3e",
> > +               .data           =3D &ipv6_devconf.ra_pinfo_rfc4862_5_5_=
3e,
> > +               .maxlen         =3D sizeof(int),
> > +               .mode           =3D 0644,
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ZERO,
> > +               .extra2         =3D SYSCTL_ONE,
> > +       },
> >  #ifdef CONFIG_IPV6_ROUTER_PREF
> >         {
> >                 .procname       =3D "accept_ra_rtr_pref",
> > --
> > 2.42.0.283.g2d96d420d3-goog
>
> Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
>
> Obviously 'ra_pinfo_rfc4862_5_5_3e' isn't a particularly pretty name...
> But we couldn't come up with anything that was better.
> In particular it shouldn't start with 'accept_ra_' since it's not
> relevant to actually accepting it.
> Similarly it shouldn't end in _lft since it's a boolean and not a
> length of time...
>
> As for why we want to be able to disable it:
> The existing 2hours is extremely arbitrary.
> It was added to prevent security attacks from rogue RAs expiring things.
> However, any network without RA guard (which would prevent this attack)
> is already susceptible to so many other possible RA attacks, that it
> just doesn't matter.
> What it does do however, is prevent expiring client devices ip/route info=
rmation
> when the upstream configuration of a router changes (cable modem
> reconnects, etc).
>
> Unfortunately the old behaviour has to stay the default, to pass some
> certification tests...
> (until the RFC actually gets updated)

btw. net-next is currently closed (and this isn't a fix)
https://patchwork.hopto.org/net-next.html

You'll most likely be asked to resend in ~1.5 weeks.

