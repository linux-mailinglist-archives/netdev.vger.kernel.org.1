Return-Path: <netdev+bounces-71688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E2A854BE2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EE4282C3F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90BF5577F;
	Wed, 14 Feb 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wA0Vh5Ff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WLeXhyd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F45A7AB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922310; cv=none; b=LZGe2E/4fBGbx/gPUMdy/dmjNM9xJtE1TqMEJbgWR0qhpZBROdhIjs4z2TiK2a/PfQK8pU7oaDPQQfmuzoi9osuNhRx0suUCZtxbGtPehYgHHzjJoHGJ09nPdjffVzAyv+7+7A9ha+98Schik9GdKnfaGhYH5cCNNXXJ4+FB0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922310; c=relaxed/simple;
	bh=3r0HvQYUNOTeFtfxHuhIBG2HjWymXxAyExskW92ny/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZI8IRqpqoD+SoJk9GquP4ZkLJCIRMzONsD0rixHLwa9oceW/yKDTstXw2g54kBe63dyFPV5XHCYL/ar0folfkx61Opx04ja3kBL3Pv863ozWElonDVQ8m39HvmhViQhO35jH+gTuZXZh2FV7cVlF6P7wEUZhRu91mFpNhV3/VIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wA0Vh5Ff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WLeXhyd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707922307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3r0HvQYUNOTeFtfxHuhIBG2HjWymXxAyExskW92ny/c=;
	b=wA0Vh5Ff02B30sX554LPAw8UTM4ih6i8LFjWDQcOnQHR3XifUx20pvOozi57bpvgqXTfUX
	ERBIdpobuHh2RH8JHEVZyzPS8sGCTK+Dl/SbuOd+SPRdPf4nMpmcz65xXTUwI5aHnqPNaR
	f5YtQpxvg43iaOVBQUJRnBuxEqluRsKpxckfJnfC5L2BaWoa/USAtsy+Vz22I149JJ4mQ4
	/JyovtaCvho1CeNUX9u2K/789wAMlhPTdFNp1zyHHO558esF7K8dVnmYPwvfPDnYgPw/OK
	3mmFHIVme7tKnXb1hWwKpo4WHrY1mfZ59r631Wj9WIniLB6A6E56kvE8QUpqmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707922307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3r0HvQYUNOTeFtfxHuhIBG2HjWymXxAyExskW92ny/c=;
	b=3WLeXhyd1PFxz3c8p1CGIROt2ZF7HGGNb/5q3YkOQU4rIoon2UjRKWXKfSCH4Y1IABHp0s
	XgmGgSn1t3BjxMAA==
To: Ferenc Fejes <fejes@inf.elte.hu>, netdev <netdev@vger.kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, hawk <hawk@kernel.org>
Subject: Re: igc: AF_PACKET and SO_TXTIME question
In-Reply-To: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
References: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
Date: Wed, 14 Feb 2024 15:51:45 +0100
Message-ID: <87y1bn3xq6.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Ferenc,

On Wed Feb 14 2024, Ferenc Fejes wrote:
> Hi,
>
> We are experimenting with scheduled packet transfers using the
> AF_PACKET socket. There is the ETF disk, which is great for most cases.

For what use cases does it not work? Are you running PREEMPT_RT? Just
asking out of curiosity :-).

> When we bypassed ETF, everything seemed ok regarding the timing: our
> packet received about +/-15ns offset at the receiver (now its the same
> machine just to make sure with the timesync) compared to the timestamp
> set with SO_TXTIME CMSG.
>
> What we tried now is to bypass the ETF qdisc. We enabled the ETF qdisc
> with hardware offload and sent the exact same packets, but this time
> with PACKET_QDISC_BAYPASS enabled on the AF_PACKET socket. The codepath
> looks good, the qdisc part is not called, the packet_snd calls the
> dev_direct_xmit which calls the igc_xmit_frame. However, in this case
> the packet was sent more or less immediately.

Well, yeah the code path looks good indeed. packet_snd() copies the
transmit time which is provided by the CMSG and calls into
packet_xmit(), dev_direct_xmit()...

>
> I wonder why we do not see the delayed sending in this case? We tried
> with different offsets (e.g. 0.1, 0.01, 0.001 sec in the future) but we
> received the packet after 20-30usec every time. I cant see any code
> that touches the skb timestamp after the packet_snd, so I suspect that
> the igc_xmit_frame sees the same timestamp that it would see in the
> non-baypass case.

Maybe add some trace_printk()s to track what timestamps are actually
calculated in igc_tx_launchtime() and if it makes sense?

Second point to make sure is that the Tx queue your packet is being
transmitted to has Launch Time enabled.

>
> I happen to have the i225 user manual, but after some grep I cannot
> find any debug registers or counters to monitor the behavior of the
> scheduled transmission (scheduling errors or bad timestamps, etc.). Are
> there any?

Not that I'm aware of.

>
> I am afraid this issue might also be relevant for the AF_XDP case,
> which also hooks after the qdisc layer, so the launchtime (or whatever
> it is called) is handled directly by the igc driver.

Is that already possible with AF_XDP? There were some patches on
xdp-hints, but i don't think it has been merged yet.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXM04ETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgo+GD/9Ul5C1CH8F5GuUh3ybWHqUUwlwK9qP
a9zNZow6taxylDWawYcgZJytsTv5+uobZ8RH4l71I8ccP3GcPzWFqP+uXYtKjIqZ
riyPReFTU2qbZ/UE5o26k3TqtjdzGuIGzOj/WzkAr1F+El2eYgVjkG4pqvbYAzCs
a6a+8Qjr6n0z/g0X1wO3/bXXmWz0Qg/G62xqcFtqf9dY/tT1XsKPZw0QFA7Rrh/Q
F+koACUManvdYGV2f0RUVWa1d/wci6mSS4rQFYNZ05g7oawOgOZPPRJKSziwtGJ3
Q5+VcbVslJJ1UttW4UhU0ZSSPYcomAHadfyUi7a7ogWtjRLwxqLgkB1izlP4V2U6
ieu2JK4IkM8dx/jCFICGBCuAIVIUbodDiebVOqBV/sp1kLuQH9t4qk8g7COTp5EM
BcWvMp744jTVBAq+NXhIHk6/qByQA2JiQUNlbAyiE6ZgQZ/mOg/fHgpuhvtC1lIt
YQATHXocIeNYRdEUmHAYKlqvvo0/BGlGYhag6BprrSkcuodEpTU2LzBYuA+uYAwO
ur6p41dEcKkDkKHIobZfgzzB4PhQLsWv1e7WGl6AwWEaw3K+ZUMezHxfUlUxnkXd
CBJCo8ofrQNwQ4+ZO7vs67L7jipgtkuBq3fudkiF8RjlHHmPXaY8oxGMJA3ULV+S
aPkA9xqA69Gehw==
=WgxB
-----END PGP SIGNATURE-----
--=-=-=--

