Return-Path: <netdev+bounces-110072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170492AE57
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD87C1F22009
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BC3612D;
	Tue,  9 Jul 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0HBKLJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611D433BD
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493643; cv=none; b=RVGL26HmIEKLzivuGxw9YwKPHyj2NTgIPkOQ9HVZBusAX8E4/hRybogec+ppFqMEOkbTFwoam28cGL1gP4lA4TMCl6dxGfarhoWwGf9smkSb0EduRuDEP8S3TxJvuDu+SUPmuGpJWg9DuATwxAUz1hfMx9zUd41juhIlJE0C7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493643; c=relaxed/simple;
	bh=U8KbggbN02hqceirmTibPpXOr56EKbg345vLx1qFGh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/gE+c2yjB3ILKlq2NcdXbdn7fNdaYoAlpe6RazcOed61ZgtwOS5IBGjx+UdzOQjOO9ev4nkkZnxLnpIveAZf/BPe8/Myyl07KMzHC/DZucELR/zTE8sEMaIfIpceA2U/nYR3gROwHbBLIM5W4urb7a0iEkGtkFRTi3z48P8Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0HBKLJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F1C116B1;
	Tue,  9 Jul 2024 02:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720493642;
	bh=U8KbggbN02hqceirmTibPpXOr56EKbg345vLx1qFGh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0HBKLJCc+PIWzf5sIPpgUBussg1wAYumxx86/FK9hB4qGSnIgIrbt19ca8ZqfgHV
	 I+KupeZ0e7rIOKGaVN/FsLekqEDoeeb8yXSQbuAGVOS81s7IN/wUBXNLkrSy7EjaP8
	 v6fD/OGI4JqvvUS4HRLg51HMgVVvjSl3fCrtsWpHlWNcuLWXxa3Ap177Zoc4vJ/v6i
	 x30GRhSHzRNrhFBN7UInIGyhSicGa+CyFSanno4j0Vc1zPaojcRVTgall+KK2ig8PD
	 xP0/GA3NYMXDQQ4XY44BX+n6CqMyzZW1NWZTtlZePVzpuEms/dGtveJxWOJdORBPRw
	 03ScrA/w9z4Dg==
Date: Mon, 8 Jul 2024 19:54:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240708195401.5ef3f016@kernel.org>
In-Reply-To: <390717c3688956d6da04b7de00da3dc57ff9c7a9.camel@redhat.com>
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
	<20240703142017.346ed0c1@kernel.org>
	<390717c3688956d6da04b7de00da3dc57ff9c7a9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Jul 2024 21:42:00 +0200 Paolo Abeni wrote:
> > To judge whether it's an over-design we'd need to know what the user
> > scenarios are, those are not included in the series AFAICS. =20
>=20
> My bad, in the cover I referred to the prior discussions without
> explicitly quoting the contents.
>=20
> The initial goal here was to allow the user-space to configure per-
> queue, H/W offloaded, TX shaping.

Per-queue Tx shaping is already supported.

I mean "user scenarios" in the agile programming sense as in something
that gets closer to production use cases. "Set rate limit on a queue"
is a suggested solution not a statement of a problem.

> That later evolved in introducing an in-kernel H/W offload TX shaping
> API capable of replacing the many existing similar in-kernel APIs and
> supporting the foreseeable H/W capabilities.
>=20
> > To be blunt - what I'm getting at is that the API mirrors Intel's FW
> > API with an extra kludge to support the DSA H/W - in the end matching
> > neither what the DSA wants nor what Intel can do. =20
>=20
> The API is similar to Intel=E2=80=99s FW API because to my understanding =
the
> underlying design - an arbitrary tree - is the most complete
> representation possible for shaping H/W. AFAICT is also similar to what
> other NIC vendors=E2=80=99 offer.
>=20
> I don=E2=80=99t see why the APIs don=E2=80=99t match what Intel can do, c=
ould you
> please elaborate on that?

That's not the main point I was making, I was complaining about how=20
the "extension" to support DSA HW was bolted onto this API.

Undeniably the implementation must be stored as a tree (with some
max depth). That doesn't imply that, for example, arbitrary re-parenting
of non-leaf nodes is an operation that makes sense for all devices.
=46rom memory devlink rate doesn't allow mixing some node types after one
parent, too.

> > IOW I'm trying to explore whether we can find a language of
> > transformations which will be more complex than single micro-operations
> > on the tree, but sufficiently expressive to provide atomic
> > transformations without transactions of micro-ops. =20
>=20
> I personally find it straight-forward describing the scenario you
> proposed in terms of the simple operations as allowed by this series. I
> also think it=E2=80=99s easier to build arbitrarily complex scenarios in =
terms
> of simple operations instead of trying to put enough complexity in the
> language to describe everything. It will easily lose flexibility or
> increase complexity for unclear gain. Why do you think that would be a
> better approach?

I strongly dislike the operation grouping/batching as it stands in v1.
Do you think that part of the design is clean?

I also disagree with the assertion that having a language of
transformations more advanced that "add/move/delete" increases
complexity. Language gives you properties you can reason about.
That's why rbtree, B-tree and other algos define a language of
transformations. Naive ops make arbitrary trees easy but I put
it to you that allowing arbitrary trees without any enforced=20
invariants will breed far more complexity and bugs than a properly
designed language :)


The primary operation of interest is, in fact: given a set of resources
(queues or netdevs) which currently feed one mux node - build=20
a sub-hierarchy.

Use case 1 - container b/w sharing. Container manager will want to
group a set of queues, and feed a higher layer RR node (so that number
of queues doesn't impact load sharing).

Say we have two containers (c1, c2 represent queues assigned to them);
before container 3 starts:

c1 - \
c1 -  >RR
c1 - /    > RR(root)
c2 - \ RR
c2 - /

allocate 2 queues:

c1 - \
c1 - ->RR
c1 - /    > RR(root)
c2 - \ RR
c2 - /     '
       qX /
       qY /

hierarchize ("group([qX, qY], type=3D"rr")):

c1 - \
c1 -  >RR
c1 - /    \=20
c2 - \ RR -> RR(root)
c2 - /    /
c3 - \ RR=20
c3 - /

The container manager just wants so say "take the new queues (X, Y),
put them under an RR node". If the language is build around creating
mux nodes - that's a single call.

Note that the RR(root) node is implicit (in your API it's not visible
but it is implied).

Users case 2 - delegation - the neat thing about using such construct is
that as you can see we never referred to output, i.e. RR(root).
The output can be implied by whatever node the queues already output to.
So say container 1 (c1) wants to set a b/w limit on two of it's queues
(let's call its queues A B C):

 rr_id =3D group([B C], type=3D"rr")
 rate_limit(rr_id, 1Gbps)

and end up with:

cA ----- \
cB - \RR*/ RR
cC - /        \=20
    c2 - \ RR -> RR(root)
    c2 - /    /
    c3 - \ RR=20
    c3 - /

* new node, also has rate limit set

You don't have to worry about parentage permissions. Container can only
add nodes (which is always safe) or delete nodes (and we can trivially
enforce it only deletes node it has created itself).

> Also the simple building blocks approach is IMHO closer to the original
> use-case.
>=20
> Are there any other reasons for atomic operations, beyond addressing
> low-end H/W?

I think atomic changes are convenient to match what the user wants to
do. And the second use case is that I do believe there's a real need
to allow uncoordinated agents to modify sections on the hierarchy.

Neither of those are hard requirements, but I think any application
driven requirement should come before "that's the FW API for vendor X"
I hope this we can agree on.


Thinking about it (for longer than I care to admit), one concern I have
about the "mux creation" API I described above is that it forces
existence of leaf and non-leaf nodes at the same parent, at least
transiently.

Can we go back to an API with an explicit create/modify/delete?
All we need for Andrew's use case, I believe, is to be able to
"somewhat atomically" move leaf nodes.

