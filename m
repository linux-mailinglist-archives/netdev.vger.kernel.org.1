Return-Path: <netdev+bounces-156833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F785A07F29
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA52F3A88BC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061F19CC1F;
	Thu,  9 Jan 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTdOlWbQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yT3+jiuC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304319ABDE;
	Thu,  9 Jan 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444718; cv=none; b=geEf5R/Lo6No3u7ChRMfpNHqfTz3uokI7MQboLVMG+X9cELi9YoE7/MZ79V1pwAzEb+AKz6ssgI1uJvi0zJr+kLF596mFpmppoKtlZSW9qaUVQxv7FA4CuVSToo5SUYMPsEYAhks/xcLHPOI7URTYtbTeJXy8MZ6/GZpwhV5y7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444718; c=relaxed/simple;
	bh=jXkfKArSexveblQ+dUbSkquyaGiDzK+NLpXwUxILcFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhoRk4jKiCWGgyvQBiPkupeq6AxK3Q9kdPA0aU0Rq+maU0SKRupnqvOjUrVn0Nrfim0hJdCK91afqdnN1uvm03KeJnT9BEhCmf4M3rnC1+JZuAPeR/y2D7UfPShh1hLQnuga/olKTZv9c1kQUK5aF08VPuRNX2JecT4OkNBbTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTdOlWbQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yT3+jiuC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Jan 2025 18:45:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736444714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITDbkQWE/hIVhZw2Nq8W6mx+3e492XIMVSSt0BOfbNU=;
	b=wTdOlWbQ91hilUGbM16VU/8j5nkkTWdg5HJnuFCuQd/GAZAaWr+puLg3RtzuPF9cZXz+YX
	WkcVIjtFD+P4FdlEYxMNVG6JQ3Tc/wA3nrh/vIUDJ6OklF2IMhByt4DRQibSdUk6ByTpDq
	z2hchp5Z3Vmsqf1hWtdcHsdwjL2VuYCViTG9bnReSk4/27uV0sWHrbIPMalIESqSmtyaQl
	apXWsvjNjQpe28NHY1NLXpbmzSESTdHVy1Bqwrj24zApmWSu54gICF47aXNErnKTlBoH2u
	jgrtrBWmuKwchINQNd0UOt2ozMkbJySorYKiV0dsniatCnvepE7coKSI3kjhaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736444714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITDbkQWE/hIVhZw2Nq8W6mx+3e492XIMVSSt0BOfbNU=;
	b=yT3+jiuCw+WM1LYsNIad/JIuKA14d7jM3TedjhRkLbOSCxz3HARUlqSyEd5ZS4roS/3Eca
	N2TekSHFJbNwaeCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for
 PREEMPT_RT
Message-ID: <20250109174512.At7ZERjU@linutronix.de>
References: <20241204114229.21452-1-wander@redhat.com>
 <20250107135106.WWrtBMXY@linutronix.de>
 <taea3z7nof4szjir2azxsjtbouymqxyy4draa3hz35zbacqeeq@t3uidpha64k7>
 <20250108102532.VWnKWvoo@linutronix.de>
 <CAAq0SUnoS45Fctkzj4t4OxT=9qm9Bg8zu79=S3DUL_jcoLbC-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAq0SUnoS45Fctkzj4t4OxT=9qm9Bg8zu79=S3DUL_jcoLbC-A@mail.gmail.com>

On 2025-01-09 13:46:47 [-0300], Wander Lairson Costa wrote:
> > If the issue is indeed the use of threaded interrupts then the fix
> > should not be limited to be PREEMPT_RT only.
> >
> Although I was not aware of this scenario, the patch should work for it a=
s well,
> as I am forcing it to run in interrupt context. I will test it to confirm.

If I remember correctly there were "ifdef preempt_rt" things in it.

> > > > - What causes the failure? I see you reworked into two parts to beh=
ave
> > > >   similar to what happens without threaded interrupts. There is sti=
ll no
> > > >   explanation for it. Is there a timing limit or was there another
> > > >   register operation which removed the mailbox message?
> > > >
> > >
> > > I explained the root cause of the issue in the last commit. Maybe I s=
hould
> > > have added the explanation to the cover letter as well.  Anyway, here=
 is a
> > > partial verbatim copy of it:
> > >
> > > "During testing of SR-IOV, Red Hat QE encountered an issue where the
> > > ip link up command intermittently fails for the igbvf interfaces when
> > > using the PREEMPT_RT variant. Investigation revealed that
> > > e1000_write_posted_mbx returns an error due to the lack of an ACK
> > > from e1000_poll_for_ack.
> >
> > That ACK would have come if it would poll longer?
> >
> No, the service wouldn't be serviced while polling.

Hmm.=20

> > > The underlying issue arises from the fact that IRQs are threaded by
> > > default under PREEMPT_RT. While the exact hardware details are not
> > > available, it appears that the IRQ handled by igb_msix_other must
> > > be processed before e1000_poll_for_ack times out. However,
> > > e1000_write_posted_mbx is called with preemption disabled, leading
> > > to a scenario where the IRQ is serviced only after the failure of
> > > e1000_write_posted_mbx."
> >
> > Where is this disabled preemption coming from? This should be one of the
> > ops.write_posted() calls, right? I've been looking around and don't see
> > anything obvious.
>=20
> I don't remember if I found the answer by looking at the code or by
> looking at the ftrace flags.
> I am currently on sick leave with covid. I can check it when I come back.

Don't worry, get better first. I'm kind of off myself. I'm not sure if I
have the hardware needed to setup so I can look at it=E2=80=A6

Sebastian

