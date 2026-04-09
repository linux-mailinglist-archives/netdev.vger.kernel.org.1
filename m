Return-Path: <netdev+bounces-276765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOAXBi781mkZKggAu9opvQ
	(envelope-from <netdev+bounces-276765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883B3C52BF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 331FD300B9FA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2F278161;
	Thu,  9 Apr 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Le2wkm0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A924E4C4
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696936; cv=pass; b=QaSXj4qKB66dSJHxO1iPeXhadi4rokR8JusxOSyEcN5E22faG1PQzNFv3sFoqMh1sMaJdpIezNpD+IM/BJqzj6mY72S2Nw2uQEpa2zecd4j1Y46APVa9P+x/9PflKlpk49ra7ftESGZUlEPRWnbZ1+mBRkeRIBI9DU1mjaZANf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696936; c=relaxed/simple;
	bh=hvquwuSY9a9P1Qit4N9tEQrqyKoLAz0HEOfvMbwEirk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPjeKYHPFXA738/PoEwWf4J5DIW8lg/jWzNRmSqq3VeObY9Aox2s7OgFWqEDMNvBkD+qHB2VUAgKYdQ+/dOcvcpoJQerCHAATvnElCCm6HvMkPmve/zv+jw9wz6JywdjXd+VKnoTtr7RFOw1jZZRTGgOtr72z6N+XUOw3GbFd9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Le2wkm0c; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so3294a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 18:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775696933; cv=none;
        d=google.com; s=arc-20240605;
        b=kaCQP/eZbz2G67N+cxzvosRoD4mp+T5bwm4/BTqUil7mqpBbK0BI3LvDzGiwLnI4rf
         pxMt2x8+PfiukH1DMTYdzpgbaDnoWgXieJVVSujRE4P35ycs9rej5l7eaQAxNkDXvgam
         2G7WGnJegJwmbkQwVEYpM9M8lqYmcSZ9rwV5U/XTI/AzwvP+02AXwI9uVZXBKOF3rlCc
         +80FAbgLxPxOjrTth1Q+7yVwGJKqcWe0MpLTTd3eedHiQ6+lqaeSyBN7/yyWgIdIe1/w
         DEnZiiOjDIOJcY9/HgdYl3Sqz85fx0zenLDab+XdtB38WjJ/WqwIjXmZifj4v/1KH4J3
         cwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NcqYuZpLaJxMPW3tiZoFprgpPguQmdQcp7gIdcVxu8=;
        fh=bpYlBfwLJU0g5WVpszobmzb/u5LDb22cLTDwSIkstGU=;
        b=inUsvpyPXS28WhszpTgILnlnSNBM1ySNsKfTXpDoyrMSf0EYA/nYeuaz5qJc1CkZ7q
         RstroP6QWG/b5o/VuGnrZKeQOfbSuq5xjNaASeQZMfUT92PA5CZVdAQH09aKIBMyfasA
         F4PwU/wseJotFo7jWHphhIvksonUTK/I3pPDerDKRFNZB3Xr6wJgMjYwgygByyTney6d
         eJBLWTS76P5Y2trFx+gw5qXCZyPzUluppSIo+TTPC4+RYGLI2JIFOKFZHAtSrt2vbQZ/
         e23C/LsMtKYC6P6Mt6ZC+m+jf9T3GMEdLHktdm+S8WpDP5/5zVf8FjCSo2kdaKMYec44
         MG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775696933; x=1776301733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NcqYuZpLaJxMPW3tiZoFprgpPguQmdQcp7gIdcVxu8=;
        b=Le2wkm0cHG8sSU38Bie55bV7TZccyZfWIHRB/kC10phAlO9kuGe5eWDuTZf20WlvK5
         38s7V8Uvo/LpOimnEbbxTc+yDNP8jdKt3t9TomQ/6ERU/0KlPXF/90RHPCh3IMdblrzK
         RR5OKdI6aoaW80sRAY2UIgToqoGUVZZWJ7hMyMIfRO/dU6QiDBeaH1q/nd3d/YfIxpws
         AeQWiNiN6Sc6HolviOCaA71mTllMV8RqNWZqCpCD2aHkihqQBDdCI86uqGATpN6ejrQJ
         evX4LPSMDrhbxohaRy12NJi9rSZrdTZhVFFdL9QY9k2kOXLp75nIqeu7A1k4LVlAd0wN
         3ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775696933; x=1776301733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NcqYuZpLaJxMPW3tiZoFprgpPguQmdQcp7gIdcVxu8=;
        b=IKC6s8l4vJ+ut23LckaV4RPrG1EHvqe56bBMWZFWwCV14Lum50SHYuhTVQpyllekJK
         q1aMg1I8wo6b0LR5z/OlIS6sJcT5LUph+N2+Egg5IZ5uRJMN+qCw+pgtjufXKwZSjhOh
         VLTswCjcfTpbJpeRKEnm7wX4PVBIOMdfxYfQIaZ/wYIEzTIoQZoFweKRdNRO7J7PW5/F
         iTvRDLMp5594C063WoL3i56j4lAHENJuZSliNaZ9IHYXuB7XUjFR4RdXlwWZLMrurSRa
         r7+v0/sMbL0X0SWEZY0ETqLK9w+3N1UT4WtvAz37Wlo6QePkZ0dwGmCdNwfld7aE3aFf
         ZZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmEFhbzP6+uiGUPWYdJsBR9QMsQs4txm7Bx5Nl1ZmYXNrQqmLBCdcMmxqffMLRBbJ/mrnPYSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxndk9L0eRcjsJRFJ3FGdKRs8UBhtZMPRHdYV5FMbg00V94wdQ3
	DFR0QHH3Y+g79qj9xOFZjf22+osODDh7siOtwKq4Yt6/ZC6B2VAIzaAHbKcLcIPzC5Q/z3rkras
	hzXdLWpaYGqcDhFx1Xl1+ntwqR8ux0PXR6T227o3L
X-Gm-Gg: AeBDieuDhDeXsavaYCXbU2upYjU8hl+TfdF0Fjtj09xR12YmauX/GZJ2pBWYWMbNs2L
	cL0gjlLd8T1aF9IDL//rpDFm9u3b4sVspFKpV3nI0TihnlMVbZdbRlb9HCJr2k8NOEr7XoEKbDs
	GPA3OvHlS0KPtb1MnLWzfTqhCdOgaEjsVDSF9CA2xfP52QCd9ar0cbmW49EhWP9sHgCqf0R96sC
	peSvqzT4u4mpCPJtmK1swo/mv+MvUtCgnDi1Ql9UDLiB4GpK5QoAxU4m5VmKo27sOJtKXf5A7lO
	jF5KK5fqnXxxXeoQjfqNc3MOFXCs1tOin1eJkw==
X-Received: by 2002:aa7:c143:0:b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-6700ebaf3f0mr21227a12.0.1775696932354; Wed, 08 Apr 2026
 18:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-4-hramamurthy@google.com> <d02145e3-8ac4-4057-a888-3ce074a295ea@intel.com>
 <CA+mzVtscZ9Dkcx8vq6MpCjNHqep3PoeuZff=o_V9usRo6eLBrw@mail.gmail.com> <093a5c92-f94c-49d6-96ea-0c76ff18f9e1@intel.com>
In-Reply-To: <093a5c92-f94c-49d6-96ea-0c76ff18f9e1@intel.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Wed, 8 Apr 2026 18:08:41 -0700
X-Gm-Features: AQROBzD0yv90uTF2jg95A9wSRTdAyYUxMAPbIKyf126GIAuveNXEFR7aawYKGdA
Message-ID: <CA+mzVttZRrrPcamK-_VPYSdSGwjZsgKN76R5w6wAvfa=N-7mVg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] gve: implement PTP gettimex64
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com, 
	linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-276765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1883B3C52BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:43=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 4/6/2026 1:41 PM, Jordan Rhee wrote:
> > On Fri, Apr 3, 2026 at 2:18=E2=80=AFPM Jacob Keller <jacob.e.keller@int=
el.com> wrote:
> >>
> >> On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
> >>> From: Jordan Rhee <jordanrhee@google.com>
> >>>
> >>> Enable chrony and phc2sys to synchronize system clock to NIC clock.
> >>>
> >>> The system cycle counters are sampled by the device to minimize the
> >>> uncertainty window. If the system times are sampled in the host, the
> >>> delta between pre and post readings is 100us or more due to AQ comman=
d
> >>> latency. The system times returned by the device have a delta of ~1us=
,
> >>> which enables significantly more accurate clock synchronization.
> >>>
> >>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >>> Reviewed-by: Kevin Yang <yyd@google.com>
> >>> Reviewed-by: Naman Gulati <namangulati@google.com>
> >>> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> >>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> >>> ---
> >>
> >>> +/*
> >>> + * Convert a raw cycle count (e.g. from get_cycles()) to the system =
clock
> >>> + * type specified by clockid. The system_time_snapshot must be taken=
 before
> >>> + * the cycle counter is sampled.
> >>> + */
> >>> +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t=
 clockid,
> >>> +                                 struct system_time_snapshot *snap,
> >>> +                                 u64 cycles, struct timespec64 *ts)
> >>> +{
> >>> +     struct gve_cycles_to_clock_callback_ctx ctx =3D {0};
> >>> +     struct system_device_crosststamp xtstamp;
> >>> +     int err;
> >>> +
> >>> +     ctx.cycles =3D cycles;
> >>> +     err =3D get_device_system_crosststamp(gve_cycles_to_clock_fn, &=
ctx, snap,
> >>> +                                         &xtstamp);
> >>> +     if (err) {
> >>> +             dev_err_ratelimited(&priv->pdev->dev,
> >>> +                                 "get_device_system_crosststamp() fa=
iled to convert %lld cycles to system time: %d\n",
> >>> +                                 cycles,
> >>> +                                 err);
> >>> +             return err;
> >>> +     }
> >>> +
> >>
> >> This looks a lot like a cross timestamp (i.e. something like PCIe PTM)
> >> Why not just implement the .crosstimestamp and PTP_SYS_OFF_PRECISE? Do=
es
> >> that not work properly? Or is this not really a cross timestamp despit=
e
> >> use of the get_device_system_crosststamp handler? :D
> >
> > .crosstimestamp is for devices that support simultaneous NIC and
> > system timestamps. Devices that don't support simultaneous timestamps
> > have to take a system time sandwich by calling
> > ptp_read_system_prets()/ptp_read_system_postts() on either side of the
> > NIC timestamp. Upper layers (e.g. chrony) use the sandwich delta in
> > nontrivial ways when estimating the system clock / NIC clock offset.
> > This is information that must be preserved, and it would be incorrect
> > to implement .crosstimestamp by returning the midpoint of the
> > sandwich, as tempting as that implementation might be.
> >
>
> True.
>
> > Gvnic does not support simultaneous NIC and system timestamps, so it
> > must use the sandwich technique. Since the NIC timestamp is obtained
> > using a firmware (hypervisor) call, the uncertainty window would be
> > too large if it were taken inside the VM. Gvnic takes the sandwich in
> > the hypervisor and returns the raw TSC values to the VM.
> > get_device_system_crosststamp() is used to convert the TSCs to system
> > times, which I believe is the only correct way to do this conversion.
> > Jordan
> >
>
> Hmm. The function says:
>
> "Synchronously capture system/device timestamp". That is what confuses
> me. Your implementation uses gve_cycles_to_clock_fn() which just sets
> some values in the system_counterval struct and exits. It doesn't
> "capture a system/device timestamp" tuple.
>
> This does feel a bit weird. No other caller appears to exist outside of
> the cross timestamp implementations.
>
> It sounds like what you want is a function that takes a cycles count
> value and does the conversion from TSC to the appropriate clock, along
> with all of the interopolation etc. What you've done is sort of a cludge
> around get_device_system_crosststamp() to force it to do that for you
> without actually using it as intended.
>
> I'd argue it would be better to have a cycles_to_ktime() or something
> which takes the TSC cycles value and the appropriate clock and does the
> exact same flow as get_device_system_crosststamp() for converting the
> cycles into proper ktime values without the mess of the callback
> function etc.

Yes, that's exactly how I'm using get_device_system_crosststamp().
There is no cycles_to_ktime() function, and adding one would make this
patch more difficult to backport to older kernels.

There is precedent for using get_device_system_crosststamp() this way
in the virtio_rtc driver. In viortc_ptp_getcrosststamp(),  the
timestamp is sampled before calling get_device_system_crosststamp(),
and the callback simply populates the return values from the context.
I believe the snapshot parameter was added to support this use case.

>
> I guess in principle what you've implemented is "correct" and
> functional, but it definitely feels a bit weird to use the API in this
> way. It smells like a neat hack instead of a proper interface for this
> purpose.
>
> That said, I won't object strongly if the maintainers are fine with
> using it for this purpose.
>
> Thanks,
> Jake

