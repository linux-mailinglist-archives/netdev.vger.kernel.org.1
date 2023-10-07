Return-Path: <netdev+bounces-38788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3247BC848
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E5F1C2093C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECC286B1;
	Sat,  7 Oct 2023 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HYHj/62v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E41A5BC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:09:29 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB1BA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 07:09:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579de633419so36896787b3.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696687767; x=1697292567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1GNuEYNNUVFdqSAVV7euIJsgJ2S6Nc7QjFuUbIKZ9c=;
        b=HYHj/62vIqzJ5j0IYQOFjEzJnGKT2fsgZAoAkzvcGRyqa7HdLEkeNPNhD5qh1Dnsjo
         s+icUdSbEhIyCp4/NKDX8jIs2TS7Y00Ler3jo/6ibcdio7vl2PZ7Aqi6IkjOhap2kfyO
         +6C3dAn08AYCCbTNnZdGEWb7nLq76gL8L2/GybW9cbbI4Yefgmg1NAEaH4czsFadedVc
         0/8QgrESXiUUfNNQz60rucK0xWUaOimSgSYpRmNT1Tn104oyZxkvkevLRIxWo86ljF4r
         EYzulYNO4xxLQtB3T61bl1xzCvgXTY6Rsja4bcwq0HwHISkUTueHpiBHzU/9/QUPvMlj
         sxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687767; x=1697292567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1GNuEYNNUVFdqSAVV7euIJsgJ2S6Nc7QjFuUbIKZ9c=;
        b=j2IZsG/+WKuFQyIhthwNP+cXqDi37IWtoYUKdrAvXR1jnr56lWM07F0U7+561P/JfM
         xQOVCDtHUdjzc1Pcy6g6hK+hn/3jcgUW7w1ZeVJ5zWG+tg+xSjfTY/jAL5XCRuS92wzz
         uFAz4Yja9T0XV3FalRJCnqvW7nS0DmW/Dh/gYRHsvKX5F2wvy06dlCoGIq0wa3RpEKZb
         ST20XG3zHNiVBulj0K0jqt9P4cexpkuBjokNYmi2cLy8zkaOs5o/I7lz3MnOz70VTt/e
         7QcIMAT9WrG3eQ6uOzfs+HVqNadxZ1WZ7m4mxAxt3uGvszGKPAgxZTE9ThAF1l9x1ioF
         5oaA==
X-Gm-Message-State: AOJu0Yxkx8BauPWABSwv6WV+H0MijepT6QBtOEgpjS9V3Ysz7LqDj0q0
	imXWzYRpB55svCBvsO148cQhbMB/zBg0QAViVlc+yA==
X-Google-Smtp-Source: AGHT+IEuzeksgO+F31But0MHyJbttH4gC9j8fBbtRuDGWkrqs+ZAAdILmdu/Wslo4ln8Db3VQ/DrkIZPrZ5r3XBMVkQ=
X-Received: by 2002:a0d:fc03:0:b0:59b:2be2:3560 with SMTP id
 m3-20020a0dfc03000000b0059b2be23560mr10184611ywf.48.1696687766751; Sat, 07
 Oct 2023 07:09:26 -0700 (PDT)
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
 <ZSEw32MVPK/qCsyz@nanopsycho> <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho>
In-Reply-To: <ZSFSfPFXuvMC/max@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Oct 2023 10:09:15 -0400
Message-ID: <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
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

On Sat, Oct 7, 2023 at 8:43=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Oct 07, 2023 at 01:06:43PM CEST, jhs@mojatatu.com wrote:
> >On Sat, Oct 7, 2023 at 6:20=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
> >> >On Fri, Oct 6, 2023 at 6:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >> >>
> >> >> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
> >> >> > > I don't understand the need for configuration less here. You do=
n't have
> >> >> > > it for the rest of the actions. Why this is special?
> >> >>
> >> >> +1, FWIW
> >> >
> >> >We dont have any rule that says all actions MUST have parameters ;->
> >> >There is nothing speacial about any action that doesnt have a
> >> >parameter.
> >>
> >> You are getting the configuration from the block/device the action is
> >> attached to. Can you point me to another action doing that?
> >
> >We are entering a pedantic road i am afraid. If there is no existing
> >action that has zero config then consider this one the first one. We
>
> Nope, nothing pedantic about it. I was just curious if there's anything
> out there I missed.
>

Not sure if you noticed in the patch: the blockid on which the skb
arrived on is now available in the tc_cb[] so when it shows up at the
action we can just use it.

>
> >use skb->metadata all the time as a source of information for actions,
> >classifiers, qdiscs. If i dont need config i dont need to invent one
>
> skb->metadata is something that is specific to a packet. That has
> nothing to do with the actual configuration.

Essentially we turned blockid into skb metadata. A user specifying
configuration of a different blockid is certainly useful. My point is
we can have both worlds: when such a user config is missing we'll
assume a default which happens to be in the skb.

>
> >just because, well, all other actions are using one or more config;->
> >Your suggestion to specify an extra config to select a block - which
> >may be different than the one the one packet on - is a useful
> >feature(it just adds more code) but really should be optional. i.e if
> >you dont specify a block id configuration then we pick the metadata
> >one.
>
> My primary point is, this should be mirred redirect to block instead of
> what we currently have only for dev. That's it.

Agreed (and such a feature should be added regardless of this action).
The tc block provides a simple abstraction, but do you think it is
enough? Alternative is to use a list of ports given to mirred: it
allows us to group ports from different tc blocks or even just a
subset of what is in a tc block - but it will require a lot more code
to express such functionality.

>
>
> >
> >> >If we can adequately cleanup mirred,  then we can put it there but
> >> >certainly now we are adding more buttons to click on mirred. It may
> >> >make sense to refactor the mirred code then reuse the refactored code
> >> >in a new action.
> >>
> >> I don't understand why you need any new action. mirred redirect to blo=
ck
> >> instead of dev is exactly what you need. Isn't it?
> >
> >The actions have different meanings and lumping them together then
> >selecting via a knob is not the right approach.
> >There's shared code for sure. Infact the sending code was ripped from
> >mirred so as not to touch the rest because like i said mirred has
> >since grown a couple of horns and tails. In retrospect mirred should
> >have been two actions with shared code - but it is too late to change
> >now because it is very widely used. If someone like me was afraid of
> >touching it is because there's a maintainance challenge. I consider it
> >in the same zone as trying to restructure something in the skb.
> >I agree mirroring to a group of ports with a simple config is a useful
> >feature. Mirroring to a group via a tc block is simpler but adding a
> >list of ports instead is more powerful. So this feature is useful to
> >have in mirred - just the adding of yet one more button to say "skip
> >this port" is my concern.
>
> Why? Perhaps skb->iif could be used for check in the tx iteration.
>

We use skb->dev->ifindex to find the exception. Is iif better?.
Jiri - but why does this have to be part of mirred::mirror? I am
asking the same question of why mirror and redirect have to be part
mirred instead of separate actions.

cheers,
jamal

