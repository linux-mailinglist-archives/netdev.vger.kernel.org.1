Return-Path: <netdev+bounces-55969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C265A80D012
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC281C2097C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F034BAB1;
	Mon, 11 Dec 2023 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="myE9lvUk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941ABD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:50:53 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5cbcfdeaff3so45779157b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702309852; x=1702914652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hps0C64CoyNeD9MOSqRfmVP377j1eR0EFq8kZD/E3j0=;
        b=myE9lvUkldtzVyjBaAipYRhXpKYaXiYLgDgq/liuPzcDXV7lzSvxb+yZpcvOAkNavg
         bR8p/gHII6LM84O3lU+meFin05Ls6KqT8pNSF5qpxhsvu+bNsopNxnDrDe6VUpkMNoDq
         hRVfRuCayWIcwnLExm9BxgkQnhjC2Kjd2gkATPaSHotQytdCuLR6yuiu9m8zELPfWBL6
         sH1J//pCCJ0afHYBlG4CN5OMs7GIm1Nf81quGw4ldSyMLCn566WQc3GBn14/ch1tJcI8
         mfbhSUakdfxwVLzjTlNCX6kimDgyVZHPDA9VaAf8QRLx6keZ3KjRCAB40q4CDHzGpXbd
         brbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309852; x=1702914652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hps0C64CoyNeD9MOSqRfmVP377j1eR0EFq8kZD/E3j0=;
        b=DEKqxb+kS6hCvr2fqcGvwxHwzytLg8g7Ws/nhlbUFE3ERS9M7JuJtwsRAKzxnywLmK
         yBy0HniAsyJ+LucSbpxC140Ev7PfrqDt8cANH8g8rV351ptToBkdh25KQZg7tTevJ++e
         xuQLd+nCSfcO200CJQQ6gpbjfFGOujco0F3wD2/gavLmTjY8EndseiVO3ZGmxNgjehMn
         80/SURepmIty74Ht8Pzo+nwFrwqTwGx3msxPNXJu9/Og0t/d6SWpWY1WrJVqZsvULIHA
         Gp6AzMYUMtM6sfw/O2UC+StZlXUS0wNmr4MNnDeEP2iwRrvkr70v9e4ftkPaSW7nolLI
         TD4g==
X-Gm-Message-State: AOJu0YwlTrDo469Ox+FhwWL+kCfFAVoMTVvZNXFslY2dqHyv8eGX+hLA
	sqsnjYr7ykS0FlrxVuMBAKzsPBq74DGC082mM2ZCp1C+NibRZYF9VU1KvQ==
X-Google-Smtp-Source: AGHT+IEHvRtjcWoge/0SGBLgFkiVduhipMufd0l6ExNwyZAbsDHpBKUXuq56riIRzXT/jw0OWrHOdBF3OMaVuyXiXJA=
X-Received: by 2002:a81:698b:0:b0:5d7:1940:f3f3 with SMTP id
 e133-20020a81698b000000b005d71940f3f3mr3858978ywc.91.1702309852470; Mon, 11
 Dec 2023 07:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1674233458.git.dcaratti@redhat.com> <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
 <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
 <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com>
 <CAM0EoMm6QHzFdFLJ8Q1nO6W-m47tkxzVp7k2rAZYJZNXCCbM9g@mail.gmail.com>
 <CAM0EoMmvjwxLmdT5pQJ-hXVMA2OJUfy8TJKDxZ=vf+Thzza0=Q@mail.gmail.com> <ZXcJrNZxt5uY1sdn@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZXcJrNZxt5uY1sdn@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 11 Dec 2023 10:50:40 -0500
Message-ID: <CAM0EoMmxv79t=5yuUTHsnOYPnePfCA_hPBGu99W52JJrNS=V3g@mail.gmail.com>
Subject: Re: Mirred broken WAS(Re: [PATCH net-next 2/2] act_mirred: use the
 backlog for nested calls to mirred ingress
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, wizhao@redhat.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On Mon, Dec 11, 2023 at 8:08=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> hello Jamal,
>
> On Thu, Dec 07, 2023 at 09:10:13AM -0500, Jamal Hadi Salim wrote:
> > Hi Davide,
> >
>
> [...]
>
> > > > > I am afraid this broke things. Here's a simple use case which cau=
ses
> > > > > an infinite loop (that we found while testing blockcasting but
> > > > > simplified to demonstrate the issue):
> > > >
> > > > [...]
> > > >
> > > > > sudo ip netns exec p4node tc qdisc add dev port0 clsact
> > > > > sudo ip netns exec p4node tc filter add dev port0 ingress protoco=
l ip
> > > > > prio 10 matchall action mirred ingress redirect dev port0
> > > >
> > > > the above rule is taking packets from port0 ingress and putting it
> > > > again in the mirred ingress of the same device, hence the loop.
> > >
> > > Right - that was intentional to show the loop. We are worrying about
> > > extending mirred now to also broadcast (see the blockcast discussion)
> > > to more ports making the loop even worse. The loop should terminate a=
t
> > > some point - in this case it does not...
> > >
> > > > I don't see it much different than what we can obtain with bridges:
> > > >
> > > > # ip link add name one type veth peer name two
> > > > # ip link add name three type veth peer name four
> > > > # for n in even odd; do ip link add name $n type bridge; done
> > > > # for n in one two three four even odd; do ip link set dev $n up; d=
one
> > > > # for n in one three; do ip link set dev $n master odd; done
> > > > # for n in two four; do ip link set dev $n master even; done
> > > >
> > >
> > > Sure that is another way to reproduce.
> >
> > Ok, so i can verify that re-introduction of the ttl field in the
> > skb[1] fixes the issue. But restoring that patch may cause too much
> > bikeshedding. Victor will work on a better approach using the cb
> > struct instead - there may. Are you able to test with/out your patch
> > and see if this same patch fixes it?
>
> I'm also more optimistic on the use of qdisc cb for that purpose :)
> Just share the code, i will be happy to review/test.
> With regular TC mirred, the deadlock happened with TCP and SCTP socket
> locks, as they were sending an ACK back for a packet that was sent by
> the peer using egress->ingress.
>
> AFAIR there is a small reproducer in tc_actions.sh kselftest, namely
>
> mirred_egress_to_ingress_tcp_test()
>
> maybe it's useful for pre-verification also.
>

Ah, good - didnt realize there was a reproducer for your use case.
We'll try it out.

> [...]
>
> my 2 cents  below:
>
> > > I dont think we can run something equivalent inside the kernel. The
> > > ttl worked fine. BTW, the example shown breaks even when you have
> > > everything running on a single cpu (and packets being queued on the
> > > backlog)
>
> [...]
>
> > > Yes, we need to make sure those are fixed with whatever replacement..
> > > The loops will happen even on egress->egress (the example only showed
> > > ingress-ingress).
>
> if you try to make a loop using mirred egress/redirect, the first packet
> will trigger a deadlock on the root qdisc lock - see [1]. It's worse
> than a loop, because user can't fix it by just removing the "offending"
> mirred action. Would the ttl be helpful here?
>

Possible. So the test is just to create a loop?
Lets test with the reproducer you pointed out then see where we go from the=
re.

> (in the meanwhile, I ill try to figure out if it's possible at least to
> silence false lockdep warnings without using dynamic keys, as per
> Eric reply).
>

Sorry, wasnt helpful - i have been in travel mode for the last week.

cheers,
jamal
> TIA!
>
> --
> davide
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomme=
nt-1782690200
>
>

