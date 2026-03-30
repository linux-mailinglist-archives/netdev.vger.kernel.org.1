Return-Path: <netdev+bounces-273060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAjWD4j3yWnK3gUAu9opvQ
	(envelope-from <netdev+bounces-273060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418C355284
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFCC3009B0B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49833CE92;
	Mon, 30 Mar 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeV94L2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785091E5724
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843594; cv=pass; b=Qh+pAjyy1SvlsS+/NIDAIb59JhZwlcrJAeHACjzZ3SgRC0KF1dZ9VUv4y+RbNsxsDj/gF3+QSq0p1Wc4duyIub9iOjG+foETWqbaumhK+qy/Rzu8oIRoDJr16mGzJZCu/lU0cFg0coiqPulHuXEe/40aEX6PxLif9t7GeB9+FXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843594; c=relaxed/simple;
	bh=pryLuuRR7o54a8dbu97fRPKb6apqdD9oNyRyCHn0XBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUvx5HCDIeWlzDITQE482Vcq7Hm0g3DQZpiL9Hl6JKLNOtQMXdebdfNrDzE9hJtq3Rl2XvcXxFagv609SY3tuAw/Gy6DcNKYGWGReLzjWkxhxn0qPYpM2DROryV/8tba0kI07BZL4thDTEjA6gUhLF0HqTRxIVXDaCtXhURnXFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeV94L2x; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso9232a12.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 21:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774843592; cv=none;
        d=google.com; s=arc-20240605;
        b=OXPNexN6FckfXouYHkRbuK3f7HkHZ59RBCyWAkJiAXqxRVX9nBiZUFLGxDY+s7jNDH
         VuEC5J2mbGsP25SkoknkF+pgkK/fj5bN7cxp5jfre6KAfOdRzRhpqH1PtS99Aw0ZWmxd
         csIYnq9ED30jlvcxjTVLIKoHsmnuIaCTD/8pysxLXFTBnQR/CPdRXV0kASHPNNheJOP0
         RYJrrgWiFt66q89flLdOOIMWuMEW4cAJ20LM5SdJppemSIFftAlPd86em/sdunb74qRv
         yM5FzFnwzIFqpkbS7vZ8iWCLVV3Av0wsRniGJVRQkR6nVm5mxyESj6XRwqmpMWRff6NC
         COUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ANSTIj2ghfnzM/RxEUip18MYygu8NsG4n16CnyfeffM=;
        fh=5gSpzYbTrDq3mchSx6Pyhtwwzt4+iT6LCWYiczLe3So=;
        b=EHwEtCnZThhIDAGvt/pPk7zYHkprhbidXexw+VHs3uoiRYEcV7TCNYglPGP+PrKnKO
         +B//8Zs3WePiKTiuOpVvQw+C//TarLnx65aLVF0xwdQML+Pc1kJbQKJ0MIZS+EdpThXV
         ZRqE9VUjBqGsKFuROWDlYwpoPQWn1cuLytShNPbOSI0cv3YcUH1X7XOx7athD28iNrE/
         j1P2dMcQlL2a/spF0vrnZsWl5efHa8GEUAlirR8xVZ8s4wEyGcoE4druwZITP5ZictCM
         7ltMu6VzXMwLjfnZ97gcnzN9OHY+TW5oHiCRSIdRnJVSjQXOEbOnDaH2F06JDRsGeP+w
         fFdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774843592; x=1775448392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANSTIj2ghfnzM/RxEUip18MYygu8NsG4n16CnyfeffM=;
        b=NeV94L2xOUcsyLREuHF7bqqsnfn/lLfCDVo0E9lNvJtTESQSMKFJr1agnmuNIKwZJZ
         pUqoQ9ls9QEe0LPYI3ylJekycaytyPPWEcP4gR4Or+r8lRiql+13DLVuRNzU3m7ga2jq
         9QDQ6RS4nUvctwt1H3w4XYkJyntj1/JaEhXDGbm2yHbpELP4o6afcZ+ENULYWK37CMF7
         55yemtxFYJ8H2DTtLPHch1tojB5Z7wNXX9VfifU93TMDqzJeu7Mk2xl2Xm6zovp+BeIA
         vyt2AIqkv+j9aoliiQEIIFn1C4qxxb+dbVJLWigTk7NUr3e+V5IqA2qc+aYwY9spOwW7
         gauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774843592; x=1775448392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANSTIj2ghfnzM/RxEUip18MYygu8NsG4n16CnyfeffM=;
        b=C+0iFHzgf2OXvCma0++UyJ4FhFmUTcY7QIYdpMD9bEDmuX46tXFiVJ3pgStcu10zVs
         WBRefSu7n4ahUa8Z5PfieQYZVIXYZfqLSdeVIxUW8a6PLxztZNTM5UNdRPSvv5J5Move
         0KFq1NuBHlzPqEolzsH/JA3bO38yWdhZ1AN7x4F9qMJ6GN7SzaGRwA8z0hG/DWgKCM1Z
         178pDRjUiS1pHCeS86Lw8fR9VX6TGLNQeposCAeBz2nxvTsCykYKpJgeXLjlaRLUK+9e
         Y8XD3OhTDJu/GHTsRCRPa0eeoeCsaSie1b31RgwaOBsZn9E4T6zSXAev1tVWZyDQCAj6
         eMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+ZpaW6EpNbL6DYt5+9C9WcgxcASEAlRfRPJBgpQt8zlrOeOZPrpOcdu1egjk5fOGU3qoiXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf6mbjSYTYMkb/SIVMIhnyAYnI/fwOEIxfb3J7tBplqwK5efo
	P2+lel8REFnk1lUssHsVNun9lpWvPxOeXGl8jxZyeZrLwXGGik0p/sfxql4z5zhwOdglTrUXhFh
	tlMmNKppNxBq0dDu9Ym5+BBph1WDLuQsteZJNh49H
X-Gm-Gg: ATEYQzxuRRU5XnXbXb9mwJuvUOP4xpZA9oSwwhSbfcXdhvyksZ7PuCcxeAnmRutFGOs
	z9gs2UjvWqA2M29zrffM5B04fji43VWCijdI6GLg8fKdCg5FXJZ9m29F8xrN9T8tIIfttPpeyrS
	y1fM97O0LMp6FmMRC9tpPbkJtmWQSwMIrGVKniZFn7ulj0B7S0MIL6QejtjvF1a29AUVC2HDHZh
	XHhlNJm7WK+VKY9+XU2K4/PjbPCdShG7oMhRD7F2xTRlHCuOvkNLVvfj2c2e8acgH7jWFhP0Fww
	yzduESxf
X-Received: by 2002:aa7:de08:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-66b77dd2b17mr43670a12.3.1774843591510; Sun, 29 Mar 2026
 21:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-3-hramamurthy@google.com> <20260329211958.2875749-1-kuba@kernel.org>
In-Reply-To: <20260329211958.2875749-1-kuba@kernel.org>
From: Jordan Rhee <jordanrhee@google.com>
Date: Sun, 29 Mar 2026 21:06:20 -0700
X-Gm-Features: AQROBzBMJtnnH1U1d8TwEconh8nST4K6FhXcxnxYTqqrN-i8ss0W-6FelFSD4LY
Message-ID: <CA+mzVtva2=Ymxeco9n-o=PL+m1jJ4J71MVEvMUjW9U-nZja=Qw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] gve: make nic clock reads thread safe
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9418C355284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> gve: make nic clock reads thread safe
>
> This commit adds a mutex to protect the shared DMA buffer used for receiv=
ing
> NIC timestamp reports. The lock is needed to synchronize the periodic wor=
ker
> and the upcoming gettimex64 ioctl.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/et=
hernet/google/gve/gve_ptp.c
> > index 06b1cf4a5efc..140b8fbce4f4 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
>
> [ ... ]
>
> > @@ -109,6 +114,7 @@ static void gve_ptp_release(struct gve_priv *priv)
> >
> >  int gve_init_clock(struct gve_priv *priv)
> >  {
> > +     u64 nic_raw;
> >       int err;
> >
> >       err =3D gve_ptp_init(priv);
>
> [ ... ]
>
> > @@ -125,17 +131,20 @@ int gve_init_clock(struct gve_priv *priv)
> >               err =3D -ENOMEM;
> >               goto release_ptp;
> >       }
> > -     err =3D gve_clock_nic_ts_read(priv);
> > +     mutex_init(&priv->nic_ts_read_lock);
> > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
>
> Could this lead to a race condition with userspace?
>
> If gve_ptp_init() registers the PTP clock via ptp_clock_register(), the
> device is exposed to userspace immediately. If a userspace process opens =
the
> device and calls the gettimex64 ioctl before the mutex and DMA buffer are
> initialized here, it could cause a NULL pointer dereference or operate on=
 an
> uninitialized mutex.

Ack, will fix.

>
> >       if (err) {
> >               dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n"=
, err);
> >               goto release_nic_ts_report;
> >       }
> > +     WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
> >       ptp_schedule_worker(priv->ptp->clock,
> >                           msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS)=
);
> >
> >       return 0;
> >
> >  release_nic_ts_report:
> > +     mutex_destroy(&priv->nic_ts_read_lock);
> >       dma_free_coherent(&priv->pdev->dev,
> >                         sizeof(struct gve_nic_ts_report),
> >                         priv->nic_ts_report, priv->nic_ts_report_bus);
>
> Is it safe to destroy the mutex and free the DMA buffer before calling
> gve_ptp_release() here?
>
> If the PTP clock is already registered and exposed to userspace by
> gve_ptp_init(), this error path frees resources while the clock is still
> active. A concurrent userspace ioctl could access the destroyed mutex or
> freed buffer before gve_ptp_release() unregisters the clock.
>
> Should all resource allocation and initialization strictly precede
> ptp_clock_register(), and the error path unregister the clock before tear=
ing
> down the resources?

Ack, will fix.

> --
> pw-bot: cr

