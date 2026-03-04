Return-Path: <netdev+bounces-264076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAKAMkO6qGkdwwAAu9opvQ
	(envelope-from <netdev+bounces-264076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:03:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014B208D6F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB70301A70C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781A37B02B;
	Wed,  4 Mar 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC7bgrvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624237269A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665409; cv=pass; b=guChreoEQ2k661aTh+08Dmbd50aYWo3c5blM7R+4G/CvzzFvnBbls+cNVeagC9X389nnJbOWGALDjq8b2yZp89bPu05mrcy+TmOtMjpyITP0XjCZnmamQPXaqjZJMAqEoeDT42iy/jhYf+IQk8jt7zavw1lHiqs0wygY8aVVDBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665409; c=relaxed/simple;
	bh=2i+IHSwXdo2vJdP59dU99G2iRMYrlyhf0Di7pAHPdxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV+1tUXT3sC4KYhEIBzQB5K0m5Wnv1wOCR36L+5DHIzhFTj9L6qT+VIyjTrwwR7UYGv3jdKczY4TO8Vu3MgIy/Y+0A6b/fiPVxFmT++qaTBIca6QrbB9Ck8kar4BPErZtrAMsssBUnjfjQYl53T0agbh13MccE0Oxli8VQc3uDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC7bgrvx; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ff14dd9be4so5100057137.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772665406; cv=none;
        d=google.com; s=arc-20240605;
        b=ebtF7jtndzNbGIs1GKgwhjPQstYH6t+TnruoSjU3jLyW2Uzf/eDksiU7FaRO3NO+Ey
         F3ZACtmH7y+unu2xlXXsgLJmoO7H8ZAJrTaGcHzXQCzCoEry9xHvAwzQlvBvk0OnVo+v
         NQ+p8ufa01cdc8Y/47XDjV9ZoDnVfiAJBq4Bw19gvzuKmYq/tCjrLxbfXjRaNdnPGOVT
         gpHti4HlXPV3PRkl3uilkBZt4xH+D2Cdhv5fjncqR1ii3kjIA4HdWG3jZqTZI6z5FEwV
         dNgU9AQOWPM1tMlODVy2imJYVk6dIP5M0/HyyL0p2b/gvTXe+QB6ckgzawIAd03SeifD
         3IOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ivkx6puhgdlm/jw1xcgfFyqPx3PkaCKD+eg0EyAqi2E=;
        fh=mAPP7F4vHZ2x9R6n/fh9fU6WOmrw6N/Ij0TWsOHmuKA=;
        b=R0t8RWRNfQsYg7eITQYAhI6DDDAUM0DaPxhApLpmyuU8asSO7wrZU5imRrEP/ZKHmz
         Li038DxAoDVA6aE8tO5nBZiQyNAByezBnLJcR8wuH/y6HopLhak5P6CXxQc25dG/e2gC
         PRsSQ6Cq8Rji4NWgiSmDq4Dw07Xk8VcqWMhR5hyrZFWGc56G/vdj6/1A0xHIvCGQ2LT9
         FEs1x24h941v484Gf/C7YjERNj7aZay+TJbH50PF68xK+dNsBnzfwhcCxNl6UvSt8sA3
         ZlO5jbffns8haIq5qLb3UBJhYUz876n721YZwbi5efpxWuOu5O3okdPAVi9iwRN0YPtG
         TWag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772665406; x=1773270206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivkx6puhgdlm/jw1xcgfFyqPx3PkaCKD+eg0EyAqi2E=;
        b=cC7bgrvxkIsXlGlwT6cNLnNmWRB8elw0aW5/2nK3ozQ/1QTqWz5fQ6Q9r4BaBwCoji
         trv6yvN8+je5RUmO4Iqxa5DsAZfnHovcxfHkeoOFOK/yVjVMZ1vZ3c8Qj09bhi7ycWk8
         Zua+We+8NS8W5zjYIs7wqX+WaFahFzDSn8ltSU9uGbrKxO1FftCwNFQIgNnXrduVL/kU
         gQEXZ6hXqB3YPDgUSCAoAKvtVpFMU3TNC6HXyaLDm0aHd4UTH75AfLfd7t31c8VAouq6
         qVifOOYuXg3cqbBuWBXMBcQIlO7w1H8TewoQDfHan8k4R2qW28c16AW4TT5Wsl0MBNNO
         x6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665406; x=1773270206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ivkx6puhgdlm/jw1xcgfFyqPx3PkaCKD+eg0EyAqi2E=;
        b=ZbzCCAR0d8eRsX322DyZQjqw/O4Ag5ogBu3N2qtn/GekZXe/WfCl4rfcKennhrYO1S
         CdSqlLLoBZfsdguhxFULJOM+jBuWjzFqJIViojTOBApVd7JwCBS/cKp8xDnXusRMdNbn
         dq68WZ4eNrDwuMSXM2uxREHKgnKvvA5hJCuFdiNETUERVaT6uoGO1PWMca2EF57VKgIT
         qbAEhGepGnHmwLRdo5yj7wvOJ9wibrxtdqXD5oi3daismx/WNqw+qFHjjZK/yqtrwQzU
         yil7U41S3DS4b+tiToC5mIrp3jXUJojVAcYrkVg9wuxge19rVGNinfUqeNa9oyvpkpcP
         jpXA==
X-Forwarded-Encrypted: i=1; AJvYcCUYarpr2+Ph964NZCTjh8evG/9kBf7zNAD4Hrr/RKRrF4igR9T7hdEH7wxVkxUdZsdbz6XIRKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9eEQGDK+oPweZcmJFWOK6uuH/CEVIL+hbj0t3DNeNpqMdLP/x
	lXA2PGq2isSn90poOHyknhB/JSz8enu94SGzmphb8Dt7tDAkLBVyVeeaP+I4gBylnKP+gHBNE2D
	Dch+AsBv3FdcvcM6yL2x2+J1gD52iY5A=
X-Gm-Gg: ATEYQzxyaamGSJ5BkXU+jCTQTMBLv6VaCV3Hg8EKn3Ur0vsfdgmENjPW+C+LOgSxOIz
	9Rw9X1ZjXUPQ0n67l+KjidO2yD5ZV7EJMZJhJ8HpsbeKBT5BILfZXiltJ4/BtBy9soszw28sNgr
	Nf/aKu8GSxlwFbXMO0EmKphFFs6ukPcH5kG8UMbtxdLpGQKhpcxgDXdPJ0Xbu4wWvIGCKyF50+u
	VpNN1Wt4KVp+qMDAb9c0BBohNfNLD38IiLogCcmBYqBsE8RoVLlr7TeIBu9VfWvqGCAPPml+85E
	tXY1BSRFg2plzARr3sHdPyxBsvhYzoEX89+0pze3WTp38AgontjeNJweRqurnOIySobtnqQ4NHM
	rKJreEQ==
X-Received: by 2002:a05:6102:26d1:b0:5ee:a8c4:18d4 with SMTP id
 ada2fe7eead31-5ffab04169amr1874568137.35.1772665406379; Wed, 04 Mar 2026
 15:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bffaab8d4727991c8dd46c8b57a08507545a25a4.1771986861.git.lucien.xin@gmail.com>
 <20260303083324.35531-1-pabeni@redhat.com>
In-Reply-To: <20260303083324.35531-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 18:03:14 -0500
X-Gm-Features: AaiRm53WpBr8gTUmyaCTW1p2ySTbZ_Gi0kG47wju22GuqYXLQHQ7psn2_WgPq2w
Message-ID: <CADvbK_f96OxCWnP9UdKxYtJ9=3xY69_ScTrU=9AQF1iUrBp_Cg@mail.gmail.com>
Subject: Re: [net-next,v10,13/15] quic: add timer management
To: Paolo Abeni <pabeni@redhat.com>
Cc: hepengtao@xiaomi.com, kuba@kernel.org, jlayton@kernel.org, metze@samba.org, 
	davem@davemloft.net, kernel-tls-handshake@lists.linux.dev, horms@kernel.org, 
	hare@suse.de, aahringo@redhat.com, tfanelli@redhat.com, mail@johnericson.me, 
	andrew.gospodarek@broadcom.com, linkinjeon@kernel.org, dhowells@redhat.com, 
	matttbe@kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	jbaron@akamai.com, quic@lists.linux.dev, pc@manguebit.com, 
	marc@fiuczynski.com, edumazet@google.com, alibuda@linux.alibaba.com, 
	steved@redhat.com, illiliti@protonmail.com, tom@talpey.com, 
	marcelo.leitner@gmail.com, sd@queasysnail.net, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, mbuhl@openbsd.org, smfrench@gmail.com, 
	chuck.lever@oracle.com, daniel@haxx.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3014B208D6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264076-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add timer management
>
> This patch introduces 'quic_timer' to unify and manage the five main
> timers used in QUIC: loss detection, delayed ACK, path validation,
> PMTU probing, and pacing. These timers are critical for driving
> retransmissions, connection liveness, and flow control.
>
> > diff --git a/net/quic/Makefile b/net/quic/Makefile
> > index 58bb18f7926d..2ccf01ad9e22 100644
> > --- a/net/quic/Makefile
> > +++ b/net/quic/Makefile
>
> [ ... ]
>
> > diff --git a/net/quic/socket.c b/net/quic/socket.c
> > index 74e3e3939c61..93a7abefc226 100644
> > --- a/net/quic/socket.c
> > +++ b/net/quic/socket.c
>
> [ ... ]
>
> > diff --git a/net/quic/socket.h b/net/quic/socket.h
> > index d7811391cc8b..c5654fdc06b5 100644
> > --- a/net/quic/socket.h
> > +++ b/net/quic/socket.h
>
> [ ... ]
>
> > diff --git a/net/quic/timer.c b/net/quic/timer.c
> > new file mode 100644
> > index 000000000000..6f957385a341
> > --- /dev/null
> > +++ b/net/quic/timer.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* QUIC kernel implementation
> > + * (C) Copyright Red Hat Corp. 2023
> > + *
> > + * This file is part of the QUIC kernel implementation
> > + *
> > + * Initialization/cleanup for QUIC protocol support.
> > + *
> > + * Written or modified by:
> > + *    Xin Long <lucien.xin@gmail.com>
> > + */
> > +
> > +#include "socket.h"
>
> [ ... ]
>
> > +static void quic_timer_sack_timeout(struct timer_list *t)
> > +{
> > +     struct quic_sock *qs =3D container_of(t, struct quic_sock, timers=
[QUIC_TIMER_SACK].t);
> > +     struct sock *sk =3D &qs->inet.sk;
> > +
> > +     bh_lock_sock(sk);
> > +     if (sock_owned_by_user(sk)) {
> > +             if (!test_and_set_bit(QUIC_SACK_DEFERRED, &sk->sk_tsq_fla=
gs))
> > +                     sock_hold(sk);
> > +             goto out;
> > +     }
> > +
> > +     quic_timer_sack_handler(sk);
> > +out:
> > +     bh_unlock_sock(sk);
> > +     sock_put(sk);
> > +}
>
> [ ... ]
>
> > +static void quic_timer_loss_timeout(struct timer_list *t)
> > +{
> > +     struct quic_sock *qs =3D container_of(t, struct quic_sock, timers=
[QUIC_TIMER_LOSS].t);
> > +     struct sock *sk =3D &qs->inet.sk;
> > +
> > +     bh_lock_sock(sk);
> > +     if (sock_owned_by_user(sk)) {
> > +             if (!test_and_set_bit(QUIC_LOSS_DEFERRED, &sk->sk_tsq_fla=
gs))
> > +                     sock_hold(sk);
> > +             goto out;
> > +     }
> > +
> > +     quic_timer_loss_handler(sk);
> > +out:
> > +     bh_unlock_sock(sk);
> > +     sock_put(sk);
> > +}
>
> [ ... ]
>
> > +static void quic_timer_path_timeout(struct timer_list *t)
> > +{
> > +     struct quic_sock *qs =3D container_of(t, struct quic_sock, timers=
[QUIC_TIMER_PATH].t);
> > +     struct sock *sk =3D &qs->inet.sk;
> > +
> > +     bh_lock_sock(sk);
> > +     if (sock_owned_by_user(sk)) {
> > +             if (!test_and_set_bit(QUIC_PATH_DEFERRED, &sk->sk_tsq_fla=
gs))
> > +                     sock_hold(sk);
> > +             goto out;
> > +     }
> > +
> > +     quic_timer_path_handler(sk);
> > +out:
> > +     bh_unlock_sock(sk);
> > +     sock_put(sk);
> > +}
>
> [ ... ]
>
> > +static void quic_timer_pmtu_timeout(struct timer_list *t)
> > +{
> > +     struct quic_sock *qs =3D container_of(t, struct quic_sock, timers=
[QUIC_TIMER_PMTU].t);
> > +     struct sock *sk =3D &qs->inet.sk;
> > +
> > +     bh_lock_sock(sk);
> > +     if (sock_owned_by_user(sk)) {
> > +             if (!test_and_set_bit(QUIC_PMTU_DEFERRED, &sk->sk_tsq_fla=
gs))
> > +                     sock_hold(sk);
> > +             goto out;
> > +     }
> > +
> > +     quic_timer_pmtu_handler(sk);
> > +out:
> > +     bh_unlock_sock(sk);
> > +     sock_put(sk);
> > +}
>
> This isn't a bug, but the four timer_list-based timeout callbacks
> (quic_timer_sack_timeout, quic_timer_loss_timeout, quic_timer_path_timeou=
t,
> quic_timer_pmtu_timeout) are structurally identical.
>
> Each extracts the sock via container_of, takes bh_lock_sock, checks
> sock_owned_by_user to conditionally defer via test_and_set_bit/sock_hold,
> otherwise calls the handler directly, then bh_unlock_sock/sock_put. They
> differ only in the timer index constant, the deferred bit name, and the
> handler function.
>
> This pattern could be consolidated into a single parameterized timeout
> callback using a data table that maps timer type to deferred bit and hand=
ler
> function pointer, reducing around 60 lines of near-duplicate code to
> roughly 15 lines. The TCP subsystem uses a similar approach for some of i=
ts
> timer infrastructure.
>
> That said, this follows the existing per-timer-callback pattern used
> elsewhere in the kernel networking stack (for example, tcp_write_timer,
> tcp_delack_timer are also separate functions), so this is a minor style
> observation rather than a defect.
>
This is a good one. May not add a data table, but a simple helper like this=
:

static void quic_timer_timeout(struct timer_list *t, int type, int defer,
                               void (*handler)(struct sock *sk))
{
        struct quic_sock *qs =3D container_of(t, struct quic_sock,
timers[type].t);
        struct sock *sk =3D &qs->inet.sk;

        bh_lock_sock(sk);
        if (sock_owned_by_user(sk)) {
                if (!test_and_set_bit(defer, &sk->sk_tsq_flags))
                        sock_hold(sk);
                goto out;
        }

        handler(sk);
out:
        bh_unlock_sock(sk);
        sock_put(sk);
}

will reduce quite some dup code.

> > +void quic_timer_reset(struct sock *sk, u8 type, u64 timeout)
> > +{
> > +     struct timer_list *t =3D quic_timer(sk, type);
> > +
> > +     if (timeout && !mod_timer(t, jiffies + usecs_to_jiffies(timeout))=
)
> > +             sock_hold(sk);
> > +}
>
> Can this function handle QUIC_TIMER_PACE safely? It unconditionally casts
> the result of quic_timer() to 'struct timer_list *' and calls mod_timer()=
.
>
> Looking at the timer API in this patch:
>
> Both quic_timer_start() and quic_timer_stop() have explicit QUIC_TIMER_PA=
CE
> guards that dispatch to hrtimer APIs:
>
> quic_timer_start():
>         if (type =3D=3D QUIC_TIMER_PACE) {
>                 hr =3D quic_timer(sk, type);
>                 if (!hrtimer_is_queued(hr)) {
>                         hrtimer_start(hr, ns_to_ktime(timeout), ...);
>                         sock_hold(sk);
>                 }
>                 return;
>         }
>
> quic_timer_stop():
>         if (type =3D=3D QUIC_TIMER_PACE) {
>                 if (hrtimer_try_to_cancel(quic_timer(sk, type)) =3D=3D 1)
>                         sock_put(sk);
>                 return;
>         }
>
> However, quic_timer_reset() does not have a similar guard. If a future
> caller invokes quic_timer_reset(sk, QUIC_TIMER_PACE, timeout), mod_timer(=
)
> will operate on memory that is actually a 'struct hrtimer', potentially
> causing memory corruption.
>
> Should quic_timer_reset() either add a QUIC_TIMER_PACE guard consistent w=
ith
> quic_timer_start()/quic_timer_stop(), or document that this function must
> only be used with timer_list-based timers?
>
There will be no callers to quic_timer_reset(QUIC_TIMER_PACE), so no need
to add a check for QUIC_TIMER_PACE, I will leave a comment there for this.

Thanks.

> > +void quic_timer_start(struct sock *sk, u8 type, u64 timeout)
> > +{
> > +     struct timer_list *t;
> > +     struct hrtimer *hr;
> > +
> > +     if (type =3D=3D QUIC_TIMER_PACE) {
> > +             hr =3D quic_timer(sk, type);
> > +
> > +             if (!hrtimer_is_queued(hr)) {
> > +                     hrtimer_start(hr, ns_to_ktime(timeout), HRTIMER_M=
ODE_ABS_PINNED_SOFT);
> > +                     sock_hold(sk);
> > +             }
> > +             return;
> > +     }
> > +
> > +     t =3D quic_timer(sk, type);
> > +     if (timeout && !timer_pending(t)) {
> > +             if (!mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
> > +                     sock_hold(sk);
> > +     }
> > +}
> > +
> > +void quic_timer_stop(struct sock *sk, u8 type)
> > +{
> > +     if (type =3D=3D QUIC_TIMER_PACE) {
> > +             if (hrtimer_try_to_cancel(quic_timer(sk, type)) =3D=3D 1)
> > +                     sock_put(sk);
> > +             return;
> > +     }
> > +     if (timer_delete(quic_timer(sk, type)))
> > +             sock_put(sk);
> > +}
>
> [ ... ]
>
> > diff --git a/net/quic/timer.h b/net/quic/timer.h
> > new file mode 100644
> > index 000000000000..61b094325334
> > --- /dev/null
> > +++ b/net/quic/timer.h
>
> [ ... ]
>

