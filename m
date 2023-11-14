Return-Path: <netdev+bounces-47756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0E7EB45D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8159C1F24D3B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13541778;
	Tue, 14 Nov 2023 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1RSoBKd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14F4174B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:04:27 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F303132
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:04:26 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso7034816e87.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699977864; x=1700582664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4x8JVCu/Bzm8DAZPUqv7WGrhofHgYtSnXUq7I8CpEcA=;
        b=S1RSoBKdflky0lrKZwheGlehNaiwfd0F3x/G84646Mn5y7/JV8+v5dHzzLTYpiT5Nx
         Axejul+cYeUEZuWcTe/dvI794xyqqHBYj7TREcikYXsu+H9A9NVWDFNEn/n8mfJxr3QL
         oP5w28savY4L3hmfPX4XmMvYudQMSc7imkoySvSZTyAFK5MzDTKIaIG+RUmF97C9fxxe
         wcSfbZ40h6EDDF2gw38xFVfd2aYPvhpAg4bEOKwpRlL8CfLWIxyfFYnDODo3k/a1I8id
         7Ji1HAEm1u9CU3iVvU34vPORUF4/XsKgdgU/fmuJ9CKsHD5QD14WmXoslSaIwxmrhUYu
         Vo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977864; x=1700582664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x8JVCu/Bzm8DAZPUqv7WGrhofHgYtSnXUq7I8CpEcA=;
        b=EQdQqENfqDhZMKcCk1SMFRd1/ve81SpVb4NFeOVrIKu7J17wj7nVgVg7n/8ig4XjCw
         xT/XD6na4YyChyjk5adiYIEypqM68hVPNOJcnwUCaX2MB1Y5oJNeAdFapxx3m6obmzYC
         c0LCwLCXJfyg+veY4vZo/p1qyubcNZ9Y2Wtypy+KGhp8Fhgqh3deW8DhM1dbk04QjhUu
         ak5NJj8w6/+9rpleYjqqKFR3q4VQguk1RduD/OguZbxPJRtInq17xXdiN/inTSstcPVM
         J5evQlPra5Ke8lO37X3nt9jiaIjWj+8ET8tE5Adk0wFYgW5YlAb2H3J+PSDawbZgv8kN
         lxFA==
X-Gm-Message-State: AOJu0YyvZMzU4NNY1/8u4D41wl88YBNpYGisOLHgSetv4PeL9yRtNRPi
	+Ox0Pz/X6PuB9iulpqlFzSyHc81+JS5gGg==
X-Google-Smtp-Source: AGHT+IF45v9A/1dPgqMaI6y7ysIyUaFYRXGZck2bx5EwywdJ9kFO70XQSCKd5ZMMlIPVtr+qKpYxZw==
X-Received: by 2002:ac2:58c3:0:b0:509:4655:d8d5 with SMTP id u3-20020ac258c3000000b005094655d8d5mr6666065lfo.11.1699977864235;
        Tue, 14 Nov 2023 08:04:24 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u19-20020ac243d3000000b00501c673e773sm1370762lfl.39.2023.11.14.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:04:23 -0800 (PST)
Date: Tue, 14 Nov 2023 19:04:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: avoid rx queue overrun
Message-ID: <ysmqbuxjcgbcq4urtru5elda3dcbyejo2db3ds5cousy2trjdh@6fe774njbiam>
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
 <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>

On Mon, Nov 13, 2023 at 07:42:50PM +0200, Baruch Siach wrote:
> dma_rx_size can be set as low as 64. Rx budget might be higher than
> that. Make sure to not overrun allocated rx buffers when budget is
> larger.
> 
> Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
> 'cur_rx'.

Have you ever met the denoted problem? I am asking because what you
say can happen only if the incoming traffic overruns the Rx-buffer,
otherwise the loop will break on the first found DMA-own descriptor.
But if that happens AFAICS the result will likely to be fatal because
the stmmac_rx() method will try to handle the already handled and not
yet recycled descriptor with no buffers assigned.

So after adding the Fixes tag feel tree to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f28838c8cdb3..2afb2bd25977 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5293,6 +5293,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
>  	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
> +	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
>  
>  	if (netif_msg_rx_status(priv)) {
>  		void *rx_head;
> -- 
> 2.42.0
> 
> 

