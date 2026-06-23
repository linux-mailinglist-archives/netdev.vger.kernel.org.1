Return-Path: <netdev+bounces-301469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ea4VBRLgOmrQJggAu9opvQ
	(envelope-from <netdev+bounces-301469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:35:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0836B9BD7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:35:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HAraGG4J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301469-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EE6C303A135
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9438392C32;
	Tue, 23 Jun 2026 19:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56630C608
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:33:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243227; cv=pass; b=X81PT5/l40I4S+NzKIurROOKC+MBJv6Q7DSOgR4OtS/SA5m/hPdMYtAkB8D2spX79eqCwFVmyi4B/bUq7kwBQ7aCdyySWPFSibtPxEjWut+sMieW6xKKyPZvbwj3VoOMvxi6PyHjXc8b8oYTQ5SZOIRGExS4Cg/c3GsmJvFrrww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243227; c=relaxed/simple;
	bh=Tn+iQA6ZhTH4MNOl1+92jKkFzlrelBdGGhR4vcgh4T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBM54ZvLHo2PRVHI4SVUNbFy6NUtoGLx+j4rLgk0DlwTe14YsOIOjyMvqtanGclWoCu3vcfg59lfinemHyy/hd73i6rx4aOhB0s2oikn3i5JAS8fV/qK6CkbKWMCNSXY7e66ePR7i3Ph09wkwcpR4jyOIAceDUOS5hm0ihk6cYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAraGG4J; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842848fd613so256258b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782243225; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7ikrd6A6NvpINQiwFzgSmbfSp/b7zJEosZQy6Rh0o+X+d9Ni9BjwAlkSXUBW2jTg5
         B8lV3nb9JsxROn62pA994zLvph9BdtLQs1kCNrcknPP05903h7JYmQUAXGHDoncAHLbJ
         /BUmKpkEhDwNFeWOLD5jkgNAwzWLTYUCQSMno+UHNWrzV6oF/DHYjZe5PpxXA2wlXTyu
         rzi968Pql5a9Nz5NFT612x/1iX4p2kFmjRVI787Gr4/K2hgjSt67/Ux+rEbTeDeHu88G
         NtaDVQoG/BOsWk61pX9qynqsHsUZ83lVNuWVR3TiDFTcEaH13F/qykq8VJGhPQdZGJ4D
         lhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        fh=o16TVwvtX7YIYZH90ebHS+nHVsDhPYlyyxTEcd2FDMk=;
        b=AdwVY60js5GtI+42JbsIfPdKDMzrpvPGSojo+OHhK5jgZPkiXjq+a0JAwdtbaEQXcL
         OdUpZgYpLdj502K0wECeQZJIdCoUCKcGVh75gTYS3MG/VJ6nwJNP510fSx+geyz+qpDr
         RdTfDJMOiQi7Icev10MvMkcPmTvSlOAZm//RI5Y3xB5ZuJR0/50XidJEdMnfXMqHTQBw
         bEUrDTnyopbOBNofewF7zkXJWGO3cgHQnQ6kip2B5AUGCTcXdZNUiwVNDwTGIBIPTZMd
         Kclxk/59XWEuUTmiLXaNa1RIjCSoQeHmGiHnpqXgKPBt7QN8vaIriLSks8/t+4qXUvm4
         CDYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782243225; x=1782848025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        b=HAraGG4JX9KJXKFwVpZ3bTuIa+KHmJOiKN72+iZQtzClQmBsi4JOZGK1Xtw28I0QzI
         URGibNxFvTokmYYr16iw6MBez8GUhyl24vN3lKpm4vBh/V2men2A0c5QE3+kwUBRpFYr
         JSmCsylFadAFyh+kn7CFXAgGpLPqF61KX0axyUBhUFiwIASz1gSWy9kTfpba3AxiNG5g
         OgtDyhgrIiRu8QKw8W+blq7D+qZ6aEzZQVZ7FsSxIi8N5g+KVLL6NdqEZ6DLKMytCnsX
         rGrYnwNpO6icOylEAysHM3cPS8nNFmr7DOMm/7p4/xG3oZxzY67fqNo111+jRQB5nKxW
         nkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243225; x=1782848025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        b=cFnBvbYRTeW9H5NGuIjtbHjGjSbORPPPHqhsaUZUirSKz5gzounJoO3CmFaaDId0bZ
         oILw7M94Vs7r3T5rh68MU6Sn9OU1i16nq8v5oifsAtwHtJlmyWtIEglC/6E0juSr3hBw
         hRh5iDTFbHVYVqDPx3kBIKGRfgoPO7b0POxGYDXGmnDQmb1Zw0NH8Py5poEgURdLIZ9d
         euFT3tG6Yf/MEcBfyY79DcuSgSUZv3EKQw51pcgjlTSt8gG8cJpAeebWsgSSBT+sSeGr
         /f48qA66I33az5S0vYS/74YVjwJ6mwWHhNTxGB5bw2m/kT95N65eHhidJg1Xj1CHzbFr
         u3Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+3o35V0GMl11Zv4oG/5ps31MmpNhWIbZeGsQiV8hFtnulgq5LFswhcxlOCMZhhgLNPCDPmYeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uTU7v5gQh2KjoCz6LgqrgLEtvedR/uiJ8TjRWpQrUch80gS6
	HmR36scKWMi6D+YCSiLCpqWTPzIqQxzzD5pt+Iaoin9K2muQb1aDvd4ynjzirFjr/9u7cZ4pZ+A
	o0E062E+EZlY3fFTOZz6+Nd/70wWKFy0=
X-Gm-Gg: AfdE7cmkgTObK3yYriYeKxyM7qfbIMdQoUK7puk83TJ6RVW58h2uZqEkwlv018EMvxT
	HaGIl4i6YNoNzVml+kdBhRGm0oFV8TAilfadwWglYQKDV78B6h8/YWCdh6djqLx1UT3UkS85+V5
	FFpMjariqLR48s9vi6sQAm5SKASewhPyjMBuvlfKCySleq7k0IoFrhUd34/mute125vKGW7+cZ5
	r22nUGo462A/ZJAAHtSN4FlZNh3fRCI2cfd0TcYsN3XPfFPX5S0zvVQmkceJ0M9FIvfP1faGGZM
	mHPe1mt8+ieklQ3WQg9M6cQwK16mAxoDpP6qPWwj4Cehgf1o4DniR9nrWSMg1EQrB+eA74o5nTd
	WGlnrtoycOChz/g==
X-Received: by 2002:a05:6a00:1c8f:b0:842:650c:153e with SMTP id
 d2e1a72fcca58-84562496e68mr17420158b3a.20.1782243225164; Tue, 23 Jun 2026
 12:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
In-Reply-To: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jun 2026 12:33:33 -0700
X-Gm-Features: AVVi8CfXsvt87dwIgEd9FrX9gy85kkM2pU8VaQLRIibBAfuVgoLBDMPyOjlQs2s
Message-ID: <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301469-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:jakub@cloudflare.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email,msgid.link:url,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F0836B9BD7

On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
> >
> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> > >>
> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. Whe=
n
> > >> completed all code paths related to sockmap-based redirects should b=
e
> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a container=
 for
> > >> socket references would remain under BPF_SYSCALL.
> > >>
> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > >> ---
> > >> Changes in v2:
> > >> - Handle prot->recvmsg being NULL (Sashiko)
> > >> - Elaborate on the end goal in description
> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-uni=
x-v1-1-d7e0cb7bb03b@cloudflare.com
> > >> ---
> > >>  net/unix/af_unix.c  | 4 ++--
> > >>  net/unix/unix_bpf.c | 6 ++++++
> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > >> index f7a9d55eee8a..84c11c60c75f 100644
> > >> --- a/net/unix/af_unix.c
> > >> +++ b/net/unix/af_unix.c
> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *s=
ock, struct msghdr *msg, size_t si
> > >>  #ifdef CONFIG_BPF_SYSCALL
> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > >>
> > >> -       if (prot !=3D &unix_dgram_proto)
> > >> +       if (prot->recvmsg)
> > >
> > > There is no reason to have this dead branch when
> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> > >
> > > Let's compile out all sockmap code when both configs
> > > are not enabled.
> > >
> > > Since AF_UNIX differs from TCP/UDP, it can take the
> > > simpler approach.
> >
> > Okay, will put the whole file behind hidden config option like so:
> >
> > --- a/net/unix/Kconfig
> > +++ b/net/unix/Kconfig
> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >         help
> >           Support for UNIX socket monitoring interface used by the ss t=
ool.
> >           If unsure, say Y.
> > +
> > +config UNIX_BPF
>
> Maybe UNIX_BPF_SOCKMAP or something.
> bpf_iter is supported without this config.

I don't like where it's going.
I strongly dislike new config knobs.
I'd rather remove existing knobs.
What is the motivation?

