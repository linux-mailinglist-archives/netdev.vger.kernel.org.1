Return-Path: <netdev+bounces-301474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KYq2Dv/oOmpALAgAu9opvQ
	(envelope-from <netdev+bounces-301474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:13:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9966B9E36
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:13:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Kbt9Pbl5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B2BF3071E63
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571E395AE7;
	Tue, 23 Jun 2026 20:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71438A706
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:13:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245616; cv=pass; b=pUM6bIsTnISTn2ZLZA0VKgAfx4tcQj8a2zQHkEgEoh0UoViMssULd/6X/voqoFHFfjOniy/IS7corxaZ0mDn4GcdhKRd8IXqDm1CrE3GXjPy5hyHftSyHFBOpduJLezotQDvkKQEG5ydNIVvFmV73p47JX0RZC1txipRfM/fIew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245616; c=relaxed/simple;
	bh=5sGeOw7VmUWiUHMPfJXbWRnlpRJBVEoR+wD19dd5j0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCe3kPDIMnJdAqg8Xpcw40bBntXkdwz204ybIXyA2R6QdJOEFZjxIJ6G7jYgW8pGeDMchCwmuHAYy+rI99PiZ0luZHkDnDzAkFA3XPVXL9NPTo5Wz0Be8d+2q7gj/jJm213jysYSu/T2+Ndf7kxUUHJ3EfqUUEgHEbzwoRjzk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kbt9Pbl5; arc=pass smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139986373b8so382524c88.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245614; cv=none;
        d=google.com; s=arc-20240605;
        b=VR1o8ViCL6xUrU90P+JdeB4EtdtDWrwuZdkk/c7F6CMDHpyEVRAiLV4nWFuR1bHm8E
         iSG4y9PFf1ghbHHHnscRkiIF3s/R7OFOnUkTACZTr8METLKz4nsaQfgw5yKGH6KIUezF
         09sE+pWLnuS8TEdEO5pxOVocH0ch9UbJ3ijujt4Fu/gC/1cMHRzTcb0WC5d0sDkwj3yA
         qgrLMQwtIcdetyd+LSFNk9D1fhxZIZbMpLInI0HjZaTzyGfF9QhRl3wUh38Dw6VJiuSV
         sKwE8XMbExl22bXZXtOZ3y60vHwi9zW0QSuPwJhe8iwEZD4nFd91SDLMd9LBpdPJcDEX
         U8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        fh=UjSFoOwHUEJV/pqr7TgakwqtSBqicToYU47ZyV3Yt5s=;
        b=WabTMxDlb4HahJf1sFSBeO2bmRKaXtywXiOSnt+E+7qAbqs0EbSzQg6MA/jB69rouU
         nFR7O4DHFPt4kdIqd8VfkiCCvf7gqKkcB4Z5VgLrH+WyyhSJYDszLweir2BQQd69naKt
         emWRdIkhSig0sV/yE07UKRlWO5ocgVtinmPf/yTBsZnlMNp9E5jSOUeI/JdN2sp5wNB+
         +gHckiCCjlVLaO1xsYaaj41Qt9jWFWvGnn46fNo/wPCviiR397sld+D13bM9fHxxgxAy
         2uvfvku/buBEvR4OwgR+k5M1fVXUoZUGYksQmQQEBPfj6yahZvqob+Ygqk2bg9jJDQRW
         F4gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245614; x=1782850414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        b=Kbt9Pbl5hNuql1DOAmfUQZtnx4xaUvWpCO5pofBgc+51+PKNDVRZeI9IJrEI56KqN4
         u0zF+BN8i1ieHptUyegRepMXPa8LxoEbuw1wCJnxMQZ40/3X340PefkWimMjIk3ly+rF
         Xo6VF/PyTTLXPGIpo8De0tcyqgNVLENUe/Pv1fPpqYVaQFBma7MSZEFgKxZ+prNmbUne
         N7pHqwlZVAEUdr0lLSQu5u7Cc3ZSEkYUajWdUO28pGWc+goyxLRO6pqZ9zPbOxTrYz0Y
         OixN8WR6YPaAQMxagcE6nTJLpmFppctGu4G6M3OKLb1rqQgtHOxoBcrzSdNIyyPG5Ps/
         669w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245614; x=1782850414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        b=MhEEWDNbpUhsW2H5JnJnoI6WLBZiF4MM2pmqYD72wvfR8XLdUTgpNU/dI2eDLb7Vdp
         nheU9PSrLoeo0Fuu+R2jIHiDYvaidYYwY6gtRtLYaQrkR6BRtoH9YPaH0Y22M7npuC7V
         quplAwycaIgxIlp8elOLUx2S4q7zZN56Y+MNR0JWE0mqk5cVuOlo1lM1fM8LMUvfEHcT
         1uEEjQEnpf39AdEy5jh3oe98ZXUzWVUgQqGbNSTSAXUMZaijmqI1OrnGYFKBPderz6PX
         ndX87VXREO+xW250OU8uLw72H7cSL6V62JaiBeKuiTdFnoYy7Be+2OFsFhnsMirhshpW
         ZgXg==
X-Forwarded-Encrypted: i=1; AFNElJ/r8M1gL8dX9aSeJBDQ/FGq8pNfYUKReyFhp7gZey7lGQKNAIOfRddZcwmJQ8nQ4eHzCG754Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlGVQd5LRG0HYF5vHcTuIEQTZCzEyQQJmSplQxrtx0Gl4/zeJ
	mckGNh4eXlcKgj70LplL5tIyHB/F30NggQl7aRAn2zAJ4P2EFFu5Y1CDsaH+Fce8+Fi0A/XiP0V
	v5fo79JvmfrPa62V9ti2zjESNCeMmu8wCq0+BFfZ8
X-Gm-Gg: AfdE7ckEj2bt6ONUVsr06tFHK5cYow2pbmZQhN6GHSGB/j2Q5+pNGFgSboQ42F4Fioz
	l/ny7HVmWkm2YJy5hMnxnw7LAZIfZ6nBbOXrO7B4dOreNcn8tYQ/Yi+2lkVdy+UYLLQo705C1Py
	3OTOL2nYg8egREXpLddq9CoU2esuOaGLetCRHBM/aXNO7X1ZjRKRp3Xj0It9Nt67Eb9xJQc7fLl
	SaC3yEzgt1R5FIqzIZrm8OkWlCzsVG9Z2XwJZoT5dFQ1qf8DhSReqLJXFqQQUZj0ZqPNr8jAr3G
	4jFXlifO7qvlMmfq37IZvalXoF/afC5i7AEqjUqhD7nkwb8HvwzCNgelA7WY4qiIO1vSLq7qVqB
	HiIPQB9ftbGhDbF3OzOfcV5y5SvUXu4ZyINqV/8c=
X-Received: by 2002:a05:7022:f9e:b0:138:4067:e44b with SMTP id
 a92af1059eb24-139d0c04109mr231753c88.12.1782245613203; Tue, 23 Jun 2026
 13:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com> <87mrwlyqg4.fsf@cloudflare.com>
In-Reply-To: <87mrwlyqg4.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 13:13:21 -0700
X-Gm-Features: AVVi8Cc3QtnEs9i7nXHsQhg0n0KdPybOUid5f0s8rhtZFNMPV5ILyqflipEPJAE
Message-ID: <CAAVpQUDgTvwG=Vvzz6gVea004f3LLTvdWz3tz1iOL1x9UW0SBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-301474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:alexei.starovoitov@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,cloudflare.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B9966B9E36

On Tue, Jun 23, 2026 at 1:03=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> >> >
> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> > >>
> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. =
When
> >> > >> completed all code paths related to sockmap-based redirects shoul=
d be
> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out =
by
> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a contai=
ner for
> >> > >> socket references would remain under BPF_SYSCALL.
> >> > >>
> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> > >> ---
> >> > >> Changes in v2:
> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> > >> - Elaborate on the end goal in description
> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-=
unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> > >> ---
> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> > >>
> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> > >> --- a/net/unix/af_unix.c
> >> > >> +++ b/net/unix/af_unix.c
> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket=
 *sock, struct msghdr *msg, size_t si
> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> > >>
> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> > >> +       if (prot->recvmsg)
> >> > >
> >> > > There is no reason to have this dead branch when
> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> > >
> >> > > Let's compile out all sockmap code when both configs
> >> > > are not enabled.
> >> > >
> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> > > simpler approach.
> >> >
> >> > Okay, will put the whole file behind hidden config option like so:
> >> >
> >> > --- a/net/unix/Kconfig
> >> > +++ b/net/unix/Kconfig
> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >         help
> >> >           Support for UNIX socket monitoring interface used by the s=
s tool.
> >> >           If unsure, say Y.
> >> > +
> >> > +config UNIX_BPF
> >>
> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> bpf_iter is supported without this config.
> >
> > I don't like where it's going.
> > I strongly dislike new config knobs.
> > I'd rather remove existing knobs.
> > What is the motivation?
>
> The goal is to compile out sockmap bits that use sk_msg.
> NET_SOCK_MSG is natural, exisiting candidate.
> New knob wasn't my idea.

I think config w/o description is okay since it's not selectable.

>
> Alternatively, we can do this to avoid the extra knob:
>
> ifdef CONFIG_BPF_SYSCALL
> unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
> endif

This is far better, I forgot ifdef is available.

