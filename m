Return-Path: <netdev+bounces-299444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z0hmIi73L2qXKQUAu9opvQ
	(envelope-from <netdev+bounces-299444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:59:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE768679B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uG9+Abmz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299444-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AE13301B7EB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA313EF650;
	Mon, 15 Jun 2026 12:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4C219301
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:43:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527398; cv=pass; b=spi4VKuoqkTsZI7yvLeKXE1lUVCXK55mM4YbR79nzzoXyEJVGb9/peSYwIEWNwCBrs9YAaZxhS1KI3gpA8HT5abbNekdlXrD/HR5zs9JBy5LA9wspRKxKFjPrJfm8DhX7rqT2CBqR0F22Y3Poe0+3VQZ+AWRLvijsmCj2GiHFUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527398; c=relaxed/simple;
	bh=bhc6xpQHzdDh1UGrX5Pi3xY4zrqFkwRTBgqhDe6OwP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgkiNOF/dnZYo7jvnh5HR9ik13vxv7VnZ4gy0ahqCB/lPV3qB5Q3YfmYTA9vdTOPTiyQx/q+Q03Syeepx5tmC1bnMbLOGdlvCLBrRKuJ+FS4ZASWnOYOM95pzb5Wt3xjzOQdclzYIBmIM1WB/pm9yKpUDJW6j02dobVIrkfB4Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uG9+Abmz; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5176bbb9384so36966211cf.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781527397; cv=none;
        d=google.com; s=arc-20240605;
        b=XfVm9D8/2j/JMvE41a4cn0rlSLwuACLMDdQ1j1k41aPRubvPwVJfECKhT5Ur3XVPTd
         DIz/xYjYhOk2xO53dprgtWoaAAv6Zhb/lx5Z/GJt3O3hll8ykUrOG3yiKaCwdJfos03e
         tu5Ne9bSzHJzRfFUkJvtBszWfJ+QlP2mmpH4i+Bgn1wHjsbzljWfL1GUajlY5rUHady/
         tWgNBKBnXoQ/2OLgIjjlcEaBKzeYtRWZVn4dDYemC3SZuwVGe5A6wqjZ2Qs5Uk23Ui+Z
         oByO+OOlpZtCF+5PshUXVNqtl0fRsBI8GmsrKMNiH8pTEO4qJOXryqL4tc3xhIPi/ilJ
         AxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bhc6xpQHzdDh1UGrX5Pi3xY4zrqFkwRTBgqhDe6OwP8=;
        fh=h2FKOcIvZyCo4HWw/vokAHrxU7xPSHtSQCXDhvS5nk0=;
        b=ETlLJip5HgMkPDw9sQ9EGfdqKkuSNLSpU1FgU0oWSbto6OU0oaGehepEo73gpre0YB
         gfOyqcot1qs6TY3wGIXw5+DLDIQY2IObkWEqPpl+NJtH1HSn8CI5KUitai9l71ydHa85
         EVYNpzACcNsh0ZNv1HBkb+E5cg0gsOJ8W9nR3dAAcNbETUqo6GjZDfxNCJHRPaJZqEKt
         AN82Uw9KVbNDjPfJE8osdNZ+gt4V8SzsfObZOjhJg5FwOILca1luoBOnXKPd0wSJHzrB
         Q+coOgRGYpJQlHyGi5GkPlwzTgcsLk7WgO7GVOdLyfARq3Ba9C9/eOwHyW8rmRtAjBQ2
         DqDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781527397; x=1782132197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhc6xpQHzdDh1UGrX5Pi3xY4zrqFkwRTBgqhDe6OwP8=;
        b=uG9+AbmzSxBnnjkFBb+04f64kJ+3c/klTtGMC3W6BVdLI2QoSuySk0/iDL7dbnQ3aX
         7rDWSEHBWEcSfrT7OAR79rI1C8V6XhIOlAaEK3wTRtZkaCBRL3R8b2eLNq+Lzy9wFx/m
         d6NxeNjDD5Wqz5p7Jdvc0ZU2IsydEi4sNh8jzvENt0bj5Hiq/dnXnLGpdoZg9D1Fu7Bp
         i4CUnUgTvXNT0JamPBvl8DIc2Krvy1sQOPx+xRCvhKP0tJQN/YUbfgzuEFDgL6bE7c6L
         TDWSp9h+MhiL2JPK3R0MZoc+Cp+uIvQnTUnb5OxC1swdwLsmlmu3e2bBgAh3Pm5P5Nhq
         m1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527397; x=1782132197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhc6xpQHzdDh1UGrX5Pi3xY4zrqFkwRTBgqhDe6OwP8=;
        b=TTizUvMMuzun+lGTvSGDMe7A4zY54OxDw9iXYQD8BKf2u9Org/avs8xTfeudxM+4Os
         sKZyZXMifQhaPzoxlaVHFh+GSr0S8HDlXqEi8fRPyUbWGpRpEjXCgejWCrnstDUGy42/
         +jYgPTgrSXDJlS8AuIawcDaMn86EkIlzo3iARhrmwwJBf+ubCGuvjOzQclXeMTM4tSUm
         KKdwvgvC4cPmYQLy5G7o4sgLnGWHiqZydoABfHMPcQ55EDFM+/aJAclIdNCSJeku47tO
         Q2eCQ6NMbkKUKC4LpBiAmFX583ApMJci1fQB9gMBaIe3m6iREgzn9BGz3gh0WqX4yU2Q
         Mpfw==
X-Gm-Message-State: AOJu0Yw8rJPRMnvuEHjgppPlYO3U4xJ7MFM80hwi75YteKXikVyixV6Q
	f1vbRspGWdhtdHc2eM7vQXhJPws7OzhMNL7cxyuz28AV3wgfq9RuuFoit1j2dElITNoHbn7lBsG
	+6aVeyb2hYsAz5VrsIUT1vmSvgsTnkKiYltSjHJrj
X-Gm-Gg: Acq92OHwJkfSTbaz199HZrePxZhhwX6+XgctDtJJ0J3tqKX67fZ+jmoJdN3S7emVVxE
	3XgwVhVcFO9yW/VFB4wV6unUA0Xx48scfiAiNaxUxTRpNDbErC0wr2hC2wS3KBBIONh2GaBCaHm
	zGE2Cby28KOtVppAYk9h2yJn22d3QUHOC6N6jV8gdpSH8q2BVyd0rOZlCemQrr/tpcq7r/Ew+1a
	tZCwxPqnAn2V2WsTKXAeGws2b44zeCGtBAe38sTOeBkG5G37OoZ++e8Nu+glmMUMa9dbVqZakJz
	uwn0qxMHMxxJ5Ax7BPKmk+haquAfdDh4V66/ShJvyPQ6qg2BPERlS1E98lO0h9wW5o1iUj5J+nL
	hCWUnwD9KP60Ug1Y541LM
X-Received: by 2002:a05:622a:1a9c:b0:517:7d69:805b with SMTP id
 d75a77b69052e-517fe5cbdf0mr215184361cf.27.1781527396122; Mon, 15 Jun 2026
 05:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a5b7e1ef4d70fbad8c8ee0b82d8405f3c964a3d.1781395200.git.bronzed_45_vested@icloud.com>
In-Reply-To: <1a5b7e1ef4d70fbad8c8ee0b82d8405f3c964a3d.1781395200.git.bronzed_45_vested@icloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 05:43:04 -0700
X-Gm-Features: AVVi8CdK32d1aEIiXfp2t4c7btXGC_Pz-RqqCEZVuzzgLWNbqtlGo96aKxTUL6w
Message-ID: <CANn89iJactwfdJB0i2Hpf_3rJzUjmPvAvNRbX8JaCD2xiJ-57Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: ipv4: bound TCP reordering sysctl writes
 and MTU probe sizes
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, david.laight.linux@gmail.com, 
	ncardwell@google.com, pabeni@redhat.com, chia-yu.chang@nokia-bell-labs.com, 
	ij@kernel.org, yuuchihsu@gmail.com, idosch@nvidia.com, fmancera@suse.de, 
	herbert@gondor.apana.org.au, yuantan098@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:david.laight.linux@gmail.com,m:ncardwell@google.com,m:pabeni@redhat.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:fmancera@suse.de,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299444-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,redhat.com,nokia-bell-labs.com,kernel.org,nvidia.com,suse.de,gondor.apana.org.au,lzu.edu.cn,icloud.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BCE768679B

On Mon, Jun 15, 2026 at 3:31=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> socket state. The sysctl is stored as an `int` but copied into the
> `u32` `tp->reordering` field for new sockets, so negative writes wrap
> to large values.
>
> With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> `tcp_mtu_probe()` size calculation and drive the MTU probing path into
> an out-of-bounds read. Route `tcp_reordering` writes through
> `proc_dointvec_minmax()` and require it to be at least 1. Also require
> `tcp_max_reordering` to be at least 1 so the configured maximum cannot
> become negative either.
>
> When registering the table for a non-init network namespace, relocate
> `extra2` pointers that refer into `init_net.ipv4` so the
> `tcp_reordering` upper bound follows that namespace's
> `tcp_max_reordering`.
>
> Harden `tcp_mtu_probe()` itself by computing `size_needed` as `u64`.
> This keeps the send queue and window checks from being bypassed through
> signed integer overflow.
>
> Fixes: 91cc17c0e5e5 ("[TCP]: MTUprobe: receiver window & data available c=
hecks fixed")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

