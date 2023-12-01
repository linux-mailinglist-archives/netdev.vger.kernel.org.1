Return-Path: <netdev+bounces-52877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD330800822
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A00B1C20A88
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3720B0F;
	Fri,  1 Dec 2023 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3XCtUdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDDF1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:23:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bc59115c2so2742675e87.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701426214; x=1702031014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHZBXDv0bWvZkwqeezwaiVy0CrTyg1blzXlB7Qy+Grw=;
        b=d3XCtUdYNz0lXL8oE6vQFTolbq1cMo9dhJLuSaB21CazFODHdG97j+yU/ARUeywOUT
         EO835kpHbY73Gwp66fm/rz3bOcVwcUCcm3nS9jrDugtrwC/6BIYdLFDy80lBRHQ6C4g4
         JprOGpFvleXB2keHQxSpJOnpBI507mjMTNK9bAvvD9zcphmxeWtYLFnOWilTr8zkhl3r
         getXiYabaxorTaMQldEYunIXBzGGW8Z9/xS2EbRToM9zOi1VMvgl8C8ahIWApSfwh3u/
         FJhBCa2+jACTRQdT38XmmUuWCdrU8Yvbm62/Kui+IcecL2NlMLWcV/uhhrqFI8BwqDF8
         M01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426214; x=1702031014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHZBXDv0bWvZkwqeezwaiVy0CrTyg1blzXlB7Qy+Grw=;
        b=JBbb399kx3aijnENq9W4YUm9OScKVY/j5jT8QfI3w5YZQMZXHqK0TVIA+rvtIUIO05
         kXhHvOiEfYa3YePIP21dxuAGxgz1ldw5kBndQW/eTLwjvh3hgP2yC9ZbVx1EafXn1lJM
         FLePOS0OMkcpqX0lfMt1MZM/74TkywNsUS6yk0prwEq/Da1odZVZegy18MyX+lofv3rN
         Fbejw0UUBQvlfgGUAMrRnbrOWs9PWhCLSoG/uwJmwGLzVcFVLc41RqKTifoP1/3SD/kc
         +NE4s+viNzclirpJpycUGEry+XlDrI+PsEP10/IYJId2ujtYDupHFLsS+PSCAuK4aRRh
         yrSQ==
X-Gm-Message-State: AOJu0Yyzw0Hv4nIdB9Jf3vVgA+qbpXHs3xHfUJ+0oZvX76YlDhv2OKPI
	Zd5zhsLSQJcsl/2S2uE5NpISVAxiO0tvF7dNjjVWlfgla5XMUm4lj24=
X-Google-Smtp-Source: AGHT+IEqwYb2rJolt5SIm5Wh4B7lmViyWquSSodJt4DcR2odm8MBw2ny++A/HUjloOJCDnp0fi9NUUb8jMJ1ROarIg4=
X-Received: by 2002:a05:6512:4896:b0:50b:d764:96a1 with SMTP id
 eq22-20020a056512489600b0050bd76496a1mr588843lfb.133.1701426214184; Fri, 01
 Dec 2023 02:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com> <20231130115611.6632-4-liangchen.linux@gmail.com>
In-Reply-To: <20231130115611.6632-4-liangchen.linux@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Dec 2023 12:22:58 +0200
Message-ID: <CAC_iWjJUaUiQfq6Lw+D-ruf3p0L3WVVYXZSL-pAKpbeH=nu-CA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

The second time is the charm, apologize for the noise.. resending it
as plain-text

On Thu, 30 Nov 2023 at 13:59, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> Wrap code for checking if a page is a page_pool page into a
> function for better readability and ease of reuse.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/skbuff.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea..31e57c29c556 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>                 skb_get(list);
>  }
>
> +static bool skb_frag_is_pp_page(struct page *page)
> +{
> +       return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
> +}
> +

That's fine, but why _frag? The same logic applies to non-fragmented pages no?
So rename it to skb_from_pp()?

[...]

Thanks
/Ilias

