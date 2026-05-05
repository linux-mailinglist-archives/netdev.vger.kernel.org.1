Return-Path: <netdev+bounces-284562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JFlLNc8+mmjLAMAu9opvQ
	(envelope-from <netdev+bounces-284562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4574D2E93
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1D1C3008C9C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1454963B8;
	Tue,  5 May 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJ3Eo4FM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13502C15AA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007249; cv=pass; b=TYbTLFD2Z1tacZ3wj44XGNOhE3UlKqKDe1aDNESVsMOV3A7Va0i9JVUu72mUa+ir8CqoilAkJSSNUe2vvTTsZENATpvHOAktlltDPv8XJDL7YmhSN4OB/YbmucwgG3rgYXCbNilkKJappMmlUgWPVuCQIhUaGNIjFZ7RfAClsSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007249; c=relaxed/simple;
	bh=bV5+SXEjJOPfgO7SKWJfvlX4NaHcgiQoXRluJ6dTaAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwJScN3iJlRj0wyQRN3oi/kEWFT7KeG8zvE9Zo+YGIj+I9UznQ5Q4737/sgJXAu4hRUClwASU5Rl93mkc1R5xrAXVLJsubZzBy3S08tghIkJSgBSkUzOJCJAX80jhnKPfcEL373NkibKoWnxaiDTTag7bYymOmQzybBEXJEV31A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJ3Eo4FM; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso1911a12.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778007246; cv=none;
        d=google.com; s=arc-20240605;
        b=H/hETCMDGJABRjvfiUpM71el4usnZjd668z2IMGg0+BziYfEChQ9yOVWQiLMqmUTod
         zeR7qNKRqK5hi4D+NGNY8KpBxJYl7sKftHB6mC3U9Nj106+Qd1tqjAhA3v0Gzb76xPpM
         7KfJrsMrB4JjvwbetcgkGFkLNqqVwAuD21ydu/HLymE+9mJtktF2wQTRNoUfi/RTdTyl
         4GbZUn12ZyWPbT3h3mE2XW8FrtH7kKBD7FDde5qFLTttvhhJLGo9rQTrVgmGbQG5E5z4
         MPTRDyM9ZntorlopyLmL7kTCkCh4PzZnYAFuBSXQmBRZvOB8lI2+qtoVhVvfuPt96jvz
         7kfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXmMd4NRSXbijalWOtOvjetOYm40fzFGENutN8PJn2s=;
        fh=IAJjIP4516iYEwTum+LD5ktN1zzNiKuP5NVm5Ggb65c=;
        b=HaOqbIcJtvouv1qKReXBbGmSP7kmeGJlCnw5VGWJ19sXRPBZGL+qNiFjGCEo6VXbXj
         ZVhXm1idhVfCioJ44iFIQCl+tWVMQ3iRumHHx5HQ4N/KG//yLhGubPYh8PLojRfA/Baa
         he2OVZ30A53wAaSoX8TqBwdzSKbx1OpphaSgBvG3JqikPKYaKS552W44nzG5n/fHAt50
         bXiLXdsN6N5so3gxiuRHymsezOYb1iYl4YtMu9X9B8yiyOX2KM/VLkEcX/5UWC570gHv
         +zxweQjUuIMLDA6EXEADiw5OcSn60rPD2pzBvBNitZfpaMRgF0N0tX7uCbw9mDSXzrVP
         zAtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778007246; x=1778612046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXmMd4NRSXbijalWOtOvjetOYm40fzFGENutN8PJn2s=;
        b=lJ3Eo4FMv7sCYVYcNjqZu12ohtho5NY9bpVKBmyesu46t4cfUERyOov+wsdzICcZm9
         Z0eiF5mGWRewDgqtujTAnyn/e/Z0cQG7tzI+YATxqggnWrzSBBl33mVLjE0julDyQMwn
         vV+dyLPtWAf6TkGbnYvp8L5wZ+XO1BFEdpk12IniJseOPmRHacCJ1FdpTk/mfKyrj5qZ
         KSlsT7zbYtGY/+etsFAuOFYAg04CRtH3X9dTDmCEE7NzOyJzR0b9tJ1p5dBbsuo9VfSO
         pzEsz8/lZrPqLYJibS4fNmBaT3LSRNMfXB2ZEXXrPppf/Pk/WV3jPKlWoPejbB8uM4WE
         RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007246; x=1778612046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXmMd4NRSXbijalWOtOvjetOYm40fzFGENutN8PJn2s=;
        b=mmNu4S0AgT9bgpm9wbwZBBUcX5V+aKqbAxYM39cFpC9SOd6jQseyxN2rIZW8Gg5z46
         urXNzi1aWzADaj4D+uSQEh6ggaEHN/W3GW1n6hh3yMBnsInJMjALQVchucf/iVQZB9NZ
         Sz8p8YE5fOgOPjt2Zfx5Sdoj9tz7v9V8WUiNVbMkHgpTtjOzTOSTvQYS0vRXLNhtJjrh
         1vF4rAqDplcZvnLK0BeCgAA/cpdZqwPCT6E55hOxEQkofMyRWY/UWRmod3ET0WcxtbR3
         suXhkI/JzTRWllrR8xMBNIx+0BVrfiv+o7VQuYH3RDXzEwY3DsVbuke9l2xzdmDEwfJ1
         MsyA==
X-Forwarded-Encrypted: i=1; AFNElJ/6zLCCXlOWd5boQTEomMf+edVu0rNGafluxf5AkQRKq+uLOxgKKvV1phoYx73uF5wAmYtkiyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58KzH4464kGWmEgXUi/jzK8rh4nol2Q05utLiKsWVgy2iVbgX
	7ZNyHbz5cOVzmd/IKzjT2KfMLygjL9eJnbdG+iRJoRS1bJ455GVZNbFW5VC1d2hAmi/lN4QoaWt
	0ViL9DO5sIN2BZaKqK9GQSTIjpn2bli6SJopRdZBi
X-Gm-Gg: AeBDiesLB6nNJrKFjLx1npEydXcx+xN4lE1zM1CDZxqz8eICPHBUrOYxkk1EO2Yqk90
	TI+pgFT4qanKwrFF8A/NmSict1ZobsKtF5mJpA4gDtM9lZmyKPXKwctsi0JOXNt/vx0vpBCyoBH
	Sy9FOLpqwLugswjCQrgDP90XbV1Bneck/yyD5bOQOITnYHSqmK2etak2nfusBi84tJ9yayBPLW3
	B40Cy8baaFMcR4FM9VuPj+8heoTfjv3u51GnrI5eW6pAm27yPdBZuvmA2RtsFFkrDHM6CDOfEZB
	WJHhHcEWkPHcBcha24tMvpYlbOXwdQ==
X-Received: by 2002:a05:6402:a2d0:20b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67d4fbad27fmr8756a12.1.1778007245660; Tue, 05 May 2026 11:54:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429012819.3102675-1-hramamurthy@google.com>
 <20260429012819.3102675-4-hramamurthy@google.com> <6259cf59-b054-42bb-9dad-5f62a54a2bc0@redhat.com>
 <CA+mzVttNJ5ka5msxOtR1_wzt47FYUbO=yejNDTLef7PwVe9sMA@mail.gmail.com>
In-Reply-To: <CA+mzVttNJ5ka5msxOtR1_wzt47FYUbO=yejNDTLef7PwVe9sMA@mail.gmail.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Tue, 5 May 2026 11:53:54 -0700
X-Gm-Features: AVHnY4KnBEpUs0SNIzRFB1xmfscEMT-eK-CjBTDVcXk9lN7C-wZdQcsEo4b_JiE
Message-ID: <CA+mzVtui1trF8MzR9tf6MnPJZULu-gpTT=vMmwp2+q3tTriGjg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/3] gve: implement PTP gettimex64
To: Paolo Abeni <pabeni@redhat.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, richardcochran@gmail.com, jstultz@google.com, 
	tglx@kernel.org, sboyd@kernel.org, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AE4574D2E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,gmail.com,oracle.com,infradead.org,intel.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 11:22=E2=80=AFAM Jordan Rhee <jordanrhee@google.com>=
 wrote:
>
> On Tue, May 5, 2026 at 1:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 4/29/26 3:28 AM, Harshitha Ramamurthy wrote:
> > > From: Jordan Rhee <jordanrhee@google.com>
> > >
> > > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> > >
> > > The system cycle counters are sampled by the device to minimize the
> > > uncertainty window. If the system times are sampled in the host, the
> > > delta between pre and post readings is 100us or more due to AQ comman=
d
> > > latency. The system times returned by the device have a delta of ~1us=
,
> > > which enables significantly more accurate clock synchronization.
> > >
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > Reviewed-by: Kevin Yang <yyd@google.com>
> > > Reviewed-by: Naman Gulati <namangulati@google.com>
> > > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > ---
> > > Changes in v5:
> > > - Reformulate retry loop in terms of total timeout (Jakub Kicinski)
> > >
> > > Changes in v3:
> > > - Take system time snapshot inside the mutex
> > > - Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
> > >   than x86 or arm64
> > >
> > > Changes in v2:
> > >  - fix compilation warning on ARM by casting cycles_t to u64
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
> > >  drivers/net/ethernet/google/gve/gve_ptp.c    | 196 +++++++++++++++++=
+-
> > >  2 files changed, 191 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/n=
et/ethernet/google/gve/gve_adminq.h
> > > index 22a74b6aa17e..e6dcf6da9091 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> > > +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> > > @@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic=
_ts) =3D=3D 16);
> > >
> > >  struct gve_nic_ts_report {
> > >       __be64 nic_timestamp; /* NIC clock in nanoseconds */
> > > -     __be64 reserved1;
> > > -     __be64 reserved2;
> > > +     __be64 pre_cycles; /* System cycle counter before NIC clock rea=
d */
> > > +     __be64 post_cycles; /* System cycle counter after NIC clock rea=
d */
> > >       __be64 reserved3;
> > >       __be64 reserved4;
> > >  };
> > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/=
ethernet/google/gve/gve_ptp.c
> > > index ad15f1209a83..c6c98ef825aa 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > @@ -10,28 +10,210 @@
> > >  /* Interval to schedule a nic timestamp calibration, 250ms. */
> > >  #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
> > >
> > > +/*
> > > + * Stores cycle counter samples in get_cycles() units from a
> > > + * sandwiched NIC clock read
> > > + */
> > > +struct gve_sysclock_sample {
> > > +     /* system time snapshot taken just before issuing AdminQ comman=
d */
> > > +     struct system_time_snapshot snapshot;
> > > +     /* Cycle counter from NIC before clock read */
> > > +     u64 nic_pre_cycles;
> > > +     /* Cycle counter from NIC after clock read */
> > > +     u64 nic_post_cycles;
> > > +     /* Cycle counter from host before issuing AQ command */
> > > +     cycles_t host_pre_cycles;
> > > +     /* Cycle counter from host after AQ command returns */
> > > +     cycles_t host_post_cycles;
> > > +};
> > > +
> > > +/*
> > > + * Read NIC clock by issuing the AQ command. The command is subject =
to
> > > + * rate limiting and may need to be retried. Requires nic_ts_read_lo=
ck
> > > + * to be held.
> > > + */
> > > +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre=
_cycles,
> > > +                               cycles_t *post_cycles,
> > > +                               struct system_time_snapshot *snap)
> > > +{
> > > +     unsigned long deadline =3D jiffies + msecs_to_jiffies(100);
> > > +     unsigned long delay_us =3D 1000;
> > > +     int err;
> > > +
> > > +     lockdep_assert_held(&ptp->nic_ts_read_lock);
> > > +
> > > +     do {
> > > +             if (snap)
> > > +                     ktime_get_snapshot(snap);
> > > +
> > > +             *pre_cycles =3D get_cycles();
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
> > > -     err =3D gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_=
bus);
> > > -     if (err)
> > > +     err =3D gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_pos=
t_cycles,
> > > +                                  sysclock ? &sysclock->snapshot : N=
ULL);
> > > +     if (err) {
> > > +             dev_err_ratelimited(&ptp->priv->pdev->dev,
> > > +                                 "AdminQ timestamp read failed: %d\n=
", err);
> > >               goto out;
> > > +     }
> > >
> > > -     *nic_raw =3D be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
> > > +     ts_report =3D ptp->nic_ts_report;
> > > +     *nic_raw =3D be64_to_cpu(ts_report->nic_timestamp);
> > > +
> > > +     if (sysclock) {
> > > +             sysclock->nic_pre_cycles =3D be64_to_cpu(ts_report->pre=
_cycles);
> > > +             sysclock->nic_post_cycles =3D be64_to_cpu(ts_report->po=
st_cycles);
> > > +             sysclock->host_pre_cycles =3D host_pre_cycles;
> > > +             sysclock->host_post_cycles =3D host_post_cycles;
> > > +     }
> > >
> > >  out:
> > >       mutex_unlock(&ptp->nic_ts_read_lock);
> > >       return err;
> > >  }
> > >
> > > +struct gve_cycles_to_clock_callback_ctx {
> > > +     u64 cycles;
> > > +};
> > > +
> > > +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> > > +                               struct system_counterval_t *system_co=
unterval,
> > > +                               void *ctx)
> > > +{
> > > +     struct gve_cycles_to_clock_callback_ctx *context =3D ctx;
> > > +
> > > +     *device_time =3D 0;
> > > +
> > > +     system_counterval->cycles =3D context->cycles;
> > > +     system_counterval->use_nsecs =3D false;
> > > +
> > > +     if (IS_ENABLED(CONFIG_X86))
> > > +             system_counterval->cs_id =3D CSID_X86_TSC;
> > > +     else if (IS_ENABLED(CONFIG_ARM64))
> > > +             system_counterval->cs_id =3D CSID_ARM_ARCH_COUNTER;
> > > +     else
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/*
> > > + * Convert a raw cycle count (e.g. from get_cycles()) to the system =
clock
> > > + * type specified by clockid. The system_time_snapshot must be taken=
 before
> > > + * the cycle counter is sampled.
> > > + */
> > > +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t=
 clockid,
> > > +                                 struct system_time_snapshot *snap,
> > > +                                 u64 cycles, struct timespec64 *ts)
> > > +{
> > > +     struct gve_cycles_to_clock_callback_ctx ctx =3D {0};
> > > +     struct system_device_crosststamp xtstamp;
> > > +     int err;
> > > +
> > > +     ctx.cycles =3D cycles;
> > > +     err =3D get_device_system_crosststamp(gve_cycles_to_clock_fn, &=
ctx, snap,
> > > +                                         &xtstamp);
> > > +     if (err) {
> > > +             dev_err_ratelimited(&priv->pdev->dev,
> > > +                                 "get_device_system_crosststamp() fa=
iled to convert %lld cycles to system time: %d\n",
> > > +                                 cycles,
> > > +                                 err);
> > > +             return err;
> > > +     }
> > > +
> > > +     switch (clockid) {
> > > +     case CLOCK_REALTIME:
> > > +             *ts =3D ktime_to_timespec64(xtstamp.sys_realtime);
> > > +             break;
> > > +     case CLOCK_MONOTONIC_RAW:
> > > +             *ts =3D ktime_to_timespec64(xtstamp.sys_monoraw);
> > > +             break;
> > > +     default:
> > > +             dev_err_ratelimited(&priv->pdev->dev,
> > > +                                 "Cycle count conversion to clockid =
%d not supported\n",
> > > +                                 clockid);
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > >                             struct timespec64 *ts,
> > >                             struct ptp_system_timestamp *sts)
> > >  {
> > > -     return -EOPNOTSUPP;
> > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info=
);
> > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > +     struct gve_priv *priv =3D ptp->priv;
> > > +     u64 nic_ts;
> > > +     int err;
> > > +
> > > +     if (sts && !(IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_ARM64)=
))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     err =3D gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : N=
ULL);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     if (sts) {
> > > +             /* Reject samples with out of order system clock values=
 */
> > > +             if (!(sysclock.host_pre_cycles <=3D sysclock.nic_pre_cy=
cles &&
> > > +                   sysclock.nic_pre_cycles  <=3D sysclock.nic_post_c=
ycles &&
> > > +                   sysclock.nic_post_cycles <=3D sysclock.host_post_=
cycles)) {
> > > +                     dev_err_ratelimited(&priv->pdev->dev,
> > > +                                         "AdminQ system clock cycle =
counts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> > > +                                         (u64)sysclock.host_pre_cycl=
es,
> > > +                                         sysclock.nic_pre_cycles,
> > > +                                         sysclock.nic_post_cycles,
> > > +                                         (u64)sysclock.host_post_cyc=
les);
> > > +                     return -EBADMSG;
> >
> > Sashiko/gemini is reporting the following:
> >
> > ---
> > If older firmware does not support this feature and returns 0 for the
> > pre_cycles and post_cycles fields, won't host_pre_cycles <=3D
> > nic_pre_cycles evaluate to false since get_cycles() will be greater tha=
n
> > 0? If this occurs, the driver returns -EBADMSG instead of -EOPNOTSUPP.
> > Does returning -EBADMSG prevent userspace tools from gracefully falling
> > back to legacy PTP ioctls like PTP_SYS_OFFSET, causing PTP
> > synchronization to fail completely on older firmwares?
> > ---
> >
> > which looks legit to me, or am I missing something? Note that
> > proactively triaging sashiko comments would help maintainers a lot.
> >
> > Thanks,
> >
> > Paolo
> >
>
> Hi Paolo, my apologies for not addressing this proactively.
>
> Firmware is not allowed to return 0 for pre/post cycles. This would
> violate the API contract, so returning failure is the appropriate
> response.
>
> The kernel PTP stack has no special handling for EBADMSG vs
> EOPNOTSUPP, and neither does Chrony
> (https://github.com/mlichvar/chrony/blob/866bedef0b648fdd6cc68f8cb4d75e43=
03244c76/sys_linux.c#L959).
> Returning EOPNOTSUPP instead of EBADMSG would not change the behavior
> of upper layers.
>
> > > +
> > > + err =3D gve_cycles_to_timespec64(priv, sts->clockid,
> > > +        &sysclock.snapshot,
> > > +        sysclock.nic_pre_cycles,
> > > +        &sts->pre_ts);
> > > + if (err)
> > > + return err;
> >
> > Sashiko writes:
> >
> > Looking at gve_cycles_to_timespec64(), it relies on
> > get_device_system_crosststamp() which hardcodes the clocksource to
> > CSID_X86_TSC or CSID_ARM_ARCH_COUNTER.
> >
> > If the guest timekeeper clocksource is something else, such as kvm-cloc=
k,
> > get_device_system_crosststamp() will return -ENODEV which is propagated=
 here.
> >
> > Since userspace generally only falls back to legacy PTP ioctls when rec=
eiving
> > -EOPNOTSUPP or -ENOTTY, will returning -ENODEV cause the extended ioctl=
 to
> > fatally fail and break synchronization? Should we intercept these error=
s and
> > return -EOPNOTSUPP instead to preserve the fallback behavior?
>
> The system clocksource returned by the callback does not need to match
> the current system clocksource. get_device_system_crosststamp()
> converts the supplied value to the system clocksource using
> convert_base_to_cs(). I've validated that cross-timestamp still works
> when system clocksource is kvm-clock:

This is incorrect, there was a mistake in my testing.
get_device_system_crosststamp() fails if the clocksource is not TSC. I
will ensure there is a fallback to
ptp_read_system_prets()/ptp_read_system_postts() if the system clock
source is not TSC or ARM_ARCH_COUNTER.

>
> $ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> tsc
> $ cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> tsc kvm-clock acpi_pm
> $ echo "kvm-clock" | sudo tee
> /sys/devices/system/clocksource/clocksource0/current_clocksource
> kvm-clock
> $ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> kvm-clock
> $ sudo systemctl start chrony
> $ chronyc tracking
> Reference ID    : 50484330 (PHC0)
> Stratum         : 1
> Ref time (UTC)  : Tue May 05 18:18:20 2026
> System time     : 0.000000703 seconds fast of NTP time
> Last offset     : +0.000001757 seconds
> RMS offset      : 0.000004796 seconds
> Frequency       : 0.164 ppm fast
> Residual freq   : +0.046 ppm
> Skew            : 3.106 ppm
> Root delay      : 0.000000001 seconds
> Root dispersion : 0.000013117 seconds
> Update interval : 0.5 seconds
> Leap status     : Normal

