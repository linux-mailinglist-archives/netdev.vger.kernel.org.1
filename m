Return-Path: <netdev+bounces-284545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A5uAZk1+mlLKwMAu9opvQ
	(envelope-from <netdev+bounces-284545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7184D2989
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5A03075C57
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55F4A3409;
	Tue,  5 May 2026 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oba6GodD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA97366806
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005377; cv=pass; b=IvyXsePrLs1iVAQoE4mwhQo+PtQNvedRKuREBBy4FFICJ5lNvDRZy48fx7k0eA7BsbzodrkXqKhQ10u7ioHzq7kplmIBOdIdFjsH0LyETE9RIzYlTJIS1ObacjBc8FoOHaMBHVuo92KIjCo7CpTcyl5VxWlU8WqiFGpGkEevNHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005377; c=relaxed/simple;
	bh=rjQ1i4u63lQ0EGSLxJQhStTaQJscyIFfd18jGNDogFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBdrVGfyMZTLSSWbwHAgIsblltKQl31Hmm8K7vDKzSiLHoL4iAN6TG4bM3ofJI4TCdz3mzK1HWJmFGG3wNe+23cdzFQ7AG4R/79AzKKAenb69liwOrmivB6bsCsnyyki+UiguaxiYGCn0LIjaEk5HBLfIY+7U9ntc7nXliOMSm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oba6GodD; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso1512a12.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778005374; cv=none;
        d=google.com; s=arc-20240605;
        b=XHQuawTg1yUWGYCLb7jbDgcy19GcQwGMdWbrcym8ZAH5+GIDhwZaMO2+7uf7EFoKkJ
         3tlauHYDRVx6ZRSg2DIexVwjITsgrbMGXXtKzGX9B1J3jN4um86jw+yFhJQRGVcBcBTw
         ou+69E4JEQHhrVhTv9Hi6QtG8FIDYhlnmqOIujKkjFID+FUgOLq6HOw06bXFQm8knDcL
         /tigns3WtpSnPuCeldRm98sNsKKXnK0xeT6trkILExgM9xC1XWrLoTYCyA/r6jc1w/cT
         C6P0eNdL0WOf+6hC09jh03rI3jWYevFPNotaGI+6rFNQklcVJ8MfLHASp+SmilduUz5s
         WySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHuYwjeFgy3ZNH7ekjqQdiihoIbVuPzvmMv5WkHoGlw=;
        fh=iGAv/3O511uanvqWMqNp7QxpDVhp2Mo13I7dXo9ZdhQ=;
        b=H04k16n+KKnm4hSVTXErAe6iX/GkEAtM8aEqUwevaD3Yz2aI3VbmN55Mg4kt5MMLyt
         rghWgfkRWlqJjZpoRvXzdp6VvKKhkgxmzzc+ZnG5syedklfXQxTu2bZEqtmg8bJBEilh
         ziXQnnhHdvMdNHQj7oGXtDHmPrq6FIqZw/vBuWfKt4M5uDJFopYJOaV54BYWVRf21uve
         sKgFz4To1kRPnQtWOJRvgb5z4UYgG08RNv4lV5IU2IAZztmwWjQGLCsmjjCVfGo/OfSn
         80zoIdNEnjkeMCu+xSgSLfn+rIxXS1wKgKAHZCzhMjTkKUgWPCncIu8rP5sAPdY5UU0G
         ZJAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778005374; x=1778610174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHuYwjeFgy3ZNH7ekjqQdiihoIbVuPzvmMv5WkHoGlw=;
        b=oba6GodDdUAq4mLevWI27R1f5VNwy0/xvLsu85syftCl051OIx+hXv9J+a14F+tY+L
         GB4ro4xLAJjPZPwKXgNfgkzI7nRCOtuW4cqVJaxe54KUvbYRPIdw/mqTXSqIFG7DItgy
         SWGgRiIR/H3fT3kP3LO9RQFZj5G5d2DbB1e+DyX/YAyAcphLrGBxxA/Ne73xavnKtrRb
         g/uMT4iP7E/QgmKnjlqJGCcAq3R8EWlHPuLoH5g02L5CxclSOy7xBMtrtLmFccrNhujH
         d7Iqe+wESrr0UhdtJzuWQw5nkEj4nJdGEjTGU7Sr4RKCiXBAe2ezXV/MUyJgd43VMbiC
         AQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005374; x=1778610174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHuYwjeFgy3ZNH7ekjqQdiihoIbVuPzvmMv5WkHoGlw=;
        b=mUF/G/DRWpjM70MtQq7KIRElymJ6/r2Nzrp1D1PgaGgQO1HWda9Zbx55+FvE2oXnr7
         CZ6aBs5wKuDPKgkYryb6rVMnrkcCeiikw/sDXBa5C3UlGQs7jCC0tmEq0rWew2ajeWw4
         rQ/EsLjHlgLS8mtdY3WoLgagoVOAqjEnyUVDImSozmJfk27ak6JQndJIhhIe6GuPnmvR
         DeQ/m44kNwC5vaW8XRhq3EQloC/1b+Eov8tjmXGz418ykY3ua3vr/IXJf4dwWNK3ZYm7
         lcpR2wB6s3us6yB0TaAq1t4+50of69YBbyLQsyVI0ZP9STs4icNFv+0vMi+fwKeK9SGB
         WcfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a0hYZzH/6rVv9gBOaW+Fdgak+u8fVS+JeC6BSFeq+SEfz9ssGmVHOJU+nvYfChFZlKNRemqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGX/X1WLTXT4jhjxC69z5A5WhWEklyB38AgNN4VLe0x3l+nXyq
	CsIFc4SpjhUKA05FIModVll/aY4JLLV7ZibdxE3byXxM7tDq9Gs+N4iN0u56R37oa+MJ0cQOyeE
	q/K9UtBtlsQ/vUQpIxniV7N9XNN+T0UzY9xT29Xkl
X-Gm-Gg: AeBDietOkz73wv323OIRmv+we9sYA0Go8DlbXLDf0/jBbH0VEv7bJf5DhHsJQiukyTy
	P9ODsqN7xj/WoYFsgsbREL4z6gxg8GoYgbaj02zxk4k/vp18gmS+kjpDo3dLdJolPRczjfZKM7y
	ZY3+ECH8cxUAFpyllXHGVrVmCRHs3rAXiva3yg26To+JgOUfOREPWlkQJjx80jwk0xCXWWyJN+d
	QMuPZtTQCHToWTJ/AZvlKDZtgLrRqvjwP8n1m2lf+/UjBsX3ob0Ht/AoA/xfy9AJ/mTowhAMHd9
	KIzbb+Gnsc7+Ogjjrg6W7nEsG2k9bg==
X-Received: by 2002:a05:6402:20d3:10b0:66b:e078:5934 with SMTP id
 4fb4d7f45d1cf-67d4fda5cc5mr7920a12.12.1778005373232; Tue, 05 May 2026
 11:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429012819.3102675-1-hramamurthy@google.com>
 <20260429012819.3102675-4-hramamurthy@google.com> <6259cf59-b054-42bb-9dad-5f62a54a2bc0@redhat.com>
In-Reply-To: <6259cf59-b054-42bb-9dad-5f62a54a2bc0@redhat.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Tue, 5 May 2026 11:22:40 -0700
X-Gm-Features: AVHnY4IAoroOPu7hBYuxPhHUkQznsJmSZoNh1l1jUG-ZAUzojb1nOpkfhD4Jpl8
Message-ID: <CA+mzVttNJ5ka5msxOtR1_wzt47FYUbO=yejNDTLef7PwVe9sMA@mail.gmail.com>
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
X-Rspamd-Queue-Id: 7A7184D2989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 5, 2026 at 1:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 4/29/26 3:28 AM, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> >
> > The system cycle counters are sampled by the device to minimize the
> > uncertainty window. If the system times are sampled in the host, the
> > delta between pre and post readings is 100us or more due to AQ command
> > latency. The system times returned by the device have a delta of ~1us,
> > which enables significantly more accurate clock synchronization.
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Kevin Yang <yyd@google.com>
> > Reviewed-by: Naman Gulati <namangulati@google.com>
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
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
> >  drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
> >  drivers/net/ethernet/google/gve/gve_ptp.c    | 196 ++++++++++++++++++-
> >  2 files changed, 191 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net=
/ethernet/google/gve/gve_adminq.h
> > index 22a74b6aa17e..e6dcf6da9091 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> > @@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic_t=
s) =3D=3D 16);
> >
> >  struct gve_nic_ts_report {
> >       __be64 nic_timestamp; /* NIC clock in nanoseconds */
> > -     __be64 reserved1;
> > -     __be64 reserved2;
> > +     __be64 pre_cycles; /* System cycle counter before NIC clock read =
*/
> > +     __be64 post_cycles; /* System cycle counter after NIC clock read =
*/
> >       __be64 reserved3;
> >       __be64 reserved4;
> >  };
> > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/et=
hernet/google/gve/gve_ptp.c
> > index ad15f1209a83..c6c98ef825aa 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > @@ -10,28 +10,210 @@
> >  /* Interval to schedule a nic timestamp calibration, 250ms. */
> >  #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
> >
> > +/*
> > + * Stores cycle counter samples in get_cycles() units from a
> > + * sandwiched NIC clock read
> > + */
> > +struct gve_sysclock_sample {
> > +     /* system time snapshot taken just before issuing AdminQ command =
*/
> > +     struct system_time_snapshot snapshot;
> > +     /* Cycle counter from NIC before clock read */
> > +     u64 nic_pre_cycles;
> > +     /* Cycle counter from NIC after clock read */
> > +     u64 nic_post_cycles;
> > +     /* Cycle counter from host before issuing AQ command */
> > +     cycles_t host_pre_cycles;
> > +     /* Cycle counter from host after AQ command returns */
> > +     cycles_t host_post_cycles;
> > +};
> > +
> > +/*
> > + * Read NIC clock by issuing the AQ command. The command is subject to
> > + * rate limiting and may need to be retried. Requires nic_ts_read_lock
> > + * to be held.
> > + */
> > +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_c=
ycles,
> > +                               cycles_t *post_cycles,
> > +                               struct system_time_snapshot *snap)
> > +{
> > +     unsigned long deadline =3D jiffies + msecs_to_jiffies(100);
> > +     unsigned long delay_us =3D 1000;
> > +     int err;
> > +
> > +     lockdep_assert_held(&ptp->nic_ts_read_lock);
> > +
> > +     do {
> > +             if (snap)
> > +                     ktime_get_snapshot(snap);
> > +
> > +             *pre_cycles =3D get_cycles();
> > +             err =3D gve_adminq_report_nic_ts(ptp->priv,
> > +                                            ptp->nic_ts_report_bus);
> > +
> > +             /* Prevent get_cycles() from being speculatively executed
> > +              * before the AdminQ command
> > +              */
> > +             rmb();
> > +             *post_cycles =3D get_cycles();
> > +             if (likely(err !=3D -EAGAIN))
> > +                     return err;
> > +
> > +             fsleep(delay_us);
> > +
> > +             /* Exponential backoff */
> > +             delay_us *=3D 2;
> > +     } while (time_before(jiffies, deadline));
> > +
> > +     return -ETIMEDOUT;
> > +}
> > +
> >  /* Read the nic timestamp from hardware via the admin queue. */
> > -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> > +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> > +                              struct gve_sysclock_sample *sysclock)
> >  {
> > +     cycles_t host_pre_cycles, host_post_cycles;
> > +     struct gve_nic_ts_report *ts_report;
> >       int err;
> >
> >       mutex_lock(&ptp->nic_ts_read_lock);
> > -     err =3D gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bu=
s);
> > -     if (err)
> > +     err =3D gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_=
cycles,
> > +                                  sysclock ? &sysclock->snapshot : NUL=
L);
> > +     if (err) {
> > +             dev_err_ratelimited(&ptp->priv->pdev->dev,
> > +                                 "AdminQ timestamp read failed: %d\n",=
 err);
> >               goto out;
> > +     }
> >
> > -     *nic_raw =3D be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
> > +     ts_report =3D ptp->nic_ts_report;
> > +     *nic_raw =3D be64_to_cpu(ts_report->nic_timestamp);
> > +
> > +     if (sysclock) {
> > +             sysclock->nic_pre_cycles =3D be64_to_cpu(ts_report->pre_c=
ycles);
> > +             sysclock->nic_post_cycles =3D be64_to_cpu(ts_report->post=
_cycles);
> > +             sysclock->host_pre_cycles =3D host_pre_cycles;
> > +             sysclock->host_post_cycles =3D host_post_cycles;
> > +     }
> >
> >  out:
> >       mutex_unlock(&ptp->nic_ts_read_lock);
> >       return err;
> >  }
> >
> > +struct gve_cycles_to_clock_callback_ctx {
> > +     u64 cycles;
> > +};
> > +
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
> > +             return -EOPNOTSUPP;
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Convert a raw cycle count (e.g. from get_cycles()) to the system cl=
ock
> > + * type specified by clockid. The system_time_snapshot must be taken b=
efore
> > + * the cycle counter is sampled.
> > + */
> > +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t c=
lockid,
> > +                                 struct system_time_snapshot *snap,
> > +                                 u64 cycles, struct timespec64 *ts)
> > +{
> > +     struct gve_cycles_to_clock_callback_ctx ctx =3D {0};
> > +     struct system_device_crosststamp xtstamp;
> > +     int err;
> > +
> > +     ctx.cycles =3D cycles;
> > +     err =3D get_device_system_crosststamp(gve_cycles_to_clock_fn, &ct=
x, snap,
> > +                                         &xtstamp);
> > +     if (err) {
> > +             dev_err_ratelimited(&priv->pdev->dev,
> > +                                 "get_device_system_crosststamp() fail=
ed to convert %lld cycles to system time: %d\n",
> > +                                 cycles,
> > +                                 err);
> > +             return err;
> > +     }
> > +
> > +     switch (clockid) {
> > +     case CLOCK_REALTIME:
> > +             *ts =3D ktime_to_timespec64(xtstamp.sys_realtime);
> > +             break;
> > +     case CLOCK_MONOTONIC_RAW:
> > +             *ts =3D ktime_to_timespec64(xtstamp.sys_monoraw);
> > +             break;
> > +     default:
> > +             dev_err_ratelimited(&priv->pdev->dev,
> > +                                 "Cycle count conversion to clockid %d=
 not supported\n",
> > +                                 clockid);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> >                             struct timespec64 *ts,
> >                             struct ptp_system_timestamp *sts)
> >  {
> > -     return -EOPNOTSUPP;
> > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
> > +     struct gve_sysclock_sample sysclock =3D {0};
> > +     struct gve_priv *priv =3D ptp->priv;
> > +     u64 nic_ts;
> > +     int err;
> > +
> > +     if (sts && !(IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_ARM64)))
> > +             return -EOPNOTSUPP;
> > +
> > +     err =3D gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : NUL=
L);
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
> Sashiko/gemini is reporting the following:
>
> ---
> If older firmware does not support this feature and returns 0 for the
> pre_cycles and post_cycles fields, won't host_pre_cycles <=3D
> nic_pre_cycles evaluate to false since get_cycles() will be greater than
> 0? If this occurs, the driver returns -EBADMSG instead of -EOPNOTSUPP.
> Does returning -EBADMSG prevent userspace tools from gracefully falling
> back to legacy PTP ioctls like PTP_SYS_OFFSET, causing PTP
> synchronization to fail completely on older firmwares?
> ---
>
> which looks legit to me, or am I missing something? Note that
> proactively triaging sashiko comments would help maintainers a lot.
>
> Thanks,
>
> Paolo
>

Hi Paolo, my apologies for not addressing this proactively.

Firmware is not allowed to return 0 for pre/post cycles. This would
violate the API contract, so returning failure is the appropriate
response.

The kernel PTP stack has no special handling for EBADMSG vs
EOPNOTSUPP, and neither does Chrony
(https://github.com/mlichvar/chrony/blob/866bedef0b648fdd6cc68f8cb4d75e4303=
244c76/sys_linux.c#L959).
Returning EOPNOTSUPP instead of EBADMSG would not change the behavior
of upper layers.

> > +
> > + err =3D gve_cycles_to_timespec64(priv, sts->clockid,
> > +        &sysclock.snapshot,
> > +        sysclock.nic_pre_cycles,
> > +        &sts->pre_ts);
> > + if (err)
> > + return err;
>
> Sashiko writes:
>
> Looking at gve_cycles_to_timespec64(), it relies on
> get_device_system_crosststamp() which hardcodes the clocksource to
> CSID_X86_TSC or CSID_ARM_ARCH_COUNTER.
>
> If the guest timekeeper clocksource is something else, such as kvm-clock,
> get_device_system_crosststamp() will return -ENODEV which is propagated h=
ere.
>
> Since userspace generally only falls back to legacy PTP ioctls when recei=
ving
> -EOPNOTSUPP or -ENOTTY, will returning -ENODEV cause the extended ioctl t=
o
> fatally fail and break synchronization? Should we intercept these errors =
and
> return -EOPNOTSUPP instead to preserve the fallback behavior?

The system clocksource returned by the callback does not need to match
the current system clocksource. get_device_system_crosststamp()
converts the supplied value to the system clocksource using
convert_base_to_cs(). I've validated that cross-timestamp still works
when system clocksource is kvm-clock:

$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
tsc
$ cat /sys/devices/system/clocksource/clocksource0/available_clocksource
tsc kvm-clock acpi_pm
$ echo "kvm-clock" | sudo tee
/sys/devices/system/clocksource/clocksource0/current_clocksource
kvm-clock
$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
kvm-clock
$ sudo systemctl start chrony
$ chronyc tracking
Reference ID    : 50484330 (PHC0)
Stratum         : 1
Ref time (UTC)  : Tue May 05 18:18:20 2026
System time     : 0.000000703 seconds fast of NTP time
Last offset     : +0.000001757 seconds
RMS offset      : 0.000004796 seconds
Frequency       : 0.164 ppm fast
Residual freq   : +0.046 ppm
Skew            : 3.106 ppm
Root delay      : 0.000000001 seconds
Root dispersion : 0.000013117 seconds
Update interval : 0.5 seconds
Leap status     : Normal

