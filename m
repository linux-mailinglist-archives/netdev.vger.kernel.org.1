Return-Path: <netdev+bounces-273726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LfaKn8OzGmHNwYAu9opvQ
	(envelope-from <netdev+bounces-273726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 408A536FC89
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F893139815
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85744CF5A;
	Tue, 31 Mar 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaqMVD/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6844CF4A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980357; cv=pass; b=h5VIdXdIJqhpJ3SjbPKy1mNI2kQ/CaxTxEeMSaerw+IVK/ST7Avp+dRJkCMEhY2DXm4j7iXkQ20xbo1ddxBVJNQoi9gHhbdTTLBNB6csbQdM98QYYK8AWEqsLTPZmFN7w8r0HR2hQglXbwCAZmw+fctiIYtrJDfrX4QPwmaN7vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980357; c=relaxed/simple;
	bh=X9AhKdM4i7suQh+q6OLHgCSpOn9AwzCNOJSkiGtwx6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNYZll55W3BOn8uWnm3VMtXBvMFy7wZcS65AkIz2kcrcBF7ow7PTkvQ2zdm+QREOT+hkNAPWAxk5rEW+xkMv9v4R24RAaznaBRrWtSOROVs7soj4G8O2jf9SEwaN/yZAW/6nmSxvMWXE8GGnN+5/EQpvO7UjDYl61dm2VnOQphY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaqMVD/V; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509062d829dso675641cf.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 11:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774980351; cv=none;
        d=google.com; s=arc-20240605;
        b=JbK9c2XJ7VsAVBR3MZjE1FPn4j+eyBFrrySic50X9PgYiAlF9TI5PS+HZYH6R0N53K
         TV7VE9WPx6hCZiAOfvbLMWtYrxSh3IHaSxV3/FswEksUp1JTueW9cSjeb7bJdWDyO1st
         QSYeK2TLwoeDdMh7b+R/cxTjOs++RWNqKK60rNmk/tpLXfBR+R04FlLBucqigKgjgvGw
         7R7CUNgfE9W51LZxsY0pKvzO6xd2cgb92T/6BmtgT/xXZ1S+kpOig4G6Xz750ULtcS4p
         jCVJhHqHrNsVZRSXGpImvVBMN044CB9/HPiiQ7zlbGZkyV/3JqKCSjg9JN5wkMr+w9vW
         CT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIIkSbqfs4xz9nI08KqRdIs/QdZhfMRuh2N9qlqnF3Q=;
        fh=epi+SLLQgnmfz6CTHjK4VBSsSIYfzdG3HGZCHj4Hm1k=;
        b=SROyvEA2doQGT6RtQ8IL0g4uEEU8x5l8/Nr74OVuAwWbvA3E1Nul2JluGcZ6ebcAH/
         f6P8P1rbScTwoQUmhrDVdlZgF4L61sTbKAhdVSi+ar+RqwRsEpJe5Rd7F/UYmDopv5/1
         jqdAnl7/3i4J3ifxt4IEG0izFM41Grdv5/CLeoBi2sVOMcPz6rETyBM2EuLcgTecb9fJ
         aw8KIEhBGA/2P+Iu86JYzKM32RZfptpc+k/M6OK5w3C61NoNTIA9H6lipANuAfXrAxm8
         FEN/ly3uro6VpZBa+CM4f9wUGYuKdu9r/mMRy5nl9JVcNWyVY05hJD+b2Cmu5Ir7NB8f
         Zb4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774980351; x=1775585151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIIkSbqfs4xz9nI08KqRdIs/QdZhfMRuh2N9qlqnF3Q=;
        b=FaqMVD/VZ8OxN9icKtV8Ma1bONIaKdjUgvTwxW+uzhn3UHH1GAjD+4qbHr3dCvV4DB
         OIeTaL/jyF5u92WMd1Rxzn3/YSBgA29RhY2rJpGQsN3mSFOYRV2IFaB7k9dbdBn/75fT
         5NPSxfhpw9xE3UzDMFlozeOj7IXiQofz/1BQuN6FoKw/U64xOTRNzTiGnQ7wi2Ei3E4y
         eHKacSIGJ4WXThn+Rmo+AD6TjOTBBesC9qWPM1Yw7STvXXiYdIISnAUuuBoT53YA/++M
         d8wJaII1W4C28Qifol+jnSMqBrm3GfLOA0alfoN/bBlS9loxHFfsD/6v6CcrJquDQCJP
         u4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980351; x=1775585151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIIkSbqfs4xz9nI08KqRdIs/QdZhfMRuh2N9qlqnF3Q=;
        b=q3xhic2JE288QXauMcZo7LvtEUcMptxMRAPyRYiD5Q4h3qpSTBwEIbgLOyLORpz1ow
         8UhwyN7DXyjIJUe12AsWJXS63VCPAAehAF0bvRO5ScptIrGq0F4srfGX78XbBbbS3RbP
         kiE9R5BZ97Mz/3kvBrZB5KquX6lof8V4XVhi7YWeSBcAix0+6xXkahS0Y3nKRcbExPky
         2Apl4NlF/9+CvD5fDSiX2up8iMPw3ATA3fjtiN3Heak73E+YDad2t1UtKw3kBFiDQWXv
         0E8/SqFlvbqf8gAMLbjscuSHTm61eWitCoimuafmbazHmw9N1RcuTThbScnZkbs9KXZZ
         zXCw==
X-Forwarded-Encrypted: i=1; AJvYcCW0UVfwNbV5IasbwVaaYxfYRZxJi5WhM6YqGPAVKRTo4JNgumACAIXSzLpV/1vaSFzf80lpcs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDd2BowsEYdf7QxpHnnyxj4rbxU1jRAyHAW87Y21tjMKNoPYqK
	49cP1aAovTAXCVHmTuDe9Q6ZLjuRsYlso8USTweIDyYgJYpv6lH/sNSmSqZf4dP2xYAaTqKa9sd
	ekCz9C5YrTKEdVZAv1Tx+1uWkKruGLPAL308YURFM
X-Gm-Gg: ATEYQzxJ/Ycn6bOByjwlxWiHo9ojwZ6zcIt+i22IWy7Emlz95LDKoJ7O8DEghWFKfCK
	wiky2cooSB+twJfwNPsVRA1p4NJZBrz+PjxEiO86OZ18w3KdTGeNuF5nbIsx3p2HWfutlQG1sxZ
	1A9s1p6zQa2C4U2mFHjtf1ejlPP+STS3r9Z7rwDsU0IeIaFnkVHDBu62HR3MbKF5u30bE+izcAs
	nKzjQ6dxZOxV9nnBXjQKhythkVOcWLdvbJf0UWW51UPlxvp9wy67SmvHUEHboDAa5K6xrPDhrBl
	powIp+j8bupzyxtcMhwoY3/OsehqsYaOpnIy
X-Received: by 2002:a05:622a:94:b0:50b:beac:df1 with SMTP id
 d75a77b69052e-50d3b8dc5fdmr2875451cf.16.1774980349999; Tue, 31 Mar 2026
 11:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com>
 <20260329212002.2875815-1-kuba@kernel.org> <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
In-Reply-To: <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 31 Mar 2026 11:05:38 -0700
X-Gm-Features: AQROBzA8k8AwwFsrDK7D1euMezcHxvGKsEPkSWaBKYu41pPLEelDf5Q_ZS35ub0
Message-ID: <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
To: Jordan Rhee <jordanrhee@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, hramamurthy@google.com, netdev@vger.kernel.org, 
	joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namangulati@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 408A536FC89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 9:31=E2=80=AFPM Jordan Rhee <jordanrhee@google.com>=
 wrote:
>
> On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > Subject: gve: implement PTP gettimex64
> >
> > This commit implements the PTP gettimex64 function to enable chrony and
> > phc2sys to synchronize the system clock to the NIC clock. It reads the
> > NIC timestamp along with pre and post system cycle counters to minimize
> > the uncertainty window.
> >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/=
ethernet/google/gve/gve_ptp.c
> > > index 140b8fbce4f4..bea794541f30 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > @@ -10,28 +10,203 @@
> >
> > [ ... ]
> >
> > > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > > +                                  cycles_t *pre_cycles,
> > > +                                  cycles_t *post_cycles)
> > > +{
> > > +     unsigned long delay_us =3D 1000;
> > > +     int retry_count =3D 0;
> > > +     int err;
> > > +
> > > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > > +
> > > +     do {
> > > +             *pre_cycles =3D get_cycles();
> > > +             err =3D gve_adminq_report_nic_ts(priv, priv->nic_ts_rep=
ort_bus);
> > > +
> > > +             /* Ensure cycle counter is sampled after AdminQ cmd ret=
urns */
> > > +             rmb();
> > > +             *post_cycles =3D get_cycles();
> >
> > Are execution barriers needed around get_cycles() here? rmb() orders
> > memory accesses, but the CPU might still speculatively execute the cycl=
e
> > counter reads out of order with respect to the AdminQ commands.
> >
> > Could this speculative reordering cause the strict bounds validation in
> > gve_ptp_gettimex64() to fail spuriously?
>
> I will add mb() barriers to be totally safe.

I'm not so sure that rmb() is insufficient here. In x86_64 rmb() is an
lfence. lfence is used to prevent speculative execution (per the x86
barrier_nospec implementation) and rdtsc_ordered, which is called by
the ktime* helpers, also prefaces rdtsc with an lfence. On ARM the
get_cycles implementation adds an isb instruction before reading
cntvct_el0.


>
> > [ ... ]
> >
> > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > >                             struct timespec64 *ts,
> > >                             struct ptp_system_timestamp *sts)
> > >  {
> > > -     return -EOPNOTSUPP;
> > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info=
);
> > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > +     struct gve_priv *priv =3D ptp->priv;
> > > +     struct system_time_snapshot snap;
> > > +     u64 nic_ts;
> > > +     int err;
> > > +
> > > +     /* Take system clock snapshot before sampling cycle counters */
> > > +     if (sts)
> > > +             ktime_get_snapshot(&snap);
> > > +
> > > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
> >
> > Could the system time snapshot become stale here?
> >
> > If priv->nic_ts_read_lock is contended, or if gve_adminq_read_timestamp=
()
> > retries and sleeps, the snapshot might be taken significantly before th=
e
> > actual hardware read.
> >
> > Would it be more accurate to take the snapshot immediately before readi=
ng the
> > hardware, inside the mutex?
>
> Ack, will fix.
>
> >
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
> > How does this behave on architectures where get_cycles() is not impleme=
nted
> > and returns 0, or with older firmware that leaves nic_pre_cycles and
> > nic_post_cycles as 0?
>
> Firmware is not allowed to return 0. 0 should trigger the check.
>
> > It looks like the bounds check would unconditionally fail and return -E=
BADMSG.
> > Since userspace tools like chrony usually expect -EOPNOTSUPP for unsupp=
orted
> > extended ioctls to fall back to basic PTP ioctls, will returning -EBADM=
SG
> > cause a hard failure for clock synchronization?
>
> Will fix. GVE is only supported on x86_64 and arm64, and will fail on
> other architectures with -EOPNOTSUPP due to the check in
> gve_cycles_to_clock_fn(). However, if an architecture returns
> get_cycles() as 0, it will fail here first with -EBADMSG. I will add
> an explicit check for x86 || arm64 earlier in this function.
>
> >
> > [ ... ]
> >
> > > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> > >               goto release_ptp;
> > >       }
> > >       mutex_init(&priv->nic_ts_read_lock);
> > > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> > >       if (err) {
> > >               dev_err(&priv->pdev->dev, "failed to read NIC clock %d\=
n", err);
> > >               goto release_nic_ts_report;
> >
> > Is there a race condition exposing the PTP device to userspace before i=
ts
> > resources are fully initialized?
> >
> > Looking at gve_init_clock(), gve_ptp_init() is called before allocating
> > nic_ts_report and initializing nic_ts_read_lock:
> >
> >     err =3D gve_ptp_init(priv);
> >     if (err)
> >         return err;
> >
> >     priv->nic_ts_report =3D dma_alloc_coherent(...);
> >     ...
> >     mutex_init(&priv->nic_ts_read_lock);
> >
> > If a concurrent userspace process immediately invokes the
> > PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the /dev/p=
tpX
> > device, could it call gve_ptp_gettimex64() and attempt to lock the
> > uninitialized mutex or dereference the NULL nic_ts_report pointer?
> >
> > Additionally, in the error path for gve_init_clock():
> >
> >     release_nic_ts_report:
> >         mutex_destroy(&priv->nic_ts_read_lock);
> >         dma_free_coherent(...);
> >         priv->nic_ts_report =3D NULL;
> >     release_ptp:
> >         gve_ptp_release(priv);
> >
> > Could destroying the mutex and freeing the memory before gve_ptp_releas=
e()
> > create a use-after-free window if an ioctl is currently running?
>
> Will be fixed in the previous patch in the series.

