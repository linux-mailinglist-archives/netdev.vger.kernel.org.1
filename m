Return-Path: <netdev+bounces-295021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WB35OVjgIGoX8wAAu9opvQ
	(envelope-from <netdev+bounces-295021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751E63C729
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QOuFTE0C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295021-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB9C7300749F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B3305691;
	Thu,  4 Jun 2026 02:17:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EC2F7F04
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:17:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539476; cv=pass; b=Xt9JPaD2Yu5ofF4CYpbUPAKowiq1D7NJC5ZHELrPLoX4CDJMyKj8/L+3KKlDvEM18nmNowA3TvPqfHChGNjTclu3pUlEDbGVxzRKBuF0KQNx+sVMgvxkEFdgyhxKajGVLxuDsl7Wx5+z39B5qGTmZWUPCx+I3yaCE+1CufIoXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539476; c=relaxed/simple;
	bh=EwcX1tsFLxFLL5FwrFLfJffAgEqRvnJSRnequxoHdNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhauTIs+l13vqHlGNafpuRHFIxIR0YRnvff79OpLSS1RX4irovlYuUV4grRXckplrWNgF/lZ9DerWPNPcAOfJ65PYom3Q0PGm3jxywtGIo7mOICgmQ2H1o9AKgGuRdoLXXK2az4rikwjQHJfP1uh2BT7qDUaAqPWM0NE2RSyJ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOuFTE0C; arc=pass smtp.client-ip=209.85.210.53
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6128bd9b3so86589a34.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 19:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780539472; cv=none;
        d=google.com; s=arc-20240605;
        b=G7/0MZdjsrIQU2qGaXPgL29XJOV+jsQjklJaPcB+weDOYEwn9DiGOOz8iEdYXaBLy7
         iZRRIlbeG16KjnliASBNSCiEf0fJy2FS9rtSx6kSLNvILQI1Ap9LwHlWOZvT/kAsHJPx
         6nHRb4jjl7i55a93Tg/Jv7UgaNWy0LlH/kb2M+f3AW9A7MHOd4gEIkVE0TPeMqvwah8s
         SbqGajiLSLTtM0zmiC/1Qg5Hbc9oJYmaT86lUeCnDuGmoaHpR6MwmelZgEkBH4GeZ4fR
         LtGd8vBGF2GdvZVkMoo+t/aT9aIV3djE57ct7pHpt/nQIK882S4bcto1C2dmVrbzjsmw
         sqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QErorqY9RMKPgA72Ld2f8HeSHtavYVIkAzt6SVGTWa0=;
        fh=yo/o8z4J3DxVeiSosoLN/ImBAQ3aHimlb4g0RXWwsI8=;
        b=SxBVqq9zw2Ay+U1RAMpXbL1LgdW6pi34av6MjYNCoEYJik7/AEmDi3yenRY/Qws5zP
         Cpr6qC40gdlHCMMG6mTVtiWaCammxy1AcCY8WprCyIxyXxUwzZpPCZERsvbl0eUOjUmg
         SxZorKcCgdQpDGWycEmV6i7hhidulyayAd/bmVrmhUvT4QBjW2FUV1VKGkgj+GBVe7YC
         CnZoGS9EQVeZRLMMRTBh1JDeAAbYztKHZgSTYoxLoKPJHFiJExwcrRBgV7TuU5+MUhSY
         4oihg3JEyOdfxXAHzrtToqKEHe7TT0a/beipbqrRD/LlgWxSdhfvRpu0DORfCr619Vt+
         NQRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780539472; x=1781144272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QErorqY9RMKPgA72Ld2f8HeSHtavYVIkAzt6SVGTWa0=;
        b=QOuFTE0CwWWZUIuhPAU3ZFlqQPTLxVeFeQRncC8Y19gnsIAQgWQdOyk/kLTZ+E4LmP
         VB3+A/JtsRMTpXr1xhMHL3j3i4IOatuuMxD5uNc/I37cbRM9SL6lgPx7I8oLneg+LMu4
         +gT3St1qCmdji6dwPhJzkBvpHPDC9w8rig+9Oorr3DuPYIrsabzOrwvWtcJV87BITCHb
         1Hd4lgL5UGL6Nna9uTIo3fh2TNOcgeiZ1xo+mJgaNM4a+AzlJpJT8XehNwP/fKt136eo
         qfvUGosf6neMwowt2MaWOUEERRA/Tb1/2F2d1LZm2zXa+SY94OEphmMkKtAa3vgpvuq4
         rNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780539472; x=1781144272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QErorqY9RMKPgA72Ld2f8HeSHtavYVIkAzt6SVGTWa0=;
        b=fYRVd7Yb0UAk2rv5BEHirbCwHESlGQpNGqYTac7ruZ4Q9CA9QzRg8JJMFy+EQ4GOKV
         jRvKRALMoLDMuhEIOuEqi59B+WLC4LRsUEcp0/Mftvbx8DhIfw3S2pyM0ALItA+jsWVs
         7aMC6RsdSsi0UtOhZ3ZpHAfx+VrJ/9Y8UCOtSN9Dy4ypSp1KEuXsBih/mw30U4/UAvc3
         wrizqLnV5DkDsLDZuN2ZMSBkCgRpaJ+5WFsUkqtj8sOZuEB7+Aq5ii/vYtZbN+sLqc+B
         Q9KHB+NNFltZH4PyZnlWdu+BKfpLospnIRmQYRRXaockqwT//oBTt1S8v+iGJqy8Nv6O
         mi2A==
X-Gm-Message-State: AOJu0Yyc9QxrF4G9rlZC0GzCcyCT6CZm/DomByg52fWNA3S3NZ17uoDR
	1BjKAXYTqGMdb5aQEx2gBnqJsMn23eN9HHm8IuEyYo/ImnU6gBJaCoMylJbP3Nhw9VaLchVLypc
	x9S01bfrlGfqu0C1YF9pCDL5r35e3Odc=
X-Gm-Gg: Acq92OEqRSX5TIZLSABHJG/ZaLX0uz1+QcPRYee3m08W2varBwiFJEnxXwRLiPBS/R7
	K5XvYGYARvsp2cDnHfWZ3GsaHaugBq9ZResHT6MCkrbbLDltltNada4FJLN71nZdK+o1VyKFYyS
	55rBR62apzSBFAj8xNTb/l9lGhqLiaklkkbaxPtp8LYSDQq+BIDTOV6D2l0f6pehR3KB+QIxrZC
	29WTcM0K6iWZOhifUsAJuye5UjR6JDyBXXLUxqnFfivJm8CijOVnBRCytCJs20JQOoXh4bF1EGK
	RtQV86fr43rghymddW/vXym05SGG/RyRyemJr4Ob3zRNHaM0vdSNlBmcEXuTJGVBhYnJLoi1B9V
	7sVDFVv0tevdg4a6m0rCJRxd6lHU6dg0=
X-Received: by 2002:a05:6830:3919:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e6e94ef38emr3659117a34.7.1780539471819; Wed, 03 Jun 2026
 19:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528092838.2099352-1-hanguidong02@gmail.com>
 <20260603112035.0866d7d4@kernel.org> <74e6932f-a755-4931-8d4d-0025826a5502@gmail.com>
 <20260603165238.43259251@kernel.org>
In-Reply-To: <20260603165238.43259251@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 4 Jun 2026 10:17:42 +0800
X-Gm-Features: AVHnY4LGebkZzXltOaznFBXkEV1y-2gdxNlRrehEewr3Ev4nuMZ8kJ7WOrq0x5Y
Message-ID: <CALbr=La4JEwfqVg_ouFExpDBQGk-B+63CMaNUp4CiimkKLfqYQ@mail.gmail.com>
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
To: Jakub Kicinski <kuba@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295021-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:ecree.xilinx@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8751E63C729

On Thu, Jun 4, 2026 at 7:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 3 Jun 2026 21:28:02 +0100 Edward Cree wrote:
> > On 03/06/2026 19:20, Jakub Kicinski wrote:
> > > On Thu, 28 May 2026 17:28:38 +0800 Gui-Dong Han wrote:
> > >> Use release stores when updating the gate and acquire loads in inter=
rupt
> > >> handlers before touching channels. Keep the existing smp_wmb() after=
 gate
> > >> updates, preserving the current ordering with event queue start and =
stop.
> > >
> > > Why are you keeping the smp_wmb() tho? You don't have to repeat what
> > > the patch does. The goal of the commit message is to explain the why.
> > >
> > > Ed, WDYT?
> >
> > I think... that my head hurts from trying to understand this.
> > What I particularly don't understand is why it wouldn't suffice to just
> >  put smp_rmb() after every read of irq_soft_enabled, pairing with the
> >  existing smp_wmb().
>
> Exactly..
>
> > And, conversely, why any of this works at all =E2=80=94 what stops an i=
nterrupt
> >  handler passing the gate, because the write to irq_soft_enabled has
> >  propagated to its CPU, but the writes to channel pointers haven't?
> >  Na=C3=AFvely I'd expect the smp_wmb() in efx_soft_enable_interrupts() =
to
> >  come _before_ the write to irq_soft_enabled.
> > (The smp_wmb() in efx_soft_disable_interrupts(), I'm not sure exactly
> >  what that pairs with, since the ordering that matters there is between
> >  the irq_soft_enabled=3Dfalse write and the synchronize_irq().)

The issue I was trying to fix is the transition to true.  The interrupt
handler uses irq_soft_enabled as a gate before it touches channel state,
for example efx->channel[context->index].  So when the handler observes
irq_soft_enabled =3D=3D true, it must also observe the channel state that w=
as
set up before the gate was opened.

The existing barriers do not provide that ordering.  There is no read
barrier after the READ_ONCE() in the interrupt handlers.  Also, the
existing smp_wmb() in efx_soft_enable_interrupts() is after the
irq_soft_enabled=3Dtrue store, so it cannot publish earlier channel state
before that store becomes visible.

A writer-side smp_wmb() before irq_soft_enabled=3Dtrue plus a reader-side
smp_rmb() after reading true would provide the needed ordering.  I used
smp_store_release() and smp_load_acquire() instead because they express
that flag-based synchronization directly and are usually cheaper.

I kept the existing smp_wmb() because it seems to provide a different
ordering, between opening/closing the software IRQ gate and the later
event queue start/stop operations.  That barrier is not documented, so I
did not want to remove it in the same patch.

> >
> > Anyway, this code predates my involvement with sfc and I've never had
> >  to touch it, so frankly I don't know any more here than anyone else,
> >  and if a memory-models expert reviews it and says 'this is needed and
> >  correct', that would mean more than a review tag from me.
> > That's not a cop-out "I won't review this", rather I'm saying that if
> >  Gui-Dong can't convince me because I'm too dumb, but can convince you,
> >  then you don't need to wait for me to show up and add my tag.
>
> I haven't dug into the code too much but FWIW having a store_release
> barrier which flips something _both_ to true and false strikes me as
> highly suspicious. So the patch needs a much better commit description
> at the very least.

Agreed, the false transition does not need release ordering.  Handlers
that observe false do not touch channel state.  I changed that side in v1
only for helper consistency.

If this direction sounds OK, I can send a v2 that keeps WRITE_ONCE() for
the false transition, uses release only for the true transition, and
improves the commit message.

Thanks Jakub, Edward, and Simon for the careful review.  If there is anythi=
ng
else you would like changed in v2, such as splitting the patch, please
let me know.

Thanks.

