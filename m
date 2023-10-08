Return-Path: <netdev+bounces-38890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246317BCE5D
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E749C1C20895
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20805666;
	Sun,  8 Oct 2023 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i1hCHGNe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C689CA49
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 12:38:39 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47902B9
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:38:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d81afd5273eso3831614276.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696768716; x=1697373516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQcs+qLJDNkL6RiaeHMSDMsbvnhk8FvSJ0wbhhkdGFo=;
        b=i1hCHGNeUkYuAJYnBCUcIgd6v1vVP3SS/TlWeW1BusSWUUIeB+TdAq9HcLozdo6xIZ
         N9QysffWwkMG8v9Vyx4Fgoud1rIBJ2fkkUIXVFCes54kt85hmJg8lNMpJYMy3ZcUk0EV
         Viz6lT4PSQVcASSPsw8p6HiqImvCB/TXo85li3heq+33gwXe1IwM+jy0yA3Y/M0P/SwD
         vFExSOOnEUu6rssGmogUXkhKWA5EJTTb/dZAPP6uUwkZSSgQQmkR5KG3lX8Nw97W4dD2
         mnDYGmxOqFAyUhMf2t0jpwj0aedR7qBwdCPdyR4FV3hRfdSbzkTgTV0je9ZBZp8TYrAx
         B+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696768716; x=1697373516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQcs+qLJDNkL6RiaeHMSDMsbvnhk8FvSJ0wbhhkdGFo=;
        b=H7guzw7oM7hv91+Ncy1oNsnmYsp29bhArVS5Crmz7a+6CCJlVqIoeYaJVDoLChbsXw
         9hrznHxR2vlyE497go5YJQLhZWUm0X0FnjG5inwQ9y9h+eAqIXPcSxsfDI6h8OpkUrco
         OpcgEGlHR+d2w9PobR7bqp7x2eINUUslLUq38C66ni/L2PXH71aTJPBB9UoHlkgOsRCZ
         Zkdef8rZTGBGvFb5eLtm1WBKvtPMjiv0zOsPl+QDhrOR6ImUF+iU/aAWxWpbhb4/P9+o
         kymIcT6R62rXUEO/63vqmu51tO0vwIpIldSEtdxOg7qZNLNgNflom0zyphJnN6tlMhWA
         1ZKQ==
X-Gm-Message-State: AOJu0Ywkeme13sIb0kLKBGSSo299Rw1uJzH3BE29X5gcBKLjyiZwaCp7
	R17vmf0+mBOwJDUI0HPWZ2hSFeKWdukrCSXSCwzu2Q==
X-Google-Smtp-Source: AGHT+IE2PCdnzcrj8fnwiLSEaKtOplUJtOxLu3uDSvumLMWewx1sZunVAHJ6ZRdSsCYDzagmrmM275SqDV35Wo6Ja5E=
X-Received: by 2002:a25:e00a:0:b0:d86:357:e314 with SMTP id
 x10-20020a25e00a000000b00d860357e314mr12452636ybg.47.1696768716457; Sun, 08
 Oct 2023 05:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSAEp+tr1oXHOy/C@nanopsycho> <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho> <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org> <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho> <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho> <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
 <ZSGTdA/5WkVI7lvQ@nanopsycho>
In-Reply-To: <ZSGTdA/5WkVI7lvQ@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 8 Oct 2023 08:38:25 -0400
Message-ID: <CAM0EoMmohH3VdMGZDNb6zkte774uohp1u0Fzxo24_tPT+PBb=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	mleitner@redhat.com, vladbu@nvidia.com, simon.horman@corigine.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 1:20=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Oct 07, 2023 at 04:09:15PM CEST, jhs@mojatatu.com wrote:
> >On Sat, Oct 7, 2023 at 8:43=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Sat, Oct 07, 2023 at 01:06:43PM CEST, jhs@mojatatu.com wrote:
> >> >On Sat, Oct 7, 2023 at 6:20=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
> >> >> >On Fri, Oct 6, 2023 at 6:25=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> >> >> >>
> >> >> >> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
> >> >> >> > > I don't understand the need for configuration less here. You=
 don't have
> >> >> >> > > it for the rest of the actions. Why this is special?
> >> >> >>
> >> >> >> +1, FWIW
> >> >> >
> >> >> >We dont have any rule that says all actions MUST have parameters ;=
->
> >> >> >There is nothing speacial about any action that doesnt have a
> >> >> >parameter.
> >> >>
> >> >> You are getting the configuration from the block/device the action =
is
> >> >> attached to. Can you point me to another action doing that?
> >> >
> >> >We are entering a pedantic road i am afraid. If there is no existing
> >> >action that has zero config then consider this one the first one. We
> >>
> >> Nope, nothing pedantic about it. I was just curious if there's anythin=
g
> >> out there I missed.
> >>
> >
> >Not sure if you noticed in the patch: the blockid on which the skb
> >arrived on is now available in the tc_cb[] so when it shows up at the
> >action we can just use it.
>
> I see, but does it has to be? I don't think so with the solution I'm
> proposing.

It's a simplistic use for a broadcast. We should support the one you
suggested as well.

> >
> >>
> >> >use skb->metadata all the time as a source of information for actions=
,
> >> >classifiers, qdiscs. If i dont need config i dont need to invent one
> >>
> >> skb->metadata is something that is specific to a packet. That has
> >> nothing to do with the actual configuration.
> >
> >Essentially we turned blockid into skb metadata. A user specifying
> >configuration of a different blockid is certainly useful. My point is
> >we can have both worlds: when such a user config is missing we'll
> >assume a default which happens to be in the skb.
> >
> >>
> >> >just because, well, all other actions are using one or more config;->
> >> >Your suggestion to specify an extra config to select a block - which
> >> >may be different than the one the one packet on - is a useful
> >> >feature(it just adds more code) but really should be optional. i.e if
> >> >you dont specify a block id configuration then we pick the metadata
> >> >one.
> >>
> >> My primary point is, this should be mirred redirect to block instead o=
f
> >> what we currently have only for dev. That's it.
> >
> >Agreed (and such a feature should be added regardless of this action).
> >The tc block provides a simple abstraction, but do you think it is
> >enough? Alternative is to use a list of ports given to mirred: it
> >allows us to group ports from different tc blocks or even just a
> >subset of what is in a tc block - but it will require a lot more code
> >to express such functionality.
>
> Again, you attach filter to either dev or block. If you extend mirred
> redirect to accept the same 2 types of target, I think it would be best.
>

We are going to make block work with mirror, it makes sense. I am not
sure about the redirect, what is the semantic? mirror to everyone but
redirect to the last one?

>
> >
> >>
> >>
> >> >
> >> >> >If we can adequately cleanup mirred,  then we can put it there but
> >> >> >certainly now we are adding more buttons to click on mirred. It ma=
y
> >> >> >make sense to refactor the mirred code then reuse the refactored c=
ode
> >> >> >in a new action.
> >> >>
> >> >> I don't understand why you need any new action. mirred redirect to =
block
> >> >> instead of dev is exactly what you need. Isn't it?
> >> >
> >> >The actions have different meanings and lumping them together then
> >> >selecting via a knob is not the right approach.
> >> >There's shared code for sure. Infact the sending code was ripped from
> >> >mirred so as not to touch the rest because like i said mirred has
> >> >since grown a couple of horns and tails. In retrospect mirred should
> >> >have been two actions with shared code - but it is too late to change
> >> >now because it is very widely used. If someone like me was afraid of
> >> >touching it is because there's a maintainance challenge. I consider i=
t
> >> >in the same zone as trying to restructure something in the skb.
> >> >I agree mirroring to a group of ports with a simple config is a usefu=
l
> >> >feature. Mirroring to a group via a tc block is simpler but adding a
> >> >list of ports instead is more powerful. So this feature is useful to
> >> >have in mirred - just the adding of yet one more button to say "skip
> >> >this port" is my concern.
> >>
> >> Why? Perhaps skb->iif could be used for check in the tx iteration.
> >>
> >
> >We use skb->dev->ifindex to find the exception. Is iif better?.
>
> iif contains ifindex of the actual ingress device. So if the netdev is
> part of bond for example, this still contains the original ifindex.
> So I buess that this depends on what you need. Looks to me that
> skb->dev->ifindex would be probaly better. It contains the netdev that
> the filter is attached on, right?
>

Note: you can use mirred to redirect to either ingress or egress of
other ports - I believe one of these ifindices changes to reflect the
new ifindex. We'll take a closer look.

>
> >Jiri - but why does this have to be part of mirred::mirror? I am
> >asking the same question of why mirror and redirect have to be part
> >mirred instead of separate actions.
>
> You have to maintain the backwards compatibility. Currently mirred is
> one action right? Does not matter how you do it in kernel, user should
> not tell any difference.

I dont mean to break existing mirred. What i meant was in retrospect i
wish i had the insight to separate mirred into two actions(and share
the code instead), it would have simplified the code and its
maintainance. It is for the same reason i am not in favor of is adding
the "skip this port" in mirror. This is in the spirit of unix
philosophy, which we have been mostly adhering to: write small
features/actions which do one thing well and stitch them together to
compose.

cheers,
jamal
>
> >
> >cheers,
> >jamal

