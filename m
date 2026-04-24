Return-Path: <netdev+bounces-281069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0d61Kmv362n2TQAAu9opvQ
	(envelope-from <netdev+bounces-281069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:06:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31212463F5F
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64DFD30067A9
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC4330D24;
	Fri, 24 Apr 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="lHxx8OID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907AD531
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777071975; cv=none; b=oSDncH6YcVLqQLhzJYzCEkuQM//igmuXU4lfZqup7qWKvM3lw3/8ZJbasJ/y2468Z4weztO3fxUeSQQZi/bf9o0wxcq7XWckO/WIeXmPbabNGjgas+S1VslHXatas16luZOY0zxIOBaLmgROwLCUNCygiQRaf2xEUx5JduyCUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777071975; c=relaxed/simple;
	bh=xmNYLGpNOpWPTvW0iyF7wwkU1PTu/CKwR6kdBPQytfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWB6uB4qC6QBRL4qEBloyAK5XQQ2bek06GYpwJGAeTHsRC3Kyac225SgIXMSslWHUtvpecHXsVoyM7ztw8C0KAheB9NvRxwB7Gtsm/hODeRqOBEIBxgkmv5IrahJLVpCpDEcK4cpMVZcGYK5Fc7Em2r0PcxHFOC7NZazRsWTXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=lHxx8OID; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-466ec4c6846so2896267b6e.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777071973; x=1777676773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0P4/bNY3ogAryjqIy22wFzuj5GPxjxBtHlZnmt3BwQ=;
        b=lHxx8OIDcxZiAD88RcctBMxvNB2akOEVvxp8Nhe82au7ae44KjdgBjLMjGuew7CxAq
         ZFKohotSyw3Zqna+BC+y4jsR/tN6TU7DyCpqGrNuFA4tBa7oLZ9e6Ushw1oVMvdLM8wj
         dHdbRo3leXpI2hhCyHlVStaEyIw2allDnUM3nVQTk2a0Y7rI+4yWehj1oyl6E+6n3zUC
         3CnyNEcXJCmiOLMXbe54rV2OzeDNTGy1voiUlTgd0xVy1nMuOth2gFMaFcW4v1ycbQxn
         1Ypw14YetfMiCrAuk0GTgvTUUxeJIR2EfJwt1v9w889GXe6mOPDoP2pwsVdKhoSTFgz9
         OwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777071973; x=1777676773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0P4/bNY3ogAryjqIy22wFzuj5GPxjxBtHlZnmt3BwQ=;
        b=iao79ydh+5OuO2Of6GbF/qcy7Pe5Zh+8B2lNEB/cHAo2V6ldbdDEaMKwMRpL8AAmDc
         qI5r8UkdMLqcADhWDMr5i6+1feqIwQdqAr/NQlicKl9UfGqKf9XcyYeeiuYfCZb3fNs8
         eqTbFrspEsan7MLZC2E7vQWCzPAjr2xMZGPfP8eXt1sn+BBRKhQtepEL8w+FBGanCttd
         n+fdX4AsJh6gb+Rq4HQyNib8+tdL5knV+i8n6Ny/uNnjyWKgR+u7LL9ArwZkD3rA0usU
         mJiF1yv30el5H1NXidYnez+323mmr6is0QKtqbE2xisWCaUXlRgdeNDijHJVzbU34Kik
         ts4w==
X-Forwarded-Encrypted: i=1; AFNElJ8DXY8q0eJXLdwuDddK1Ww2+uWQM6d092jcBfeudKCY8aMXDXyB2W09ped3IydHkGNt01ILzKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxDEdTsmRRY81pUq1t8nt+z69VouY85A1Civ3GOLvZtZbe6a3
	8pucU32CVbswLvnD/XVApuIPVXoqWc3SCAJXKMkB0+6iZvPqrR0G+VSfoD8sWcNXOko=
X-Gm-Gg: AeBDievGsrIYyEV8FPT0XzB4OZJBgSPd9NVW8Vs2vnmdf0wHJcNwr9EP4stDW1TvwV+
	ZZLLEKYsoYnTM3psxN6fjhJ28M2faFDUq8r0qApRLVXuo/MVkkNwZOB4yHdrsGUfOgnH2ij0Odv
	Dq7dhyJJYzz7zVLPsvpATfXwC0XAVnAA1asBNLgIEbwpZOrAsbO269kaPyNykN9UZrarnRHLxg1
	3tTIIlsuKFBxJSCVTW1jMKQ1j0Q5UeYcH9rnOa9UJeiDiBPXMKXC/DAxPtkuukbGCcZZMLKXMaz
	mbkecAe1fRK+h6QkbHKw0TLarvl3wBh4mxzee7x9Hvto9ooPWz3YIRXIQop4BCjN0rXU1oL39+a
	Im/gtRWzqGlc59uGipvApWkw/lsGwiONaCoRrHSa3PXYmqiGbvKimOZYbdieC3TQ6NvafXiBoEI
	BVksTiBgq8mwDkdqOGhmUEXc+2kPm4od5o+wYcojNfzMCq4A==
X-Received: by 2002:a05:6808:e3cd:b0:47a:c2f:db2b with SMTP id 5614622812f47-47a0c301739mr5202111b6e.38.1777071973269;
        Fri, 24 Apr 2026 16:06:13 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f6705d7asm7990554b6e.10.2026.04.24.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 16:06:13 -0700 (PDT)
Date: Fri, 24 Apr 2026 16:06:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Dave Taht
 <dave.taht@gmail.com>, open list <linux-kernel@vger.kernel.org>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot
 configuration
Message-ID: <20260424160609.45ff9a0a@phoenix.local>
In-Reply-To: <CAM0EoM=mtYFyVJYLRiFULX1hpxvcwpUoTDGJvTyAskyCk_Oehw@mail.gmail.com>
References: <20260418032027.900913-1-stephen@networkplumber.org>
	<20260418032027.900913-5-stephen@networkplumber.org>
	<20260421131039.GA651125@horms.kernel.org>
	<87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com>
	<CAM0EoMmnHfUiKP1PO19sHJZpeGN5tdL7ds=_8Nma7Y-4XoSczg@mail.gmail.com>
	<20260424080700.6846dfcb@phoenix.local>
	<CAM0EoM=mtYFyVJYLRiFULX1hpxvcwpUoTDGJvTyAskyCk_Oehw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 31212463F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_PBL(0.00)[104.202.41.210:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.167.173:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,phoenix.local:mid,mojatatu.com:email,networkplumber-org.20251104.gappssmtp.com:dkim]

On Fri, 24 Apr 2026 16:17:13 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> () ncalls s
>=20
>=20
> On Fri, Apr 24, 2026 at 11:07=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Thu, 23 Apr 2026 17:12:15 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > =20
> > > > > This is intended and explicitly explained in the cover letter. =20
> > > > Jamal, given the uAPI implication, could you please double check th=
at
> > > > the change is fine?
> > > > =20
> > >
> > > It should be fine; at least iproute2 will never allow the kernel to
> > > receive a negative number.
> > > Stephen brought up the fact that strtod() could return a -ve number
> > > (but at least iproute2 makes sure negative numbers are not carried
> > > forward to the kernel).
> > >
> > > cheers,
> > > jamal =20
> >
> > Iproute2 blocks negative values kind of by accident.
> > The NEXT_IS_NUMBER() macro looks for digit at start of arg.
> > To hit this you need to either use raw netlink or change NEXT_IS_NUMBER=
()
> > to NEXT_IS_SIGNED_NUMBER() where slot values are parsed. =20
>=20
> For this specific attribute it was intentional:
> ...
> if (get_time64(&slot.dist_jitter, *argv)) { //get_time64 calls
> strtod() which could set dist_jitter -ve
>     explain1("slot jitter");
>      return -1;
> }
> if (slot.dist_jitter <=3D 0) {  // we reject -ve values
>     fprintf(stderr, "Non-positive jitter\n");
>     return -1;
> }
>=20
> cheers,
> jamal

I see no cases where negative time value is a valid input.
Doing audit of netem:
- slot times
   parsing rejects -10ms for min delay and -100ms for max delay
- delay
   negative value is accepted, but internally acts like 0
- jitter
   negative value is rejected (i.e What is "-2s")
- slot distribution delay
   same as regular delay, accepted but internally acts like 0
   negative jitter is rejected "Non positive jitter"

Gate:

Codel:
  - setting negative target, interval or ce_threshold gives huge value
    4.29e+03s
Pi:
  - setting negative target gets absolute value
Hhf:
  - setting negative value gets 4.29e+03s

So I can't see any valid use for negative intervals





