Return-Path: <netdev+bounces-54861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0908089EA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0907E1C2096B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6641743;
	Thu,  7 Dec 2023 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RtAKYDCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D4C10E4
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 06:10:26 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d7a47d06eeso7882007b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701958225; x=1702563025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDGlQYDb5PUCcczbzebIyUx2ResvXtOo+s87LRLH3zs=;
        b=RtAKYDColJ+Hwj66XMHoYWoqFnijV+E2Fl+W4OeI0g0e55+kvX4wc5x99vnTEbHPEg
         tAXcidR2nrrnmvcgsask5frtXscd7uCk2rFwSdhE1FOrfagDRDlHWTEXmjom5aZoSv3M
         dLBYAmiqxGqAm88A6A6JK315kjyAWEiM2y7Ij1L35gQP9AsVnMeepL3YRie7A9zAIc2f
         iz50kyeL8maPkIs8QCmkOrkCzJc/PrmI9TZMtR5B07ZJBvxpnnx08C6ejEuo5LHMQzkM
         wVyIY+OanDYUToZsGe9iIO5m1vuoiY5SvSOGdzgUOG7DC2Tp9RA2kTrrX0lVM+lJvG7O
         NZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958225; x=1702563025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDGlQYDb5PUCcczbzebIyUx2ResvXtOo+s87LRLH3zs=;
        b=asLkID1K7tbKlQTs/Z5jKtIU5ojnyqqqCcJG0o2+jvgPeJnicqR1KiJV9yjeTcqE5n
         lKdbdQSkto+hWopWy9T8n59KTZDIG3Va71Pxb3e74h/OqHp17nOcMEDpdTOp7JiZakGm
         FJva1Qt941l+uyaB+bvsTlXRvE94Z3/1Xli3/OoUlakWTNHNS9m8YqzBw+P35QN54idv
         yGnXMUeY0k573YsRM7S6754kyXWAtGiJrnVv4XY5ZsW3CqjZMtnnjmktNzc+P8/27xLw
         yBGGOqnwTONXmT8h80kuyD0gsEtH40QSbsd7dynagavwmSe4Mtum+tspshz8Cv42luA8
         MHzA==
X-Gm-Message-State: AOJu0YwLRgCoQcpQugKi3gyC3P+coRkSmsmaAAI8HVu2QtEBCrVnfypB
	PW0GMen9ZyHorxC2MFMwv4ajivoqKjPPJjVv34HOQg==
X-Google-Smtp-Source: AGHT+IHlXNWdOZ8QC8IUstIusrU0V6V71CjdzbND+uTsAe3x7XbWfUVIrrLtyXnac+A71ULvwPlfHajKKebicYyjzxM=
X-Received: by 2002:a0d:dd0d:0:b0:5d4:ce2:e90d with SMTP id
 g13-20020a0ddd0d000000b005d40ce2e90dmr2364538ywe.31.1701958225246; Thu, 07
 Dec 2023 06:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1674233458.git.dcaratti@redhat.com> <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
 <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
 <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com> <CAM0EoMm6QHzFdFLJ8Q1nO6W-m47tkxzVp7k2rAZYJZNXCCbM9g@mail.gmail.com>
In-Reply-To: <CAM0EoMm6QHzFdFLJ8Q1nO6W-m47tkxzVp7k2rAZYJZNXCCbM9g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 7 Dec 2023 09:10:13 -0500
Message-ID: <CAM0EoMmvjwxLmdT5pQJ-hXVMA2OJUfy8TJKDxZ=vf+Thzza0=Q@mail.gmail.com>
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


On Tue, Dec 5, 2023 at 10:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Dec 5, 2023 at 5:54=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
> >
> > hello Jamal, thanks for looking at this!
> >
> > On Mon, Dec 4, 2023 at 9:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Fri, Jan 20, 2023 at 12:02=E2=80=AFPM Davide Caratti <dcaratti@red=
hat.com> wrote:
> > > >
> > > > William reports kernel soft-lockups on some OVS topologies when TC =
mirred
> > > > egress->ingress action is hit by local TCP traffic [1].
> > > > The same can also be reproduced with SCTP (thanks Xin for verifying=
), when
> > > > client and server reach themselves through mirred egress to ingress=
, and
> > > > one of the two peers sends a "heartbeat" packet (from within a time=
r).
> >
> > [...]
> >
> > > I am afraid this broke things. Here's a simple use case which causes
> > > an infinite loop (that we found while testing blockcasting but
> > > simplified to demonstrate the issue):
> >
> > [...]
> >
> > > sudo ip netns exec p4node tc qdisc add dev port0 clsact
> > > sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip
> > > prio 10 matchall action mirred ingress redirect dev port0
> >
> > the above rule is taking packets from port0 ingress and putting it
> > again in the mirred ingress of the same device, hence the loop.
>
> Right - that was intentional to show the loop. We are worrying about
> extending mirred now to also broadcast (see the blockcast discussion)
> to more ports making the loop even worse. The loop should terminate at
> some point - in this case it does not...
>
> > I don't see it much different than what we can obtain with bridges:
> >
> > # ip link add name one type veth peer name two
> > # ip link add name three type veth peer name four
> > # for n in even odd; do ip link add name $n type bridge; done
> > # for n in one two three four even odd; do ip link set dev $n up; done
> > # for n in one three; do ip link set dev $n master odd; done
> > # for n in two four; do ip link set dev $n master even; done
> >
>
> Sure that is another way to reproduce.

Ok, so i can verify that re-introduction of the ttl field in the
skb[1] fixes the issue. But restoring that patch may cause too much
bikeshedding. Victor will work on a better approach using the cb
struct instead - there may. Are you able to test with/out your patch
and see if this same patch fixes it?

cheers,
jamal

[1]https://lore.kernel.org/all/1430765318-13788-1-git-send-email-fw@strlen.=
de/

> > there is a practical difference: with bridges we have protocols (like
> > STP) that can detect and act-upon loops - while TC mirred needs some
> > facility on top (not 100% sure, but the same might also apply to
> > similar tools, such as users of bpf_redirect() helper)
> >
>
> I dont think we can run something equivalent inside the kernel. The
> ttl worked fine. BTW, the example shown breaks even when you have
> everything running on a single cpu (and packets being queued on the
> backlog)
>
> > > reverting the patch fixes things and it gets caught by the nested
> > > recursion check.
> >
> > the price of that revert is: we'll see those soft-lockups again with
> > L4 protocols when peers communicate through mirred egress -> ingress.
> >
> > And even if it would fix mirred egress->ingress loops, we would still
> > suffer from soft-lockups (on the qdisc root lock) when the same rule
> > is done with mirred egress (see an example at
> > https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment=
-1782690200)
> > [1]
>
> Yes, we need to make sure those are fixed with whatever replacement..
> The loops will happen even on egress->egress (the example only showed
> ingress-ingress).
>
> We will try restoring the ttl and see if it continues to work with
> your patch intact... unless there are other ideas.
>
> > > Frankly, I believe we should restore a proper ttl from what was remov=
ed here:
> > > https://lore.kernel.org/all/1430765318-13788-1-git-send-email-fw@strl=
en.de/
> > > The headaches(and time consumed) trying to save the 3-4 bits removing
> > > the ttl field is not worth it imo.
> >
> > TTL would protect us against loops when they are on the same node:
> > what do you think about inserting a rule that detects BPDU before the
> > mirred ingress rule?
>
> I dont think running STP will save us from this, unless i am mistaken.
> This happens within the kernel before the packet hits the "wire".
> Besides this happens without using any bridging.
>
> > [1] by the way: the POC patch at
> > https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment=
-1782654075
> > silcences lockdep false warnings, and it preserves the splat when the
> > real deadlock happens with TC marred egress. If you agree I will send
> > it soon to this ML for review.
>
> please do.
>
> cheers,
> jamal

