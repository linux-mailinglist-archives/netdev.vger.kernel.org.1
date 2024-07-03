Return-Path: <netdev+bounces-109041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B89926A20
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455D81F2246F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC21836C3;
	Wed,  3 Jul 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6rtFWk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1882BB13
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041619; cv=none; b=JBI2mEoQJIJkbOw7cWBzqTQg15hbcySpPhbf3xrobCY0js8jAJXKzdYE1DWQM88Eo97/RdIRR/bTTpTkC7HJxiJlzRNRZu1ZN3fr2TrGxNroAVsEQSw8yq9em0GhMzNPMa292CCqA9PWToMKvmluZ6XWoQThwx+1pFa5kEI0HvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041619; c=relaxed/simple;
	bh=VKAihJE3FC26LspBosWDDGUS2opLofhC0D7FBk+000w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9OMsT+L2lQXbose/cw++M3KgKJ2DsmZkkNTa4VQC9+czyCk1tXWWtJwu/07xNReN3S9MJDfNvU4dkabDAnIADNMLlsR6M0xD7DiLYqbpE+8oOp7rOA0eWjeKMOSscy/JIyZIOyJpLAVJThaKU06Cnh+IFfjtbsAM510az7L07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6rtFWk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D7C2BD10;
	Wed,  3 Jul 2024 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720041618;
	bh=VKAihJE3FC26LspBosWDDGUS2opLofhC0D7FBk+000w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u6rtFWk+poumcxZlufIZedw9TgRQ/JICRu0T6AiDGZbKLCC3NC8g/A58WAqcz65p9
	 GGxHESGMaw0JPcu0IXCs/EjErwQ6teDwhpuDAxhmxZCmdDedKT+T1TYwYq74r8P0QJ
	 J61ZzQMg5CNo9q08FYd0oLq05xTFY5Ui3GZ+0LOI6ZzMgj/OJaBGsF7ATnVQ6QMYMw
	 ZA0AINodALxf8eneB2Ehz3HEom9/MTUMKxNLIu5K5tcY+oB5fI1lCA3fOlwqbd5Q/E
	 ae/O87+cJxDNROF1zQpFs/jyZt9mcxQPd97y3ol28wtkwYP+tgy+nFPVy5hII0BznA
	 UzNsSZGIibn/A==
Date: Wed, 3 Jul 2024 14:20:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240703142017.346ed0c1@kernel.org>
In-Reply-To: <2e4bf0dcffe51a7bc4d427e33f132a99ceac8d8a.camel@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	<75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	<20240628191230.138c66d7@kernel.org>
	<4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
	<20240701195418.5b465d9c@kernel.org>
	<e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
	<20240702080452.06e363ae@kernel.org>
	<CAF6piCLnrDWo70ZgXLtdmRkr+w5TMtuXPMW9=JKSSN2fvw1HMA@mail.gmail.com>
	<20240702140830.2890f77b@kernel.org>
	<2e4bf0dcffe51a7bc4d427e33f132a99ceac8d8a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Jul 2024 16:53:38 +0200 Paolo Abeni wrote:
> Note there is no stats support for the shapers, nor is planned, nor the
> H/W I know of have any support for it.
>=20
> The destructive operations will be needed only when the configuration
> change is inherently destructive. Nothing prevents the user-space to
> push a direct configuration change when possible - which should be the
> most frequent case, in practice.
>=20
> Regarding the entity responsible for control, I had in mind a single
> one, yes. I read the above as you are looking forward to e.g. different
> applications configuring their own shaping accessing directly the NL
> interface, am I correct? Why can=E2=80=99t such applications talk to that
> daemon, instead?=20

We know such daemon did not materialize in other cases.
We can assume there is a daemon if we think that's a good design.
We shouldn't use a mirage of a third-party daemon to wave away
problems we didn't manage to solve.

> Anyway different applications must touch disjoint resources (e.g.
> disjoint queues sets) right? In such a case even multiple destructive
> configuration changes (on disjoint resources set) will not be
> problematic.
>=20
> Still if we want to allow somewhat consistent, concurrent, destructive
> configuration changes on shared resource (why? It sounds a bit of
> overdesign at this point), we could extend the set() operation to
> additional support shapers deletion, e.g. adding an additional =E2=80=98d=
elete=E2=80=99
> flag attribute to the =E2=80=98handle=E2=80=99 sub-set.

To judge whether it's an over-design we'd need to know what the user
scenarios are, those are not included in the series AFAICS.

> > For a fixed-layout scheduler where HW blocks have a fixed mapping=20
> > with user's hierarchy - it's easier to program the shapers from=20
> > the hierarchy directly. Since node maps to the same set of registers
> > reprogramming will be writing to a register a value it already has
> > - a noop. That's different than doing a full reset and reprogram=20
> > each time, as two separate calls from user space.
> >=20
> > For Intel's cases OTOH, when each command is a separate FW call
> > we can't actually enforce the atomic transitions, right?
> > Your code seems to handle returns smaller the number of commands,
> > from which I infer that we may execute half of the modification? =20
>=20
> Yes, the code and the NL API allows the NIC to do the update
> incrementally, and AFAICS Intel ICE has no support for complex
> transactions.
> Somewhat enforcing atomic transitions will be quite complex at best and
> is not need to accomplish the stated goal - allow reconfiguration even
> when the H/W does not support intermediate states.
>=20
> Do we need to enforce atomicity? Why? NFT has proven that a
> transational model implementation is hard, and should be avoided if
> possible.=20
>=20
> > IOW for Andrew's HW - he'd probably prefer to look at the resulting
> > tree, no matter what previous state we were in. For Intel we _can't_
> > support atomic commands, if they span multiple cycles of FW exchanges? =
=20
>=20
> My understanding is that we can=E2=80=99t have atomic updates on Intel, f=
rom
> firmare perspective. As said, I don=E2=80=99t think it=E2=80=99s necessar=
y to support
> them.
>=20
> WRT the DSA H/W, do you mean the core should always set() the whole
> known tree to the driver, regardless of the specific changes asked by
> the user-space? If so, what about letting the driver expose some
> capability (or private flag) asking the core for such behavior? So that
> the driver will do the largish set() only with the H/W requiring that.
>=20
> Anyway I'm not sure the mentioned DSA H/W would benefit from always
> receiving the whole configuration. e.g. changing the weight for a
> single queue shaper would not need the whole data-set.

To be blunt - what I'm getting at is that the API mirrors Intel's FW
API with an extra kludge to support the DSA H/W - in the end matching
neither what the DSA wants nor what Intel can do.

> > > In any case I think that the larger complexity to implement a full
> > > transactional model. nft had proven that to be very hard and bug
> > > prone. I really would avoid that option, if possible. =20
> >=20
> > Maybe instead of discussing the user space API it'd be more beneficial
> > to figure out a solid way of translating the existing APIs into the new
> > model? =20
>=20
> Could you please rephrase? I think all the arguments discussed here are
> related to the model - at some point that impact the user space API,
> too.

I was hoping that implementing the code that mirrors the existing APIs
into tree operations would teach us something about the primitives=20
that operate on the tree. The proposed primitives are really low level,
which is why we need to "fuse" them into multi-change operations.

More specifically what I described a few emails up was a
group+schedule+limit paradigm. Instead of describing single moves=20
and parameter setting - transformation would describe inputs,
scheduling across them, and rate limit to apply. But one transformation
would always operate on at most one MUX node.

IOW I'm trying to explore whether we can find a language of
transformations which will be more complex than single micro-operations
on the tree, but sufficiently expressive to provide atomic
transformations without transactions of micro-ops.

