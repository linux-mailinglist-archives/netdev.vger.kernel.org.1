Return-Path: <netdev+bounces-260779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM0PMN2inmlPWgQAu9opvQ
	(envelope-from <netdev+bounces-260779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:21:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665F19341C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F25B0303B4F7
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2C92E8B81;
	Wed, 25 Feb 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3s3CKya/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535E2D7DCE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004009; cv=pass; b=ik1VlRG0ZgeDWd5mAAvwJc51rwPvi2T20WgXa+roggBD1vhaG3MIrf220GVjyEcsM/EAmZXKlwNI29NA6BfT2fhfatkkB3b+cl9KFbMce6mzMjJhtt5Ej1+/RVTa5uTMhCrKANnUkkDup3fK3A5bL9NrTu1nuGWBPuRkueF3Q+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004009; c=relaxed/simple;
	bh=5I29VZbalTCm3rqbnUgdsldcNOKbt8fBfZD9i7LyvUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/ICvVa9JWRP8qplLlIdE/AsF1M4T4wGNxgbmcXOm+0TDz/v1KegFlpw3qmKtToVU7boBgJKBmKGBWqu2Ng9mx0sz5t7/GcmtxLOmS8OAOtAJ57bDQ975Jckw1CakahcQslxWy9onJthdjP4n++gl1i9221qhlHQZoOgJi+xvEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3s3CKya/; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270adc5121so7540081c88.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004007; cv=none;
        d=google.com; s=arc-20240605;
        b=OJgBlN0NM152TzQjk18vnaVZl7EL0poYNLrdnfTz6FtvQmEn/rEogNaKVF1CCep+/8
         MXrbVBo5oNhE/UVCBnfjtP0dm8jbz1/HfmJETSHg0SMRZCIFXhkxrgibc0D2sS8fdNCp
         s/5/cc7ZDR0lr9zkWU7pj5tKaUpRRFmtCKP7Sti9x57r7EJ5OZiP+/W5hqmvf8YyXxGQ
         HrJhjDTFL1ZLl08JR+6z5yq0lgsth/rl9TcR4J1ntT1Ao7rcLjDY+H8qjv0GaFhMLeoZ
         ivhMCKlL4wlOFL92uqx2/bZiAFyz5fKGw9eq670kwKl1KqwOPxWcSuKdTQlDd4KgTMXv
         13DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqhpk74uT9fBv8HKiORUn49XOvxveD9GSNmoEX4BxXA=;
        fh=mVZQEoNHncbthRrRLCk76GHy1sn/e6DmJvk8fUDYde4=;
        b=Bss3dDjspYEvbJGbUYMNxOVBP/+cdmVSllYoFVTAQlQ2wTISzttsWXWKxFi3J2bGpf
         ePsOulPRdLuozUGdK6FFKyAdz//aH3riSwddXh/LoGy4CXbJG4kweh7uW8hHL8UkdQap
         p6FhVXFY9o9eo0q+3dU6c2JOdbaAJh8R/gG0nM7HxpULn2uirNAy7Lx0f2Ah6eif19fs
         1hirjtxRVWYUkdZ/t9j5LUwWzxnsUD/XGTb06qFJlreXDOJZQnVCwWI+xMGnYkOE8Fx0
         szAEbzsIyZRkIm8pB0XPYbNQip5HRzSII/fLo+bRV7GY8plXQkpBcyh14AtQoHQXlMoA
         02qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004007; x=1772608807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqhpk74uT9fBv8HKiORUn49XOvxveD9GSNmoEX4BxXA=;
        b=3s3CKya/MduQruj6qCa5pUYnvsEwgiJy+Vt/yYhtH2fnyhH9zEjKgGQFUgsAfQl78h
         wj/bv1CrGJHLZtbftzcG4f8yd0+crroHoQuZ3tSS9CocmPlKVSVdnsNGM7OV28OVgM/I
         grygw+s93jiQnby3raaNikOTzF2g2g5ZQ83tQF405vWjQGTl2/I3KOCG/C6WaNeWnv8E
         f1uazdjeundr6yyNuFDeUtNzUKFIY+ojjW9y+rYEJ6u5nV1IEe8f21MtZSM1diUA6cnv
         vJ6WdPcFqn4Y8CKOM+s089/ZLiH1VCagoKwcE81x0SxnaRrCybabjCiVmO4Y5V5ZX5wt
         tA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004007; x=1772608807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqhpk74uT9fBv8HKiORUn49XOvxveD9GSNmoEX4BxXA=;
        b=WxSTWlx+fkuIhngDRhu5jmLAfyjafUQloDWiJ0cxsj0R4MnC+w0PvbqzD669P1XTWO
         y3a+wB3MH1y3Dj8HuPi7M/th1FHs6JS7GgL7LwXcQ6gonGXWE+FX1sWpN3TT6iU/xoO5
         FF3YGPm1cJwJoPQK5nHc/vILrE6de+2SSF00k1ZDSdQ9II5aQQ3imTvF8Htxdx6j+Xe7
         ia8oCZIXi1XO3aiWsSMjfuYBTur6Ce42QHuYeFLwm35hnzjYkwsgljCrmu8RU1IK567B
         vbU7TyAkZHwU3cYxK/02srY3RBBiuFHEON+Cz/tb9dq0sWlC9zNQO43Sj3Lqyr1NYhEU
         evNA==
X-Forwarded-Encrypted: i=1; AJvYcCUat9Max/K+J/8nGnaua5jCjvRKZyBblhqRlBk77tZVTzDZe/y2Iluc31BoIeRgZWUiaVpbcbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5SlX1mqVHyz30QgLkEdJ8AzGfZgmzH7mLpOh3dhOf3bZ1a6M
	Ku64llg3z+HEFwaAOxiYGfpvY1VFN1SvXHpFyHjEFS2De/+ewYfYfFUjkVJNjXvOumtzX+uU9dy
	cwfBRMn0FjYHgglM6EcnImC/roW/RfGwTOEJi3WXk
X-Gm-Gg: ATEYQzysIBsPqPL2o08GZx8B9XQ0RZnyKSma7X7wxz2A3V7sHX+4BaongBwtVE/j3sP
	VRM4ND5HUbZle8M7b+5RtW+k8sgEBrYxzfMimVX2iLEdUG9qUg7zg62VIQyQvzDyEaonWmnmWaT
	39z6iZkvQi5JSxJEYeUrom0ZuuZkMzhAPnYHkXun7IiOL9EFSRybLijRt6QjNugN9C0csMOLUnA
	WVk4tS0P5N9/HsVVXoC/wfx7Nt+qk3dKCY9oCFJkOeTJRnf6OPMhBTJvJalfRKhZQaAhqvqqjWx
	lEmFVLM90g5s7wijn7XkFM+ySKEuP4QV4ylp15PcZGWn7kPog95/Z4EQ+16XkjnaHp174nTp
X-Received: by 2002:a05:7022:40f:b0:122:2f4:b285 with SMTP id
 a92af1059eb24-1276ad61d72mr6277793c88.25.1772004006544; Tue, 24 Feb 2026
 23:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225033216.601205-1-edumazet@google.com>
In-Reply-To: <20260225033216.601205-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Feb 2026 23:19:55 -0800
X-Gm-Features: AaiRm50D8_9Hxq6I2GHjqHBaqarKrq1O1FH2tgukzto__lUBLDRAtg-ozb0nbow
Message-ID: <CAAVpQUDMTefL+Rsb_9FnMFf5o8UsqhxpZ3Vgg56_TDQQbPHCRQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260779-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7665F19341C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add a fast path in lock_sock_nested(), to avoid acquiring
> the socket spinlock only to set @owned to one:
>
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
>         sk->sk_lock.owned =3D 1;
>         spin_unlock_bh(&sk->sk_lock.slock);
>
> On x86_64 compiler generates something quite efficient:
>
> ffffffff81e96100 <lock_sock_nested>:
> ffffffff81e96100:       f3 0f 1e fa             endbr64
> ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
> ffffffff81e9610e:       31 c0                   xor    %eax,%eax
> ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148(%=
rdi)
> ffffffff81e96117:       00 00
> ffffffff81e96119:       48 85 c0                test   %rax,%rax
> ffffffff81e9611c:       74 33                   je     ffffffff81e96151 <=
lock_sock_nested+0x51>
> ...// slow path
> ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d2570 <=
__pi___x86_return_thunk>

Wow, this is interesting !

>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h |  9 +++++++--
>  net/core/sock.c    | 10 ++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 55b61e4b0d8318887d527e919fc1103d78ac6d14..84c21fb38a28406e387dc33e0=
fb5decd18893950 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -81,8 +81,13 @@
>   * mini-semaphore synchronizes multiple users amongst themselves.
>   */
>  typedef struct {
> -       spinlock_t              slock;
> -       int                     owned;
> +       union {
> +               struct slock_owned {
> +                       int             owned;
> +                       spinlock_t      slock;
> +               };
> +               long    combined;
> +       };
>         wait_queue_head_t       wq;
>         /*
>          * We express the mutex-alike socket_lock semantics
> diff --git a/net/core/sock.c b/net/core/sock.c
> index cfb2a6209946089669882cdbd5d1b36c53838989..2a03d1432111f2dcea9d700f8=
0efb7b0bb4a47d8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3780,6 +3780,16 @@ void noinline lock_sock_nested(struct sock *sk, in=
t subclass)
>         mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
>
>         might_sleep();
> +#ifdef CONFIG_64BIT
> +       if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> +               socket_lock_t tmp;
> +
> +               tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> +               tmp.owned =3D 1;
> +               if (likely(!cmpxchg(&sk->sk_lock.combined, 0, tmp.combine=
d)))

Should we use __SPIN_LOCK_UNLOCKED() for the old
value too ?  Looks like parisc assigns a non-zero value for it.

arch/parisc/include/asm/spinlock_types.h:5:#define
__ARCH_SPIN_LOCK_UNLOCKED_VAL 0x1a46


> +                       return;
> +       }
> +#endif
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
> --
> 2.53.0.414.gf7e9f6c205-goog
>

