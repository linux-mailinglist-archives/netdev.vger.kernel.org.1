Return-Path: <netdev+bounces-47687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F237EAF9E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F21F230DD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437D3D984;
	Tue, 14 Nov 2023 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoQGIjbw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B6291F
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:06:05 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27DF0
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:06:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507be298d2aso7384198e87.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699963562; x=1700568362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZggK9siKn7KExoQxFcIHD3TyD4//iFjzA6iSpMA3G10=;
        b=KoQGIjbwR8WdSMcmt+DOOdac9ZjwlFShTufW42cdF5bHd8W2aG6jsrj84mtMzO1TLC
         b6iH1AIgcMQ5mqCAvxU/vTT6SWOAcqWEqE5+tpKWewmTo5bUaYGDqTMUUqD8GfYF8aTF
         rvTO8bBoEPAsauFNqBcZi3yt5ZP/avnTp8P7UrEn+PahnCoHwtTZMqY/zR5YnraSq2FD
         UKvNMvo9k6SIqHTYZmVojwfmzZq345hoi9xjxSmpUoLLXut/GaLBG3IyQRxtFQFP0A8t
         jcT0hCtEpiOVra+Kh48ogEah6E9EKLwMyvLyYfvfvwUeuT8HGsfIgyeglnkOXVX7bxdE
         ISOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699963562; x=1700568362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZggK9siKn7KExoQxFcIHD3TyD4//iFjzA6iSpMA3G10=;
        b=IfKT3BGu6qP/i4KLqmu74YMtKcNV2Pt3EWWG4EFa5p+l+52U/hcMgPxv9IQEswwbii
         jnX/8VQhny8+QaVZuyYmL8nmLmq6zXr7LGziUYMvcXIGkovXTyr61I3O5iBEwCjAAiVt
         oKyqJBjraMTMoe7nzBSNRXLLakZ0zqxBXQHr7Ii18z7zUEF+1q+uzDYKVsA4xmsHql/s
         pPNx8ClHUQmToRkBfpL4nI93xSzCUfHTLVMxz69F4fiVwG/BVl4y2aA+w2lJHVt2tuog
         G6HKBvrMUHXTTLTXK1zUATSIyjcvbBmZ/0Kyc0MHa6qlmNF6EAW8HwfhmdDH8FsXPR2v
         R2Vw==
X-Gm-Message-State: AOJu0YzkWbLISrfXKT84O0/MEWHTeSmOUpon6N25TjGZztIC/fY11S+Y
	st3PgPv+KW2MJ4mesRwfy/PIN+mdAfgY+A==
X-Google-Smtp-Source: AGHT+IEwjt0LujeowNoQLGcYpLszzW+/j0oIkWyUq6CS50C4N8rjEVqcKDGphdIx4klIWW9g5m/Nvg==
X-Received: by 2002:a05:6512:238c:b0:509:d97:c84f with SMTP id c12-20020a056512238c00b005090d97c84fmr7844254lfv.23.1699963561724;
        Tue, 14 Nov 2023 04:06:01 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056512159600b00507cee141c9sm1300459lfb.32.2023.11.14.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 04:06:01 -0800 (PST)
Date: Tue, 14 Nov 2023 15:05:59 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: remove extra newline from
 descriptors display
Message-ID: <la55hpdihraxfe4u35w6kyurkkjqij7ss5qpirehat47hwzo62@aj5qku6vypdi>
References: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>

On Tue, Nov 14, 2023 at 09:03:09AM +0200, Baruch Siach wrote:
> One newline per line should be enough. Reduce the verbosity of
> descriptors dump.

Why not. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3e50fd53a617..39336fe5e89d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6202,7 +6202,6 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
>  				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
>  			p++;
>  		}
> -		seq_printf(seq, "\n");
>  	}
>  }
>  
> -- 
> 2.42.0
> 
> 

