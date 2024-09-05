Return-Path: <netdev+bounces-125541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D68496DA0A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F25B2503B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C519D075;
	Thu,  5 Sep 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1TQi6Oz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJNPHzyW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201019D079
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542316; cv=none; b=WrCWE1ot8/5Ujsy5bo7bARCdJGnxiQw6RUgE/L+kVWF10IbhcOCT+UiUQOuKSjIf0P2369RtBoQHLLCPSdY6f7vbWKRdMdUzk/Nug1C27arIi9XZTLeVSv8ikhb7BiJapgKVR/QMc0rpQEbrWfKxGmZkjYMCoc89TrRB73g1i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542316; c=relaxed/simple;
	bh=gxLWjtP/32VsVpbZBQvw/FtpxRo8e7hp0ECw8wZ+7OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev1tWiyEbUIInsXA2fmO3CSdfth7Z67n9CQhSkF6i+cMLgMluSio/4w7ZMz2GtRWye0t0AWVMzczopJ09/WfLvnCFgigzk8QSPuD+D7UthAK0ySY4z9NfcFdXCROIMn5IlIOKZtTmOFNaPi7xJ2LdppZlUGbApoIH9Z3whiSI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1TQi6Oz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJNPHzyW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 15:18:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725542312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VhSqnaTMeL/zFiqAFTBoOJTaQ0+JWaanysx1nYHGoQ=;
	b=m1TQi6OzbLqjDgS5ECHfDHb6zEufsn0l36UwCUhIO4xRmB2UZnJQAyS/fZEOD/dt/OOmiH
	pVRSVBJHdVmIoLYwfpqbz3+CM+SoN3AmKTRoVom8patLPGmNZ08eqKeHMdFsX6iNNfnvI7
	zL1wSikbBP7R/KCyvJS0yddDfFLaeRhuWhnLMxZtI6Lg4/MdWYswzIebndbseV61cqMBnt
	ct1pjM1LeFWICpm419FWkBI/rlen+y6cL+qZrYC0HCrxAOOeo/EMQ2p+HdIh9W3uQeLPy7
	NEOKmRSUQ8xoWjmHHV1uUk8pgWYDw1WY+afab+nn+4QK/yDygXCC5TulsWGQKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725542312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VhSqnaTMeL/zFiqAFTBoOJTaQ0+JWaanysx1nYHGoQ=;
	b=PJNPHzyWCS+has7SALlWuDcvqzquuXRVIVM23s2Psuedmt+2ExjaHoVqNWa0ywbuhC/p/L
	YUcbmp9/jNTW7FAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
Message-ID: <20240905131831.LI9rTYTd@linutronix.de>
References: <20240904133725.1073963-1-edumazet@google.com>
 <20240905121701.mSxilT-9@linutronix.de>
 <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com>

On 2024-09-05 14:26:30 [+0200], Eric Dumazet wrote:
> On Thu, Sep 5, 2024 at 2:17=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-09-04 13:37:25 [+0000], Eric Dumazet wrote:
> > > syzbot found a new splat [1].
> > >
> > > Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> > > spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> > > and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> > >
> > > This also avoid a race in hsr_fill_info().
> >
> > You obtain to sequence nr without locking so two CPUs could submit skbs
> > at the same time. Wouldn't this allow the race I described in commit
> >    06afd2c31d338 ("hsr: Synchronize sending frames to have always incre=
mented outgoing seq nr.")
> >
> > to happen again? Then one skb would be dropped while sending because it
> > has lower sequence nr but in fact it was not yet sent.
> >
>=20
> A network protocol unable to cope with reorders can not live really.
>=20
> If this is an issue, this should be fixed at the receiving side.

The standard/ network protocol just says there has to be seq nr to avoid
processing a packet multiple times. The Linux implementation increments
the counter and assumes everything lower than the current counter has
already been seen. Therefore the sequence lock is held during the entire
sending process.
This is not a protocol but implementation issue ;)
I am aware of a FPGA implementation of HSR which tracks the last 20
sequence numbers instead. This would help because it would allow
reorders to happen.

Looking at it, the code chain never held the lock while I was playing
with it and I did not see this. So this might be just a consequence of
using gro here. I don't remember disabling it so it must have been of by
default or syzbot found a way to enable it (or has better hardware).

Would it make sense to disable this for HSR interfaces?

Sebastian

