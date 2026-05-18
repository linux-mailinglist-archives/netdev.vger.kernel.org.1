Return-Path: <netdev+bounces-289159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC3kBS9oC2qnHAUAu9opvQ
	(envelope-from <netdev+bounces-289159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D394572DF2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E48E303B731
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604F390981;
	Mon, 18 May 2026 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBv4RbjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8A1CAA6C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132195; cv=pass; b=EclLhPJ1D4I0s4KGOQSBvvSpKwApM0mrYHFgVADeOEr4igBGDQ/MAFvpsv9Vv3ibxBznfvY3/ej/y45LcvkFUT2otDAoxIsK5wUDQuZc+2GWhMjgjM/JejoF4zKbOLY4yBSCj4mxpFlo9fAWwfQlqk0asaqj9Kr7P5PFm0InluM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132195; c=relaxed/simple;
	bh=vS7t0kRAjr09rod4LmZRdHDpcGd/IcycfZRao+wlUlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l80M8XBiL7AiDfYMUupjT9mUQZpaK1c3dTgP0J8gkmwgY88abTFbFdSClxnQOF7eaOn3qqcBmUjixvP1jKk9CwgNWfVnIOkJeyHNbZkDJ+uiE4Wk1hawK657xzf4sDU+PmEMn8QOM6kBeTys11emma/tLNP/atj36G+G5KajR2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBv4RbjX; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1329fc4bf77so7065525c88.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779132192; cv=none;
        d=google.com; s=arc-20240605;
        b=eo8PKIA0r36eMvHp0VaVtHpheYZPjgd3ErBdIuD558tXrEuYhO0pKQcjhmocKWa99I
         t4OW2Wcqv8RrHUNGUb31l09eLNjc7MdxhIJQmpmm7llRZlKsRzSO6H1D97KGmKFmruHr
         3n/BggLhJqdyCmA6xQeOqQHDR8/zo0OQwpBTcQI803To5KobqWRH0Ts9E1SEtuahaQUT
         rGEPsCufHqRsRci2dNMBrNjvOGqNSVPQdxo7w9cSh2CDhpd3w13iqbIdlj4LynuIbDsV
         4uZ/IVjIW++MMRcUco+PtFtfOFW+dYk+C2YdZ/xNFWWDEYWCBKIWvjrBeZKeCVdVuE2P
         JlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        fh=MRyEDYEUjNipxbHWzNRtqRkCpInlPh08NyJquKyoUUw=;
        b=IAIiuynaPCMUQyWzvhlAyqdVT0GZQBeakvAf6M2QMbjOztsoyYC34kQaNuB/hUCWsb
         an88wKEqQE4EP/q+Oijd+/d6trh//0nqijQy2hw5M4CQK1QWqoygd2ZUMHBapVx6d/xj
         9LedaacD44aPSNba6nm2s1tgx7GFzQihp93xZUSlrmDOcH532j1JNLrp5Myny353HB+o
         XuRIVzyYNyE+IGV7HXOx0PwBKdkM+GfSkRr/92u3HpXMJ8hT7BgInjhAWf/0Drzw27Rh
         p4LU3PdicmKbQvTkD6iOa7uziRRIDBNkwxTzxwGdCZg1HA4C1VS1egWSKHVVwuK1z25C
         SrkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779132192; x=1779736992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        b=nBv4RbjXRmE7TnMNymmVORfjV22nS2uaTnD/n/n7k/5OePpEosmZ1NWruLm6vMY6B2
         eTKalGwB6njvpMvSO/TiTMYn8iynGhBUuBNyJ0zrbfPiEcyg9yttDmF3xyOTOeAsGzIw
         l5YfoysaxUNsF/cG9t873hdtvhkHgt1hAUmsEja/+FVao5tvWIiKHWDGC9IfL5n0s/hR
         e6zNx7WfKC1+sFKqdMMno4CfzUwV51pnOfNustc66cPOhLO1Y1dsYNf1NLoFr8GVK02B
         s+m14iyd+y237JYBY9uk/oh4KFzRMjZ8mSkIlwwF/HvYczbpq/XapwU5HI5iTtExren9
         ztLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779132192; x=1779736992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        b=QfLpcysJPQjR7YwpydKez/JMjOYPxPaIl53RbYI9fanAQPsO8RmnD+CdraZN86XXwZ
         u1aSGmd87pMa3+Pho7hF1SsNXOQYhkb5DTzOfFHOIePnFdniscNAsScrwBTHyP+uzBPp
         rNbNW43JTaqkCOh1XE8Ngy0Ifj0Vqsra0mnbREzZs2C9zAg38sTnlPZ8xFdFE1aSAFjL
         G5wFN1FB6qVO8R41j/6XscMs85WiJoqppsZvRkOxFITv49tXk9sml8JnBkL9q+GqvR9s
         jUgMqZziAWCLVR4YyOWlZkyZUVncFO3tpTdgZuVR+9RoAAXvK+0jt6mvybmQtoaKDLbo
         QOxA==
X-Forwarded-Encrypted: i=1; AFNElJ/ROGX15OFNlbfGHbfvX1XrFVyJrMcKJrVY2WFViUmwELHq9eZQMX17YAmQnATQvy/QdDYHq5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlL4UZvOF+XPk9nbYsuFy/sMy55lex8krlE1gL362IsJSQTcq
	aNTTipmGjiqoc/ShictWk1N13z0pnqiC/VFPqTA6nDRs3iEsIEAKLdaVyLv5qNHJtri7ruH47Ck
	7AJcbDOITS7Utb3ynVbx+AtZT5i2MJp7oNa5nRfql
X-Gm-Gg: Acq92OFDoj2aFKI7OO/lK1t8k0QYhaRgARkgrXgpKY0kGsJILz3Jd9IpYnhXwQcrg0w
	e6ezelMuWWCXt3w2yoNn5fNupYw+tsM/htyXBJH9chInwz5XVUxLiCiPWB6PuVSszS9++UREycL
	hYzNwsUMmDuxzn6pMJt8bnJBJMIM31wSgYUMZtt5b0wO3dnkycZejufSG3CzsbtB4OEY2ZqNdZb
	1o190PVd+beopT/fUjldmhgEH5zi59AWASdzSKqtfDVh+w3tlf+6wAwaksqm2iuU333eYwG0/pa
	QzS+LS5NXfiRW6Ztgq7C8LNPpdZgWETOyY9NcnGStSm5H7dzMwcpuVBLNqEpxo0yFybv2bTG158
	L+kdCc80bFTXIdWhREEKNWRZJ4ykYi3cPbmFfWErGq7h2mj/wdePqKadrJcw=
X-Received: by 2002:a05:7022:1e11:b0:12b:fc21:874d with SMTP id
 a92af1059eb24-1350484e801mr7468645c88.19.1779132191080; Mon, 18 May 2026
 12:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
In-Reply-To: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 18 May 2026 12:22:59 -0700
X-Gm-Features: AVHnY4LsKtOPIZP-oDaTngNmJs5H7FpqNGa_FGOaCijUbnrkv-tVkauHd7iASQA
Message-ID: <CAAVpQUC5Qr4FR=7z+suDW6kukpHLMRBW2zhrs98YLHVtHDMTeQ@mail.gmail.com>
Subject: Re: [PATCH net v2] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Jann Horn <jannh@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289159-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7D394572DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:51=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
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
> which can no longer happen.
>
> Kuniyuki explained:
>
> > When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> > support") added sendpage() support, data could be appended to the last
> > skb in the receiver's queue.
> >
> > That's why we needed to check if the length of the last skb was changed
> > while waiting for new data in unix_stream_data_wait().
> >
> > However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> > commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> > MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> > to a new skb.
>
> That means this fix is not suitable for kernels before 6.5.
>
> Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix s=
ockets")
> Cc: stable@vger.kernel.org # 6.5.x
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

