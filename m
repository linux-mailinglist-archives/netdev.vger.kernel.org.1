Return-Path: <netdev+bounces-57394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2755813035
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696671F214B0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177D4AF84;
	Thu, 14 Dec 2023 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="rPQOtEhj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41933115
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:33:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca03103155so101700221fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1702557196; x=1703161996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOKRvReK44WjC67PpboxcBAbWNfB0BRmMGzQVugpv1I=;
        b=rPQOtEhj7NoKrhnE41K6eNPo8ZJBU3/TvDfFUEnrxKTiSkQAlJc6LV3WJ6bdCndALU
         uGsNJ3/eq4/FKFLtMpsXuqgSTkw2SlDlowCmryhXChavD1qiznHXwl9jWU2Z1AipECNe
         /0aLh3iEnh9sQxgFOW4wM6C8K2dLKUz2dtQen4HjEp66bgrF8SCZNzaqzJbdrgWTAblx
         gLm1i108wVPQ/PQe9BiEMAH3FeegsjU4WhgSp6OSR6TUGXVEV95PGVbbou/5Bl5VuKPt
         swDVKTUVwhb6tUJ7Du814/QtX2pevkqp35gXRiYG3V+tote8utvZ8uwvp6ZrEnn718C1
         lxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557196; x=1703161996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOKRvReK44WjC67PpboxcBAbWNfB0BRmMGzQVugpv1I=;
        b=lYaizLMY0Z7RlJHER5Mdf5fPH/rJns9O7H8zkJ9SoBf/WTHmHbGa5zeWzVIXMJpE7q
         JXIUyo3VanBxmv+hCQEi16ldJN59F+5Xwmbl6dlD47hzd92BdMywPQvBj7CdqgGR+705
         QLIwgalgSwr9qWN/Y/8U4glj8a9c/i/0YTGy687vK93OTDcB7ffVBI1JV2m0AcDIFYlt
         IB49pz/p4gPEw9G3d/JAlQiX6Vp2Gt8WaMnhFf3ClL2PcPJULZ7g3Cdp+vN3MPzQJnCu
         9ArUBFKC2hFKXXV4YZobQF+6+6aTFQt2wtc/rM2MDzhcUNc2CiCKb3enMzC5xjG55lxv
         tmSw==
X-Gm-Message-State: AOJu0YwzEO2P+k/EUNFzGe16N01M+BQq+gu9KagASQ8gFRL1Os3wh6js
	Wv6ZUkuJqLMSK2lgOdvDBK1wuA==
X-Google-Smtp-Source: AGHT+IH5NkhwO7Bck9gXySSKfyEWsZo7KqBsKJph/ZdaImpEC0ABrLLMoAFOIsAgX7Nrk1vij46ftA==
X-Received: by 2002:a2e:908d:0:b0:2c9:f864:9c7 with SMTP id l13-20020a2e908d000000b002c9f86409c7mr2982649ljg.55.1702557196324;
        Thu, 14 Dec 2023 04:33:16 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e87d2000000b002ca013cb05csm2119750ljj.79.2023.12.14.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:33:15 -0800 (PST)
Date: Thu, 14 Dec 2023 13:33:15 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ravb: Check that GTI loading request is done
Message-ID: <20231214123315.GL1863068@ragnatech.se>
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214113137.2450292-3-claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

Thanks for your work.

On 2023-12-14 13:31:37 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hardware manual specifies the following for GCCR.LTI bit:
> 0: Setting completed
> 1: When written: Issue a configuration request.
> When read: Completion of settings is pending

This is hard to parse at first glance, the last row have odd indentation 
and the mixing of read and write info is odd. I know this reflects how 
it's written in the datasheet, but at least there the indentation is 
correct. Also missing here is the fact that only 1 can be written to the 
bit.

> 
> Thus, check the completion status when setting 1 to GCCR.LTI.

Can you describe in the commit why this fix is needed. I agree it is, 
but would be nice to record why. As this have a fixes tags have you hit 
an issue? Or are you correcting the driver based on the datasheet?

Maybe a more informative commit message could be to describe the change 
and why it's needed instead of the register layout?

  The driver do not wait for the confirmation of the configuring request 
  of the gPTP timer increment before moving on. Add a check to make sure 
  the request completes successfully.

> 
> Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
> Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
> Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ce95eb5af354..1c253403a297 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2819,6 +2819,10 @@ static int ravb_probe(struct platform_device *pdev)
>  
>  		/* Request GTI loading */
>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +		/* Check completion status. */
> +		error = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
> +		if (error)
> +			goto out_disable_refclk;

nit: Maybe create a helper for this so future fixes only need to be 
addressed in one location?

>  	}
>  
>  	if (info->internal_delay) {
> @@ -3041,6 +3045,10 @@ static int __maybe_unused ravb_resume(struct device *dev)
>  
>  		/* Request GTI loading */
>  		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +		/* Check completion status. */
> +		ret = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	if (info->internal_delay)
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

