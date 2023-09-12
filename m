Return-Path: <netdev+bounces-33387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511A79DAC7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C87A1C20B92
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0606BB663;
	Tue, 12 Sep 2023 21:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D9B65D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 21:29:25 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01C10CE;
	Tue, 12 Sep 2023 14:29:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1488762b3a.1;
        Tue, 12 Sep 2023 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694554165; x=1695158965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coLs4zLGWX8/UEODDwcZYm9UyYfj5qBA7vCefH0ABEY=;
        b=RPb27HNFlgbMypYKkJ/t5w6x+lVU5JSibzvCKD8tSDnnCXpAdiC+mysPcSijkw6cUU
         jF8IJEd9Xlygys6PPoZ3t4TB1RoF3Q3dqf2d2ASHXCn+4sd+GHHUMda87afXCRvPULZV
         +/6ApAU0fSofiIA62ithE4OA74boxMT0DbA5np+bd+uGo0Bg9q2SItaSwN14W3j5OuMo
         aFTktBpner7+ysQByUwLGalglTJB2/HwNVbBGJTlkwg4C2VVKeYkPrqMpckk40TH/Mxc
         wFToR/NsEq3F7dPAeT0q1QDDxOQomkPMcTG/wZ3N0aoYC1K8zUvHOMSkjTPzL5ZW8UqQ
         tS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694554165; x=1695158965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coLs4zLGWX8/UEODDwcZYm9UyYfj5qBA7vCefH0ABEY=;
        b=vSfDwN2VWBRg0X1lkCnboB2BdaZPII81w1kFRmCU42jDPQn3v1+zahkWS9TcTFL4lL
         dfNm6N3O9e12FMFTKl5WCOvp2LUDoNQtwwFwsmST6l8P0/muAE+52MrQ4X7nclOzC3eA
         58cgATxE9Ur8vJNUqdjWU/1jdLlpE/JAo923TiJso815XWWJI+Rb/gWH6q3uaerZO8MT
         hUoqlp2YNeqztlJ/jEw1fMz7Aj6vOi8F6WmS0RY86hTMgTvkSBCZvWgaYC6OJpjEnhJ9
         DkVPBktjAFumkk/ya9wpqv5uRv8iCde9lMyfvDVnyQF6f0jhNoyUTvlsMGTfxozEfXsE
         LITA==
X-Gm-Message-State: AOJu0YwM3DII6iuNUMugBqdTdo4ne2OzgEVxVLXDwYx93jJaQi33cANk
	UMeFGon/J77dW+HDot5AyCE=
X-Google-Smtp-Source: AGHT+IE3q3b82eqhPh+EnWknJL77OHqIRSda8tn9Vn/AKjRMyo7gHLi/Db5dlOybFhajVtsfEaMMQA==
X-Received: by 2002:a05:6a00:23c7:b0:68e:25ff:613e with SMTP id g7-20020a056a0023c700b0068e25ff613emr981894pfc.3.1694554164702;
        Tue, 12 Sep 2023 14:29:24 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b0068ff6d21563sm761370pfg.148.2023.09.12.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:29:24 -0700 (PDT)
Date: Tue, 12 Sep 2023 14:29:21 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH] octeontx2-pf: Enable PTP PPS output support
Message-ID: <ZQDYMRT/hoF7zuK4@hoboy.vegasvil.org>
References: <20230912175116.581412-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912175116.581412-1-saikrishnag@marvell.com>

On Tue, Sep 12, 2023 at 11:21:16PM +0530, Sai Krishna wrote:

> +	case PTP_CLK_REQ_PEROUT:
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
> +
> +		if (rq->perout.index >= ptp_info->n_pins)
> +			return -EINVAL;
> +		if (on) {
> +			period = rq->perout.period.sec * NSEC_PER_SEC +
> +				 rq->perout.period.nsec;
> +			ptp_pps_on(ptp, on, period);
> +		} else {
> +			ptp_pps_on(ptp, on, period);
>  		}
>  		return 0;
>  	default:
> @@ -411,6 +425,7 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
>  		.name           = "OcteonTX2 PTP",
>  		.max_adj        = 1000000000ull,
>  		.n_ext_ts       = 1,
> +		.n_per_out      = 1,

Thanks for using the "per_out" API for PPS output instead of...

>  		.n_pins         = 1,
>  		.pps            = 0,

this one (which has a misleading name) !

Acked-by: Richard Cochran <richardcochran@gmail.com>

