Return-Path: <netdev+bounces-304300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9YcfAY76RmqlgAsAu9opvQ
	(envelope-from <netdev+bounces-304300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2256FD82F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KCkJRjpQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304300-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF943043D33
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D23CF692;
	Thu,  2 Jul 2026 23:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E713C9890
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:55:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036555; cv=pass; b=tndvMvaD+pMejQ9Ht7QHej9ooVUKzsAlfWIUDrYF72lYNMxBO2dDs/BKFoVcttfmaZJoxVuTcBIhPWSI4QgFe9cYI7nRUYcmvUqDnNECYU915uXwwzGhLXjo1bnaPkc1PGVlUbIAw9NZ2pqlA3haQ/abNj9w1XK7Uw0+9hjyX/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036555; c=relaxed/simple;
	bh=PzK/3a+EW4qod8r42q/MbPg45gD78aLPvZUTwYBrqqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae8Aoavbzo9anwLCidal/tTQq2j/Xiz0MBwC5oybA7tYceFfi+5nwnfl57KacN64E1OEC4gIuvtBCtR5QHhWtap5o0XQmOISZ4VofbLLCEWo4DFpgzPy1MAApIG7ppzt/kTnnSEAIvUGPJge/NChuXNoUDTpOKPYGW9ndiwd4iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCkJRjpQ; arc=pass smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c126f9c9567so306152766b.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783036552; cv=none;
        d=google.com; s=arc-20260327;
        b=cDnjZy027vTcJIq4He+96xXgcRaA7rCP1nw1jNgF6rvGcOjs0GFDnOxwPcwTBLKJ4j
         t1AYHWIQxbHPV1JshdNO/p1Ydea3A3GDHI9EWWMj8Fw+BYZhrp6i9O63s2tBZhjM4DeD
         2RitKCrN0U44kMY4k1SnwbAwPfDRHdatUmCB1gzvtdDTVbd6hJmHI79SdtZQCyfw8eBf
         X/aa+RMm4abVJ7ajbGD5e1iRTrsntlDKnVQLVPRxwNe3NHMH0/PznATm5PGocoeznq2F
         Ba6aEwwaVRi1fVjXM6lYq3mEh4YaJlp5oQIZqqiZhfeUO4Jat5vVQyL4ijkuEptRBfFR
         igjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XKyJsl9vpHc7CD9m1Nziom0/Bvw4rlvQakxBpkEnBjA=;
        fh=uUW5rmrur/mtnyl4Yz+80XiinXemOYUuIj9kIiax0C8=;
        b=pS9k/rXiDE3N8pzsEsYF9vKhCMwgYqICXhwCJZ2UqapMWMvz/aDHAV4WvK3L5Itm0s
         5VzwbK+gaEW1000ubIATixMQdC2o+hhhDNZ4JN0Xn8d6PiqRUNB4/hHR7E0bzAdwLI75
         clfWDElB7S5tA9Vb7jz2Ll7Bx9/H/8uStAK+H/ANclzGX1TQ5jcVuArLaDuixAa66jEU
         d79J4q6pSDD+kfSpULSvYCvqsAeok0AIfnDbgSxOM9Md98hRZaPdnyckdXlVJEtd+Sna
         /qAJh1+TBIBT1vm2Cwl62kmkPJsXa0KXCQJyJDYQAyjZHhxGKc9qAiBRM7Sw8odbI90I
         1r3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036552; x=1783641352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKyJsl9vpHc7CD9m1Nziom0/Bvw4rlvQakxBpkEnBjA=;
        b=KCkJRjpQ/qKUkLC+1hLwvSPc6gQ4aFco84+ZgdJMrBRY30QInDoyFvFbjL+TsVbJc1
         97L7koLVm9qHKEyOdMT2dSVnvTljPpjVh2ezNoIczTflHPqLdlc5t/Gz8lDuD8Ta+g2+
         F9o8AsuPj901N5xMzdmfDRYAgh64dx9QVLNnRlCFTZNz5UePAt7oQVMyrTX/wfC7l/e1
         7vGrIIlRpHfpNN0xIli5K5+6wKPIXR1/hePqcYIB6gtS/SGFzeT/j4ZHBqMLrdv7kSdN
         kdf4WYejapdv8MeWLqhUCwA6TqRdougMHkziT+7C4YVMDM7V71Cd0IOk1glNgkuPA2vG
         1O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036552; x=1783641352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKyJsl9vpHc7CD9m1Nziom0/Bvw4rlvQakxBpkEnBjA=;
        b=BUvsvEx0boSU0Jz8sjqskWSarNrhiYWcm6GBQfvf011iwXg/CSWf42fmC0U1v9+cua
         KNZ4BJ9e8KGeLQTPAxmFX4Xhq2u/jzYYVo23gm06A8fGrcUBjx4+jqpK7jYVJciFhnAR
         Dt/NbZ1EIu/lzFcgmZRqSJj6AtYAMj6VSgktrgCKG/IuW6tPbx5k8hqkd0hSu0VQcMFk
         n2A9dk1wNmLstpCaoBUO3HuGGs62gjIu00ulC0ELQishN+YXBbhVaZ0HheDxY0sbn1eK
         8BDDwSOSEhvyHs7p7el0CEtIBKIcQ9innmkrHWcEILrGC4q/oT9PWW4ouGEn8lPI0qDE
         KoqA==
X-Forwarded-Encrypted: i=1; AFNElJ9rnNlImLw5Xssqwdwr3CmDCe9GDce0OPV6gpU70MQOuBCTtlxJvCihiosjPzosckOFtXiQXdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+FZ9eAWeTRJ4dNWwnlAGhboogbrdYefiuaJVp1OlPofUAdoc
	1fSaaETDxmqeM1rBB8kaKMPe0giiZve6DDnrY3NmgaeSFdtQbyO+1RCEhX9gia89NtM7AoXVrpC
	EwTYd3GZuJUaFfjb2Br2EZd5suQqFWvA=
X-Gm-Gg: AfdE7clsik3ZwUDVb0Ih21/rItPYTz76uP0+wK3+Zcvep35m+HFbYYCPn239phppcHI
	whnwg2PKTcc4jU3HYKI5cFEV/uiq0b/9+ObdGcScxLCQ2cjF/g2nOy7TaJXJwBKpq4hqgzlttCq
	DMxe4NIPgXNtsk0fxHM6Gc8ZY2fhYCxaaKvq77KBaTfHvCJf4GoqIujaoGswUoy1LPUDNAIcnv+
	blL15A6u8RdIgBHqDzep+0Ctdal94BYEEbSZ8JEsWauPXkfF+CZHKSPz5OT626wS9DNOnLWEA==
X-Received: by 2002:a17:906:6a27:b0:c06:3267:4483 with SMTP id
 a640c23a62f3a-c12aa1b3512mr391582866b.36.1783036552166; Thu, 02 Jul 2026
 16:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630164623.3152625-1-syoshida@redhat.com> <CAAvyFNhY2Jp5aH6YPrtfc0mBpwuSeT-8u8bODqq=pootpQffmw@mail.gmail.com>
In-Reply-To: <CAAvyFNhY2Jp5aH6YPrtfc0mBpwuSeT-8u8bODqq=pootpQffmw@mail.gmail.com>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Fri, 3 Jul 2026 09:55:40 +1000
X-Gm-Features: AVVi8Cf3zb4j9AF4RZT03Tf7lSbR2X5Hyffy9BP7eaDm8qdfJv9lm9w18pFSEF0
Message-ID: <CAAvyFNjLcVRQBuMsd31neQpo6BY4HBP-hNMHh=RtFeiWBo96ZA@mail.gmail.com>
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb failure
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matvey Kovalev <matvey.kovalev@ispras.ru>, Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304300-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:syoshida@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F2256FD82F

On Fri, 3 Jul 2026 at 09:52, Jamie Bainbridge
<jamie.bainbridge@gmail.com> wrote:
>
> On Wed, 1 Jul 2026 at 02:47, Shigeru Yoshida <syoshida@redhat.com> wrote:
> >
> > qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
> > NULL return from qede_build_skb(). When it returns NULL under memory
> > pressure, the functions still consume a BD from the ring before
> > returning NULL. The callers then recycle additional BDs, resulting in
> > one extra BD being consumed (off-by-one). This desynchronizes the BD
> > ring, which can corrupt DMA page reference counts and lead to SLUB
> > freelist corruption.
>
> Good catch.
>
> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Sorry for the double mail.

I believe the Fixes: should be against the problematic original code:

Fixes: 8a8633978b842 ("qede: Add build_skb() support.")

because that is what you are fixing.

Jamie

> > Commit 4e910dbe3650 ("qede: confirm skb is allocated before using")
> > added a NULL check inside qede_build_skb() to prevent a NULL pointer
> > dereference, but did not address the missing NULL checks in the
> > callers, making this off-by-one reachable.
> >
> > Fix this by adding NULL checks for the return value of
> > qede_build_skb() in both qede_rx_build_skb() and
> > qede_tpa_rx_build_skb(), returning NULL immediately before any BD ring
> > manipulation.
> >
> > Fixes: 4e910dbe3650 ("qede: confirm skb is allocated before using")
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  drivers/net/ethernet/qlogic/qede/qede_fp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > index 33e18bb69774..c11e0d8f98aa 100644
> > --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > @@ -765,6 +765,9 @@ qede_tpa_rx_build_skb(struct qede_dev *edev,
> >         struct sk_buff *skb;
> >
> >         skb = qede_build_skb(rxq, bd, len, pad);
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> >         bd->page_offset += rxq->rx_buf_seg_size;
> >
> >         if (bd->page_offset == PAGE_SIZE) {
> > @@ -812,6 +815,8 @@ qede_rx_build_skb(struct qede_dev *edev,
> >         }
> >
> >         skb = qede_build_skb(rxq, bd, len, pad);
> > +       if (unlikely(!skb))
> > +               return NULL;
> >
> >         if (unlikely(qede_realloc_rx_buffer(rxq, bd))) {
> >                 /* Incr page ref count to reuse on allocation failure so
> > --
> > 2.54.0
> >

