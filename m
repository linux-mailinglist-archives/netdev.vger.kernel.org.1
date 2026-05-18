Return-Path: <netdev+bounces-288906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPMDJS3ICmqf8AQAu9opvQ
	(envelope-from <netdev+bounces-288906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E00568595
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CA06307EC2A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76603AB26E;
	Mon, 18 May 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5p3k6Ju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8B2C0F6D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091050; cv=pass; b=WFz8F2C4qmVi8X9yjERD88zaqPBwc05NyNaxNrq5fI1Fmdbrwrea4+JX3lkbnFJJnHs1VrsxFdNBTZE4yngq+JxH44VuRdpKlBMaNeqIp9JcmeLI40naPvJJysQVzM6RdzGggLfxFsTX9sJMdY8vywWv9KrVzJLq9npTY4jwDzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091050; c=relaxed/simple;
	bh=4xB2B9zc4CCWQlPP/GC5eeqzWlvXjQmImSfaPFUPpOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azMltpdhi7q0NBjfXd2KpYoHm0ttMvFE9XD2/gGYsBLcVmiLkRkiiEZQ9sUnKyD7CYmgprvOddt/1f+KB8g0pebNXFlj1C0qetO/TNbPadU5Qgf42X2CJ94iEjteZQ8DXc8ub2/8/QFXRiRuuo7t/aFsuXPQ8+/vJrTN3Q5jHBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5p3k6Ju; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50faf8ed9c5so9669511cf.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 00:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091048; cv=none;
        d=google.com; s=arc-20240605;
        b=Dem1K7q81nxFq+BYetEUd45Lmm6pEU5g2ZScolz6c73DPV938xuAKinIeBRJARZocm
         MjE95CQWOqvUqeRYtiUyFY5DZ8puzeQPDo00T/yj//csIMk2RZJ5ycBbpE95xopqyQ2r
         o+gzO7cUCeRDBpOQZI9Cwudt9Qr8TqEArsYfaaABXzncbttYw8uJ7z5yRC7CnNRyXlRT
         R9nApLxzJ7q9wwGIfdw6tH5jRqsNGondvzwyv34pSFKO335oP0aLqtZ3WyBdN8kw7JEA
         6ew7a/86pURdaDKu8BMaAtnbVZmjgg/vdJCyzAuOjss2zR+yyGwNyPNbNrjIld9GpUYd
         IEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ycc0wSl3+Drf46KKdfSMrZoXhkLDSPLUS21PV8OVhOg=;
        fh=g+1xPLE35Xnf9QmNicsrMlLiYMkGDerEvgc3Nbsznxc=;
        b=Lydt+HbE9+UNk/whcfQRle9eIHSneMMINVUohCsKWYElaQ5GXlwBVAlA0aFdkNqYCJ
         7zGR4CWGMlXvbASkGS368KPj7d/+K8gzd39WU/8Jki0umr+IYrTnQDxd8jP3wYomhPXS
         9YfqvAWvrvcTF+CXdWUdMCWTOCDAljZQ+u/0J95vy9by3W9EoQSA9ihhKwMrsTyjjT1X
         jEyo70hfa9WL3MIy9jn7EFoaKpeQN6FkuM8bn7XxQj12WY/W/H6l6oZj87+5r5JhJdvk
         CtYI0VEaafBU6sK6bV/5HcSVbuBZLO5DvPF7+96LCEg/bE3b7IeGF8IJQ466m4klf1ix
         DCyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779091048; x=1779695848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycc0wSl3+Drf46KKdfSMrZoXhkLDSPLUS21PV8OVhOg=;
        b=j5p3k6JumHiQu/t95kK9PZiP8cX2NdRN8KGyv1TrBj41dqBwUj1lp/LzvYxZpPM89y
         RXGgJ8TDsmU9tr7/GeLbSQRHcAJ3nseZdCQQl4zgwKAYQ2ImqsMBM9BoDfaB0eyQ3dip
         4rWbgCQ8BUxMgkkijWmxk0hqpsFKHq24HeL87m3HFIl2jTb5WU5ytiT0MECiENfJ84GQ
         BTiNBwY3UwGtOb7OILk/BGFLA9Hw6UZ2C61RSX3yEQ4/TosVGU7c4UoB9qs+TZSGLT8v
         LZTVgDkLR+jhkTWVzDHfXrb0XHlMA3+kgZYMfg9FnWHhjokg1ijBiC/OCgl73bCJclQm
         qDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091048; x=1779695848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycc0wSl3+Drf46KKdfSMrZoXhkLDSPLUS21PV8OVhOg=;
        b=IxO+/pLqQ65csM1h2rSv1eF6sX6ER5jIvaM4pm0n4AWAVJANMkRikEpMxYc5sI2KiT
         8eEG8+fe6+mgw2Sy6UPMrEq/QH0fI0tlo5MwgBAqQuOnnlEiQ57sZFaLQwYgH8qxxY9J
         xVz5wUIUjDb/Pbi4cgzagPaPmIdLIDn7lmSwJptJmCk7v3D3HVpgmYZNnNkSP7MOru3x
         YXI6yAHZ4ohTp4lOrpOWLI1t8PWV0yUiQU+YvFvWTp8Gc0fEm8MgE3xLap8m0xYtlFs7
         UKyD0XjM8V7V2HZ3YnJuMloHyPGIvL/XL0uxeN0DYj7duUR7fNOyOft9euJCN0TI/wbU
         TNxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MXfO36Cch528bV7hTLRoKjNTKSoUwgR4tCteo9MirhDw45i95BEVzL1CvoSTE+5LQ1r/dkuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTr0JGvOOF8hAP6K6WTJiB9nylM+uiMPdKhSU3k8Dl9BxsglzJ
	nhFCgV2mSc+rqzfdT98V/yd3kpzF4X6a+w10j4aLVf3vxxkiEw8dXEE7KfWt/7TsH5aROyC/qWU
	um+HhCKBLPOX45K8BEjxqFcPF14Vz6GdAAIzZBj3j
X-Gm-Gg: Acq92OGGQzzQVRucxrmCY2e+i8EQA/QFjLuYi9S0aBW/8YfE0YltohFnGz1cIHVzOKy
	XFnz0S7F2jM5AFU59MzahMpY0XEKgU5vAMD8By24FX1XjkREcZJkm3BKa7O+T8ROoySqZREx13Z
	GEF0c38Hjv6gdWLuRsMH2iNI7xsKkLtqghzal01wSl7MzUXcN7zg+26lIs3/Tn/6lrzAAXuqGfm
	3TDNp0pbczg/fQlI3euQEo9w2z5RvbB08j9CLI1GUUD4/K1zNRm5ztiKNfg8ILbQmGW/4/AKbOi
	1PH8Y4jnwDDdYeX5nCWUpiQg0B/e7V8FLOVMNCY6rGsj9rntA51gfFlBfQrTtCd1gl/d77bTl8V
	Vf6R0GxKkZzPQDAgvZC38XuHlRXs4
X-Received: by 2002:a05:622a:13d0:b0:50d:69cb:d603 with SMTP id
 d75a77b69052e-5165a21a2dcmr199875891cf.47.1779091047308; Mon, 18 May 2026
 00:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517184158.2757505-1-sbrivio@redhat.com> <20260517184158.2757505-2-sbrivio@redhat.com>
 <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com> <20260517215307.13cda56a@elisabeth>
In-Reply-To: <20260517215307.13cda56a@elisabeth>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 May 2026 00:57:16 -0700
X-Gm-Features: AVHnY4K6JJt1R3LyuzLt561bBFmlUBBiw-JfMG_b8grEqoNoW-nAMpX95JutlNQ
Message-ID: <CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair mode
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavel Emelyanov <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 17E00568595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288906-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[passt.top:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com=
> wrote:
>
> On Sun, 17 May 2026 12:05:45 -0700
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@redhat=
.com> wrote:
> > >
> > > Once a socket enters repair mode (TCP_REPAIR socket option with
> > > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > > number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
> > > (using TCP_REPAIR_QUEUE to select it).
> > >
> > > If we receive data after the application fetched the sequence number
> > > or saved the contents of the queue, though, the application will now
> > > have outdated information, which defeats the whole functionality,
> > > because this leads to gaps in sequence and data once they're restored
> > > by the target instance of the application, resulting in a hanging or
> > > otherwise non-functional TCP connection.
> > >
> > > This type of race condition was discovered in the KubeVirt integratio=
n
> > > of passt(1), using a remote iperf3 client connected to an iperf3
> > > server running in the guest which is being migrated. The setup allows
> > > traffic to reach the origin node hosting the guest during the
> > > migration.
> > >
> > > If passt dumps sequence number and contents of the queue *before*
> > > further data is received and acknowledged to the peer by the kernel,
> > > once the TCP data connection is migrated to the target node, the
> > > remote client becomes unable to continue sending, because a portion
> > > of the data it sent *and received an acknowledgement for* is now lost=
.
> > >
> > > Schematically:
> > >
> > > 1. client --seq 1:100--> origin host --> passt --> guest --> server
> > >
> > > 2. client <--ACK: 100-- origin host
> > >
> > > 3. migration starts,
> >
> > Here, a netfilter rule or bpf prog must be installed to
> > drop packets temporarily until migration completes.
>
> Thanks for the review.
>
> I have to say it's rather unexpected to have to work around obvious
> kernel issues in userspace: TCP_REPAIR implies that queues are frozen,
> and this is handled correctly on the sending side (see
> tcp_write_xmit()), but was clearly forgotten on the receiving side.

Have you contacted TCP repair authors for best practices?

Please do not add code to TCP fast path.

Instead make sure TCP repair inserts in ehash table sockets ready to be use=
d.

Yes, it is more complex, but I am sure it can be done properly.

>
> TCP_REPAIR also allows to dump queues, not just sequence numbers, so
> this really is a bad race condition making the whole functionality
> unreliable.
>
> But anyway, even looking for a practical workaround of the kind you
> suggested, I see two issues with it:
>
> 1. we would still have a race condition, because userspace doesn't have
>    a way to synchronise application of nftables rules (or even a BPF
>    program) with the effects of TCP_REPAIR. We could apply nftables
>    rules "a while before" just to be sure, but this is severely going to
>    impact migration downtime
>
> 2. passt(1) runs unprivileged and uses a very simple helper to set
>    TCP_REPAIR on the socket. Expanding helpers of this kind to directly
>    manipulate nftables rules, or installing BPF programs, looks like a
>    substantial security drawback
>
> > We do not want unlikely tests in the fast path.
>
> I understand, but note that this doesn't really add a branch to the
> fast path: there's already a list of (more expensive) conditions under
> which we need to fall back to slow path, with 'tp' definitely
> prefetched at that point, so I don't expect any fast path cost from
> doing this. Everything else is handled in the slow path.
>
> To be sure, I also checked throughput with delivery to local sockets as
> that's the only case affected (veth setup similar to the one from the
> selftests from patch 2/2) and there's no visible difference.
>
> > You can find a similar issue:
> > https://lore.kernel.org/netdev/20260130145122.368748-1-me@linux.beauty/
>
> That one is not a kernel issue: in that case, the socket is closed, so
> it's actually expected that the kernel will reset the connection. As
> Jakub pointed out, that patch introduces a race condition on its own,
> and it's a hack rather than a fix.
>
> We happened to have that kind of issue in passt as well (the
> implementation is inspired by CRIU), but that's something entirely
> different which userspace clearly needs to take care of, so we fixed it
> here:
>
>   https://passt.top/passt/commit/?id=3Da8782865c342eb2682cca292d5bf92b567=
344351
>
> > > passt enables repair mode, dumps the sequence
> > >    number (101) and sends it to the target node of the guest migratio=
n
> > >
> > > 4. client --seq 101:201--> origin host (passt not receiving anymore)
> > >
> > > 5. client <--ACK: 201-- origin host
> > >
> > > 6. migration completes, and passt restores sequence number 101 on the
> > >    migrated socket
> > >
> > > 7. client --seq 201:301--> target host (now seeing a sequence jump)
> > >
> > > 8. client <--ACK: 100-- target host
> > >
> > > ...and the connection can't recover anymore, because the client can't
> > > resend data that was already (erroneously) acknowledged. We need to
> > > avoid step 5. above.
> > >
> > > This would equally affect CRIU (the other known user of TCP_REPAIR),
> > > should data be received while the original container is frozen: the
> > > sequence dumped and the contents of the saved incoming queue would
> > > then depend on the timing.
> > >
> > > The race condition is also illustrated in the kselftests introduced
> > > by the next patch.
> > >
> > > To prevent this issue, discard data received for a socket in repair
> > > mode, with a new reason, SKB_DROP_REASON_SOCKET_REPAIR.
> > >
> > > Fixes: ee9952831cfd ("tcp: Initial repair mode")
> > > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > > ---
> > >  include/net/dropreason-core.h |  3 +++
> > >  net/ipv4/tcp_input.c          | 14 +++++++++++++-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-c=
ore.h
> > > index 2f312d1f67d6..19ab9e6ffc33 100644
> > > --- a/include/net/dropreason-core.h
> > > +++ b/include/net/dropreason-core.h
> > > @@ -9,6 +9,7 @@
> > >         FN(SOCKET_CLOSE)                \
> > >         FN(SOCKET_FILTER)               \
> > >         FN(SOCKET_RCVBUFF)              \
> > > +       FN(SOCKET_REPAIR)               \
> > >         FN(UNIX_DISCONNECT)             \
> > >         FN(UNIX_SKIP_OOB)               \
> > >         FN(PKT_TOO_SMALL)               \
> > > @@ -158,6 +159,8 @@ enum skb_drop_reason {
> > >         SKB_DROP_REASON_SOCKET_FILTER,
> > >         /** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is f=
ull */
> > >         SKB_DROP_REASON_SOCKET_RCVBUFF,
> > > +       /** @SKB_DROP_REASON_SOCKET_REPAIR: socket is in repair mode =
*/
> > > +       SKB_DROP_REASON_SOCKET_REPAIR,
> > >         /**
> > >          * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged whe=
n SOCK_DGRAM
> > >          * or SOCK_SEQPACKET socket re-connect()s to another socket o=
r notices
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index d5c9e65d9760..6eca34274f97 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -6457,6 +6457,7 @@ static bool tcp_validate_incoming(struct sock *=
sk, struct sk_buff *skb,
> > >   *       or pure receivers (this means either the sequence number or=
 the ack
> > >   *       value must stay constant)
> > >   *     - Unexpected TCP option.
> > > + *     - Socket is in repair mode.
> > >   *
> > >   *     When these conditions are not satisfied it drops into a stand=
ard
> > >   *     receive procedure patterned after RFC793 to handle all cases.
> > > @@ -6506,7 +6507,8 @@ void tcp_rcv_established(struct sock *sk, struc=
t sk_buff *skb)
> > >
> > >         if ((tcp_flag_word(th) & TCP_HP_BITS) =3D=3D tp->pred_flags &=
&
> > >             TCP_SKB_CB(skb)->seq =3D=3D tp->rcv_nxt &&
> > > -           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> > > +           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt) &&
> > > +           !tp->repair) {
> > >                 int tcp_header_len =3D tp->tcp_header_len;
> > >                 s32 delta =3D 0;
> > >                 int flag =3D 0;
> > > @@ -6632,6 +6634,11 @@ void tcp_rcv_established(struct sock *sk, stru=
ct sk_buff *skb)
> > >                 goto discard;
> > >         }
> > >
> > > +       if (tp->repair) {
> > > +               reason =3D SKB_DROP_REASON_SOCKET_REPAIR;
> > > +               goto discard;
> > > +       }
> > > +
> > >         /*
> > >          *      Standard slow path.
> > >          */
> > > @@ -7125,6 +7132,11 @@ tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
> > >         int queued =3D 0;
> > >         SKB_DR(reason);
> > >
> > > +       if (tp->repair) {
> > > +               SKB_DR_SET(reason, SOCKET_REPAIR);
> > > +               goto discard;
> > > +       }
> > > +
> > >         switch (sk->sk_state) {
> > >         case TCP_CLOSE:
> > >                 SKB_DR_SET(reason, TCP_CLOSE);
> > > --
> > > 2.43.0
>
> --
> Stefano
>

