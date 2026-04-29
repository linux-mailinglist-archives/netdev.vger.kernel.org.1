Return-Path: <netdev+bounces-282393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGe4DV8H8mkimwEAu9opvQ
	(envelope-from <netdev+bounces-282393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C3494CD0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8C4A301147B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C73FE357;
	Wed, 29 Apr 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR+of57P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20143FE347
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469220; cv=pass; b=VLOAqLxOQOWv6dfrQHqgPxwvaGnF4Du+o7ImQpv/0e4Y+3r3FIkCPGxpWNAFni8d+QOgmYXaUt24/knC84UxunJmhXHbmmrnloMAESugIPX/tKQh+GGFnJwtforbLCXnLpR2FhXLbNaofNJjo7lMHmyghflb2NlfqT4MGUEMyIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469220; c=relaxed/simple;
	bh=FOsFryz9uEMD0y0xajcCjGUezJTWoq340vDG1IiuyZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEhDJctdhxfJRONFFk9eyigpygHrYh1i+wiy1XJVtarx9ayqKfA4HVl89JpSnbRBiMKh0RebFwRt23PmgS6CkFlSc4QFEo4keIqkPq9Tba02LNJ3jVcDRAQaoBrL/0PcahNIudbPNKCS/KPo2JU8+sZMCveitQY9Ix1jL3jZIso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR+of57P; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca2726f61so149262576d6.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777469218; cv=none;
        d=google.com; s=arc-20240605;
        b=gd5O/dQQ65QVrdHPE7GFasJJwf7mR8KHFwLmqpZRfrgYO+UtbqTmRFcG8PlblkzKRX
         +tn+Vw6k25plOVxEwSX6pmY+Fb0WaL3OF338+LOeakkhOoi4uWO25Uit2/aj89AVedW6
         hnUXi/GFv2osLJO9LDuhx5jiKd7eLRoAYreTekmGgAutCatdfghosBSkj/J0R8IfGgM8
         C+TIx2Lajd6p7qK7/KMoA+PqKrDXZs1FrtVFuZYwa2rwMmiu0gqpUvgk5sxqC4lH0c15
         rvKkbAkdF2mInHXfyt+K+0ifa6hjVpR11fRPb5rAJu/xql80fT4prsjNgW64rApa194V
         wCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8y+KA4KOzYym1C71KbDBRYhXiIos9WNrsanBlQUO68=;
        fh=5Kiw+1fhhYZMtK+wXbkeOSuwih2qctmmu3YdXKVcy2c=;
        b=LwJZA3GhCQAV3/WiQdh+6WHo36QKa3CjfG9TRiAdwTrf+G+XvWxBo7AZR2z9mluQI9
         Il7XPZoqbEoB+5TuA89xxpSv0veXkR3mwtXvpoyzhOa4UqTMh2VWTXtmASe+OYnkGLtn
         AFvaZS1aTTgYeUSvcUDboEUOwEl/ZXXqMH/0P2Jpxn0TbNWbTz0pmVX0hG20bc46vfqc
         CkBci/bv/S3nmS9QAGQtiZyuNNYLJ69UsNOnjsp5HHAfinZJtwTc6evtE9YPhm9vxxWI
         fGmSBEbJlfSN68kitydHEvXydZSLhpGMKZ73iWj9KMefXtH6ZXeiha6UQthZnDi9bTsl
         KC6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777469218; x=1778074018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8y+KA4KOzYym1C71KbDBRYhXiIos9WNrsanBlQUO68=;
        b=kR+of57Puh0PF92D2FZA7x7arqAkpeM6XKrz1USD9KDJFcXn3EcqpzAO7BNTfk+66R
         ZS+i0oSlK9wO7kHhws3pyf56xl73AEvSHnCHGZnupnO37tTqmS/NF32+niR98D36mzv1
         xVMLr5VB2oVLyjZhfO/OmZvxCvJRUvD2Ha5dvItJNWe+vfCOiU36hWGPp9S3CnG4CrvM
         5dgHi9M0gsDye4A06pPsmt3DRi8DvYfwYiMP0+uQmFebizaeA8lkAQZ/L5AgH2bsi4t8
         5ntJ5nYPivTnh4kXyBTruQ3CQqH2O3W8Wd6ZbagqlP3x+faew6LIZQ/6O0fNOBgRUKpB
         db6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469218; x=1778074018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8y+KA4KOzYym1C71KbDBRYhXiIos9WNrsanBlQUO68=;
        b=lEMfOc2nkrX0E2eCW1s/tR45d3x3cdKtk/GfOAggjX2J5xoFJkfcnw71NomFegWcHW
         B5CnD+2Z2KoeomuLTOCyErUo6217iy1iyjgUFKpQxWoEZ3EAL+kGhpo/3OEzKPH7ypql
         zMRdxbENDX7HS0vDvi5VcwiMoX0u2KIE/WiHJNpB0CBv/DJkZRp4tFG6/2gs2L6qPuVZ
         31upQhi7FvjSr9J2w/7dOM3D9mKgkHTaNbh1zLlIx8RfbNSLiNeZmi5ABQsmrOlTgYZW
         6A0G8qzrYh+6Tq3UdC7Q1+/XECMScWr2RTLCAkUgePXpJOHEmIpW0q+bDmiJGA5Dlnv7
         hH9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+pX0JR+SjUYnDNE5ov2n/X2SMO4/N5nuRKg91Z1KCtzuXsBMRFqBuqBJyIqvYVfIXqIoeJeYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1t2M/Gx/gkW/5ssZAcr0sM307JvI1Vl38GgLJ1ai6Xk1/Jcc
	NdVli2RBdAvk1KwxhMTfRT8PK803TZMJV4Rn308VmKyI4ixvWBKel0w4E5XLce18BfWkMJkMupj
	NcHyTejseflw0USSWqJuktg8w9458sxTWvJShFw51
X-Gm-Gg: AeBDiespsxRJjc1K6QTGu8lxk2Ic7p9zlhsdnf+0CDlbpVqeCx5m4giZG8lGChKC7ww
	ihhtpS+AfuRVda0VkZvwCrqA0TPI+WOmSs2c5D7Dl09pnvROdULiQAeuDGZNae8YIistfM1cyVg
	0K0gGQUh6sCap0VVlC/MIlstquTUfK8LqGFR8D00DMWBYc5oZmlWcFfGYJs9COwS6RzeKJ+hCQ7
	0Bhg5SEJEgyEkWxzVLaeFec2F+zV6CZe9sX0Mc9fnzRs+jRZzenw1o9i7CMouGurg1ff+lPu3Aa
	HKqBmFxKPN9SLhPCtiSj0ukUO5xbJW0MAT71hqVY62uCLOhWGswQe955hNXkedjSoT0IJDnhLQq
	BEUVa3HRO
X-Received: by 2002:a05:6214:1947:b0:8a1:478a:e58a with SMTP id
 6a1803df08f44-8b3e31f9dabmr122939496d6.36.1777469217278; Wed, 29 Apr 2026
 06:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429132218.3548644-1-lee@kernel.org>
In-Reply-To: <20260429132218.3548644-1-lee@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 06:26:45 -0700
X-Gm-Features: AVHnY4IwMmXjk-XLg5uSNtzhc5y83lpbiyoRhN9mPIm0gezj-Da4cGBSeDVuvQ4
Message-ID: <CANn89iL_o4dJ-zgjGzA=gGXiVF1P0TTz74LJNuy2zrgbxB5S0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfc: llcp: fix use-after-free in llcp_sock_release()
To: Lee Jones <lee@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EE4C3494CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 6:22=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> llcp_sock_release() unconditionally unlinks the socket from the local
> sockets list.  However, if the socket is still in connecting state, it
> is on the connecting list.
>
> Fix this by checking the socket state and unlinking from the correct list=
.
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/nfc/llcp_sock.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index f1be1e84f6653..feab29fc62f44 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
>
>         if (sock->type =3D=3D SOCK_RAW)
>                 nfc_llcp_sock_unlink(&local->raw_sockets, sk);
> +       else if (sk->sk_state =3D=3D LLCP_CONNECTING)
> +               nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
>         else
>                 nfc_llcp_sock_unlink(&local->sockets, sk);
>
> --
> 2.54.0.545.g6539524ca2-goog
>

Why are you sending this patch a second time?

You forgot to add a Fixes: tag, as requested for all networking patches.

