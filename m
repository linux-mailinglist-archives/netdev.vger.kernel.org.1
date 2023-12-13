Return-Path: <netdev+bounces-56688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D858107DD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B5528230F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5CA5E;
	Wed, 13 Dec 2023 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJ9HueVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFA3AD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:51:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1db6c63028so731120066b.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702432303; x=1703037103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TklYrgTZ3NegcmBlOIQaEuD+kvAJ5OPcu+HwN+PsM/A=;
        b=gJ9HueVUD7cwbfTDOy5E3v631VAyclrbOcRUXghhk+MRHATusm8X62Rl+TjDBsFWR/
         MbUXHNtiWqBSJHn+HpW/LZ5tuoNnuVZ3pk4Ycr+3de/LQJ6gmUWBU64QvGajgYDex5mx
         fkNpHYUchZciKENFWyfyu4Xn+aV1nvMuYOhGaAQ6EBWOg2U8SSrgSELcYoJ0b1V1Lbia
         zMUmiiI9XEbW1IPphTWbz+VNcHaMz6t5RcY0yfGea2TdHoKmcl27aG+ZvwKSlNfL1P3x
         ZFTNEogdc2jBQ6q/eBqOh7le9OJBCPrX21ayrwQrBvYPuxnvPCXc+5Q7odZX5tMSq4PA
         ziFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432303; x=1703037103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TklYrgTZ3NegcmBlOIQaEuD+kvAJ5OPcu+HwN+PsM/A=;
        b=sIFXyLqBhgtOozq4inQG1eni0pjRPOoh+gWq4ie/owJPRc30SCdks/KbR7eQnHcLVe
         DYi7kWHHBQxuWoWJV+dtWL5DGMUEpaOksjMdAeNmFfxeFLdAt04gyjAVHGwpHJGA4xqL
         CDn0FLXO9J77g6rJEXXCjociQ8dS2DOzgjAxpYD0QR9ahDp/7b5luxEhFjMjNCBwQF23
         9oz+55OXLbyaLlmGBpKocLQUdyhz9UfLiYJWzzXc26yWQJ9yS/IrJ7C3xoJMtFcO8q/U
         47YF8tD8ss+svYjk7cq/YFCjismVsfpHw9Asc9TxoyDwq0YG/WTGqP5aUwpMC8ld+tbf
         3vgQ==
X-Gm-Message-State: AOJu0YxQtVazJWrPscz0oC3qjwmEvMEe4Un0h5QCMuGYuBjC+X3Dk+SJ
	2ZzSsVc3b0SzdwD6Q/qQp941vcB2B6/vPLT/0JFVQA==
X-Google-Smtp-Source: AGHT+IETnqaBNVOF81fdtSM39Ss0WfltPtcNJL+KCi21mHH8UXqSk6Qr1CCtSG8dHkctdmy68n/GIhq3KSHzFGD+7c8=
X-Received: by 2002:a17:906:5352:b0:a1f:9617:99a with SMTP id
 j18-20020a170906535200b00a1f9617099amr2178327ejo.94.1702432302460; Tue, 12
 Dec 2023 17:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com> <20231212044614.42733-3-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-3-liangchen.linux@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 17:51:30 -0800
Message-ID: <CAHS8izOJNT+fv+tUP3yGeDxg8ehk1bFQfFMC-K4hCbiO8+OrdA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:47=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> Referring to patch [1], in order to support multiple users referencing th=
e
> same fragment and prevent overflow from pp_ref_count growing, the initial
> value of pp_ref_count is halved, leaving room for pp_ref_count to increme=
nt
> before the page is drained.
>
> [1]
> https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com=
/
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

Reviewed-by: Mina Almasry <almarsymina@google.com>

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
>


--=20
Thanks,
Mina

