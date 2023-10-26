Return-Path: <netdev+bounces-44443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C437D7FE3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9591C20F68
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849028DB4;
	Thu, 26 Oct 2023 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8egavAI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6B28E38
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:43:00 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2A1AC
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:42:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so8005a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698313377; x=1698918177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KkmbSu8db+qiDUzJkTv/heJ9UCtH2HHLky/v14eISo=;
        b=C8egavAI8dY6sDfslJnSUgx951b1RHnIN3W2un4QSfPkG0yN7/Xx/v6ypy9MQQuG1j
         dOrljb+1HYRzEhfNDIcoFn+AW6jceV/59EOeRIR8e13XIl708f0HtrPBbRdVgi97ErSN
         En+IZ1toIzelShcfK4Q4lXuuvgUbXWUThU2RacAx0XpECyX0mHXMm+0fPI/w7qVsP6cF
         z9S2RMrtcKwrqu4LABKCJYxETiAnW1RFiTiw/Si5bt0sEEL2qAa3YSvx3+CLTqRtOjQE
         gQqX49cC3jZM1x0+AHqEZff5KLHRnYcZsL84uIRQBs5klMsvj4yxMPv7/MNELLOgKIf+
         lb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313377; x=1698918177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KkmbSu8db+qiDUzJkTv/heJ9UCtH2HHLky/v14eISo=;
        b=fckPIIEESB+HXGDCGxtKKpTpbEZ7gHdGA+kfEYUQF0BBBbo9Med2iH645t/ASBrTJC
         OQqDtVsZUQzAmQTdSEi9LwDtrX5B1EcBwbuoJsyrBCfPHlq/yFIxEZmeYude2p6fpyWt
         kzB+j47UNI1tuHUZaOveVCzfYYSjSgSUg/hYCYTbVar/0dr/tDEvGaB81ZWs8vVLWCUn
         X+V9PnjV2j21Dvdh9TCMhi0jD9XGfbLRTlmw9KntGHvEK3UXs8MkNmFPiud1W9flyaJA
         KOTW8yMQ8LOIzbntyZPpOyu7OCvNvLVl71x2X11jbJ+FVB/Oh0cnzwPLKB9D0v5/ohIs
         VYmw==
X-Gm-Message-State: AOJu0Yz4oxu4+GmfauG6kNjI/l95ioGmdH6VT/WZPqA++NsIaBTKhe6t
	02QV/7M8ZnSQeEfwCBgfQoQrP4b7i0q+1DvqLhJMfw==
X-Google-Smtp-Source: AGHT+IEHNu9QuTztGNkBr9m/srSV5BBqeoY/w1kAQxmfyacRTDkzFXgKyGNljLX3GJRSddd0CNTDgW42yPF8tnUaUqE=
X-Received: by 2002:a50:d706:0:b0:53e:7ad7:6d47 with SMTP id
 t6-20020a50d706000000b0053e7ad76d47mr224615edi.5.1698313376577; Thu, 26 Oct
 2023 02:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com> <20231026081959.3477034-3-lixiaoyan@google.com>
In-Reply-To: <20231026081959.3477034-3-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Oct 2023 11:42:45 +0200
Message-ID: <CANn89iKVc9J5511u2GO7Qpc=CShhhRf+qN5NmEv5bnHcUM6d1g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:20=E2=80=AFAM Coco Li <lixiaoyan@google.com> wro=
te:
>
> Set up build time warnings to safegaurd against future header changes of

safeguard

> organized structs.
>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Eric Dumazet <edumazet@google.com>

> ---
>  include/linux/cache.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 9900d20b76c28..4e547beccd6a5 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -85,6 +85,24 @@
>  #define cache_line_size()      L1_CACHE_BYTES
>  #endif
>
> +#ifndef __cacheline_group_begin
> +#define __cacheline_group_begin(GROUP) \
> +       __u8 __cacheline_group_begin__##GROUP[0]
> +#endif
> +
> +#ifndef __cacheline_group_end
> +#define __cacheline_group_end(GROUP) \
> +       __u8 __cacheline_group_end__##GROUP[0]
> +#endif
> +
> +#ifndef CACHELINE_ASSERT_GROUP_MEMBER
> +#define CACHELINE_ASSERT_GROUP_MEMBER(TYPE, GROUP, MEMBER) \
> +       BUILD_BUG_ON(!(offsetof(TYPE, MEMBER) >=3D \
> +                      offsetofend(TYPE, __cacheline_group_begin__##GROUP=
) && \
> +                      offsetofend(TYPE, MEMBER) <=3D \
> +                      offsetof(TYPE, __cacheline_group_end__##GROUP)))
> +#endif
> +
>  /*
>   * Helper to add padding within a struct to ensure data fall into separa=
te
>   * cachelines.
> --
> 2.42.0.758.gaed0368e0e-goog
>

