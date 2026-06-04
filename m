Return-Path: <netdev+bounces-295241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zooIJK16IWqWHAEAu9opvQ
	(envelope-from <netdev+bounces-295241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:16:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D956403A9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:16:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IRyyyXbO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FB3300917D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0CA47885F;
	Thu,  4 Jun 2026 13:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F403477993
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:13:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578823; cv=pass; b=st3IY9UmCrEPZTCt42BexKiQleLDQKGT1sZHXgkr/4g98wMMv1gZiwuMciMz632lpJ5kgaHGrLEeWDfxqpK9WH6RFmTWTxTyp1O88WICHgxvVbhldkkZaQBOvAsbLGNM5W8v++amim8n3aOPBJ10BADcLpVrm+IqeURLCGuCmKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578823; c=relaxed/simple;
	bh=rfHhjL3ZZMp60w7b1i+Cr2MGuwtgIguCPu+p9RC8SQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTAEo/gHzKtAVdyM5uoXtkcrQPq67sgg7Ue9jHmTjBwu97UdXuMoyM8yK6AzlZXeHnvFFJ2uZPdG+EOj+DshC21x6EYIEOOSPRqBvxI64ej32bzrS5M8lgiLrEpcaUNfigZXlPJUsGVUoyzQGV2tW/H8W03KpOFdklY0SccxmvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRyyyXbO; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517863a2edfso5285011cf.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780578821; cv=none;
        d=google.com; s=arc-20240605;
        b=dv9OqVZCsmAkgBvGgrS1X6I0xWF3yELNzssQM4/sqhgLXCQUxO+6yRYUqhCMcIRgQY
         faOl5Elbls80VKidhlIijxrHY/O4c/mfYnODIJEqz5f/PkgwOFQhFtsNq+KxVy6Kr19l
         Q6VzM44vuSlDOGwFg/2Jrr9ErrOl4sJYwyfkk7gX0FgPW8jq6Jy6AQLnFO+OWgWKMvO2
         LX06YbWVgXsSRIjjjqe0WgeWlYx1UxutQdIoF7ijGd8aUhOUinyJqTjpd6mWo3clA9b3
         ip9IEVXrLwVmUxKjGAcoepZQuu7ix8x2qWUwWOHVI4vfbUpJRxd8Ctu5Sq0yKg9SZU8Z
         962A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLMuLfUGqkTkGr6t08UWpsLJjsHkoXfFjO9Vo2MOjIs=;
        fh=K/NG9dPRVSyMTaD+yBK9psxmjdzscoEmXfYRWUuNuyU=;
        b=KxqOQ/VQ7Y6aN+O5kEPzycM+UlWoYFVmrx/bK6eHj5pkIg6roSXlEil6qJEchrF+Rp
         ZAYsy1s0aXkxVD/Y7rU4Z5W3rCBVERj4wXBw8/q0Cuxra+Ajbo66RS0I9KafeSb2bFOd
         M0PIguUTwnx3FLeoKrJj0hUtQ0DKnuVrQpmCaeA+7jMzwSiWVXUqFcG8q5ipDfI3v8Rk
         fo6ouXgGswAmJO6WT5azYMdxBK0oVrW6LHkQVK/RLlOO/o86oImzBM9uoH5s8Chzn0h8
         28k/hRr4Xg6PzIpJhlUXS766C5U7iJC10PtnBxyw+XWtbHEj3Bz1Il6SHG1K5vTrt+TJ
         GCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780578821; x=1781183621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLMuLfUGqkTkGr6t08UWpsLJjsHkoXfFjO9Vo2MOjIs=;
        b=IRyyyXbOXJxB4a+WTrto/KeN20FUhCEmrPLpF5QKmw4OUMfPiapip151Fso5MV1kgn
         kIPwZ17SOmTI5DQXwLuE3GRU+Vb9xHeffUAzTNmbkNSZB5WHRiz1jJpgbPXlWtARRNf8
         isdgrDA+4T+0mj4HvCNpEqyFuOS77PP9QgN741hYZIkx/UU8/5iXGkBmPMU1QzFPzlLO
         UtYOGZM9/Wfoco1k/MqtxKJKvrq2cKaViQyxljYmqL1GC7htpSECL+9ZK4dwCe6wZhh9
         QLiLwvMD0CzrVeKc1yyh+wQybADPjL2heI3uzTc1X20lsPyXg31jERNPdikra790sjCO
         6UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578821; x=1781183621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLMuLfUGqkTkGr6t08UWpsLJjsHkoXfFjO9Vo2MOjIs=;
        b=IK6N2NgpX9weHM5aB/frc97LAJ74Tryk24DuSbHV6YOjGV0iJGVkxqw/Ejte3tYPNU
         3+Q4Wm6lCpHXc8kUKM8CbetYa7JtzPQjyNWAeUdYBTp+cXXiyYy6b/QPbIvzt2EQw+ea
         97MSuVK9W5+Qn/lvXZdzZ26jyFl+xAyxOQpGN0Gs556SxoDlqiqOPB2pTkgMBmAULdSD
         WZSui/N6reb91WLtz1QAvM6zsUy9X6vBYv+OM809WsX6xbOzuLkJtQgZI35SnYneqBdU
         6DQSeegXJCmSxVl4pY2oa0gb1/94EzrJ7Sg4qbbRhMb+VZ7YnN8aVLRxefgxiyuHIw8l
         WLtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tiz2j7m8o7W22zMk5qAEv/0ax4L0EjHGCdey1HZo2ltllFQxZ44Uik0PpnVdZpDKjvgAffNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4x7qnLwEV+oRcxcRvPOMG2qZn7hj82enYP+sUzv3FvhOc9xj
	IMPdNS1xk9rUxyuEsEC1Qi9mjbpEgmKpuLVKl4WZjCjjN94fN20ros4NWnRViEO7sdZwK/I+2bg
	IMYBt7CcLJRshylBglQHnxYN88PC5JcsjtMM0fgbc
X-Gm-Gg: Acq92OHjTbCtaYMx+VC+8d9um2iR2HkeDa54XwevwpubAxTDyGOXKLpEqrc/fiWNa8q
	I7Xny5hnahDKElf14GZ4OlieDBvlk+X+Q8lfW2MAAbMzFXs/I9VDyCWs3n7FGgydvESzJloZjZm
	fiHbr96CdnvKyliRHQBequl5Us9FNDkcjtghkzttkiNRGyuf1qzddQxHoymxq3nDJdjvpIUf22a
	6e44fs2KwsDPBk97SC8hDfBo0VUWPFCf9LlDK8kZSq0zjtv3WJxVaeSYmctDwQcVa6eFnYsHpWQ
	7b2yboshW9DIQBIa2+788ec1FClE5Yhrj6QiQi013ldlbq+k0fXEKks80FxnJonIU1qbWXP17OC
	Dt186BA52L0+NhwYMv5oJxm/jnzkJHg==
X-Received: by 2002:a05:622a:1dc3:b0:517:84f3:6908 with SMTP id
 d75a77b69052e-51784f3727dmr67811931cf.32.1780578820456; Thu, 04 Jun 2026
 06:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603171922.4A1512AA9D4@windowsforum.com> <345af51b-9135-4ca0-816b-781a61fdbcbe@linux.dev>
 <CAP_6uV+1zQqLtwH30SyuQmyHc03uv9ea+ZUr42TGSCozU4KcdA@mail.gmail.com>
In-Reply-To: <CAP_6uV+1zQqLtwH30SyuQmyHc03uv9ea+ZUr42TGSCozU4KcdA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 06:13:29 -0700
X-Gm-Features: AVHnY4LeIBb5kQLkkIRSYRzKcvvmNsrN7jJIUE8W9uhZX7zdFQHlQPHzAaaJWto
Message-ID: <CANn89iKWNXT_zeBHKZbQXAXbAs_+7iSMZVNXM=MOgHjygu+VfQ@mail.gmail.com>
Subject: Re: [RFC net] tls: TLS_SW sendfile() stalls at large MSS
To: "WindowsForum.com" <admin@windowsforum.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
	David Howells <dhowells@redhat.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:admin@windowsforum.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:dhowells@redhat.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,windowsforum.com:url,windowsforum.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1D956403A9

On Wed, Jun 3, 2026 at 11:53=E2=80=AFPM WindowsForum.com <admin@windowsforu=
m.com> wrote:
>
> Thanks for testing. The non-reproduction is maybe now the key data point.=
 My reproducer omitted a precondition my hosts happened to meet: a low net.=
ipv4.tcp_notsent_lowat. To reproduce, add before running:
>
> sysctl -w net.ipv4.tcp_notsent_lowat=3D16384
>
> Root cause
> ----------
> The stalling hosts have tcp_notsent_lowat=3D16384 (local web tuning); the=
 stock default is effectively disabled. A TLS 1.3 record is 16406 bytes (TL=
S_MAX_PAYLOAD_SIZE 16384 + 22), just above that watermark -- so once tls_sw=
 queues a single completed record, notsent (16406) exceeds the lowat, tcp_s=
tream_memory_free() returns false, and tls_sw parks in sk_stream_wait_memor=
y() holding exactly one corked record (the notsent:16406 + persist state fr=
om the original dump). With the default lowat, tls_sw keeps queuing, the MS=
G_MORE cork flushes at each sendfile() boundary, packets_out stays non-zero=
, and the persist timer never arms -- which is why stock kernels don't show=
 it.
>
> Three conditions must coincide:
>   (a) MSG_MORE forwarded on a completed record -> the sub-MSS record is c=
orked [the bug];
>   (b) tcp_notsent_lowat < one TLS record (16406) -> tls_sw blocks after t=
hat one record instead of streaming past it [the trigger I'd omitted];
>   (c) large MSS -> the record is sub-MSS, so the cork engages [the amplif=
ier].
>
> Confirmed by flipping only that knob: on a stalling host, restoring the d=
efault lowat -> 2.89 GiB/s; on a healthy host, setting lowat=3D16384 -> sta=
lls (~0.0001 GiB/s). Everything that merely correlated (kernel build, conge=
stion control/qdisc, wmem/rmem, tcp_mem, tcp_limit_output_bytes, CPU count,=
 AES-GCM impl) was flip-tested and ruled out.
>
> This doesn't change the proposed fix: clearing MSG_MORE for a full record=
 sends it immediately, so the deadlock can't form regardless of tcp_notsent=
_lowat.
>
> If you had not submitted your reply I don't think I would have kept testi=
ng it - hope this information is useful to the group.


I see no reason using such a small net.ipv4.tcp_notsent_lowat

Recommended/practical value for this sysctl is 2MB to reach line rate
on modern NICS.

tcp sendmsg() has an skb granularity; an skb packs around 64KB of
payload (this might be bigger if BIG TCP is enabled),
so 16KB is clearely asking for troubles.

>
>
> On Wed, Jun 3, 2026 at 11:12=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >
> >
> > On 6/4/26 1:19 AM, Mike Fara wrote:
> > > Hi,
> > >
> > > Software-kTLS (TLS_SW) TX over sendfile()/splice() drops to the TCP
> > > persist-timer cadence (tens of KB/s, with individual sendfile() calls=
 blocking
> > > for tens of seconds) when the path MSS is large -- e.g. loopback (MSS=
 65483) or
> > > jumbo frames. At a typical 1448-byte MSS it does not occur. Plain TCP
> > > sendfile() on the same path is unaffected, and kTLS write() (no splic=
e) is
> > > unaffected, so it is specific to TLS_SW + the splice/sendfile path.
> > >
> > > It triggers only on large-MSS paths with software kTLS (no NIC TLS of=
fload), so
> > > it is a niche path -- but it is a clean, reproducible multi-order-of-=
magnitude
> > > cliff, so it seems worth a look. Reproduces on current mainline. CCin=
g David
> > > Howells as the author of the 2023 sendpage->MSG_SPLICE_PAGES splice_t=
o_socket()
> > > rework referenced below, and Eric/Paolo as this is as much a TCP-cork=
ing
> > > interaction as a TLS one.
> > >
> > > Environment
> > > -----------
> > > - net/tls TLS_SW (no NIC offload; ethtool tls-hw-tx-offload: off [fix=
ed]).
> > > - AES-GCM; gcm(aes) resolves to generic-gcm-vaes-avx512.
> > >
> > > Reproducer (no OpenSSL/handshake; TLS_TX programmed with a fixed key,=
 the
> > > receiver discards ciphertext, like tools/testing/selftests/net/tls.c)=
:
> > >
> > >      cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
> > >      ./ktls_sendfile_stall          # default loopback MSS (65483)
> > >      ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG
> > >
> > > Observed (loopback, single box):
> > >
> > >      MSS=3Ddefault    sent=3D     4.0 MiB in  52.08s  =3D>  0.0001 Gi=
B/s   (stalled)
> > >      MSS=3D1448       sent=3D  2048.0 MiB in   1.65s  =3D>  1.2106 Gi=
B/s
> > >
> > > i.e. ~four orders of magnitude; at the default MSS a single sendfile(=
) blocks
> > > for tens of seconds. For contrast, on the same loopback path:
> > >
> > >      plain TCP sendfile() (no TLS ULP):           7.87  GiB/s
> > >      kTLS write() (TLS_SW, no splice, 2 GiB):      1.99  GiB/s
> >
> >
> > I tested your ktls_sendfile_stall.c under stable 6.6 and upstream, but
> > both of them works correctly.
> >
> > ~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=3D1448 sent=3D 2048.0 MiB in
> > 2.32s =3D> 0.8603 GiB/s ~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=3D14=
48
> > sent=3D 2048.0 MiB in 2.37s =3D> 0.8439 GiB/s ~/code/tmp$
> > ./ktls_sendfile_stall MSS=3Ddefault sent=3D 2048.0 MiB in 1.64s =3D> 1.=
2204
> > GiB/s :~/code/tmp$ ./ktls_sendfile_stall MSS=3Ddefault sent=3D 2048.0 M=
iB in
> > 1.70s =3D> 1.1737 GiB/s ~/code/tmp$ ./ktls_sendfile_stall 1448 MSS=3D14=
48
> > sent=3D 2048.0 MiB in 2.33s =3D> 0.8570 GiB/s
> >
> > ~/code/tmp$ ethtool -k lo | grep "tls-hw-tx-offload" tls-hw-tx-offload:
> > off [fixed]
> >

