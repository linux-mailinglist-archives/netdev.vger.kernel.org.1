Return-Path: <netdev+bounces-242837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FDC95480
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBF3A2872
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CA23D7DB;
	Sun, 30 Nov 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="RHVjMNFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3821E098
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534870; cv=none; b=lw1zC5dPbVCTy6G+tbIWcMFNRbZMgZdeL8bmb+Bw4IcwlHFiMU+q7myFQfRUmxKKTtiyLFRd6Ilo2ICkLOy7SHNhuRklP0Xqm40SSC2j+X+1qruuePsZfY504V+ZD0JAiLJg3hen5YYLeYSd5Ur6Zo3F7GGGvTVcQ0Am4qVZQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534870; c=relaxed/simple;
	bh=/XVLRUvvO1SSEaQUOc5WImXhXd0adtg+yKhUJbCiaTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hxsJLl03W4QPnAOhZdauUucn3/6NguIRkWH/5atZeBqcaXkogLVM9kGFvrDwtiyIXo/MQMrvFEZ95sKTS+KOA8NjbPtUQRO12xFAF8QuZu+43Sj1H6Op/KbBvOBVnHVucze2NcM6WecPBOe6w+7kzONXIZjXQpg845ziSRYR4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=RHVjMNFv; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764534863; bh=/XVLRUvvO1SSEaQUOc5WImXhXd0adtg+yKhUJbCiaTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RHVjMNFvXKgd7MAGIsx41eHiSlt5iM5/4qnxfw9xCYUTc5fSViB6kh0X6TIeSHZnM
	 GRHgIembIBp7dhYVcGk1UrKdzfBIsymCN19prz+4C0+D86XbYiETAqbQ1cMUkkUI8f
	 U7GvDeAe6Lv5VYaOQpagT0f3CZWEtuDDe5b8UYuf6CDAuO/EibaB1hoyeT9WTAgGYE
	 KJ32a9U3oOZSilP8Btko9+ZDueiJ9x1LIeZPQsBF0qbhA11pSLqsK2tAnPJ1slJJ5X
	 2WsNEfc0vY67CA+WZ1pH//tTutKkwtxSUn24phWXjGy1NOJXFRcTjxZ971ZYAvQS42
	 OE5q6/yStRyIA==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
In-Reply-To: <willemdebruijn.kernel.69fe80979368@gmail.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com> <87a505b3dt.fsf@toke.dk>
 <willemdebruijn.kernel.352b3243bf88@gmail.com> <87zf84ab2d.fsf@toke.dk>
 <willemdebruijn.kernel.12cce168f29d0@gmail.com> <87tsyba3wx.fsf@toke.dk>
 <willemdebruijn.kernel.69fe80979368@gmail.com>
Date: Sun, 30 Nov 2025 21:34:21 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pl8z9s4y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
>>=20
>> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
>> >>=20
>> >> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> >> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
>> >> >>=20
>> >> >> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> >> >> Add a cake_mq qdisc which installs cake instances on each hardw=
are
>> >> >> >> queue on a multi-queue device.
>> >> >> >>=20
>> >> >> >> This is just a copy of sch_mq that installs cake instead of the=
 default
>> >> >> >> qdisc on each queue. Subsequent commits will add sharing of the=
 config
>> >> >> >> between cake instances, as well as a multi-queue aware shaper a=
lgorithm.
>> >> >> >>=20
>> >> >> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.co=
m>
>> >> >> >> ---
>> >> >> >>  net/sched/sch_cake.c | 214 +++++++++++++++++++++++++++++++++++=
+++++++++++++++-
>> >> >> >>  1 file changed, 213 insertions(+), 1 deletion(-)
>> >> >> >
>> >> >> > Is this code duplication unavoidable?
>> >> >> >
>> >> >> > Could the same be achieved by either
>> >> >> >
>> >> >> > extending the original sch_mq to have a variant that calls the
>> >> >> > custom cake_mq_change.
>> >> >> >
>> >> >> > Or avoid hanging the shared state off of parent mq entirely. Hav=
e the
>> >> >> > cake instances share it directly. E.g., where all but the instan=
ce on
>> >> >> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mod=
e (a
>> >> >> > bit like SO_REUSEPORT sockets) and lookup the state from that
>> >> >> > instance.
>> >> >>=20
>> >> >> We actually started out with something like that, but ended up wit=
h the
>> >> >> current variant for primarily UAPI reasons: Having the mq variant =
be a
>> >> >> separate named qdisc is simple and easy to understand ('cake' gets=
 you
>> >> >> single-queue, 'cake_mq' gets you multi-queue).
>> >> >>=20
>> >> >> I think having that variant live with the cake code makes sense. I
>> >> >> suppose we could reuse a couple of the mq callbacks by exporting t=
hem
>> >> >> and calling them from the cake code and avoid some duplication tha=
t way.
>> >> >> I can follow up with a patch to consolidate those if you think it =
is
>> >> >> worth it to do so?
>> >> >
>> >> > Since most functions are identical, I do think reusing them is
>> >> > preferable over duplicating them.
>> >>=20
>> >> Sure, that's fair. Seems relatively straight forward too:
>> >>=20
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit=
/?h=3Dmq-cake-sub-qdisc&id=3Dfdb6891cc584a22d4823d771a602f9f1ee56eeae
>> >
>> > Great. That's good enough for me.
>>=20
>> Cool. I folded it into the series, and it does make the patch a lot
>> simpler, so thank you for the suggestion!
>>=20
>> >> > I'm not fully convinced that mq_cake + cake is preferable over
>> >> > mq + cake (my second suggestion). We also do not have a separate
>> >> > mq_fq, say. But mine is just one opinion from the peanut gallery.
>> >>=20
>> >> Right, I do see what you mean; as I said we did consider this initial=
ly,
>> >> but went with this implementation from a configuration simplicity
>> >> consideration.=20
>> >
>> > Then admins have only to install one qdisc, rather than what we do for
>> > FQ today which is one MQ + a loop over the FQs.
>> >
>> > I don't know if we have to coddle admins like that.
>>=20
>> I don't really view it as coddling, but as making it as easy as possible
>> to take advantage of the mq variant in the most common configuration.
>> The primary use case for cake is shaping on the whole link (on home
>> routers, in particular), and the mq extension came about to address the
>> common bottleneck here where the cake shaper can't keep up with link
>> speeds on a single CPU. So I think it's worthwhile to make it as easy as
>> possible to consume that seems worthwhile, in a way that retains
>> compatibility with the existing tools that work on top of cake, such as
>> the autorate scripts:
>>=20
>> https://github.com/sqm-autorate/sqm-autorate
>>=20
>> >> If we were to implement this as an option when running
>> >> under the existing mq, we'd have to add an option to cake itself to o=
pt
>> >> in to this behaviour, and then deal with the various combinations of
>> >> sub-qdiscs being added and removed (including mixing cake and non-cake
>> >> sub-qdiscs of the same mq). And userspace would have to setup the mq,
>> >> then manually add the cake instances with the shared flag underneath =
it.
>> >
>> > One question is whether the kernel needs to protect admins from doing
>> > the unexpected thing, which would be mixing mq children of different
>> > type when using shared cake state between children.
>> >
>> > Honestly, I don't think so. But it could be done. For instance by
>> > adding an mq option that requires all children to be of the same kind,
>> > or even by silently setting this if the first child added is a cake
>> > instance with shared option set.
>> >
>> > As for shared state, in cake_init the qdisc could check that the dev
>> > root is mq and it is a direct child of this qdisc, and then scan the
>> > mq children for the existence of a cake child. If one exists, take a
>> > ref on a shared state struct. If not, create the struct. Again, like
>> > SO_REUSEPORT.
>> >
>> > All easier said than implemented, of course, but seems doable?
>>=20
>> Yeah, I do think it's doable; just needs a bit of thought around the
>> lifetime management of the shared config struct as sub-qdiscs come and
>> go.
>>=20
>> I am not necessarily opposed to supporting this mode, including the case
>> where there's a mix of qdiscs on different HW queues. However, I view it
>> as an extension of the base use case, as described above. Now that we're
>> reusing the mq code, cake_mq becomes quite a lightweight addition, so we
>> could potentially support both? I.e., the cake_mq qdisc would be the
>> straight-forward way to load cake across a device, but we could add
>> support for sharing cake state across (a subset of) regular mq as well?
>> WDYT?
>
> I'd only plan to do it once, do it right.
>
> mq_cake has the advantage of being simpler to configure.
>
> The alternative that it allows more configurations. But we don't
> immediately see real use cases for those.
>
> Your call, assuming no one else chimes in.

Right. Well, given the somewhat speculative nature of the combination
use cases, I am still leaning towards the cake_mq version. Will submit a
v3 with the shared sch_mq code.

Thank you for looking at the code and chiming in!

-Toke

