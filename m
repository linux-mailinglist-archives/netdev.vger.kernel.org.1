Return-Path: <netdev+bounces-21912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574176542A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D1A1C21575
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6C101C2;
	Thu, 27 Jul 2023 12:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587FC8E0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:38:39 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5509B1AA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:38:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so278521cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690461517; x=1691066317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUaGVlI81ZbVkVHY0zPoIF2Yq3ttm13iSLOyBzUG8fA=;
        b=kJBGf4ML2i0qXtGA7cLcRsngByqHeJbtk9xbe0sBBAyaBWXSLh2p5kiOUpJzgt2Gqv
         FQBetlJs1fNn7WGV7d31BfrrjSAXjoO66wBYikcAZ+ZKGCCHBXVSg4zaz3IlzBBr9NSv
         Apj5S+FZHhKEHYUq0gQ3dgllUOgZ4quTKou+kRrAhB1/ppmyBkR4n0YfyoQmVaqQD+Ns
         m0HZGuwBIsDcBsOaRBToOn2GwaqHMuOhW52AQKMLw0HPJVv7rEubXv96EvQ+TcBIIBBr
         hpHkL2O4Be2pImDKi54TbfJUn+1QpA5W+bU0qqDd0wTsbMATibGpqhajdDWiA4k4v73j
         nshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690461517; x=1691066317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUaGVlI81ZbVkVHY0zPoIF2Yq3ttm13iSLOyBzUG8fA=;
        b=D84PfYoCt6eHktB5LFJzBplg+gk2pgosvAySSHHcE8Y/C+/wGwru9wRGSCQp7UMDtL
         aujymd1r3AT4kkFS6rt56IFBAkq0m5aJuYprWJQQ5u52e4VJkkGlWSftuZGW2dlv86Y6
         JJ+f/WehfQklmPOtiWw2KqhmzOq740s7v7ROJksPVHW9qDNV1APWUQeuwGOAWp9nO0rw
         LCsIqwqV/zd1g+3Itu2Tf5X+ARj7T0Mme56o06S84Bij9SMFbmGV1hIQCW6QHXkFui9F
         8aMF8l98O8qHWqO/PU9uImZw3+EfpVvdmBoKOlnvJKM4UV0i6jzyd4ZhztKySK7wNcJl
         p9NA==
X-Gm-Message-State: ABy/qLbp0iyMsYTtAjCJOuCa1TMus+cEbX4Y95KA56qLDYYG84z9K2OS
	Za9p8fMFh9/9KrOneTDJRSukcLDEUQM9BfCE1Q0+pA==
X-Google-Smtp-Source: APBJJlG1TczTnKvxReUX049165fNZWTaAexhOx6KadV62w0VUZtp8/JCzIjXMUKI5acUfBvI1+3WNpQDBa6behhAnTk=
X-Received: by 2002:a05:622a:1a8d:b0:403:ff6b:69b9 with SMTP id
 s13-20020a05622a1a8d00b00403ff6b69b9mr145617qtc.13.1690461517293; Thu, 27 Jul
 2023 05:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726230701.919212-1-prohr@google.com> <ZMJh1RS+EaGsmgZJ@corigine.com>
In-Reply-To: <ZMJh1RS+EaGsmgZJ@corigine.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 27 Jul 2023 14:38:24 +0200
Message-ID: <CANP3RGdeT5MGaxEyYA6LP2kiEGQmA-VdSVf8bme2KR+4mLa79w@mail.gmail.com>
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
To: Simon Horman <simon.horman@corigine.com>
Cc: Patrick Rohr <prohr@google.com>, "David S . Miller" <davem@davemloft.net>, 
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

On Thu, Jul 27, 2023 at 2:24=E2=80=AFPM Simon Horman <simon.horman@corigine=
.com> wrote:
>
> On Wed, Jul 26, 2023 at 04:07:01PM -0700, Patrick Rohr wrote:
> > accept_ra_min_rtr_lft only considered the lifetime of the default route
> > and discarded entire RAs accordingly.
> >
> > This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> > applies the value to individual RA sections; in particular, router
> > lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> > lifetimes are lower than the configured value, the specific RA section
> > is ignored.
> >
> > In order for the sysctl to be useful to Android, it should really apply
> > to all lifetimes in the RA, since that is what determines the minimum
> > frequency at which RAs must be processed by the kernel. Android uses
> > hardware offloads to drop RAs for a fraction of the minimum of all
> > lifetimes present in the RA (some networks have very frequent RAs (5s)
> > with high lifetimes (2h)). Despite this, we have encountered networks
> > that set the router lifetime to 30s which results in very frequent CPU
> > wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> > WiFi firmware) entirely on such networks, it seems better to ignore the
> > misconfigured routers while still processing RAs from other IPv6 router=
s
> > on the same network (i.e. to support IoT applications).
> >
> > The previous implementation dropped the entire RA based on router
> > lifetime. This turned out to be hard to expand to the other lifetimes
> > present in the RA in a consistent manner; dropping the entire RA based
> > on RIO/PIO lifetimes would essentially require parsing the whole thing
> > twice.
> >
> > Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Cc: David Ahern <dsahern@kernel.org>
> > Signed-off-by: Patrick Rohr <prohr@google.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst |  8 ++++----
> >  include/linux/ipv6.h                   |  2 +-
> >  include/uapi/linux/ipv6.h              |  2 +-
> >  net/ipv6/addrconf.c                    | 14 ++++++++-----
> >  net/ipv6/ndisc.c                       | 27 +++++++++++---------------
> >  5 files changed, 26 insertions(+), 27 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 37603ad6126b..a66054d0763a 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -2288,11 +2288,11 @@ accept_ra_min_hop_limit - INTEGER
> >
> >       Default: 1
> >
> > -accept_ra_min_rtr_lft - INTEGER
> > -     Minimum acceptable router lifetime in Router Advertisement.
> > +accept_ra_min_lft - INTEGER
> > +     Minimum acceptable lifetime value in Router Advertisement.
>
> Hi Patrick, all,
>
> I am concerned about UAPI-breakage aspects of changing the name of a sysc=
tl.
> Can we discuss that?

This isn't uapi yet as it (the old name) was only merged a few days ago.

