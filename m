Return-Path: <netdev+bounces-242741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B8C94709
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACF03A779C
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01522233D9C;
	Sat, 29 Nov 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="mcA9/JOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF21946AA
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764444804; cv=none; b=USC2e5Zxp3NDfLCKhMbBqFBJlyEtLCWLBMY9e3YsurQbxDAxjyNfD4ksXNBlWQz7tocK073cUGjtm8NGmzWD5Hu4stOdxdoiYDuUXs7jzWdxIrg86pGZ2Dyq2ZbP3uhZcZiQwCeFqiRZQbuIp0UxDBmX8anJY/XKfa+LQ6Drn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764444804; c=relaxed/simple;
	bh=f/KyVCRWNS1Y8RXUJQH+pdcC5xBr+/2oT62pE2DNR8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ONuMFzbm+/rqCAW5lFRRI0Uc6jPaWzRwTZzbOGZkginhhB+NsZuV963021RhTEZV3iV37YD06fc3eBJCRVyKF9Rlq9aNNgbRycw0bdL55dLoj4g46ftgVGmd7b3lHq3WhgDL714XHg1kNrmTdxrie/zQXozHu6fXNS8Y85ubHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=mcA9/JOK; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764444794; bh=f/KyVCRWNS1Y8RXUJQH+pdcC5xBr+/2oT62pE2DNR8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mcA9/JOKO+mcqnOtpkyJwZEecAs8jeYMaYl+y7QscbRinl/fYtSkCtTKqlFAa2n8n
	 BrOEI8rmqvFKMBP/+HoNMj/43Gw+jSFrjJ+FZUnHb2KR8uKQNJmHXo0uXpn74Wq8hh
	 hsibo6UOldCgwgVoqcFOHFb5JgSf/oNwU4N7Zj/t2T7uwoHRZgb7MdZkqx4aSWZIsG
	 aMNSM+w9Jkv37OgttawTEfJaU63VjL1CI3SyXzbWx+8xHzxu4gZPQQI03TqtUdGI7V
	 MUtWc2G/+ykayfCfNFQBV6sl2H4irbIz8fobETaAxy4eq+inQldMi0m0eUyD2KDuyr
	 LLonTXz/VwLGQ==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
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
In-Reply-To: <willemdebruijn.kernel.352b3243bf88@gmail.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com> <87a505b3dt.fsf@toke.dk>
 <willemdebruijn.kernel.352b3243bf88@gmail.com>
Date: Sat, 29 Nov 2025 20:33:14 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zf84ab2d.fsf@toke.dk>
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
>> >> Add a cake_mq qdisc which installs cake instances on each hardware
>> >> queue on a multi-queue device.
>> >>=20
>> >> This is just a copy of sch_mq that installs cake instead of the defau=
lt
>> >> qdisc on each queue. Subsequent commits will add sharing of the config
>> >> between cake instances, as well as a multi-queue aware shaper algorit=
hm.
>> >>=20
>> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> ---
>> >>  net/sched/sch_cake.c | 214 +++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>> >>  1 file changed, 213 insertions(+), 1 deletion(-)
>> >
>> > Is this code duplication unavoidable?
>> >
>> > Could the same be achieved by either
>> >
>> > extending the original sch_mq to have a variant that calls the
>> > custom cake_mq_change.
>> >
>> > Or avoid hanging the shared state off of parent mq entirely. Have the
>> > cake instances share it directly. E.g., where all but the instance on
>> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode (a
>> > bit like SO_REUSEPORT sockets) and lookup the state from that
>> > instance.
>>=20
>> We actually started out with something like that, but ended up with the
>> current variant for primarily UAPI reasons: Having the mq variant be a
>> separate named qdisc is simple and easy to understand ('cake' gets you
>> single-queue, 'cake_mq' gets you multi-queue).
>>=20
>> I think having that variant live with the cake code makes sense. I
>> suppose we could reuse a couple of the mq callbacks by exporting them
>> and calling them from the cake code and avoid some duplication that way.
>> I can follow up with a patch to consolidate those if you think it is
>> worth it to do so?
>
> Since most functions are identical, I do think reusing them is
> preferable over duplicating them.

Sure, that's fair. Seems relatively straight forward too:

https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?h=3D=
mq-cake-sub-qdisc&id=3Dfdb6891cc584a22d4823d771a602f9f1ee56eeae

> I'm not fully convinced that mq_cake + cake is preferable over
> mq + cake (my second suggestion). We also do not have a separate
> mq_fq, say. But mine is just one opinion from the peanut gallery.

Right, I do see what you mean; as I said we did consider this initially,
but went with this implementation from a configuration simplicity
consideration. If we were to implement this as an option when running
under the existing mq, we'd have to add an option to cake itself to opt
in to this behaviour, and then deal with the various combinations of
sub-qdiscs being added and removed (including mixing cake and non-cake
sub-qdiscs of the same mq). And userspace would have to setup the mq,
then manually add the cake instances with the shared flag underneath it.

Whereas with this cake_mq qdisc the user interface is as simple as
possible: just substitute 'cake_mq' for 'cake' if you want the
multi-queue behaviour on a device; everything else stays the same. Since
configuration simplicity is an explicit goal of cake, I think this is
appropriate; although it may not be for other qdiscs.

Hope that makes sense?

-Toke

