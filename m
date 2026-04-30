Return-Path: <netdev+bounces-283000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOieBDbH82kp7AEAu9opvQ
	(envelope-from <netdev+bounces-283000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD24A821F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C25403083506
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC683BD65A;
	Thu, 30 Apr 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClWEuZ5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E213BE146
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583666; cv=pass; b=Y6K2bfMfNmSH6J0fbARe9nBMbKhj0iqqYTb3kisyoSDQ24uAz7YZ/UDHwSh5SsxfLaGZTAPmCwEeckK43q98I5Weqv3r0Pqug1D9YqZtKoimyKgcJ8P6lTdkXng2gXXI3n5FxyuRU5DhRCHFwI3+d1qkYvcS2t/lWRl/xYDxO1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583666; c=relaxed/simple;
	bh=KeLktcW4RN4FirOdw8p7/AA+E8QD/RT5ZeIRPUFSs1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgzDGz7ou4x7uHMC44FvMW9QsUD4aV2CFhYAAbQJpFQ9hLCFERMv1UxPIBDInqR+GC5uWpCbuocHLsR75flqRemaFUBl2Bk5gDZOrYNmZ9UzZWqJIyZOR5Z1jnTBqa+OIY4pXzwmyUmvQICDbf3tA2z9IJC1k8jM4FuAwGSACLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClWEuZ5B; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dbd0f8063so1064118c88.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777583664; cv=none;
        d=google.com; s=arc-20240605;
        b=ITTfLjfrFQVJumHix0AfGDpmdqyxNEl6ElCcE+9cwxkQFUa7LGUCeTk4eVaICzipXQ
         155jVHL4cYrloOBZ6/3Prh4y1EmngAlI5Zv2izopTvP+20A1RJPQhG8a6l1jdy+BY0s8
         fI5Q5mWKUyunN2apfv1Trwt/mJnq1eAxzeYRgSSjv9O5d9X1x7TP9ErrdLoRsg0ljfBH
         SlSMhdq9zMR/Yn6M8JQqo2emVduGnA1CvFZjdrlO2NBJcAVIpUkge/BUqbP5Hy+G/GUd
         2upGakeK5jxmOAvuQkKCMwJSZLyM32PjLIKjcBnrEu8DxfrSQx15AN6UAI3hYww5l2CU
         couA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        fh=DUTTodJ1sjdcN40FWg5pLs+QHAAaEsAMSBTrVkHqaYs=;
        b=cXivuCmEsgT5qeN3lHchurIMB6zONjGXxFsUC30hzQ5RpWrakcx4c9z+O0WV0h08Jh
         v6mO9NOijmTt+q+Il/awXi2H6I1MRv3HHkJ+nNvjE3nl92nW33o1d6Dswf8e/6ax80h3
         Gt2Y9pK9QP3vB7xTSJhoMjRYN0Zer71Ai8hs7KpFOjFgjM6UE5FHQax1mEvzCiqV5LjI
         4yNBmyeUouHeE0WgUNSTn7n7F257tNXcdu35ZF/Xnlfi+8hIDE1oA9b+5nGZA1mxFR16
         sqncoIVkRtT78cUAblSXFZuEvOiubg8eN3rmeMJf2coAQPL3dHd7Xm7/koRh9XF3OryA
         HJcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583664; x=1778188464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        b=ClWEuZ5BQsYAdaQb/B/Xboaj+PuZ0w1lkXHtgPpvnILdRT7TcRi+TCUuwQIYIECw2A
         gv9FUmBB700e73pZUeXhwzTdAIUs9fiox9/B8rBUNQabQrgd0oTrwb6+/7CtgxKZMkXa
         imbM9L4ZnWbaUORXVOzJtm5xFCg61t3gvavNfPDH8SPOUzk0Mgfk8r30dpGWY43C09Y3
         LBjSf60sk9Ir2RgxT0xDmiMH2C4HAX//a3eK7QHF9NKsCtAubpQkWsVmk9ZAqmkF9cGq
         xjg6kcEOT4/zj43+m6vJRBYWOuiJh6OYf6Vl4vzkTZjk3q1sgUucQXGKZrzJFnRaV05A
         yuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583664; x=1778188464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        b=Io1cPAuhjFMaqpbChCGZbfVsGDTyiUoc1MnHITreoPPvt7RTl3GT0LerwQ+FYArf54
         n3rOs3cBMdzKtzurTMbCMIwKWu7ZQpYD0Hys3EscTq8GGU1f4MsSTyaAutO1F/FnJLOi
         FY6LqOuvdN/cK2Di1MTP5SFzaceUVZBFFN/FCDxYSd28glDMn8nntQoB/Yu6V2x+O5rP
         Cyh8Y7/CHBfDVnX7BOxl15yy+ukUjbLE5/gECY8w3jV/037fQfcDSCGQFokVj9waMV4+
         duSf9LGNX98N9NxsCxRbjPSqGRbpJ7asv7SJU6ZCt3g8luHYdkmFOrDtpGYW/0EIoQxF
         Mwzg==
X-Forwarded-Encrypted: i=1; AFNElJ9PZ30EvgdKHTDBPgjgQl7WgofN/OBKveSic1xQ8oapUXu7aa4LESsUs0pNPOFrcBT4CVz9aZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SJrOObu7a67SHWDsP0sur08xQOdSx7ng1ys4WPokHUBHJZYT
	lI82mcVgfiGwseiKF45rh6pe8rUz8bcDYkXqeiNOBPrfoZd/UUgFftV9DjexFi931YIp1lLNM10
	nLZ01o8QtY/5tqMikDrx3Zi7QRjUXMs5rqecVVGmL
X-Gm-Gg: AeBDievFObHQdNEY8XPlJndLjgP418ZRFw3xHg4mc6DoZzmBUGEVFf9JQ8YvUw52Lpk
	ijcOoXuH4tEm8cgBns8Mpr3kjaD4xk88WH9vu4/9pysrOf+0BrYepXz7+rlvoaULUVlLIYfAsQo
	9k5PD/u5+uQhSmIviDHpTAi6V94nkieH07NFmpP6tLSucZoRegTSeJ16rO0comciLQo76d9i1nw
	s4xuF9Z/ZGiuEdde/mGyfuaCJU7rUvZcZE05SM+zjbIU4Gqm8j2a43FwK64HBxX9afyS5oQt7o3
	Y6t9d86nr5wWRKADeQ+MiOjJcS3c0Gg1NvBCMrxEoMQ2kjlf3SQ1atkxK4lb+LrjZ3XGV9NITdZ
	4Oa9E3DUo7rTSSBjwcGrtTAVetptZUfBuFxSY2KMMuIc7ss98dR6MlfhQohcfAnGy5QV7hQJoqg
	==
X-Received: by 2002:a05:7022:b8c:b0:12c:f77:f0a0 with SMTP id
 a92af1059eb24-12df8238de4mr158020c88.13.1777583660171; Thu, 30 Apr 2026
 14:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com> <20260430184405.1227386-3-kuniyu@google.com>
 <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
In-Reply-To: <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 14:14:09 -0700
X-Gm-Features: AVHnY4J87pWikJxSFzLMx6MkBQcXq7p65ZvaRw26Ozcndpc40ZvjjYBHTpYi1TI
Message-ID: <CAAVpQUBt7X6YRC27jkoEHp+57z3P-Q-xcxGmQ3ZJKsR-F2oj8Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock() and
 RAW socket.
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7DFD24A821F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283000-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 30, 2026 at 1:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Apr 30, 2026 at 11:44=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
> > wrong socket type.
> >
> > Before:
> >   # ./test_progs -t sockopt_sk
> >   [  151.948613] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7=
/0x8e0
> >   [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_p=
rogs/1259
> >   ...
> >   run_test:FAIL:getsetsockopt unexpected error: -1 (errno 22)
> >   #427     sockopt_sk:FAIL
> >
> > After:
> >   #427     sockopt_sk:OK
> >
> > While at it, missing free() is fixed up.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
> >  tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tool=
s/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index 53637431ec5d..87e771c8991f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > @@ -190,7 +190,7 @@ static int getsetsockopt(void)
> >         fd =3D socket(AF_NETLINK, SOCK_RAW, 0);
> >         if (fd < 0) {
> >                 log_err("Failed to create AF_NETLINK socket");
> > -               return -1;
> > +               goto err;
> >         }
> >
> >         buf.u32 =3D 1;
> > @@ -211,6 +211,21 @@ static int getsetsockopt(void)
> >         }
> >         ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value=
");
> >
> > +       /* Trick bpf_tcp_sock() with IPPROTO_TCP */
> > +       close(fd);
> > +       fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> > +       if (fd < 0) {
> > +               log_err("Failed to create RAW socket");
> > +               goto err;
> > +       }
> > +
> > +       optlen =3D 60;
> > +       err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> > +       if (err) {
>
> Ugh, I forgot to commit s/err/!err/ change.. :/
>

I'll include Matt's followup and extend the test
accordingly in v2.
https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5=
cda7da9@kernel.org/

