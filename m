Return-Path: <netdev+bounces-46894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6C7E6FB3
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CACCB20B30
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF81B1FCB;
	Thu,  9 Nov 2023 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiFsJ68d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9C3D6A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:51:52 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B235BD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:51:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5098eb6690cso1135273e87.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699548709; x=1700153509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oW3Ur1Uy+CYcIsjbvWYnxpXvheTPWpcm+8SfISkjuFM=;
        b=QiFsJ68dXVIYdZ65Upn1z8PIPHhVLDUYL2ghbOVA1bKpk9oxNfEC5CzhDSWb6qAVIP
         cUqg7S+C5Jophvbc6B9jdDHzpzIDHTdKH3E5lmDa3Jo/Cf/RJij5l2xsjeujaVQkp9J6
         hLspx3szZmO/rPizs7fPgbeLSCexkPoK0Y3Sb1bpplubCfWpVlYYGB0IeXmBEszC85hI
         WAmbCbBayEXHkmX2euXs7/NAWgLlUNbI+rbnsMtAfmaWy97jl/al1azLeT9bXSC4mbhI
         y4YbBZBm/q55wTlxY2nu8R1SD0cvKlNYMm/dRyiA0BeBNkEd3clH6faAjee2uBpIqGuA
         Tiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699548709; x=1700153509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW3Ur1Uy+CYcIsjbvWYnxpXvheTPWpcm+8SfISkjuFM=;
        b=gXPsItzrVla+fWfeP3MbZoMN+6dzRPvs06sVk6DXO6WdSiq8xk8Q8t0rpn8k7nNd4k
         d/zrCHRc2jLo+E3pWwmtYIgTXaSU+SdnrlPyTqfB+jhofld6b6IcR2IguvpcX4ZNXsjb
         Ddymp1PtQNLQezJ4P4s0jYZOZrxWKG9xc+2ZPcafUtp1UxUs3xEWdLIFov+v7Q79TM79
         t/J5sEysLpbExO0p1BoItRZVym8JLVUkUmZRMmp4Jvk1SFefNLI4+zxsUnhY8HWldCQs
         49BzH5Z6o60U3EfVyR6feRzZAf3erH9aX6kfTrdhXUroz5Nx43dgERQY7eg9zR6+1ho7
         UPww==
X-Gm-Message-State: AOJu0Yy8+jdyfwcKijWPtuMyh7ns6uocDgCj8afgqe+nO2C9U9l56ut8
	+WZT6HQFg2KS8bAbYD25auIxqgzOD17vSd4Lifh6Bg==
X-Google-Smtp-Source: AGHT+IEPLwbUwT1cB5ywYS7T6GxjNHIyrW+nts6TfsEBeM3UkkvnhYfXUGKk/Lce0StzqumC60DtGLd2IEb8py62qjU=
X-Received: by 2002:a05:6512:25b:b0:500:b7ed:105a with SMTP id
 b27-20020a056512025b00b00500b7ed105amr1973441lfo.29.1699548709339; Thu, 09
 Nov 2023 08:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-8-kuba@kernel.org>
 <CAC_iWjJzJp+QWCY8ES=yOr4WrKXqF_AWGJjzNdCQmGpa=5dbyQ@mail.gmail.com> <20231109082630.77f74839@kernel.org>
In-Reply-To: <20231109082630.77f74839@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 18:51:13 +0200
Message-ID: <CAC_iWjKRUi8qxGeDFzhdBO=xn8ngnjO9j7Q5Mnbdg+rSBxuDYg@mail.gmail.com>
Subject: Re: [PATCH net-next 07/15] eth: link netdev to page_pools in drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 18:26, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 9 Nov 2023 11:11:04 +0200 Ilias Apalodimas wrote:
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
> > >  3 files changed, 3 insertions(+)
> >
> > Mind add a line for netsec.c (probably in netsec_setup_rx_dring),
> > since that's the only NIC I currently have around with pp support?
>
> It's a single queue / single napi device? So like this?

Yes it is

>
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 0891e9e49ecb..384c506bb930 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1302,6 +1302,8 @@ static int netsec_setup_rx_dring(struct netsec_priv *priv)
>                 .dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
>                 .offset = NETSEC_RXBUF_HEADROOM,
>                 .max_len = NETSEC_RX_BUF_SIZE,
> +               .napi = priv->napi,
> +               .netdev = priv->ndev,

Yea

Thanks
/Ilias
>         };
>         int i, err;
>

