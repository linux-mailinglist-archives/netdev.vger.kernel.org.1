Return-Path: <netdev+bounces-289582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKKvCDyvDGrdkwUAu9opvQ
	(envelope-from <netdev+bounces-289582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:43:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44F583D01
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98E3300A8F5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8736BCF0;
	Tue, 19 May 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrQlHwVs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C431ED80
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216184; cv=pass; b=T3SksQP0oXOJumPUvDGF/j0CiRqoJRbUh6dTy9khtPV0mDQwqd1BIJYFKhnpO+uFBOitw/vyFwiRAqu8V/p/b+DwGpLMWlvZmrPTGWDBxgCFY/7v0KwOnnRqFAqP2oIKJqYaTdXuW3Mn3z0Hrq5kb4jUsAVpDnQjlciePe5d9vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216184; c=relaxed/simple;
	bh=jyHZ/08tvcyFQsPqYGKjfC/6QDyS1u1QbpIxGFQeg9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv+alVJ43EB6CmPlRY8dFvjyH6zpfD9toUxW3P9p+0r6xMYXyYT7DJv74Y2hGBfr7uabLVdB0p+fGavd5sbSSlZuEyQVc+75Qq6+djyywKfKEQy8ayHcjxsXhPj9fWoyKenr52yAcnSqvNC03dZyMvD7xd8m0+oROBLo0Bkh1+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrQlHwVs; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d6b393d60so4121cf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216182; cv=none;
        d=google.com; s=arc-20240605;
        b=M9glaWKcIj2KzyjoqLELp0W5j2qy4NXzpvR9+tke7ZPSmrvydvWashbhM00uztwaHL
         XZws1YtDVdGO5rPHZSn8/j6fj+EpsCh9TqIbkB0i/hhWTWHNihC8ENSpC66DJ01DN66A
         uF6Qsig55AW0VlIqPfRs6zKfoxvnjnDsrXpwuGzNIrbApbtev8eLDpa8PmpAVYfX5E8X
         hZ4uP6qDUsuEFndP09IfWijS2YUQAnT2TwEy/9JfNMHaHlis3t9QmeibIoSkeBiO2QDd
         w2GICiNV6tKZnXdt+ytq4/5mJLHPL+xz9jl49fzeufMgHmg24EBHJeGq+XysKK9hnxCQ
         Jyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i16+FFvfRzBkoRR3FfnvsjYKLz//qSHJsdGGTw8nQ+c=;
        fh=hd1tqU/tVp3RiH3PzpbxZlcW8nTmWUwxbAwi3TV5zqw=;
        b=W/RtrCyQP1TqPQTsP2FE3GDolBzZnrigUuiWIE3pggVJntbLM9WARGlu1F46zRGdiS
         ggmOQ8V8YnXE4kb0nxMmZuVSHmHwev7sEcnBSB/7fSdVaJ9hnc5Fjzixa9OzqQAEQPQA
         BCfJWSlyepBGQUgfqa2/VcbWG/z0jrdF3S317g6e7U4K/paNGYiP/24Ruubnytlr7HQq
         jh/fzJTFEdHagH8k3/KK6VcRfeF4XNUkRVPPLkHgx1Y6OQPuiivT0U8ORBpJ1FfHemMa
         4CRounZfrpUEok2abiER0aWHP8ixGVkeVCYcv3XBhyUcnnLbi5T7EVQ1v3lUy4BQsmM5
         EP7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216182; x=1779820982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i16+FFvfRzBkoRR3FfnvsjYKLz//qSHJsdGGTw8nQ+c=;
        b=TrQlHwVstY6h/+9d08qDcMlrUXqpD/dz/oBE7sDTDTWycWY3h7XePO3FbNKSZYlYZg
         lKvt4j81W6ydM7fr12MVwWXWk9qA+buG0Scoj2vcLQmUCFNM2BcAk2vc4q4bysl6re+N
         PFKvU/AQRcXqos1FReFeDz10uTjOeNwd/Rpmi0oanLoM+0AQr4BoYPHLG7tplOkzSiez
         1AHjPzUDaJ/ruiDAeQSEq8WNA9IrU/UOI319EPlYw29zARWWVFrltsNEaNhMukVAn/Hp
         CuL3KTzfxOav0D59YK0qOj7NS8AtxT8Id+hiZconZ6ryUWe02CeXfTFoN3bVjmJVLDBD
         7nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216182; x=1779820982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i16+FFvfRzBkoRR3FfnvsjYKLz//qSHJsdGGTw8nQ+c=;
        b=Tzv1MF4PFKqrJrr3Ga7o9RLjyZgDoqY2YtJKrflA6593yCTkTNUMeNkvAGibLo5vgv
         SYU3K2B1TZJ+IrITizbuD0+Ujk2CkFIesUmINhQSt6kRyd40ljTsKQYDv9XGzoFdedER
         ndI+5Rx3UhF5pH7t57kQzXMGOTgPHFGPWq9uI73qigWWvaLnT/qBM6XNTuNXqkEs+gWQ
         Ma2WB4fwzhpe8o/N8JrPpv1eWTdmOc/jmn8PaPYCYgd3No5+xbSM0f+0EtR8pPL+SGh9
         fOyUvjeGxK7muKiodr7vDfFJGtKPSIPe1vTYy0OqOgxdjyDGESlnaz6tIDJ0L1pwGagI
         Jbeg==
X-Forwarded-Encrypted: i=1; AFNElJ8DOSI8M/wNGF5k2rtJe3gtn/5XEHGkrrT7XjLkKKzntY6FvECqZWcMJ/FNbhueUy9r+BXXIV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGd5hx35iG4jHAUewVAVPB0FO+1vW6joZ20VzXQT53Be9x3xFn
	sQPpvkUkoTmwnPvNzUTg4LJnoulHAvdfjMVFCS/t+oIU+OqBYuncZUABQDAC8nfjdipbzxBhG5e
	mkrxgBrJ7u83RUFI2ZdcHw2U8S2iVAuTSbmvW9jOz
X-Gm-Gg: Acq92OHdl8I6/HjEGprKUoSphpIWufiZaUb/FbXG0aCI6B051xdQuJFiKJFrzBLQh1/
	sQ3QF8HKrrmUSQyasrUzYCH0n+B5+02zQUKLvbcxxCvv49d4smXprDf9FZRwLNTrfRO45SGiaqT
	T6bLwF7DsRg+bFG6XzgC5gJbWKX5HP2PxRalActmEznDBEsLo9VDBcLpQ20uc6MPQhW4wv7M3mp
	WjnUyGdOr1jDC2n6yF3VcFlZc3jKCiNkcT+ls9nabtrtOj/uY878Le2wKNFkRLgMa4Yk5oiXKcS
	BuUhuCVbRMa81cnmyQ==
X-Received: by 2002:ac8:5f91:0:b0:50e:41f3:6467 with SMTP id
 d75a77b69052e-5167943f41fmr9837631cf.12.1779216181555; Tue, 19 May 2026
 11:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517184158.2757505-1-sbrivio@redhat.com> <20260517184158.2757505-2-sbrivio@redhat.com>
 <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
 <20260517215307.13cda56a@elisabeth> <CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
 <20260518132831.5b9eb0a8@elisabeth> <CAEWA0a5AG6JmeybHcxU+EL_Ohi0uVnSaVCiz7Bp_oDVuEdtO=g@mail.gmail.com>
 <20260519181157.1b0605f8@elisabeth>
In-Reply-To: <20260519181157.1b0605f8@elisabeth>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 19 May 2026 11:42:50 -0700
X-Gm-Features: AVHnY4IEKu_LjVK5cbfuKENBvnGAkj0ktHC3a1qrMUHOlR6-1UX7It_8tvvetmA
Message-ID: <CAEWA0a4d-PpWpVexYGP5SLRuzj8hs1W1_Ww6qA4BBrkzSs4umQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair mode
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavel Emelyanov <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Dmitry Safonov <dima@arista.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 6F44F583D01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:12=E2=80=AFAM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
>
> On Tue, 19 May 2026 08:36:27 -0700
> Andrei Vagin <avagin@google.com> wrote:
>
> > On Mon, May 18, 2026 at 4:34=E2=80=AFAM Stefano Brivio <sbrivio@redhat.=
com> wrote:
> > >
> > > On Mon, 18 May 2026 00:57:16 -0700
> > > Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > > On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@re=
dhat.com> wrote:
> > > > >
> > > > > On Sun, 17 May 2026 12:05:45 -0700
> > > > > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > > > >
> > > > > > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivi=
o@redhat.com> wrote:
> > > > > > >
> > > > > > > Once a socket enters repair mode (TCP_REPAIR socket option wi=
th
> > > > > > > TCP_REPAIR_ON value), it's possible to dump the receive seque=
nce
> > > > > > > number (TCP_QUEUE_SEQ) and the contents of the receive queue =
itself
> > > > > > > (using TCP_REPAIR_QUEUE to select it).
> > > > > > >
> > > > > > > If we receive data after the application fetched the sequence=
 number
> > > > > > > or saved the contents of the queue, though, the application w=
ill now
> > > > > > > have outdated information, which defeats the whole functional=
ity,
> > > > > > > because this leads to gaps in sequence and data once they're =
restored
> > > > > > > by the target instance of the application, resulting in a han=
ging or
> > > > > > > otherwise non-functional TCP connection.
> > > > > > >
> > > > > > > This type of race condition was discovered in the KubeVirt in=
tegration
> > > > > > > of passt(1), using a remote iperf3 client connected to an ipe=
rf3
> > > > > > > server running in the guest which is being migrated. The setu=
p allows
> > > > > > > traffic to reach the origin node hosting the guest during the
> > > > > > > migration.
> > > > > > >
> > > > > > > If passt dumps sequence number and contents of the queue *bef=
ore*
> > > > > > > further data is received and acknowledged to the peer by the =
kernel,
> > > > > > > once the TCP data connection is migrated to the target node, =
the
> > > > > > > remote client becomes unable to continue sending, because a p=
ortion
> > > > > > > of the data it sent *and received an acknowledgement for* is =
now lost.
> > > > > > >
> > > > > > > Schematically:
> > > > > > >
> > > > > > > 1. client --seq 1:100--> origin host --> passt --> guest --> =
server
> > > > > > >
> > > > > > > 2. client <--ACK: 100-- origin host
> > > > > > >
> > > > > > > 3. migration starts,
> > > > > >
> > > > > > Here, a netfilter rule or bpf prog must be installed to
> > > > > > drop packets temporarily until migration completes.
> > > > >
> > > > > Thanks for the review.
> > > > >
> > > > > I have to say it's rather unexpected to have to work around obvio=
us
> > > > > kernel issues in userspace: TCP_REPAIR implies that queues are fr=
ozen,
> > > > > and this is handled correctly on the sending side (see
> > > > > tcp_write_xmit()), but was clearly forgotten on the receiving sid=
e.
> > > >
> > > > Have you contacted TCP repair authors for best practices?
> > >
> > > I Cc'ed them here, Pavel is the author (but as far as I understand no=
t
> > > active in kernel development anymore), and I know that Andrei did som=
e
> > > substantial work on it in the past, so he's Cc'ed here as well.
> > >
> > > But we are following what CRIU (the userspace reference implementatio=
n)
> > > does, and CRIU would be affected by this issue as well (depending on
> > > usage).
> >
> > Before extracting the socket state, CRIU uses netfilter (iptables or
> > nftables) to block all traffic associated with the specific TCP
> > connection or, in the case of a container, the entire network namespace=
.
>
> ...by default, yes, by "depending on usage" I actually meant
> '--network-lock skip', but I have to admit I'm not sure how commonly
> that is used.
>
> > This approach provides two main benefits:
> >
> > During the dump, we don't need to leave all sockets in repair mode for
> > the entire duration of the dump.  We enable and disable repair mode jus=
t
> > to grab the state. It's simplify a roll back if something goes wrong.
>
> Thanks for clarifying this aspect, I wasn't sure whether it was done to
> make rollback easier.

I would rephrase that: it likely wasn't implemented originally because
Pavel may not have considered it necessary. When checkpointing a
container with a separate network namespace, blocking all traffic within
that namespace is straightforward. If CRIU crashes or is killed during a
dump, we simply unblock the traffic, and everything continues to
function without needing to manage individual connections.

As I mentioned before, I have no objections to the idea itself, moreover
it looks quite rational and will make the code safer regarding undesired
side effects/race conditions. Thanks for working on that.

Thanks,
Andrei

