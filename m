Return-Path: <netdev+bounces-288771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJYcDEsVCmrgwgQAu9opvQ
	(envelope-from <netdev+bounces-288771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52B563817
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E9B3014404
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCFC309F00;
	Sun, 17 May 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc+vGuQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E9302742
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045697; cv=pass; b=WTUa/K2Jzi/2jmE00V6FidK/TjwhshKhz23ndFTjoZjb7Lk4ROR1zRdPV2hXFUSFfHnn+yxfH75qM4hYXVAAAGCs4VNxjULA2zwLTgjBRYkhrPRCgrCH0qHXcekkjIRV0/Drh+F9RW1QlrgLIaJVCr6BL229hRACGM9YBptxnIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045697; c=relaxed/simple;
	bh=1v/XXWFyX1CrqrfCcNCeDqucdVkXIMDW9YfLgDAaYcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvFiBq0mXcsn16Js6ioULVIEoDN1jdge2evNB4+6y9P3h3YfCD0JNIxFmhfAvkprEzKaZB6iSZBYhkmgYGf6Yz3pn5ANwJdCObmrrmsNnaugnlaBZTP13PO15wwxjWcu+OB3Q09TClCOk0QegB77kblnZvZ+J+gdm2LHXtUtrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc+vGuQO; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c88e5f4aeso641655c88.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779045694; cv=none;
        d=google.com; s=arc-20240605;
        b=ZexkQf8joKzC+5EI0uVowBU6fJHcWxkJkJy6h3f8dF/HepiXPnaTGEExK1ljOaORtJ
         fDQkNYKh7XdhBG8P0H53SsRjasa/SBmVZ8pRl9X7PhNwLtfoE6xzTcT5/Ks+K5q4d0x1
         atl5Zfe7uXPENAWy47vQTS7WL7nv8s3azpMfxbjabHpgGrP53VtDSz0txXBgLlp24/od
         2XmB07PoFT73/WR6R228+vtNJDsf2RlWdTEzx7Toco/WAIzKWz3KvUs9Q0EfMoy9M66r
         el66gAoW6ncVoWzbYMstJGCTIqvSDg5d7a35zVVvW21btSMft51M9bGiKtT5fqJyR7AF
         uCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        fh=ova7dxVoHcqTOIjku7XfzWaN3H0H3OyU6pN8GYNCTsc=;
        b=kQF1xemGR+SSJH3xtI/aQTw7eFagq+2qhUIUg+9LvkO3SohdwpmL7ndktkn0oF1COg
         BP2CcnQEUEElRltLKzcuf2FRInQv6ZQrpfY+kQDJPcVVx3twOuwCAA6NkYa+h+wRieJ5
         GkmgHzED+WsQoG0KNR66tLYjJtzdAu+dl4w5xfpb8ApLfr825aJpyKtuBW2XxSig7jMP
         AFePtfJakDUhwKDxZrVOZ0L9kKAxtnTq+ZMpeHsc2MD3s9jOx7Sk1NAjDjtssyTbRM/+
         LKjUC+Tpu1QZKT8zvy4DHY2K9c6UEzBsbkMO2qUAmpKdbzNCSo2wFmkDd9EowB0vNqKC
         BjDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779045694; x=1779650494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        b=qc+vGuQOWP9Prkuk4uvVJs2FeLMDAJobrq7kCCd53I1nGQFiHME0CKBj+1D6cygKiD
         Xp71H5z0FQg8QEC2zbSz3M3YjQRyQ+d2mPILxItGMA225HAaYqN0gAjYpXtr8Kz8qYOJ
         ozrueSpBEhMgfS7XFWLFWpgej1+XhglwssbQft9yKypf83rxZvjxc9gAz9dvBRwE+KtW
         Cu/6gLzYcdBNieNSkkXcqZ+yDHkUgfXH/OVag4wpu1ytF8TeXuRAh2VpasuFB4Y9CxtA
         QrgAy3of9EzCHEL3ULx3PuuJqlKAQIVRxwMy6LsPd6ojX+xGSb82kOdBKyU2oef31rX5
         ZxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779045694; x=1779650494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        b=e5I+IAMt4dhXrz95mcgnVTWbYFdhC12mPp6msmcyi0Y14EUXgBT1tk8hPOaKya8XVi
         Vqj1EzEmwNl+HDGeLsVXI22nhorA3YjTVOa/uf5BEri3RyBqvFpzZNVUGuSUpmWRfGeo
         Bobk6ceZgzZ/Qjw6aiQjU6gHFnhmgF0JvoRJJ/6elufFiKbqDgVioJH7qTKdsDY7ln+1
         h8wVtOVlEuvMdSiuO8SHqQKd1/kfUKiMhquFQSgfNCWHpB4c524ULOJkjRnmzX/49aiK
         vNQL6uCOlzxAL3pxpa5oXCg7gX7E1snh085mMfiuR28xYTJFZceG3mVKarskhRwEuSXH
         OlQg==
X-Forwarded-Encrypted: i=1; AFNElJ/mcB7fjvTOq9F+egP0RtcWM+KsFihptqyP5DsDAYfb/iNYlMe8r46aGqVhLD0UKTM4e3chGUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeAjgwjJhoMg8UxLQDrAxmpLUgH+l+1TPf88pSFyFkAzuJlEh
	qJbTKAzg9/79AmtxfZ4L56OVOyqz9XlXoI9HBf1vqtJ/EYmr7qT2X5I/hOeCUwrvPv60PzheJKq
	5gVhQWkFFSSQuh1AVhAqNJoNpCS6cwbKRMquVUEuw
X-Gm-Gg: Acq92OF/Jh2YRykwNfXv0mj8Va6ogV/V+tPGWIPwPXwpTPXxhe4KvaFqqZdGaajg7rj
	v4wd5Z4CPkuNtkwYwsk0+3HqYz6lfvODkause/J+UD9abhvF9Scq5vYfdV88qj28yWCmoFRI0u6
	m6ElCvup52bolLY6qCGUq3IuCjIer4Z4EDANVwjbVy4CZEcncdxBducZFo8jhAuH6muCaYq5R2y
	bh7eV20eqbEfL/tZr16eMYRVXAQW+ZcVxWznM1Vl2K1JX3BIzuy9K353Bqk1WrT1VhI72wRY4qx
	5yDa1US5oaLvsXiDYsKuBmL8iSKUEKzIWxt9xLZcVND9J9IRtgkg0kCvkqSaquH/4oGhv4iNTB4
	nyvKFdTPeDzCigZwztWjUF9cDvVcCnGg=
X-Received: by 2002:a05:7022:128d:b0:12d:b8e5:5e2 with SMTP id
 a92af1059eb24-134c8d4f477mr7482953c88.23.1779045693291; Sun, 17 May 2026
 12:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com> <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 17 May 2026 12:21:22 -0700
X-Gm-Features: AVHnY4JBNg0xjLVUNScPxVzZN0nh0saT-xFzCCVwtR1do4uoeNLyD5M3cMYb7hI
Message-ID: <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DD52B563817
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288771-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:54=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
> holding any lock that prevents SKBs on that queue from being dequeued and
> freed.
> This has been the case since commit 79f632c71bea ("unix/stream: fix
> peeking with an offset larger than data in queue").
> The first consequence of this is that the pointer comparison
> `tail !=3D last` can be false even if `last` semantically refers to an
> already-freed SKB while `tail` is a new SKB allocated at the same address=
;
> which can cause unix_stream_data_wait() to wrongly keep blocking after ne=
w
> data has arrived, but only in a weird scenario where a peeking recv() and
> a normal recv() on the same socket are racing, which is probably not a
> real problem.
>
> But since commit 2b514574f7e8 ("net: af_unix: implement splice for stream
> af_unix sockets"), `tail` is actually dereferenced, which can cause UAF i=
n
> the following race scenario (where test_setup() runs single-threaded,
> and afterwards, test_thread1() and test_thread2() run concurrently in
> two threads:
> ```
> static int socks[2];
> void test_setup(void) {
>   socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
>   send(socks[1], "A", 1, 0);
>   int peekoff =3D 1;
>   setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekoff)=
);
> }
> void test_thread1(void) {
>   char dummy;
>   recv(socks[0], &dummy, 1, MSG_PEEK);
> }
> void test_thread2(void) {
>   char dummy;
>   recv(socks[0], &dummy, 1, 0);
>   shutdown(socks[1], SHUT_WR);
> }
> ```
>
> when racing like this:
> ```
> thread1                       thread2
> unix_stream_read_generic
>   mutex_lock(&u->iolock)
>   skb_peek(&sk->sk_receive_queue)
>   skb_peek_next(skb, &sk->sk_receive_queue)
>   mutex_unlock(&u->iolock)
>                               unix_stream_read_generic
>                                 unix_state_lock(sk)
>                                 skb_peek(&sk->sk_receive_queue)
>                                 unix_state_unlock(sk)
>   unix_stream_data_wait
>     unix_state_lock(sk)
>     tail =3D skb_peek_tail(&sk->sk_receive_queue)
>                                 spin_lock(&sk->sk_receive_queue.lock)
>                                 __skb_unlink(skb, &sk->sk_receive_queue)
>                                 spin_unlock(&sk->sk_receive_queue.lock)
>                                 consume_skb(skb) [frees the SKB]
>     `tail !=3D last`: false
>     `tail`: true
>     `tail->len !=3D last_len` ***UAF***
> ```
>
> Fix the UAF by removing the read of tail->len; checking tail->len would
> only make sense if SKBs in the receive queue of a UNIX socket could grow,
> which AFAIK is not supposed to happen.

I posted the same patch 2 years ago (and forgot to respin),
which has the historical context.
https://lore.kernel.org/netdev/20240530164256.40223-1-kuniyu@amazon.com/

---8<---
When commit 869e7c62486e ("net: af_unix: implement stream sendpage
support") added sendpage() support, data could be appended to the last
skb in the receiver's queue.

That's why we needed to check if the length of the last skb was changed
while waiting for new data in unix_stream_data_wait().

However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
to a new skb.
---8<---


>
> Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix s=
ockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Can you post this patch separately to net.git by specifying
[PATCH net v2] in Subject ?

The later patches are net-next material.

