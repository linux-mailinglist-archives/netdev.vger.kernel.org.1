Return-Path: <netdev+bounces-255794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FzGKhZrgGkd8AIAu9opvQ
	(envelope-from <netdev+bounces-255794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E882C9FDE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67D0B3004909
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA113563C4;
	Mon,  2 Feb 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpEDHWU5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2CA1EDA2B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023692; cv=pass; b=scXpMG7doHRT7bpj/EytRt8n5Kn1h/cmKXQtp0XdBiQDGvSU+W+pahTk26NMmMzcWfKE0tja8gdcbKJmeE56qRJVjDXZTTMF2b/A7V+20Qf/GcFSpYU5ip0IaP9jWkyWLfRGtYjQjiTyUjIFLbZZTfUpKy9+ZVlKU/rTe+OmL08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023692; c=relaxed/simple;
	bh=Hlmx6itvnTRIc2QCHXdbaz9IppUzZpOrcPsAZ1RIVlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHy0Qaw1QQQYaM2PtyYYGaHdL0OZaHA/AJs72Dps8KPf/enmu1kq84CiAHFC9leqIZJkba/teHt2JvKWzNN2SoU+9Pi0d72vGmLQHmTk2Jo14ShStxAed29Lm7CgLJYiWysycOUvxgt6zANegEni9Azb17g1UvzB5oc2r2ZN/Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpEDHWU5; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50336cffef9so32951031cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 01:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770023690; cv=none;
        d=google.com; s=arc-20240605;
        b=HUL6+5EqjMyBl1Pk/otjIVnyBo0rXXGRGeKeuEhnSHgKAdZiIKFkPsz+znbu/oqUBg
         zhZI5Bcn9SO/0GLUKyl52EY85YnyhM/hQEONsKOsXPg0XL091U9rSC9iv2OFWT8a9uxx
         Iu0BjS6py+skbuX3w2hqu7h0D49fN/UDi8N+fKqosW2x2ppkMdAOav9oAAZv+HPeKZQc
         BKNfSslAyslVhFztoZayQJMOPDzCNmEoGeHakn09vI62NvJRMcnWwoXYjIQCPRhgvQWT
         pUR5pMo7c8LuWEh5UbxOBz6a8VQ3Wyn0h5FM7OXbMu+5fDI3q4eiE3jCSLoS9mYLaDU8
         z35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bshSp5/gIbOmkc5jxRvILFyEO5Spmn2DFmzf3Fkly+I=;
        fh=q6aiJ0kxxKX/uGNy69dzJDrdq3XS2iG7fkiur9JYQzU=;
        b=FxJSzxmjCzdoyCEsYvljNN6DXThX5fmtBvH6cgWb/Dsx0u7RncQA49X3zUkhBSeI+y
         dl20Pm1GIWa5dZCdzVZ8Dv6K6ebFSHou7ZWyuNXqdVv9hev1x8duATa3Z6ePMizqzwNw
         5oO7P3QgbwfTDejhQktNasGZQn/tuXZGLrL4h5bJ4vYC7SCWTUP2abfR0AICVnNc/mIn
         pQ5zkejx5Iwtl9B0ncpLkdoVWFryrGrir2QuM8H25eNTM6dufwXdYQnw+TYAfU6ovmjJ
         B4MzajFzfw3U+4H31P5UOrYDYfWoLTTOix7DI5n1rRqY5mDRTpwL+IImKQ38IZDDWFrH
         Z8Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770023690; x=1770628490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bshSp5/gIbOmkc5jxRvILFyEO5Spmn2DFmzf3Fkly+I=;
        b=rpEDHWU5v8irxPuWKhOwtrOavEm8xUGlUg2BpOneQR3girn6QAnSGyxCdcEk1NHG9C
         Q+5xlVtIBo1hBwDxjWOnnySEbubR9cljII32DR70UA44XYzlF6Ir2LAxBRu1Nwww0AGd
         Ej7FIg9PxRp/mvXGuAW8SNTbMrLnS0BVjx6RHhz2aIw/Rx+T0HXqi8AR4SfKsNCZoj+q
         lyMRu3dA08Y3ZCk5DnOeqi4TjCIHPvHs31PQnTU6mYcH+KE2Kg7hNva8PaU233h5AR84
         bYbfpDYybVqri+Q1sOWM0yrT4xRB3v0wdY903xk9B2wLetA4YGJgsYzOsJEMOjI918eK
         S+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770023690; x=1770628490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bshSp5/gIbOmkc5jxRvILFyEO5Spmn2DFmzf3Fkly+I=;
        b=vd4h7BAwMU66CQEsGS8zWJ/B+XXouo9SOMw/EfWAbnNJ5k2nqH0WTe4cuR/MsKV7/E
         eX+frxVPa7QXmsCdcpseVCrcsKwmrQswDgn9+OiT9RxWqMOPqZyL68d5O5abja4Nv7sv
         YKbiUF+axFfN3x/SOvMLRcah92z/RNejIc5c7uCbqfkgzQs/NHGPw6ZbGNrhW58mdHe8
         SPiytBJXyjadV6NWtzjkEZounWaSS1eVKt7P2PebDkWiA+iszuif4G2y6vFLwp2NKdPp
         ssy78MvwnJu7ammLIVi3kIjwsjvnRFfPvF37emHN/ZSNcW1fn8qN2b+vvUweGwJ2VlV0
         jhTw==
X-Forwarded-Encrypted: i=1; AJvYcCWPkZTdyAXVzXBOBByT+c25QqZ31wKU+R/mkTwYSIWmGfhlq+OgnPkcqos5EfPvSTeHCobPaGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fVhsFvv8UOFiqAK4YkJT8Yv4oZYksyLgNcu7vsWI+HWboi7D
	JdHxF8MHVCQVraHyFHKrNfFlbrnmBt/BUcIiLC3JGuzkVPLZujKUcQNscItJolBELUpHVhxzjfG
	I6bXX8MnVvETxGjwwAEijwuXq0GuWLLL7cGBFTWWE
X-Gm-Gg: AZuq6aL6oERO9LfiGdfMGUQCvvMI4IpshHuG+Oxw04cjljJa6mkALBlNLNhCFmC+Hbw
	3X8vW0y7K3b/EUAUZV/B9T2I+DT2j6VdzJQI4bVCjRF/jjWaoyH/d+CDcVbnL/PHJ/ow1zd6Crz
	b2/yt7R6fvkF5Sn1oLYDSS6KHFpsQ20zM2QKfQk1iMCqC0p09jtAaZuZq3P8MF7wxvdb64MsJkd
	CQG9PAOlZvOQsZPhWr0XIPgcU8lHafK2JZZesjXQjdu/Tw+8u3LMKgSjfG608lKLmIMDC0=
X-Received: by 2002:ac8:7fcc:0:b0:502:f81b:9961 with SMTP id
 d75a77b69052e-505d2191537mr151329231cf.19.1770023689958; Mon, 02 Feb 2026
 01:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131212934.2547995-1-edumazet@google.com> <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
 <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com> <CANn89iK95qb_=KWrcsvqEB9Bn0PXi3JkY5h09NiWuVWARABOww@mail.gmail.com>
In-Reply-To: <CANn89iK95qb_=KWrcsvqEB9Bn0PXi3JkY5h09NiWuVWARABOww@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 10:14:38 +0100
X-Gm-Features: AZwV_Qi0gfsGjTjcyckB_u84fUFbzITBZEkqxZr12ZKTxQJSbBRzxpVQEJCpcmE
Message-ID: <CANn89iJRmEPJiz5-L_yJorU+xH5kBwraFy2_-=TwgkHzzfjKEg@mail.gmail.com>
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	fengwei_yin@linux.alibaba.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-255794-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3E882C9FDE
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Feb 2, 2026 at 9:21=E2=80=AFAM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
> >
> >
> > }
> >
> > [2] add delay to pype_seq_next
> > diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> > index 160dd729178f..73f5a20ef57c 100644
> > --- a/net/core/net-procfs.c
> > +++ b/net/core/net-procfs.c
> > @@ -230,11 +230,14 @@ static void *ptype_seq_next(struct seq_file *seq,=
 void *v, loff_t *pos)
> >
> >          pt =3D v;
> >          nxt =3D pt->list.next;
> > +       if (pt->dev)
> > +               mdelay(5000);
>
> Waiting 5 seconds while holding RCU is going to fire the soft lockup
> detection after ~two calls to ptype_seq_next()
>
> What is the actual trace you got, and what happens if you reduce to
> mdelay(1000) ?

OK, I took a look, and ptype_get_idx() needs to return information
about what list the returned pt is in.

I will send a V2 ,thanks.

