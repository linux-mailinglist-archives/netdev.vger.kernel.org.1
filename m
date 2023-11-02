Return-Path: <netdev+bounces-45678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A1E7DEFA3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAA1C20E04
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423310969;
	Thu,  2 Nov 2023 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dsc6HVVl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E879C7
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:16:39 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8A128
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 03:16:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1229641a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698920193; x=1699524993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02xkZqOKKz9d+moFfG7ERv43EDw24szAgy8uy4/RXNc=;
        b=Dsc6HVVl0B5n+tG36McAUl9jsQbCec3w4zgQobK2LkQS+8NYuc8Dk3PhhVrYi0HSCS
         98ha4aiSpab1vlIouEGstnJiTkUb0ObG+5b7TsuWsNwH3iMscOESBIeAIobPdHU6C52j
         lPRynfl0kc9on886tJNG0yc68UXR8VE8D6Sezjbfvk+tzKs+xAyS5xdXQg/Slo5cTaXb
         ynqyZ4tvid7jYFkBE6ifqZ3UgeYQuPLPx5iSeY54KE7PU7ydg+A41audtycFah+UUd9C
         0gzzP4bFaTOG5U3yvHoOuj+bfYWtf60mq9c/DaXrkCORbvZPdzcjYb2pZn5pi+oLbWcc
         AD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920193; x=1699524993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02xkZqOKKz9d+moFfG7ERv43EDw24szAgy8uy4/RXNc=;
        b=P2d7W3o4pWAR6VvuC+1R6q15Nx27JJDZp1gS+bfOmBkp88lu7JyN0+HIv+7zFX4+fL
         nBhQXBCX7h+T3UpaksecdFIHw/Nl3iymerLqAvv9nPJNC2IgI1J17+iyDZE20WGKjDyp
         c1Jv/hcLu9cazyC9Z2aVy+NTExg/chQrxI6rcqpErC1sKI1LGFtS+zbRWPyvuZAEpj2h
         fgoPZ/QZqZL1HLWIEpwxq/KCoo/OzYB76mQtmp2QyWCtrQcSjQDkiQGZ8b5v7GglwjNF
         vEm3OfI4kKp3ZmI8vHuHfgrrFiY7fjiPwtjueZQFviG4TXITJYgtA82OOxRd8pNRCgRB
         TXMg==
X-Gm-Message-State: AOJu0Ywr7ep5NdwYVTCqRHM/2PFMYxkipJxO2G6vNLFCy7X7F1jSA7RW
	sRG7VinYGRcsYt1shGNRI64J4g==
X-Google-Smtp-Source: AGHT+IGAIpKlpb139ceS6EcClNVt5Z+NaIbDHk76iPL/T7wUBC0B/lAuYL7CQFzy391iCAo+wQDcCA==
X-Received: by 2002:a50:9544:0:b0:543:595a:8280 with SMTP id v4-20020a509544000000b00543595a8280mr7273567eda.37.1698920193032;
        Thu, 02 Nov 2023 03:16:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d896000000b0054354da96e5sm2146543edq.55.2023.11.02.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:16:32 -0700 (PDT)
Date: Thu, 2 Nov 2023 13:16:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH v2] netfilter: nf_tables: prevent OOB access in
 nft_byteorder_eval
Message-ID: <d7e42ffd-aabf-46d7-b02a-a7337708a29a@moroto.mountain>
References: <20230705201232.GG3751@breakpoint.cc>
 <20230705210535.943194-1-cascardo@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705210535.943194-1-cascardo@canonical.com>

On Wed, Jul 05, 2023 at 06:05:35PM -0300, Thadeu Lima de Souza Cascardo wrote:
> diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
> index 9a85e797ed58..e596d1a842f7 100644
> --- a/net/netfilter/nft_byteorder.c
> +++ b/net/netfilter/nft_byteorder.c
> @@ -30,11 +30,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
>  	const struct nft_byteorder *priv = nft_expr_priv(expr);
>  	u32 *src = &regs->data[priv->sreg];
>  	u32 *dst = &regs->data[priv->dreg];
> -	union { u32 u32; u16 u16; } *s, *d;
> +	u16 *s16, *d16;
>  	unsigned int i;
>  
> -	s = (void *)src;
> -	d = (void *)dst;
> +	s16 = (void *)src;
> +	d16 = (void *)dst;
>  
>  	switch (priv->size) {
>  	case 8: {

This patch is correct, but shouldn't we fix the code for 64 bit writes
as well?

net/netfilter/nft_byteorder.c
    26  void nft_byteorder_eval(const struct nft_expr *expr,
    27                          struct nft_regs *regs,
    28                          const struct nft_pktinfo *pkt)
    29  {
    30          const struct nft_byteorder *priv = nft_expr_priv(expr);
    31          u32 *src = &regs->data[priv->sreg];
    32          u32 *dst = &regs->data[priv->dreg];
    33          u16 *s16, *d16;
    34          unsigned int i;
    35  
    36          s16 = (void *)src;
    37          d16 = (void *)dst;
    38  
    39          switch (priv->size) {
    40          case 8: {
    41                  u64 src64;
    42  
    43                  switch (priv->op) {
    44                  case NFT_BYTEORDER_NTOH:
    45                          for (i = 0; i < priv->len / 8; i++) {
    46                                  src64 = nft_reg_load64(&src[i]);
    47                                  nft_reg_store64(&dst[i],
    48                                                  be64_to_cpu((__force __be64)src64));

We're writing 8 bytes, then moving forward 4 bytes and writing 8 bytes
again.  Each subsequent write over-writes 4 bytes from the previous
write.

    49                          }
    50                          break;
    51                  case NFT_BYTEORDER_HTON:
    52                          for (i = 0; i < priv->len / 8; i++) {
    53                                  src64 = (__force __u64)
    54                                          cpu_to_be64(nft_reg_load64(&src[i]));
    55                                  nft_reg_store64(&dst[i], src64);

Same.

    56                          }
    57                          break;
    58                  }
    59                  break;
    60          }
    61          case 4:
    62                  switch (priv->op) {
    63                  case NFT_BYTEORDER_NTOH:
    64                          for (i = 0; i < priv->len / 4; i++)
    65                                  dst[i] = ntohl((__force __be32)src[i]);
    66                          break;
    67                  case NFT_BYTEORDER_HTON:

regards,
dan carpenter


