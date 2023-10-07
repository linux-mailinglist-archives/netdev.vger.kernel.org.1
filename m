Return-Path: <netdev+bounces-38779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6C7BC6FE
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BDD281F8E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F211862F;
	Sat,  7 Oct 2023 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FnUnpBW9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3A7488
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 11:06:57 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98639E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 04:06:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f55c276c3so37038397b3.2
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696676815; x=1697281615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGW/wJA4NmVVYfEwSmWGCB7AOufy+bOIKxAkjAbIuW8=;
        b=FnUnpBW9PUPU3wnTgwkS5gHB4tiM5lvm6sdY5Kk3UoGgGUaIbzui9oKZ/jpRL6lb93
         qdby351fl0d9WijHWp9Iv684/vA9aErMTWteB9bOWvmCUs+dpfULmOQZfQg/MsCVqIWD
         vXH0xh7v1Xm4EGHxILf0dzLRaSFeNKUzYsslbPxpfelfU6LiSKuxLqQh3VV1XQA4mFW9
         0iog9ACva+Q6TQctYjpPcKX157LAFLcvozKnxGpyeMOimsmNR0GKXCaqURazxQdnBJMW
         +ELKBf2ybCjo+SBvn1Z89sfCUbZwF9sxruxhqG7hdkyvZfj29GZL9nriEx6SPdsQ1Oml
         qDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696676815; x=1697281615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGW/wJA4NmVVYfEwSmWGCB7AOufy+bOIKxAkjAbIuW8=;
        b=kOeQllYrCnBbxqAUUBikHhPOKbHsk1cTS51mwSYPBpQdxnWGxvfa5f8VN8ugJ7RpDk
         hSyyMMBAUBsDM9J9LFaGB9KN4c1suFInhGTMTCQ8ErJ1S61IrzZ3bt/7+7KWsLlosbBd
         EJRPSnL0lSquWpnnwtERKFaa8gt6MnKWkP8TvdjgzBYVkXmUcVD/zPtDOtxImSOwqNb+
         Z37dc7sMGi1e6JxgBeQSL6leKZvftFxyOpnj0HeqG7kmnaQ3FSoNCq18ypsUfh2DuE9D
         ttTDIr9BBDOPmUduMzQ5ViJejTawYy0SeLcxHSz5Nl7ackDC1H4n68I2rQVcLVipeawq
         z1Ug==
X-Gm-Message-State: AOJu0Yy4XfUbqmpvvQZzYU3MpTl7mY/Stb7gUV7AvaUznmKpkrW6TVsX
	ZkSFQvUIs8jJeROEBWhE9j4QV9QGCn1oYgpyw0br3A==
X-Google-Smtp-Source: AGHT+IFqUttQZQzq20mHslWWvZOFe3iFxE+TCX/ONrmYIFaaEFq8+Ae0RemG+IzY+ppXWtWW3PhfhfFTf0BRcVBHEjY=
X-Received: by 2002:a25:248d:0:b0:d1a:c21:3bcf with SMTP id
 k135-20020a25248d000000b00d1a0c213bcfmr10592960ybk.55.1696676815096; Sat, 07
 Oct 2023 04:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005184228.467845-1-victor@mojatatu.com> <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho> <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org> <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho>
In-Reply-To: <ZSEw32MVPK/qCsyz@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Oct 2023 07:06:43 -0400
Message-ID: <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 6:20=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
> >On Fri, Oct 6, 2023 at 6:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >>
> >> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
> >> > > I don't understand the need for configuration less here. You don't=
 have
> >> > > it for the rest of the actions. Why this is special?
> >>
> >> +1, FWIW
> >
> >We dont have any rule that says all actions MUST have parameters ;->
> >There is nothing speacial about any action that doesnt have a
> >parameter.
>
> You are getting the configuration from the block/device the action is
> attached to. Can you point me to another action doing that?

We are entering a pedantic road i am afraid. If there is no existing
action that has zero config then consider this one the first one. We
use skb->metadata all the time as a source of information for actions,
classifiers, qdiscs. If i dont need config i dont need to invent one
just because, well, all other actions are using one or more config;->
Your suggestion to specify an extra config to select a block - which
may be different than the one the one packet on - is a useful
feature(it just adds more code) but really should be optional. i.e if
you dont specify a block id configuration then we pick the metadata
one.

> >If we can adequately cleanup mirred,  then we can put it there but
> >certainly now we are adding more buttons to click on mirred. It may
> >make sense to refactor the mirred code then reuse the refactored code
> >in a new action.
>
> I don't understand why you need any new action. mirred redirect to block
> instead of dev is exactly what you need. Isn't it?

The actions have different meanings and lumping them together then
selecting via a knob is not the right approach.
There's shared code for sure. Infact the sending code was ripped from
mirred so as not to touch the rest because like i said mirred has
since grown a couple of horns and tails. In retrospect mirred should
have been two actions with shared code - but it is too late to change
now because it is very widely used. If someone like me was afraid of
touching it is because there's a maintainance challenge. I consider it
in the same zone as trying to restructure something in the skb.
I agree mirroring to a group of ports with a simple config is a useful
feature. Mirroring to a group via a tc block is simpler but adding a
list of ports instead is more powerful. So this feature is useful to
have in mirred - just the adding of yet one more button to say "skip
this port" is my concern.
Lets see how the refactoring goes first then it will be clearer - it
is a lot of delicate work - but you are right lets give it some love
now.

cheers,
jamal


>

