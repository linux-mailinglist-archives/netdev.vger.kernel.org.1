Return-Path: <netdev+bounces-255371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o6rILFqhfWneSwIAu9opvQ
	(envelope-from <netdev+bounces-255371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:29:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A2C0F3E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0440530039A1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD31EDA0F;
	Sat, 31 Jan 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jM5kRK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FE2F25F4
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769840981; cv=pass; b=aFZHbMKf2QCDZBNnkgfT0r21lw+p9dKom6NTNLpQD7GC7yYN5INQynm/wtZ3qBKSyjnQFD/0Kk2ucpjUrIynx+kAOkjTSfc3DCMNhEfPF8hpBmGOCUfqtGF6rpbRuW+MXgT/bV15DTifRX6sOu9ulPRKXDB5TXklO3InKwNpkAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769840981; c=relaxed/simple;
	bh=QkXLUdjt69wTIOEjVCmxgV+YCm1cK/27uOcsux/tDZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2Qn5abuA0Bj1PVWL/TX9mtVWji0y85Hf62e0P7TUmb6TzkCs3Loq4GNT0QMQEEinfHMcKfcdEG2reQLJ8/3AgGD8lLqrJOflgYHhEKvD1sQMZf1EcFr6vc9NyQNo3undFFdNVUa1+X4OQOohh4Kh6jBkorNbVPjNmlYgFggxr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jM5kRK1; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b71557299dso3028106eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769840979; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGh+d4M+oPPAq966U++Mw/f36bIk6ZddVK0ZwKaNMlLmfAnsN4RT9dpqDSDWnDyMe5
         y6sBEay3Qyi5iZzp1Q+NN2HGjlgvEbSze/s2DOt3nAbZFyW2fnUVsEITveJvXjYbR0LX
         xwpVtR4G/ebQFRgvPEeDjAeLNgSft5iMdIsryeT80E4wLyyjwHCoS1uy4ujB0Az2u2LO
         1UVrB4FKYGPqMsB/rdsmRvB7Ld0ak5C+0Qc1etzjh4kbwC7Z18JaMNG3Bq2Q/6dEjHum
         GPCB7S2rGs1/VbSpVmEqs/LsQ7yliCREW7QUat1d5a7aeQytbMO/VqHClJw2gG4vd1Fg
         Ti8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mFKbc5wFdJHpb8ESPFAEXdoapA5+TZ2P7+IOEfEYC2M=;
        fh=EgIE9hFkh0SsjZNI20k4JsUPevb5pFMjiwl6bmEvE5M=;
        b=S0THc/BOirBHph0MBvbjFTzLrogVidxlqemPnwSRakpIUakR9o5qeMCOrcE6dglpYR
         qrhba9wpcuLyD4VshV8OKcfYt9bYeS5Or862AaHOTSHKKV+yQbErOs9z1KQ5YfYeb9Y0
         X6VBQ1WDdW8aMJBUYo3dMCcGB9g2U9wP14dRfN9bT/YIvIPQbA3hYu/Z8UYMoiTywiZL
         urgYPJOW8rLZXNGZrY+xiKFR7hDSysJIeIZv8nauQLbr9ood+hlNf9Zq9jmh8qENLxH/
         x35KnOiSfxY6fOHTCKsJ/H6y/kG5JV5k+TE10fRhCdOx3utihr6bMuBW/+mA616KQ6DW
         dreg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769840979; x=1770445779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFKbc5wFdJHpb8ESPFAEXdoapA5+TZ2P7+IOEfEYC2M=;
        b=0jM5kRK1XXpeEVU3C4fXm7pDUv3BBxzaInysUWhyJeCk+GYDtfYUa29j/XlQQrBiTk
         Zl/bHK/KRvsykb1rZwzldU7XSHsFs91kd0XEDg5PKFRZhxELymcc1UJRflIkXZnQ/mEv
         MglD4ylJwl7fKP8mbhLsJ2m1fZx8Agh1GO0S7Vlzy8FZreSUuPNiUO9mV5RZvxN1fiIO
         myq2uj8FLMltFcDk1n28TBNrPUiyLfuyETdNBFkvF1QAmF711DYOSaP4pkVCHXLqVHXT
         5ERL1eQRw4397pcQ5YbDegSRv7Vgm7BjqStc19XUO+/eBOjRL+XrUVPaREZO/x+ZoA2t
         i1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769840979; x=1770445779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFKbc5wFdJHpb8ESPFAEXdoapA5+TZ2P7+IOEfEYC2M=;
        b=CorBeXajPMKzpvuAIoINBROR8/11XjBeeTGvVdiTr5Lilr+pV9IlrZ66DCxsCxVUSa
         y8gRjClOg5WNgG/yVblazkC/MRC8v67EczRbyEk6L4/cpuYS61bZYxLX96gvv9vrsI7l
         um+B21ZPXykZyvOFZc09QS7pzn2wBZ1PNEHLqem5KkK8NRFOo7Xju+/f24q7dhpJBdDu
         gyCQ7bOOvd176NomrNnuO+dWq65AseoyqtLiloVxWaLiZOwqa/SGNIFy31q3iN0eakye
         OhMPlCC6Wx+AiLXGxqYmP1VTmae6NuA04SxTFauzGYEvu//mOLdSzcz2g/CEifOINicy
         V7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfioggHNVn9FcZYF998qjGlQg/s1k4qh0n2Q+rmlKQ4kitLczFtmxeNbfejVRr00qWWJhLcI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SY3Gvx9/U+ldKY+a00nkzFSdrwA/e2E9nCqiVN38HCwB6HTv
	CKu9vOBwzPxqoaYgn4xEHGKnxSpfbwxWJ++GzEd3bwz5q1UkEvOxUyb8wYTjPw3t+lg2DKkpb3R
	wkFGrLa5nOdubuJ4i7pFXBQBBEbIpzCeDIjZnAcKL
X-Gm-Gg: AZuq6aJyXKM6UTKhet6NzEmQVVBJjT6A7gccHShsET185KX3GkpRR1xm3EVysRuJYHv
	clU5N/hGCQ308K8WEcoAU+BE4uv4hyRoDvSXbOFD+xKafJiILssE8CC8fCh2lYO/Ke1p3LiWIHy
	nQ4waFZLFXRUeL38579M6VknnOgYLpj/JKLBIWTYCCj8Qf1FPw9GXPRtE7yf1hhMnsSI9hU3pyp
	sAnEQwolaVY+9vF+qQh1gggY/BBgxvT4Z/jaHMwDuG2OIJP7Zz7pKih2uuw3I9sbRUuY170MtiC
	W0MfZp20icaHL5p4nm/YQnUapDPEZia1kR3YDbTDnIW00sxwp3KTL57BzrBP
X-Received: by 2002:a05:7300:7306:b0:2b4:5514:38fd with SMTP id
 5a478bee46e88-2b7c88d5de9mr2746972eec.20.1769840979164; Fri, 30 Jan 2026
 22:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-2-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:29:28 -0800
X-Gm-Features: AZwV_QiT9BXl80_KjVVi7Kg00c2tzM2kV4OF53ZZoOJ6UikQEJoklAbn5FDBQXA
Message-ID: <CAAVpQUCrLxU3deQ7UY_RwW6tqa975qDPS5AwRHbxt2hO9EtLzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] ipv6: pass proto by value to
 ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255371-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B0A2C0F3E
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> With CONFIG_STACKPROTECTOR_STRONG=3Dy, it is better to avoid passing
> a pointer to an automatic variable.
>
> Change these exported functions to return 'u8 proto'
> instead of void.
>
> - ipv6_push_nfrag_opts()
> - ipv6_push_frag_opts()
>
> For instance, replace
>         ipv6_push_frag_opts(skb, opt, &proto);
> with:
>         proto =3D ipv6_push_frag_opts(skb, opt, proto);
>
> Note that even after this change, ip6_xmit() has to use a stack canary
> because of @first_hop variable.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

