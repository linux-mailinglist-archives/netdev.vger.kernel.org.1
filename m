Return-Path: <netdev+bounces-289116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJCIKok+C2oJFAUAu9opvQ
	(envelope-from <netdev+bounces-289116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:30:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38224570ECE
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6A003031F56
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E6480951;
	Mon, 18 May 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avu0BJwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476893D5240
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121137; cv=pass; b=Jhln8SOkxyWVJgQU6fB58B9TJ6Fv3r/lzS0vexA/VheukTNKrr1Eoy0iomTxWLZ6U72Yka0nMC5pLyPYU+8Ga86g1B+0mfaWQkbDakZb9caNB6GMr25DhpjOG9CBTNniGJySgosLEO3sNGtkoMyEfMZXuiNc/1HZnGIbhT0EypU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121137; c=relaxed/simple;
	bh=mATkwyC8CsfmbtEjXmliiX1cfrfLq4a/zwucAwJrrMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ril9GaivpchK7r/I66d4m1a9p0Lb8KR2YXUAZXeu3jGrs7vogkWSheWiqdyE+U+4PjGdGLyejTeZxXQlcw9/J3qMBfZ5n9g00FsTvYx8CLzzI0Aqw8Pgbm071DbkmkQ7mmmlPzSb+dL7f50xJi+314k30iRVipFkWx8umOpUh+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avu0BJwD; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso194a12.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779121125; cv=none;
        d=google.com; s=arc-20240605;
        b=Cl4AhBD72G3HwhH7kWy8o063VlLRzhISCAWz2iRMVFyxtKoZvc6sQh0cDr/3lyHj85
         DQF5t28Fd5IdN+G4aWiSSR6ys5vClAoh6SUyk1MS3ixHrW156zLWoGqeWcSQsP+qpJIC
         h0bbsK55hrrvbkyQ7VewXPqi+j7sEH6q+WUjnoG3DBUNEpLOkZl+h0rnaombKQIs1Xgk
         gI36ZeqrtFU/Nft1QA5x8djKoI74hToJpZgK3/LFy4AIo10aYO7pXcbJ6LYxJTpOzTdr
         BAwQO2hZiCOm4KS7E4ySYyuYz2lb90Z5Q+4w9c3sMzKkJrxMMGELa76su8OXYdk7RJJm
         7EMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        fh=sSnm42n51NemoqQYojhuEczDRyYUYTK9x4lBhpNTTC0=;
        b=LAUP0s/sO+pd9xyFTXPlrroQzPsaCB1c3QIu4cBO+hCPaJqfBICAuVdwP2Rz0PnLh5
         ph7lwn49ui8k41z8WYkoMGnXQSvKxTr5CdptpEhWxRSd1nnNYv/NBI4NTZyYJFJ+4h/T
         0bdDxUGU+JBRa7e1OtUE3xnHm2ZYwdL78noVv4RnQw+YCHkFuHbT05C+mu6fbhqkXr2l
         Fa62cJYQc4h/CpCjOCv5cI+E1HFakZZYfW/23iVyn6g+k3HPKg5YznnV1DzekT/axc2E
         /FOcnASqMb0eOWPq1sCjijxG6iREc7oBrHCh+0sFPP3TqSJNneaikKCQNKoioKezXYoS
         bZRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779121125; x=1779725925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        b=avu0BJwDBgBEO8lQSkc/1hffUI3CsBJxP2u/6vcvB8cQYAr6Hk/wveAp5i5YOAoXPi
         lbh6bGQM9f3o3k5KRIoi2SyJdUTGLmLtkKGM9Ze20e9Hmz0hi6lAIn3W6JZhAP9RIP2m
         pcotPfL4MasHRZaVZ6hfNzixxTDMH0dOMgY2gmiwMl4mjLD1iPdZh0kYe4ppxrX5febC
         E8E4Qzwxj53nTaSj4S1QupzQHLzbDrP7x9S3d87Wy0dlJlFKsVgIPpJCJAUDBYVKOpfr
         9ZtiyLGEjVhxo1sK4HAwzS9ZPpIbPukMhoGsvJOc7zmsDBaOqnXJtJVKApO4J5U9c1G6
         Bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121125; x=1779725925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        b=rmlR1KcbU5gXe9bb+XMyjKh2+RSgv2HRCLB/M44tumauqeMPK9lcQ0/T21biJUX4ge
         Q2Q80/X34rLa04dYdT8at3OgFn5f8Aq+zAdK8UZpOxsTX1W+0nouDJ9HyHruqffGvo/B
         ubxHQNLesjO3S81iSDEFZdwWZl6oIZF8N1WFrE0ouwbqs7k+4BS9HLgFX1ifBSEB1aNc
         OZ6x86rATlFGamzlBEgCfV4t1sROYk8gWAO/6/ElTyMEnxTIy71SEC3r3wn74r8UVSjP
         qhDeW9nPc8UNHNMdPirEN8v/zubhyQ6AS5BYTFyeZ/cVo2RJywP8Gs9ZXgk6LcIM/mhO
         8mbA==
X-Forwarded-Encrypted: i=1; AFNElJ8Z2Bf8sR+1QdKV62G7Qt6DB/WA2JmFR3N6HuW1YBPlUYD2ElldOA2Jt8DqPUiCXK88X0TkuVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XJJirJZaZgBgMdO+iInYVVcWKzcA05UGnkHPPHXUFy94tpeJ
	Ag4UKRsOJwCm3MR5IYCRkzIanNN784IYh4+EBuSjjFa0zPkWvfJjCLNILk88SCejqa6zk97i+q2
	T4K5uzKLrwifDcWRo/n4+16dUceM2J6+//6UsbrqBUR0nAhp8A3tRbGP1
X-Gm-Gg: Acq92OGSva7Xp6iJ0Xq4y8LnMULM3A2Qfmn1sgF1e6ZWkzO7yhbhyjoAw4/pqZCzRIK
	aV5ZA+fzA4OFNfykoBfhCukbzcW013uK0lF0BCuNTgxv47itDH0dEbTBLpIloFQqlT6i4VfowkP
	Q5xb/NW17hgO4plP8TxWN2Cd47SwIz+qdOV8AUIWkynizpSouThH5cyPNr3W8yf3B2pk1kvfS2X
	mXGM5H/5bozEsYZxVn0CrX9WaHQr3/rLnwdktZ9XkU2TvlWumD8H0M+bMIffJuYftRoDZ2Hv6v3
	OZN3xUXW1xQWw3zAtSKj2NfTQ750oODNN7k/k1LiT2+QMNQ=
X-Received: by 2002:a05:6402:4c9:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-684985e96ebmr76245a12.1.1779121124779; Mon, 18 May 2026
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
 <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com> <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
In-Reply-To: <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:18:08 +0200
X-Gm-Features: AVHnY4JEW223kfoVSQDlfwCDKkPQOQR08O4FxFyX9fT-m-RsU3KiMfxz6iu40fQ
Message-ID: <CAG48ez08P0mRcbdiYAZaQCmbG-OcN8JZYT72wkC77zXHn1BV7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289116-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 38224570ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 9:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> On Fri, May 15, 2026 at 11:54=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) witho=
ut
> > holding any lock that prevents SKBs on that queue from being dequeued a=
nd
> > freed.
> > This has been the case since commit 79f632c71bea ("unix/stream: fix
> > peeking with an offset larger than data in queue").
> > The first consequence of this is that the pointer comparison
> > `tail !=3D last` can be false even if `last` semantically refers to an
> > already-freed SKB while `tail` is a new SKB allocated at the same addre=
ss;
> > which can cause unix_stream_data_wait() to wrongly keep blocking after =
new
> > data has arrived, but only in a weird scenario where a peeking recv() a=
nd
> > a normal recv() on the same socket are racing, which is probably not a
> > real problem.
> >
> > But since commit 2b514574f7e8 ("net: af_unix: implement splice for stre=
am
> > af_unix sockets"), `tail` is actually dereferenced, which can cause UAF=
 in
> > the following race scenario (where test_setup() runs single-threaded,
> > and afterwards, test_thread1() and test_thread2() run concurrently in
> > two threads:
> > ```
> > static int socks[2];
> > void test_setup(void) {
> >   socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
> >   send(socks[1], "A", 1, 0);
> >   int peekoff =3D 1;
> >   setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekof=
f));
> > }
> > void test_thread1(void) {
> >   char dummy;
> >   recv(socks[0], &dummy, 1, MSG_PEEK);
> > }
> > void test_thread2(void) {
> >   char dummy;
> >   recv(socks[0], &dummy, 1, 0);
> >   shutdown(socks[1], SHUT_WR);
> > }
> > ```
> >
> > when racing like this:
> > ```
> > thread1                       thread2
> > unix_stream_read_generic
> >   mutex_lock(&u->iolock)
> >   skb_peek(&sk->sk_receive_queue)
> >   skb_peek_next(skb, &sk->sk_receive_queue)
> >   mutex_unlock(&u->iolock)
> >                               unix_stream_read_generic
> >                                 unix_state_lock(sk)
> >                                 skb_peek(&sk->sk_receive_queue)
> >                                 unix_state_unlock(sk)
> >   unix_stream_data_wait
> >     unix_state_lock(sk)
> >     tail =3D skb_peek_tail(&sk->sk_receive_queue)
> >                                 spin_lock(&sk->sk_receive_queue.lock)
> >                                 __skb_unlink(skb, &sk->sk_receive_queue=
)
> >                                 spin_unlock(&sk->sk_receive_queue.lock)
> >                                 consume_skb(skb) [frees the SKB]
> >     `tail !=3D last`: false
> >     `tail`: true
> >     `tail->len !=3D last_len` ***UAF***
> > ```
> >
> > Fix the UAF by removing the read of tail->len; checking tail->len would
> > only make sense if SKBs in the receive queue of a UNIX socket could gro=
w,
> > which AFAIK is not supposed to happen.
>
> I posted the same patch 2 years ago (and forgot to respin),
> which has the historical context.
> https://lore.kernel.org/netdev/20240530164256.40223-1-kuniyu@amazon.com/
>
> ---8<---
> When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> support") added sendpage() support, data could be appended to the last
> skb in the receiver's queue.
>
> That's why we needed to check if the length of the last skb was changed
> while waiting for new data in unix_stream_data_wait().
>
> However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> to a new skb.
> ---8<---

Ah, thanks, I will integrate that context in the commit message.

> > Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix=
 sockets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Can you post this patch separately to net.git by specifying
> [PATCH net v2] in Subject ?

Will do.

