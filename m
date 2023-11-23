Return-Path: <netdev+bounces-50614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0697F64F2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212B1F20E38
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827863FB23;
	Thu, 23 Nov 2023 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQwXr5Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4CB9
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 09:10:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12385a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 09:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700759453; x=1701364253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogv27qnGpnnAxgKKa25Ba5uAbjpfBJFgKmK2MewHApc=;
        b=jQwXr5Vnb2KU/9NXBOIRMloclLQAPkBxu7bUaZjfyYRdbnXSZXqR6eKLuIDJrbo2Tb
         qFYUY9Z4VUC4cRkgE1Z7W6nTChrbCkV0dlv7sTZYMm9ibDcFs5b3tZaoVCK0Aebab50I
         po+3G84T1ko8Ov54fPyhoLza+u83JLRA46BmGwfqLf1agUF5QxZGVAEDEoETWARXUYLs
         Heh19yz1yscf7Lrd/pMG+XRl17eHIM1Ibv6jQ0sl7gpMGMJx7TWiaEKkE8TdsjaKSoB9
         xbT/mGWGpP76VfmNrE6fI1IcNaq3SE3SlViChE8zsQqofC8R3kPpm18yGDtKJpUYWkx/
         KuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759453; x=1701364253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogv27qnGpnnAxgKKa25Ba5uAbjpfBJFgKmK2MewHApc=;
        b=VolqpfFkAansm7W01FAqdKvoFZ8mw/YJ64kZgdJ9KISKRQonq4afA9pZGXcMly6hdq
         WqHYAeew1PlelO+yd21hQSYJ0JvWlB6ueQ85nvjRETyIzCCpo+BelFr7EP8J949Ug/nL
         +d2NoDsxqmtOl1XWDqw2URHPo52QVgyuFlAV/hjt9ZHYAOU4s1lDEaKSS9N/+vKQ996J
         SsVcPsgDy9YATJsOTtnsffTDKTMtVyCVo0bPPpJrAGlmb7yHEcKn5dcrH3YC8xK9O6uj
         7b/O+l9l2vNIYOchuX4XnRmF4tWpHG39wjqib9g1EAk4qEJenOCfG7AkcIsfbhoka85X
         vNXA==
X-Gm-Message-State: AOJu0YzQS+0fs1J8j+LQfFX85gYVoGYUfBc8HxZHEDEvGQoV2AxXRGCs
	joAKbrbCIpyfRkbyWlAZ6rJZIz1pTiYMpuf0MWwLFQ==
X-Google-Smtp-Source: AGHT+IH+NzLwsoHeMJPU/+4k0X7JE9s4eC5uLQevGz1P/mYgZuuYwOgCevHH8koTsNTGoxpH0WRBV+Y2+yzTWAgD2z0=
X-Received: by 2002:a05:6402:541b:b0:544:e2b8:ba6a with SMTP id
 ev27-20020a056402541b00b00544e2b8ba6amr331755edb.3.1700759453346; Thu, 23 Nov
 2023 09:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
In-Reply-To: <fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Nov 2023 18:10:38 +0100
Message-ID: <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
To: Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Wei Wang <weiwan@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Neil Spring <ntspring@fb.com>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Neal and Wei

On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> After the blamed commit below, if the user-space application performs
> window clamping when tp->rcv_wnd is 0, the TCP socket will never be
> able to announce a non 0 receive window, even after completely emptying
> the receive buffer and re-setting the window clamp to higher values.
>
> Refactor tcp_set_window_clamp() to address the issue: when the user
> decreases the current clamp value, set rcv_ssthresh according to the
> same logic used at buffer initialization time.
> When increasing the clamp value, give the rcv_ssthresh a chance to grow
> according to previously implemented heuristic.
>
> Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv4/tcp.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 53bcc17c91e4..1a9b9064e080 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3368,9 +3368,22 @@ int tcp_set_window_clamp(struct sock *sk, int val)
>                         return -EINVAL;
>                 tp->window_clamp =3D 0;
>         } else {
> -               tp->window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> -                       SOCK_MIN_RCVBUF / 2 : val;
> -               tp->rcv_ssthresh =3D min(tp->rcv_wnd, tp->window_clamp);
> +               u32 new_rcv_ssthresh, old_window_clamp =3D tp->window_cla=
mp;
> +               u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> +                                               SOCK_MIN_RCVBUF / 2 : val=
;
> +
> +               if (new_window_clamp =3D=3D old_window_clamp)
> +                       return 0;
> +
> +               tp->window_clamp =3D new_window_clamp;
> +               if (new_window_clamp < old_window_clamp) {
> +                       tp->rcv_ssthresh =3D min(tp->rcv_ssthresh,
> +                                              new_window_clamp);
> +               } else {
> +                       new_rcv_ssthresh =3D min(tp->rcv_wnd, tp->window_=
clamp);
> +                       tp->rcv_ssthresh =3D max(new_rcv_ssthresh,
> +                                              tp->rcv_ssthresh);
> +               }
>         }
>         return 0;
>  }

It seems there is no provision for SO_RESERVE_MEM

I wonder if tcp_adjust_rcv_ssthresh()  could help here ?

Have you considered reverting  3aa7857fe1d7 ("tcp: enable mid stream
window clamp") ?

Thanks.

