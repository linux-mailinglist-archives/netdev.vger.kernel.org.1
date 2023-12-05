Return-Path: <netdev+bounces-53987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BB805851
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83E91C20F8A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68067E92;
	Tue,  5 Dec 2023 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yV+avZ1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E01A5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:12:57 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d719a2004fso23537137b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701789176; x=1702393976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL0QhbXmHorEXJcV4b8IBdv1Ae2E1hgML6wB1P0EvVc=;
        b=yV+avZ1jGnHNqx4rQxEvrKW2Tw8H0R5OMFc19Ordq+wvzM16wJlqHWrfyJMaujY3ST
         clL/VZjjsLurpXGbbuaVMeS/Q1mytyxeOONDrum8NGoBfyhHW8qx0QiMaV7aSxDO4ZOF
         dQlfs7t75Hq4j3YuD0lYhUf0qaLuFY0kUYJVJHATer2M5ELylly5zP/qeWle5VzdWyuy
         peRPRP5rUwqERx4n0pJ9LS/eYx5m9dIU/XLvMbv/kZ3EtkHDx0bOSl3qAzw91T3lQduy
         7SOBUD/85klDXi1L0+FYFtAv22PlF7LLuelIvubB+odnNU7TcwVRntw9nwi5IdoI8kv+
         D3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701789176; x=1702393976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL0QhbXmHorEXJcV4b8IBdv1Ae2E1hgML6wB1P0EvVc=;
        b=t7ZLZJyhzSSyPGb0w0dFvCJWVq+8gMe6GXiDbFHw1pR4VOikLENX4/2vpmLB+UvLqa
         yt60QiMRDUd/2vyZJTf0KBQTZm7hPnxvoDmFrbBYzXfRxbyKp5LIY0E5V8ExL9iL/dnY
         3xBbouNQIAuDWzod3LhXB/tN2m9spRvVG87RevC0tRiDDmHlqevNlwmBVj1jO/odSI2H
         tOQculRrJWhNQv6Qyev1f5ClLYn49l+V9Ae1O8MTYDcHfaljOaCFf9cweOWKFk6/fzsW
         xPy0j136rzIKlIkvrkLEdUp0M1iBCBsu+quR1KjwzqJQRrJUT+KTxGVvsGG5vvd5+rIf
         2sqg==
X-Gm-Message-State: AOJu0YzRm+AZIN9WUWEu4HoH3vVIXMrNIWbhaIhL8Vf+fhPGzQKxEPW0
	KyQg/FCGb56ICRr+td0uh50XyD7KZcn0la5h2zhP1g==
X-Google-Smtp-Source: AGHT+IE0adhJ3lavPf95IACQoWP7h5//Uh8fhEdq5BQ+rE4M/a2jyLnuLc5JcEwHEre6auq3lYJXqWk75dsGJcmKRIw=
X-Received: by 2002:a05:690c:368d:b0:5d4:28f4:1c7 with SMTP id
 fu13-20020a05690c368d00b005d428f401c7mr2887436ywb.42.1701789176586; Tue, 05
 Dec 2023 07:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1674233458.git.dcaratti@redhat.com> <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
 <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com> <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com>
In-Reply-To: <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 5 Dec 2023 10:12:45 -0500
Message-ID: <CAM0EoMm6QHzFdFLJ8Q1nO6W-m47tkxzVp7k2rAZYJZNXCCbM9g@mail.gmail.com>
Subject: Re: Mirred broken WAS(Re: [PATCH net-next 2/2] act_mirred: use the
 backlog for nested calls to mirred ingress
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, wizhao@redhat.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:54=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> hello Jamal, thanks for looking at this!
>
> On Mon, Dec 4, 2023 at 9:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Fri, Jan 20, 2023 at 12:02=E2=80=AFPM Davide Caratti <dcaratti@redha=
t.com> wrote:
> > >
> > > William reports kernel soft-lockups on some OVS topologies when TC mi=
rred
> > > egress->ingress action is hit by local TCP traffic [1].
> > > The same can also be reproduced with SCTP (thanks Xin for verifying),=
 when
> > > client and server reach themselves through mirred egress to ingress, =
and
> > > one of the two peers sends a "heartbeat" packet (from within a timer)=
.
>
> [...]
>
> > I am afraid this broke things. Here's a simple use case which causes
> > an infinite loop (that we found while testing blockcasting but
> > simplified to demonstrate the issue):
>
> [...]
>
> > sudo ip netns exec p4node tc qdisc add dev port0 clsact
> > sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip
> > prio 10 matchall action mirred ingress redirect dev port0
>
> the above rule is taking packets from port0 ingress and putting it
> again in the mirred ingress of the same device, hence the loop.

Right - that was intentional to show the loop. We are worrying about
extending mirred now to also broadcast (see the blockcast discussion)
to more ports making the loop even worse. The loop should terminate at
some point - in this case it does not...

> I don't see it much different than what we can obtain with bridges:
>
> # ip link add name one type veth peer name two
> # ip link add name three type veth peer name four
> # for n in even odd; do ip link add name $n type bridge; done
> # for n in one two three four even odd; do ip link set dev $n up; done
> # for n in one three; do ip link set dev $n master odd; done
> # for n in two four; do ip link set dev $n master even; done
>

Sure that is another way to reproduce.

> there is a practical difference: with bridges we have protocols (like
> STP) that can detect and act-upon loops - while TC mirred needs some
> facility on top (not 100% sure, but the same might also apply to
> similar tools, such as users of bpf_redirect() helper)
>

I dont think we can run something equivalent inside the kernel. The
ttl worked fine. BTW, the example shown breaks even when you have
everything running on a single cpu (and packets being queued on the
backlog)

> > reverting the patch fixes things and it gets caught by the nested
> > recursion check.
>
> the price of that revert is: we'll see those soft-lockups again with
> L4 protocols when peers communicate through mirred egress -> ingress.
>
> And even if it would fix mirred egress->ingress loops, we would still
> suffer from soft-lockups (on the qdisc root lock) when the same rule
> is done with mirred egress (see an example at
> https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment-1=
782690200)
> [1]

Yes, we need to make sure those are fixed with whatever replacement..
The loops will happen even on egress->egress (the example only showed
ingress-ingress).

We will try restoring the ttl and see if it continues to work with
your patch intact... unless there are other ideas.

> > Frankly, I believe we should restore a proper ttl from what was removed=
 here:
> > https://lore.kernel.org/all/1430765318-13788-1-git-send-email-fw@strlen=
.de/
> > The headaches(and time consumed) trying to save the 3-4 bits removing
> > the ttl field is not worth it imo.
>
> TTL would protect us against loops when they are on the same node:
> what do you think about inserting a rule that detects BPDU before the
> mirred ingress rule?

I dont think running STP will save us from this, unless i am mistaken.
This happens within the kernel before the packet hits the "wire".
Besides this happens without using any bridging.

> [1] by the way: the POC patch at
> https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment-1=
782654075
> silcences lockdep false warnings, and it preserves the splat when the
> real deadlock happens with TC marred egress. If you agree I will send
> it soon to this ML for review.

please do.

cheers,
jamal

