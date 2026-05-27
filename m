Return-Path: <netdev+bounces-292427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOV3Bz48F2qg9wcAu9opvQ
	(envelope-from <netdev+bounces-292427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:47:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627985E932E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38F333009FB2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E84A30DEA3;
	Wed, 27 May 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw3yypSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2912472AA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907609; cv=pass; b=C1UNWmMDKzLiTSQyOPpwH41UjkZe2f5vSL0ZE+6Z3zyhPwCIMQjWe2/lkocIdli1XQFXtkWNy1CeLGr+LEqH9zZbmFNSvkyNWZKT1sEq6476BZqzsuLvJ+8wQp6+6HvPnfee5CmLs4K2N4b/9wRZcMTXg+WRso7zCX4r+1Mk9e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907609; c=relaxed/simple;
	bh=AvcCT2bpYWyCPUDatXo6nITVkWzKt+JY52IpSQMiMIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDuew8z1ZRtXUuLbxUFXtRjk+XhAI7ucN8DxK38pT6VBSjDULUSNcK5FeldkrOwExD5FAVd4Ic31XlSVGFDijhjNOrCkYmcVBPtiqzRICldTxsRe91wNDRIuhMn5HCar+TtaYqYdjB2gY53Qcs4QiMWNz9yVVwBETPwFIrRDCOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw3yypSa; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso598a12.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 11:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779907606; cv=none;
        d=google.com; s=arc-20240605;
        b=a2eOoq6P/QuLrOCF9yDSzLQ9qvvX/BwWyzEF50evFWExoCyA2qrGxK/60MI2Tu+sRb
         IA84XLGisEhQwKebiDTABfNulFwE4gyaEygEC+ICSA/x+WGXz2IXdTl7jF6j8DROtPJZ
         8U6Hu7FETM3/NFJ77qLq/Lr8nTjEOtNRUAHppZKQ0zJ/A4cgD4I7bdCLmX13pxHK91hX
         8Tpe/Ysm4TTr0+w0uztlFg7sXT9S2NRSz2fghoK5c/Wx22bJk/Q918t38tQxJQZ2ZcKo
         bFEkLegtBYM4vNBccGFudr4aIJ2dUx0OxqjSMkY72RrRQn19A+aNqBCyaiQxugjmjve1
         ZrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ihsnyiEjxeCtiMQ9Slu0ilDxRaV9GRqrLoCUEqFUHU=;
        fh=/xLGrOgdlhedLDulHZWunSbjCukoXOzbt/YsDRE77Cw=;
        b=XwTDx6xaC0yl72DEgZJukOYif9+qLRoFOfVNP3WCuSKHi+hiR8vqeOI21+4Gn/8rUI
         8+e35febwvMTBMxLCJow8K1x8JfGY97/ezDWxyZg0el1X13dDXEBhNbNQGo3jpnau5mG
         Q/ui9tG6Uz0vswrGCaSG0t0AkgKZgqISZ1ypVkCIoKpmt0P3K3eEhrlk6l7dHG+DI9JX
         zJTL8W7QvXSbuH6zEmb+KrHpKiNTPvCcQw7wy5rgZ3IFQMMeWek5Wtr4QeNYhYUpshTH
         n/XohHJUAq6sOHqOOuPDUGqDgfj+sf+MDeI5O/DN3nU0DSh9r7/WU7jg73+dcjuPXYIb
         zbCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779907606; x=1780512406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ihsnyiEjxeCtiMQ9Slu0ilDxRaV9GRqrLoCUEqFUHU=;
        b=Yw3yypSaHoHhC+khkyrjmDiVDBoyB+oARHQzf3w7ZohPvbPoZ7AcSbVlEw7RW6+2RN
         jwqpz0wfroL1l/sTdwOSP2k3BQzjFnjs3QQoDlB3mjF0qd+MneM6A3ETHG9dhoLAYB3g
         VZLzxH5eHS70qtv0ICGn/eeCfCy/AGD5Suj85qLlOW16huXG2idILDWeTbKfkD+X3AeK
         9SvxEq3GU2EbwrtTbxgS3yVNvcmT1AGRMnNXDLlJPXUEhsTWxr3q3RywMWATMyN73D9I
         WYFULapS3PuzkwDiIuB6YkKF+w4NMrP8sYxH5wc0/QZZnuPGkLritAyKQZ9wy6bLD7Ht
         8Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779907606; x=1780512406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ihsnyiEjxeCtiMQ9Slu0ilDxRaV9GRqrLoCUEqFUHU=;
        b=QrklcIJz3Wxa4sReqqjhLEJJHonanM4YsupWBx5sLg021DKeKpGkr6qgofAjNSLp08
         y6WoKxptH/rdsa7rUW59N8nZ+/9qKNGzZuJy+7ljkIPYkbDuGmhOwgmUyigepaMl5Q0e
         AmB+lH4mRC5JKR4nvr0HxO/87BDS8dP5Ca0JpcIkcEe4drei2kKEQ2OGlG3FOAWjsvrD
         DqMBm2WvMRmdRWmtDAb2GiRvYEALfKusPtdztAOOyQ3yd7zC7rRDkIkoyODGfP6qWN+N
         Kwnoeo7Ovcx69yXuhJLB+Z5dGGOr+Ks0lcav2ZUGm3bzLjN/+E1X8r0qe/Y1HQQ3KH2A
         RIPw==
X-Forwarded-Encrypted: i=1; AFNElJ/R5Df1Xx3RLOcfhS3MBcmACi5l3mUD7FSiM9CHlLrsiZPDQBrOoND6UOezlw7Mur5jACsYAKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKJXGQUGwSUbZR/a02aNyinmsp9P5n8gQfiGjO608hKiyeuJG
	bIQ7FRKRBBP6z3jyR+WU/6iIdz9Jomccqcf17RJJeNQT9XZozlaFoKkwiXC/sZcE9F6jpFivxdU
	5f0+3SueGIWGW/OEnzhXrO1FAQl8ZYJVynrKz4EGD
X-Gm-Gg: Acq92OENtU7c9xjpMcHynVFcfZ6c1wZ7M8l6+d84iHQtYAKHoli4anFk/N1luvdRW1O
	ssh27lOJJbTfc7zvBzoOxCRGX1Um2qWhHOjV9OFAu/tv61K1IFr+WKFORPk+ZGYdgy543Fuc6+J
	YMu7vZYG9DdqVc1ab1zfHYefXL3Ut83LuNPF/NbogpDOOiH/dg1M/p9lcVl3UoHnGq1ieSd9KT9
	xSxsxrzM7fxTq6YvDOL08zHEAwfy/PD2ImKr7fwR8i/0oFa2IC+RjVmrm+W5JWQY+nlmcPBE4cb
	5O/YAK23+ezMf3+977+5TaIXje+c7vGuc4c7tlNMngj99ZhYjEhsH63S
X-Received: by 2002:a05:6402:3049:20b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-68ae9f1ad0dmr484a12.8.1779907605587; Wed, 27 May 2026 11:46:45
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com> <87mrxtwzz9.ffs@tglx> <CA+mzVtuhB9J9MDHSUfmBeV8hdtprGBsBZWrxLRtvdZY_V_NhNA@mail.gmail.com>
In-Reply-To: <CA+mzVtuhB9J9MDHSUfmBeV8hdtprGBsBZWrxLRtvdZY_V_NhNA@mail.gmail.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Wed, 27 May 2026 11:46:34 -0700
X-Gm-Features: AVHnY4LRQWryzmy1-Y9ODmlfgPUPFfiPvshhqHxXipf5cWRCKgqVv6_zzSoippw
Message-ID: <CA+mzVtt==6x0-BK7_5OupH+a=dwNrMY0YT4fGjHH2OM48MgLkA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
To: Thomas Gleixner <tglx@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	jstultz@google.com, sboyd@kernel.org, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292427-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 627985E932E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

We would like to request the community's guidance on how to proceed with ad=
ding
cross-timestamp functionality to GVE. The key challenge is that the
NIC clock can only be sampled in the hypervisor because the NIC time
registers are only present on the PF, and a hypercall takes 60-80us.
To minimize the uncertainty window, the hypervisor takes a TSC
sandwich around the reading with an uncertainty window of ~1.2us,
converts it to guest TSC, and returns it to the guest.

The goals which led to this implementation were to minimize the
uncertainty window and communicate the uncertainty window up the
stack. I've reviewed
https://lore.kernel.org/netdev/20260526165826.392227559@kernel.org/
but I'm not sure how we would use it, so if it is intended to support
our use case I would appreciate if someone could explain how we
should use it.

Here are some options on how to proceed, but other ideas are welcome.

1) resubmit the patch with the same high level approach with the
feedback addressed. This is our preference since it achieves the smallest
possible uncertainty window and communicates it up the stack.
        - move system timestamp sampling and ktime_get_snapshot()
inside the mutex
        - remove get_cycles() and the ordering sanity check
2) implement getcrosstimestamp() and return the midpoint of pre/post,
but lose the uncertainty window
3) wait for https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazo=
n.com/
which adds error_bound to getcrosstimestamp()
   - error_bound calculation: convert TSC delta to nsec using
tsc_khz/arch_timer_get_cntfrq() =3D> clocks_calc_mult_shift() =3D>
clocksource_cyc2ns()
   - since this patch changes usermode interface, chrony/phc2sys would
need changes to consume the new IOCTLs, and it is unclear whether
there is an intention to do so
4) implement gettimex64() using only system timestamps sampled in the
VM (i.e. remove the precise path). Accept uncertainty window of
60-80us vs. 1-2us
5) implement gettimex64() using the midpoint of pre/post to make a
single call to get_device_system_crosststamp(), then compute the
pre/post ktimes by adding/subtracting the delta/2 between the TSC
readings from the firmware

Thank you,
Jordan

On Wed, May 20, 2026 at 9:35=E2=80=AFPM Jordan Rhee <jordanrhee@google.com>=
 wrote:
>
> Hi Thomas,
> Thank you for the review. We plan to rework this to use
> https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/,
> which will let us use the midpoint of pre and post while still
> propagating the uncertainty window up the stack. I am going to address
> some of the concerns you raised simply for the record, not because I
> am trying to convince you one way or another. I do not expect a
> response. Thank you,
> Jordan
>
> On Wed, May 20, 2026 at 2:08=E2=80=AFPM Thomas Gleixner <tglx@kernel.org>=
 wrote:
> >
> > On Thu, May 14 2026 at 22:58, Harshitha Ramamurthy wrote:
> > > From: Jordan Rhee <jordanrhee@google.com>
> > >
> > > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> > >
> > > Two paths are implemented: a precise path using system counter values
> > > sampled by the device, and a fallback path using system counter value=
s
> > > sampled in the driver using ptp_read_system_prets()/postts().
> > >
> > > To use the precise path, the current system clocksource must match th=
e
> > > units returned by the device, which on x86 is X86_TSC and on ARM64 is
> > > ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> > > be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hol=
d
> > > by default on GCP VMs using Chrony, so we expect the precise path to =
be
> > > used the vast majority of the time. If the system clocksource is chan=
ged
> > > to kvm-clock, it activates the fallback path. Ethtool counters have b=
een
> > > added to count how many times each path is used.
> > >
> > > The uncertainty window in the precise path is typically around 1-2us,
> > > while in the fallback path is around 60-80us.
> > >
> > > Stub implementions of adjfine and adjtime are added to avoid NULL
> > > dereference when phc2sys tries to adjust the clock.
> >
> > Sorry that I did not react to this earlier, but I was burried in
> > regressions and allowed myself to take a few days off.
> >
> > > +/*
> > > + * Read NIC clock by issuing the AQ command. The command is subject =
to
> > > + * rate limiting and may need to be retried. Requires nic_ts_read_lo=
ck
> > > + * to be held.
> > > + */
> > > +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre=
_cycles,
> > > +                               cycles_t *post_cycles)
> > > +{
> > > +     unsigned long deadline =3D jiffies + msecs_to_jiffies(100);
> > > +     unsigned long delay_us =3D 1000;
> > > +     int err;
> > > +
> > > +     lockdep_assert_held(&ptp->nic_ts_read_lock);
> > > +
> > > +     do {
> > > +             *pre_cycles =3D get_cycles();
> >
> > This is a completely non-sensical hack. Why do you need get_cycles()
> > here, which is a horrible and ill-defined interface that others are
> > trying to get rid of?
>
> We use get_cycles() purely as a sanity check against the TSC values
> returned by firmware. We do not use them in the time conversion.
> This check found a serious correctness bug in the firmware.
>
> >
> > Just because it's still there is not a good answer and it's actually no=
t
> > required at all. See below.
> >
> > > +             err =3D gve_adminq_report_nic_ts(ptp->priv,
> > > +                                            ptp->nic_ts_report_bus);
> > > +
> > > +             /* Prevent get_cycles() from being speculatively execut=
ed
> > > +              * before the AdminQ command
> > > +              */
> > > +             rmb();
> > > +             *post_cycles =3D get_cycles();
> > > +             if (likely(err !=3D -EAGAIN))
> > > +                     return err;
> > > +
> > > +             fsleep(delay_us);
> > > +
> > > +             /* Exponential backoff */
> > > +             delay_us *=3D 2;
> > > +     } while (time_before(jiffies, deadline));
> > > +
> > > +     return -ETIMEDOUT;
> > > +}
> > > +
> > >  /* Read the nic timestamp from hardware via the admin queue. */
> > > -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> > > +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> > > +                              struct gve_sysclock_sample *sysclock)
> > >  {
> > > +     cycles_t host_pre_cycles, host_post_cycles;
> > > +     struct gve_nic_ts_report *ts_report;
> > >       int err;
> > >
> > >       mutex_lock(&ptp->nic_ts_read_lock);
> >
> > Why is this lock taken _after_ the regular (fallback) pre/post
> > timestamps are aquired?
> >
> > What's wrong with doing:
> >
> >        do {
> >                 guard(mutex)(&ptp->nic_ts_read_lock);
> >
> >                 ptp_read_system_prets(sts);
> >                 err =3D read_nic_timestamp(...);
> >                 ptp_read_system_postts(sts);
> >        } while (err && !timeout(...));
> >
> >        return err;
> >
> > which moves the "fallback" timestamp right next to the actual hardware
> > readout?
>
> The lock is taken at the smallest scope possible, which does not
> include the pre/post TS reading. This routine is called by multiple
> callers, not all of which need the pre/post timestamp. Options are to:
>  - move the pre/post TS reading here and add branches to conditionally
> sample them only when needed
>  - always capture the pre/post TS readings and discard them when not need=
ed
>  - duplicate the locking logic, once for path that needs pre/post TS,
> once for path that doesn't need pre/post TS
>
> Since the fallback path is expected to be rarely used, lock contention
> and retries are expected to be extremely rare, and chrony is resilient
> to samples with high uncertainty window, I chose to prioritize
> cleanliness of the code and keep the pre/post TS reading in the caller
> where it is actually needed. That said, I do not feel strongly about this
> and would be open to moving pre/post inside the mutex if I were sending
> another revision.
>
> >
> > That would make the "fallback" case too precise, right?
>
> Moving pre/post inside the mutex makes no measurable difference
> because the lock is rarely contended. There is 4 orders of
> magnitude difference in RMS offset between precise and fallback paths.
>
> >
> > After noticing the obvious, I just checked what our new AI review
> > overlord "sashiko" has to say about this:
> >
> >      "Does wrapping the timestamp read outside the locks and retry loop=
s skew the
> >       measurements?
> >
> >       In the fallback path, ptp_read_system_prets() is captured before =
calling
> >       gve_clock_nic_ts_read(), and postts() is captured after it return=
s. However,
> >       gve_clock_nic_ts_read() acquires ptp->nic_ts_read_lock and calls
> >       gve_ptp_read_timestamp(), which can sleep using fsleep() during r=
etries. This
> >       means the prets/postts window could include mutex wait times and =
sleep
> >       durations."
> >
> > It _IS_ actually on spot. So why the heck did this garbage get merged
> > without addressing this obvious fail?
>
> - The fallback path is expected to be rarely used since it requires
> changing the default configuration
> -  The lock is rarely contended as there are only 2 callers, one of
> which only executes once every 250ms,
>   and retries would only occur if a VM exceeded their rate limits
> which have been tuned not to occur
>   under normal chrony calling patterns.
>
> >
> > What "sashiko" actually saw aside of that, which I didn't see myself wh=
en
> > looking at this, is:
> >
> >    "Similarly, in gve_ptp_read_timestamp(), the get_cycles() bounds are=
 taken
> >     outside the gve_adminq_report_nic_ts() call, which acquires the sha=
red
> >     priv->adminq_lock. If there is lock contention, the cycle bounds co=
uld become
> >     extremely wide."
> >
> > Oh well.
>
> get_cycles() is only used for sanity checking the values from
> firmware, not in any time conversion.
>
> >
> > So what you really want is:
> >
> >        do {
> >                 guard(mutex)(&ptp->nic_ts_read_lock);
> >                 guard(mutex)(&gpe_priv->adminq_lock);
> >
> >                 ptp_read_system_prets(sts);
> >                 err =3D read_nic_timestamp(...) {
> >                         ...
> >                         return gve_adminq_execute_cmd_locked(....);
> >                       }
> >                 ptp_read_system_postts(sts);
> >        } while (err && !timeout(...));
> >
> >        return err;
> >
> > Or just rely on gpe_priv->adminq_lock in the first place. No?
>
> adminq_lock is private to the adminq layer and protects adminq shared dat=
a
> structures. nic_ts_read_lock protects the global DMA buffer that receives
> the timestamps. Since retries are a response to rate limiting, we must wa=
it
> between retries, so we do not want to hold the adminq lock across
> these retries as it would block other non rate-limited commands.
>
> >
> > But what's worse and escaped the AI scrutiny is:
> >
> >   Your attempt to convert these 'get_cycles()' time stamps after the
> >   fact and outside of the timekeeping core protection is fundamentally
> >   wrong.
> >
> > get_device_system_crosststamp() does
> >
> >       do {
> >                 seq =3D read_seqcount_begin(&tk_core.seq);
> >                 take_timestamps(...);
> >                 convert_timestamps(...)
> >       } while (read_seqcount_retry(&tk_core.seq, seq));
> >
> > which covers the whole sequence of taking the snapshots from the
> > hardware and the conversion.
> >
> > Your abuse of this is completely out of spec. Just because it did not
> > blow up in your face yet does not make it in any way correct. You do no=
t
> > even get bonus points for creative abuse.
>
> We use ktime_get_snapshot() to capture a historical snapshot before sampl=
ing
> the TSC, and we pass it to get_device_system_crosststamp() which
> uses the snapshot to interpolate the sample if it occurs before the curre=
nt
> timekeeping interval. Perfectly within spec.
>
> >
> >
> > Now let me look at the "firmware" provided timestamps.
> >
> > That's the poor mans emulation of actual hardware timestamps aka PTM.
> >
> > Why do you need all this pre_nic/post_nic muck there? Fix your firmware
> > to actually honor PTM and not provide some made up version of it.
>
> This has to run on platforms that don't support PTM.
>
> >
> > Also the whole debug mechanism of comparing the time stamps of
> > get_cycles() with the timestamps provided by firmware tells me that you=
r
> > firmware is a hacked together piece of garbage.
> >
> > If you want to use "hardware" timestamps then populate the
> > ptp.info.getcrosststamp() callback.
> >
> > If your firmware really can't do PTM and only provides pre and post
> > values, then you simply can take the midpoint in your getcrosststamp()
> > callback:
> >
> >       do {
> >                 guard(mutex)(&ptp->nic_ts_read_lock);
> >                 err =3D read_nic_timestamp(...);
> >                 system_counterval->cycles =3D (nic_pre + nic_post) / 2;
> >       } while (err && !timeout(...));
>
> We considered returning the midpoint of pre/post up through
> getcrosststamp(), but there was
> no way to communicate the uncertainty interval which is important
> for some of our use cases.
> https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/
> fixes that issue, so we can use that when it lands.
>
> >
> > If you do not even trust your firmware then you still can validate it
> > easily without creating horrible hacks:
> >
> >       do {
> >                 guard(mutex)(...);
> >
> >                 ptp_read_system_prets(&ctx->sts);
> >                 err =3D read_nic_timestamp(...);
> >                 system_counterval->cycles =3D (nic_pre + nic_post) / 2;
> >                 ptp_read_system_postts(&ctx->sts);
> >       } while (err && !timeout(...));
> >
> > and then check the ctx->sts timestamps against the results provided by
> > get_device_system_crosststamp() after conversion in your
> > ptp.info.getcrosststamp() callback:
> >
> >         err =3D get_device_system_crosststamp(..., &ctx);
> >         if (err)
> >            return err;
> >         if (ctx.sts.pre_ts > xtstamp.sys... || ctx.sts.post_ts < xtstam=
p.sys...)
> >            return -EBROKENFIRMWARE;
> >
> > no?
>
> get_device_system_crosststamp() has nontrivial logic that operates on the=
 system
> timestamps, so I am not confident that a bad TSC value would be detected
> if we ran it through get_device_system_crosststamp() first. The check
> is simplest
> and strongest when performed against the raw TSC values received from the
> device, before passing them to any kernel API. But I hear your point
> about mistrusting
> the firmware enough to need this check.
>
> >
> > Jakub, please back out this hackery before it makes a precedence for ot=
hers
> > to copy from.
> >
> > Thanks,
> >
> >         tglx

