Return-Path: <netdev+bounces-260785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OI/CiSonmmrWgQAu9opvQ
	(envelope-from <netdev+bounces-260785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92596193AB4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82D0E30038F3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F22EFDA1;
	Wed, 25 Feb 2026 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2a7lISA9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296732F4A0C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005409; cv=pass; b=a7cf0fS7xBxGGta0dDQVSXM46j8pl/BXBzGK1Hq9LWtBch3Ubdmul+pZCYWnvfNh6grJaA+WnO0WFAGJ1u6G58rChe4ZX2HJDy9DTCvSvY/ToKY5Q0Q48Gpzn7EJJlCCKcIG/L/MhIYC0jl4ZQCrXgl/DfyyKe3D8AM+tDEMfhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005409; c=relaxed/simple;
	bh=pD5qgSyj+M+ZKRt0xRcrtKgBujxN495BZuFlw6/RleE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K01rOGYXsEhJvMRqx95KQn08vxhYqgjRx9K8wEmPNp0SwTDKD8pryBWrT3tzPj9ELZJLQVSJb6bZUcHLvVpAd/pO0yCQ6sAm4YjQ3Mw5xW/gx6zprK0HzWlxs+9Qbjw1Rq2fzq8B0z34kVFHKcT5QvowgXVVndfvCfF7nccuIcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2a7lISA9; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1277d379936so1566945c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772005407; cv=none;
        d=google.com; s=arc-20240605;
        b=BmBqOeDMoTqCmBiwclQSk3EB/Bi/nS1kRrFf9HaNTpgZsp+xPNQyTulh0642V3+WfM
         r5EMk9iXJzd/lenuJwBFSpweBc2dB2OGG96FZSOy8LLW4rHntIKejbm9gl/QeI0fqM4D
         zCR6SJR+XUwI3nkyB2WbQaXH2HOSk55CDBe/2pZx/VI9QoYKyubBPMcHK7XmT4jeZVZ7
         eDJIbz2I7RANiXpRWgNHUWaKHx7hdyZouMiWQlYXoKQsX2c3lum5FeS2EqI6MxI+aowc
         Vfew59bUFurmX+r30Y3ljsI3tdj1oEOe3jGidX2LY8EAIy2TPDmQpVQf4uaPteJwm5ui
         tAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31tKxIamTKYA+kb9Yej+epsVr+m056uORYnUnfM4tIQ=;
        fh=XgIqm8f/4rP5JqkRLrBgw7sDDwws/HvLfnTtZ8roUo8=;
        b=eekwfJ40ZeE7OSi3L3Ylv+em6L3WUgNBR9+dUQbBEiyxUFrEXuJNV0trTEQP9Eixth
         BPcjHortjzcf9ITNv5YnmmE6F+ikEb8ROxccy/jdgfj1qFZyR2NAlyG/AXZ5xCd+fxX9
         OLR87O+sBYP/Y0Bbz6wouxJVCUgegvSzKCSqMDy1HOYFDsh9RJwqPe9KexyVVu9abhNJ
         XyF8gsT/gDA5lsy+OoRV7PQWJGdmQ67yLoOw2zgjbV64vx425mr/xp5eIlLMZveb5bPS
         GNE43e+gsXBWYKXNhBfoluNO6vMBnbgcB8W9QSGjtsrKw6n35dm1Fmh8HPI9kpRiUwuI
         AOBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772005407; x=1772610207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31tKxIamTKYA+kb9Yej+epsVr+m056uORYnUnfM4tIQ=;
        b=2a7lISA9mMWG7B2HSe+/iD0XEsgdG4WXd3QQlLKDdcHl40hC5Db9rPnhYxFJDlJh9X
         c0PAUUJJI1tDYQNiO5gwbDx59duTy1PQTHv70LDt+DIal+zGGe8/4hmiZkhmGEr5Te9p
         sUxiTT5FPmv2jratSKV2OYE7ybcsJcNooXyQNMFmajFCVHqy3eItA7wCPnI3vPRJpmDS
         sL7iEgwjguXXKiVjju+r6yIZKS+E1kkkdFAfIjUzK4GhtX6LDj7aDDh3WjwOKDMVc1ZX
         ZzVUGjncNWrR7lybLjRqN2hHwT0puidEV6R9idUk/KeEe0CMgTI/SAvUqhPQSfTlIcfV
         nIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772005407; x=1772610207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=31tKxIamTKYA+kb9Yej+epsVr+m056uORYnUnfM4tIQ=;
        b=FIdtKqKbFS1RacKKMpvmgr3nfgSLP3Iym53zukmeNiAxLGUXBkpa+Y+4SwLLGD+U+B
         CB7zwR/1ZQfnEj/iOvR8iw3e57Xag+2Ifk5VJ2x+4nD6YXYUfdC6WpsaYDzZJOAvHQ9l
         HIjelMRKWHBlgfhaeK9Vsf9Keq3GsMD2X1novZYBkXAPKYTfWjXbsD/UYntD3n/aHdrg
         yS7CcwtMpHRsgbBvVoAEX5gSRMaLjQNDqebjB3mWhMquH4bwkB31CjOJOGHO8MwDTz1e
         jHqdkGwPrKAz0T0GArcocATGm5UKt054Cs7ZJb9PmxDlZtvM0Gcmvoy/TYQhGnDQU7l2
         vL6A==
X-Forwarded-Encrypted: i=1; AJvYcCVxKUx1eAgOoZHnmnoKBF1CastL6D1utuj4OErtR0Jg//SLCzxHg9xJ9wP1JJdKVlYBXEFoHlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX9LuAEPOzt1/BNTMI4GsWx76yUHqVfgrxD92z1r1VOt9Wudk
	RlbylsCgCSzlgll3ozeYG6BsuIAboocYmuHsASi+SZ+mOxCrM31Nu86K1pgTI349D0730vYvmcw
	fuXgHz46iz0+pRXzgjOIw9js2HZiL9CUXnQUdV3kS
X-Gm-Gg: ATEYQzwY5m7TURUBuvlhhCJoOPpYNLLgp1QjvZXPfSwpOSid/muxrWyQxyKzXgq2WN2
	5VMh6NliqcZ9OAsJthquys5D+7846Kf/hbxzFCIlQ1ZhWQ9NS+xQ22jE2EO0dIEnucfSc+uq8ru
	yeDW4AS5JInTx4eUJ2zjL2jzuw236ks8+EhJDB38j2t2ikVE2dMPek4fN3I3giVMXsE6lrGGfPO
	VrkjAX6/Rc6SwZdNqIadKUFdN06xY380iRICvaAeuZZ6vkbjvg40zfy//bdwc/eG7qL9GbzzyYw
	d/rLWR1gQgZ2sEJ4bYLHqHKX92OH8HcDEozcL9P99BKRps1D4p3I2AlLLDlgh2jYKM4S16ZN
X-Received: by 2002:a05:7022:6724:b0:119:e569:f61b with SMTP id
 a92af1059eb24-12781df5bc9mr599957c88.20.1772005406674; Tue, 24 Feb 2026
 23:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225033216.601205-1-edumazet@google.com> <CAAVpQUDMTefL+Rsb_9FnMFf5o8UsqhxpZ3Vgg56_TDQQbPHCRQ@mail.gmail.com>
 <CANn89i+oE7SpzKq8cVw4J=0DTHvQt2Ou_v=cxmNKhCviK7fXRw@mail.gmail.com> <CANn89iKfD5-MZUcCFjnkWV1E=RwBVf6T+sSFRv+zEiAMEc46Sg@mail.gmail.com>
In-Reply-To: <CANn89iKfD5-MZUcCFjnkWV1E=RwBVf6T+sSFRv+zEiAMEc46Sg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Feb 2026 23:43:14 -0800
X-Gm-Features: AaiRm513VY2ZpjytvehcsVn7C9rFth2yqVf00mZMtSsAOzmmuozodI_ObzQ3EiI
Message-ID: <CAAVpQUBMF5Awq_JRJTRrNMx5SrqFwrCHc2ySFw-4O6+QL2Zkag@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use cmpxchg() in lock_sock_nested()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260785-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92596193AB4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:29=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Feb 25, 2026 at 8:23=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Feb 25, 2026 at 8:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Tue, Feb 24, 2026 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > Add a fast path in lock_sock_nested(), to avoid acquiring
> > > > the socket spinlock only to set @owned to one:
> > > >
> > > >         spin_lock_bh(&sk->sk_lock.slock);
> > > >         if (unlikely(sock_owned_by_user_nocheck(sk)))
> > > >                 __lock_sock(sk);
> > > >         sk->sk_lock.owned =3D 1;
> > > >         spin_unlock_bh(&sk->sk_lock.slock);
> > > >
> > > > On x86_64 compiler generates something quite efficient:
> > > >
> > > > ffffffff81e96100 <lock_sock_nested>:
> > > > ffffffff81e96100:       f3 0f 1e fa             endbr64
> > > > ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%ra=
x,1)
> > > > ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
> > > > ffffffff81e9610e:       31 c0                   xor    %eax,%eax
> > > > ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0=
x148(%rdi)
> > > > ffffffff81e96117:       00 00
> > > > ffffffff81e96119:       48 85 c0                test   %rax,%rax
> > > > ffffffff81e9611c:       74 33                   je     ffffffff81e9=
6151 <lock_sock_nested+0x51>
> > > > ...// slow path
> > > > ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d=
2570 <__pi___x86_return_thunk>
> > >
> > > Wow, this is interesting !
> >
> > And using try_cmpxchg() might remove the "test %rax,%rax" after the
> > "lock cmpxchg"
> >
> > >
> > > Should we use __SPIN_LOCK_UNLOCKED() for the old
> > > value too ?  Looks like parisc assigns a non-zero value for it.
> > >
> > > arch/parisc/include/asm/spinlock_types.h:5:#define
> > > __ARCH_SPIN_LOCK_UNLOCKED_VAL 0x1a46
> > >
> >
> > I will take a look thanks !
>
> WIth this diff on top of V1 we indeed remove one test.

Cool, I was wondering why the test was needed and
understood it was just to clear ZF which we can reuse
with try_cmpxchg() !

With that diff:

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2a03d1432111f2dcea9d700f80efb7b0bb4a47d8..86185f194d64b4eea0835ee0f=
9b53fda184c73cb
> 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3782,11 +3782,14 @@ void noinline lock_sock_nested(struct sock
> *sk, int subclass)
>         might_sleep();
>  #ifdef CONFIG_64BIT
>         if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> -               socket_lock_t tmp;
> +               socket_lock_t tmp, old;
>
>                 tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
>                 tmp.owned =3D 1;
> -               if (likely(!cmpxchg(&sk->sk_lock.combined, 0, tmp.combine=
d)))
> +               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
> +               old.owned =3D 0;
> +               if (likely(try_cmpxchg(&sk->sk_lock.combined,
> +                                      &old.combined, tmp.combined)))
>                         return;
>         }
>  #endif
>
> 00000000000077c0 <lock_sock_nested>:
>     77c0:       f3 0f 1e fa             endbr64
>     77c4:       e8 00 00 00 00          call   77c9 <lock_sock_nested+0x9=
>
>                         77c5: R_X86_64_PLT32    __fentry__-0x4
>     77c9:       b9 01 00 00 00          mov    $0x1,%ecx
>     77ce:       31 c0                   xor    %eax,%eax
>     77d0:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148(%rdi)
>     77d7:       00 00
>     77d9:       75 06                   jne    77e1
> <lock_sock_nested+0x21> // slow path
>     77db:       2e e9 00 00 00 00       cs jmp 77e1 <lock_sock_nested+0x2=
1>
>                         77dd: R_X86_64_PLT32    __x86_return_thunk-0x4

