Return-Path: <netdev+bounces-301472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pp1TF7jmOmq6KggAu9opvQ
	(envelope-from <netdev+bounces-301472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BA6B9D59
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:04:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=c5ypY7F4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301472-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301472-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B33F30AA3CC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CAD3932FF;
	Tue, 23 Jun 2026 20:03:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB835675B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245024; cv=none; b=dPWALxLJqfMF1pW7H5Nu6uQ49E0ngL+3HIpFXySBfJ/UKyu/1HdaM+cb6xBZInEvMssZBgytll1KurdBf8e1mGJ3hoy9Ln300Wce7qZGowx3D/krkZttI/w6pv20xC9/aeha+9lsC8HQxC6gXd9eXT0NnQ+YrljMf5Fhc/Pwecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245024; c=relaxed/simple;
	bh=pSaanlwtBbeInvRpU6KeexNfjPmfeqm+bZK18BkZANc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ke6oSftzBRmNHNTXVe2cJV860ry6S959t+c9SaY+wpLNjBWfgy8iS7M2H/AuQlOlt7qUdTTF5vS4FErBVxwDrYeMlgQAGjNtaLTUgL5czcGaIf0ofsjA/gNayfgqD6w5yenpFnO5T72TsjUObPYaRMw9HxYt9IXc+9AfuHkfnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c5ypY7F4; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697de335c18so392474a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782245021; x=1782849821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6SzrCo7H7iOgBc7gPmXFJSVTMaa0i98zxr3jzUeDCQ=;
        b=c5ypY7F4bTWGvo/DFcIWK5U6o0PJCS52+zpyrgV+rX78rAHrKkRguMf+dLNpSA+9Ej
         RhthrpBU8u9jeZ/wzrx56pdKRiW7nIwnEPlDQ839bwxwA6U0GzzwTlfx77280llyVKw0
         OINGdHcYZMZ3Zqc/0ts/5gMhqkLh7CcrS/m52FKAz9tl9TueRHvFMXfm23V+xDX+1bB+
         AdZIFSqicYz2YfOoScEawaT5FpzyVfSBdu6a4r46+G5rHB6fxewdPBcz6yEJyZFEZzvq
         kVNnyXMrZ2TtTzmtZApe0kXx0zLsaG8NkNYIBKlQYyFljQDoezVvMntQ1AhVUfv0/zdQ
         JNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245021; x=1782849821;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6SzrCo7H7iOgBc7gPmXFJSVTMaa0i98zxr3jzUeDCQ=;
        b=VB3KBvVVm/iDmBBjnjdh8vah7GZ8ZCtltvfJkaqpOHlTYZPGxwwQrG8Qf9g/q3NeN0
         wif9Qun5ezpA/Wq/GX1TXqEeDVlgj9IOM8NyLR7BFPad+37XNryASRVFkwbWf86S1J/N
         t3Y71V7wD8/mLQoweqp7ad4HQhTcOvHE8IN8MBVc9+9VAGyNvi4qHF56psSi6h9A9QRR
         Pw2CEOK4IfFHGzLE9jBnE1J/H95v5lCwT4AGEROWx7XlkJjQbAemWIODM7Ve8i87soIZ
         TIQhA7pMKrGqo7/JITLAo3pqRY2fZOrY1kwVjf4oIZ7nRtdweg5HUnKxSUIbl4yoQI68
         dJyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+seFQC6764meuCHqXPI8f6Vg55UlcbezMoPK1GQIPyFT/KNSbZF+ucqhqKnu9B5py7KZs8LfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtAhj2xBdupKy9ZDh9QITgPjJFSm8oGjfQZf3V34/Oh+OcgvU
	cBca2N9vDX0ydwGUgGRXDibOGJH07tNNqCL7d9vCFse+HlqucTktzNX0rOWJmSVEfG4=
X-Gm-Gg: AfdE7cnGtg+cDpvWVTNjHdyJ3Gn3hvIZ+zrcVCGVXwWefz37e3GRElWLGZOnY2cU0BT
	oixB1J/a49OJQ3+nVAX2enaQOh0ouh3MBz6xNG5ZcDcQn3ez745Uu10k/5QzjaLwaeZJL/mpSwD
	Lnix8vIuspY+gzteBAUf9i9J1raQKnfJsnwo2+graouhs6rUDRXdz+/W9EULvJ8RvQbjr1oPgKz
	puYAtW1178wvGFla/hWxclZRjoV3sr9voHpyxfT8CvLodcLmXKePBn0128U6MBL8rTkcskLhXdw
	2P0uWFI0JI6dhqR3juioRpsvNRTZXWDs9O7RDlM60J+jvNk4PG0Mv4zzHFjGSbYKNBMedRqe9jK
	Dy2vsxpr8VvXBVOQdZCHMvyQQhR268tjGY75kMo38aj/ZiZlIlGqHBqMhMkCMeuFIo16b/UW7S8
	3o5Qp595wEPY8F6bQ=
X-Received: by 2002:a05:6402:5190:b0:671:a18b:32b8 with SMTP id 4fb4d7f45d1cf-697f305a514mr61658a12.0.1782245021176;
        Tue, 23 Jun 2026 13:03:41 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be32083sm5237099a12.14.2026.06.23.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:03:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,
  Network Development <netdev@vger.kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 23 Jun 2026 12:33:33 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:03:39 +0200
Message-ID: <87mrwlyqg4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301472-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C45BA6B9D59

On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
>>
>> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
>> >
>> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudf=
lare.com> wrote:
>> > >>
>> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. Wh=
en
>> > >> completed all code paths related to sockmap-based redirects should =
be
>> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a containe=
r for
>> > >> socket references would remain under BPF_SYSCALL.
>> > >>
>> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > >> ---
>> > >> Changes in v2:
>> > >> - Handle prot->recvmsg being NULL (Sashiko)
>> > >> - Elaborate on the end goal in description
>> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-un=
ix-v1-1-d7e0cb7bb03b@cloudflare.com
>> > >> ---
>> > >>  net/unix/af_unix.c  | 4 ++--
>> > >>  net/unix/unix_bpf.c | 6 ++++++
>> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
>> > >>
>> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> > >> index f7a9d55eee8a..84c11c60c75f 100644
>> > >> --- a/net/unix/af_unix.c
>> > >> +++ b/net/unix/af_unix.c
>> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *=
sock, struct msghdr *msg, size_t si
>> > >>  #ifdef CONFIG_BPF_SYSCALL
>> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>> > >>
>> > >> -       if (prot !=3D &unix_dgram_proto)
>> > >> +       if (prot->recvmsg)
>> > >
>> > > There is no reason to have this dead branch when
>> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>> > >
>> > > Let's compile out all sockmap code when both configs
>> > > are not enabled.
>> > >
>> > > Since AF_UNIX differs from TCP/UDP, it can take the
>> > > simpler approach.
>> >
>> > Okay, will put the whole file behind hidden config option like so:
>> >
>> > --- a/net/unix/Kconfig
>> > +++ b/net/unix/Kconfig
>> > @@ -30,3 +30,8 @@ config UNIX_DIAG
>> >         help
>> >           Support for UNIX socket monitoring interface used by the ss =
tool.
>> >           If unsure, say Y.
>> > +
>> > +config UNIX_BPF
>>
>> Maybe UNIX_BPF_SOCKMAP or something.
>> bpf_iter is supported without this config.
>
> I don't like where it's going.
> I strongly dislike new config knobs.
> I'd rather remove existing knobs.
> What is the motivation?

The goal is to compile out sockmap bits that use sk_msg.
NET_SOCK_MSG is natural, exisiting candidate.
New knob wasn't my idea.

Alternatively, we can do this to avoid the extra knob:

ifdef CONFIG_BPF_SYSCALL
unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
endif

