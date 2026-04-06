Return-Path: <netdev+bounces-275734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB2UBeAb1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:47:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946913A74EF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1554B303F7F8
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3630F94B;
	Mon,  6 Apr 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONDkc2si"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D330FC1A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508126; cv=pass; b=MGUKlkv+kBzD+B90G1il4pHNurW4IHI0f5Hf8YzHsuuMO+7TZdTMAp3aFhb81uurDAlfwhwtVbFNMRpK1kNFi1a5gRJiAsuIXnrZSNWoUfZXmO/7iW/D39D2l93JA6JXMl+TDC8yVUbXQ4pXpjc94uVu5ez+QF0ZxPuxfFuYJJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508126; c=relaxed/simple;
	bh=H452aBqSycsj/dH7zlvJMw+tCAjq+b/ORqOvNscxUqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHPbKBmTSGRscpsDsygHhmuTY5m07jP4Z27Xfdj22U5bccgPDSywpAQxcUe6KYc7mt4OEZnyhJK4nkoqVBxpDFZ7oNsXqDn+F6922Ky5FGvnSHhQNrhW4DLMZkCSelGrcCPUnjm3O9qjtRLqoidxQYEyrrAUemmHYXRGNRzXLV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONDkc2si; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so30300a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 13:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775508122; cv=none;
        d=google.com; s=arc-20240605;
        b=PBPcc16FP0329HGK2gk6yrXYFn/fIt/tfEb2oJN3ypNT3C5aY18Ft49kp34P0xcDxK
         vaizUtuXz4Iz5jQn8gGsxUH+MGdKm3qbcvg9rAMnAvExDtolgUj0cszTJeHYhd+0OPQt
         h6IkzlZPlFmp8fTx39qmY0aG5vvnFkcZQTcFZMl3cNXkxE1WGt2dmgjl2TveOG22zWj1
         fyD/qzxWBH05zhWmZ3+ed9FIVh/1mVV1u+S9V2sSWl0ROxZenO3gdseJjRrnfLUvGNQk
         MMZ43U1Zv9W5DLCM+fgSypNfz0GsxA7Fj3aToipHnrVMewVF/ogbxc4HItyCxeIqtXOM
         Ve1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEFKwFsa9/6z5LdIbjtFkRrQFOfpN4xztM959jDZ/QQ=;
        fh=sZYiMo/6IvMS397zWvbP7HOwQmlkmmzPF1+rJnaX7o4=;
        b=bYmF/+Lhy2Lt3wEml7+9Eay8/HUxe0wINwCr6cRm8V0wOxHiJuWt4O2ttYjQ/czjWP
         Yhx2mfVKLb+Nf4Mxc3knN0MLhCTnHTViLWyx9Pws8AmifZY129+30wiUv14ktLbeJKl/
         gS2NFld177olkjRQ2p3MEXTYUqRQhYWJCKw6vcPtDDmLMezqVJG6AxlZc7g0x9PghEm7
         ER4+z5Z0Adsok+Q1HL0oWeXmrfLdq6zVL/alOY7Jv/QxbKRr0Mnz4pxsLKr2D/rz0lQv
         RSoNiU+Cc4fb6DT3hDYn7uQm1OVEOjpe9ScAD68MXUVpXWGaFwfBFJTGsuQZQG2zIQY9
         9aqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775508122; x=1776112922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEFKwFsa9/6z5LdIbjtFkRrQFOfpN4xztM959jDZ/QQ=;
        b=ONDkc2siHSMpoNFVXEEHSaz6CCDJhmJ/rtrudi0LOUMcease+dlbAjPnvQwM9zPBSi
         CcSEsoqKlnzTue4zjpk0JqGQ+NLR3UkuVhAMMWDMlMD2V94auvamC4YfG64nNJ7NTSZd
         l2toJIK6yN1uQwdDBtxqLRK7rkMKkmcggFy7wuViXVTImtJxA5cDnwUkSZFcJTpZklk5
         IhcZpD0tNyhT4zBoxH2AM+GDxIyMXoq2ZWt8aTs6Ntoa0hqhvBC4PQDIGOdbclApPM0+
         0dFurU74ZcOKYwl5Gi7bs0i29BfCIBnyvwN93iadqM34UZBaN6P+5Um5UHSJ6HfKXoD1
         lWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775508122; x=1776112922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEFKwFsa9/6z5LdIbjtFkRrQFOfpN4xztM959jDZ/QQ=;
        b=gYYA39B9c5dObvFMpzcKsEMCy49n4q+lgTOpbv1iaFTQh8wbEEJcWI9827GoUz+kdn
         oxZYQwttPr51rjv2f0a3QbKeCKIpdqzyfco5ewGwGw8drRPkk2jwAqRDsgnWRjz6tjNX
         Qbv+vRVIHIbWi9cSj9SC+W+SgpHEfzVbB1rFkwHQfX37+Kc2cQycnzFhVE1m1xZWLonG
         gtUQi9IdGZXEL1zngq6tc17Lf5/mWnyBk8vCvzs8VslC4Jw4nwRxihUH3vMGtXWOfV3t
         pzICrSRNyF4voIZC2JV8ocHYzXaobJcutwBxcDnhO++5BBQNv4BZntKjqSfla+hhi/5V
         BpKw==
X-Forwarded-Encrypted: i=1; AJvYcCWuxdceey2QpbZjNvsb5MkD3jTMfaVgSnMlET3tSAbK8Pk32atncXUYcAHVWaawWkR2ewr3Y3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeobuhAOUDVNzVvx/ZBIo/pE61xzbkVOLkzG5/7QDvP/N81Fe
	KBjwyQl0hDEw/jKwK69pRozLWyoDz/IbxTQbEYSjVyjSVGJBhStfK1iZJYCrDSTH7dc+i0t4QdJ
	jYq1iCCg+m9/LwpJmmb0LKG42V6xp8TA8t968+mvh
X-Gm-Gg: AeBDieuZXsehjaKqVmxV/kWp3B4zYCcTXa1KLvIYZU9IqeEf5joqligj1VsFESW9deB
	CrMCiaOmEnNXXznsLb1s5v6VK82eZmM7QN9I63sMx4KQBzkJeXcKMvd0gdxSXLe+IV3JW08jDGk
	HlB6MuSWqBe9Y2Vw9IihlRZY8UdHRcMV1n2cwbIqWbTFVeKD+Rp8vCd8teJil/2npOKoG+jVZpJ
	Jju6dH/O0ZaIHFPS7BMjeVBcS1edibALwsDZbAKDLKOwMlUG5mJJWPNlP9v209OfX+Uop/w6L4U
	htUe+PcvfuowCHyCi/VVZZSiW+lgsPpmqXCiZA==
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr128249a12.8.1775508121697; Mon, 06 Apr 2026
 13:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-4-hramamurthy@google.com> <d02145e3-8ac4-4057-a888-3ce074a295ea@intel.com>
In-Reply-To: <d02145e3-8ac4-4057-a888-3ce074a295ea@intel.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Mon, 6 Apr 2026 13:41:49 -0700
X-Gm-Features: AQROBzCoTO0wnbYnGHpxpmhTDEzxmgni6DNUif0jK8WgB1tkbj-bZRloe-ijVvc
Message-ID: <CA+mzVtscZ9Dkcx8vq6MpCjNHqep3PoeuZff=o_V9usRo6eLBrw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] gve: implement PTP gettimex64
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 946913A74EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:18=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
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
>
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
>
> This looks a lot like a cross timestamp (i.e. something like PCIe PTM)
> Why not just implement the .crosstimestamp and PTP_SYS_OFF_PRECISE? Does
> that not work properly? Or is this not really a cross timestamp despite
> use of the get_device_system_crosststamp handler? :D

.crosstimestamp is for devices that support simultaneous NIC and
system timestamps. Devices that don't support simultaneous timestamps
have to take a system time sandwich by calling
ptp_read_system_prets()/ptp_read_system_postts() on either side of the
NIC timestamp. Upper layers (e.g. chrony) use the sandwich delta in
nontrivial ways when estimating the system clock / NIC clock offset.
This is information that must be preserved, and it would be incorrect
to implement .crosstimestamp by returning the midpoint of the
sandwich, as tempting as that implementation might be.

Gvnic does not support simultaneous NIC and system timestamps, so it
must use the sandwich technique. Since the NIC timestamp is obtained
using a firmware (hypervisor) call, the uncertainty window would be
too large if it were taken inside the VM. Gvnic takes the sandwich in
the hypervisor and returns the raw TSC values to the VM.
get_device_system_crosststamp() is used to convert the TSCs to system
times, which I believe is the only correct way to do this conversion.
Jordan

>
> Thanks,
> Jake
>
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

