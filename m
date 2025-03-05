Return-Path: <netdev+bounces-171949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB60A4F933
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E747A29CF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FE1F5850;
	Wed,  5 Mar 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Djcds1Z/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIRMcas2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465EC13792B;
	Wed,  5 Mar 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164774; cv=none; b=Nv6eV/TZUmWvBsO+Rz/HASTPojSIV39XhpaGwnabGdCF7V+N17BeYqonPZktPHUDbpacS1mZNSmtiOHJQhe/SQSzbHijxPHX9t/bDidk6bpPhrXU/77Qw2OmpqnqeW+eprpuxhlei3LQBGvXxmOc5Y5tEXlrr/NtdVenjT7taqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164774; c=relaxed/simple;
	bh=5TOP37lavmG5KtTmqIMlbBWITRSnLNC48N98N2hVtZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR/YRclN9RfgLNPEfbKz0/edoTU0iC6ck48+zzs1fCb66VGqaZ4r8hIAA2vhaXqIAJclIVBGxTMw/iwPTNVsOM+M9kFegZctvcmyKir/jn6j6M7vdx/BFgmf3o885NMQ8LjByforuPzfQ4RqtSbFja6/1rVdzxb7vWkdBNaJY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Djcds1Z/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIRMcas2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 09:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741164771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TOP37lavmG5KtTmqIMlbBWITRSnLNC48N98N2hVtZI=;
	b=Djcds1Z/Klu3wqcQVYcHgSTF9HU7ACRem9/71vN6eWFHCEd144h7L2tHP7z8c65uyzw2zn
	QWKemm5X1864FQEecTupd68T0o04yV3cdz/6lvr6Cc+5LeDjYzcVh1boLUX/sgRPZb+V3y
	eK1W9Ws6BEidpTw+QouudShO3/OkXwd7+6H/2sIJrNMECFkHyD3X+Wg1R6uADK1u3U1Bhu
	7jeF5ZdHJAiU+UZxKAN3zKQs6oJW+w3853DxJYLuTQwzOOAcXRdCQDJ4axz0KUNWOs/kP8
	1rBvQkKLO51aBaY7dqDXqxBWHz8n0n0r3vWJKlaCoWRS/nhYflWtNouDsrfMFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741164771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TOP37lavmG5KtTmqIMlbBWITRSnLNC48N98N2hVtZI=;
	b=JIRMcas2gC036+6JH++FJDO7AOr2SXg5BxMfPHFlAknqRSZRmj44A2JOfq/R6OE4ycXCpw
	NKSKn0r1GDtMuVBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from
 non-interrupt
Message-ID: <20250305085249.j11kJDkC@linutronix.de>
References: <20250223221708.27130-1-frederic@kernel.org>
 <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
 <Z78VaPGU3dzKdvl1@localhost.localdomain>
 <CANn89i+3+y1br8V4BP5Gq58_1Z-guYQotOKAr9N1k519PLE7rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89i+3+y1br8V4BP5Gq58_1Z-guYQotOKAr9N1k519PLE7rA@mail.gmail.com>

On 2025-02-26 14:34:39 [+0100], Eric Dumazet wrote:
> On Wed, Feb 26, 2025 at 2:21=E2=80=AFPM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> >
>=20
> > That looks good and looks like what I did initially:
> >
> > https://lore.kernel.org/lkml/20250212174329.53793-2-frederic@kernel.org/
> >
> > Do you prefer me doing it over DEBUG_NET_WARN_ON_ONCE() or with lockdep
> > like in the link?
>=20
> To be clear, I have not tried this thing yet.
>=20
> Perhaps let your patch as is (for stable backports), and put the debug
> stuff only after some tests, in net-next.
>=20
> It is very possible that napi_schedule() in the problematic cases were
> not on a fast path anyway.

I got here via Sascha's stable backports. It looks to me that these
paths (the reported once) are not widely tested and then we don't have
any prints if the BH section is missing while expected.

Would it work for everyone if warnings are added and this patch is
reverted? These days ksoftirqd is not blocking any softirqs until it run
so chances are that the NAPI softirq kicks in before ksoftirqd gets on
the CPU so the damage is probably little.

I am slightly undecided here since real work usually originates in
softirq and it is hard to get this wrong but then who knows=E2=80=A6

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Sebastian

