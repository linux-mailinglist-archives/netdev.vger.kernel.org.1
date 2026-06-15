Return-Path: <netdev+bounces-299563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /J3yN55DMGo7QgUAu9opvQ
	(envelope-from <netdev+bounces-299563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78414689268
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c3B3LEhl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299563-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F28A30A55D2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90A31327F;
	Mon, 15 Jun 2026 18:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DC313E01
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:24:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547888; cv=pass; b=mbKdvAYhUgH8M9QZguLwT7lBbQATNzHwpxuYAQ0/YmKBvFgeDdE09y7Kx4nlxmzWJ8LX71mQQfzUyTgVfmKAht6+3UQV1gs1moQOyvInr6EMZvYsPqMwacNBmGL9TrVcoOGqKmGCWHQl2gP5ToRuTClMwKOrxKOdMqQfQYxNAtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547888; c=relaxed/simple;
	bh=rQU3+1dptlO7EZ4QftxgAWtETbg9hrrizonkQ/zs6OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX2h6Zgqoja2sa0ulbQtE6LCRPKfQRvbMx5JVibTjjHt9Zzhuqds0pA3yU6/l95LBk1a9lry/xJvvxuJYwHV+etBO50a0SEmf523e4PVzHx/svGRHicq0DOSKFgLHi2VYesrjvL7AlBO9aoF6ITogLtTla5F+zQGX9xWVedG6/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3B3LEhl; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8434840cea8so2234721b3a.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781547886; cv=none;
        d=google.com; s=arc-20240605;
        b=X9kvMj+wpDDAYm7D43jW2cLvUssJGCvFJOADsXJ4Qfr2v36l5HtadGpvklhNsFgti4
         uSYUL7vAW7kbY4IVVjgHvCZ/P1UNtP0Bk1f8B1bA8I9DqgjpkMOSxH56Dq9szyrsSU9h
         lMXx2LqEE+e5AxW5u7hEuKgHZPuw96lgPooB3ndkAOLa8v20rR3P33ViRWXg85YqrRES
         vcehUxkc2n6B2iWrzU8ihLE9e4qjqyOIg6thlPtSlkIxhMsBTdpwJvt8CdHzCPOei439
         JWlepR4vO1m8D1J96MMkd8aRjFR7QsxnUlDTWVklKcX0+CLbt/VFz1aHLUwQSyzJ4fcO
         e9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        fh=YFlUGFL9p5VoFoFpNCgoyB8TcV2Zsi2AnnDuinNOMX4=;
        b=QIHKJ2y5HS0NbiM+zgoAl7CtDnJg4aCvzbDgIr0z5Bl/5FeJkevgQ1hbgpFAEpZb0t
         Sdf/9LJ7vXKP1PBwpJrk9FT/LW/waPmKrYuKu0kDXfqJSjXkRBgckszgpCkH+TNebtqe
         2+Uga9qWTIFzS4btI72zM2kCUzDNYXrDoZZnm3FzkvJueK8Xfy9YsjuJAelQAeFbyAS3
         fgqhiPURAXjtnuKPGvI4TvLDrZNt1ErNna/jASSEbepOIvMz+uo2EyK/EggVpHc+OiD7
         FGk+4wk3l/aRA2Bb/2EqBha6iwvnlONjrkBlRC24Rr9tN+Xu3NNGasDWjHDQdA1wL2FR
         DjsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781547886; x=1782152686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        b=c3B3LEhlHKrq6WtUg5r+iRgRd3EGgVKY7819k6Xrf6BWgL1/z1R9dVTANTGjlbower
         0+Ynx2sRgwt9MyBxY6W0J7D1yhyRCqRHp6CVmmslxpLtZCFtJ4wFRJXB62VTaS4YsCMW
         2QcNMoXVd9XvCmluAWFq5rl+NlD6t8m4nbt6cu1yjW62OUVDhKe1HagcqP5rujiM0NTE
         rH0ziNoaujTd8PpKdHtR1CNe84w58NGg0/fHV4fx6kKpe9PV969v1uoXWew4gcc8o3U8
         JYPRX1INj4ItVAkpLSQCSgbPKdv40eZY/8ROA2Zy4HlIKZbA+VyAowhbFredGsFvBsPM
         pgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547886; x=1782152686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        b=i3JIjnb6rjzXu2zrnA+p2sEo+EmFtgD6dHyYu9iZJM7+zfwkQCA2gso8kDkdlGVI75
         l3Qf0BKZD7dHhVInhO2blp3ndhUpXR9UoSxljL6/7jP7z9bTBXt9p7udLGA0prX37y6r
         Q3Z7I+OSw4Nn5Z9UpPe/+epfNHQ5p+FSSvq8MwTNJFOX2l/0jVN2xy4yUyMRRuMueel5
         0GI1Ca8jhMqKgei8v28dzL69ZwKBTl+sbqoON1zfxYreMzS78pY73nZqBGSYbhD1DcWe
         Av0kjWhrwSrtYNHsjNa+FVDlr4vhBYjG2QRa3EYk+y4cxKlGPZgDzYUSLTFD/cm7OdIs
         swQw==
X-Gm-Message-State: AOJu0Yw8yWzEg058fQPMI/3ff4lav9bPof6AHnr5LEx9uTADgrpnYhJO
	xGi/SJvQOUCeHip/iAgnzAizp2XrWZr1wPAhvLpiaPqfUhNLbMiL6cc024AKEPoLDQ7jCBdWC0C
	VMZ8a3uz1fbV5b5n0um+8+HqD/RQlmMU=
X-Gm-Gg: Acq92OFP/THG4gtmYEbvQ+4DoHWftPlqp9hneC7NzgHhMqRgw1q0pwaznTxIp1Wb0Tu
	gmXsPtaOaogkJBv5+og5aagwPxaqsg8hJQCYU3d2VpPIqDcvdS41uVSnYyqKQqt5sGDY22y9K1p
	He4dOhuHRNAP73uesM+rY9o8ZK5+O6TedLAem0x7XOtaKY8fiAqy0fnv3JwdBmwhzFf6+pLmkM6
	kS/I5BwXh5nXod7HE2pY9qoJfUlK9tfscSIh2KdEYgXCIKZkVB43YuobKjIGK9WqFWQf5LuqF5d
	NDrJ5GabM9Glu+7cZqfuJ2QuaEHc2UtNxowKhHE4te/RaMOJS/MfdBnGuh6/XjU6/s2vWy0Re+O
	QY1ULMQ==
X-Received: by 2002:a05:6a00:c83:b0:842:6004:3fd5 with SMTP id
 d2e1a72fcca58-845154f58d3mr78801b3a.25.1781547886044; Mon, 15 Jun 2026
 11:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
 <20260615110402.753443-2-horms@kernel.org>
In-Reply-To: <20260615110402.753443-2-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 15 Jun 2026 14:24:34 -0400
X-Gm-Features: AVVi8Cdsgr1lIev8i-LOeRjiGsTT6EdjDVWHZXyGUQKfw-EyZyIxlJW6n2LNSZE
Message-ID: <CADvbK_e062WLNVy+BbuNTNoJGBvQBR7PHp_BmxLwwSGq4O9_dw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in sctp_diag
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, w@1wt.eu, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299563-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78414689268

On Mon, Jun 15, 2026 at 7:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> sctp: hold socket lock when dumping endpoints in sctp_diag
>
> This change reworks SCTP_DIAG endpoint dumping so the socket lock is held
> across inet_sctp_diag_fill() to keep the bind address list stable, and
> moves position tracking into sctp_for_each_endpoint() which now drops the
> bucket read_lock_bh() before invoking the callback.
>
> A few questions on the new iterator and dump callback below.
>
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index d758f5c3e06e..9108272ca527 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -373,42 +374,36 @@ static int sctp_ep_dump(struct sctp_endpoint *ep,=
 void *p)
> >       struct sk_buff *skb =3D commp->skb;
> >       struct netlink_callback *cb =3D commp->cb;
> >       const struct inet_diag_req_v2 *r =3D commp->r;
> > -     struct net *net =3D sock_net(skb->sk);
> >       struct inet_sock *inet =3D inet_sk(sk);
> >       int err =3D 0;
> >
> > -     if (!net_eq(sock_net(sk), net))
> > +     lock_sock(sk);
> > +     if (sctp_sstate(sk, CLOSED))
> >               goto out;
>
> [Low]
> The new unconditional skip on sctp_sstate(sk, CLOSED) does not appear to
> be described in the changelog.
>
> SCTP_SS_CLOSED maps to TCP_CLOSE, so a userspace caller that asks for
> TCPF_CLOSE in idiag_states will silently receive nothing from the
> endpoint hash for entries in that state.
>
> Most hashed endpoints are LISTENING (sctp_hash_endpoint() is called from
> sctp_listen_start() right after inet_sk_set_state(sk, SCTP_SS_LISTENING))
> so the practical effect is small, but is the intent to filter teardown
> windows (in which case ep->base.dead might be a more direct check) or to
> honour the user-requested idiag_states bitmask?  Either way, would it be
> worth calling this behaviour change out in the commit message?
>
> >
> > -     if (cb->args[4] < cb->args[1])
> > -             goto next;
> > -
> > -     if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
> > -             goto next;
> > +     if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
> > +         !list_empty(&ep->asocs))
> > +             goto out;
>
> [ ... ]
>
> > @@ -479,41 +474,40 @@ static void sctp_diag_dump(struct sk_buff *skb, s=
truct netlink_callback *cb,
> >               .r =3D r,
> >               .net_admin =3D netlink_net_capable(cb->skb, CAP_NET_ADMIN=
),
> >       };
> > -     int pos =3D cb->args[2];
> > +     int pos;
> >
> >       /* eps hashtable dumps
> >        * args:
> >        * 0 : if it will traversal listen sock
> >        * 1 : to record the sock pos of this time's traversal
> > -      * 4 : to work as a temporary variable to traversal list
> >        */
> >       if (cb->args[0] =3D=3D 0) {
> > -             if (!(idiag_states & TCPF_LISTEN))
> > -                     goto skip;
> > -             if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
> > -                     goto done;
> > -skip:
> > +             if (idiag_states & TCPF_LISTEN) {
> > +                     pos =3D cb->args[1];
> > +                     if (sctp_for_each_endpoint(sctp_ep_dump, net, &po=
s,
> > +                                                &commp)) {
> > +                             cb->args[1] =3D pos;
> > +                             return;
> > +                     }
> > +             }
> >               cb->args[0] =3D 1;
> >               cb->args[1] =3D 0;
> > -             cb->args[4] =3D 0;
> >       }
> >
> > +     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > +             return;
> > +
> >       /* asocs by transport hashtable dump
> >        * args:
> >        * 1 : to record the assoc pos of this time's traversal
> >        * 2 : to record the transport pos of this time's traversal
> >        * 3 : to mark if we have dumped the ep info of the current asoc
> >        * 4 : to work as a temporary variable to traversal list
> > -      * 5 : to save the sk we get from travelsing the tsp list.
> >        */
> > -     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > -             goto done;
> > -
> > +     pos =3D cb->args[2];
> >       sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
> >                                       net, &pos, &commp);
> >       cb->args[2] =3D pos;
> > -
> > -done:
> >       cb->args[1] =3D cb->args[4];
> >       cb->args[4] =3D 0;
> >  }
>
> [Low]
> The commit message states that args[4] tracking is removed, but the
> asocs-phase comment block still lists:
>
>          * 4 : to work as a temporary variable to traversal list
>
> and the trailing epilogue still does:
>
>         cb->args[1] =3D cb->args[4];
>         cb->args[4] =3D 0;
>
> Are those leftovers from the eps-phase rewrite, or are they still needed
> by the asocs phase?  If args[4] is genuinely gone, should the comment
> and the epilogue be cleaned up too?
>
> The previous comment also listed:
>
>          * 5 : to save the sk we get from travelsing the tsp list.
>
> which is dropped here without further mention.  Is args[5] confirmed
> unused on the asocs path?
>
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 66e12fb0c646..1ed405dedc01 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -5369,24 +5369,44 @@ struct sctp_transport *sctp_transport_get_idx(s=
truct net *net,
> >  }
> >
> >  int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> > -                        void *p) {
> > -     int err =3D 0;
> > -     int hash =3D 0;
> > -     struct sctp_endpoint *ep;
> > +                        struct net *net, int *pos, void *p) {
> > +     int err, hash =3D 0, idx =3D 0, start;
> >       struct sctp_hashbucket *head;
> > +     struct sctp_endpoint *ep;
> > +     struct sock *sk;
> >
> >       for (head =3D sctp_ep_hashtable; hash < sctp_ep_hashsize;
> >            hash++, head++) {
> > +             start =3D idx;
> > +again:
> > +             sk =3D NULL;
> >               read_lock_bh(&head->lock);
> >               sctp_for_each_hentry(ep, &head->chain) {
> > -                     err =3D cb(ep, p);
> > -                     if (err)
> > +                     if (sock_net(ep->base.sk) !=3D net)
> > +                             continue;
> > +                     if (idx++ >=3D *pos) {
> > +                             sk =3D ep->base.sk;
> > +                             sock_hold(sk);
> >                               break;
> > +                     }
> >               }
> >               read_unlock_bh(&head->lock);
> > +
> > +             if (sk) {
> > +                     err =3D cb(ep, p);
>
> [Critical]
> Can ep be freed before this cb(ep, p) call?
>
> The bucket read_lock_bh() is dropped above, and only sock_hold(sk) is
> taken.  In sctp_endpoint_init() the reference direction is
> ep -> sk:
>
>         refcount_set(&ep->base.refcnt, 1);
>         ...
>         sock_hold(sk);
>
> so taking sock_hold(sk) does not pin ep.
>
> A concurrent close(2) on the same socket runs:
>
>   sctp_close()
>     -> release_sock()                  /* lock_sock dropped here */
>     -> sk_common_release()
>        -> sctp_destroy_sock()
>           -> sctp_endpoint_free()
>              -> sctp_unhash_endpoint()
>              -> sctp_endpoint_put()    /* refcount may reach 0 */
>                 -> call_rcu(&ep->rcu, sctp_endpoint_destroy_rcu)
>
> The destroy callback then does sctp_sk(sk)->ep =3D NULL; sock_put(sk);
> kfree(ep).
>
> Between read_unlock_bh() and cb(ep, p), this iterator is no longer in
> any RCU read-side section, and sctp_ep_dump() then calls lock_sock(sk)
> which may sleep.  That allows an RCU grace period to elapse before the
> callback dereferences ep at:
>
>         struct sock *sk =3D ep->base.sk;
>         ...
>         if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
>             !list_empty(&ep->asocs))
>
> The sibling helpers in the same file pin the endpoint explicitly to
> avoid this:
>
>   sctp_transport_traverse_process()
>         if (sctp_endpoint_hold(ep)) { /* asoc can be peeled off */
>                 ret =3D cb(ep, tsp, p);
>                 ...
>                 sctp_endpoint_put(ep);
>         }
>
> Should sctp_for_each_endpoint() take sctp_endpoint_hold(ep) inside the
> bucket read_lock_bh() (while ep is still hashed and live) and a matching
> sctp_endpoint_put(ep) after cb returns?
>
> [Medium]
> Can this restart pattern miss or duplicate endpoints when the bucket is
> modified concurrently?
>
> After processing one ep the loop does:
>
>                         idx =3D start;
>                         goto again;
>
> which re-walks the bucket from the head and uses the running counter
> idx compared against *pos to skip already-emitted entries.
>
> __sctp_hash_endpoint() inserts at the hlist head and
> __sctp_unhash_endpoint() can delete arbitrary nodes, both under the
> bucket write_lock that this iterator releases between walks.  A
> concurrent listen() on a sibling endpoint shifts every existing entry's
> index by +1, and a concurrent close() before the cursor shifts indices
> by -1.
>
> Under that pattern, can SCTP_DIAG consumers observe duplicated
> endpoints (the previously-emitted entry now sits at the new *pos) or
> miss live endpoints (the next un-emitted entry is shifted past the
> cursor)?  The pre-patch sweep walked each bucket once with read_lock_bh
> held throughout, so this consistency window did not exist.
>
> [Low]
> For a bucket that contains N matching endpoints, does this restart
> pattern walk the bucket O(N^2) times?
>
> For a bucket {A,B,C} starting from *pos=3D0 the goto-again loop performs
> 1+2+3 traversals to dump three entries plus a final 3-entry walk that
> finds nothing and terminates with sk =3D=3D NULL, which is nine list
> iterations to dump three endpoints.  The pre-patch code walked each
> bucket exactly once because the callback ran while still holding
> read_lock_bh().
>
> The commit message describes the change as simplifying endpoint
> traversal; could the description also note the new per-bucket scan
> cost, or could a cursor that survives unlock/relock be used instead?
>
> > +                     if (err) {
> > +                             sock_put(sk);
> > +                             return err;
> > +                     }
> > +                     sock_put(sk);
> > +                     (*pos)++;
> > +
> > +                     idx =3D start;
> > +                     goto again;
> > +             }
> >       }
> >
> > -     return err;
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);

Low: #1, #2, #5, not really issues,
but worth mentioning about it in changelog.

Critical: #3, not valid.
socket refcnt can't be 0 when traversing the chain under read_lock_bh().

But it seems better to hold ep instead sk, and also to check
ep->base.dead instead of sk_state CLOSED.

Medium: #4, not valid.
it's completely okay to dump duplicate or skip socks because of
concurrent close() and listen() in diag.

will post v2 with some improvements mentioned above.

Thanks.

