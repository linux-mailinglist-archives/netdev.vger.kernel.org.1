Return-Path: <netdev+bounces-16321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3874CB2D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 06:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6137A280F1B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B81FB4;
	Mon, 10 Jul 2023 04:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4F17F2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 04:23:10 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D519F
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 21:23:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so5095474a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 21:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1688962982; x=1691554982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unJunWB9yRpC3U1eqb2KdocYK0tHtgtI+uUB6Ylr4i8=;
        b=dRV5ujPph26AcjYtOEROPML5mPDRSAdEOBso8r/e7B2L3gm5869TI6/4HeVgNPKoVf
         syyYQIRX/EZSrUWSzilVWrH0i1vOpM0cjNeJ2jjexwBY7nEcv4nwg7RqA7FHCThpZubI
         mR5W6PZjCRGReIqd0FmpPvWmRjLtf3r3vaARo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688962982; x=1691554982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unJunWB9yRpC3U1eqb2KdocYK0tHtgtI+uUB6Ylr4i8=;
        b=lUhmRx09bv/mThoHCYNZlQa4icDrSNBHH0MrM6xWFsU6a4aSdAZN2Ucin6qTg+Ucgp
         mvABdnoPZTLRBkqtm1mb5R++2LTz5b7fSez6CeVjDZoivwVNlBmfLMzHqhBbegLEiYX9
         n2agv0KzVBP6R2MPZv/2gw8ESTfrJoa6l6e+xu/CzGWPzEaEntytg3iw/76F/i0CrMpt
         VxyRv8em4koKvdeBdpUSbW4x+C2g3eOIFhRqGBODyg/jVwgu0yetazNLhYdf/QKvo/kh
         PNnxoL570ADgKpmxV3tI6zwm7upkNR5ROliRAxvHWaTGySAy4GN32okuUkmaPwI4LUCa
         nBvA==
X-Gm-Message-State: ABy/qLaISpP67WgVsY+PnPimxg6lI5plNVhPXrGkiPzU1a+wTF/tsxXx
	J6BJM+lGdB9GykzfkMtQWtUOtZ2c6ssFlt3MeJ3N1Q==
X-Google-Smtp-Source: APBJJlEb7YzeGv4dUXss3qrlGa92ZkWCTXKAMeFi/NwO6iIlvBR0oBNLvMKcmZXACqeRgXPZOzANeW5ospTulr+8RIE=
X-Received: by 2002:aa7:d6d0:0:b0:51d:ad30:5ed7 with SMTP id
 x16-20020aa7d6d0000000b0051dad305ed7mr11049329edr.35.1688962982462; Sun, 09
 Jul 2023 21:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707183935.997267-1-kuba@kernel.org> <20230707183935.997267-10-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-10-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 9 Jul 2023 21:22:50 -0700
Message-ID: <CACKFLikNuOgJPOd1xCcSkB9-BJczVZsfqUKy4EVhPLYTE5xbQQ@mail.gmail.com>
Subject: Re: [RFC 09/12] eth: bnxt: use the page pool for data pages
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, almasrymina@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com, 
	willemb@google.com, Andrew Gospodarek <gospo@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To benefit from page recycling allocate the agg pages (used by HW-GRO
> and jumbo) from the page pool.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 43 ++++++++++++-----------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 6512514cd498..734c2c6cad69 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -811,33 +811,27 @@ static inline int bnxt_alloc_rx_page(struct bnxt *b=
p,
>         u16 sw_prod =3D rxr->rx_sw_agg_prod;
>         unsigned int offset =3D 0;
>
> -       if (BNXT_RX_PAGE_MODE(bp)) {
> +       if (PAGE_SIZE <=3D BNXT_RX_PAGE_SIZE || BNXT_RX_PAGE_MODE(bp)) {

We have a very similar set of patches from my colleague Somnath to
support page pool and it supports PAGE_SIZE >=3D BNXT_RX_PAGE_SIZE in a
more unified way.  So here, we don't have to deal with the if/else
condition. I should be able to post the patches later in the week
after some more QA.

>                 page =3D __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
>
>                 if (!page)
>                         return -ENOMEM;
>
>         } else {
> -               if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
> -                       page =3D rxr->rx_page;
> -                       if (!page) {
> -                               page =3D alloc_page(gfp);
> -                               if (!page)
> -                                       return -ENOMEM;
> -                               rxr->rx_page =3D page;
> -                               rxr->rx_page_offset =3D 0;
> -                       }
> -                       offset =3D rxr->rx_page_offset;
> -                       rxr->rx_page_offset +=3D BNXT_RX_PAGE_SIZE;
> -                       if (rxr->rx_page_offset =3D=3D PAGE_SIZE)
> -                               rxr->rx_page =3D NULL;
> -                       else
> -                               get_page(page);
> -               } else {
> +               page =3D rxr->rx_page;
> +               if (!page) {
>                         page =3D alloc_page(gfp);
>                         if (!page)
>                                 return -ENOMEM;
> +                       rxr->rx_page =3D page;
> +                       rxr->rx_page_offset =3D 0;
>                 }
> +               offset =3D rxr->rx_page_offset;
> +               rxr->rx_page_offset +=3D BNXT_RX_PAGE_SIZE;
> +               if (rxr->rx_page_offset =3D=3D PAGE_SIZE)
> +                       rxr->rx_page =3D NULL;
> +               else
> +                       get_page(page);
>
>                 mapping =3D dma_map_page_attrs(&pdev->dev, page, offset,
>                                              BNXT_RX_PAGE_SIZE, DMA_FROM_=
DEVICE,

