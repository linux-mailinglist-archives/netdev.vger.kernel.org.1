Return-Path: <netdev+bounces-298711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WgHbALwtLGrqMwQAu9opvQ
	(envelope-from <netdev+bounces-298711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:03:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F667AB04
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:03:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LmayjKZf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298711-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728B23217E81
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913838D3FE;
	Fri, 12 Jun 2026 16:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46C5C613
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:01:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280119; cv=pass; b=TWMeD5UEQDuQvUdYme2IByvcvmusH05mK/SNTda+58DCLNdL8QNz1oU/5dhqlAM7wJqkg11A9WSgCRKakJtEDFeEnRrtOfpTDRJqH83HAL1l9nLEn50DeNCFdr+FL3yqvB1Dn2ULIcZwAwYO07qUzEwVzVBd/QnP66N7uZxR20s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280119; c=relaxed/simple;
	bh=xLmT1CglDc1tRi97nwnjGAiRAUXSf/PXHXAe9jH7qa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPz3H9ZWMWYT7YqvaaMqXgHG1z1SjJxsTKbcM7ElXEO3pYlnRBE9B8sV7kzjcSOjPXmuafODs549s6KWkgJ2hjUmAnK0UM/S7waM9Ty42jRqeCx/PnlG414O6Ih897gh2k7KIqtFR6kmbidTOVYc9R1xFQCFEwaeUzh/7kYiFiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmayjKZf; arc=pass smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso699846a12.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781280116; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2L+jEZIwn5IxFEeqd5vecefEEqEZZSgdOLArhzdbgUD25tL0t35sVzhd5fadql0Iy
         Dp05w0Lu7xQ6QGGsUGY2+8yu+QaI8sVMsDw4DLHUWab2zKfaD3DUnv0KsuXgkfbBAor9
         TwLcRwdVQuoy+x868A9RNSlT4+Y1bMB7lCjH7uRVO+6nOfaQVvdFyG62e+ksZUBlbFHE
         +7g2JKIiZdxEfVnDVp848SfJB7DtfKjTZ5atWyyeXJ1HKfx0cUqRCP6L62Nnz2ZfVUw/
         +Mmrf45VUU7VNfoMemlUx5eg/zIQHv29L/5Nr/BINggD/edhYwB/ClvZNpvzlMw+oxhS
         eFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        fh=cchpIVL84HOB5TkQpFJbO+CtzxR/7Z32gY443b4semQ=;
        b=dT97Gs4c23jSbcD/dVAWHGRupnkW8HpvZBf+xitz6hmawvkbJYsExO/Nincw3NmBSy
         IGRsM+8kkwcfK0ruwygON8VB8i/aNoTN72suP9Eic08xLxInOv5YuWV77HGkMLpwT3bB
         8lkbjdg9XIQarLgPNJe9tePmPpRa5GhVBge/ZtaStGSAolIllDp6Ofswky/Ee2189mbT
         4k0Egia69GuJ5DU37k7UxmdXyUHDkRMsBsC4/4IvSbjNtSH10Ae91EfqcduM0iPUIX25
         RC35oXfBVJMes3ZwVJwwyMXvsTJsdCZLyDMIKfYrUexqcA8RzuqnKpa/ASc090TdNV+f
         lolw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280116; x=1781884916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        b=LmayjKZfXj6a0qpPllyDM4QM/G4gpUaLGmES8roRE15fVN/SSLH4vStK+sgtEvfLWT
         9gJUB5R+symRRzxQK0nHtekVFmD7fmTRG6mjyeDLY3vMnAIdvhYTaPYpKsp2C1wA+rsR
         dJ0ganFgAmJDcNmdQFu499jp/zSQbXykkpBDi/c3BN2Vv7tiGgWdCNadvjXBiM1oLcAu
         FYfe2bwzRVG2AEwV84HmOPnWb57F52fDPp44jZUTtp3BEpC/xs8j3ENwasrO0yP4+h9N
         FPkVH0Nkrw7nBENJWzjutiOF3AOO4QksPTAdL5h+nM7UjYm9co/WyB3Fe8fo8PRxBg2U
         76cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280116; x=1781884916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NluFMG/+8oV4UqiIPnUP3waoS+zwZ5/CDcQWyg+zCA=;
        b=qi6FIy3z67Plf6swlVY9ixOsYW7TjcM2gnzvT94Bdj4pYUteDRBnJO48hRjTzUEcc8
         1dxAvw5nYsDtnW9tjvUPjJZw5h/UATB2GcEBUir63itficVr67XKW21M+moG7le7ehFW
         RK9ObTxiVM7jKqZSxDdDohlK5keNrL+UI4gMyJQHWy/THC3OFILqHa3MKn6FqTNINCd4
         BIyN1pyLELI1/EXrEtBmPkzqsbOIrBD3O8SmJvomkHGqrmiwE8ePGT9FbDB7FsFcOgg9
         9njnBVbc2U9gyOn7HZ73CjpZdgRXxWuParKmPCE/FYXJ5NefKhUK0w4mWdtOfZOa1Z+6
         YmFw==
X-Gm-Message-State: AOJu0YwaOQSGvMCjV+CqiJ61xGLgwfHtwJLRXJOSTCyN//3JsDj6AD6I
	L8/NPAToS6gQ9h+qWbPcUw8jRYcJX4D/5fSMtiVkWtX2ioflEyyYFYrkp0Y05LpJbRMtGB9OJLW
	I/M/nVRlYupAeUBuaW1UnTqBEarwTppo=
X-Gm-Gg: Acq92OGKUH053B+wvt38rURZLw/VP9+W4Dacmh2aYIcUJWH5Ea6afQNNwJ8epuhAFSI
	1/vDRd7ztEJO2OlsYyEwH2UiOSIzojcRNRDqh0JSKTBJqMbhCq9kE0S7sfyRpRKv2yRb6Kwfhed
	7HHrAeWa2ixszmD+QSU9la2IqgX9jxeZMAjmHRRlMXe63/3XKzKVYnOa0Rfjjo4AfCKzdGUKf2+
	t9I8bWWHnd85Xl8XcwHxzXXKId3ufi+thWfUi4d7RuK7G9Y7+3xFHkXSVjwB1OeN5klM1vIh7l6
	P7ofou1fmpNr8Fk60Z8OfFPbWq1C9j8t/HrCvtp2yVqqAbPc+gkgudDpCELbQUlEjYGVG2Em1Ok
	sNQJEPaBdQEMsjX7h8FBP/FpXpJvyrB7Dqqw=
X-Received: by 2002:a05:6300:6708:b0:3aa:c93b:625b with SMTP id
 adf61e73a8af0-3b783c74eadmr4367140637.3.1781280115162; Fri, 12 Jun 2026
 09:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 09:01:43 -0700
X-Gm-Features: AVVi8Cf3XUkYJ4-XhNrmqW9iOjgBV1BE-aGRWP1cVs3vyQnQRIzHDQ5CDQInRCg
Message-ID: <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
To: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>, 
	zijianzhang@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298711-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:xiyou.wangcong@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyouwangcong@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 544F667AB04

On Thu, Jun 11, 2026 at 6:15=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This series adds an opportunistic "loopback splice" fast path for two
> locally-connected TCP sockets that a sock_ops BPF program pairs at
> handshake completion. Once paired, sendmsg copies the user payload into
> a per-direction in-kernel byte ring and recvmsg drains it on the other
> side; both copies happen in their own task's mm, so the fast path incurs
> no skb construction, no softirq, and no TCP protocol-state processing.
>
> The underlying TCP connection stays fully real: sequence numbers are
> frozen at post-handshake values, so FIN/RST/keepalive keep flowing
> through the normal paths and the pair tears down via a regular close.
> Pairing is opt-in per flow and fallback is per-message - handshake-style
> traffic takes the TCP path, the bulk phase takes the ring, on the same
> socket. Nothing leaves the host and applications need no changes: no new
> address family, no LD_PRELOAD, no source modification.
>
> The target use cases are co-located endpoints that speak plain TCP:
>  - regular TCP loopback (127.0.0.1) between processes on the same host;
>  - container sidecar deployments - e.g. a service-mesh sidecar proxy and
>    its application in the same pod, talking over loopback or a veth pair =
-
>    where the per-skb veth+bridge cost is exactly what the ring sidesteps.
>
> Highlights (TCP_RR, 1 KB request/response, netperf, pinned CPUs,
> baseline TCP vs splice; full tables across message sizes and TCP_STREAM
> in patches 1 and 2):
>
>   loopback (127.0.0.1):
>     without busy-poll:   105.8k -> 235.1k tps  (2.2x)
>     with busy-poll 50us: 106.1k -> 713.0k tps  (6.7x)
>
>   container (netns + veth + bridge):
>     without busy-poll:    99.9k -> 233.9k tps  (2.3x)
>     with busy-poll 50us: 100.4k -> 704.9k tps  (7.0x)
>
> Synchronous-RPC (TCP_RR) at a 1 KB message wins ~2.2x without busy
> polling and ~6.7x with it (the win grows toward smaller messages and
> narrows toward 64 KB), because the ring removes the per-cycle kernel TCP
> receive-path cost and the receiver can spin on the ring directly -
> loopback delivers via the per-CPU backlog and exposes no pollable
> napi_id, so the generic sk_busy_loop() is a no-op there. Bulk streaming
> is roughly neutral on bare-metal loopback but wins decisively (up to
> ~6x) container-to-container, where per-skb veth+bridge cost dominates
> the path the ring sidesteps.
>
> ---
> Cong Wang (5):
>   tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback
>     splice
>   tcp_bpf: busy-poll the splice ring before parking the receiver
>   selftests/bpf: add tcp_splice basic round-trip test
>   bpf: allow SO_BUSY_POLL in bpf_setsockopt()
>   selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog
>
>  include/linux/skmsg.h                         |   9 +
>  include/net/tcp.h                             |   8 +
>  net/core/filter.c                             |   1 +
>  net/core/skmsg.c                              |   3 +
>  net/ipv4/tcp_bpf.c                            | 847 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/tcp_splice.c     | 206 +++++
>  .../selftests/bpf/progs/test_tcp_splice.c     | 125 +++
>  7 files changed, 1198 insertions(+), 1 deletion(-)

Just saying that the code is free nowadays, so whether it's 1k lines
or 10 lines is irrelevant for the discussion.

As far as the idea goes, I think, it would be interesting in pre-AI era,
but today splice and friends are a prime target for bugs and more bugs.
skmsg and tcp_bpf are reeling from unfixed bugs too,
so my take is that we should not add any new features to skmsg
and instead deprecate what is already there.

