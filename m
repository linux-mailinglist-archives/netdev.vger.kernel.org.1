Return-Path: <netdev+bounces-56197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58380E263
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA04E1F21BDD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055134696;
	Tue, 12 Dec 2023 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k016COjG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A839C
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:00:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33330a5617fso5416773f8f.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702350020; x=1702954820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEpaSDxBDaqvEZxE2thoR3lqcHzm2s07IHm9DdzxaPU=;
        b=k016COjG0uJGVMuut6hRM82opclMEcdI64TLze2af/f+0LXILpczxowYAPmI6eowwe
         Nk0CwkozK0KwUEds9DHWPMAaukX2aPwID5ck3Wh/grlMrQNp6qaiFMu9FyTDNuaugyNb
         +jNM2wYKS/9tXIdlOpz4KAm4it+YSuR07CHu8+vWAt/63psEM5xrwhUbOjBHI9EGm4XD
         lNrlvEW+qi/Kakw77yfEK44NQxzvem/GXUkc6hCp6KPm2CSxvo/3uRn+tO3awlOJZFO4
         h74fhZiaSY9kmYJ90wQqGOQahDWNJa2calkfwbHk34jV8ouKiK6OAwqtYw8+rU5d2ZCJ
         GSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350020; x=1702954820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEpaSDxBDaqvEZxE2thoR3lqcHzm2s07IHm9DdzxaPU=;
        b=XJM+OmVCYGdzjZobvx3V0uarpXDd+z6LlwZUGQ9Kjqq0hFQ5/p5YBY8etP7ng3YfkS
         y5UaGgFvgzfFs0YueIq9scYh1HTiwy48E7BtBoeeOf2oafT0bMynb6lBKl6wMqOGnUgH
         TbSDsxRUW5swxSxorc/2/XcBVcBEwE+2hNX9ILVo1iHNhqONKYW4RWYyDQ+GpSlh3B4y
         D775g7aITBqQHWl+XSF5wgMq0bnvatKf8voZ7sTxX/TPQxk6F8hFE6zuui8/b3HZSzbz
         NSurbbIlMSDfBZhshbUkcpB3kbV0v9llFlnMT4mFElYm3t6QBBtB/aiHvxYp01xZONqx
         1Syg==
X-Gm-Message-State: AOJu0YxFmfEwbWdLvIIoK0XC8Hsz+ug8faYYuSxQYRZRjZNMFCF29gkm
	yq4a/h6hWS18QwTIZE9Jb3CexPc0EhBvrrva2eGxWu+u4EgceA==
X-Google-Smtp-Source: AGHT+IH9Q0gXAmA8EOFXeZ7d7irnsATyGJaEZESyqs98wIDGwdl7X4UaOe5V1uwTd0GHFHJXqcrqXsAkZB1YA2sqGj8=
X-Received: by 2002:a05:600c:3084:b0:40c:24e7:a777 with SMTP id
 g4-20020a05600c308400b0040c24e7a777mr2995092wmn.47.1702350020022; Mon, 11 Dec
 2023 19:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
 <20231211035243.15774-5-liangchen.linux@gmail.com> <CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
 <20231211121409.5cfaebd5@kernel.org>
In-Reply-To: <20231211121409.5cfaebd5@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 12 Dec 2023 11:00:06 +0800
Message-ID: <CAKhg4tKZ=ab50KqxpO47AreGocekXBuGsxtmFHmTDAjoThk27A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 4:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Dec 2023 09:46:55 +0200 Ilias Apalodimas wrote:
> > As I said in the past the patch look correct. I don't like the fact
> > that more pp internals creep into the default network stack, but
> > perhaps this is fine with the bigger adoption?
> > Jakub any thoughts/objections?
>
> Now that you asked... the helper does seem to be in sort of
> a in-between state of being skb specific.
>
> What worries me is that this:
>
> +/**
> + * skb_pp_frag_ref() - Increase fragment reference count of a page
> + * @page:      page of the fragment on which to increase a reference
> + *
> + * Increase fragment reference count (pp_ref_count) on a page, but if it=
 is
> + * not a page pool page, fallback to increase a reference(_refcount) on =
a
> + * normal page.
> + */
> +static void skb_pp_frag_ref(struct page *page)
> +{
> +       struct page *head_page =3D compound_head(page);
> +
> +       if (likely(is_pp_page(head_page)))
> +               page_pool_ref_page(head_page);
> +       else
> +               page_ref_inc(head_page);
> +}
>
> doesn't even document that the caller must make sure that the skb
> which owns this page is marked for pp recycling. The caller added
> by this patch does that, but we should indicate somewhere that doing
> skb_pp_frag_ref() for frag in a non-pp-recycling skb is not correct.
>
> We can either lean in the direction of making it less skb specific,
> put the code in page_pool.c / helpers.h and make it clear that the
> caller has to be careful.
> Or we make it more skb specific, take a skb pointer as arg, and also
> look at its recycling marking..
> or just improve the kdoc.

Thank you for the suggestion! I will proceed with improving the kdoc.

