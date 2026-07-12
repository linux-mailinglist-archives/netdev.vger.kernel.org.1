Return-Path: <netdev+bounces-306959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QVBvD0G/U2piegMAu9opvQ
	(envelope-from <netdev+bounces-306959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73274552C
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:22:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=RacuGe8L;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306959-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306959-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57C783002931
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA9356757;
	Sun, 12 Jul 2026 16:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1163546F5
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 16:22:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873340; cv=pass; b=JLdOYX3u2BTkZIQEUTctSHfJlDHdj3BwGh+i6ODsIunAy+hNcbqhffq0vN/IssfdV5myav/9FAusG6EUmisdojPT25TT8V2wVn4VTCnOUFQQbL3zn4b2QyPEggsg/sJdY3JoaWki7VDS79bHhSyaRgN7X2D2fJcRK1Ak7mANTKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873340; c=relaxed/simple;
	bh=J+iZNQQvMSCXr2hbBHz7Wo3mc0Gi3r0duqYAG2oZu7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiXx8u6Zyk3+zkMSgGDQb0df0zkbEzf/W1oijRsDxposZCE/IT8q//4IfdCVW1f+2fpW6SJskNY+zNTTCkbePPVh4OdYx17DMKxJETf9tpW2cxKgViuWDUjJatj63AQClcYIyqto0TmRPzUIdciXasDxnVnVUZXWN5ci0K7w+Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RacuGe8L; arc=pass smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so28166225ad.2
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 09:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783873337; cv=none;
        d=google.com; s=arc-20260327;
        b=Bn1Inmce41MKSKTf2f7QjSndfv1U9R62VEHLWuFZkaZJHimnRzWv0pC6i8/u8Mow5i
         HSnMTDz2GCx5oNXFDl9KVqKUEU8jAxlE01g8Z4/AiWCz973CPOD0mPuNjNDPwpzxYopR
         Hdh69yNIkbkwInCW+j7aUo3xQeIejCmBli3OnVFtV/jaf8VTXe+xgcFLqh5BWmPy/koG
         ay2dVMxAoKCm3ez/7ksiJkrEicJ2bXmtTZc6GShYHjYkykMepDtDJr5nCI8Fzu6yNkoY
         pRP0P19nZEO6Yn/bkITL1BABDyhY2ORrhAWh3x+g2schwDuFETTf/ziduQkQxc2Qp7wp
         5UEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        fh=rqZPHbaigzXuUcNSgJzZ3AKlAa0O/0aTcPj0o5u23Es=;
        b=epD6lRXkBNo1qzHcltjpXJ5JH9bKQsO4FJSSVYZaYyWeJyr3X6xnRTg/nK+gnKjRLX
         8FQKBxlXnn8j/JbWnBjh94vFKoNivXtRX/Nz/JJ9TlIL1eH8rKzCEBRV7prlTHm+874C
         gkcJaJlDV6RHFtRgKcTwX7AM4DFk9TWVKISQHvVFWGAmCmJGHfvtSDq+3n6WRwON0Xnm
         N5UUko0T2Dd62OpeagaJBHUYi5/C8np2kH0zt7JORLasCwefjkbNXk9RqUKLnx31S5k7
         myCSMPc8P3Wx7l5X+Z84PmFlb7GNHQXEHgG+uAroXOwhulxWzVq0MrRnSOm2gNZ2zWc1
         +hgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783873337; x=1784478137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        b=RacuGe8LN4plnA3Xo9TIQCTzwQDNnp6xMSC0wc9wW1zydSoq46Rz/4tcx4cc/paW1M
         foJEUEpl8KDGifywcNLPBrHUaBXperRJBeavl2NA9e1Qmi2SOnvWTCF+gEP0gtw44fuq
         U9wR9IcP4dVNglv3a55eluPRqyojM0A18tmXSQOEqi+mdK5WKvw4LVpPK7h8vMV+h2NH
         ePzOZHWyBcRSfjk2z956w5cD4wn7ROrQjtfSZ14R2486Tp3roKrerqHvaNOPq0gO+IAm
         dVuQI/oQEsFmrXJa4+3aCGSo4vDJXf76rkR0jDTDonTylX+vsatHMYIkC7SoBlzFkLS0
         Hd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873337; x=1784478137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNQFSIoiUS5yps8KC+SWZ1gAvHIjXV4NMadqHQrQOw8=;
        b=H16l5IhehoPixIoZSAOaZZgSj8hw7qFaTlLNwIHQ6f6eS5CJIeSr6c7U6JZz/ZPuUO
         oYpWmZsrm5IF0G6wQajrAnRGCzHnSjt5b8awEJ/Mn3ya1HbDkv9cH4rpufPRwBJTMHH5
         cA7XZFqTlGMeUQK4nQ+DJjxM4B7WRPMukt6EaMMP2S7jU3z0pKph2btX4cdW7GZVfpvB
         q6GhlouZPkibW/6OkB4moHfIX+9+XeI0ur1phmg0wSpAQ81+mMluYH0N9omcaqUuPzYv
         uIb5Vu4BDz8mcLvAuobRUnAJAFcIVCQua5zb+cQALVdrI0o/QwLNjJOuANXI4TS/dOVN
         Bx8w==
X-Gm-Message-State: AOJu0Ywei08tGrI3L0cRQwDf3MkM54LyK3q+/kzsW0cPSsNeVN6kburF
	Zv0TRcdYGEWYFumqxTGmU0ao+71KRoPOqXeSs9sbK8tAb8pIdw/D1k3hnYoLt7EpNqYQRnq6zN8
	9XZXc+pLAvlyT7nJNAHRbZBnOiTbf75PNory+JdvoMWQN3djOsPP3Q3It
X-Gm-Gg: AfdE7ckRZHJplRJnsv1s4LCJa1WhJZaAMCyDTGNo6OMnwGkDIKHi7CHj0MXQWp1oeid
	OgYgnapnJKRfogAD11ouMJ9QZBUeg/xc9uVDEsANLB4Km6pByVjnZbwsKZ3BgGCfdEF9gUewYJ9
	cel7DCks4XbM6ZRcpX4imafysx7qFhTCHwTbN0+YfT6NcQABEVonbipSUJu8zMYvMetqrdWVvGd
	s6KebxklboXUwNmmN6yKMhSk70c8vqXl2lZ0uEEUEDenyAI/hntuZhrlLqipvk6m+LVFOiDguSx
	Y9K9xCM=
X-Received: by 2002:a17:902:f706:b0:2c9:97a8:afef with SMTP id
 d9443c01a7336-2ce9f3c2c44mr56463405ad.40.1783873337523; Sun, 12 Jul 2026
 09:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712013941.4570-1-fmancera@suse.de> <20260712013941.4570-12-fmancera@suse.de>
In-Reply-To: <20260712013941.4570-12-fmancera@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jul 2026 12:22:04 -0400
X-Gm-Features: AVVi8CeR6p9IFdHxiLZpYHAlyp8c47JdAudStQqM7LnXYkS82gL2ns4MbJCsLNc
Message-ID: <CAHC9VhTA8Y+BLOcLcv6X9u3nRU=X7NQz-u4kZuVNL-Yz1mWKxw@mail.gmail.com>
Subject: Re: [PATCH 11/13 RFC net-next] net: cipso: guard IPv4 packet
 manipulation functions
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	idosch@nvidia.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E73274552C

On Sat, Jul 11, 2026 at 9:41=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> To enable compiling the network stack without IPv4, the CIPSO functions
> that manipulate IPv4 options and generate ICMP errors must be bypassed.
>
> Ideally, CIPSO should not be compiled when IPv4 is disabled but
> currently it is too integrated within netlabel, so let's just bypassed
> the relevant functions.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/cipso_ipv4.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I think I would prefer to make CONFIG_NETLABEL dependent on
CONFIG_IPV4 at this point in time.  This will keep the code cleaner
and allow time to do the proper work of wrapping the CIPSO code with
CONFIG_CIPSO (or similar) and making that dependent on CONFIG_IPV4.

--=20
paul-moore.com

