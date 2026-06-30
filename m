Return-Path: <netdev+bounces-303296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsZOOpPtQ2rAlgoAu9opvQ
	(envelope-from <netdev+bounces-303296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 611766E6678
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=hdH3oFZa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303296-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B304D3048C14
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22647278A;
	Tue, 30 Jun 2026 16:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C2451047
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:19:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836350; cv=pass; b=Qp/tP6JU5ozwilZzcp4YKgf7nRVlcWibtqUbEipE9T2+xfQ3LPnR4X/PAoP2zLG9pEkE+FN1neymzAPpWUn/PxGhWMZzpa7oSDO4S9VR3EocwifYjNdAzFTqn+b85GWxUl12p74b22bOsxljaGhkXBRff8mNdSrWkzZjMDzqyVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836350; c=relaxed/simple;
	bh=f/+MyDfnaeuI7CogaxN3dIMBY5/0RM7R9hdpQjkqoaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0aMEDOY5zw7SaAVx8VngSqiVKkx5binozIOERxsekwI0Z4gy1drS5nTxFqbCDpTMZ0zOm4pH5WqXs4Dgxh5d1/wYadMzeJedbSjW0izYGWGMWaOIb0CF0ctQSIaSfbWpiSOZBImXcnPq7fSF+Ox5QeEw64daxURzhITPFMP8uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdH3oFZa; arc=pass smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139a5f4ca15so5747792c88.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782836347; cv=none;
        d=google.com; s=arc-20260327;
        b=l4mAMKQgSG1LCFHh+lkbaFBzItkmJH8VFQjTi2RIfDOu11g+nztwqmp/2VOLNvx9MF
         NmYOHe9hI/CSsC7njiFqCMwBnC1DB/xJ8i7rovqPYvu5O5DkR1ulBarDPDyucrzoUuFY
         R8m/J3zSoiROZGg3enc/aKqYhcKq0wvCjUpDUcTAY7wJDlNuHdb5gh1kLbOf7+daZZES
         IWR+ebqB7wjYPUDceNHasY39uRgcX7u4omFpnt53QqD5lOOjFcytWJFqa2+HvujfcTmV
         y852HL2gNCdRd4k7k5eUhlN8yVFrDzpic8ofvUeQsFS7rsKuHSiYODCXfLnQ3RGRAnKA
         YpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        fh=xXtz9sjm0cYL2WR9hLy5fF1QyGOvQ0zb1M1QjyFJydA=;
        b=pV0J7d0ZNezY2x8zLJklDqJQDvBFx0WNQ0g9nUnkRBT7CAkrqHQ+Lh8VRn6d9Rfitz
         sXb+5WcMhmNgrQ9ZIYNIGAMWiPe+PIVFNIPE9PPuZ/H0ALAlIYkfTbSvkk7TO8pstLad
         YwDyrVGcyfARoBo5xQtuY13VTLJivMsMUIoX+5apg3ZbmGlZyAVnGvUVVUPI2rrl5qFV
         DyXRBpjl8/L4XVvqalcspKyzN9Ro30wAySJgTsmd3glvRXGJ8YZaB+FLIjqyVJLQPJ87
         0PfzrwKeluNLL81KZIDZ9ozTTQIMB6ZdIy3HMFhQQjX8PStr9yTnxe5dRBJafcBzEmS0
         eEiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782836347; x=1783441147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        b=hdH3oFZadb5aVCZDHspdVB+floXDVazdlU/UzwLYjKTeMiOnvmRlgz43APilz52RQ6
         eS77Y7kcZRwS8MX5qTPLHEb+gMFiORfx+zfEKWghJlQ+Jxl3kQkQYMlWV8igxGJBcu6j
         Qzd6OU3lUrVB9PbyvALD6notCzMNaZKuFKCjtVqwunhRf6IkhT16PeF2gUXjdHHd+lKY
         DG2IGpjQ595fdmV7KyRajXJy82GVA1skoxOOl6kqjmdvw/8nyr+iMshVpuKGKV4j3NNJ
         7S0qZEROoHwVCA8vLi6YEGo3X5XLjXtz2DukymP7NE1IYXepfA6NjLjPgCiUTfUJIlyp
         tTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836347; x=1783441147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        b=WLPeTzN5RukdFw3r2xnOteQge2q/cgk5ko+crXHPE1vpVbEiHS7zUKPv5QkAWF56OR
         y6hdLRg6OOVeUYUmfh2d+oElD4BOCGfSoI9gKM2GyCKVhKuGq8yhZMnUCJT0CTmWfep3
         qXnr6x+L0gO1CfQt9oK0lVmFSpjHK+gcIfRQ/3wBDLeMtBzjTqnT2HDm0KVSgUw9oM0Q
         atjrTRTsgXrNg0AIpyPOdxzutdwotFuErL5NTi7QE51yjLMH2dvowghq9YDrxYcXC0tg
         JSLq36Cv1U5Sbygt54fLZteaJ7EfxEc+6vD6/R7Hw6WgjOvgDqzrm5vNbtXT84KBedJD
         A65g==
X-Forwarded-Encrypted: i=1; AFNElJ8mLbKeGklwM4i9dTw1619czdOMKU1LfeZ5cAAWwHxJNNsMS3qYZiI+soEjjMRxEebYkhC5oCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/aMEC4PdDoK7PG/qHh6sHCPeIvt6Jow+sQ6WEGdUNNxXm97A
	dWDeMIn+KnrHlVd9XKX1LSKQ0ToXR+jl2Tjoo7DQhjl//xbBp9GOW8zJsd4aaIbj+QjPX74ViIf
	x45AXMhKt8qk4oFCjPP1p5yUA8ZeJdcXftIlp6QuK
X-Gm-Gg: AfdE7cl6ZebBbn8oueZ6D6Q/1DJidF1ohS+Kq45tGwgUH3QX1emDQ1l+AGHWO5m88tB
	rSWBUyzVDChMwV6vnZmr53l3MHV8hFSP0miyY21PPMM2c6Mm+nVKYHcaFHHR/wxwYJwamCCfXlp
	THB3xuBUfh5ffg/moh+LVu+sW460VqJYlhadNlOEzoKTa56VzC9oU5pnf/vKYmuD9MNTHvnBDaI
	gb1v1P5O7sQw7W1rtQEPy+M7ODoQT7RhB9UfMihWX7sBMRGNlvzfWUdG19gk4r/LxI5GFYGgXuc
	N0HDT7vjv2agrRPr5ZE4tSJA0n3TbhSfo/TAXpCunX9vw4OqK63FF8VQWdBaD6ta1MGGfwThCOX
	KtzYiBAa27UuEuUoE1ptF/i5ObTA1yNQohvhxoA==
X-Received: by 2002:a05:7022:4595:b0:139:ed59:4b86 with SMTP id
 a92af1059eb24-13b2a1bf1bbmr2364497c88.42.1782836346356; Tue, 30 Jun 2026
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-5-jkoolstra@xs4all.nl>
In-Reply-To: <20260629194327.2270798-5-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:18:55 -0700
X-Gm-Features: AVVi8CfwyMBPNQ0tPm3h1L9ozwd_nr1YcpkmcBZ_aBP6o8OPTJkBnWkD5vIy6-A
Message-ID: <CAAVpQUBFFzVvsdJ+JytvUukRinN29+J0uZQKZbxLy01m7VeeKg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] net: af_unix: replace copy_from_sockptr()
 with copy_safe_from_sockptr()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 611766E6678

On Mon, Jun 29, 2026 at 12:42=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
>
> Replace deprecated call to copy_from_sockptr() with
> copy_safe_from_sockptr().
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  net/unix/af_unix.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 83274ce18e06..07a0b07cd65f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -933,6 +933,7 @@ static int unix_setsockopt(struct socket *sock, int l=
evel, int optname,
>  {
>         struct unix_sock *u =3D unix_sk(sock->sk);
>         struct sock *sk =3D sock->sk;
> +       int error;
>         int val;
>
>         if (level !=3D SOL_SOCKET)
> @@ -941,11 +942,9 @@ static int unix_setsockopt(struct socket *sock, int =
level, int optname,
>         if (!unix_custom_sockopt(optname))
>                 return sock_setsockopt(sock, level, optname, optval, optl=
en);
>
> -       if (optlen !=3D sizeof(int))
> -               return -EINVAL;
> -
> -       if (copy_from_sockptr(&val, optval, sizeof(val)))
> -               return -EFAULT;
> +       error =3D copy_safe_from_sockptr(&val, sizeof(val), optval, optle=
n);

Currently, only int is allowed, but this change unnecessarily loosens
the validation.

Please keep copy_from_sockptr() as is.


> +       if (error)
> +               return error;
>
>         switch (optname) {
>         case SO_INQ:
> --
> 2.54.0
>

