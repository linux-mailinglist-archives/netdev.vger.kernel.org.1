Return-Path: <netdev+bounces-264170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP1dD6X7qGnVzwAAu9opvQ
	(envelope-from <netdev+bounces-264170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:42:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E620AA4D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946D53007C8E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6727A133;
	Thu,  5 Mar 2026 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeBM1Lw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534E26E142
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682128; cv=pass; b=cdhtQs3qTczPp9LadFaXPs6zmyBhbhj7SFGlYTBlWmc4NIvyehslAo1zzhdchYmAJ5wt/J7LiPiJlIOBcKP85mU2XeDjZjN8bDKFhSc+FiGcf3EUJ6QCObv3yhGpS8flkfY85xkKY5q37ZyZV3FI+//kK4nx8x846WQQriH51Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682128; c=relaxed/simple;
	bh=Q7K9Jo92G86BmPJUCWpH8Ckm6Y5l4M+EkxUH8NVeFfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTN8KlvMwhUY2qPpL7qJDvHACt+D+dMBIOoaIGEuCwKlQQwdbDO9xNUonsUpQ59xvs9OpzQ320gT934a3wKpEROm6nN6ppQEb0uOWVYomSur38pnEC+zfJtdqWPSQzkdKArck3IPzmuIxwXEkqFAIuq5TNtn+maAtWlZWyjl2qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeBM1Lw8; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732165d1eso8211623c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 19:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682126; cv=none;
        d=google.com; s=arc-20240605;
        b=KvOJAcfaCaU7Hx5NNZLwQCuNxYPzYK0YlVI8dncvVQex6Cn5BD8bS2ryDp2n7D/G/i
         tMKLN8eJGqN71xGq04mvyelMSNjkEq2TL2PwfQ9SWK9FdHpapu6QovqBKbYzIyv92YnA
         bFV1kYFr9pHMtkJ2DwsSia5xAv+WCfn++OBtua8VIiAHeKwPJFWiB75D/udOos1TXpuv
         +sKltBjmcWn408YDt/a3MI3Iy6XoCF3GN3wkpZSYy2sjn1gN8/kVfhvPKmt0ZFtuHPOS
         r16haXATY9YKPsZ8NAcYNCY2nBe/wD9/NmN3Pmf4osV2icOIQmrzBenrc0hHsWoM84Qy
         bfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        fh=ogs4swrAxTiciwEHNSiAMM8JY4Tf5UbX7zQY8Jb5+4U=;
        b=JEh/mpRuTd1nNLAnLCFSJtUKLKvUb18SRrFxkDRpzP2ZSv29colMHjtl70u8thI9lD
         D0OifrJAFQht/b0wweQmXdRr3hjlilH0iRVYNMnzCptikRCT34Pk/z1JbHpFFujEAbbG
         jJGmFPsIqI7uqEyoxRiIbGwMSnuvLJnd55l9FhwrovkYKORZGNUX4SlJ4rWy+zb35YmG
         tmWhuY4AcRnirayWju8gC/y+CWDVpzKGkKCMdxBLQXoe1Bb48MZC23U0ru9sHwUWo1Yc
         VejZK1mznWps4n0KG1BbkJzRLKGsK6NXscuGdt16KhvJXlWRTgX+84XqSE5ZEBfVzJfO
         Q1YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772682126; x=1773286926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        b=qeBM1Lw8TbVIW9HtBKQZGUg3uAeBvcYHB9hYWbq39GRcrvYXzNoykT1wsU2RHqHDg/
         jpn9Ry5ZtbdFI8LI8u2wKe4OmhbFpoZYIRs8ZzcpDoybHv+Uys20s9dPP4m7xJ/jUGoo
         rs7a92psf9XMSiIpoVoa9r3Se4ymdtreIXFkGY+ll+iJiQQtTth7K/LMUkjpLyXB/eBQ
         LovUNOnqcrvIaTsKMG4Wb/LtdKNB//Xyb0N3Co71FiNEwiDyGYx+3pv6v4RNP+gK1lOU
         ThokUUO7K6KP/aX9NvADwJk5+pFjp+OKnOXguDMS7I3T6hcimidlI2UqiXgFnhHQJaND
         fhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682126; x=1773286926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        b=wGL5kH00Cv2Gv2I2LS4X2nOkRvP4Be3P3LIKPa+Mva266wfkwWMd8yvxhoFEw+Vw6w
         A5UYqu3uYO8y0qreNciEGVYLgDKeYrq2tEImaqLnjAs3YcuB1nBR/FhY8uAlFakAwuVe
         NMxJ3yNbLDt7HXFuIlU+V/eRi21bhHg5S1crmY7auRqp3FA5kD4nq+rLWPsFG9bM6aXT
         kqlCt859B+NIDTzi7d2K0dfNEbqWtkwcLaXixu06gpVKEr+W9LzBVfAjaI9dby1sY4Kl
         E3K9qZ+L867GItil/T0xJpq4xawi5byykqAM4yOiwLaTN2w07VM77V8fGjXz1DTW2HQ/
         wxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWqctUcPbigkFMychOq6zGk/MvwKkBEM7pHWz9qP41RW9STUuyxfEPGPj1Bnus51QBFr5FkfH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzTUevsJOLm/Llf5iBsVgXUxrLDdxC+6GduzO12fdF7evOarw
	IkQnEHSDAUde/NWg9zLek4Mb4c6o/enbJ3pCWypzojPqvusvFfUedzengT6W7vxt3Eis0niNWPt
	EccJ/KEsrINn1wHazux4H0rroBUnZ9wCxM+qA7M3x
X-Gm-Gg: ATEYQzwCbeTbyV5OwaAmB9nipKT6ng3c4tW1Et5768Pw07i1dlPRnSn2k1sa2xlwLtk
	BqeOf1I8DD9EeDB5YCQByawwV8HM4wutQ4boQHHZsOk8utF4iU8aqeESpYfphrhERD4ezmyyLSp
	V1fDJdlDMAz0e4GGUFTsv26389ZzB6cMvbzgw+zAKh6NDne1gF3Fqq7OW6ZMAgFOUage333+rKz
	FsY1De4eIoV3WpdXpOvtDYYWu1wBzMgTYpvvtie9oqoYWAC16zid/6NdKyrT+jayfc1A3fFGrPk
	RbEDtHJxcoBXA+GhTPd2WA7DNx6XZTAyqAmcQ1v2l1O2Niq5mv/feUQCRs0/bJlVI8bOfX37
X-Received: by 2002:a05:7022:238e:b0:11b:ceee:a46d with SMTP id
 a92af1059eb24-128b70a403cmr1467046c88.15.1772682125291; Wed, 04 Mar 2026
 19:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-4-kuniyu@google.com>
 <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
In-Reply-To: <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 19:41:54 -0800
X-Gm-Features: AaiRm52HICgRVA9yBp1pMCjIA_v984tORy1UIdfq4YvFSooO0AOUW58dJWgIa4I
Message-ID: <CAAVpQUD1NrXM9kRQgSOFFM4j73gg7aE7Yba6XDkdL42ZQMQESg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in udp_bpf_recvmsg().
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9B7E620AA4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264170-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 6:30=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:50PM +0800, Kuniyuki Iwashima wrote:
> > syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0=
]
> >
> > sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> > but its processing is lockless.
> >
> > Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> > multiple threads could touch the same sk_msg.
> >
> > For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock=
.
> >
> > Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> > commit accidentally removed it.
> >
> > Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
> >
> > Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> > an option due to copy_page_to_iter() in sk_msg_recvmsg().
> >
> > [0]:
> > BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/=
skmsg.c:428
> > Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
> >
> > CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/13/2026
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
>
> [...]
> > Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> > Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/udp_bpf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 779a3a03762f..b07774034a91 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -52,7 +52,9 @@ static int udp_msg_wait_data(struct sock *sk, struct =
sk_psock *psock,
> >       sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> >       ret =3D udp_msg_has_data(sk, psock);
> >       if (!ret) {
> > +             release_sock(sk);
> >               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> > +             lock_sock(sk);
> >               ret =3D udp_msg_has_data(sk, psock);
> >       }
> >       sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -81,6 +83,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >               goto out;
> >       }
> >
> > +     lock_sock(sk);
> >  msg_bytes_ready:
> >       copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
> >       if (!copied) {
> > @@ -92,11 +95,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >               if (data) {
> >                       if (psock_has_data(psock))
> >                               goto msg_bytes_ready;
> > +
> > +                     release_sock(sk);
> > +
> >                       ret =3D sk_udp_recvmsg(sk, msg, len, flags, addr_=
len);
> >                       goto out;
> >               }
> >               copied =3D -EAGAIN;
> >       }
> > +
> > +     release_sock(sk);
> > +
> >       ret =3D copied;
> >  out:
> >       sk_psock_put(sk, psock);
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
>
> LGTM.
>
> One minor observation for a possible follow-up:
> psock_has_data() is checked before lock_sock(), which leaves a TOCTOU win=
dow.

This is intentional.  We don't want to hold lock_sock()
just to check if the queue is empty, which can be done locklessly.
Otherwise, you will introduce an unnecessary lock dance
for every sk_udp_recvmsg() in case the psock queue is empty,
which is too bad.


>
> If the BPF verdict path consumes the skb from the UDP receive queue and r=
edirects it to
> psock->ingress_msg between the check and sk_udp_recvmsg(), the thread may=
 block in
> __skb_recv_udp() while data is already available in the psock.

And this is just a matter of timing.  If it's already empty before
the first check, the thread is anyway blocked in sk_udp_recvmsg().

>
> Moving lock_sock() before the psock_has_data() check (as the original cod=
e
> did before 9f2470fbc4cb) would narrow this window, similar to how
> __tcp_bpf_recvmsg() acquires lock_sock() upfront. But that can be a
> separate patch.

