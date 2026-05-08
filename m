Return-Path: <netdev+bounces-285949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ0eFfkg/mmunAAAu9opvQ
	(envelope-from <netdev+bounces-285949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95184FA1F2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDDBA301E807
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD7421EEF;
	Fri,  8 May 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWpRor7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A015B135
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262238; cv=pass; b=XCNpYhk+92aeGPQH3e53qn3km54W1MHeIbaiMzG+dtQDnj4oye1X7y6lNFn962FOfmg+4zwXttOXSxjMST5pxL1vVOf/BRmD3NVMWZLISSGhqv5l1D8R9jEeuER7aUzpiZTfu11/ani8u4hlvLx+iwl/81ccDFiHMdrZUNrrvqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262238; c=relaxed/simple;
	bh=PgIk0w8wil/hZjOTGmlYMT9GhmtLfkapmbSE0wuRrvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/gDZtef6lteis6/8xuNoheqxKU3yUOhkkwHVsK5MSB+2uVcKUS7iNQtIQ3r7s0ceYYITv4yMHWIZBHtuEu+hcJof+gItnNu9CWsTuosZlmu0PL4IYX7GsA+WnVBQ/UbNjFX8oxLm3FGeQ2gQd7BpRLUs34QopQ4GCtFphuEUPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWpRor7W; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso71a12.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 10:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262234; cv=none;
        d=google.com; s=arc-20240605;
        b=FXoLp0FCstgiejY0Z5nzspdBj+jxEHT9dxMk3w/8HNhGwli0oH2vICFKIwSVd63jt7
         g2CMYabpcJ59A8UqUJlLYBTc6FQA2zIyUEG8kqXLDMN6BFF4THwX/pGxglxr+Qj0D4rO
         GmENy3iSsUlAEhRucx8PBaxAjS6MQBJz/qqnp/6WhwdMWnnwivjJAXFRaE69Fxwf6D8l
         NhOwsg/pC9Y/NA7z37Ux+ftp7U1EKfNwVWWb4k7ORFd/4PwZTRXpNjKb0Fwm8VHh1WSV
         FgQxjQhyYyDqLeuD3lvdCnPBM5k7MkS30e906S71ieeQqNGKgVN1e+pcV+Puw4JqKfZy
         8fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PchyBFS8tQKJlNEBmyOBmtqArxY1WWRzvq5ayZh7P9w=;
        fh=JjkKR8F+H0mjdGkPaPEUpoK5hSDHhMQsS+u+uONL0eE=;
        b=J2zq7f2RYM/PNl/4fFZdkiRXxWvD690DSUHWh2F/0w/An4f3FB6iOD8EQMTwjmCWzL
         NMnlaFSPDpVWMFNlxxP3pl7e/KB3hqzLlUOBWh9J8M6zAaURgACV7woVb+R3+v8MXbZc
         jmxyhLpuiE8wdS6ENbhWVCP9SdN1//jO7TD0bnBlOZ7N0w7tBrby/pH6PomlyO7cRv7e
         UIJMIH5XghCR5W1mqQbt3eUvX0ZnrO9TbtEE9q4VVYNz+evVrLbE+UgPLQ0S0lPGTVBi
         Gdl97mC9/a6Y83suZfAIwYMluP5+SAPlVhtT66amyr5KFljorIXsOEp21I9Ru6hRZVcv
         4Lnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778262234; x=1778867034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PchyBFS8tQKJlNEBmyOBmtqArxY1WWRzvq5ayZh7P9w=;
        b=UWpRor7WvVOwhxkcm94JkAIymsCi/oqJdJpUOueoVxxyZ53Uas3dtadFh+8BWoZ45g
         5wKum7706RAtN32EG4PXSX8AIPvvnFvCoYtdiBB75XcS7yEgNyshfpf8bWHzEsIPbdJq
         OlQtPy6Aw6UHVwRfLKh1XFpupVDuqWxBaAtZdYZctRizUxUB3/ouaxocKqQK/5j2SyYC
         J+KRLjXU7x3iPggcdK+ig1YyiJL0xxWmlxjPMagJQZncKufNruYbF6xIZxl/M5fnOcCe
         Dkh6isC5exHWlLccziJXVeoB0qOCgv/rDIFuU/xtaikOCa3lzxt5y2UfcxWMSt5ZhvyF
         gEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262234; x=1778867034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PchyBFS8tQKJlNEBmyOBmtqArxY1WWRzvq5ayZh7P9w=;
        b=VEKNowFN6xaYx1j08yfKcOStX1Mdh1JaTY48/FTw/jbvR9SCq24Uh34q6Jn9M8t4lQ
         hH2Cg4FtEJ/CCDt3miRkIXL5uMdsv5mW0zug9dmt82ipn2DxaeyBXi7m6dDFhBUAuVlj
         fW2k4TOEu6LcIdBEKdxw9Uk4worfyVYytl/f637Ufvuf3WDwsCy4asp+Sov1Gk6uuQ+R
         6YIbbsRgGjuuRrMqGVitfw0pOIg8ChRyKEmYK6nKmxI19Ut6lnp3OU3GULPYl9HpGLmN
         f7sZ7VdxXyVoOj/jXciWTXiWwlNohy3sYvxDuUkIg1myy89SauwDFoPQsM4VADbFPtFv
         UOuA==
X-Forwarded-Encrypted: i=1; AFNElJ8zcP8VRIbrBMkni8ATYCXPjIV4rxU3+DCF1ua9paNWzIt6UzBw84DsAOTIT2ZkDGN5EuiupM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmEj4wnc0oUE3ylVG7jBjnrdryESucJQUuzbXExomkp0keAKZ
	VTVWCjMcvjTLFiMKb70jqnh9sxdF3aH84X38ky7YICo3XCoxpt9kCM0rSL2rrH0u2x8hNNPbF3Z
	VH4HDxwYwXZlO+IjX5zpA4OsixzsSDKumPN9nUvfM
X-Gm-Gg: Acq92OFZ+BezgG10j+T7JDRzteVJ2NQCZE0rAftYhZlbXAnOYWM56iS6VLhd5z7E6Er
	bvhcDJBHD372P4wRpo9ix4cxrVwihIFii6PHR+/rCz7wtnhHUuHoLW3mhsdphbnm5aoxtuqxQ7n
	YBr4jTe5LdIt8MxvOIezLmG0tSfX+7f7Z+6ZNYAg9nn3o87eWzjM6BDsPY2c2uBi8KjuX0wdDI8
	FW/OV74+IMcQ9gOC0YKPsM7H9XFWI3P54VM6EEg+WIXLkSKd7loK1WerulnH7Mbuwh3ZVdwT31e
	j47bd/dOiuM+rpu/+sliJMLzDPgSog==
X-Received: by 2002:a05:6402:7d9:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67f5af75266mr1846a12.1.1778262233969; Fri, 08 May 2026 10:43:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-4-hramamurthy@google.com> <4fb57921-33a6-4ab3-a0a8-9b8c3a48fd24@intel.com>
In-Reply-To: <4fb57921-33a6-4ab3-a0a8-9b8c3a48fd24@intel.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Fri, 8 May 2026 10:43:42 -0700
X-Gm-Features: AVHnY4JgfY9zLFBgLSvvE3z19WNNxFI9TnYYn3Tf9gVlseSv4u6SNbX6AjRDUC4
Message-ID: <CA+mzVtu9OVgK3XEsoRsZ3BamQGjBnsdu2cAtesamiDQQi_69sA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] gve: implement PTP gettimex64
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	jstultz@google.com, tglx@kernel.org, sboyd@kernel.org, willemb@google.com, 
	nktgrg@google.com, jfraker@google.com, ziweixiao@google.com, 
	maolson@google.com, thostet@google.com, alok.a.tiwari@oracle.com, 
	pkaligineedi@google.com, horms@kernel.org, dwmw2@infradead.org, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E95184FA1F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:23=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> >
> > Two paths are implemented: a precise path using system counter values
> > sampled by the device, and a fallback path using system counter values
> > sampled in the driver using ptp_read_system_prets()/postts().
> >
> > To use the precise path, the current system clocksource must match the
> > units returned by the device, which on x86 is X86_TSC and on ARM64 is
> > ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> > be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
> > by default on GCP VMs using Chrony, so we expect the precise path to be
> > used the vast majority of the time. If the system clocksource is change=
d
> > to kvm-clock, it activates the fallback path. Ethtool counters have bee=
n
> > added to count how many times each path is used.
> >
> > The uncertainty window in the precise path is typically around 1-2us,
> > while in the fallback path is around 60-80us.
> >
> > Stub implementions of adjfine and adjtime are added to avoid NULL
> > dereference when phc2sys tries to adjust the clock.
> >
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Kevin Yang <yyd@google.com>
> > Reviewed-by: Naman Gulati <namangulati@google.com>
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> > Changes in v6:
> > - Added a fallback to driver-sampled time sandwich that is used when
> >   the following conditions are not met:
> >   - The system clock source is X86_TSC or ARM_ARCH_COUNTER
> >   - The requested clockid is CLOCK_REALTIME or CLOCK_MONOTONIC_RAW
> >   - The architecture is x86 or ARM64
> > - Added ethtool statistics to count how many cross-timestamps used the
> >   precise path versus fallback path.
> > - Fixed printf format specifier.
> > - Added stub implementions of adjtime and adjfine to prevent NULL
> >   dereference when phc2sys tries to adjust clock.
>
> All excellent improvements.

Thank you for the review!

>
> > - Moved system time snapshot back to gve_ptp_gettimex64() so we can get=
 the
> >   current system clock source from it. It is OK for it to not be inside
> >   the mutex or retry loop because lock contention and retries should be
> >   extremely rare, and chrony filters out bad samples.
> >
>
> I'm a bit worried about this part, but if I understand, it would only
> affect the fallback variant anyways since the clock samples are taken in
> the host in the precise/fast path.

Good point, the snapshot *is* used in the precise path to interpolate
system timestamps that occur before the current timekeeping interval.
This is my understanding of how historical timestamp interpolation
works (adjust_historical_crosststamp()).

        <--      total_history_cycles                      -->
                               <-- partial_history_cycles -->
-------|------------------+------------------------------------|-----------=
-----+---------->
 cycles (input)
  snapshot         sample                               cur_interval       =
 now
-------|------------------+------------------------------------|-----------=
-----+---------->
 ktime (output)
        <--                      corr_raw                        -->

At the start of each timekeeping interval, both the current cycle
count and ktime are recorded. Each interval boundary consists of a
(cycle count, ktime) pair.

It computes the ktime corresponding to sampled cycle count as corr_raw
* partial_history_cycles / total_history_cycles. In other words, it
scales the distance between the interval boundaries in ktime units by
the relative position of the sample in the interval computed using the
cycle counts. It adds or subtracts this value to whichever interval
boundary is closer to get the absolute ktime.

How would this be affected by a very old snapshot? The interpolation
would still work, but it may be less accurate if the clock is not
stable. To get a sense of the timescales,
 - the timekeeping interval is typically 4ms (CONFIG_HZ=3D250).
 - the AQ command typically takes 60-80us.
 - there are 2 sources of contention on the mutex (aux task and gettimex64)
 - worst case retry loop is 100ms (but this should not happen due to
how the firmware rate limiter has been tuned)
 - typical clock stability for the relevant cloud server platforms is
about 10ppm

The vast majority of the time, the sample should fall in the current
or previous timekeeping interval, resulting in the most accurate
interpolation possible.

In the worst case for retries and contention, the snapshot could be up
to 200ms before the current timekeeping interval. Assuming clock
stability of 10ppm, this translates to 10us of drift per 1s, or 2us
per 200ms. This is still considerably better than the root dispersion
in the fallback path (81us), so I think it's OK.

>
> > Changes in v5:
> > - Reformulate retry loop in terms of total timeout (Jakub Kicinski)
> >
> > Changes in v3:
> > - Take system time snapshot inside the mutex
> > - Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
> >   than x86 or arm64
> >
> > Changes in v2:
> >  - fix compilation warning on ARM by casting cycles_t to u64
> > ---
> >  drivers/net/ethernet/google/gve/gve.h         |   8 +
> >  drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
> >  drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +
> >  drivers/net/ethernet/google/gve/gve_ptp.c     | 237 +++++++++++++++++-
> >  4 files changed, 243 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 7b69d0cfc0d5..4de3ce60060e 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -880,6 +880,14 @@ struct gve_priv {
> >       u32 stats_report_trigger_cnt; /* count of device-requested stats-=
reports since last reset */
> >       u32 suspend_cnt; /* count of times suspended */
> >       u32 resume_cnt; /* count of times resumed */
> > +     /* count of cross-timestamps attempted using system timestamps
> > +      * from the AQ command
> > +      */
> > +     u32 ptp_precise_xtstamps;
> > +     /* count of cross-timestamps attempted using system timestamps sa=
mpled
> > +      * by the driver
> > +      */
>
> Helpful for analyzing when its not working. Nice!
>
> > +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> > +                               struct system_counterval_t *system_coun=
terval,
> > +                               void *ctx)
> > +{
> > +     struct gve_cycles_to_clock_callback_ctx *context =3D ctx;
> > +
> > +     *device_time =3D 0;
> > +
> > +     system_counterval->cycles =3D context->cycles;
> > +     system_counterval->use_nsecs =3D false;
> > +
> > +     if (IS_ENABLED(CONFIG_X86))
> > +             system_counterval->cs_id =3D CSID_X86_TSC;
> > +     else if (IS_ENABLED(CONFIG_ARM64))
> > +             system_counterval->cs_id =3D CSID_ARM_ARCH_COUNTER;
> > +     else
>
> No single kernel can be compiled for both CONFIG_X86 *and* CONFIG_ARM64
> simultaneously, so there is no need to check in sequence and an
> exclusive if/else path is fine. Ok.

Noted, thanks.

>
> > +
> > +static bool
> > +gve_can_use_system_ts_from_device(enum clocksource_ids system_clock_so=
urce,
> > +                               clockid_t clockid)
> > +{
> > +     if (clockid !=3D CLOCK_REALTIME && clockid !=3D CLOCK_MONOTONIC_R=
AW)
> > +             return false;
> > +
> > +     /* If the system clock source matches the system clock
> > +      * returned by the AdminQ command, we can use the system
> > +      * timestamps returned by the device, otherwise we have to
> > +      * fall back to sampling system time from the host which
> > +      * is less accurate.
> > +      */
> > +     if (IS_ENABLED(CONFIG_X86))
> > +             return system_clock_source =3D=3D CSID_X86_TSC;
> > +     else if (IS_ENABLED(CONFIG_ARM64))
> > +             return system_clock_source =3D=3D CSID_ARM_ARCH_COUNTER;
> > +
>
> This feels a bit duplicated to me, since you have the same check
> elsewhere. Would it make sense to pull this to its own function check?
> Its short enough I think that is only warranted if you have a true
> (non-nit) cause to make a v7.

There is a similar check in gve_cycles_to_clock_fn, but the logic
inside the if blocks is different so I'm not sure how they could share
code.

>
> Thus:
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thank you very much, appreciate it.

