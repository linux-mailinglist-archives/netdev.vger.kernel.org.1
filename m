Return-Path: <netdev+bounces-274617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OZJOySRzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:54:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494138B81F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 094483006B44
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6723570DF;
	Thu,  2 Apr 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyOnTf5q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81819F115
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145211; cv=pass; b=V645qWVgrfRpfI3/ZdOpCsljD6OWkQ55Qx24AE8m6WKtSZCvj0R/+omxvehavrKyGJlRCBAnY+ySB7QT9rRES0+M2FEoI5QGwEYC48cAO5vxlrpeMwlHArZOjX7C+9/FC/B5mWIUtXlOfP0WkDEBdG2QlQv7NHeXsD/0crR0Xgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145211; c=relaxed/simple;
	bh=I6KxRHU4DAy38OR1DkG/qA+oj2sZETdR46GOgXDqx7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYvmGfV8ZR5G2GlIYvQWi7Bv1k/LSkj7iK3Iz+z21kMitY0NqlqzF1oVS0QlB5qFvweBlJtZkrUzx2kbW6UUfcDdklkVOXnSUGteHOaczt2bvjqzuoAk9uP0v8xCDsHRoRHZaE91XiOXhD77IFoher84HSOCNdKdRqRWBVWy4Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyOnTf5q; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5091ed02c54so508721cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775145209; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+RslqfZ52KLCoIKIGC9aLwaxONUqtNzeJEOUCU9tlcW+X9NDe6XuNnrCBCnbKXLP9
         GtsLcxK3Lhqd25Qp569+P5dRcuQ4JW6BmkQCmtGrIhUfn/4kT9It048Aa006Qir2YMFi
         PWI0J2mTZfGADJOOftX8pgir08p+WejrYYe3cT4F2lRVUf8Bk6gktZz6db5+QRGP1nsT
         KOFFaJW2tAJ7c8nWEwNcY7HBe39RYGuygtqsZKuiXCL6lKkad6bScVFWizv96FZQrdHV
         3IQJ03C6GTg0hIwzjoBwC3LZCI8FhNExznoQIZcRQ9ptKYC8uWN37GIXGAQbCYYg5QYu
         n/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iwH4TyCRmmVbMGM6b0qg1MnVJEnYkYdG3JYvIlYrMuI=;
        fh=Z3wyAwYhcD3hqeRWucNna23j8eBUSgUYXElQHch3obk=;
        b=JqYH7Ug+M6nsdAnrVpqgod+SJ6yoctRXgyjGi1tTUNfhLXfFCNzA/r8Ww/e7Dz0cOK
         9WCxneDnZozpjfR2rJ5zSNiUZhzjYqKaNmEQZ24Vqa5rZMEcNs+KXYhE8geTKKVcwM+b
         ugXmuFP340JO/722o5kEr+BHzlE1UawvLu7bwsuPwqpIXIiFKWBSP9sbXF7FO5RmBy11
         HOasWFseSqwBYYfN8qCijex1HgfjRnChuDTVMquCLRnV6D5fNngRexe9dK9NdZsr0zPy
         iaiOGuV0Yc8i2um5+sI7SuES8451x8/keZjQS6qsWellVnvyf2hRqF+YInyOVelDLGMw
         H5zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775145209; x=1775750009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwH4TyCRmmVbMGM6b0qg1MnVJEnYkYdG3JYvIlYrMuI=;
        b=GyOnTf5q2UqNjDFW/xuvHFCIvHZr1ETaWzssnNZ30mIs+7msLY0PMM3tR35SJfKRAm
         FU1Kt8nLJhUoJ+FJQaOsDyvJObnfchgRtqDtx7x1rT/CHgEp0+KdwSc1/3OzCqS9kEhS
         Fq5PYWnrOTU57L2bB7WLoFFL7fSjr6SvFOKy8DFyYxHhjcMHMUNga5aT9QMuxJbkEOGi
         NvmNkjp6SDl6Zmqom+FdeM6cQi4MXR2E05ziEE4JuYpH2LRqrhqHiP6DtutlTMlGTmjh
         zQpxDPIN8DFlKhfo5pt71jRXHha97VB67hcGGX7jshe6b5Y/p/FJsKynRCCwt40aRMRG
         dzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145209; x=1775750009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwH4TyCRmmVbMGM6b0qg1MnVJEnYkYdG3JYvIlYrMuI=;
        b=AlDIYaRHsfPPjBwzk4ifncYFw7nIaMC0uizwlqVvhXonMLLMR3YgkhRMNgxSBE2G6O
         676XUS52Kp/Ug1GzU5sikVDnsfNZCVnoDjwmrZXomtIRtdhjWwFeQJUj6g1/1iU3Or7q
         cU4hSEwDlyO12plnVuokxDzQ7TQQ7bMdoTdt+h46TM75T59jKpoS4+QwM4mwz6xbxHJr
         d+RQcYGCIvGkBfP2vZgUvj57dLOzQ4BWE3vlrTNGbKGGHHL2SMulYKIYXiFtRpoxgQU6
         O491lKn6achceG5GGoDtOHGbeDcKUfVV56a9+Dj63pAZwWl28UJEvcoPd9pe1JqZJjvp
         t1aw==
X-Forwarded-Encrypted: i=1; AJvYcCWzeqdbZl8Q9W6EgCb7fnM0d4kni5nkqVbF7dwehdzT5YuZDXk6fdCvh1r7kBEOkiUg4spIWAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLm+/waRj0sb6g41rat6QOTejfkb97OLrFcyHOgfmn89FleTb
	0a/S3JMhaYoLtQIRu1JLFdmDCjijVtLcVwsYqf2/IWKsM9D/8k+EgNqSifXC9TRRs3qv+ZJP9a8
	WwWeSerQTR2rx3lmcAdi41E4gBi0VT8gI7v78G3o0
X-Gm-Gg: ATEYQzwqnQqsmLcCVwxXj1UxPwMJVTpegPZcuKMzTE3tgoOmxOUJOAvvNG300shPc/J
	NVm33DHUpYFE4JRRIwp+cRyJOH/VPfG3J4WdRArGyGVllNmjlGGMn4wW8SVNdfMxDfkKo3WEUEU
	n+gDLSYOPAfEFuazH+sRdCizASthA6kc5jlN1uFxmcMWrNs2jIx7IqxeZnygIOd/dldtugDtapC
	6A1AHXoND3BCa+VIz/+vLRJK7hcszfk9ynoGidazvCHnWxf3bSp8NiJ5vcv9V+aM5HFwNB9eu/G
	rWH3gItgj+YY9+atKCvOvXMG+HKAWihPDZGq3Q==
X-Received: by 2002:a05:622a:aa04:20b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50d507597b5mr10876561cf.12.1775145208136; Thu, 02 Apr 2026
 08:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com>
 <20260329212002.2875815-1-kuba@kernel.org> <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
 <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com> <CA+mzVtv-91ru7v6GxOS80xihE4ZbwGqdyQdKPTHv+woKaeOhuQ@mail.gmail.com>
In-Reply-To: <CA+mzVtv-91ru7v6GxOS80xihE4ZbwGqdyQdKPTHv+woKaeOhuQ@mail.gmail.com>
From: Naman Gulati <namangulati@google.com>
Date: Thu, 2 Apr 2026 08:53:17 -0700
X-Gm-Features: AQROBzDBdG6Lgvz9aTFyb3Yu1FH3VZ-lsAo4FSdEg9tmHbuXoe4g2y4HSUEep44
Message-ID: <CAMP57yVS3OiFX+Qjcr9djO46OLZ=KuW2awD-7fCPZ=k2SdHNnw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274617-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9494138B81F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 8:38=E2=80=AFAM Jordan Rhee <jordanrhee@google.com> =
wrote:
>
> We know that gve_adminq_report_nic_ts() will cause a VM exit, which
> will act as a full barrier. Additional barriers are not strictly
> necessary from a functional perspective. Can we rely on this fact or
> do we need explicit barriers?

I don't think that's enough. Without a barrier get_cycles can be
speculatively executed before gve_adminq_report_nic_ts.

>
>
> On Tue, Mar 31, 2026 at 11:05=E2=80=AFAM Naman Gulati <namangulati@google=
.com> wrote:
> >
> > On Sun, Mar 29, 2026 at 9:31=E2=80=AFPM Jordan Rhee <jordanrhee@google.=
com> wrote:
> > >
> > > On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > This is an AI-generated review of your patch. The human sending thi=
s
> > > > email has considered the AI review valid, or at least plausible.
> > > > ---
> > > > Subject: gve: implement PTP gettimex64
> > > >
> > > > This commit implements the PTP gettimex64 function to enable chrony=
 and
> > > > phc2sys to synchronize the system clock to the NIC clock. It reads =
the
> > > > NIC timestamp along with pre and post system cycle counters to mini=
mize
> > > > the uncertainty window.
> > > >
> > > > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/=
net/ethernet/google/gve/gve_ptp.c
> > > > > index 140b8fbce4f4..bea794541f30 100644
> > > > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > @@ -10,28 +10,203 @@
> > > >
> > > > [ ... ]
> > > >
> > > > > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > > > > +                                  cycles_t *pre_cycles,
> > > > > +                                  cycles_t *post_cycles)
> > > > > +{
> > > > > +     unsigned long delay_us =3D 1000;
> > > > > +     int retry_count =3D 0;
> > > > > +     int err;
> > > > > +
> > > > > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > > > > +
> > > > > +     do {
> > > > > +             *pre_cycles =3D get_cycles();
> > > > > +             err =3D gve_adminq_report_nic_ts(priv, priv->nic_ts=
_report_bus);
> > > > > +
> > > > > +             /* Ensure cycle counter is sampled after AdminQ cmd=
 returns */
> > > > > +             rmb();
> > > > > +             *post_cycles =3D get_cycles();
> > > >
> > > > Are execution barriers needed around get_cycles() here? rmb() order=
s
> > > > memory accesses, but the CPU might still speculatively execute the =
cycle
> > > > counter reads out of order with respect to the AdminQ commands.
> > > >
> > > > Could this speculative reordering cause the strict bounds validatio=
n in
> > > > gve_ptp_gettimex64() to fail spuriously?
> > >
> > > I will add mb() barriers to be totally safe.
> >
> > I'm not so sure that rmb() is insufficient here. In x86_64 rmb() is an
> > lfence. lfence is used to prevent speculative execution (per the x86
> > barrier_nospec implementation) and rdtsc_ordered, which is called by
> > the ktime* helpers, also prefaces rdtsc with an lfence. On ARM the
> > get_cycles implementation adds an isb instruction before reading
> > cntvct_el0.
> >
> >
> > >
> > > > [ ... ]
> > > >
> > > > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > > > >                             struct timespec64 *ts,
> > > > >                             struct ptp_system_timestamp *sts)
> > > > >  {
> > > > > -     return -EOPNOTSUPP;
> > > > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, =
info);
> > > > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > > > +     struct gve_priv *priv =3D ptp->priv;
> > > > > +     struct system_time_snapshot snap;
> > > > > +     u64 nic_ts;
> > > > > +     int err;
> > > > > +
> > > > > +     /* Take system clock snapshot before sampling cycle counter=
s */
> > > > > +     if (sts)
> > > > > +             ktime_get_snapshot(&snap);
> > > > > +
> > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
> > > >
> > > > Could the system time snapshot become stale here?
> > > >
> > > > If priv->nic_ts_read_lock is contended, or if gve_adminq_read_times=
tamp()
> > > > retries and sleeps, the snapshot might be taken significantly befor=
e the
> > > > actual hardware read.
> > > >
> > > > Would it be more accurate to take the snapshot immediately before r=
eading the
> > > > hardware, inside the mutex?
> > >
> > > Ack, will fix.
> > >
> > > >
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > > > +     if (sts) {
> > > > > +             /* Reject samples with out of order system clock va=
lues */
> > > > > +             if (!(sysclock.host_pre_cycles <=3D sysclock.nic_pr=
e_cycles &&
> > > > > +                   sysclock.nic_pre_cycles  <=3D sysclock.nic_po=
st_cycles &&
> > > > > +                   sysclock.nic_post_cycles <=3D sysclock.host_p=
ost_cycles)) {
> > > > > +                     dev_err_ratelimited(&priv->pdev->dev,
> > > > > +                                         "AdminQ system clock cy=
cle counts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> > > > > +                                         (u64)sysclock.host_pre_=
cycles,
> > > > > +                                         sysclock.nic_pre_cycles=
,
> > > > > +                                         sysclock.nic_post_cycle=
s,
> > > > > +                                         (u64)sysclock.host_post=
_cycles);
> > > > > +                     return -EBADMSG;
> > > >
> > > > How does this behave on architectures where get_cycles() is not imp=
lemented
> > > > and returns 0, or with older firmware that leaves nic_pre_cycles an=
d
> > > > nic_post_cycles as 0?
> > >
> > > Firmware is not allowed to return 0. 0 should trigger the check.
> > >
> > > > It looks like the bounds check would unconditionally fail and retur=
n -EBADMSG.
> > > > Since userspace tools like chrony usually expect -EOPNOTSUPP for un=
supported
> > > > extended ioctls to fall back to basic PTP ioctls, will returning -E=
BADMSG
> > > > cause a hard failure for clock synchronization?
> > >
> > > Will fix. GVE is only supported on x86_64 and arm64, and will fail on
> > > other architectures with -EOPNOTSUPP due to the check in
> > > gve_cycles_to_clock_fn(). However, if an architecture returns
> > > get_cycles() as 0, it will fail here first with -EBADMSG. I will add
> > > an explicit check for x86 || arm64 earlier in this function.
> > >
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> > > > >               goto release_ptp;
> > > > >       }
> > > > >       mutex_init(&priv->nic_ts_read_lock);
> > > > > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> > > > >       if (err) {
> > > > >               dev_err(&priv->pdev->dev, "failed to read NIC clock=
 %d\n", err);
> > > > >               goto release_nic_ts_report;
> > > >
> > > > Is there a race condition exposing the PTP device to userspace befo=
re its
> > > > resources are fully initialized?
> > > >
> > > > Looking at gve_init_clock(), gve_ptp_init() is called before alloca=
ting
> > > > nic_ts_report and initializing nic_ts_read_lock:
> > > >
> > > >     err =3D gve_ptp_init(priv);
> > > >     if (err)
> > > >         return err;
> > > >
> > > >     priv->nic_ts_report =3D dma_alloc_coherent(...);
> > > >     ...
> > > >     mutex_init(&priv->nic_ts_read_lock);
> > > >
> > > > If a concurrent userspace process immediately invokes the
> > > > PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the /d=
ev/ptpX
> > > > device, could it call gve_ptp_gettimex64() and attempt to lock the
> > > > uninitialized mutex or dereference the NULL nic_ts_report pointer?
> > > >
> > > > Additionally, in the error path for gve_init_clock():
> > > >
> > > >     release_nic_ts_report:
> > > >         mutex_destroy(&priv->nic_ts_read_lock);
> > > >         dma_free_coherent(...);
> > > >         priv->nic_ts_report =3D NULL;
> > > >     release_ptp:
> > > >         gve_ptp_release(priv);
> > > >
> > > > Could destroying the mutex and freeing the memory before gve_ptp_re=
lease()
> > > > create a use-after-free window if an ioctl is currently running?
> > >
> > > Will be fixed in the previous patch in the series.

