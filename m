Return-Path: <netdev+bounces-289514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEVnKq2KDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A908581F30
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3057830E865A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2C35203F;
	Tue, 19 May 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCraIdDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2E3F1AA2
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206307; cv=pass; b=MSqP96h0nz2KzeD3ywvgiemF6vb5dm7kMtGs42/KI1UO0RdPPr5xuJQ2xPugA85NO3VSDL2Q2pLM3R56XUtKniBBB1jkd39EdfMBwHena6nKT5P49SUi9JSPk626KCBvEuhz/4Fl9oPaBE771xZr5MA7QsB5BwCX2K4xcc8KBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206307; c=relaxed/simple;
	bh=UwfRDIGy2q3FUkgiUSA/dAFUOsVNn+iJpmUP4CYfdjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZSVHEamFcbFwm4vtALNHRH+DsI9J5ycu1dyEDMysGVTX1UHWbjEdb0vTCa4PensHrGMWRxtB6n8td0AQkkj/5fmU37MDZPZofZSVYHcO9nsMszTlVE7hbpOK8vWng09THbB1gKHdswFoCkdxOD/CFgQH7PNB/DNR0kkpdWlkLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCraIdDP; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so5254305e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779206301; cv=none;
        d=google.com; s=arc-20240605;
        b=hqVQzBCmzJeFfDNuu3KdK6c0QwF5geZg9atRfksvlKSSfP4Bd8AywNrk3ifZFqYpCu
         AvQ5Buk0EIMpi/TN6eHqZGYhFej4j0oP4bDB5pGYvid8ewQNHTAahIwL2W1WmV9Hr6DN
         m/oTJ7fuvIFo8ZnZAnzp/zlD1yT77d39eHROTtVAyjjS4+R4fsECT5nktCEjoOmwOGHF
         UFZ4cp5K9WCxcMExNdlD+t9SQS84lCvUgdQvQWs7J1wVn+5g6xqhWroX90+njWtJruo4
         pWvu4Py/PfsbXKbvJm3BrVXjWApMZx9krb+Zq/aVuyuyftBjbeESsb9HLK1NTWHYuOWt
         RKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        fh=OreROVuWG60Mee9m0RanDLyBYvBZaII33WnO1U+1MTw=;
        b=OtD09XspdDtGtnmGkYSQQmGlniZpfAkDtwvgWqBIaCUbbS1Pl+VDM9D3c28l09mJbb
         8MMfgeEsCXvybAj8c090VrXk1zFUdm2DC1wItdAyPUr5zVSXG2+ycAyWt9uQkEyT5ns7
         PgXwR+8rbfAOCsGiVOXsr14GgmUprpATb7if/csoVfYwnexaNH3gAYmSGsxw7vGPlohB
         y7I2asHREncZOb6ZAJL5oiZAgs5b05a2uxRTshq5UGcEv3E3HegU6qzlDdMXxUlISD33
         MIKZZWQCNaaq6RJcDQr712a0Tvpv8y4kaVL6H4pPgw4PrmZVqfcaF9zBm7bcNpZbTQPC
         j59A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206301; x=1779811101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        b=sCraIdDPryFLcvRUAK2KbLzN2FwAn2tKX1P4WPsetFug1Zw77ceaB9fSJlO4cUrCva
         ukVk9c5/yTT2BxE9UedXvRqfBHKYSv599Iz3IKQm2uiln5N54O2AkK/HLzOlP2/7ZCDk
         HYSogE3y3JOtezww/gmIA2iS4z02WbokPBkxsFoTcoNXO1z59mVscR2Eg0I6BfcGKWq4
         DIyN0rpteRwF18nh8EviLhDCG/KA/CznBAfDNwRMCfJsQepvK8oXXG7fjKNRRGKaDs8Q
         Y6wgDmm1EqJU7RJvLXfUXxYT3yrh+usuvWROSTs0mxywxV7T800iwZ9yc3FmkYOhdvAr
         MbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206301; x=1779811101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        b=AbLuw5htdrPtbsgAP9PDy7JGEAf+FPQ/hAyXI/whJNtTm03cZGKdLHZnttkSczOeQZ
         AEJGeochui3/YcAkfG/EgQtWONo0yIXPHNvPKfUSHJnORGBcmg3WJdsFta+7ZTIWm6EO
         H+vKn+QubqgXQrpha01NwwCchIKpSiDhx+6Am+qXq5Tae60RDrBKemXVcqprR8B9Ozxk
         Jxy3teFjur+Z6SlL8Dkxp+FlQ3Jb9J0pnypRJZ6nYU43d/VcqtGcbYHItyWAPLiEMJYf
         WaLHWzl3MWImq6RAZ0uZcn5Xf5hA2C88cygPxl4FX8BumZL+rtF7Nbv+80j3Vn3671wB
         xBxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nL9yx0l4YhmCf+/ibdsxgC8ySFNAR6RRefnSX1/OaEQv1bIT3AJCkVqQPemQLPfrezAW+ZuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TFCg3vbBWh6oIOn7ZJYu/dxXqs5sXwel7+YtkK/Njo35+J2P
	FdLFqPJJtqhWiIjSy/Jt+vMUvXmEABJh8/Nk+mqRdYSjkbaOb3cQ4d+o0C87Lb29PjTxk/JZAxD
	oBU+K1d/jWk62BVil+DouSNPZhzNLgxc=
X-Gm-Gg: Acq92OGbDahdPHjb0BGaGT2U3kYLinGkl22SADkyaCNyZra737QgCQP7QBJqI0pPeH+
	x1RnBkJYDFX2LEMlqHxAceMjvm8b6tP5E72HOCKdihlEXYkz3QoAW5YwK+j7fk605Wnvbsvhk1V
	r0LrD0n1W3WdtuzReAYth0cK7z2gkEq59nKjVSZfhhNrK2wYB1BnUOrjhyiSW3B/hvCJ/qnJPci
	XipUmgwPTq81L2Arzo/uq+TlOhWzLVeh5Jscyp+7nL4DvVXiMGaHf3Qbw1o/6PuSjb39Ok9d+dA
	/pNbrIM=
X-Received: by 2002:a05:600c:1d02:b0:48a:5302:8ed9 with SMTP id
 5b1f17b1804b1-48fe5ea0842mr180244485e9.0.1779206300911; Tue, 19 May 2026
 08:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
 <agrldIdftDXvATYx@sgarzare-redhat> <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
 <agwugKMrTsNxQ2BD@sgarzare-redhat>
In-Reply-To: <agwugKMrTsNxQ2BD@sgarzare-redhat>
From: ziyu zhang <ziyuzhang201@gmail.com>
Date: Tue, 19 May 2026 23:58:05 +0800
X-Gm-Features: AVHnY4JF15iV8VNxh-zoQopw8snUWS1lixKwNhMLTZ44g5qqA7v69Lig3q9xBy4
Message-ID: <CACPoYJxJN0fmmK-7e7B9JaS7sqsCdEYxYMiaMK1gDaPMGuwhhA@mail.gmail.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vmware.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziyuzhang201@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A908581F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 17:36, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, May 18, 2026 at 08:39:37PM +0800, ziyu zhang wrote:
> >On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
> >> >vsock_poll() reads vsk->peer_shutdown before taking the socket
> >> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
> >> >lock to report EOF readability. A shutdown packet can update
> >> >peer_shutdown while poll is waiting for the lock, so one poll invocation
> >> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
> >> >
> >> >Keep non-connectible sockets on a single lockless READ_ONCE()
> >>
> >> Should this be paired with WRITE_ONCE() on writers?
> >
> >Yes, since the poll path uses lockless READ_ONCE() snapshots of
> >peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
> >well. I will add that in v2.
> >
> >>
> >> >snapshot. For connectible sockets, defer shutdown-derived poll bits
> >> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
> >> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
> >> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
> >> >for a poll pass.
> >> >
> >> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> >> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> >> >---
> >> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> >> > 1 file changed, 26 insertions(+), 14 deletions(-)
> >> >
> >> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> >index adcba1b7b..bed42347b 100644
> >> >--- a/net/vmw_vsock/af_vsock.c
> >> >+++ b/net/vmw_vsock/af_vsock.c
> >> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> >> >       return err;
> >> > }
> >> >
> >> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
> >> >+{
> >> >+      __poll_t mask = 0;
> >> >+
> >> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
> >> >+       * case of EPOLLHUP set.
> >> >+       */
> >> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
> >> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >> >+           (peer_shutdown & SEND_SHUTDOWN)))
> >> >+              mask |= EPOLLHUP;
> >> >+
> >> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >> >+          peer_shutdown & SEND_SHUTDOWN)
> >> >+              mask |= EPOLLRDHUP;
> >> >+
> >> >+      return mask;
> >> >+}
> >> >+
> >> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >> >                              poll_table *wait)
> >> > {
> >> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >> >               /* Signify that there has been an error on this socket. */
> >> >               mask |= EPOLLERR;
> >> >
> >> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
> >> >-       * case of EPOLLHUP set.
> >> >-       */
> >> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
> >> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
> >> >-              mask |= EPOLLHUP;
> >> >-      }
> >> >-
> >> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
> >> >-              mask |= EPOLLRDHUP;
> >> >-      }
> >> >+      if (!sock_type_connectible(sk->sk_type))
> >> >+              mask |= vsock_poll_shutdown(sk,
> >> >+                                          READ_ONCE(vsk->peer_shutdown));
> >>
> >> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
> >>
> >> Not a strong opinion about that, but in any case IMO we should add a
> >> comment here to explain why we are doing only for not connectible
> >> sockets.
> >>
> >> That said, if we use WRITE_ONCE in the writers, do we really need to
> >> move this after the lock_sock for the connectable ones?
> >
> >Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
> >and add a comment there.
> >
> >For connectible sockets, my current understanding is that
> >READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
> >they do not make two separate reads in one vsock_poll() invocation observe the
> >same peer_shutdown value. So I still think using one peer_shutdown snapshot
> >after lock_sock() is useful for keeping the returned mask internally
> >consistent. Please let me know if you think WRITE_ONCE() is enough for this
> >case.
>
> What will be the issue of "do not make two separate reads in one
> vsock_poll() invocation observe the same peer_shutdown value." ?
>
> In any case, I'm not against it; I just want to understand the issue
> better.

The issue I was trying to avoid is a transiently inconsistent poll mask
from one vsock_poll() pass.

For example, the early peer_shutdown read can see 0, so the
shutdown-derived bits are not set, especially EPOLLRDHUP, and EPOLLHUP
in the cases where the existing logic would set it. Then, before
lock_sock() succeeds, the peer shutdown can be processed. The later read
after lock_sock() can see SEND_SHUTDOWN and set EPOLLIN|EPOLLRDNORM for
EOF readability.

So the returned mask can say that EOF is readable, but miss the
shutdown-derived indication from the same peer_shutdown state. If
userspace is waiting specifically for EPOLLRDHUP, that notification can
be missed or delayed for that poll pass.

I agree this is small and transient. A following read() or another poll
pass will observe the shutdown state. My intention with the single
snapshot is only to avoid mixing old and new peer_shutdown values in one
returned mask.

I will send a v2 as a new thread with WRITE_ONCE() on the writers, the
DGRAM comment, and your ordering suggestion.

Thanks,
Ziyu

>
> Thanks,
> Stefano
>

