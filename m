Return-Path: <netdev+bounces-132782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8699328A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA561C2285B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206A1DA11B;
	Mon,  7 Oct 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz1oDRrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C81D61B9;
	Mon,  7 Oct 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317310; cv=none; b=ieECuvN/g0SUoAaxBPU0yUBC+SjOzd6hA71o1Hp8kwB1wpfZu/Y2Pzm+x1G4JrH70rxWqPWUAEnm/ithxG1PaqsCs6DwrO2MaMn4eit00NntzS9XXLRPGQjZB978iibGtibV/V51cDYeZoglMvvY/v0IQHnVfh9bUOQzDbYFq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317310; c=relaxed/simple;
	bh=xDgyIVS9Fuab/jyvCIFWrh1DGqRg2hdQk1qB2WubCBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ick5gBCXzL7yy3NWZmByOTy85LHeJg7fW12xY4jtT8wyhxlqfN/gvSPVJ6ykWHT81v+IPvgOM8Dq42MRtmRM7aOO/aiNZcLJlp4XW9F+cexCrVCWrQWkMGf+ZBxBJnQEeaOPBHP5rpId/lrHnmemstDkZMupOtAEyEmQyLrMxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz1oDRrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9DEC4CEC6;
	Mon,  7 Oct 2024 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728317309;
	bh=xDgyIVS9Fuab/jyvCIFWrh1DGqRg2hdQk1qB2WubCBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pz1oDRrMI7GnxwC3Xf0rq0RQwfIdMwTrnzOWDD7ZwJXp52JDq/O/GChPNvYegjDmB
	 nWDuHFcZfVQho18iTaAqdr4bzARPOyO5gecxQSTSYZWN6nGCM+2pyG0cJek54elfwM
	 ItqyKKeN5gLPqtyB4JNFXzD5RqyePps5rtuOTUF2v4PNLOz0SeNQdXnWyUNYcxShye
	 RJeJ1FThloAPGxmr/87dyaYH8Xzy9O0oeksJHuTdKpIpRX49rsBwvysChMhkBvm15/
	 nguEMyEUBWHEOgL8RXdhPCPKve7NB6/D1zchd5vf1RBsrq81O6nWajx1owxE5PtLrv
	 6VQu/VI/q+6bA==
Date: Mon, 7 Oct 2024 09:08:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241007090828.05c3f0da@kernel.org>
In-Reply-To: <20241007155521.GI32733@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
	<20241007082430.21de3848@kernel.org>
	<20241007155521.GI32733@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 16:55:21 +0100 Simon Horman wrote:
> > > +Netdev discourages patches which perform simple clean-ups, which are=
 not in
> > > +the context of other work. For example addressing ``checkpatch.pl``
> > > +warnings, or :ref:`local variable ordering<rcs>` issues. This is bec=
ause it
> > > +is felt that the churn that such changes produce comes at a greater =
cost
> > > +than the value of such clean-ups. =20
> >=20
> > Should we add "conversions to managed APIs"? It's not a recent thing,
> > people do like to post patches doing bulk conversions which bring very
> > little benefit. =20
>=20
> Well yes, I agree that is well established, and a common target of patche=
s.
> But isn't that covered by the previous section?
>=20
>    "Using device-managed and cleanup.h constructs
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>    "Netdev remains skeptical about promises of all =E2=80=9Cauto-cleanup=
=E2=80=9D APIs,
>     including even devm_ helpers, historically. They are not the preferred
>     style of implementation, merely an acceptable one.
>=20
>     ...
>=20
>    https://docs.kernel.org/process/maintainer-netdev.html#using-device-ma=
naged-and-cleanup-h-constructs
>=20
> We could merge or otherwise rearrange that section with the one proposed =
by
> this patch. But I didn't feel it was necessary last week.

Somewhat, we don't push back on correct use of device-managed APIs.
But converting ancient drivers to be device-managed just to save=20
2 or 3 LoC is pointless churn. Which in my mind falls squarely
under the new section, the new section is intended for people sending
trivial patches.

> > On the opposite side we could mention that spelling fixes are okay.
> > Not sure if that would muddy the waters too much.. =20
>=20
> I think we can and should. Perhaps another section simply stating
> that spelling (and grammar?) fixes are welcome.

Hm, dunno, for quotability I'd have a weak preference for a single
section describing what is and isn't acceptable as a standalone cleanup.

