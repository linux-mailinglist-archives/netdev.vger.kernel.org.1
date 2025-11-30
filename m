Return-Path: <netdev+bounces-242826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36110C9524C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3F84E04FB
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804C280A52;
	Sun, 30 Nov 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="cTJitjao"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED7223702
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764519616; cv=none; b=PTF2bAqZnFNAbpcdG2Vv1cguotSZbYy4toEVm0m+HHS4Bdv/reM7yHNfcSUQsA4f7llltGCVvZwZS3KsPftc7TpXgpKmKqv48XrwBYqoOU3Tuf5Xjauy611sKcrhFUuJpvTiCjZArSbuTOErFS555vZvvI9tqX7IrfAF7bz0kaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764519616; c=relaxed/simple;
	bh=lFIBeiW6thAlk84emwzVfRqiPwy9MsCHuke4YUbOvMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZcZJwLxOuXjqK/1C5Ly5GuaYX0Y2ClXDSUMQj9Im/UPJ4X31LaYMyO2eQAqomerx3ljR53EwlW2E3kfPqIKghOHyILpCRiPC/d7A1U3NTlr+zakojzJTLgEFFZk1WYZQKRqtnjU3CwufHrpszYBuTrOSrdMPGAMXB4PFpim0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=cTJitjao; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764519600; bh=lFIBeiW6thAlk84emwzVfRqiPwy9MsCHuke4YUbOvMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cTJitjaoU2oMAk64PLOgauuz4IVCE2oxeZEJ33X2oF0JlxUXA4HE3ls0Pf6UlQTsD
	 2fjVP661xB6n8V92fdhAdfKKqNSF3CG9hhlT03B6Xv6XOc6Ml1FpYDqtLyNcxDsANW
	 IzcDqVBvD6KvdkXmyvyajQdggMUd6XFI8O0I2BuMzVGUOHdUXcesOe0lcngu1tyCR4
	 slnHZb0hQlkxZLBo+z+XZxiBB+jTOF8WKv4vdwP51iz4/YlWdu/8u+L4Udu5ht5N5X
	 PsuhRqMP1Uz5Qvy72JZ5/vXB3AXR0QLytSRHuMdqyeNQpa4uBjk3gQnCtYu4tRkCb+
	 131V+y0rSrM5w==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
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
In-Reply-To: <willemdebruijn.kernel.12cce168f29d0@gmail.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com> <87a505b3dt.fsf@toke.dk>
 <willemdebruijn.kernel.352b3243bf88@gmail.com> <87zf84ab2d.fsf@toke.dk>
 <willemdebruijn.kernel.12cce168f29d0@gmail.com>
Date: Sun, 30 Nov 2025 17:19:58 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsyba3wx.fsf@toke.dk>
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
>> >> >> Add a cake_mq qdisc which installs cake instances on each hardware
>> >> >> queue on a multi-queue device.
>> >> >>=20
>> >> >> This is just a copy of sch_mq that installs cake instead of the de=
fault
>> >> >> qdisc on each queue. Subsequent commits will add sharing of the co=
nfig
>> >> >> between cake instances, as well as a multi-queue aware shaper algo=
rithm.
>> >> >>=20
>> >> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> >> ---
>> >> >>  net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++++++=
++++++++++++-
>> >> >>  1 file changed, 213 insertions(+), 1 deletion(-)
>> >> >
>> >> > Is this code duplication unavoidable?
>> >> >
>> >> > Could the same be achieved by either
>> >> >
>> >> > extending the original sch_mq to have a variant that calls the
>> >> > custom cake_mq_change.
>> >> >
>> >> > Or avoid hanging the shared state off of parent mq entirely. Have t=
he
>> >> > cake instances share it directly. E.g., where all but the instance =
on
>> >> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode (a
>> >> > bit like SO_REUSEPORT sockets) and lookup the state from that
>> >> > instance.
>> >>=20
>> >> We actually started out with something like that, but ended up with t=
he
>> >> current variant for primarily UAPI reasons: Having the mq variant be a
>> >> separate named qdisc is simple and easy to understand ('cake' gets you
>> >> single-queue, 'cake_mq' gets you multi-queue).
>> >>=20
>> >> I think having that variant live with the cake code makes sense. I
>> >> suppose we could reuse a couple of the mq callbacks by exporting them
>> >> and calling them from the cake code and avoid some duplication that w=
ay.
>> >> I can follow up with a patch to consolidate those if you think it is
>> >> worth it to do so?
>> >
>> > Since most functions are identical, I do think reusing them is
>> > preferable over duplicating them.
>>=20
>> Sure, that's fair. Seems relatively straight forward too:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?h=
=3Dmq-cake-sub-qdisc&id=3Dfdb6891cc584a22d4823d771a602f9f1ee56eeae
>
> Great. That's good enough for me.

Cool. I folded it into the series, and it does make the patch a lot
simpler, so thank you for the suggestion!

>> > I'm not fully convinced that mq_cake + cake is preferable over
>> > mq + cake (my second suggestion). We also do not have a separate
>> > mq_fq, say. But mine is just one opinion from the peanut gallery.
>>=20
>> Right, I do see what you mean; as I said we did consider this initially,
>> but went with this implementation from a configuration simplicity
>> consideration.=20
>
> Then admins have only to install one qdisc, rather than what we do for
> FQ today which is one MQ + a loop over the FQs.
>
> I don't know if we have to coddle admins like that.

I don't really view it as coddling, but as making it as easy as possible
to take advantage of the mq variant in the most common configuration.
The primary use case for cake is shaping on the whole link (on home
routers, in particular), and the mq extension came about to address the
common bottleneck here where the cake shaper can't keep up with link
speeds on a single CPU. So I think it's worthwhile to make it as easy as
possible to consume that seems worthwhile, in a way that retains
compatibility with the existing tools that work on top of cake, such as
the autorate scripts:

https://github.com/sqm-autorate/sqm-autorate

>> If we were to implement this as an option when running
>> under the existing mq, we'd have to add an option to cake itself to opt
>> in to this behaviour, and then deal with the various combinations of
>> sub-qdiscs being added and removed (including mixing cake and non-cake
>> sub-qdiscs of the same mq). And userspace would have to setup the mq,
>> then manually add the cake instances with the shared flag underneath it.
>
> One question is whether the kernel needs to protect admins from doing
> the unexpected thing, which would be mixing mq children of different
> type when using shared cake state between children.
>
> Honestly, I don't think so. But it could be done. For instance by
> adding an mq option that requires all children to be of the same kind,
> or even by silently setting this if the first child added is a cake
> instance with shared option set.
>
> As for shared state, in cake_init the qdisc could check that the dev
> root is mq and it is a direct child of this qdisc, and then scan the
> mq children for the existence of a cake child. If one exists, take a
> ref on a shared state struct. If not, create the struct. Again, like
> SO_REUSEPORT.
>
> All easier said than implemented, of course, but seems doable?

Yeah, I do think it's doable; just needs a bit of thought around the
lifetime management of the shared config struct as sub-qdiscs come and
go.

I am not necessarily opposed to supporting this mode, including the case
where there's a mix of qdiscs on different HW queues. However, I view it
as an extension of the base use case, as described above. Now that we're
reusing the mq code, cake_mq becomes quite a lightweight addition, so we
could potentially support both? I.e., the cake_mq qdisc would be the
straight-forward way to load cake across a device, but we could add
support for sharing cake state across (a subset of) regular mq as well?
WDYT?

-Toke

