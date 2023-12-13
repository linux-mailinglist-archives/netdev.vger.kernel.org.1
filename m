Return-Path: <netdev+bounces-56742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73AB810B0E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCB41C20CDE
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13F168BE;
	Wed, 13 Dec 2023 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iys/bRNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCCAD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 23:10:12 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f62447c2so65408941fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702451410; x=1703056210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xr2xoEhq40SCymfewxeZeSzLkdKg7a4JO5PolVrdEF0=;
        b=iys/bRNIDVZAB1tBRqO44KEGQDjy47fhgQ7qWIPCCYdI0KcfQz2uqfDyu1v8wid15n
         zyMxjD5VHC1v9aH4Eiabbl9K9KVFagOMeC0MRV9kozxGd5V0AZy2pyIXEs5LsUN+QZnL
         I90shn3HFGqkQTZWMxcTFuNWbPeVwcT9mtxA0qlxx8jGEC5IAz+QTMnXv5S4MNDr10jS
         Y9QBMlxKBQqg805ozaA/WVHCco2AII7ss2NuTyvOgLYyKxKb1XP7ABA98MxWNvjOZHEu
         VST1cM0dhsgIMiIZJxXiTUsaZhp7MldCVU+UiGCzXWE232+qJne58VSwISVxUqj0IC3T
         Szsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451410; x=1703056210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xr2xoEhq40SCymfewxeZeSzLkdKg7a4JO5PolVrdEF0=;
        b=vYglgtxapThLjDJFKSIV0OjkzPcg5UwXoD9CUaYzqp8Z7U8aXUG1BKqUnjakFSsFM8
         cReTM0w2F/Gbj23ItLVHckb5QVw/H7HAbAPH0mj8UCYADTfYTFbhUHc6r5i1HpzdjHKN
         G38/x/e9G7E3AtJnzQl7xPo+Y6klXOaBOuLTVQcoJafKF0mD/htALm1W+WngqKhvCvUK
         ishD5xaEauWUI0RSSn6AfJy7iQxtMWIDw/KDvJtzCnPF16lxc/v9Km8DVOA3+n4PJJ1Q
         h7PumdjNKpSoXYUFhO3sdd1GJ8VHsghd7X/ZeKe1EwsY+TV43juxxSjBSDzSRhvRmUdi
         sKqA==
X-Gm-Message-State: AOJu0YzgmJFB5J5AxV7UkBbdofdX3YQU/CtV3cioAFD+j1EMYhZTuS9b
	36mUd1jyvGTEBBCcneJpA84DAQtBmcw7vIEmzidfBYFF4pJ6F/szk/U=
X-Google-Smtp-Source: AGHT+IExKJAEseKKqyTNTppg1spHDP0V6SplJkXJNn8LRFc//Ja8pVqfqV5LsZJgybVitX2OtUydKq8VaOcBA3ALvoo=
X-Received: by 2002:a2e:a99a:0:b0:2cb:2e9b:df9 with SMTP id
 x26-20020a2ea99a000000b002cb2e9b0df9mr3948145ljq.14.1702451410305; Tue, 12
 Dec 2023 23:10:10 -0800 (PST)
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
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Dec 2023 09:09:34 +0200
Message-ID: <CAC_iWjK=Frw_4kp-X+c4bN7e19ygqsg78aiiV2qJc59o7Gx8jA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Mon, 11 Dec 2023 at 22:14, Jakub Kicinski <kuba@kernel.org> wrote:
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
> + * Increase fragment reference count (pp_ref_count) on a page, but if it is
> + * not a page pool page, fallback to increase a reference(_refcount) on a
> + * normal page.
> + */
> +static void skb_pp_frag_ref(struct page *page)
> +{
> +       struct page *head_page = compound_head(page);
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

Correct

>
> We can either lean in the direction of making it less skb specific,
> put the code in page_pool.c / helpers.h and make it clear that the
> caller has to be careful.
> Or we make it more skb specific, take a skb pointer as arg, and also
> look at its recycling marking..
> or just improve the kdoc.

I've mentioned this in the past, but I generally try to prevent people
from shooting themselves in the foot when creating APIs. Unless
there's a proven performance hit, I'd move the pp_recycle checking in
skb_pp_frag_ref().

Thanks
/Ilias

/Ilias

