Return-Path: <netdev+bounces-262106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGmqLvDGommy5QQAu9opvQ
	(envelope-from <netdev+bounces-262106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:44:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FE1C235F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7764A30225BE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418B423178;
	Sat, 28 Feb 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8kO8Aa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778242317D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275432; cv=pass; b=Te0f1PxwuII0VxcAyygB2OfzxurJq3UIdlRZglCyhNInpUzZXD7fpSRgTnQ7Y+gGEjwO3oDF+SIuGtUU8jiNvIF8BRH184r2KRNwNExEE2Fct3p9aBpBZeQxWJmV0yMYVBmneQDo/6Z8peFNRAyYU3Ix8ZYXAEjRLhyw63dOckw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275432; c=relaxed/simple;
	bh=byrV1y01S9ZllwpxdPTd0kag3viPIA43uIwxs2gGxYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIknM9tG3Ae+n/rd63lVDpnUPeOipc1i6uCe6F87RiDMrEixrfLDra9wX7ArYVSRuni3asNcBaYPoKp5FECZqpufwDw7wWKRkvy1uDxdeE1yWR4jmAshisB18P8d5iCocwuZr/Xh8BjzgKhOy3QWLGS8G3OwaQyWt2ipNBIAElc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8kO8Aa8; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a1b23c05so34332831cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772275429; cv=none;
        d=google.com; s=arc-20240605;
        b=N021ud3KhZJdQxE7ZTHZ0ujJ8mkFz2We9b7Y1VLoKhFsKZVm/gN92a57dz5jTUmbo/
         2TBLEGjNXgmvHkzxDSr0A/x1m47qI5O+yKOI3+5nkCKqavImMMO2/C4Jb95XJZF+MbZg
         veOQLhCrMpZ16y/Sy7vQMwsy9V0qKEks2vUH2BO3RHVuJinigY3BRPx2BJN+dlOs/UdH
         /U0tizwsePF12xTOouCNRT9DKFWGgI9Sp1KP+NACNDA13zdKsAOeQSrBQGN2V2q5Df8E
         pBJUjxHgOgu5vrQDZYweMKoL+j/dvYRjEBFAXGLDKStbpI91IneKzao9rUYoCoZGQpXe
         ePeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        fh=FaKOKa+lfraK287LA7hQ9v+BDmpD/5qg+TfEyY3oXQs=;
        b=HDyHnLqmWPYTIs5CJb4OtKn+KFZtAFJSaR0V54DRi2ZgpBWmKx31sdS3i7EIHTmjn5
         M77IEw/rpOrbyzwDF51v96PIr9rf9A+Pljn92HkpkB6i/noCC9JZmnGgCJw9Fs72+bvb
         Dmbc4eOIRM2sxlgS6IKemQl6uD6NPNSjGftYjy6dnpq8ernxVCuFzaN3/szj92yl4bW1
         jOiknrhFKQ+gO/8McnxGkuX1bSypCMKyxB3IuFCOXdTYhWnSbiWcQTOj74htvYSlKLdN
         hEk5G7g9+CVXkC8/ivd9Ol3MSWAwCGJwuXS9AMz5umHMBXtLFTcInpuk/2RCai+esvys
         vmMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772275429; x=1772880229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        b=Z8kO8Aa8QSG2E/ix2tvq9c1dGUPne+wHN/OOyKPBGCQCVhmvI9R7PXTBCUonh9IT9Z
         +pMWwGiUFJtB9DskLQ/5zrzyebdiAfFEClB269oXI8ZdGFt3I9zllp/AroIQaSZNy/wI
         PfHXCZh50oGDsg7cOn5C5WNuBFHZisNIHX6Zh7SbbM1ml5lVYGKaeV8uzQCL0pHECFgf
         tIdNya544rOozXx9J7LLG6yZ9OC6yqTAawqvccq5YhqFvr6HojxiACV/3VnUOeLFWPtt
         VoVE07dwjc3B7LnmKhJfLb+zBn56GHCvedZHPt+lUoTEXt2aleHv8tnawIvcV8/YIa1u
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772275429; x=1772880229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        b=kYZ3AKBkxbjM9ADTLuXTP6FDT8yyoZTnkSO6yumumukLkp2UKyOU5gOX7MZXZCjDOT
         qSVthVUxpPR5qfTnMY6A1XHRW1LNPGJ+E1YuODI+Vpz/LmqWohsxg+OcswQI9G6Px9A5
         uZeRmdrojPdgTiwhE/U+l6eZZWxsooDBmrYzGhvJ9S/1+hzbQ8UoPU2BGCRgPe51XBJc
         zV39Ebx9YfrbimsSfUFsyQWgMX4t22lByfBY/pH+XSvWajAScK7ki9ZEM4ijH204ihqq
         BcjLNPpK6DXTHmAGm7i9kxHiHZlogjcd5qskz0Bv1zozrH3XU+AKHVfVoUPQ4z1h0sal
         w9jw==
X-Gm-Message-State: AOJu0YzigNuEFDzxTU/Zf2IOZth5ZHJbT2vGXvDbc9wp9UsKvk2bao3b
	bD/AZo6+7wE/EBN85yKe4yzAdiMeGdOw6CqhqNDKnny3oSbrBNqvnqoq3GvD3RYEBmmDBr/OXn0
	texwQoh7v64E0cZaBmmr2Kh/8IF1644fqlkFvkD8v
X-Gm-Gg: ATEYQzyVpVivNkkHj1FmtW8UTdCBcJ7/w3d/QglCKFTxNfbQSfeb494Ptylsxxa7iSL
	tpjpqkMZZNFHS+LLUeOLdyNDyelwSMTOUmUBO1gcHN+RjbrhlcMrjeNDtNvpwDQU5A4V8xp1G+q
	DDXpLvUiGoZYBa6B/nuXPTbQOUwf1EQAhCY4RGcsFu8OMXZL8Z9xgmVC5gcRk3b2WIT95cvbEJ+
	uJSt7/lomdtWxP8dgKz5zFOOSTvmHJTXmlhQGqd/qhhxADe2QVr4FplrJNtljBulP1PNtKWGsRN
	8bxfGTte
X-Received: by 2002:a05:622a:15c9:b0:506:a50b:3a8f with SMTP id
 d75a77b69052e-507527a412dmr72813731cf.30.1772275429198; Sat, 28 Feb 2026
 02:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228090644.362807-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228090644.362807-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 11:43:36 +0100
X-Gm-Features: AaiRm504Md_PN1rDK-Pt41giHnp4Eh_LDEFUnni68ItoT1ge6iwGLdz8b9wfpg0
Message-ID: <CANn89iLphv9XtPnW5Bw1UETNoZZO+rdifQfzC8MxYM+gNHAcTA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: fix sock compilation error under CONFIG_PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,google.com,redhat.com,davemloft.net,kernel.org,linutronix.de,goodmis.org,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E63FE1C235F
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:07=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
> brace-enclosed initializer rather than a compound literal, which cannot
> be used in assignment expressions. This causes a build failure:
>
>   net/core/sock.c:3787:29: error: expected expression before '{' token
>    3787 |                 tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
>
> Use declaration-with-initializer instead of assignment, consistent with
> how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
> DEFINE_SPINLOCK).
>
> Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  net/core/sock.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9d841975a7a1..2461aba7b18a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3782,12 +3782,10 @@ void noinline lock_sock_nested(struct sock *sk, i=
nt subclass)
>         might_sleep();
>  #ifdef CONFIG_64BIT
>         if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> -               socket_lock_t tmp, old;
> -
> -               tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> -               tmp.owned =3D 1;
> -               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
> -               old.owned =3D 0;
> +               socket_lock_t tmp =3D { .slock =3D __SPIN_LOCK_UNLOCKED(t=
mp.slock),
> +                                     .owned =3D 1 };
> +               socket_lock_t old =3D { .slock =3D __SPIN_LOCK_UNLOCKED(o=
ld.slock),
> +                                     .owned =3D 0 };
>                 if (likely(try_cmpxchg(&sk->sk_lock.combined,
>                                        &old.combined, tmp.combined)))
>                         return;

Thanks for your patch, could you please use a nicer formatting ?
(And keep an empty line between variables and code)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a14a12769450a8d937af96f7777070..fba4d5b8553c58f700bda3dbd82=
ce68ec74187da
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,15 @@ void noinline lock_sock_nested(struct sock
*sk, int subclass)
        might_sleep();
 #ifdef CONFIG_64BIT
        if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
-               socket_lock_t tmp, old;
+               socket_lock_t tmp =3D {
+                       .slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock),
+                       .owned =3D 1,
+               };
+               socket_lock_t old =3D {
+                       .slock =3D __SPIN_LOCK_UNLOCKED(old.slock),
+                       .owned =3D 0,
+               };

-               tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
-               tmp.owned =3D 1;
-               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
-               old.owned =3D 0;
                if (likely(try_cmpxchg(&sk->sk_lock.combined,
                                       &old.combined, tmp.combined)))
                        return;

