Return-Path: <netdev+bounces-54473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFE807366
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBC91F2182F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD903FB12;
	Wed,  6 Dec 2023 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="urRiwf/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228DB5
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:09:41 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d33574f64eso77839967b3.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701875381; x=1702480181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuB9ZPr3YpZQqGDVJOyJlSUD/FmE+LfvsXDusRilAMI=;
        b=urRiwf/ULEnABHVOV4+qwEUTTfOIBWmDuR6tGcaiJfuXp4h5nVxT1rMhIapa4KpghZ
         q0N9N9xIfHryF4eD7aoRqLpsktf38oIvLK07yG6Y9lWQUxbahK7RuWM+D3cjiREYLG2U
         HNh0lpH41tXhrrYJ45bv5F3MmnnwvqkLC5MYPk5JDIqlJzdtvsnAKb5zwpp5x0VWI11p
         tiy6gAy5kOYkS24pSKymMMgBUbOgceQPUtSdbimUathqVLKDj3ZRg48wK7fYLR+BvuRx
         bTmzH8BWckG+A025t9I35SnqMjKrmftJkL4/a4D1QCQwuLEhdDsvoh72JpiRy/eiBhWF
         o6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875381; x=1702480181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuB9ZPr3YpZQqGDVJOyJlSUD/FmE+LfvsXDusRilAMI=;
        b=BbCT5icatepi/A0MaxXwXFpJr/XNZ2vWOLXWFvydXJk1REnVdArMr2y8pVias8sWed
         x6XC5LNpV5CsP1WTMrPtQ/+1/CRBAYeN7rBe1CRnqLkcRg7jU6M2qh4t4mogUrcQ7a8l
         Lj7WeKjztQy80W37TcdzhIwNQCwR9MdTlylW9NZ5k9R9nVVQb839a2LiOnzWdPiNBVT8
         Kb+npFNT5vTI/zZk5BGDGMLqYKKVwI4Vv9Y728vuPlQprhQMRrLE3iZGuUQLbevipMmi
         Xew2Xzu42lb0SnwjXju/Ry/DD+ieqdQXqrv1GuvLrVxtqRk5ZeluFoAoPOq+z2HSS5iR
         KkTA==
X-Gm-Message-State: AOJu0Yzsxa5J+veGvimWM3mdZ+11wtzNiVdPPJ7iB8ZQmNI11qviZ96E
	S8n5lZM2LlZg5qoEnagsd0NrXg5i0TMP3dL5TrpXpg==
X-Google-Smtp-Source: AGHT+IGT/OsStExOpqa5jKpMHqXSkvFUW7VWlpgEswzPIjpaGPHgW3CFuWQKQurPs4a/5IpiVKnlCCLiYLuFOQrX47g=
X-Received: by 2002:a81:7e49:0:b0:5d6:c70f:7798 with SMTP id
 p9-20020a817e49000000b005d6c70f7798mr856929ywn.35.1701875380769; Wed, 06 Dec
 2023 07:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho> <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
 <ZW7iHub0oM5SZ/SF@nanopsycho> <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
 <CAM0EoMmax-t+ZiaQAOJxhDOtRK2Gi3_TcqVoLEhDQWjsfOaRJQ@mail.gmail.com>
 <CALnP8Zavd8N=9n42sbeKqE-mMKXHsFtmCHKOuG7sZEN5Z8m7kw@mail.gmail.com> <ZXApC8od2deGjKYi@nanopsycho>
In-Reply-To: <ZXApC8od2deGjKYi@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Dec 2023 10:09:29 -0500
Message-ID: <CAM0EoMkbK9PxRw23ROFLOiQtYwGyUkEAWTPACMVRy=Q-cBaVaQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:55=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Dec 05, 2023 at 11:12:23PM CET, mleitner@redhat.com wrote:
> >On Tue, Dec 05, 2023 at 10:27:31AM -0500, Jamal Hadi Salim wrote:
> >> On Tue, Dec 5, 2023 at 9:52=E2=80=AFAM Marcelo Ricardo Leitner
> >> <mleitner@redhat.com> wrote:
> >> >
> >> > On Tue, Dec 05, 2023 at 09:41:02AM +0100, Jiri Pirko wrote:
> >> > > Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
> >> > > >On Mon, Dec 4, 2023 at 4:49=E2=80=AFAM Jiri Pirko <jiri@resnulli.=
us> wrote:
> >> > > >>
> >> > > >> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
> >> > ...
> >> > > >> >Ok, so we are moving forward with mirred "mirror" option only =
for this then...
> >> > > >>
> >> > > >> Could you remind me why mirror and not redirect? Does the packe=
t
> >> > > >> continue through the stack?
> >> > > >
> >> > > >For mirror it is _a copy_ of the packet so it continues up the st=
ack
> >> > > >and you can have other actions follow it (including multiple mirr=
ors
> >> > > >after the first mirror). For redirect the packet is TC_ACT_CONSUM=
ED -
> >> > > >so removed from the stack processing (and cant be sent to more po=
rts).
> >> > > >That is how mirred has always worked and i believe thats how most
> >> > > >hardware works as well.
> >> > > >So sending to multiple ports has to be mirroring semantics (most
> >> > > >hardware assumes the same semantics).
> >> > >
> >> > > You assume cloning (sending to multiple ports) means mirror,
> >> > > that is I believe a mistake. Look at it from the perspective of
> >> > > replacing device by target for each action. Currently we have:
> >> > >
> >> > > 1) mirred mirror TARGET_DEVICE
> >> > >    Clones, sends to TARGET_DEVICE and continues up the stack
> >> > > 2) mirred redirect TARGET_DEVICE
> >> > >    Sends to TARGET_DEVICE, nothing is sent up the stack
> >> > >
> >> > > For block target, there should be exacly the same semantics:
> >> > >
> >> > > 1) mirred mirror TARGET_BLOCK
> >> > >    Clones (multiple times, for each block member), sends to TARGET=
_BLOCK
> >> > >    and continues up the stack
> >> > > 2) mirred redirect TARGET_BLOCK
> >> > >    Clones (multiple times, for each block member - 1), sends to
> >> > >    TARGET_BLOCK, nothing is sent up the stack
> >> >
> >> > This makes sense to me as well. When I first read Jamal's email I
> >> > didn't spot any confusion, but now I see there can be some. I think =
he
> >> > meant pretty much the same thing, referencing cascading other output=
s
> >> > after blockcast (and not the inner outputs, lets say), but that's ju=
st
> >> > my interpretation. :)
> >>
> >> In my (shall i say long experience) I have never seen the prescribed
> >> behavior of redirect meaning mirror to (all - last one) then redirect
> >> on last one.. Jiri, does spectrum work like this?
> >> Neither in s/w nor in h/w. From h/w - example, the nvidia CX6 you have
> >> to give explicit mirror, mirror, mirror, redirect. IOW, i dont think
> >> the hardware can be told "here's a list of ports, please mirror to all
> >> of them and for the last one steal the packet and redirect".
> >
> >Precisely. I/(we?) were talking about tc sw/user expectations, not how
> >to offload it.
> >
> >From a tc user perspective, the user should still be able to do this:
> >1) mirred mirror TARGET_BLOCK
> >2) mirred redirect TARGET_BLOCK
> >regardless of how the implementation actually works. Because ovs and
> >other users will rely on this semantic.
>
> Exactly. Forget about hw for now.

Ok, Lets go!

cheers,
jamal

>
> >
> >As for the actual implementation, as you said, it will have to somehow
> >unpack that into "[mirror, mirror, ...,] <mirror/redirect>", depending
> >on what the user requested, as I doubt there will be hw support for
> >outputting to multiple ports in one action.
> >
> >> Having said that i am not opposed to it - it will just make the code
> >> slightly more complex and i am sure slightly slower in the datapath.
> >>
> >> cheers,
> >> jamal
> >>
> >

