Return-Path: <netdev+bounces-288787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qbS3LTVPCmokzgQAu9opvQ
	(envelope-from <netdev+bounces-288787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:28:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233055645C5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E575530094D8
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875FB30C157;
	Sun, 17 May 2026 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJObiiNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEC171B1
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060529; cv=pass; b=WWDUNa17cQSs6vbzfWQQ4Wfihzuz31zs2FbRhvGuR6Uu/0BOen++pkLRCrBJIAAexgMKoG9m1FWj8L7fHjkG3cfR3/zkywPsLeWeqLse7gRxe1CxTDvMclwJQE3GAfOLci0nnS9BoJC3ezNQmPeE3L39MMZVUPJaIU7sX/azRZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060529; c=relaxed/simple;
	bh=m6bgQW4Zf8MXt1wfbHMNC+QaLmkOQvqE09zCrI53oZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9t6CFTrhG64gPYCOKq8EyzVDj2QaN3MYwbiv+BCTwrLvqYJJN8cOI/8txUVqKy6+eU/Bi1e58LNiRQ/LH+zo8lIvXX4w3wU4scvNNDJgeoOSTX5YdaZv+Z/ZukMik5swioazVx6VkF7ekdGHmdwkWMVExoXlWTH3orsrzZPvE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJObiiNe; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-135200bc7d2so4456829c88.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 16:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779060527; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+9Dgss709HzUbrLOVX+V4O+1xXz6mH9L1IwL7sYyAhWGhwfx5Ggbq/8gPN9gRgys2
         +UUT3IdG0xNC5AUE5JXMcKbAJt4f6Hv2i30/oaKrmvC8Vqbjj1P7zdnJ5/qsbezntKYy
         M2pPHaABnRX07W2ExF9utYyZQxhzAFNz9afeQJP+TctI5hIRev5d87wX0NLn/6PCwSJU
         hTSCFltN4yz5fIkHl7brRwSLGQLE5OjTsPGX9V1QiuBnNQ3P3VhjRPi/b02zlUnG7miZ
         zkp7zjYvKoaH6LIvpHwKnQvVfSy0FcOj1IDVycUGUJAMjVG+NpozK0mdLwrKLDL8DzUg
         hKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        fh=n77jcvc4Wj1RUUEEgR9rJfh5dMYtY6YnanFqVbrbt8A=;
        b=AWp10WuhIogo9JVXEIsHEQDJYUrlGtfimfnBD7JiTZO8ryjr0BpiRfm6ga50hYSp6O
         zYiH3MS6xjE5hqNozCzIQ7PUHXWnRLfhOL1NQ+pHXGzJptzI+oetTJI79PCrDHB32gNj
         J6ZM1h9bqIKrdsZh6MGaYPnwAwpM78vSaHlDFQCJ/iri17VEGXzuMR5psYPa0z/Y2ZXP
         Zu+1zJuRbiGyPG7Miw9l3S6XFlOPUAkNVlYS4KN31M2D23eNj0G/vX65eQM7hgWTRAMO
         K5AeCfv3R7vDOL8oN1Uk6rPvDS26Ce2vEzFEBnZGCwkC6e1RWEg8ynYLyySvpGjEOLk5
         PCVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779060527; x=1779665327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        b=IJObiiNeQVmyQ4i+ARUgXwH0aNUqN6QLS9zvqoUkQNcWtRHWuHOPKfKpEWaD8ocyV3
         sml47GtI1MnBdS/VVo1wD59t+Ayb3kxkMTW+qW7gFhPRvE5RXiMfZqjUe5jS5DFGVAcK
         GMX3njpH/a6RMOCRZKd4RDz6Qh9BzsEfs63mMkrNaKrn2tMV2jMnFJ6lTueaaRiDTKcj
         fiNXW07pMxBADDJr7diaHvUufjRRaVIiCfBpL6Lumql8VY0XnSWJtBN1wpLBuZZfUQdm
         htyc1mMpaia40bz4NOc9ez6d6gys9OOJSmvwgDZRvf6QJzlgWLsajNygsUX+svNErmkA
         6Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060527; x=1779665327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        b=rwhlq+97fbFI/VYl1udA/1oVpq1efflpCgpqBQx7lwGx53KBh7mEk833jMcAfofo4j
         s+wTLUxKrjCpMnTpEpJcW5i5/8bfTvbgN5Fu296A/ko4Nq1Q4QPaIbmL42da1Mr1EEBT
         otfk994zzN/NL4N1H5Fi1s6p1kN50oCQ/ftASoPtzC+55+ao96aCPQQBprY7MvRm5fhd
         3M9U4KG8iXKYj+YNf2m51XvGE9lO1GyPhku4dPfniL1QdSszQl37gT+jN4ii4IReiBiQ
         gdibsGr5AxhPRKjkCTZ513hH9uFsmkUGwPWDeD6dNYCn+fTLeWgl5IpqRmyJ85w8K4G7
         /d7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9q7vGpwEaS9g++FoydNiTjQaudDPHGJjTp67K5mp0fsowlabxUSFvr3CtFnqUnTSJ6/LOe3+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjS3Ebss1tG0988ZvpKzjMI+4+euWrDjcAcuMaESxeBljmeQB0
	ksH8Ntn2CWa+s3jTjZHbyiXKuWJsKEoEdt+aI7dmty2RLEQOTNGpec3Zm1xRzciXXHf3i7EFAMh
	NLYlNqXudjBU5Vui/2AyaRftJg24sxcZrulsl+Pa0
X-Gm-Gg: Acq92OGnTyNPz1OesTrkiBhRSub4Od1HlBiRFM1o7Rw4cVsSpXgpAq6CjRkdkDAzNc7
	G4ClQgLt/oCTjWGSfbFQwTOKbPl82NXAisPP4wb0NJ8CjYqufxLT90UORwM8emkz9kHz1s5qh/O
	7jXIj38YeYp66/ZFY0LMnk52+n8QCmKYU6+gstCG4X5OaHrSLQ+OJ9kpHL4N2Y7Dj7hIzq0lSlo
	V66wAO2OkeJMGV+RnULFlOD5zJAxFza1E8vSdI3OI8NUE9On+rhy0xAW6TT7MEd1k9D/wIKrO6n
	tBawW5WGoT+NiQXF/qfkMXc/RzqnZrtV+1syiugh5cm/jjZ5zmhsWbRhm+sY3eF8RYtiCcP5MP+
	uTFk6nSTbVvW+s6zXaSBfm+7B5g/E0Gq26pvKOkFKyg==
X-Received: by 2002:a05:7022:41a7:b0:134:def6:e70b with SMTP id
 a92af1059eb24-1350451e322mr5774300c88.6.1779060526553; Sun, 17 May 2026
 16:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-6-kuniyu@google.com>
 <87ik8ujfa1.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ik8ujfa1.fsf@all.your.base.are.belong.to.us>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 17 May 2026 16:28:34 -0700
X-Gm-Features: AVHnY4Ig7UxTlQzaKGRM04g04YbMYBZZ4r4oVDiLULEpxp4tTBPeWfll-rBxudw
Message-ID: <CAAVpQUDKx=07Rhz279oFOD3dw6PvuOP4mVmvQKDjPFOHZXimfw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 5/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 233055645C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288787-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 5:34=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Kuniyuki Iwashima <kuniyu@google.com> writes:
>
> > We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB
> > to adjust sk->sk_rcvlowat when
> >
> >   1. TCP stack enqueues skb to sk->sk_receive_queue
> >   2. TCP recvmsg() completes
> >
> > Let's provide a kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > The wakeup flag is determined based on bpf_sock_ops_kern.skb:
> >
> >   * For the enqueue hook, skb is always non-NULL, and wakeup is
> >     set to false because
> >
> >     * tcp_data_ready() is always called after the hooks in
> >        tcp_queue_rcv() and tcp_ofo_queue().
> >
> >     * when tcp_fastopen_add_skb() is called for TFO SYN,
> >        the socket is not yet accept()ed, and when called
> >        for TFO SYN+ACK, the socket is woken up by
> >        sk->sk_state_change() anyway.
> >
> >   * For the recvmsg() hook, skb is always NULL, and wakeup is set
> >     to true because tcp_data_ready() is not called in the path.
> >
> > An alternative would be to support bpf_setsockopt() by adding
> > BPF_SOCK_OPS_RCVLOWAT_CB to is_locked_tcp_sock_ops().
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/core/filter.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 94d07a15b2ab..9c4cd27c6d4e 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12346,6 +12346,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >  #endif
> >  }
> >
> > +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern=
 *skops,
> > +                                           int rcvlowat)
> > +{
> > +#ifdef CONFIG_INET
> > +     if (skops->op !=3D BPF_SOCK_OPS_RCVLOWAT_CB)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
> > +#else
> > +     return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
>
> (Nice work BTW! I played a bit with this, but took a sockmap/stream
> parser approach instead -- this is much nicer!)

If you want to play with multiple sockets, sockmap is the right
choice, if not, it's slow and kills zerocopy.

>
> Curious if we can get into a situation that commit fcf4692fa39e ("mptcp:
> prevent BPF accessing lowat from a subflow socket.") fixed?
>
> IOW, we can construct a program that enables autolowat on MPTCP
> subflows, right? If so, do we need a similar check (or checking for
> subflows) in the kfunc?

Good point.  I'll rather drop support for MPTCP for now.
If needed, they can extend kfunc to call the mptcp-specific
rcvlowat function.

Thanks

