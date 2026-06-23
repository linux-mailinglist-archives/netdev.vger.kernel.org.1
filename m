Return-Path: <netdev+bounces-301492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DnIBLAP6OmpbNggAu9opvQ
	(envelope-from <netdev+bounces-301492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:26:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD0B6BA3FE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LDpawnYy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301492-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301492-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713C93011BF1
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9F3AF64F;
	Tue, 23 Jun 2026 21:26:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F63ACF02
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 21:26:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249979; cv=pass; b=ZaUqlXDEBdpEtUKx1537WGSx0kd5qDTl6CPgyFu3bGsGbvY2PrW4jen6muDyNClFSynkGgj6vVsvBJRfNQkSOMO7KmqN5YoG/uShdw7qM4NAs2v+1ZpnzPMV2dm3eyHcmAlewtc4R5DIiYDgOMnEmQ57rsz11eq7ox9EVOrIzlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249979; c=relaxed/simple;
	bh=kmbhr2XiGYBwOOko7mqYKlF/rFd5r96q8J/WiCcO8aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzxNkg8vYhZmuuCfYI/HwutGW+GKNss1NwNgtf6wZR/KnE63PKg68897qV9pbzB28xwV32XU9gPAjw+vGUNTZlKivP7SZdrykyZHlqTTfJNanK9kgx3+NSWS686vPLMgNi1Cwt0AgLe0BRLssmXqgyX0+pyPziH2xV48epgzpvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDpawnYy; arc=pass smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso898150a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782249978; cv=none;
        d=google.com; s=arc-20260327;
        b=VxjgSTfLAcHZjBlwMm6wWXnMKkRN1D1TPgHzgVI4jd8ClYAVr2T+9Xu+zUJlt09G5t
         htHDYFuglcs3wZKN/IgUbfmBGFqUyIJNlNaoNNoGLgFiCmPgnkjLU+zlrlHmrW69pxlO
         ycU2g2FUdwTctGv3Th3k6nBo2wwLWfYZn7I17PHHWl9K4RqUspLC68jQVD1KIKi2W3jJ
         eCLj3iqXVVHH9km1/dQ9fwfqPLFl1OaCmaXdgA8G8pFc/rpfAinkOvcgpoq+ruz4epvX
         jV0L+WGgybOGp6kJ6BGaRiSK3B1l+pek+n1GedyxUfYgH1WmtiTf5QRsTN7AvdMOsLYq
         9c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        fh=whbP9V4se4T2ARobdhg8OKwc3gqTYMXmx/oPJ7LPT1A=;
        b=RFFQlt1edV/KwG8/TI/3Cm5zH+2RIvRq28aFzSOreps3mEwrANC7dNYI+uyVQv0wC5
         668vPa4xcMbeb80WYpUBdFv8lZlhGxGldI0jnU0FHJboMlhWXsTIs6/BWXEbGc/TIDDN
         wnVPMOtCABrz7rieWXwhTYVLAWFeFhBmbqsexbcNpoFQ+pAfN9cSCKtX9bHCHBU8FFYk
         BPxLYE4/PzChUFpzc82gsaXnAjN9j3QUv4gM5PxBqKoTLzS/3YRr4znTAXJD2R3pEUBD
         0wLdyaAnT4fQt/4vJuqiqc4VRLS8Po7i2vf9u6NsLdp/dEcLpbf4gpaKuJFzQbaQLT8d
         gcrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249978; x=1782854778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        b=LDpawnYyvALN7qgjd3o4/rpDjz25DIhZwCS6M8RjOO4tryuhSPM6CNoMBbpTbKm7v5
         bwwMa7k+LdSBZcqZ9pUOUFdkyvmgbfRzLhcK+ko7NjIDNCHpGaGEcXy0TOF5+X2Kw/dK
         CW3Cxm3egBXCgMrHn4dhv6rcjdKTdOP8JIVTvvFvN/hQsaWR4SYQ4BA7+vnmfCSesbVv
         UNexP89a4xEWR81PgWXpuRvXiPwEfzxeot2VOlTaPrd7v3hkXauFXPp+1a7ECiwokcqA
         szvLevkL2FSt83IiHyw3bXvOQOnSeGks/UxZho9GFtFXeNGXgNBbmd/zr21XUxA034Ae
         uASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249978; x=1782854778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        b=YTRtfCnqzSJs9toHQG+8G1NupIH2x/K2ZCSBKJjynvYahb8DVaBaXX0jIqKLTu7IVC
         6xwtgxpv5Gzov41XkMorZK9iEI6Kad8Y/ahczMISD/MB0xdoabOEWAjPd515UfywSi1q
         WQ4/XtyGDpmfk4JBHcoSUAwm3fKYZs5Qd2FNNhc6we39L25RCp6mbTSLKCJJRHyEsQ0R
         fhfeiBqgVMBXBRWv+KlkG7lav6oQpD0yLe113j9nCAmax9Z3qGZKNelovYYpgQhn+JM2
         K0fzoyE3mQPjRs5g1yNil2UU1kbJQsIPy9UgKUr47kFVMN0EiYvG2ffsnovBKvihK5xH
         QdSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZvk/mAyGc32uP+Meh0jgp4W2MpoNXZ7w32HPCDQKRzg4wE3w0GPz0FQmK7BR2rZEkR9eRtZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6Ci6xhn9qv5qUIBzDXVZ6lghwzdEKJ9C4KXeIKvFs4guZ9zk
	TJGrV52zaDcSuSzg9wx0hdzySy2+9JjKeOL3tdMfUJ6ugnX/mr4RmvM8A4eXRZTITjWUgNDAg9K
	e5gRjy5ufsBJyQzJ4O9IdgbDlA5HXfI0=
X-Gm-Gg: AfdE7cl6ltLTIwAzU/TnjvmSUo03TE2/itnP9P7uy9vTspllM4Lvmlg/N8M5S/zPaxX
	xVvN/yMOlh7DRtHMqcLbpxJ2apHceABU46tf56gntJCylfSuL8A0TS3Aeg9Ns2hgSnWUv0WJ/1l
	mb8hqQrF6bCj/nNFAWDC6ptJKyYVPw6dZtDXBWY/8Zh0l7oMNZuLq7GH9wOor60fcxOTllva+EV
	WFqtLZj5GJl7UzP1oLJpC09Ob16YcHsdVXfd8X3uxRY3hHa/U35VtuhJBuiMFpsrNKvh2XL6YDL
	BKGoHnq5Zgvc6iLhNawYHT2QN+llhAAkusnWVibyCizp30hGWAmic9pbGHXPNU2BDbySDeM51a1
	95zvaz27NpFVLoCSPl8kVEqEH
X-Received: by 2002:a17:903:1a0f:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2c7c3ff8e25mr45033955ad.20.1782249977555; Tue, 23 Jun 2026
 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com> <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
In-Reply-To: <878q85yoy5.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jun 2026 14:26:06 -0700
X-Gm-Features: AVVi8CeY7z9Rj08nBW_kFc0hpBI6wW6ndWShy7Xbr0q7dvXzSQPEb0mb2mBVoEs
Message-ID: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Amery Hung <ameryhung@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf <bpf@vger.kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301492-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:ameryhung@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD0B6BA3FE

On Tue, Jun 23, 2026 at 1:36=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
> > On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> >> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> >> >>
> >> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> >> >
> >> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@c=
loudflare.com> wrote:
> >> >> > >>
> >> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MS=
G. When
> >> >> > >> completed all code paths related to sockmap-based redirects sh=
ould be
> >> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt o=
ut by
> >> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a con=
tainer for
> >> >> > >> socket references would remain under BPF_SYSCALL.
> >> >> > >>
> >> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> >> > >> ---
> >> >> > >> Changes in v2:
> >> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> >> > >> - Elaborate on the end goal in description
> >> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-spl=
it-unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> >> > >> ---
> >> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> >> > >>
> >> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> >> > >> --- a/net/unix/af_unix.c
> >> >> > >> +++ b/net/unix/af_unix.c
> >> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct soc=
ket *sock, struct msghdr *msg, size_t si
> >> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> >> > >>
> >> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> >> > >> +       if (prot->recvmsg)
> >> >> > >
> >> >> > > There is no reason to have this dead branch when
> >> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> >> > >
> >> >> > > Let's compile out all sockmap code when both configs
> >> >> > > are not enabled.
> >> >> > >
> >> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> >> > > simpler approach.
> >> >> >
> >> >> > Okay, will put the whole file behind hidden config option like so=
:
> >> >> >
> >> >> > --- a/net/unix/Kconfig
> >> >> > +++ b/net/unix/Kconfig
> >> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >> >         help
> >> >> >           Support for UNIX socket monitoring interface used by th=
e ss tool.
> >> >> >           If unsure, say Y.
> >> >> > +
> >> >> > +config UNIX_BPF
> >> >>
> >> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> >> bpf_iter is supported without this config.
> >> >
> >> > I don't like where it's going.
> >> > I strongly dislike new config knobs.
> >> > I'd rather remove existing knobs.
> >> > What is the motivation?
> >>
> >> The goal is to compile out sockmap bits that use sk_msg.
> >> NET_SOCK_MSG is natural, exisiting candidate.
> >> New knob wasn't my idea.
> >
> > I'm also missing the big picture here.
> >
> > sockmap already holds socket references today. You can store and look
> > up sockets without attaching any verdict/parser program, and no
> > redirect happens. So if the goal is to use sockmap purely as a socket
> > container without the sk_msg fast-path overhead, what does a
> > compile-time NET_SOCK_MSG knob add over the runtime checks?
>
> Sure, let me clarify. It's about the maintenance overhead.
>
> sockmap-based redirects are a rather niche feature with few users, for
> which we've been getting quite a few bug reports since AI came along.
>
> We're not using it internally at Cloudflare, so I don't really have a
> good reason to justify time spent on these bug reports.
>
> Hence the move to put sockmap-based redirect behind a config option,
> which you can enable at your own risk. Or which we can deprecate, but
> that's not really my call.

This is wishful thinking that a config knob will stop
the bug reports.
Just disable it for real instead.

> > I am also not sure if NET_SOCK_MSG is right. It is broader than
> > "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> > Because those select it, it can't be toggled independently.
>
> Once the sockmap redirect bits are behind _some_ config option, it will
> be easy to replace it with a more granular one that depends on
> NET_SOCK_MSG. But we're not there yet. One step at a time.

No. That's not workable.

> > Could you share the concrete use case you have in mind, and whether
> > this came out of an earlier discussion or thread upstream?
>
> This is a follow up from discussions at BPF summit with Alexei & John.

Not quite. The discussion was to disable pieces of sockmap
that are causing trouble.
Not to move them under config knobs, but disable them.

