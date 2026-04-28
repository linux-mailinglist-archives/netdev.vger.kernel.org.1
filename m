Return-Path: <netdev+bounces-281964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM/RG3Tm8GmoagEAu9opvQ
	(envelope-from <netdev+bounces-281964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE74896C5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E81130D8E02
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E73C3C0C;
	Tue, 28 Apr 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+ldaVRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540283E1CF0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391387; cv=pass; b=pZSQG2CZgqOHXLNCQV/L15FUqNr+HXrm/zIwD/0AIhi4Xjwk7g2gcmXAVQ/59M3I5FNdlVLFEnKAtMpB5gxNIELTyDxq6HuZrw1NGL4M0B+s0T1frqNXhdo5YAU4lzKmXnm9QJsze0tGi4JFKSc9HnGXM9QLHiyTNjZ9zR9AUxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391387; c=relaxed/simple;
	bh=1wxdcnwBH4OuyJ8paPxY0JQhPkA7Ked8MGTmyyP6YZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL8d4R5ifjE1sTUuarz2CYI0ug86PMPAwzDt1qoaZAVy75yRxRJfLJCECCJxMBtB6qQ1QGq72w2uPwkfpdeMqf7DbcUxsRMh5zBo041diPAhAXiyRdR4V1CB0B9QwwHVz/47yLsjH8e8OfSnirphNeJcnx2/beef6FtswTRr1OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+ldaVRn; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso11289a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391385; cv=none;
        d=google.com; s=arc-20240605;
        b=eW4svA8h1/0XWNNvW3xCliJxNk154F89yUqO3QocAv4siKBDkEIJBr2gL8+9vd5gxr
         CTMzEnxVEPtofpIvOXj0xfVTeX1y+Z3Db/ibK0XbLLgjX5BlHG6GjXvAX+LuJ+2Bn6LG
         synT85xrpYgP+iMR14tQ2nQNeIszcOP0bmanKTrl1jU8Fe5ddmL50yaav2lGgTSITYxA
         C9RH3HhHLeIkKbJ0RIsaBtvxlLiOXDx8Pkk6yn8yXBjTIzz1bvUVym0voImQhZ5Hw983
         s3GCZo0HxKiBBdBp4IUo/JHRUnN+vGYUAJ4NzPOiDyPBSRyTRPkk/aLkf++WoYCpc8w0
         oUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fmgcP8VMMqOHy4IIH7reA11NF1gm+a+PnLG2tnDdTZU=;
        fh=FITDBuLxMGzES4qJyYA1GNbVoRceSbH43g+L5/PwEag=;
        b=hXkLWGWRX2VTDGrSlFg5AtjS9EQLpfshCpPhg+Xo6yrjxRcRHTCUlxLnZtl7E3KlnG
         itDTrYQz0Ce1H8Xk8fmzDGYvtD1hzhRga/kAMK22XMZ6neBoiKzPHTOxZL1JNa63L0Xa
         Gvl4VUepQolGG+6xXukyB65Dwb7vNl012JT9nDuu2GjujiQ12NlU+y4lkvCoYlUkyX/F
         8aXdJhvTWZIsoDy5bykRK61VvOF+kQyd/B7cdIgi+mg+NHVJLOt+N5Zqf7zLI3TJIUP4
         4XiZYG2pbxmVnMi6d7giB8z47mQhnEThejv73yAgdeBW1tdbhY5q6y99STs5LT7doimn
         3uDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777391385; x=1777996185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmgcP8VMMqOHy4IIH7reA11NF1gm+a+PnLG2tnDdTZU=;
        b=i+ldaVRnqQh6s0WTgiV2tfodbIZjVnvpoSGmVhQzIGdaAuxul+lxlrSkClqkbmE1Pu
         bOAhe7lQSHfpfOlrY1u6Qkg/5Ia4FMH+jVsWRqHAzwmCzRzqlLxUxPZAZCKyS/3HfPXU
         PmQvC65P8pgweEMQJoedmM3wsTkvawUkD71jxhNSDlnkF7mhStC6nBmLaNbdqakR+yQO
         wlJKAS9XSpKHiYjt9vv8t9Rer0eEGXuG7xcG6Pg7EVW7VEVrcu0W3p8IWAsSm2vl0CgE
         R27yjWnUFtdVusJPiOMw3l2YA9VtlqZUXY0n0sHgycmzS86SfT/3HJLQ8r4x3gRoiyM/
         Nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391385; x=1777996185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmgcP8VMMqOHy4IIH7reA11NF1gm+a+PnLG2tnDdTZU=;
        b=Q4NIMj2SvM1tNbIPUCUsReEtyUJUXWywAT+A9/39/74CYM4c0Tpk+PRl0j0ZhkAhFo
         1J3tFr1H9kjEzhtwwq/n0YX8IwlrvGjvS/hQU+KhYD8Imf1KW32dFueZiJOZ5SN/Hp6B
         eD/J59JB1l9FXtcOBjgQ60srm67YaMBEczI0pG6gko1NqV35ykxdMLLsyJA6KN2f50f2
         wOwGHrKampdj0BFzRI2jK4zB3IxGJK7f4GSXauVaYofVuiA+PaDDH2GVYQ9SXFNhTjS2
         X3za4VTh+v38nwgmH4aMsCuS4csMLBfmZPyyzIeZwsUUAVLvsLdHUaGQsxwXdkq757RB
         WJRg==
X-Forwarded-Encrypted: i=1; AFNElJ/6J64djFsZeeFEMQq7kLVy8UoV+u9RytskSnaSCn5SgQCOheAemWMxRNbm9R0C/qoN4IvPTsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/ksoqohZET4ise9czAEp20TYimJaUEcgcXNr/XFAOVvtAXDi
	EPUOdImSa8WfYMT6IE7o5wbhrpsfgihpd2dHc20cs3N01WLY0pV9FipngU/wqOdZygURs5X15Mm
	xjDkTkx5AQ1IAzJwm+UbblB9X211BlTdpSv6p++JQ
X-Gm-Gg: AeBDietdmtdGzYXG9x3camD3qrkAgc/Ir16BML9TlOYxFa9SL6R0dQwnY1c8cauv2Dr
	Hvpijh8eM3Y8nOLFf+K0kXcbK26sNqH0hK5nOu1tbKcLaiYxiEu7iHqdOSjQUPgvL68gIO9s+nR
	IFUJRTMh8u1tn7wgaOOgxienSwR8m+nuzmLSeoFSneV1fqRj4+6kC3ksSLmc1+v3X09OdotC5cA
	qziPZFxqPkKSDtYg/PhFacYCBEad/vSN1ncqGuaEWUOEXinqKTK7RMu1mgwc2vtHSAzWPENExjG
	2dbZDZOL3Q3lg4n06vl7JYAxB/seZQ==
X-Received: by 2002:a05:6402:3042:10b0:66b:d36f:f83e with SMTP id
 4fb4d7f45d1cf-679b67c56bcmr56932a12.8.1777391384264; Tue, 28 Apr 2026
 08:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234002.3610542-1-hramamurthy@google.com>
 <20260406234002.3610542-4-hramamurthy@google.com> <20260409201646.6af5235d@kernel.org>
In-Reply-To: <20260409201646.6af5235d@kernel.org>
From: Jordan Rhee <jordanrhee@google.com>
Date: Tue, 28 Apr 2026 08:49:31 -0700
X-Gm-Features: AVHnY4LZ6isdXhhFEnB3C7EqKPwWPMbZx7qe9rpUUq8rB-daAhV2G5SXCNjy5ww
Message-ID: <CA+mzVtuviy1k5-m3saQEtCL0YPUwfKBJWjC54rw+1y9ypFM+Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] gve: implement PTP gettimex64
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, richardcochran@gmail.com, willemb@google.com, 
	nktgrg@google.com, jfraker@google.com, ziweixiao@google.com, 
	maolson@google.com, thostet@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com, 
	linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 90FE74896C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 9, 2026 at 8:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  6 Apr 2026 23:40:02 +0000 Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> >
> > The system cycle counters are sampled by the device to minimize the
> > uncertainty window. If the system times are sampled in the host, the
> > delta between pre and post readings is 100us or more due to AQ command
> > latency. The system times returned by the device have a delta of ~1us,
> > which enables significantly more accurate clock synchronization.
>
> Interesting. I'd like this looked over by David Woodhouse and tglx.
> Please repost after the merge window or send them an RFC.

Ack, will include comparison against ptp_read_system_prets/postts()
implementation.

>
> > +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_c=
ycles,
> > +                               cycles_t *post_cycles,
> > +                               struct system_time_snapshot *snap)
> > +{
> > +     unsigned long delay_us =3D 1000;
> > +     int retry_count =3D 0;
> > +     int err;
> > +
> > +     lockdep_assert_held(&ptp->nic_ts_read_lock);
> > +
> > +     do {
>
> This can't be a for () loop with 5 iterations?

I've reformulated it to be in terms of total timeout, and kept it as a
do-while to guarantee that at least 1 iteration is run.

>
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
> > +             retry_count++;
> > +     } while (retry_count < 5);
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
>
> Does this do anything GVE specific??

No, however, I would caution against adding an API to the kernel to
convert TSC to ktime since this could invite further abuses of TSC.

>
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
> --
> pw-bot: cr

