Return-Path: <netdev+bounces-290976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iVDzKs72EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F55BC0ED
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C247D30B5A26
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542FC23C4E9;
	Sat, 23 May 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXfrZJ7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E11FC110
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495683; cv=pass; b=JNSg8kOcku8rXO3y394W7rzYPmDB3OMDwjFvftWt6a9P5nrxiA4Ee+uQ6xt154L8h1esEFJ9WgnVnHv7Ni/NQylJScN7RS1d3GehpB4da0UHETH/bCKwUYG/uXz/sBr0tAm+Pgn/VuhACkmhutMIMxzmZJ+BAy5NNsM9F/01bwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495683; c=relaxed/simple;
	bh=D4mJ8FPVD1YjGkYCg49HEYymj35lmCHehpyNdIcT9kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts3jORU9SUfxndI2MOH7ATnLNApgFzvaUzqNP9hu0yc+urnet+IAm3EH8hLJCSMzY5T8b9j8q5FmtfA80NtcmNb1hwBGOu7eXXOr3VSD4msAW7Eu2BrScbEfRdlv1sYZgV5lHpAB5mDOetLwF4B5Ywt9w0wxRAQ6B2XF5RsQpbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXfrZJ7X; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-130c9dcbd25so5191734c88.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779495680; cv=none;
        d=google.com; s=arc-20240605;
        b=PU59iJiDRdgqommU6zCtUhl2t9ORxoqiBb8SWyZL+QggxW2s31oZlMk8xeT/9oIwJ1
         ibVbSuzBDDqP+4IVB90JbZH2YHHrpWbjKFjOu8803cfUvg510XsEjkT1g7UcHuTIhTT3
         8TaTGif6asWdX3UbAyGp1Vb5qKv0n7HBP3C2T1IfswIOoJnhNgwL2K/edjx8Pnw7ZRJD
         Qv5z1u4FFhbrbB2B3Br+B7xVKIvViajeCVUvkfPV0a+WKPIg9athh8FvS7u2Oj2b1rt/
         f2v3QkKxzlv5QFvtZdTgnZLgV/3781emyv/rB1P7htMd6+kV9985fihKcL5qIe/DH1k2
         4N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        fh=y2ZCoJWFNHiu0e7FEpdCbKvfC9EMJ7X/6w5P9G11Okk=;
        b=GxVYgm0zIS22L7dhNrtnedgkZuMHazSz2XrTKQpXkEIKbNL+biTkn7K+bJfU145Kbb
         fEnsa/ZLgYKRe9q6eEeK0F7+FH4oZLaDg4QW2KJFxyu3e6TDv0Eu6ogGE/HTLoM2WNF6
         C9hW2N+YvQrlmpvRVPcQ5v26w4JI5LTYnQmUMvzfESLId0uyIyPaO3+FOp3PBn3Zarag
         lVHC2fqyDCUR0cTC4s5FUEb0YH6EHLAbrX7DuG1j0uBO4vdsYGlRRBTAFhlR/6ieoSJ7
         sNjPB6gsJ3lXlqj3x9YdmTWTOTDWpznOJMB4L18UHJfgThDckWj5LwplAO18gg6oDmqe
         wAxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779495680; x=1780100480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        b=oXfrZJ7XEdYbE2gNV6Z+eeknlVX1u2cgiuCa8/ZjUBIl8N0aqibJCsA0s2oXHryWEy
         Mpvw3YVyhEXPLKmZv6BqFdJtLmJgQh+EtmV9NGDEm/NbZSYFqEgFxIF+AlZi/JLENxHa
         Y/u7sUYSnxgPys4/zbaU/SH1nH2+Hm6pa32uOIVzcWqmoxDG3EFfocW+fuS23rq8du8j
         4abWAg4T3fsihV5+n76pIFYLcj+I90O9fRnbFZTzypYPlZiVLgSeCqm7tQDjNP6p7L/L
         Xz3OshajrqRIrgalbJrScup6WyrxyM3SIFX2W8rdSqzWZVfukNm9YEpb1jSqBUYlBFWy
         Th8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779495680; x=1780100480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        b=tXH5h6HVM6Mo6xpg2RVneJZlYzv/HRTgOIvSiYPgE9f4tEF2ZROPOJJWRarZhR54CI
         HtW3XFZ7m7YeZ4IwYiCW4OMnIydPk2NZbzr50V7tiSiX8m+l7bw2RLlnrH0sUeW50BMH
         GwU+lkBFVLPfS+gtSzYK4AI+JkcwV+4U0IPoj/nOEiaMeY3YYpqEYbVFp13NNgyX/iS+
         RQbyEbmBGcnTmdH9vHtTSU2aIzvvIZasmKmzYfUtfQA00v4rDqRM91YBZAa24XJBG788
         jtmTKaBzKePEVxITWg9Khiif5MQiyNcgT5vN9hTnGYe/N1jRPieXvdaUvignj2AesUde
         KcWw==
X-Forwarded-Encrypted: i=1; AFNElJ/IPIk78dm6ItAr9Ty5JFSbmE3qSbQBlsR84KXPoF+aONrTyEUU1QeUdAozZoFqkiO0/oE1wWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1eDKiQpCSAPduFuKOD0jNsP0eVXhvq4QGcAVJCubMzyvVelr
	DXbz8z2PKEZA59/nQk74QgJ+bQcwX0kmkhKMn7VzgQvh+RfhvLQyKGyLkPN1dFiq6zs/mwnlcnw
	iq/eq+2okgwaYobIUZZH8PscIbrjlXp2wMbKLFiPo
X-Gm-Gg: Acq92OHyzpjvOCJENmfFsbRbDdYziYYx13xz7fDzXa2k17OWe9H27WgqHM9gh46AWN4
	h+gB7zK2L8QU0aDkgIyqcGw+hi8XTK2zJLSDGYI180iEfZPHdBtQ0CTbuz1BM678VzAjxJ3Tke4
	1EUibRPCl/P4mdMSLNPdXC1vkXyuUv+ZGKvOC3QHVaVPPmB4rF0LLx9aGZJnkfhfQLSAY/eI8ww
	KH9XOapba0u4LkbcsoKXOzGfal6nU7cALcflOV9g0s+ihubR23sZPR3k6N9MuvDX3123vbhpHbw
	+LgP9iBnHoGWiNjLSvPdjXVAft7bQcPSrlrSedz4e/0DGhqSTc+ruz6ehBPe9appESxPeog1RZY
	Dbfy67a0W+pq9VrjZIoCrIBQLRsB8v4wplOIlweYunap9pWjBxrQ1XUxpDz542Vg=
X-Received: by 2002:a05:7022:41a5:b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-136341cd515mr3579257c88.22.1779495679240; Fri, 22 May 2026
 17:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-3-kuniyu@google.com> <5d9fbf4b64d5684f423bcdb540d72734b962752adbbf69958138cfbc9c907f5a@mail.kernel.org>
In-Reply-To: <5d9fbf4b64d5684f423bcdb540d72734b962752adbbf69958138cfbc9c907f5a@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:21:06 -0700
X-Gm-Features: AVHnY4LDyBEijob0AU0ht4MUtMSwXuaQK-_gazG06ym8XCz2Jt6ctHmtZZT7Aug
Message-ID: <CAAVpQUBMpV3WyuuYZ74VjD7Wc94QdnSYBYSz16rgD5g8J2ocMg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290976-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 205F55BC0ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 1:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index aec171ccb6ef..31130e1b63ea 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
>
> [ ... ]
>
> > @@ -7031,8 +7034,16 @@ enum {
> >        * options first before the BPF program does.
> >        */
> >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > +     /* Call bpf when TCP payload is queued to sk->sk_receive_queue
> > +      * and after recvmsg().  The bpf prog will be called under
> > +      * sock_ops->op =3D=3D BPF_SOCK_OPS_RCVQ_CB.
> > +      *
> > +      * It can be used to adjust sk->sk_rcvlowat and suppress
> > +      * unnecessary wakeups before sufficient data is available.
> > +      */
> > +     q =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> >  };
>
> The BPF subsystem requires multi-line comments to have the opening /* on
> its own line. This comment starts with text on the same line as /*:

All SOCK_OPS comments are written in the netdev style.


> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714..4a50fe2cd863 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> >
> > -     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +     if (!is_locked_tcp_sock_ops(bpf_sock) &&
> > +         bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB)
> >               return -EOPNOTSUPP;
> >
> >       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> >               return -EINVAL;
> >
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> >
> >       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>
> The patch allows bpf_sock_ops_cb_flags_set() to modify
> tcp_sk(sk)->bpf_sock_ops_cb_flags without holding the socket lock when
> bpf_sock->op =3D=3D BPF_SOCK_OPS_RCVQ_CB.

This is clearly wrong.  BPF_SOCK_OPS_RCVQ_CB is under
lock_sock() or bh_lock_sock().

