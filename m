Return-Path: <netdev+bounces-274673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOOBCErCzmmqpwYAu9opvQ
	(envelope-from <netdev+bounces-274673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:23:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FC38DA37
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7715E303AF90
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D349333440;
	Thu,  2 Apr 2026 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnTERyGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECD35958
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157749; cv=pass; b=H99LzdizlCDzVdwRlun95pgjpJFeZOqL6a4MevZcINpqkfdMKOkhDeiJoRKmxcjx7A+3w/eJoQpwkHvzhExwI9qt+ee2DlYm+YLDRSXl9iS5Mkp7sMiWiY8nI8AG51/9X1opyEpXUkZJxMXmS4KuPupqAA3x5rq4REAPwGk6o9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157749; c=relaxed/simple;
	bh=cQrixCzgQ4H0I5sRm31clp6klAihQ3kGYJ6qIWoBe9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1fLh2qRJxb73GO2aTIEwWtpWDacaU70J6WyzgzjaKEzKqyCD2xhdEF03gdvn42z8ncO+fFCF4f/pqPJx/ruwjsnSRjX8TsH9r11pzkj2+qc1EAjeDUVajKkcOaJswOn/acOTzDzSr/BTn4fHVqRZv7NxkcYSgQlnjGMLCPt55I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnTERyGm; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so2234166a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157746; cv=none;
        d=google.com; s=arc-20240605;
        b=O2b0pJJD66IZ0UqRI+sau+USp1J2mt5TJRosmkJkIGn3pTfMkL/IOvRdmWblx0MuWM
         ih62q0jaDXfCbfODOR2+R4aCC6u0s+rF9uFsoXpc38FG3BYL0dGKsKztrcswTp6ZCdjc
         DCM64QJp7C7UGKPS0Hyo5iXxvx2G0Rw6KsYWMzOSE8hcGzwvXwPKqMJK4AWSoU4AkGSQ
         yvhtBsNRs/tlY63ZTmlbzKanwQEvbeHdlTxkH3RkzLMjlke1Hf2sEXZwXg0m71wmBl6N
         7t+iBE6eNo1RNRq3mwdlW4SGqCkmPkWXq895xpoKPmwLNnZMG26UcWPuSe7k1QDNWv+0
         7lfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        fh=LTsHuVPTCGhO+Ebyqc4Gz08vRg16RCNdIxYr212k4l0=;
        b=FRFAGv84JORPJKqnmAzMazmtzsCYZ+HsSnUvp3E+yYit8YH6Nrp49TZPNkvRsPgDnP
         HS2GsXxaPebKy8Ay/YxTTt+Xuo+w4ALnD/0VyfBqO7bJVzgOLtQIib6Vjk85lP8/Pk0+
         2Vr/6ApqxjVVYOQcGX9kHGa5adABy5BS/bDCLohKJ0nNw99oTCYpLysaOTlPJ5Z5XULa
         PewxoOnhHumCav2fBPRicd7WbE0zPQawt3fAaO6ZOpxsoX+19DmTkJvxigwd1jXENmpy
         GD0iaXEzu2L8d7irLeTl6FPfyPuZgEgqkIhY0sAC9q0ZohGXd0Pm1AiLFogmf9DBkVtX
         9oAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775157746; x=1775762546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        b=rnTERyGmIG0pO+TWLhuRVrGOz0JtK7qzUNnhBDMgXB0ZJ1folYeWGXk4Xh19Aq7YKb
         YjFP7oaqNVMTCFhbvjb6xp4+hM55x436kerphlRZlulIpiVd1ZzMhY0aTPQ37Or1pSZC
         eYIFlZeqSlaDXMxfU8n68wz6kjiLO131/5mFf81vyn5hlM7b2nrqYy27/jRGuRTb53Lz
         uKN1ZmJsQIH7wGyOF/oVga5h33wTLPpJLuetdi+suvK3C32Fc3joERQcEzwV3WLnyJsu
         EB6Upcvfqp7VOyvn1qyfvJBEqfhd+edyYGvUrsrexxv+stf5dNFBGAioSqwq4vToRLRo
         gl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157746; x=1775762546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        b=UMx1Cwc/pdgLomypjvfKEUFaZ0HYQY0gPlAR+OlrS6RAbAlKNulimW0ywGGvUDEJvf
         khmDMCl4ZEUQCveEOoQAsCOR2v1VtbT5aO6Lo4EVgBRux6d1+vqBn8wHNzMWixt9I98A
         QOqgLMIwuOek2tWS7JTiSOoWDDNMU6ULZLexaAqJCDzQqrz3TahXRv3nOD1ydksYYS/5
         no8eq0j5RzGmO3mcqoT0QjSQ18ORPKiZZnVhFD15TheBHis6eZeKIUCBAS/f+14233Gb
         pWRFiklHaZg7akLQ3AvKEId6IuHEursIFVnITqxxIQm4J1hBidb1NHVDzWikOmqhukwb
         jrpA==
X-Forwarded-Encrypted: i=1; AJvYcCXg9zQuSIx9b0eJYLqjt5gdJo+jMqzZAvZvyQ0Q3p6h8GuKl6V00U6RsP9uL3atDKFjulwQztk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmKnpt30K/7SMgJN+Zm5lEG++4ge6gUM1oZNbyiOMFUhmps2V
	hkRnSipVOKfVFI8ihDq2vJyhRbPRVUEtBnBHcLzZHcy9HWcKUJ0rl0Z+sCYAO7mLU15beBSexbI
	AEAEWb4xFIGJ1BRobufdwG7aPD4j4QZV3NGRLID0=
X-Gm-Gg: AeBDieuZTB9MuIB9FHL39hTJ7sZr8KaKA2o2Q2/ILY/Ar3NLEa8G1f/IOJeEoo1YpVG
	+AH4bXP8qogh5xtP8Y8e2XEwrvAAppp9uzJP0l0LqLq4zxNTJfroMmKX9Iu1JPfR/yG2ns2Gx1R
	RAvTOsPIy1XElWixfQ4fSVbWA+tS3BoGbFaAmxY+sdfHQe20yL2CJVy72NX2x0pOVN/MnK0Al/l
	8zvoaXplezlOLs4RKZvS+TzVcy8sriQUTz9F6T0QYJLCxBpEd0cZWN55pl9cJ265iFULy8lvuox
	cs2mfogNQObpNFZ4Gw==
X-Received: by 2002:a05:6402:3719:b0:66c:5a46:b7fa with SMTP id
 4fb4d7f45d1cf-66e3f2bde49mr169822a12.5.1775157745469; Thu, 02 Apr 2026
 12:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402044637.73531-1-laurencerowe@gmail.com> <ac47PYPeL0IyRtY6@sgarzare-redhat>
In-Reply-To: <ac47PYPeL0IyRtY6@sgarzare-redhat>
From: Laurence Rowe <laurencerowe@gmail.com>
Date: Thu, 2 Apr 2026 12:22:12 -0700
X-Gm-Features: AQROBzB2-Dau1-MNR3xqc_SHA8HQW_z28I2FNnIn6XVrVmtXCPSjbV8KbrcIedU
Message-ID: <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274673-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurencerowe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF6FC38DA37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 5:03=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:

> >Scheduling a timeout for a non-blocking accept with an empty backlog
> >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> >of microseconds of additional latency per accept loop compared to
> >AF_INET or AF_UNIX sockets.
>
> Not related to this patch, but should we do something similar (in
> another patch) also in vsock_connect() or doesn't matter since usually
> it's always blocking?

Looking at vsock_connect it's not immediately obvious to me whether it
is affected
in the same way. I'll capture some ftraces and follow up after
updating this patch.

> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 2f7d94d682..483889b6d8 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, str=
uct socket *newsock,
> >        * created upon connection establishment.
> >        */
> >       timeout =3D sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
> >-      prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> >
> >       while ((connected =3D vsock_dequeue_accept(listener)) =3D=3D NULL=
 &&
> >-             listener->sk_err =3D=3D 0) {
> >+             listener->sk_err =3D=3D 0 && timeout !=3D 0) {
> >               release_sock(listener);
> >+              prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPT=
IBLE);
>
> Is it okay to move prepare_to_wait() after `release_sock(listener)`?
>
> I'm worried if we can miss any wakeup. BTW if this change is okay, we
> should document that at least in the commit description.

I'm not sure. I'll swap them around so they are the same order as before.

>  From checkpatch:
> CHECK: Comparison to NULL could be written "!connected"
> #58: FILE: net/vmw_vsock/af_vsock.c:1870:
> +       } else if (timeout =3D=3D 0 && connected =3D=3D NULL) {
>
> >+              err =3D -EAGAIN;
> >+              goto out;
> >+      }
>
> What about simplifying this with (not a strong opinion):
>
>         } else if (connected =3D=3D NULL) {
>                 err =3D -EAGAIN;
>         }

That definitely seems cleaner.

> Also
> https://patchwork.kernel.org/project/netdevbpf/patch/20260402044637.73531=
-1-laurencerowe@gmail.com/
> suggests to specify a tree (net-next I think for this change) and be
> sure to CC other maintainers (scripts/get_maintainer.pl can help).

Sorry about that, first kernel patch submission. Will do so when I
send the updated patch.

Laurence

