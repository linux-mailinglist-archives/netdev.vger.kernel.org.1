Return-Path: <netdev+bounces-262520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RLizNjwqpWnY4wUAu9opvQ
	(envelope-from <netdev+bounces-262520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:12:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269121D360F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 715C5300E273
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCA33344A;
	Mon,  2 Mar 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjNsJ10l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CB37B417
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431928; cv=pass; b=LvVKT3HUFX/UaSWtYgNOG2sL4WWwsFeBbbR9Z/6LWt/dGImlwap3M1Yxpj9fal0Q1xKxzCzcXRtMO9BCSU8qHuaYv9gkYkYZui1ZtHNO7/4cbBCK8/y1kgP4XjLDSjShsuxQxGvN5LAjZr1PSg37NwoIT1jcSVe8v8hK7n1ontI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431928; c=relaxed/simple;
	bh=UZhBqkq7sme1gXCpbJjFrKz8FxqcGe2wY6C+t/7f/v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq7n3ISrP1axlUvl24ttWOTValJnxMrIoilOxfzb0n87MZHo9MPZcw1dQleK/N+gvgzRwJDKSZpaaAznUvDRtXuBVptFActbGtZONngWa/fscXcKSBgFG3yCBgxJGi288JHV6hbMqV78k3QXa7hss7H4FbZjtANKzz+1pBZRLu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjNsJ10l; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6f21c2d81so397186885a.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772431923; cv=none;
        d=google.com; s=arc-20240605;
        b=Vad1cpH2lRHSf9EvVKLTu1qtepoZ3DWYPxMbR+I7viETsRPI6ayZGg2HD+J10gCYoN
         4cyCZhdl5KKdMhbF7GxkXdUYLF9mt36zkJW2g63VWsGv4vM64PHA3Ics4wKEBDUi8Nc8
         Kyx4wSXvU0nmH+IptFZoOM1LLhfZ1Ol6RAqh7wCV2LzjeDTCroIChg5bOOhrmN1pgGO3
         9xjmcP/W0lvZ2Qcx8fyuGzk+SQfCpMIfXOJNBDA0PwMzc+Gqqojork4VGOHhCgQ0KIm0
         XGIfjDZpHtRqDCEwLlqql7koAL/+MMoSWA2BFC/rIkrXbkw9WuT+odcbaojG35kiUEQr
         lkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ski89AnwaWBeS16R9OsWU00+Wyrl3eVXwV/RiRDK3rk=;
        fh=3Y5GW5XVtJEB0gP7NdIhLgWVGKOFzNBWGKDtaVg6rHE=;
        b=I2wdEyDbuI0vkOb9wo+RrxEDzoOrAx3l4cvdcJhiSMwIad1c9mZ/6Y/q1kF7CJZIoi
         P/3d14TxT25+oRgd1HatWF4p+Rz4g9dtejTtlbgVaJHhAblqNgRAjqN14DZyzHtZ8OI8
         YlA3FGGTgCboN/k19uYL8gEK1ix5edUt4qE/u/+aWkgjadYaALxzSOUpiSj88P6LZOmh
         sr9J5KpU45BAi2E0D1ydi/ZutnWwlAeJXFVQbh6M/G1gpn99V11Ww9B0cfiCeHZMZ5xa
         xLitd2RTzDNvHhT/h/IDq83DuBk6RcxqDj6CD6fr61F9zNlZkbZkUtc4GWhAoK5OHs3Z
         P9QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772431923; x=1773036723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ski89AnwaWBeS16R9OsWU00+Wyrl3eVXwV/RiRDK3rk=;
        b=sjNsJ10lnKTQWzXEoGmoFE1wA6nt3Mg7B495lT+3YZm3sxwnvtjqA65T8a76b+ltEb
         wO3GJf/1k85dHhp0u7esIxRAswMUIqeUws6ehD5n3fwSC08q4D0Z+XPy3aRMZ3RB/7nR
         30PPlDaZ4xdRE5cXNbCYIrzwCfeGyHRhyoYYLsy+FiwV1Y8Sn9pSn0cE1x/vh6Txar7R
         xN3qvqYaQTIJKZKJKiPHZIJxKjk9O5MwFN3yIoQcouQkOJhMl5LHgdqiFt4wHWGXxbva
         US6OPkHJiii6wDWPSiT/obCbjd7zg0jwW0JIsIP/kJEYgDcRBickww8eQoNYcnTQnBVf
         +XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431923; x=1773036723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ski89AnwaWBeS16R9OsWU00+Wyrl3eVXwV/RiRDK3rk=;
        b=hnAgVBwI2v1Ybbo5A+JWKDeoO3eKYO7gVlL0oi4rMgisMsh+7t12akIuMUPUFN/lm6
         YbNWRktXEd1ulwf7KzXO2cNe9ktPZENCohsfsMOxc8ppTaO4GhUxYNL3jazhZCvk5Kca
         x2ZSk3H7QpR6QE1tXQ1eje7lx/mQTND5toy2ngA+CXTZMb5xRnvwHv3wRauGj1xMur/O
         5pNqGz28KtEXmCipCS9B1yeF7PxmGEV22vln4XVrJpONYKAEXX6GD5mBeT3QtpldJwpL
         To6jkTonhsJ1/aDgq38sXfkZormjyE/HXR0RBd+5CoHtk3XmOShrYt8FhUmr1ygCzUiF
         /Jyg==
X-Forwarded-Encrypted: i=1; AJvYcCUOP2R1ZZxXnI63PUE9x1m/ay4wx0OTszEKuQGWWIbQcEcEkvGbs7fDD1XHKzK91DDtlsppkiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHbRbSYDuzwwpVldalvUc2ruWmwE8gE5jk18DMSlFOq2jt2nj
	+yDY77BEvsaBwb8IlVVXkwSERMK8Xa2dLSSGdw3rbdlpNXnERyx+zTszPSEU1guaajRaTFHI5n3
	rqQNTjx8c7vpKuGC/UFAiD/ZvebyepY6McJxDdX3G
X-Gm-Gg: ATEYQzy1Z4mBUVUaGKUnT+YGzb8/GItcDKFC6fI0fotBDAc/5fwNo5fTgqsijphfWpK
	KjlzAHrK2nom8VbcRbJWIKNDDhkygqeDliFLi48ojmX5gcFhxwADocIFewDYNWWH5I+c+Kohf7L
	vmzuoKj43JUn/6ptoq/NHtTXjtb+aM9PRd8IHPv5pOTeP02NBzVChWUKsvKZjji4hx//wiJ+gFC
	ZJcLzRi5x6V6EwYVb49o2H30cNjHPE3SD5RKtqUkxeknS/1J1i0op7nQBef65xoAp/ZQfYjssZd
	aW7gQ/0=
X-Received: by 2002:ac8:7f03:0:b0:4f4:de04:2434 with SMTP id
 d75a77b69052e-50752879a78mr134210271cf.11.1772431922428; Sun, 01 Mar 2026
 22:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302060247.7066-1-yuuchihsu@gmail.com>
In-Reply-To: <20260302060247.7066-1-yuuchihsu@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Mar 2026 07:11:51 +0100
X-Gm-Features: AaiRm526yfhoI165ArwRJdmaMofXDk3Rnllb3dqCYKcPLy11uSawO1K2SmrpcQ0
Message-ID: <CANn89i+O5b0xfcP5GLtUopqHz2ppewK9zSr4995jsjCPM+3AFQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: ipv4: fix ARM64 alignment fault in multipath hash seed
To: Yung Chih Su <yuuchihsu@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 269121D360F
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 7:03=E2=80=AFAM Yung Chih Su <yuuchihsu@gmail.com> w=
rote:
>
> `struct sysctl_fib_multipath_hash_seed` contains two u32 fields
> (user_seed and mp_seed), making it an 8-byte structure with a 4-byte
> alignment requirement.
>
> In `fib_multipath_hash_from_keys()`, the code evaluates the entire
> struct atomically via `READ_ONCE()`:
>
>     mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_se=
ed;
>
> While this silently works on GCC by falling back to unaligned regular
> loads which the ARM64 kernel tolerates, it causes a fatal kernel panic
> when compiled with Clang and LTO enabled.
>
> Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
> when CONFIG_LTO=3Dy") strengthens `READ_ONCE()` to use Load-Acquire
> instructions (`ldar` / `ldapr`) to prevent compiler reordering bugs
> under Clang LTO. Since the macro evaluates the full 8-byte struct,
> Clang emits a 64-bit `ldar` instruction. ARM64 architecture strictly
> requires `ldar` to be naturally aligned, thus executing it on a 4-byte
> aligned address triggers a strict Alignment Fault (FSC =3D 0x21).
>
> Fix the read side by moving the `READ_ONCE()` directly to the `u32`
> member, which emits a safe 32-bit `ldar Wn`.
>
> Furthermore, Eric Dumazet pointed out that `WRITE_ONCE()` on the entire
> struct in `proc_fib_multipath_hash_set_seed()` is also flawed. Analysis
> shows that Clang splits this 8-byte write into two separate 32-bit
> `str` instructions. While this avoids an alignment fault, it destroys
> atomicity and exposes a tear-write vulnerability. Fix this by
> explicitly splitting the write into two 32-bit `WRITE_ONCE()`
> operations.
>
> Finally, add the missing `READ_ONCE()` when reading `user_seed` in
> `proc_fib_multipath_hash_seed()` to ensure proper pairing and
> concurrency safety.
>
> Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash seed"=
)
> Suggested-by: Eric Dumazet <edumazet@google.com>

Nit: Use of Suggested-by: implies I made the original suggestion for
this patch (before the V1)
I simply gave a feedback on your V1. The idea of the patch came from you :)

So next time, do not add a "Suggested-by:", as the expected step is
that I add a Reviewed-by tag when I am happy with a new version,
if I see it in time before it is merged.

No need for a V3, this is simply a reminder for your next patches.

> Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

