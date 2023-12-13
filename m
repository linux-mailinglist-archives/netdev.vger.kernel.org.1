Return-Path: <netdev+bounces-56858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D54B81104D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117E41F20F1B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442A2420E;
	Wed, 13 Dec 2023 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIsun8Zw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B3A5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 03:39:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50c0478f970so7122320e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 03:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702467555; x=1703072355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2HiWmQaWm4MP/NodEPVjpBx0ZdkVp5YIb/IjIDv1aQ=;
        b=vIsun8ZwjVWiP8C1Q8BpGzDIqsL0rMzA2hf+2F4nxX1FohOIwrQaXII/kAYMiucCHj
         k6nAbJ6J7ByhTkoJgmcN9DNCrl5Zq3nfgFjaF8hBR9bY1wZnKz0LyWDCDROka/kWsLpi
         bcLQQJTYHkeowRFEFxn2Gy2hfKPTbFY1j6LqFRu4jwFuZOgWHjmB7QpY7sOvljrAwx1L
         DF6a8uImpXedKOMcazzNUF8q0ck6fhFL3bFMHma6ir6+dwTrnC8xj1UtjgfIUD+rpirV
         brfIfr/ULT0Z3PBaCQJI1AjuPi9WvkFebh6Z8UuAd+4HuOsR48kRfmTdmgHiiPiiIBV5
         mPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467555; x=1703072355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2HiWmQaWm4MP/NodEPVjpBx0ZdkVp5YIb/IjIDv1aQ=;
        b=mxfnDVCeWjkNClxskD0jCgqKR0QT7/a6IWWSoBMKV9wdHAH/xgEPkmG0Bof1otRCF1
         sOXO+4Yr1yVRvUdKOnwNV4r9+WxTlg9FWWU+3OZI6Svu+hGtYLDZYuOU3tXr949/qeha
         xuFV8YLJRgdHQbg44wT5F9AEKsKNFiu1d98Ks9TvP6vvPcFLg+n8dph1yoJnMKb3GdG5
         GLeQeM/PEttOz7kJJgumkMx+6Rej6NC5xN08yLjNQASgsDEfofpxy9p2OJhlIdrEprVO
         JDbppvDriG4topT3UstUEaIdrvOXX5EAGIjfSXoWRPBl4U6c64mx8RbiDCOXK/bx286R
         C/yA==
X-Gm-Message-State: AOJu0Yxw8xgdyHPq8NnadJUOmJtmAwX12TST1iNqrTJbgM8jExaSIhF3
	WiHzSaI7zFG7VVKduetWneGDpJc6TqZsuUTOmeTjiA==
X-Google-Smtp-Source: AGHT+IEczFWViTBtCu4945IpCG/4uQaaO2cIq/6WGJxtQAU45RYpbgodNpUAHz0opnj/+Zo60whYZ6Vkb/0qectBD9U=
X-Received: by 2002:a19:5e53:0:b0:50c:c4c:2201 with SMTP id
 z19-20020a195e53000000b0050c0c4c2201mr3299603lfi.77.1702467555277; Wed, 13
 Dec 2023 03:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com> <20231212044614.42733-3-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-3-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Dec 2023 13:38:38 +0200
Message-ID: <CAC_iWjK88W3xHEuL+7XZ4bZXk0HrQZ4vNEFtevrX_Edrx_Md4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Liang,

On Tue, 12 Dec 2023 at 06:47, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> Referring to patch [1], in order to support multiple users referencing the
> same fragment and prevent overflow from pp_ref_count growing, the initial
> value of pp_ref_count is halved, leaving room for pp_ref_count to increment
> before the page is drained.
>
> [1]
> https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com/

We only need this if patch #4 is merged.  In that case, I'd like to
describe the changelog a bit better.
Something along the lines of
"Up to now, we were only subtracting from the number of used page
fragments to figure out when a page could be freed or recycled. A
following patch introduces support for multiple users referencing the
same fragment. So reduce the initial page fragments value to half to
avoid overflowing"

Thanks
/Ilias
> same fragment



>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 106220b1f89c..436f7ffea7b4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -26,7 +26,7 @@
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> -#define BIAS_MAX       LONG_MAX
> +#define BIAS_MAX       (LONG_MAX >> 1)
>
>  #ifdef CONFIG_PAGE_POOL_STATS
>  /* alloc_stat_inc is intended to be used in softirq context */
> --
> 2.31.1
>

