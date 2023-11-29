Return-Path: <netdev+bounces-52090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B007FD3FE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554ADB21747
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE11A71B;
	Wed, 29 Nov 2023 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AOIADvn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074310D3
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:20:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso7554a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701253237; x=1701858037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K1pgVBMcYU7bzXRB07o7wfGLOUjRgQ7TJnPk6wf/gY=;
        b=3AOIADvnRiYriVRDTSFSO2B2RvMcVCtqRjEmLdJr5qB3nVWlSaOkPeuHDSEwUpu+jC
         dPUJndixGYxzuTsVgnBuYy+EGEY6CZFRHfqsDiC1LCCTB1zgJFAOQ1RiDk28uhEzxyvV
         ZmaMv4VtvCeusyNQ11+7XNophrZZNIDejqLHVoIE0DWqN6MKmCGbCB76FgZFArt6Oiz5
         8BqYbXCDTnvsLVpScI/AnoMRkWKHipeUCmbOcHqzUoGJbIN98+49hQGuBNjlQGtWwBPG
         dDyZRnqVUf8GgQMcf/vdwyy3vYZH4tDBBW0m3gQTz6V/1OF4XryLciAsANJS12G1TI28
         KJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701253237; x=1701858037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K1pgVBMcYU7bzXRB07o7wfGLOUjRgQ7TJnPk6wf/gY=;
        b=dj3DwhueYU18QuqAxXmRh1IY1mJ7AGiqZN+gUlhXPPx0+wzKtmNlMYZazsJgO4ig4B
         rLeKa9JXVsmT9W4Npz+wZByLVmQsQV9leeLAxW/ndozKgrHTbSxLEptwP29hDbRt/kel
         LQpfYWEsPGyuVYxBiLSxc8hYrWPiH0xLXXyeomzJ1YdIOIIar6a6MspA6hlLmx0NoWTc
         hWuqXsLMrNDz4ANpn3uz1M2ldwcME3Am430lecxWSrUvwV3Ndwkt1EoHlXh+siLTqCRE
         q9mytXgPpPU0VyWrfwLSO2DqVNcwf64oFngFczmuELFkipl8bOtSri/msUf6n7iNDodi
         a9vg==
X-Gm-Message-State: AOJu0Yxr8pofmxrHMjDHoX/tX4cdNpn82qYaUo8EI+7Mmy8ofcUM/kxE
	mhw+92EEjmE2BGbNJHaSE1Gpko65MiOrWrBvjl1xmQ==
X-Google-Smtp-Source: AGHT+IEQ1VgbC/IrwvosnReucCncdwhWEjHxRSdOlIpq5n/GqVXvvu3RjRWJTUhbdCq9uGBSc4k2Tyz1O22kneqJrak=
X-Received: by 2002:a05:6402:88d:b0:54b:221d:ee1c with SMTP id
 e13-20020a056402088d00b0054b221dee1cmr578543edy.5.1701253236925; Wed, 29 Nov
 2023 02:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129022924.96156-1-kuniyu@amazon.com> <20231129022924.96156-9-kuniyu@amazon.com>
In-Reply-To: <20231129022924.96156-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 11:20:25 +0100
Message-ID: <CANn89iJ+0D1KdUBQ-f-ac5XqZFPH3KN1P_7y-jafK4a4WVkTqQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 8/8] tcp: Factorise cookie-dependent fields
 initialisation in cookie_v[46]_check()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF, and then kfunc at
> TC will preallocate reqsk and initialise some fields that should
> not be overwritten later by cookie_v[46]_check().
>
> To simplify the flow in cookie_v[46]_check(), we move such fields'
> initialisation to cookie_tcp_reqsk_alloc() and factorise non-BPF
> SYN Cookie handling into cookie_tcp_check(), where we validate the
> cookie and allocate reqsk, as done by kfunc later.
>
> Note that we set ireq->ecn_ok in two steps, the latter of which will
> be shared by the BPF case.  As cookie_ecn_ok() is one-liner, now
> it's inlined.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>


>                                   dst_metric(dst, RTAX_INITRWND));
>
>         ireq->rcv_wscale =3D rcv_wscale;
> -       ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, net, dst);
> +       ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);

nit: presumably this cookie_ecn_ok() call could be factorized if done
from tcp_get_cookie_sock()

Reviewed-by: Eric Dumazet <edumazet@google.com>

No need for another version.

>
>         ret =3D tcp_get_cookie_sock(sk, skb, req, dst);
>  out:
> --
> 2.30.2
>

