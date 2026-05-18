Return-Path: <netdev+bounces-289052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGL4G6AJC2o0/gQAu9opvQ
	(envelope-from <netdev+bounces-289052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5556CEC5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997DD308A369
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6936841C300;
	Mon, 18 May 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHD2+8Fd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A94410D0C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107993; cv=pass; b=opnyIx2pvvP0/yHV2fKyF1cytehw2mjhYyGRSbk5BEHXtjxeNMVW0Y7ZwP5hND2vTU+jsKMBmtzq/GEYGGpw94A002vLZeptDtKLvnH56+rP+LnXrxGHtxVHrRGP4EriNhL6+jUKWQK9qKeOr/S3Zg9B8Z5H7KdFgLiqi+GHGt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107993; c=relaxed/simple;
	bh=JJ8fpDX8TBkCH5S0/z0dF6rSeIENeKcqacJPaMsAlPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMrURnUShDToNkXwWd6S+LeaBaKwxKX4JH0xZqjGq+RpyeJ+6UdK5p6oSfHstu5/nHaXKZDeMMM/i/8i/WM21xKNf0QOJSC7LcKyQnP2Kwmj5J9BrF0fUJimd39VCUrCa7HU88PJFyxZxwIZIHt8zeYs7Epfu1rsFFRDO7zAgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHD2+8Fd; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so3819115e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107989; cv=none;
        d=google.com; s=arc-20240605;
        b=bjYNI5ZRfF0aRbvMQ/MjuZPRPcsBDmkxEpSO2sO9DUxhiS4FEs3hwpmMqR1Sv9U/3s
         LvSGbAOo6nDaz5i6iqXlL5yo+ndKGmaNyfpBA46zxPjkLwK9D02U08ediCTZyfvflJxZ
         mzcg8MG9myWDxKe0RYplGGnojf/f9kPfOVakDuuwwuGqcG2EVCQzPNR8XcT3FM8YO+oe
         9Yx8RfvauTmnY9XUikILpYR1hSEuLfVOwPLsltoE+ggb68vXq4zIugKyrtEBx6UIeLYN
         MAAr7HBQsotp/PPz2fL2n14p0eyGmlvHgG3uCxuL259fOdUAD9SjNs2Jta//DDQ9gGXb
         znxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        fh=Z3/6nU8dN8S63FMR+6dGn+1fygueKHsB/8zKUBBVVoE=;
        b=JCLIrhcfnSjSV5FI11+KzPhTex0yBErACt0ni+btjiPlqrnV/3XdGvm1sZjDToDp3h
         qrLPtsCZqFAbj/63xEU4hhdREPST1EjcNE4I4PbVW18Vdn3c/o7UTjxnWSYY31nFBjhP
         egIFFEgtFsDXCfVzFu+YhvB4AtBMdZT1bGChqMo1W9YEl/wJmdlb76iuMWiz4xUNsERc
         tQ1dK9Cgay2V58ZfmtYZksvrA+laBqBK+QjBpUHMMmRs5QJSoCrUOKhcEQolIHUnrFZv
         nBGMyzYUze015dm4GdJGtoK0QAdtBjO3xh0B/9L0teAOuM8BedMz9QWFXk06C+8A9SDo
         Z7LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107989; x=1779712789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        b=sHD2+8Fdee9oRN42KyyCj8C93NJhNFk4T0hGchaLc8CRTWCyQrhJKqUohk7nRGZm+c
         PLYrRv3KymfVDTJIZ+33k7C0gviGnBSrWbonZpMHlqlDc2Cje0rSsM7z8ZpLAO+AT8mR
         CjWvR0dGrqTpITpwtPYv3FvFj+zhciT8OPciM94eMhme79DEaB7fgI9uPHLhDFdneOeR
         gc48a01+Mgmjqphcp5ZLBSKThaUDU/+lgHSe0Q/eFpNoPR5kqtfNwPI9HJEfmOdbOGyX
         PzYNfM4TkWIUrnVgTWJhPMOOq3iz5ikX2kt+d8sV26pGDBtxu2uGGjktWg4wZ6Ytin00
         kChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107989; x=1779712789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        b=DmfAo2a1Nc40IBf4iV+AIaOC9fWLVLkwwzyM4cBgXszLl41thp45Sgi4fyHefQ0zOY
         BGI6TFXdBuiKDGTqDfWMBHugnRUhCWSDjF2p01uLvnwASwvlb/t0JHNQAsGjdFRyGEKZ
         +YeerUAEZJSAMMxUeE1+TF7h1i4rXOzSj01gXusvsUnCW7/lyM11gnzj15oUZ9R0HFDe
         1q7AdIEjX1Fih9tKn9vA38lJCRlR/la/pC8gSTaxyIhK0FbkdnwqTsuDE6Q48x+Mf9m9
         f+pHbKzB3xiihwqZbGpzrjJxyVKYoaB70wbzl6QU61WAyjMo7wQctX1dp2l+/nJuoGcX
         hMzA==
X-Forwarded-Encrypted: i=1; AFNElJ9Fsb6+caUElHtMwlfRcYvUfdPHR9Dpml4X+sdy1MCuhfQbXiZfBazUkhOCSYDvSxJhfo+zgfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jn2H1ZdePxgYK6hZMMQ42etAcTdo+p998Y2as2n4mj/bDybk
	uK0dmkNmCkvTp3AkVpEYx7kLoKEMLp11M+tRn1lAsVNmZR4yv+UR32dGd7pKJGHOUYP4Jxcy+9p
	EzNouOQ0rraD2frZ7fbWien3ULnlz8oE=
X-Gm-Gg: Acq92OFpukZCQLUz7xkA++xC2tjZ/hO0jeXiw0H+t3Y0JC020KGiHwCiAvvqpOhOF6j
	WgY68rYpK1bUyUenvEhGNoM9BwxCwCvlUTIrtdNW2+LxLKr6gPYLs10ASJ1bnVsybhkyxmgcgEi
	yNJxCCpW/PsIYH4PZofttL+iqwP6VShmShI35xd2LR+Mpc9UsAWll8afJ8nq7NZoiqn1mwkn3hh
	jLQxAGhyPkyLv1CmQlvMrhWk1/iAkdZGm8sQWD98PiIW1zzGwaCJADWR8Ctr+YAJtFrkDEcQNz7
	Kat7YUI=
X-Received: by 2002:a05:600c:198d:b0:487:1826:e138 with SMTP id
 5b1f17b1804b1-48fe6309a99mr126995475e9.1.1779107988810; Mon, 18 May 2026
 05:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516034745.260442-1-ziyuzhang201@gmail.com> <agrldIdftDXvATYx@sgarzare-redhat>
In-Reply-To: <agrldIdftDXvATYx@sgarzare-redhat>
From: ziyu zhang <ziyuzhang201@gmail.com>
Date: Mon, 18 May 2026 20:39:37 +0800
X-Gm-Features: AVHnY4JBDiIRJU-61TJDNbnXqzlRWWvp1w4GkFiNKUv_vD4n0ZzkHb8gPQGL79w
Message-ID: <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>, 
	Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	gality369@gmail.com, zhenghaoran154@gmail.com, hanguidong02@gmail.com, 
	zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EDB5556CEC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vmware.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziyuzhang201@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
> >vsock_poll() reads vsk->peer_shutdown before taking the socket
> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
> >lock to report EOF readability. A shutdown packet can update
> >peer_shutdown while poll is waiting for the lock, so one poll invocation
> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
> >
> >Keep non-connectible sockets on a single lockless READ_ONCE()
>
> Should this be paired with WRITE_ONCE() on writers?

Yes, since the poll path uses lockless READ_ONCE() snapshots of
peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
well. I will add that in v2.

>
> >snapshot. For connectible sockets, defer shutdown-derived poll bits
> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
> >for a poll pass.
> >
> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> >---
> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> > 1 file changed, 26 insertions(+), 14 deletions(-)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index adcba1b7b..bed42347b 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> >       return err;
> > }
> >
> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
> >+{
> >+      __poll_t mask = 0;
> >+
> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
> >+       * case of EPOLLHUP set.
> >+       */
> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >+           (peer_shutdown & SEND_SHUTDOWN)))
> >+              mask |= EPOLLHUP;
> >+
> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >+          peer_shutdown & SEND_SHUTDOWN)
> >+              mask |= EPOLLRDHUP;
> >+
> >+      return mask;
> >+}
> >+
> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >                              poll_table *wait)
> > {
> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >               /* Signify that there has been an error on this socket. */
> >               mask |= EPOLLERR;
> >
> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
> >-       * case of EPOLLHUP set.
> >-       */
> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
> >-              mask |= EPOLLHUP;
> >-      }
> >-
> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
> >-              mask |= EPOLLRDHUP;
> >-      }
> >+      if (!sock_type_connectible(sk->sk_type))
> >+              mask |= vsock_poll_shutdown(sk,
> >+                                          READ_ONCE(vsk->peer_shutdown));
>
> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
>
> Not a strong opinion about that, but in any case IMO we should add a
> comment here to explain why we are doing only for not connectible
> sockets.
>
> That said, if we use WRITE_ONCE in the writers, do we really need to
> move this after the lock_sock for the connectable ones?

Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
and add a comment there.

For connectible sockets, my current understanding is that
READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
they do not make two separate reads in one vsock_poll() invocation observe the
same peer_shutdown value. So I still think using one peer_shutdown snapshot
after lock_sock() is useful for keeping the returned mask internally
consistent. Please let me know if you think WRITE_ONCE() is enough for this
case.

>
> >
> >       if (sk_is_readable(sk))
> >               mask |= EPOLLIN | EPOLLRDNORM;
> >@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >
> >       } else if (sock_type_connectible(sk->sk_type)) {
> >               const struct vsock_transport *transport;
> >+              u32 peer_shutdown;
> >
> >               lock_sock(sk);
> >
> >@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >                * terminated should also be considered read, and we check the
> >                * shutdown flag for that.
> >                */
> >+              peer_shutdown = READ_ONCE(vsk->peer_shutdown);
> >               if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >-                  vsk->peer_shutdown & SEND_SHUTDOWN) {
> >+                  peer_shutdown & SEND_SHUTDOWN) {
> >                       mask |= EPOLLIN | EPOLLRDNORM;
> >               }
> >+              mask |= vsock_poll_shutdown(sk, peer_shutdown);
>
> nit: to keep the order the same as before, I would move this call just
> before this `if` block, but I don't think it makes any difference in the
> end.

Sure, I will restore the previous ordering in v2.

Thanks,
Ziyu

>
> >
> >               /* Connected sockets that can produce data can be written. */
> >               if (transport && sk->sk_state == TCP_ESTABLISHED) {
> >--
> >2.43.0
> >
>

