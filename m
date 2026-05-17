Return-Path: <netdev+bounces-288778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M+5GrwsCmqUxQQAu9opvQ
	(envelope-from <netdev+bounces-288778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 23:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCA563E38
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 23:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F2C03000FD9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7B2EA749;
	Sun, 17 May 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qp4+FKAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8E260566
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051704; cv=pass; b=MvMbTlTe55T1FM31XFjNOTCuZDF9eIjeUF8Yn9S4hQThNtcBylboB8tGcutPbR7hvQITeoxxUiy/Y3cenMGwRmFMHVS3MWXlf6AvkW1z6CZc+ZF7zTnm+opRuceqT2oyYO0A+tsGKX/Ek/5MK9+NNNaksiof0FUzA1haVS0840U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051704; c=relaxed/simple;
	bh=XcwF+voGzyrihir2UXqIAtpfc5HHpxMkkJMOJyMYcN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQvZmP+47URAvhrY/N/wtRfJBtUFtc6xusLOHFvdG12qncyV/bG8N39R+imfSElnjQd2F6yFYzfQWCEFyUpcvaLixH5yTk0A7WWLkAm0z/aFGyzmrW3Q8Fj1kCyxgRLIjKYZYuaLeXI4Dcmp9hz4RK8CtM1tRkpRl81umD8I84c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qp4+FKAJ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so1773122c88.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779051701; cv=none;
        d=google.com; s=arc-20240605;
        b=FJDGvedp2JKOSn42PzzTjBhmhyVE4EXdDuVoSsatDOYD3HK5NeFVhfItc8U0EvKkir
         UUMpf3GhrEbukzoWnPTD9ZW6kJuxN+C/1v8fxTPmM5h+HDf0GFEMxiC/qj/TRi6QX12q
         paneKAaqLTsMeWWu9DtTQfcC430/oBExEAtoDDPSSCrtjQMjZwFwWv8XuuqI0ZAlwnlB
         oR7lRa5jmcNALhYerKctQX677wxDCy+w9iBQfSj3HZBifTo4/gtPlQaTp0avceuEF8O6
         Xbe154TiblxfakbKTYBBwvSe142qJgDg2BFVtz8ExC4aEttZpp+NVCdC6FMqu4nTE5XP
         hujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l1e7nsqB0SkleMMtfALLI715YnnZXMRJ3Z3H4ARzTzQ=;
        fh=j2WoyUXxa1OzmEt8b4oOkENbiVWVNQJhZhqAPyitXpQ=;
        b=TciFqzTSe3s2pUfAxSDRRfS70mSSpIS87oZBG5Zzj8eVzGeD40h+gZxIvFgsStxQ4K
         arMwLkz0ZDJgmO3zFKCTq6GyqtW2DY6DPgQRDHZgt3Ad1wSkvEhEHjFD8tZTqFIXkwih
         84etEBF7/YvCeQFX51J5s55bf13wPaW3VJC8bxh/5sECvQdSi1NzX0XUmWFCDQTrMLBK
         EsFkpC+8tFS9js3Wg7I0Dn3xq5VFP39PLc/dBkNd0hAUwnzToEBDw9IVbmJ6On7YNfnd
         x4PZzcicjGeeja9nIiCd4A8QXve4mquwGHBOs4XsDFx9F/9djcx/IhvPmzeOkd6HuwlS
         Tzjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779051701; x=1779656501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1e7nsqB0SkleMMtfALLI715YnnZXMRJ3Z3H4ARzTzQ=;
        b=qp4+FKAJURlhCyokeZ57D5xkOyV7lkUfFpX2d3CeKyUteKpZzFVZgOzZwHoAKyga2b
         Vw4s24vBxv2Ie//IQO84ZCHp6hAEKsdfGn/4uCP7zwb/C10zFgheI7zY5RA4esccgPbm
         n1ppXdRLBKXoTxrLDeYdJ+l9jaHMqAQ4bFCPzqjZKOocBAqJc9rjkkceMvfME5u3eAbx
         UhvoxolQrfV5HFYHiQ3CJX1+FIxJJjLEhtj+onZcsT8/AsdDhLqGd+Lfo1oqGdL6xKXH
         xa74JQn6CHpDDxGcqGusTWauaIzW25JD8Pzpvi6/9VwS0MmXixMnOClDtbkC4lW7jCCW
         u//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779051701; x=1779656501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1e7nsqB0SkleMMtfALLI715YnnZXMRJ3Z3H4ARzTzQ=;
        b=ftovrNNGnrTsqKnBNJdvCaaDwCJV5oEewHdbXl6EWxWEUT7hJ7LSvkHXzxKadPPZKT
         C+dRWdUbnti/1I6JcheCxznHc17peEQJTpjcFTgDjZZu8WsHGe2IlSBbpJK3scQGnkxF
         2E3vqBN6XlhFIowjwJIWKadY3VpfzxydPRkAEewo6oZ1bNwlmkdiga2nR2AZbjHCX2WH
         jnGuY5xR1zSTITEqMeAlqXriQ+q+oy4Z+0U0fxgkQ8l7YxKGli14vkiFLDuVhWuBSlIn
         sPZ7LT4uuWUM1Bg3Bilz0/mTzQJ6p3YlcAQMCkyg0ed8+nutxPa+9CsXqx2czwHoE+GZ
         NwIA==
X-Forwarded-Encrypted: i=1; AFNElJ893aTnfHQH+G7MMMIwVRhgTUk2oABtQdAbyDgoxNVwNC7plVey8Pd+DavvBJBcPO4PYgJCDYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjwg1sV/nQRwt1XuWG3raDfVYAuZgyF8RZZhmGPozREyk8CXx
	CJHOZBCjuhzz1BkbMZpiB5N/KKk9uylUYFD679b63T/ctlegr2hzXwRv9J7Dq614KfMW1evNbu8
	XRoe4oRewnql1zIbicbCW1HqKY+NbsP4M/HMKZfny
X-Gm-Gg: Acq92OFkOsxnejzbV2ybkOKj9JooZkSXz+CveqvoujATGOjnNPez9B4VnP67HrCmDxh
	FmEry7x/TTOF+BvGG86/hkIT/U8ZgSeT+TWJxZuRWHAVMRxSOF/LFH5BXloH4N0Hg5YM1v/GTBb
	V8t/SjKhIIUfNhpu+wmYDd8kwJFpRt+FrD6dFbZuwd9Mwd3DGBmmJSKJlirP/vC7sxte0SPm4ZX
	TIycAV8oimd7jwW6yDkTg1dlzsRuI5ykwR1KnxxjK7XoYNdQmEc8ewNudb6Q6o1N4okQOEreRw1
	hFjBbvRDxnx/PScF+g3ugftt+WAPXRf5PlW49P/qGnK/NiGl7Bw1aDqvf1TN/cHB8UGA2EFo9Cv
	g6tiJSQROCzaCK9+kbm4DecdptjprOzA=
X-Received: by 2002:a05:7022:62aa:b0:12d:ca32:59f with SMTP id
 a92af1059eb24-1350441967emr5074414c88.11.1779051700738; Sun, 17 May 2026
 14:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517184158.2757505-1-sbrivio@redhat.com> <20260517184158.2757505-2-sbrivio@redhat.com>
 <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com> <20260517215307.13cda56a@elisabeth>
In-Reply-To: <20260517215307.13cda56a@elisabeth>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 17 May 2026 14:01:29 -0700
X-Gm-Features: AVHnY4IPALeNMOec3ibBVeNtMM0x9yg72S-FBK_8amrAxaDvHFzHy5p-jJRusjg
Message-ID: <CAAVpQUDc5FL2Ab-J3GHCU-LxPAwsZVfo=BG3chun6zRxOPVQtA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair mode
To: Stefano Brivio <sbrivio@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavel Emelyanov <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 10CCA563E38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,passt.top:server fail,mail.gmail.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
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
>    program) with the effects of TCP_REPAIR.

Note that setsockopt(TCP_REPAIR) is under lock_sock(), so the
backlog is always cleared before returning to userspace, and the
following getsockopt() will have stable view.


> We could apply nftables
>    rules "a while before" just to be sure, but this is severely going to
>    impact migration downtime

So it's "just before", not "a while before".


>
> 2. passt(1) runs unprivileged and uses a very simple helper to set
>    TCP_REPAIR on the socket.

I guess it uses userns ?

setsockopt(TCP_REPAIR) requires CAP_NET_ADMIN in the
userns tied to the socket's netns (in tcp_can_repair_sock()),
so you should be able to use netfilter anyway.


> Expanding helpers of this kind to directly
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

