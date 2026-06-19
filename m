Return-Path: <netdev+bounces-300739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TAIwCW6CNWrLyAYAu9opvQ
	(envelope-from <netdev+bounces-300739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:54:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E96A7526
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MXETY7FS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300739-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39D9305FB34
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694BF3B7B79;
	Fri, 19 Jun 2026 17:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6233F597
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 17:54:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891690; cv=pass; b=pS9pawEo+QTlJJOE600UpTvVBMf8vr/f1wxLY4tPxf6mpjxSkmnbhKkjKiHOlEFStk7zdsk0i7WWWcDafduFE+6YPQMvyrhrgytcpnPRQp3Z6hzukt+5mJ7Fbncbg6PqJ3+OjL5S6yqqRPP56QTOlLbgx2nodikvtOhZ0VPyx3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891690; c=relaxed/simple;
	bh=HMu5ul4oO38t0KmuN3K+u8iYfe2lkgNGwIgXHdR8N8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWdoE518J91AsVvhBpmoqWuTxIGQHzNZqFZp3S4PO1pQGoRBmVKksgVYJvp3RnuuBulDTeK6RCiSvA8T+b8pAPwe93TDrSZH2NprGHz+FRrh4JT4nwhQ4sz58w4jKFp5vpRfvfqFXIG+Hi98UHPcZFiFKpXa0KV+kJ7UXpSRaZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXETY7FS; arc=pass smtp.client-ip=209.85.219.51
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8dedb44ed1fso7155076d6.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781891688; cv=none;
        d=google.com; s=arc-20240605;
        b=LWOLx9ieh8dpDIhzXWxqrzCTBd91KUC3xhGPvypqV73tA4c8G5ogF+IF8w49crF8l2
         ZrESRBoTvb8P8sRQznfsOL7nD0h8893cLtmffzWhwXGwmMWGnsYFI+kCIMFdtI87ifjZ
         imCmB89yPmvzxkOb9S7BHg8Vn4wpDmRHgl+vjayYj0DjfZIjXeXcy6gz8zy9YLy+NJ4n
         eYQj8Ka3BGU7de8dmdhM8fGLQ8IZk0yi2zy8uHNPw2ZrCs5ZxGlWo52/ssQV9rhQvnBe
         jLBIVIeSyvLgSmFwffggpbzfOv+9/QRAzg6Cor5ZL/QD+aUfLrH9pr0ul3xvQM6qehWV
         eyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhkvJg+LpILjlzC521sb/+/zn6OM31tX+jh3rPVUa90=;
        fh=0W1uwFd03qlh9POJZQMQmBq/e5KznC5tAoNCMC+Na2s=;
        b=ST3GGG+QU5JUOiz7FsHDhvd50VvHekZHKSNslJlh1PI6GV0eSk6dWVDr7x7f2zzR+j
         oHEx4YCt862CnG3FoHVnmS7pQjfbyZaxXCuAYCCpSeaaBN/HC2aFqhiLKwTU8j2O1hzq
         AWKbud2qnHfA6+UQuH4fHk+wDzVir2m3fc5YoMZKLPzA7t3Jcig68D76wH7/14En02A9
         /yg0RAoUgxcMCOZUA0r1JUs4TYdwpKSU3H7LO/Mw2p90NUFCZkZpQoTbwJNfpp0pFTgB
         +cUugpvuz9FLFdztGoET/T5xNpr+cWE9pVRtF2DvOnXhMnIpQ1XBpGV/uM1yeIG+6ejl
         eDNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781891688; x=1782496488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhkvJg+LpILjlzC521sb/+/zn6OM31tX+jh3rPVUa90=;
        b=MXETY7FS+NFXa5me4D4fN3cZ0knBWdKGjPZKDEgIG60kLtU5ufMHe276oosQXVGxuG
         UCRprDYFGuEcVeaiBQwV+gyx0hC03NRukV/uY5dMbnYUwxEp/b9T1GbJMUErlBpAynNj
         r/Lbi9AoCALEwDDEma/hwKj+gAj98CVYJtLafZqMUT7h3lo3FtAPmwGsYft/EqS5lZtj
         BTzUTZgJ4To3r8fY/Sg1Pv6yNzQh7WFfJUVFZSxeikQR4ZZ2EMDRG0IIZLJQKp7C0HyN
         5CKE7jsHFHaW2rLqpQm4xnQ4mDWEApGUoECHDz4b/jbSbali7fWMHMGDDxv4gf8Z8GL0
         9LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891688; x=1782496488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhkvJg+LpILjlzC521sb/+/zn6OM31tX+jh3rPVUa90=;
        b=OYNu9uVloZt+UV+OoG3GOPJUw3150JXTwXpHtn27IcIO7UbwsyWtiTEHsFAFO2FuWN
         fDlBr25GgiOkgupNNnr78OmpD4ku4h7u+KZllRc3C1pDRdAO1uh+BIlJi0PVh3ew8xUH
         ykLTo2aKlpsO4ORdY8b9NGK+qT12/eV223ywXoo6+O7j2EyipVttCBAANinHoNmjVASV
         YdD5kGan73HNzdixdrXUu3hbzbsKKLjNF1EYGO4hIA6dMP2IoYCoNKRibqosNck7Sr/h
         l1JipqWnghnG3Jbf4EhzScNShbuNS0TeTXCV9jmsvVH76yuty7r5MKPiVVuD8z7OssjC
         ci5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QS/LHvNscQ+WzjjTZcqSLdqyww7+L3pbkRUXzDzsnCZJ9vWzfk9w1VTiMDtAhAJ6zOXsMgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXlJh+92WXgbZVowG1jAMGfJ/nYyQmRanqJjySkTDwMRVaRWU
	WbiUVGv4PHImU1djm6tFO2/zI7ZZf1HG4ulGGWI1nEPDBYODGRzeAL5YTWeuxOyjZPkZsH89Q3A
	Ao4kHNN6Jainy9SDDce5dAGMc3mgR9YJoa5vYXYOjoWyL28Q=
X-Gm-Gg: AfdE7cky95dc/sIMSyAnu8Bv1x8SKUzrkmesD6mo5B8TXG9iA04hGL953ryPCIxUiLy
	0xjd/KhbnSCxKd/8GvYSM0bPgsG0klxdXuOiqkge6kuGPjlp6DFZ4WpVZ7DlZY6FPR87AlBvpAT
	kyACINMd0ifYqW+kXZBu2dVzFDchQ20/494hh3Fx0BFZlAjbo0S2rAc8ZgN7FlAtXuNX8Lj6dcF
	HTOcJKfDGEE4oI+pvb1Yj0BK8vB9i2DRYwJWQFQaJJZraHEUbHSTxDt/BIAel78mtXGR5OmqkJh
	GGkZBNHK
X-Received: by 2002:a05:6214:769:b0:8ce:e409:22c5 with SMTP id
 6a1803df08f44-8de40b0e4f5mr77034306d6.22.1781891687929; Fri, 19 Jun 2026
 10:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
 <20260618211231.GB2636677@ZenIV> <CAEKmD4JfM5GWSiRMUn6NK+kKFeyXA8i3A9gthDz3hVKFcR1YDA@mail.gmail.com>
 <20260619163421.GD2636677@ZenIV>
In-Reply-To: <20260619163421.GD2636677@ZenIV>
From: Alex Goltsev <sasha.goltsev777@gmail.com>
Date: Fri, 19 Jun 2026 20:54:36 +0300
X-Gm-Features: AVVi8CdqrjRbqvTlNtfcnHv2DrommYDGvSTEXxG-xMFFLRgfVxa0Xg05YYhWjpI
Message-ID: <CAEKmD4JV_XKG_tmKhOh9s2WbZ8ZmBE8xDiKnm3ethptRxUe7Mw@mail.gmail.com>
Subject: Re: [PATCH] net: add sock_open() for unified socket creation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300739-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C5E96A7526

On Fri, 19 Jun 2026 at 19:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 19, 2026 at 01:35:56PM +0300, Alex Goltsev wrote:
> > > What's the point (and why not make it inline, while we are at it)?
> >
> > > Are there really callers that would pass a non-constant value as the =
last argument,
> > > and if so, what are they doing next?
> >
> >
> > As for `inline`: in this case, it would have no practical significance.
> >
> > The compiler already treats a simple inline function as a regular
> >
> > symbol within the `EXPORT_SYMBOL` context, whereas a static inline
> > function (the standard
> >
> > kernel template for helper functions) would completely break the
> > export to the LKM.
>
> How so?  All three underlying primitives are exported, so static inline
> in whatever include/*/*.h you put it in would work just fine.
>
> > As for the last argument, yes, today it is usually a constant,
> >
> > but that=E2=80=99s not the point. The purpose of the enumeration is to =
provide
> >
> > a unified, explicit control interface. It=E2=80=99s important that if, =
in the future,
> >
> > someone adds a new type of socket creation, existing calling programs w=
on=E2=80=99t
> >
> > panic or throw a compilation error, but will smoothly fall back to
> >
> > the default case and return -EINVAL, which is a safe failure mode.
>
> Collapsing several functions together is worthless unless the combination
> can be _used_ other than a (questionable) syntax sugar.  kmalloc() can;
> something that would only result in trading multiple identifiers for
> functions for multiple identifiers for "which function to call" is not
> an improvement.

Thank you for the detailed overview. I understand your point of view,
standardization without adding new features isn=E2=80=99t an improvement. I=
=E2=80=99ll
consider a v2 version in which flags can be combined to produce unique
behavior, so that the API offers more than just syntactic sugar.

