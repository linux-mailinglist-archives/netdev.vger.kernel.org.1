Return-Path: <netdev+bounces-274601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEf6Fu+NzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D438B589
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4F9301AB88
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EF34DCE6;
	Thu,  2 Apr 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsOB4Xpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DC2D9ECB
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144305; cv=pass; b=oLgUYA0aQZyNUZkJFMKDXfCkDctGVpU/eorQl1Fu3C1ctlWw5lAuw+HbWj95ckVQDqjp6TPFPwZLMH/7zL61/fKDEwyyriateRSaEJqaco44yH1qEO0dy9SZT+T8DfqwDF+9FTd014Grhf3zHFpf5YHoQ4/2UjMGo/EfU5DHaVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144305; c=relaxed/simple;
	bh=8ZtGy874vjgppYvW3SX8dQvNFvBnbw2e8vSZzO8Pgps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsr/s7w/3LCWr+veIikWE53jJpffqeBvdTw0dyT6SuRUVc9RNarJge1mcC6hWN9OH5s+U9kc0SQefsHT6YDto65MSn99M7Z7gIEFFGtXyNnhVqMnWmh45bdtYNSsAH9GxYaW0tkviEXhg2f5B01+Obq0KO0ymkqwJl5DpD5kybA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsOB4Xpu; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so10838a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775144303; cv=none;
        d=google.com; s=arc-20240605;
        b=JRYBsRWhZ3DIs8/OlRWAAG8f5/ZQ1Ng6Ti2SwAaZCE1z8uecdFwLHmsiWshjpS6OQF
         o5vx17+n3Y40nXlCpx4lVMNztp1n7M3Cj0bq9Md5JiYgtX9iByOuRqIF8g6SEosNUUPj
         sSKm/zHdBarWOOs9+9mncjgiY4UArVWvoQ3Q7LuoVue+7A4uAUxM/272hCq2X5m/EdNJ
         x0atZ4DgqfWjFZa0fT8TWhEF9lGLUKikt7CAyLD6LoQ92w0c3HAY2pkKiT+fqetUtcPS
         3g7+FLJlAb3RdfyN1V6XqDN/NycIIkWV3O4K86RK1WxBKDiYL+bLnUzvLTaiLbW7dbDN
         nJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lnCBop1teWNxRcQuL75vbJuQI5Jq0L8beyHxiI8hffE=;
        fh=4iwRy7I/O/FAb4XQVk5uzN6pcT3C0aQM5SfHohshkNk=;
        b=g4FupDJdMyGX0d4zbuOJdBPc7CXjOkX45IWePqj6oT5zDjRQZQMYKifDFeZrbbnW1c
         q6LEKLodmODUzsrj36xueASLI2KetygCb4hkhICSFbW9NUvzF5D2Vcuxd7HlFVGOclsS
         yh1mQCOK/m1o/BnXGwb+DIw76AfqMK894f6iZMgrtT5iYhagpnjQiRL5mJMWFnqezVi7
         hGVvG1sAGszUSvoFhasAh0rExCwydZxoIg0X9AJLs4SOARV6elYEFTqoDws+WtzBzWCa
         EtHp+BOJ9D3CDmfptdPudnlpINDJgNIVhSLzdqEbfMuFpmF80s9CM4IJU6Xq2iFMqlIO
         X2YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775144303; x=1775749103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnCBop1teWNxRcQuL75vbJuQI5Jq0L8beyHxiI8hffE=;
        b=PsOB4XpueFSpzI/wDW8M94iGNkYoFFxtOfgUTskHNK7sNp3GRVFJsX10+luAk18HSj
         /zcDeKg4S2RDffJ03fWMasx4uKVvYu8Iu8nqSuMjxA4tqp7BS8W721OgTSljyKDkGCiN
         vUURNiEYMcd7H0ptYnlvLmJcPjlgjFasvW2MeJTShIx5qwb7sD2nQk2+AVKavs1VPJ6G
         GVPyneEvCpsyt4i7JMeHE223UZawNSZNFxV9nsKH8cWpVSc16bWDfYWgaiblzMuv/2b6
         VQ0kfcJQEYcTyhSqRIYFODcLCDn9op5NtoMveRYa95RiwJDEBHUsAQ+2DR8HS/WBxWJE
         lHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144303; x=1775749103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lnCBop1teWNxRcQuL75vbJuQI5Jq0L8beyHxiI8hffE=;
        b=NVuAf5ClEC7c8WqPhabF4feUbVU3SMjU74cPGFoVTG2ZnYz/aOLUuPxkv87R5OSFMT
         AnOkx24TDWY6DsMJjCcTe64T2tsvGXssba1krz1plsea19CPQw31OMq18hruWxFI4P5H
         h7/cb9kc4f0grlfJj8uqiHJ4bTm6S0HSt2HTQ7hjvsrtoY0rKHpQaX8aRN13emqXXbKf
         X8t8zUwWMZ37kf1P2XztWnJupAWmfNm5EFLttmTWlZkg8ECtkDIoti9EXzA+Iqg248Nr
         WUq92IyJVjII5/RGVJtLroBdM6j4u5vpja5kxI6sy8S8dZTpnGQ2F8RtzbWcRer57j2b
         onSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMFW7JSxq25tzumoI2c6UtY2hZTqGk7QEk8VvILDWhdtaConwmhSlenS6tQxPFn8dJ0Hit00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24IApG2meUZOKJxSzCXdb1ZkXGNTixvWFolWtKvZQKKHN8FFE
	2JJMoYyA0E4TW1Nm4fLF7Q4lV0KuTR/ZxkVkvxqQKVRHAnTadx6CpWuVu6fespiG8fMvLLseSnO
	hVxDFKKlXfV9OAPz/PeKP2TtIxCA+UL0oTXGcMxvI
X-Gm-Gg: ATEYQzzTJvhNXkgfmU8csy0icthZTTUoOOypUx6QmhNNU+2+VwcRfb3zYS+5Rie3ovF
	ik6SK56pJI+XFjz2sFQUXCXk36RLekE+QCB7JPdsEsa8vihUY2E5KgfhPQ5VT6Z/ctvgOPf70HK
	rhHGkpia9799/LfHtUSL4FCZVVcuXd3Ngeh1u1QJ1S1EG+al5tWJESR/TgP8rX3IueosxDYM2bs
	eCI9aj/WHDDztks2BaFO4A2T0x2nIcxaOwavftFlOskB7oGJ8XgceLrPI6QDK3qNUG2H64imaIm
	uGOgQWyC8CfEzs02iSBi34qyjbjrQG2DcXTOtQ==
X-Received: by 2002:a05:6402:4601:10b0:665:d39:4afc with SMTP id
 4fb4d7f45d1cf-66e08300257mr29341a12.6.1775144302300; Thu, 02 Apr 2026
 08:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com>
 <20260329212002.2875815-1-kuba@kernel.org> <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
 <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com>
In-Reply-To: <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Thu, 2 Apr 2026 08:38:10 -0700
X-Gm-Features: AQROBzB_rWy3znwwqLDiWXl-uzQWtWRlQYTvM5oLvi65l8v_yQPIONrU-hujofM
Message-ID: <CA+mzVtv-91ru7v6GxOS80xihE4ZbwGqdyQdKPTHv+woKaeOhuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
To: Naman Gulati <namangulati@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B48D438B589
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We know that gve_adminq_report_nic_ts() will cause a VM exit, which
will act as a full barrier. Additional barriers are not strictly
necessary from a functional perspective. Can we rely on this fact or
do we need explicit barriers?


On Tue, Mar 31, 2026 at 11:05=E2=80=AFAM Naman Gulati <namangulati@google.c=
om> wrote:
>
> On Sun, Mar 29, 2026 at 9:31=E2=80=AFPM Jordan Rhee <jordanrhee@google.co=
m> wrote:
> >
> > On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > ---
> > > Subject: gve: implement PTP gettimex64
> > >
> > > This commit implements the PTP gettimex64 function to enable chrony a=
nd
> > > phc2sys to synchronize the system clock to the NIC clock. It reads th=
e
> > > NIC timestamp along with pre and post system cycle counters to minimi=
ze
> > > the uncertainty window.
> > >
> > > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/ne=
t/ethernet/google/gve/gve_ptp.c
> > > > index 140b8fbce4f4..bea794541f30 100644
> > > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > @@ -10,28 +10,203 @@
> > >
> > > [ ... ]
> > >
> > > > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > > > +                                  cycles_t *pre_cycles,
> > > > +                                  cycles_t *post_cycles)
> > > > +{
> > > > +     unsigned long delay_us =3D 1000;
> > > > +     int retry_count =3D 0;
> > > > +     int err;
> > > > +
> > > > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > > > +
> > > > +     do {
> > > > +             *pre_cycles =3D get_cycles();
> > > > +             err =3D gve_adminq_report_nic_ts(priv, priv->nic_ts_r=
eport_bus);
> > > > +
> > > > +             /* Ensure cycle counter is sampled after AdminQ cmd r=
eturns */
> > > > +             rmb();
> > > > +             *post_cycles =3D get_cycles();
> > >
> > > Are execution barriers needed around get_cycles() here? rmb() orders
> > > memory accesses, but the CPU might still speculatively execute the cy=
cle
> > > counter reads out of order with respect to the AdminQ commands.
> > >
> > > Could this speculative reordering cause the strict bounds validation =
in
> > > gve_ptp_gettimex64() to fail spuriously?
> >
> > I will add mb() barriers to be totally safe.
>
> I'm not so sure that rmb() is insufficient here. In x86_64 rmb() is an
> lfence. lfence is used to prevent speculative execution (per the x86
> barrier_nospec implementation) and rdtsc_ordered, which is called by
> the ktime* helpers, also prefaces rdtsc with an lfence. On ARM the
> get_cycles implementation adds an isb instruction before reading
> cntvct_el0.
>
>
> >
> > > [ ... ]
> > >
> > > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > > >                             struct timespec64 *ts,
> > > >                             struct ptp_system_timestamp *sts)
> > > >  {
> > > > -     return -EOPNOTSUPP;
> > > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, in=
fo);
> > > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > > +     struct gve_priv *priv =3D ptp->priv;
> > > > +     struct system_time_snapshot snap;
> > > > +     u64 nic_ts;
> > > > +     int err;
> > > > +
> > > > +     /* Take system clock snapshot before sampling cycle counters =
*/
> > > > +     if (sts)
> > > > +             ktime_get_snapshot(&snap);
> > > > +
> > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
> > >
> > > Could the system time snapshot become stale here?
> > >
> > > If priv->nic_ts_read_lock is contended, or if gve_adminq_read_timesta=
mp()
> > > retries and sleeps, the snapshot might be taken significantly before =
the
> > > actual hardware read.
> > >
> > > Would it be more accurate to take the snapshot immediately before rea=
ding the
> > > hardware, inside the mutex?
> >
> > Ack, will fix.
> >
> > >
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     if (sts) {
> > > > +             /* Reject samples with out of order system clock valu=
es */
> > > > +             if (!(sysclock.host_pre_cycles <=3D sysclock.nic_pre_=
cycles &&
> > > > +                   sysclock.nic_pre_cycles  <=3D sysclock.nic_post=
_cycles &&
> > > > +                   sysclock.nic_post_cycles <=3D sysclock.host_pos=
t_cycles)) {
> > > > +                     dev_err_ratelimited(&priv->pdev->dev,
> > > > +                                         "AdminQ system clock cycl=
e counts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> > > > +                                         (u64)sysclock.host_pre_cy=
cles,
> > > > +                                         sysclock.nic_pre_cycles,
> > > > +                                         sysclock.nic_post_cycles,
> > > > +                                         (u64)sysclock.host_post_c=
ycles);
> > > > +                     return -EBADMSG;
> > >
> > > How does this behave on architectures where get_cycles() is not imple=
mented
> > > and returns 0, or with older firmware that leaves nic_pre_cycles and
> > > nic_post_cycles as 0?
> >
> > Firmware is not allowed to return 0. 0 should trigger the check.
> >
> > > It looks like the bounds check would unconditionally fail and return =
-EBADMSG.
> > > Since userspace tools like chrony usually expect -EOPNOTSUPP for unsu=
pported
> > > extended ioctls to fall back to basic PTP ioctls, will returning -EBA=
DMSG
> > > cause a hard failure for clock synchronization?
> >
> > Will fix. GVE is only supported on x86_64 and arm64, and will fail on
> > other architectures with -EOPNOTSUPP due to the check in
> > gve_cycles_to_clock_fn(). However, if an architecture returns
> > get_cycles() as 0, it will fail here first with -EBADMSG. I will add
> > an explicit check for x86 || arm64 earlier in this function.
> >
> > >
> > > [ ... ]
> > >
> > > > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> > > >               goto release_ptp;
> > > >       }
> > > >       mutex_init(&priv->nic_ts_read_lock);
> > > > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> > > >       if (err) {
> > > >               dev_err(&priv->pdev->dev, "failed to read NIC clock %=
d\n", err);
> > > >               goto release_nic_ts_report;
> > >
> > > Is there a race condition exposing the PTP device to userspace before=
 its
> > > resources are fully initialized?
> > >
> > > Looking at gve_init_clock(), gve_ptp_init() is called before allocati=
ng
> > > nic_ts_report and initializing nic_ts_read_lock:
> > >
> > >     err =3D gve_ptp_init(priv);
> > >     if (err)
> > >         return err;
> > >
> > >     priv->nic_ts_report =3D dma_alloc_coherent(...);
> > >     ...
> > >     mutex_init(&priv->nic_ts_read_lock);
> > >
> > > If a concurrent userspace process immediately invokes the
> > > PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the /dev=
/ptpX
> > > device, could it call gve_ptp_gettimex64() and attempt to lock the
> > > uninitialized mutex or dereference the NULL nic_ts_report pointer?
> > >
> > > Additionally, in the error path for gve_init_clock():
> > >
> > >     release_nic_ts_report:
> > >         mutex_destroy(&priv->nic_ts_read_lock);
> > >         dma_free_coherent(...);
> > >         priv->nic_ts_report =3D NULL;
> > >     release_ptp:
> > >         gve_ptp_release(priv);
> > >
> > > Could destroying the mutex and freeing the memory before gve_ptp_rele=
ase()
> > > create a use-after-free window if an ioctl is currently running?
> >
> > Will be fixed in the previous patch in the series.

