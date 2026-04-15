Return-Path: <netdev+bounces-278651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I9iGpcl32lcPQAAu9opvQ
	(envelope-from <netdev+bounces-278651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FBB4008C1
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6B030182BD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7E37F8A9;
	Wed, 15 Apr 2026 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxuJODnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0D37E2F9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231828; cv=pass; b=cCc5DoXXwATFMoSnIe+YwDPf4mOhlSz77s1ywMf87Wh4jCNYqzVz2RL7Yaqo0akawhHLY7U9WcRjb6ePTe09JVI+b0IBvPHqzmAXq0qksAxQeHZ1mW5xosaluNXcJhCFWpCL0RaSIwGf4pY4ethJ2dZJtuTpjmxWcYdG2RhfTcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231828; c=relaxed/simple;
	bh=V3U97sip5Mv4JbGeVHgOZ36r6bRgJkRsbKyhPYwGEV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFooG8nVUnpNxOf43LU8wuJuRnpswgudP6/wJx9HF1twuNO3CNuShscShbxu3AVwBNLJXzuSZaSkt9/cgd7fU9TS7qhTbbBNGDYFTDZ+uhnvkwGVs2f2BXBKhawE77kA/Z7n2Zy3nAMlcgBGkdwAmODJ4gMKhQk+JLKoaIOotdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxuJODnr; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca0469204so35962986d6.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 22:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776231826; cv=none;
        d=google.com; s=arc-20240605;
        b=YDVu0khRPcfjraFN5dTJ8AQAsD7cVxVYZUpcgEDc51YG7Kc3fjxwwhGzeA+cRAfF7j
         sZRBL9dJwG8nOcGp4Xo6O4pcFHb90lg9QJNV51Hz81pOzg3Wt+kxQ/oZlpgqhAvzEkph
         u1/ddrLBSJTxSjaL7+kTBwzeNuYGb8W2Nm3KewGEza1kSElFUbOV2TEhGhODNgmlDMlT
         dLPf1WGJ5+MZaGwbjQGYfG0B9UzYE4xMy0LgOQUWmQJz5QssnHRpzIlCoyzG1A8RSz8I
         y/ecGXaW72+33JE0v+w9u8rgm8yRM+GoAQITsdGQB4AIjqlY6PIOnyqmMcxlDFPZawl8
         ieVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUq3AhoGeUTEXVFbLhU6OMKy97K/qIMl3XnWAtEojyE=;
        fh=biXnKMvMaHmXKzwwcRbfe+xz0KSzGf64Ls7CpRP63HE=;
        b=F/nLisM1/E2kb35KiNThz/sduGWOEKetkhcvLQgjKNAP7lpP4CquyG7LpvZAcyDg/z
         Gb2GXGvDLgvGAeR4D3mC0wBZvoY5pkgM4OAaJiybYugcmMDb0jXjoOJKECirAq04JZe1
         zr3qAgxQehIeKIoj+PGTzjc5dEHTJIDxjy0SrT5Bjf6Sd2sgAzkKDhl8SO5p+iBkDkmB
         mv3cuHtEsFm8keJZxiD69R5kGTMIWtuISJ5S7FEpEJYwmVI29aT3RSJ7X69JrMAH64z2
         e6J5PR08OAU+DFKX+YB0rlNUiOSTQWHfdxZoFGQ4e/+v+OE9oAk6kDUtglpSsD5p0Lhi
         dYwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776231826; x=1776836626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUq3AhoGeUTEXVFbLhU6OMKy97K/qIMl3XnWAtEojyE=;
        b=uxuJODnrNwteherc5RDRtkFobbDsu/5onvdU9RUg701AQx+30aTZfjE+dD5sRdXA2d
         DkOv0y6hyGN49S9GuPrrj6evia6gF3ZB0INzArlDpxADp3S9hp96Ooi9vt1G0nHcGyKM
         plGa88VbgbH/msGGrJLIfnJqiA9HVBxh/5BpsBcHMbY/ro7iB2ksTNfae3zerubPsJ+A
         sR9rhvl+iEEnK7/kDGL4Sq9Zohjrt1PVauGUc1ii0M3VlmV3SmgtMcorKxBrNu86NAOa
         mAVVZvTvVGEE9i+jzBW9xpBGyI4dwAfrRnY2U2JcDGBiiripcUTfPdUg9MbHXmi2iG5W
         hhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231826; x=1776836626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUq3AhoGeUTEXVFbLhU6OMKy97K/qIMl3XnWAtEojyE=;
        b=GdOBo8cDYpzEN/dniJjFx2/+qXcz9RWpq2E++6E/heJitk4sAyk9vHBPMZbLSMvrMB
         ERS6gdt1QnMpm8Q3a5xx6zIb6kPm6ytmIKWg3jrzrqXk1Ujx0nAvyZs1Eu0l0zUrwRAU
         A/O0qJpOZwPDaFOFKFpAWW1GI+Eik2t5Q0YPAnFXE3rC+aS2pFnXYvpNhzfcK0BFgO7U
         MbqGD0EHipP3eIwd9RYRLEywzxAf9kKbIpLtHE3MSlKITrKmQ96LHuazxc374QRITkMf
         P7gk3CuAvRxHHRjDhB+vzgr3My5TzRS37PsXu+OJw6DtDz2EPXcODUq1Vy67etWXRDgK
         0IgQ==
X-Gm-Message-State: AOJu0YyLYz/W04aDhcQ8YS1VuNLDqSt9HR0aEoDqzYwxgrGwl+aq5nMc
	O+qBsHtBUD/UfxmGw5Lr4gm6l4rSuzzP1uNz78VKsSk5eOHHRtjZJ6yrsst21HNi1xsYOuUJxRl
	cXbdIjaFa6ZsLW/7HKciX79CWRQjUGHMU88VuPTtO
X-Gm-Gg: AeBDieuXlG/sqgTsN2QeOevNevOT+9cRjXBTYXinm9LQFp1kgqGWnRhwkEyOWmm7GGK
	M376t3rSEJH2tKJVxd8ysdiLE7yRz5jT/cDGy37RJimBwdKcxTzUJE5rFPY3x9X982PZpwDyg+y
	ynVYiulaO1ppNKoNZF2EYdi+l4ramDC1XPj9pA11yHgT2e+Hkq8EF88JtDFXek6bLH78iyGlGMY
	1ccvQYFFfj4a51x/n9nxxO/vsvy3MXQktjoqvqGbtTiP5RFDBFPKAEoIx/CMxcI4P/OP1skCjMg
	wZjpxZfSLTzS+IuXwQ7P6O8fsmiVu4EQ/Vi1p+QxdqmPa/1DzYyqpqfjq6Zl1jMUxopXJFxAiAy
	XPYnAIA==
X-Received: by 2002:a05:6214:498a:b0:8ac:800f:10d5 with SMTP id
 6a1803df08f44-8ac86139ec5mr312117346d6.2.1776231825618; Tue, 14 Apr 2026
 22:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415051343.1190626-1-juno.choi@lge.com>
In-Reply-To: <20260415051343.1190626-1-juno.choi@lge.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Apr 2026 22:43:34 -0700
X-Gm-Features: AQROBzDc24cK0Vx__LVonLpxYLUrDPSB3lSAE_BJVtbHJbhj9hZnSv12-voqCKU
Message-ID: <CANn89iL7Q0bxJ1nnJoLH3RwozfVf2ijGNo4PmJFHtScbpGAwRw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix alignment fault in sysctl_fib_multipath_hash_seed
 on ARM64 with Clang
To: Juno Choii <juno.choi@lge.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,mail.gmail.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: B8FBB4008C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:13=E2=80=AFPM Juno Choii <juno.choi@lge.com> wro=
te:
>
> From: Juno Choi <juno.choi@lge.com>
>
> On ARM64, Clang may generate ldaxr (64-bit exclusive load) for
> READ_ONCE() on 8-byte structs. ldaxr requires 8-byte natural
> alignment, but sysctl_fib_multipath_hash_seed (two u32 members)
> only has 4-byte natural alignment.
>
> When this struct lands at a 4-byte-aligned but not 8-byte-aligned
> offset within struct netns_ipv4, the ldaxr triggers an alignment
> fault in rt6_multipath_hash(), causing a kernel panic in the IPv6
> packet receive path (rtl8168_poll -> ipv6_list_rcv ->
> rt6_multipath_hash).
>
> Add __aligned(8) to the struct definition when building for ARM64
> with Clang to ensure proper alignment for atomic 8-byte loads.
>
> Signed-off-by: Juno Choi <juno.choi@lge.com>
> ---

It seems you missed

commit 4ee7fa6cf78ff26d783d39e2949d14c4c1cd5e7f
Author: Yung Chih Su <yuuchihsu@gmail.com>
Date:   Mon Mar 2 14:02:47 2026 +0800

    net: ipv4: fix ARM64 alignment fault in multipath hash seed

    `struct sysctl_fib_multipath_hash_seed` contains two u32 fields
    (user_seed and mp_seed), making it an 8-byte structure with a 4-byte
    alignment requirement.

    In `fib_multipath_hash_from_keys()`, the code evaluates the entire
    struct atomically via `READ_ONCE()`:

        mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_=
seed;

    While this silently works on GCC by falling back to unaligned regular
    loads which the ARM64 kernel tolerates, it causes a fatal kernel panic
    when compiled with Clang and LTO enabled.

    Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
    when CONFIG_LTO=3Dy") strengthens `READ_ONCE()` to use Load-Acquire
    instructions (`ldar` / `ldapr`) to prevent compiler reordering bugs
    under Clang LTO. Since the macro evaluates the full 8-byte struct,
    Clang emits a 64-bit `ldar` instruction. ARM64 architecture strictly
    requires `ldar` to be naturally aligned, thus executing it on a 4-byte
    aligned address triggers a strict Alignment Fault (FSC =3D 0x21).

    Fix the read side by moving the `READ_ONCE()` directly to the `u32`
    member, which emits a safe 32-bit `ldar Wn`.

    Furthermore, Eric Dumazet pointed out that `WRITE_ONCE()` on the entire
    struct in `proc_fib_multipath_hash_set_seed()` is also flawed. Analysis
    shows that Clang splits this 8-byte write into two separate 32-bit
    `str` instructions. While this avoids an alignment fault, it destroys
    atomicity and exposes a tear-write vulnerability. Fix this by
    explicitly splitting the write into two 32-bit `WRITE_ONCE()`
    operations.

    Finally, add the missing `READ_ONCE()` when reading `user_seed` in
    `proc_fib_multipath_hash_seed()` to ensure proper pairing and
    concurrency safety.

    Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash see=
d")
    Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Link: https://patch.msgid.link/20260302060247.7066-1-yuuchihsu@gmail.co=
m
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

So perhaps you only want this followup:

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7bd87d0547d8af40ca8736e97eac9e3d8a069052..5de5fd9465b8c5ea81d92dc74d7=
c6e50e3a94c73
100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -11404,7 +11404,7 @@ static int mlxsw_sp_mp_hash_init(struct
mlxsw_sp *mlxsw_sp)
        u32 seed;
        int err;

-       seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).user_s=
eed;
+       seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.user_se=
ed);
        if (!seed)
                seed =3D jhash(mlxsw_sp->base_mac, sizeof(mlxsw_sp->base_ma=
c), 0);

