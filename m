Return-Path: <netdev+bounces-273062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG7lDqD8yWnJ3wUAu9opvQ
	(envelope-from <netdev+bounces-273062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:31:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF313554A0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4EA3005AF9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7348A2264C0;
	Mon, 30 Mar 2026 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Und1WxMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E41B4257
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845084; cv=pass; b=njoHUy4p97nMKOjQRGLfH2NbPrO4l5SRCAU7Oh6NRLv06L+e7e7/kVbKL4kH9Dg4r2naDOGH8fpMp5/wuS77adkSK/bTic8KvOL/oZmK6QAg1/nmZS+b+pmCMVlBlRlfDqkqgIAMIq5wJ7fddhp8Q9CZy2YFq+UdBdggfKpEn/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845084; c=relaxed/simple;
	bh=TvhAo9NsT3zhqHCbTQSadV8T6GCTjivNKHvHZ6jvsac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFj0nZGA61u1MmzzDzsT0k0jPFLUsr5YpIfqDx9pevZDDSYo6Ne5JhZy4U5FadifpQH6ov7dy7xGMW+1JEV6kCP7FRNIS1fKcD3X5EGpDHAUcAK9qKyVrfeepM4WoIQT+5WRu8KyuL5DbmppHckE+P+3ntCmbp9rDmMQnaOFA68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Und1WxMV; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so4536a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 21:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845081; cv=none;
        d=google.com; s=arc-20240605;
        b=PDbm9C9y+dzg0KIVzdcl6FgxzmklcltVOR5E4zHVWn67LzKFy0C2rnQO1afz+Te7sF
         NmL3ivIQiLGv2XjW+HO1l/2WCdsABPcr0Ods9lt1CemLmrBRnJg8CBQi2JaRdZ/pj/lO
         kKuZPSIBrg1oLruUq/Odku2nsG1n1YwTDcyFIGNI4UMxPzCuXoiIX14hNwaQXKMKawTW
         mzJnuk6vzB3wzx7Am3PvSHnyIt5BAN9IhRkd0qz03d2nwQRjKyTxfc5DmrcK5mqnh7Pc
         s6Ajqrx78QCqxCBO6E/cKA01UHqs/fTkOdHlbWDziVPskB2RJC70gJkbHU8KTbzEK5vG
         AF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XcEQACgTleLgHJ1Vv0C3gqsCWVcWsmSWHWaIP5pBKLk=;
        fh=PQfkrXLuOmEKZ9py+OIyipf2A6nUA1yIWrBFSE4cDKk=;
        b=TRR/0jpLPW3jHvpogQnb8lAS79V/kTC4HEhXQNDxq+lJJ2gVkzhu+9akYCj526bvd9
         yKEWFk8/DNT0zasUepc5srwvkfOwailjr+LI3l5tc2hmpuNYgmFvYOvlX6rcZ17OcQVc
         a5ZWHnBeTHUGsaR4n1Mz0ENEdfoeCTY21jKlyeY9EnIUnt8DzqeDsM4w9VnUWjqjjx4O
         MRlClj0BhlbiFhl0IyOh8rlNWVD/xfjZPxQXp9fxYwCMXz1DolaJxQmZn223lHgP7pvo
         NtSPn9adg2jjI+8s2GoRs1Nb2FamF65rGbykk/MprJ9hApXOB16ZsoCCTkdL3g9V2X0b
         KMOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774845081; x=1775449881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcEQACgTleLgHJ1Vv0C3gqsCWVcWsmSWHWaIP5pBKLk=;
        b=Und1WxMVrlew6e5noHCAwIwtu0mK9HigUW5sErMDQMTOnoE19c8r8arYJ0YX2AFxXx
         8DzHz96FjvRP1OD/lJKJ4HOr2wUmwir/Fa5YPgnl+iOCIYHDWREW8/0GMiH1Lbmo+eOB
         vQF2FPbNnFBe+ReFQkXmrSw4GtN7LeCqPMyj8Jav9HRhoQBJ8KWA8+urkbaJJPQI5b/I
         N6VBFNbUuqdP7JmBzdXFc/vtgf3Rs2Pw2a2W0BL2c/3PPEmRcW6SLA4SVBsG8j+kK+IS
         5aBBOQaPa0c6AWMCcDDhWYzEUvsMp4+M88W0rE8cUEXoTMjIxMULebnq0hiHzaK6dlec
         t7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845081; x=1775449881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcEQACgTleLgHJ1Vv0C3gqsCWVcWsmSWHWaIP5pBKLk=;
        b=HOzUljF7bjqqdnl/fsMK17qYeEugUluyY1dq5eZcBs4OZ8hJaN5XZUNmJUg4k3X45L
         eHck/9BjQ6lcMKQHZUXlf3LItcB2c8oPkNOVQ/ppogc+hc2wcODcaAZAEZlN83P7D6NF
         q7ZS4HZsGWKzpCBK458MKY6xRSjNi3mSKZ/3OFwiL2UGyLeOipOfwuo1r3oO0k09ALgm
         LkcgzrXUa2a1qyg0ofkLg40AnEPGM6uQCITajyZk8scetrFppNbvCFzZ6JGZldxtVmqd
         08Q88K2VordRPpjAtRDcGkllKypL0IO9yESPZIm9WOVneZuIOTB1+uox/Z/UOuZRGbZW
         u+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU5wBidI7EEj7NyZSEdwVrUpazkbJU+UF3krK9LavjcFFuFlfx3llmZXYrJNPGUU0SLpCjoag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTZbzBH0i+rYF8pMQKHv+8Odsnto16hAX26AVPcgkKGwiPHbs
	/RRnlib2sCztIZQtGJ8FhM0x/wv2Xl1yR6fTo6V3KQ/yp5HZlGv26XLkhftVPrm50TO3zKqelo/
	GfcPgRoHtEDw5ENMnSa1f83wtX84pb0XToI3SRYOq
X-Gm-Gg: ATEYQzx+f0AgFnO9OM7Q+Mrv99NLooms0TaRaey2h3iUj5N/1UPpnWK34HWTHzPslwo
	dAkMvo6ZzMifbWd0KbexTrG69tRG1Lt2AwVz27J7wvg1wu3j9pt22WTHsuco6bGazgTiLcIuts0
	kTUhI+uaArjt6bo9yeMgw2N3k5RM2ILFAJ9dijwR2cBUGf/t6vcNe/fEhGGdm5ZeGcSQkh7DNpr
	3J5gtxCkNBQw8CqqOyxr6jZYgcred6Pbhpr0NBv2euaGoOqrV8mNBB4LzKbZf0CS/shJjjfzL+6
	+ZDUk0vz
X-Received: by 2002:a50:9e4b:0:b0:65f:8150:dd22 with SMTP id
 4fb4d7f45d1cf-66b6867e4b4mr44195a12.0.1774845080598; Sun, 29 Mar 2026
 21:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com> <20260329212002.2875815-1-kuba@kernel.org>
In-Reply-To: <20260329212002.2875815-1-kuba@kernel.org>
From: Jordan Rhee <jordanrhee@google.com>
Date: Sun, 29 Mar 2026 21:31:09 -0700
X-Gm-Features: AQROBzDuAhY0G9fg2AOU3ijxo9oMCPUYtKodNB0HHk4oEluVciQE8NGqIntTZvM
Message-ID: <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
To: Jakub Kicinski <kuba@kernel.org>
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, richardcochran@gmail.com, willemb@google.com, 
	nktgrg@google.com, jfraker@google.com, ziweixiao@google.com, 
	maolson@google.com, thostet@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org, 
	namangulati@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273062-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AFF313554A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: gve: implement PTP gettimex64
>
> This commit implements the PTP gettimex64 function to enable chrony and
> phc2sys to synchronize the system clock to the NIC clock. It reads the
> NIC timestamp along with pre and post system cycle counters to minimize
> the uncertainty window.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/et=
hernet/google/gve/gve_ptp.c
> > index 140b8fbce4f4..bea794541f30 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > @@ -10,28 +10,203 @@
>
> [ ... ]
>
> > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > +                                  cycles_t *pre_cycles,
> > +                                  cycles_t *post_cycles)
> > +{
> > +     unsigned long delay_us =3D 1000;
> > +     int retry_count =3D 0;
> > +     int err;
> > +
> > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > +
> > +     do {
> > +             *pre_cycles =3D get_cycles();
> > +             err =3D gve_adminq_report_nic_ts(priv, priv->nic_ts_repor=
t_bus);
> > +
> > +             /* Ensure cycle counter is sampled after AdminQ cmd retur=
ns */
> > +             rmb();
> > +             *post_cycles =3D get_cycles();
>
> Are execution barriers needed around get_cycles() here? rmb() orders
> memory accesses, but the CPU might still speculatively execute the cycle
> counter reads out of order with respect to the AdminQ commands.
>
> Could this speculative reordering cause the strict bounds validation in
> gve_ptp_gettimex64() to fail spuriously?

I will add mb() barriers to be totally safe.

> [ ... ]
>
> >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> >                             struct timespec64 *ts,
> >                             struct ptp_system_timestamp *sts)
> >  {
> > -     return -EOPNOTSUPP;
> > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
> > +     struct gve_sysclock_sample sysclock =3D {0};
> > +     struct gve_priv *priv =3D ptp->priv;
> > +     struct system_time_snapshot snap;
> > +     u64 nic_ts;
> > +     int err;
> > +
> > +     /* Take system clock snapshot before sampling cycle counters */
> > +     if (sts)
> > +             ktime_get_snapshot(&snap);
> > +
> > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
>
> Could the system time snapshot become stale here?
>
> If priv->nic_ts_read_lock is contended, or if gve_adminq_read_timestamp()
> retries and sleeps, the snapshot might be taken significantly before the
> actual hardware read.
>
> Would it be more accurate to take the snapshot immediately before reading=
 the
> hardware, inside the mutex?

Ack, will fix.

>
> > +     if (err)
> > +             return err;
> > +
> > +     if (sts) {
> > +             /* Reject samples with out of order system clock values *=
/
> > +             if (!(sysclock.host_pre_cycles <=3D sysclock.nic_pre_cycl=
es &&
> > +                   sysclock.nic_pre_cycles  <=3D sysclock.nic_post_cyc=
les &&
> > +                   sysclock.nic_post_cycles <=3D sysclock.host_post_cy=
cles)) {
> > +                     dev_err_ratelimited(&priv->pdev->dev,
> > +                                         "AdminQ system clock cycle co=
unts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> > +                                         (u64)sysclock.host_pre_cycles=
,
> > +                                         sysclock.nic_pre_cycles,
> > +                                         sysclock.nic_post_cycles,
> > +                                         (u64)sysclock.host_post_cycle=
s);
> > +                     return -EBADMSG;
>
> How does this behave on architectures where get_cycles() is not implement=
ed
> and returns 0, or with older firmware that leaves nic_pre_cycles and
> nic_post_cycles as 0?

Firmware is not allowed to return 0. 0 should trigger the check.

> It looks like the bounds check would unconditionally fail and return -EBA=
DMSG.
> Since userspace tools like chrony usually expect -EOPNOTSUPP for unsuppor=
ted
> extended ioctls to fall back to basic PTP ioctls, will returning -EBADMSG
> cause a hard failure for clock synchronization?

Will fix. GVE is only supported on x86_64 and arm64, and will fail on
other architectures with -EOPNOTSUPP due to the check in
gve_cycles_to_clock_fn(). However, if an architecture returns
get_cycles() as 0, it will fail here first with -EBADMSG. I will add
an explicit check for x86 || arm64 earlier in this function.

>
> [ ... ]
>
> > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> >               goto release_ptp;
> >       }
> >       mutex_init(&priv->nic_ts_read_lock);
> > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> >       if (err) {
> >               dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n"=
, err);
> >               goto release_nic_ts_report;
>
> Is there a race condition exposing the PTP device to userspace before its
> resources are fully initialized?
>
> Looking at gve_init_clock(), gve_ptp_init() is called before allocating
> nic_ts_report and initializing nic_ts_read_lock:
>
>     err =3D gve_ptp_init(priv);
>     if (err)
>         return err;
>
>     priv->nic_ts_report =3D dma_alloc_coherent(...);
>     ...
>     mutex_init(&priv->nic_ts_read_lock);
>
> If a concurrent userspace process immediately invokes the
> PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the /dev/ptp=
X
> device, could it call gve_ptp_gettimex64() and attempt to lock the
> uninitialized mutex or dereference the NULL nic_ts_report pointer?
>
> Additionally, in the error path for gve_init_clock():
>
>     release_nic_ts_report:
>         mutex_destroy(&priv->nic_ts_read_lock);
>         dma_free_coherent(...);
>         priv->nic_ts_report =3D NULL;
>     release_ptp:
>         gve_ptp_release(priv);
>
> Could destroying the mutex and freeing the memory before gve_ptp_release(=
)
> create a use-after-free window if an ioctl is currently running?

Will be fixed in the previous patch in the series.

