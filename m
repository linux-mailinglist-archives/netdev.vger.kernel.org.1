Return-Path: <netdev+bounces-298310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id htDIDMgMK2p41wMAu9opvQ
	(envelope-from <netdev+bounces-298310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:30:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63B674BEA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DvDBufCf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298310-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E42E3100166
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442629A309;
	Thu, 11 Jun 2026 19:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5C329C7B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206213; cv=pass; b=dmZdPbAjRRXFUGb58TS2VBHx1Okn/HItCIZAfZNt4n3LbXr4jfBfsJQ94YBTHDdRcjLlf7PyfgioKjtp27WPWK89e6BjHeTm/9SKY8EtFR2LqBVMI8KCFc6srzjP8v1dGnnhEovqJTxaKgNt99Vi+EA/rVP3VyRREZgDXi8igjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206213; c=relaxed/simple;
	bh=aC2SEf6gxVccR4+bsOfFxVe/FP6uXoqMe0hML1JTX4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXLTy8zTmw1U22tVvfVJFlJ6W1/Up1AhOX0vHwtNShuXVAuKM90BF6YL1s6akkvNZhMjI9i03hX+r7j8svsv8f0rj0ImfYOoL0TkbBQ7Wvv2zgjdfw1FJW4hZEsH0aO6K/6unLCY0onBDj60d9D4FIwbe2Hi0KpscP/rqwKrpUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvDBufCf; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5175d339e8bso118161cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206208; cv=none;
        d=google.com; s=arc-20240605;
        b=bfUXp+1LJ18UG/9SOxo2yd4vCBrz90gSYtk9gwnOJxevhf6LWxkH4LAAQUIX6/xfVw
         Wqf6dx1h2nHPlWiLpG8xpMq+XfWG4FVPVeybFE56z/5Ise7WwlMJAwRr/u1G1lrYagU0
         +z+/p0kljXj+6K1RfZe0iRE/2CA9D1nmyMwL02LbFjjCltPGwq7QntEOlC8DWJWszqQj
         FHCownjZZifI3nxw6L1Vcqjhz36SWwmXtPvguZV2T8/PdrrctnMxbBRYCe3hV9KYKjwK
         l9wL2u7tl0PbdwU7l0PxXYFUNYLWWzrU7K/KGIHlFOZ4FnaaAQAb7Z5/V9AfWVgVaKQA
         CYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZE18H5Ui8cnmxCzZ0X7IVvZWtIRFB9ouO8fNlDixovc=;
        fh=mUsIoPxyRp4WkeFUqbDvSjzQugb360kv1Cup+BHpDsY=;
        b=dWE+PxlCY0Ev5f0sDMIhO8gRmsgSOCgvuGKM/bNygGRC4jFGQjbcuzrqfDNlHEK7Y0
         b51eFwllxH874KCoo4prwtB7LEmph3EUoTZT2P2I2ZzrPPc9T+aRwaVfWndf9yE5tprv
         A5lAoDQssGiYi3+6hs/EYRYmI/t0VXQnAuVMMOrhj9BqmDDRawliBqtxVJVWhTccs6vH
         Yp6qAycj26MQ+mO3m4CPKv+9vJcj97U+r9d8GVkHk8/B3cT0H8Ax37Bs/w9b76RndV6A
         9WHh8YD0FZjtTou7HULo5QhHCKUgPHPjtC+m8nSlxGbEzRrXeDvxbPsWUL7vwuBQ/Jen
         qrNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781206208; x=1781811008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE18H5Ui8cnmxCzZ0X7IVvZWtIRFB9ouO8fNlDixovc=;
        b=DvDBufCf+TPCMaC1J0UIn9DoJl+JcJQ8y/5t7+rjcZwQPNNoDTAJ/3Ybb4YBzY/n9A
         MGEv1ioZSMDsfeCHD2c7fsNNP0H0L5AqVpkbbrjpPo6V1nxJLWVquIbZcVvWcqdeSS2p
         Tdf5pVmYow+WRNeJ6uDZ+dbWZEAfEkY2pQDPJkYIoB4Sp76ErWCRDeRQAr+GrItKcllw
         Os9yEoZIEP8YVY/OOtg0JphxkTtO4yZDl1Re52o37qnkR9TzWAsat7o8qDdBQlAqy2FL
         y4oqJGDcjzX7JR19B1YQ6/MadYt+V/RtDwprK/6oFvkNR/GczyH0MoDuNSoK4f0Be4ZL
         yQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206208; x=1781811008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZE18H5Ui8cnmxCzZ0X7IVvZWtIRFB9ouO8fNlDixovc=;
        b=AuyrUfIm205vlEBSH9ZVC1PX0dpAzqA+Ryqtuj/DruFil9gGHcj/1qd9Mur1ZS42WQ
         9dlSkiVeJpQjpk3LkFa08awcooAnSkQmKIjklllt5vx9yrrbYghgilzj/2NYRpCFJU3T
         KxBgqIQOxsetZa56RHcWa6vYk8l6Sk0NX7LDf+/7dlNEfRlzAY6pI2izMnJf2NVAfeHo
         AlWIKbrwj0Ownc776i1/iV8amjlzjue1ALDP54bye4JU2SkPcnnd82A8ItUu5iNFAWd9
         1rzykT8fZXKl5SlTSvFb4y8Apk/1KS2ZtYmV2EJRuCIf8vK93WXc1lBdlxbI+DTq/0Gs
         zHRA==
X-Forwarded-Encrypted: i=1; AFNElJ8W+/yFhcBmOktJLLQAcd9nCeb5dAmXqAWlOmjWrcbb+jbaPskY+G+acxNYRlK15KuvjruW29A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8kd1/62CHMRklCdgAwvKvUuxIOyWcu5vhJpZZkFKQpfiKpIV
	WYqwxOL9u3xAqdd9xM9BZSkV5eqaSRDbZpCp93+qTGA+Zo8XU/tBsUTCEEsfL7N0ohEX/hWoH3R
	ZBwIiLeyYY0Q+tT7cIHd4uyXTSBEVK8xiBuvTwLom
X-Gm-Gg: Acq92OEcD95ZNnJMDuNZjlGPy+HZmQzirlz9XaeZci9f2kYD9L7j5GCApAlyHSkFlt/
	wXKKeD5Y9snmRu4reLmQ6kr5NKiExcF9w/2trLsUWl8kS/agLEg3GONm3hdNpZiIEsL2ccI8GXL
	byuvhFSjEasm4D+lsCH+ufNGESCArFYSgoJFOd08Wtvp26fmsm+3AS1NUFsq8hhjnsSyHQkoZp5
	4twtPjc/ZpsZl4pkbaxxb9euBi/lGn2T2HLdUsY4tAoZVrdI/h6uEni2+vAp613ZNlfNc0753Fv
	h3ADoiE/x3WG0y3gDYwhalA6tCJeSGkEvQUV
X-Received: by 2002:a05:622a:2293:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-517fb24f55dmr1423531cf.19.1781206206972; Thu, 11 Jun 2026
 12:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230411.617DD5E7@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230411.617DD5E7@davehans-spike.ostc.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jun 2026 12:29:54 -0700
X-Gm-Features: AVVi8Ce8DHD1TRde_gfa50pisjPH2maXlW5G_8M-eoDp8baullLXePwybPMEt1s
Message-ID: <CAJuCfpGbz1_05GkyaoEpnhbd4s6+-U_ksUA=wYfRPivq2iFBHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: Make per-VMA locks available universally
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298310-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E63B674BEA

On Wed, Jun 10, 2026 at 4:04=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> The per-VMA locks have been around for several years. They've had some
> bugs worked out of them and have seen quite wide use. However, they
> are still only available when architectures explicitly enable them.
> Remove the conditional compilation around the per-VMA locks, making
> them available on all architectures and configs.
>
> The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
> when the architecture started using per-VMA locks in the fault
> handler. But, contrary to the naming, the Kconfig option does not
> really indicate whether the architecture supports per-VMA locks or
> not. It is more of a marker for whether the architecture is likely to
> benefit from per-VMA locks.

Correct. Originally per-VMA locks were used only in the page fault
handling path and architectures that used them in that path would set
ARCH_SUPPORTS_PER_VMA_LOCK. Over time these locks are used in more
places, so ARCH_SUPPORTS_PER_VMA_LOCK lost its meaning and indeed can
be removed.


>
> To me, the most important thing side-effect of universal availability
> is letting per-VMA locks be used in SMP=3Dn configs. This lets us use
> per-VMA locking in all x86 code without fallbacks.
>
> Overall, this just generally makes the kernel simpler. Just look at
> the diffstat. It also opens the door to users that want to use the
> per-VMA locks in common code. Doing *that* brings additional
> simplifications.
>
> The downside of this is adding some fields to vm_area_struct and
> mm_struct. There are likely ways to optimize this, especially for
> things like SMP=3Dn configs. For now, do the simplest thing: use the
> same implementation everywhere.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
>
> --
>
> Changes from v1:
>  * Remove a bunch of left over CONFIG_PER_VMA_LOCKs
>  * Trim some speculation out of the changelog
> ---
>
>  b/arch/arm/Kconfig                       |    1
>  b/arch/arm64/Kconfig                     |    1
>  b/arch/loongarch/Kconfig                 |    1
>  b/arch/powerpc/platforms/powernv/Kconfig |    1
>  b/arch/powerpc/platforms/pseries/Kconfig |    1
>  b/arch/riscv/Kconfig                     |    1
>  b/arch/s390/Kconfig                      |    1
>  b/arch/x86/Kconfig                       |    2 -
>  b/fs/proc/internal.h                     |    2 -
>  b/fs/proc/task_mmu.c                     |   51 ------------------------=
----
>  b/include/linux/mm.h                     |   12 ------
>  b/include/linux/mm_types.h               |    7 ---
>  b/include/linux/mmap_lock.h              |   48 ------------------------=
---
>  b/kernel/bpf/task_iter.c                 |    5 --
>  b/kernel/fork.c                          |    2 -
>  b/mm/Kconfig                             |   13 -------
>  b/mm/Kconfig.debug                       |    1
>  b/mm/debug.c                             |    4 --
>  b/mm/init-mm.c                           |    2 -
>  b/mm/memory.c                            |    2 -
>  b/mm/mmap_lock.c                         |   24 -------------
>  b/mm/pagewalk.c                          |    2 -
>  b/mm/rmap.c                              |    2 -
>  b/mm/userfaultfd.c                       |   55 ------------------------=
-------
>  b/rust/kernel/mm.rs                      |    7 ---
>  b/tools/testing/vma/include/dup.h        |    4 --
>  b/tools/testing/vma/vma_internal.h       |    1
>  27 files changed, 1 insertion(+), 252 deletions(-)
>
> diff -puN arch/arm64/Kconfig~unconditional-vma-locks arch/arm64/Kconfig
> --- a/arch/arm64/Kconfig~unconditional-vma-locks        2026-06-10 15:57:=
53.491348630 -0700
> +++ b/arch/arm64/Kconfig        2026-06-10 15:57:54.069369179 -0700
> @@ -80,7 +80,6 @@ config ARM64
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select ARCH_SUPPORTS_PAGE_TABLE_CHECK
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>         select ARCH_SUPPORTS_RT
>         select ARCH_SUPPORTS_SCHED_SMT
> diff -puN arch/arm/Kconfig~unconditional-vma-locks arch/arm/Kconfig
> --- a/arch/arm/Kconfig~unconditional-vma-locks  2026-06-10 15:57:53.49934=
8914 -0700
> +++ b/arch/arm/Kconfig  2026-06-10 15:57:54.070369215 -0700
> @@ -41,7 +41,6 @@ config ARM
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_CFI
>         select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_RT
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
> diff -puN arch/loongarch/Kconfig~unconditional-vma-locks arch/loongarch/K=
config
> --- a/arch/loongarch/Kconfig~unconditional-vma-locks    2026-06-10 15:57:=
53.542350439 -0700
> +++ b/arch/loongarch/Kconfig    2026-06-10 15:57:54.070369215 -0700
> @@ -68,7 +68,6 @@ config LOONGARCH
>         select ARCH_SUPPORTS_LTO_CLANG_THIN
>         select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>         select ARCH_SUPPORTS_NUMA_BALANCING if NUMA
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_RT
>         select ARCH_SUPPORTS_SCHED_SMT if SMP
>         select ARCH_SUPPORTS_SCHED_MC  if SMP
> diff -puN arch/powerpc/platforms/powernv/Kconfig~unconditional-vma-locks =
arch/powerpc/platforms/powernv/Kconfig
> --- a/arch/powerpc/platforms/powernv/Kconfig~unconditional-vma-locks    2=
026-06-10 15:57:53.544350510 -0700
> +++ b/arch/powerpc/platforms/powernv/Kconfig    2026-06-10 15:57:54.07036=
9215 -0700
> @@ -17,7 +17,6 @@ config PPC_POWERNV
>         select PPC_DOORBELL
>         select MMU_NOTIFIER
>         select FORCE_SMP
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select PPC_RADIX_BROADCAST_TLBIE if PPC_RADIX_MMU
>         default y
>
> diff -puN arch/powerpc/platforms/pseries/Kconfig~unconditional-vma-locks =
arch/powerpc/platforms/pseries/Kconfig
> --- a/arch/powerpc/platforms/pseries/Kconfig~unconditional-vma-locks    2=
026-06-10 15:57:53.552350794 -0700
> +++ b/arch/powerpc/platforms/pseries/Kconfig    2026-06-10 15:57:54.07036=
9215 -0700
> @@ -23,7 +23,6 @@ config PPC_PSERIES
>         select HOTPLUG_CPU
>         select FORCE_SMP
>         select SWIOTLB
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select PPC_RADIX_BROADCAST_TLBIE if PPC_RADIX_MMU
>         default y
>
> diff -puN arch/riscv/Kconfig~unconditional-vma-locks arch/riscv/Kconfig
> --- a/arch/riscv/Kconfig~unconditional-vma-locks        2026-06-10 15:57:=
53.559351043 -0700
> +++ b/arch/riscv/Kconfig        2026-06-10 15:57:54.070369215 -0700
> @@ -70,7 +70,6 @@ config RISCV
>         select ARCH_SUPPORTS_LTO_CLANG_THIN
>         select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>         select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> -       select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
>         select ARCH_SUPPORTS_RT
>         select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
>         select ARCH_SUPPORTS_SCHED_MC if SMP
> diff -puN arch/s390/Kconfig~unconditional-vma-locks arch/s390/Kconfig
> --- a/arch/s390/Kconfig~unconditional-vma-locks 2026-06-10 15:57:53.57135=
1470 -0700
> +++ b/arch/s390/Kconfig 2026-06-10 15:57:54.071369250 -0700
> @@ -153,7 +153,6 @@ config S390
>         select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select ARCH_SUPPORTS_PAGE_TABLE_CHECK
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select ARCH_USE_SYM_ANNOTATIONS
> diff -puN arch/x86/Kconfig~unconditional-vma-locks arch/x86/Kconfig
> --- a/arch/x86/Kconfig~unconditional-vma-locks  2026-06-10 15:57:53.57735=
1684 -0700
> +++ b/arch/x86/Kconfig  2026-06-10 15:57:54.071369250 -0700
> @@ -27,7 +27,6 @@ config X86_64
>         select ARCH_HAS_GIGANTIC_PAGE
>         select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> -       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>         select HAVE_ARCH_SOFT_DIRTY
>         select MODULES_USE_ELF_RELA
> @@ -1885,7 +1884,6 @@ config X86_USER_SHADOW_STACK
>         bool "X86 userspace shadow stack"
>         depends on AS_WRUSS
>         depends on X86_64
> -       depends on PER_VMA_LOCK
>         select ARCH_USES_HIGH_VMA_FLAGS
>         select ARCH_HAS_USER_SHADOW_STACK
>         select X86_CET
> diff -puN fs/proc/internal.h~unconditional-vma-locks fs/proc/internal.h
> --- a/fs/proc/internal.h~unconditional-vma-locks        2026-06-10 15:57:=
53.579351755 -0700
> +++ b/fs/proc/internal.h        2026-06-10 15:57:54.071369250 -0700
> @@ -382,10 +382,8 @@ struct mem_size_stats;
>
>  struct proc_maps_locking_ctx {
>         struct mm_struct *mm;
> -#ifdef CONFIG_PER_VMA_LOCK
>         bool mmap_locked;
>         struct vm_area_struct *locked_vma;
> -#endif
>  };
>
>  struct proc_maps_private {
> diff -puN fs/proc/task_mmu.c~unconditional-vma-locks fs/proc/task_mmu.c
> --- a/fs/proc/task_mmu.c~unconditional-vma-locks        2026-06-10 15:57:=
53.594352288 -0700
> +++ b/fs/proc/task_mmu.c        2026-06-10 15:57:54.072369286 -0700
> @@ -130,8 +130,6 @@ static void release_task_mempolicy(struc
>  }
>  #endif
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -

A bunch of these helpers can be removed too but I'll do that cleanup
as a followup. Let's keep this one simple.

>  static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
>  {
>         lock_ctx->locked_vma =3D NULL;
> @@ -213,33 +211,6 @@ static inline bool fallback_to_mmap_lock
>         return true;
>  }
>
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static inline bool lock_vma_range(struct seq_file *m,
> -                                 struct proc_maps_locking_ctx *lock_ctx)
> -{
> -       return mmap_read_lock_killable(lock_ctx->mm) =3D=3D 0;
> -}
> -
> -static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_c=
tx)
> -{
> -       mmap_read_unlock(lock_ctx->mm);
> -}
> -
> -static struct vm_area_struct *get_next_vma(struct proc_maps_private *pri=
v,
> -                                          loff_t last_pos)
> -{
> -       return vma_next(&priv->iter);
> -}
> -
> -static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
> -                                        loff_t pos)
> -{
> -       return false;
> -}
> -
> -#endif /* CONFIG_PER_VMA_LOCK */
> -
>  static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *p=
pos)
>  {
>         struct proc_maps_private *priv =3D m->private;
> @@ -527,8 +498,6 @@ static int pid_maps_open(struct inode *i
>                 PROCMAP_QUERY_VMA_FLAGS                         \
>  )
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -
>  static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
>  {
>         reset_lock_ctx(lock_ctx);
> @@ -581,26 +550,6 @@ static struct vm_area_struct *query_vma_
>         return vma;
>  }
>
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> -{
> -       return mmap_read_lock_killable(lock_ctx->mm);
> -}
> -
> -static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> -{
> -       mmap_read_unlock(lock_ctx->mm);
> -}
> -
> -static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_lo=
cking_ctx *lock_ctx,
> -                                                    unsigned long addr)
> -{
> -       return find_vma(lock_ctx->mm, addr);
> -}
> -
> -#endif  /* CONFIG_PER_VMA_LOCK */
> -
>  static struct vm_area_struct *query_matching_vma(struct proc_maps_lockin=
g_ctx *lock_ctx,
>                                                  unsigned long addr, u32 =
flags)
>  {
> diff -puN include/linux/mmap_lock.h~unconditional-vma-locks include/linux=
/mmap_lock.h
> --- a/include/linux/mmap_lock.h~unconditional-vma-locks 2026-06-10 15:57:=
53.599352466 -0700
> +++ b/include/linux/mmap_lock.h 2026-06-10 15:57:54.072369286 -0700
> @@ -76,8 +76,6 @@ static inline void mmap_assert_write_loc
>         rwsem_assert_held_write(&mm->mmap_lock);
>  }
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -
>  #ifdef CONFIG_LOCKDEP
>  #define __vma_lockdep_map(vma) (&vma->vmlock_dep_map)
>  #else
> @@ -484,52 +482,6 @@ struct vm_area_struct *lock_next_vma(str
>                                      struct vma_iterator *iter,
>                                      unsigned long address);
>
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> -static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> -static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
> -
> -static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, u=
nsigned int *seq)
> -{
> -       return false;
> -}
> -
> -static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsig=
ned int seq)
> -{
> -       return true;
> -}
> -static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_=
refcnt) {}
> -static inline void vma_end_read(struct vm_area_struct *vma) {}
> -static inline void vma_start_write(struct vm_area_struct *vma) {}
> -static inline __must_check
> -int vma_start_write_killable(struct vm_area_struct *vma) { return 0; }
> -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> -               { mmap_assert_write_locked(vma->vm_mm); }
> -static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> -static inline void vma_assert_detached(struct vm_area_struct *vma) {}
> -static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> -static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> -
> -static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct=
 *mm,
> -               unsigned long address)
> -{
> -       return NULL;
> -}
> -
> -static inline void vma_assert_locked(struct vm_area_struct *vma)
> -{
> -       mmap_assert_locked(vma->vm_mm);
> -}
> -
> -static inline void vma_assert_stabilised(struct vm_area_struct *vma)
> -{
> -       /* If no VMA locks, then either mmap lock suffices to stabilise. =
*/
> -       mmap_assert_locked(vma->vm_mm);
> -}
> -
> -#endif /* CONFIG_PER_VMA_LOCK */
> -
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
> diff -puN include/linux/mm.h~unconditional-vma-locks include/linux/mm.h
> --- a/include/linux/mm.h~unconditional-vma-locks        2026-06-10 15:57:=
53.745357660 -0700
> +++ b/include/linux/mm.h        2026-06-10 15:57:54.073369321 -0700
> @@ -890,7 +890,6 @@ static inline void vma_numab_state_free(
>   * These must be here rather than mmap_lock.h as dependent on vm_fault t=
ype,
>   * declared in this header.
>   */
> -#ifdef CONFIG_PER_VMA_LOCK
>  static inline void release_fault_lock(struct vm_fault *vmf)
>  {
>         if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> @@ -906,17 +905,6 @@ static inline void assert_fault_locked(c
>         else
>                 mmap_assert_locked(vmf->vma->vm_mm);
>  }
> -#else
> -static inline void release_fault_lock(struct vm_fault *vmf)
> -{
> -       mmap_read_unlock(vmf->vma->vm_mm);
> -}
> -
> -static inline void assert_fault_locked(const struct vm_fault *vmf)
> -{
> -       mmap_assert_locked(vmf->vma->vm_mm);
> -}
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>  static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
>  {
> diff -puN include/linux/mm_types.h~unconditional-vma-locks include/linux/=
mm_types.h
> --- a/include/linux/mm_types.h~unconditional-vma-locks  2026-06-10 15:57:=
53.763358300 -0700
> +++ b/include/linux/mm_types.h  2026-06-10 15:57:54.074369357 -0700
> @@ -959,7 +959,6 @@ struct vm_area_struct {
>                 vma_flags_t flags;
>         };
>
> -#ifdef CONFIG_PER_VMA_LOCK
>         /*
>          * Can only be written (using WRITE_ONCE()) while holding both:
>          *  - mmap_lock (in write mode)
> @@ -975,7 +974,7 @@ struct vm_area_struct {
>          * slowpath.
>          */
>         unsigned int vm_lock_seq;
> -#endif
> +
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
>          * list, after a COW of one of the file pages.  A MAP_SHARED vma
> @@ -1007,7 +1006,6 @@ struct vm_area_struct {
>  #ifdef CONFIG_NUMA_BALANCING
>         struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
>  #endif
> -#ifdef CONFIG_PER_VMA_LOCK
>         /*
>          * Used to keep track of firstly, whether the VMA is attached, se=
condly,
>          * if attached, how many read locks are taken, and thirdly, if th=
e
> @@ -1050,7 +1048,6 @@ struct vm_area_struct {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map vmlock_dep_map;
>  #endif
> -#endif
>         /*
>          * For areas with an address space and backing store,
>          * linkage into the address_space->i_mmap interval tree.
> @@ -1249,7 +1246,6 @@ struct mm_struct {
>                                           * init_mm.mmlist, and are prote=
cted
>                                           * by mmlist_lock
>                                           */
> -#ifdef CONFIG_PER_VMA_LOCK
>                 struct rcuwait vma_writer_wait;
>                 /*
>                  * This field has lock-like semantics, meaning it is some=
times
> @@ -1269,7 +1265,6 @@ struct mm_struct {
>                  * mmap_lock.
>                  */
>                 seqcount_t mm_lock_seq;
> -#endif
>  #ifdef CONFIG_FUTEX_PRIVATE_HASH
>                 struct mutex                    futex_hash_lock;
>                 struct futex_private_hash       __rcu *futex_phash;
> diff -puN kernel/bpf/task_iter.c~unconditional-vma-locks kernel/bpf/task_=
iter.c
> --- a/kernel/bpf/task_iter.c~unconditional-vma-locks    2026-06-10 15:57:=
53.773358655 -0700
> +++ b/kernel/bpf/task_iter.c    2026-06-10 15:57:54.074369357 -0700
> @@ -835,11 +835,6 @@ __bpf_kfunc int bpf_iter_task_vma_new(st
>         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(st=
ruct bpf_iter_task_vma));
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __al=
ignof__(struct bpf_iter_task_vma));
>
> -       if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> -               kit->data =3D NULL;
> -               return -EOPNOTSUPP;
> -       }
> -
>         /*
>          * Reject irqs-disabled contexts including NMI. Operations used
>          * by _next() and _destroy() (vma_end_read, fput, bpf_iter_mmput_=
async)
> diff -puN kernel/fork.c~unconditional-vma-locks kernel/fork.c
> --- a/kernel/fork.c~unconditional-vma-locks     2026-06-10 15:57:53.78335=
9011 -0700
> +++ b/kernel/fork.c     2026-06-10 15:57:54.074369357 -0700
> @@ -1067,9 +1067,7 @@ static void mmap_init_lock(struct mm_str
>  {
>         init_rwsem(&mm->mmap_lock);
>         mm_lock_seqcount_init(mm);
> -#ifdef CONFIG_PER_VMA_LOCK
>         rcuwait_init(&mm->vma_writer_wait);
> -#endif
>  }
>
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struc=
t *p,
> diff -puN mm/debug.c~unconditional-vma-locks mm/debug.c
> --- a/mm/debug.c~unconditional-vma-locks        2026-06-10 15:57:53.78535=
9082 -0700
> +++ b/mm/debug.c        2026-06-10 15:57:54.075369392 -0700
> @@ -157,17 +157,13 @@ void dump_vma(const struct vm_area_struc
>         pr_emerg("vma %px start %px end %px mm %px\n"
>                 "prot %lx anon_vma %px vm_ops %px\n"
>                 "pgoff %lx file %px private_data %px\n"
> -#ifdef CONFIG_PER_VMA_LOCK
>                 "refcnt %x\n"
> -#endif
>                 "flags: %#lx(%pGv)\n",
>                 vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_=
mm,
>                 (unsigned long)pgprot_val(vma->vm_page_prot),
>                 vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
>                 vma->vm_file, vma->vm_private_data,
> -#ifdef CONFIG_PER_VMA_LOCK
>                 refcount_read(&vma->vm_refcnt),
> -#endif
>                 vma->vm_flags, &vma->vm_flags);
>  }
>  EXPORT_SYMBOL(dump_vma);
> diff -puN mm/init-mm.c~unconditional-vma-locks mm/init-mm.c
> --- a/mm/init-mm.c~unconditional-vma-locks      2026-06-10 15:57:53.80835=
9899 -0700
> +++ b/mm/init-mm.c      2026-06-10 15:57:54.075369392 -0700
> @@ -39,10 +39,8 @@ struct mm_struct init_mm =3D {
>         .page_table_lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.page_table_loc=
k),
>         .arg_lock       =3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>         .mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
> -#ifdef CONFIG_PER_VMA_LOCK
>         .vma_writer_wait =3D __RCUWAIT_INITIALIZER(init_mm.vma_writer_wai=
t),
>         .mm_lock_seq    =3D SEQCNT_ZERO(init_mm.mm_lock_seq),
> -#endif
>         .user_ns        =3D &init_user_ns,
>  #ifdef CONFIG_SCHED_MM_CID
>         .mm_cid.lock =3D __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
> diff -puN mm/Kconfig~unconditional-vma-locks mm/Kconfig
> --- a/mm/Kconfig~unconditional-vma-locks        2026-06-10 15:57:53.81636=
0183 -0700
> +++ b/mm/Kconfig        2026-06-10 15:57:54.075369392 -0700
> @@ -1394,19 +1394,6 @@ config LRU_GEN_STATS
>  config LRU_GEN_WALKS_MMU
>         def_bool y
>         depends on LRU_GEN && ARCH_HAS_HW_PTE_YOUNG
> -# }
> -
> -config ARCH_SUPPORTS_PER_VMA_LOCK
> -       def_bool n
> -
> -config PER_VMA_LOCK
> -       def_bool y
> -       depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> -       help
> -         Allow per-vma locking during page fault handling.
> -
> -         This feature allows locking each virtual memory area separately=
 when
> -         handling page faults instead of taking mmap_lock.
>
>  config LOCK_MM_AND_FIND_VMA
>         bool
> diff -puN mm/Kconfig.debug~unconditional-vma-locks mm/Kconfig.debug
> --- a/mm/Kconfig.debug~unconditional-vma-locks  2026-06-10 15:57:53.82036=
0326 -0700
> +++ b/mm/Kconfig.debug  2026-06-10 15:57:54.075369392 -0700
> @@ -310,7 +310,6 @@ config DEBUG_KMEMLEAK_VERBOSE
>
>  config PER_VMA_LOCK_STATS
>         bool "Statistics for per-vma locks"
> -       depends on PER_VMA_LOCK
>         help
>           Say Y here to enable success, retry and failure counters of pag=
e
>           faults handled under protection of per-vma locks. When enabled,=
 the
> diff -puN mm/memory.c~unconditional-vma-locks mm/memory.c
> --- a/mm/memory.c~unconditional-vma-locks       2026-06-10 15:57:53.83036=
0681 -0700
> +++ b/mm/memory.c       2026-06-10 15:57:54.076369428 -0700
> @@ -6659,7 +6659,6 @@ static vm_fault_t sanitize_fault_flags(s
>                                  !is_cow_mapping(vma->vm_flags)))
>                         return VM_FAULT_SIGSEGV;
>         }
> -#ifdef CONFIG_PER_VMA_LOCK
>         /*
>          * Per-VMA locks can't be used with FAULT_FLAG_RETRY_NOWAIT becau=
se of
>          * the assumption that lock is dropped on VM_FAULT_RETRY.
> @@ -6668,7 +6667,6 @@ static vm_fault_t sanitize_fault_flags(s
>                         (FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)) =
=3D=3D
>                         (FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)))
>                 return VM_FAULT_SIGSEGV;
> -#endif
>
>         return 0;
>  }
> diff -puN mm/mmap_lock.c~unconditional-vma-locks mm/mmap_lock.c
> --- a/mm/mmap_lock.c~unconditional-vma-locks    2026-06-10 15:57:53.83436=
0824 -0700
> +++ b/mm/mmap_lock.c    2026-06-10 15:57:54.077369463 -0700
> @@ -43,9 +43,6 @@ void __mmap_lock_do_trace_released(struc
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */
>
> -#ifdef CONFIG_MMU
> -#ifdef CONFIG_PER_VMA_LOCK
> -
>  /* State shared across __vma_[start, end]_exclude_readers. */
>  struct vma_exclude_readers_state {
>         /* Input parameters. */
> @@ -431,7 +428,6 @@ fallback:
>
>         return vma;
>  }
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
>  #include <linux/extable.h>
> @@ -548,23 +544,3 @@ fail:
>         return NULL;
>  }
>  #endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
> -
> -#else /* CONFIG_MMU */
> -
> -/*
> - * At least xtensa ends up having protection faults even with no
> - * MMU.. No stack expansion, at least.
> - */
> -struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> -                       unsigned long addr, struct pt_regs *regs)
> -{
> -       struct vm_area_struct *vma;
> -
> -       mmap_read_lock(mm);
> -       vma =3D vma_lookup(mm, addr);
> -       if (!vma)
> -               mmap_read_unlock(mm);
> -       return vma;
> -}

Might this removal break CONFIG_MMU=3Dn && CONFIG_LOCK_MM_AND_FIND_VMA=3Dn =
case?


> -
> -#endif /* CONFIG_MMU */
> diff -puN mm/pagewalk.c~unconditional-vma-locks mm/pagewalk.c
> --- a/mm/pagewalk.c~unconditional-vma-locks     2026-06-10 15:57:53.85136=
1429 -0700
> +++ b/mm/pagewalk.c     2026-06-10 15:57:54.077369463 -0700
> @@ -446,7 +446,6 @@ static inline void process_mm_walk_lock(
>  static inline void process_vma_walk_lock(struct vm_area_struct *vma,
>                                          enum page_walk_lock walk_lock)
>  {
> -#ifdef CONFIG_PER_VMA_LOCK
>         switch (walk_lock) {
>         case PGWALK_WRLOCK:
>                 vma_start_write(vma);
> @@ -461,7 +460,6 @@ static inline void process_vma_walk_lock
>                 /* PGWALK_RDLOCK is handled by process_mm_walk_lock */
>                 break;
>         }
> -#endif
>  }
>
>  /*
> diff -puN mm/rmap.c~unconditional-vma-locks mm/rmap.c
> --- a/mm/rmap.c~unconditional-vma-locks 2026-06-10 15:57:54.018367366 -07=
00
> +++ b/mm/rmap.c 2026-06-10 15:57:54.077369463 -0700
> @@ -260,11 +260,9 @@ static void check_anon_vma_clone(struct
>         /* For the anon_vma to be compatible, it can only be singular. */
>         VM_WARN_ON_ONCE(operation =3D=3D VMA_OP_MERGE_UNFAULTED &&
>                         !list_is_singular(&src->anon_vma_chain));
> -#ifdef CONFIG_PER_VMA_LOCK
>         /* Only merging an unfaulted VMA leaves the destination attached.=
 */
>         VM_WARN_ON_ONCE(operation !=3D VMA_OP_MERGE_UNFAULTED &&
>                         vma_is_attached(dst));
> -#endif
>  }
>
>  static void maybe_reuse_anon_vma(struct vm_area_struct *dst,
> diff -puN mm/userfaultfd.c~unconditional-vma-locks mm/userfaultfd.c
> --- a/mm/userfaultfd.c~unconditional-vma-locks  2026-06-10 15:57:54.04936=
8468 -0700
> +++ b/mm/userfaultfd.c  2026-06-10 15:57:54.078369499 -0700
> @@ -104,7 +104,6 @@ struct vm_area_struct *find_vma_and_prep
>         return vma;
>  }
>
> -#ifdef CONFIG_PER_VMA_LOCK
>  /*
>   * uffd_lock_vma() - Lookup and lock vma corresponding to @address.
>   * @mm: mm to search vma in.
> @@ -164,34 +163,6 @@ static void uffd_mfill_unlock(struct vm_
>         vma_end_read(vma);
>  }
>
> -#else
> -
> -static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
> -                                             unsigned long dst_start,
> -                                             unsigned long len)
> -{
> -       struct vm_area_struct *dst_vma;
> -
> -       mmap_read_lock(dst_mm);
> -       dst_vma =3D find_vma_and_prepare_anon(dst_mm, dst_start);
> -       if (IS_ERR(dst_vma))
> -               goto out_unlock;
> -
> -       if (validate_dst_vma(dst_vma, dst_start + len))
> -               return dst_vma;
> -
> -       dst_vma =3D ERR_PTR(-ENOENT);
> -out_unlock:
> -       mmap_read_unlock(dst_mm);
> -       return dst_vma;
> -}
> -
> -static void uffd_mfill_unlock(struct vm_area_struct *vma)
> -{
> -       mmap_read_unlock(vma->vm_mm);
> -}
> -#endif
> -
>  static void mfill_put_vma(struct mfill_state *state)
>  {
>         if (!state->vma)
> @@ -1672,7 +1643,6 @@ out_success:
>         return 0;
>  }
>
> -#ifdef CONFIG_PER_VMA_LOCK
>  static int uffd_move_lock(struct mm_struct *mm,
>                           unsigned long dst_start,
>                           unsigned long src_start,
> @@ -1747,31 +1717,6 @@ static void uffd_move_unlock(struct vm_a
>                 vma_end_read(dst_vma);
>  }
>
> -#else
> -
> -static int uffd_move_lock(struct mm_struct *mm,
> -                         unsigned long dst_start,
> -                         unsigned long src_start,
> -                         struct vm_area_struct **dst_vmap,
> -                         struct vm_area_struct **src_vmap)
> -{
> -       int err;
> -
> -       mmap_read_lock(mm);
> -       err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
> -       if (err)
> -               mmap_read_unlock(mm);
> -       return err;
> -}
> -
> -static void uffd_move_unlock(struct vm_area_struct *dst_vma,
> -                            struct vm_area_struct *src_vma)
> -{
> -       mmap_assert_locked(src_vma->vm_mm);
> -       mmap_read_unlock(dst_vma->vm_mm);
> -}
> -#endif
> -
>  /**
>   * move_pages - move arbitrary anonymous pages of an existing vma
>   * @ctx: pointer to the userfaultfd context
> diff -puN rust/kernel/mm.rs~unconditional-vma-locks rust/kernel/mm.rs
> --- a/rust/kernel/mm.rs~unconditional-vma-locks 2026-06-10 15:57:54.05136=
8539 -0700
> +++ b/rust/kernel/mm.rs 2026-06-10 15:57:54.078369499 -0700
> @@ -174,7 +174,6 @@ impl MmWithUser {
>      /// When per-vma locks are disabled, this always returns `None`.
>      #[inline]
>      pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadG=
uard<'_>> {
> -        #[cfg(CONFIG_PER_VMA_LOCK)]
>          {
>              // SAFETY: Calling `bindings::lock_vma_under_rcu` is always =
okay given an mm where
>              // `mm_users` is non-zero.
> @@ -188,12 +187,6 @@ impl MmWithUser {
>                  });
>              }
>          }
> -
> -        // Silence warnings about unused variables.
> -        #[cfg(not(CONFIG_PER_VMA_LOCK))]
> -        let _ =3D vma_addr;
> -
> -        None
>      }
>
>      /// Lock the mmap read lock.
> diff -puN tools/testing/vma/include/dup.h~unconditional-vma-locks tools/t=
esting/vma/include/dup.h
> --- a/tools/testing/vma/include/dup.h~unconditional-vma-locks   2026-06-1=
0 15:57:54.064369001 -0700
> +++ b/tools/testing/vma/include/dup.h   2026-06-10 15:57:54.078369499 -07=
00
> @@ -569,7 +569,6 @@ struct vm_area_struct {
>                 vma_flags_t flags;
>         };
>
> -#ifdef CONFIG_PER_VMA_LOCK
>         /*
>          * Can only be written (using WRITE_ONCE()) while holding both:
>          *  - mmap_lock (in write mode)
> @@ -585,7 +584,6 @@ struct vm_area_struct {
>          * slowpath.
>          */
>         unsigned int vm_lock_seq;
> -#endif
>
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
> @@ -618,10 +616,8 @@ struct vm_area_struct {
>  #ifdef CONFIG_NUMA_BALANCING
>         struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
>  #endif
> -#ifdef CONFIG_PER_VMA_LOCK
>         /* Unstable RCU readers are allowed to read this. */
>         refcount_t vm_refcnt;
> -#endif
>         /*
>          * For areas with an address space and backing store,
>          * linkage into the address_space->i_mmap interval tree.
> diff -puN tools/testing/vma/vma_internal.h~unconditional-vma-locks tools/=
testing/vma/vma_internal.h
> --- a/tools/testing/vma/vma_internal.h~unconditional-vma-locks  2026-06-1=
0 15:57:54.066369072 -0700
> +++ b/tools/testing/vma/vma_internal.h  2026-06-10 15:57:54.078369499 -07=
00
> @@ -15,7 +15,6 @@
>  #include <stdlib.h>
>
>  #define CONFIG_MMU
> -#define CONFIG_PER_VMA_LOCK
>
>  #ifdef __CONCAT
>  #undef __CONCAT
> _

