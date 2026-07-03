Return-Path: <netdev+bounces-304510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b0OZOXmaR2oDcAAAu9opvQ
	(envelope-from <netdev+bounces-304510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79753701BB4
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lnkwVr/9";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304510-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304510-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67AC03065A39
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269F3B6BF9;
	Fri,  3 Jul 2026 11:12:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAD3B3883
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:12:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077140; cv=pass; b=M76MmMwZ1XrB2Isw0Y5u3W4BBF7aA2jLeUOKorpbVVki5fEdpUic1IuUUleh3f9nb+Udr0yBe6PDwW6/pEk5aHjlFija4LMfD3YmKdiH+5X+LDBPReD9daDWmcGvx1QpYv/SH5ShEqyY5kSc6WQuElg1SFdomCGgQJeNEgHGTMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077140; c=relaxed/simple;
	bh=fBfNO/FZ4Kkf6B1oz6DiRpDdiAAh4LKfzlsZE2dGZAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYbVN/Fv6ZGsc4+l/6dVbyH5yM1xgwukiZAaXZlrPVCZ+eD3AnRWi0GSsjZc6z9zQGJN03L7427fk99G26Sc5KzYhyYE6gmV4v8Hq5QEvYQJoKYdQVvqTzuO3zKW4T87xi+vvt3/JaqPlQLKJ0LLvi5igie0/QL3ZJZT4XCRxoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnkwVr/9; arc=pass smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacd69a9c0so3496655ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077138; cv=none;
        d=google.com; s=arc-20260327;
        b=TZyALYZWHlU5M126fYpXmhl0sIq67FcRmCMd51VU9X1hPePNp8N1jBuBp1QgX1TU9M
         hNk5fGiLEskZheQ7kxvweyBC1flSEhSaNgtjxM/hB3eL1vDssBtHNYl1h6zrs+IBP/wa
         fL2UQj6ggKiCcP6notR2jLpSR90DOD/q9GnO3veKkYA171h2eNUeKfoqhV29+gySH38w
         IbPgRb1rA4Z+HtCQZ4W1m81qOtZAjBDoOjPp9w725qcNDZikx1lg+v0nIALduFHSXJyz
         j+giysjwdCLTO8eiwdXki1uunF4a2GKJovRJ3W7qdspNJM4r4CFjuJPUp7mqPdrPxoWv
         bWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PEtXaQw946Gm7yJHwMUZr6fnL8pi2CISGQOoSZ3j8Y=;
        fh=XE+vXfHYXC046lt+b0In2ZXZD5QST49KH1O6ugWN3tY=;
        b=SmHy6DRQqsXf9cCaIkYM9duVN5MJcQusL46l8SklEUTIK5gIAyi+XJq/FhWPHAA75s
         4ixtH9bj9WvnG4aWV4MvrYSBHEd4sPJ+ZFb4fuMMaN7L8UrEDub9xZj+VWcOvVQrzygt
         9tN2eHBFFfVT/DT2GoxDuiu0F9YXDmvXbiq+Fy9EqMxdCprXubcw/crN9hZAcpxE9DHU
         G4vXBAtQM/43XYetqx3r/v6WWtDPxdUOpNmtFrnbM4F/TDeFWLIbp11Ofh5qmOhElgXL
         Au3vet0Zvr27qRdPtHk9+Mz0WWX91XmBeMoaj4Oqq6t33qz1rachqGj49AAW2gWFS9m1
         ZeIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077138; x=1783681938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PEtXaQw946Gm7yJHwMUZr6fnL8pi2CISGQOoSZ3j8Y=;
        b=lnkwVr/9gVVtopLNnjPvxMyuf1z+Ftsk4o+e31uUe5ge2AF/24marnDSPPZXNHVr98
         2uaLXpk/uSvpm8YPTJtBi1UjOCckJvL6qtPr5/CJ3OhnyAQMfEYJ04HB0t+JAP89yNtO
         f0mLUmPvi7fVEyEkEp+ynxjMNwIs4uFYYhY77CkXMinWvYAQk6kxAZfkgpzw28fb1Z9s
         jc0O9gAEIvhQ44nEiStxPYS8KNObNC36ERyY8ekricKeb3Fp2ROpRD9kJ42KtczQIX6c
         2FpxCJbsnqyCUwh/BBWNa4wbVS7MlT4LUxljh+lSSxhMvHlH1v9MhGArbZtrCcMO/gqZ
         Uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077138; x=1783681938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PEtXaQw946Gm7yJHwMUZr6fnL8pi2CISGQOoSZ3j8Y=;
        b=Qgc8TOEKUFvePrStVm7qibafSjhqefUlt5q6chaywE/e3unUF0qlUT5r9NfsNigajq
         UUpz5IRpQgI0c4+CVfRfYjYKFZ7tmsg9eiQl+jkEq9QNUWsQKjOf+prLBs86I67KAWso
         43qGIgggdXoI05H9rA8Ug0OH+f9G8gRNiQBf19vfjtl66JtX2vv4+KiznW6X2PJFwCkR
         8HlfzYSSIscuJJQLaN/J9mwTTQdhzS5dPeVsHshpRdyJmnDSh7uNHfr+LmullxCp//np
         d+JbjrknE/9sABGLtd7ZvgOfqrG6sOIYU+hh61OIT8wshSuJwin4RWXXNr1DWMix63bA
         gYgg==
X-Gm-Message-State: AOJu0YxK5bE8rDLK9JQxvayTCPYz3wuxtpKbp2zOTGLnaAkYSbqrKzT+
	6uj1cUdt8It+xe4wWHpe4m/pFLpmCh0Va/B85La0MyDfAbDgWGcZuPGB1RR7oVe5zq0IB2hKD5H
	3USQ4ZRvNg1nG8jnW60bSbIzy9kH5JI4=
X-Gm-Gg: AfdE7ck5lQCKr4f02JVD9hYDuSChPinzvsRFUILaC5yEgyzv5sSN16lrme6f7iovkdn
	Z3CV9nRXQDC9uIFLnB677X+OEljaGx0XVmwwXdUa88e1HHuA2LXhvWNDfsgRgPlujuCiXS10afE
	+6upuYFpKyxAW55dPwy25s7ztN8kZ7IMngdHDK6ANCVc1RttUAhCY0FJUeNEQ5jhn4NKL/s+CO7
	5tkekwpg53dwlPQhoEBb8oV8fxoHdQcq0aO/Uu8Rs+bNEfmn32IzHzZlOTUdk+8SAJGmQ==
X-Received: by 2002:a17:90b:3502:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-380ba80ebf3mr9941918a91.4.1783077138019; Fri, 03 Jul 2026
 04:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702144919.172295-1-dhowells@redhat.com> <20260702144919.172295-4-dhowells@redhat.com>
In-Reply-To: <20260702144919.172295-4-dhowells@redhat.com>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Fri, 3 Jul 2026 08:12:05 -0300
X-Gm-Features: AVVi8Cfo7aDnD9M-_zHi7p_6h9j6ZGxDDdyYzR4aGimyDUziEmpvLo15RC0KjG0
Message-ID: <CAB9dFdsibK-+8HJpkMYs+eOrN+43dW7UcyvH+y=t0f6f+0hx5A@mail.gmail.com>
Subject: Re: [PATCH net 3/4] afs: Fix UAF when sending a message
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79753701BB4

On Thu, Jul 2, 2026 at 11:49=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> In afs_make_call(), there's a race with async call reception and
> destruction.  If a call is dispatched that doesn't have call->write_iter
> set (used to specify the data content for FS.StoreData), then the first
> rxrpc_kernel_send_data() will not set MSG_MORE in the msghdr.
>
> Once rxrpc_send_data() queues the last request packet, the response could
> come in at any time and cause the call to be completed and put.  However,
> afs_make_call() will look at the call again to see it ->write_iter should
> be handled - something it's only allowed to do if it has its own ref on t=
he
> call.  Whilst this is the case for synchronous calls, it isn't true for
> async calls such as FS.FetchData.
>
> generic/650 plays games with randomly taking CPUs offline, and can
> interject a significant delay such that the call is deallocated before
> afs_make_call() gets to check call->write_iter - and a UAF ensues (caught
> by KASAN).
>
>    BUG: KASAN: slab-use-after-free in afs_make_call+0x1c90/0x2210 [kafs]
>    Read of size 8 at addr ffff888035e050e8 by task fsstress/1409
>
> Fix this by caching the call->write_iter and call->debug_id so that neith=
er
> variable needs to be accessed after the first send.
>
> Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operatio=
n")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@kernel.org
> ---
>  fs/afs/rxrpc.c             | 12 ++++++++----
>  include/trace/events/afs.h |  6 +++---
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index d82916657a3d..05fcb9b6adde 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -347,7 +347,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>         struct rxrpc_call *rxcall;
>         struct msghdr msg;
>         struct kvec iov[1];
> +       unsigned int debug_id =3D call->debug_id;
>         size_t len;
> +       bool write_iter =3D call->write_iter;
>         s64 tx_total_len;
>         int ret;
>
> @@ -410,7 +412,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>         iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_s=
ize);
>         msg.msg_control         =3D NULL;
>         msg.msg_controllen      =3D 0;
> -       msg.msg_flags           =3D MSG_WAITALL | (call->write_iter ? MSG=
_MORE : 0);
> +       msg.msg_flags           =3D MSG_WAITALL | (write_iter ? MSG_MORE =
: 0);
>
>         ret =3D rxrpc_kernel_send_data(call->net->socket, rxcall,
>                                      &msg, call->request_size,
> @@ -418,7 +420,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>         if (ret < 0)
>                 goto error_do_abort;
>
> -       if (call->write_iter) {
> +       /* We lost our ref on call if MSG_MORE was set. */
> +
> +       if (write_iter) {
>                 msg.msg_iter =3D *call->write_iter;
>                 msg.msg_flags &=3D ~MSG_MORE;
>                 trace_afs_send_data(call, &msg);
> @@ -427,9 +431,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>                                              call->rxcall, &msg,
>                                              iov_iter_count(&msg.msg_iter=
),
>                                              afs_notify_end_request_tx);
> -               *call->write_iter =3D msg.msg_iter;
> +               /* We lost our ref on call. */
>
> -               trace_afs_sent_data(call, &msg, ret);
> +               trace_afs_sent_data(debug_id, &msg, ret);
>                 if (ret < 0)
>                         goto error_do_abort;
>         }
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 1b3c48b5591d..cf7218efb861 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -937,9 +937,9 @@ TRACE_EVENT(afs_send_data,
>             );
>
>  TRACE_EVENT(afs_sent_data,
> -           TP_PROTO(struct afs_call *call, struct msghdr *msg, int ret),
> +           TP_PROTO(unsigned int call_debug_id, struct msghdr *msg, int =
ret),
>
> -           TP_ARGS(call, msg, ret),
> +           TP_ARGS(call_debug_id, msg, ret),
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               call)
> @@ -949,7 +949,7 @@ TRACE_EVENT(afs_sent_data,
>                              ),
>
>             TP_fast_assign(
> -                   __entry->call =3D call->debug_id;
> +                   __entry->call =3D call_debug_id;
>                     __entry->ret =3D ret;
>                     __entry->offset =3D msg->msg_iter.xarray_start + msg-=
>msg_iter.iov_offset;
>                     __entry->count =3D iov_iter_count(&msg->msg_iter);
>
>

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

