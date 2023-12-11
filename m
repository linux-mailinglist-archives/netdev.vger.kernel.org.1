Return-Path: <netdev+bounces-56066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D057480DB42
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577A5B214FF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA72537FE;
	Mon, 11 Dec 2023 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKwsqlKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8EC4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:07:18 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7c59ac49f12so2691868241.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702325237; x=1702930037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TliIQAhu/pCdffbMcTGtCdKTnFLxSs38Z+sDzdIobAQ=;
        b=PKwsqlKDPXpF1bvm/hzY9HTdgj8pT0bMURnMQqzw+HN1vuZXWZqhS8sVuCSG0mLBQX
         RH7V0EKGH9jM5K509SPwdqPC7CjbmNdsbZ9vVVAKI32/JEFA2D8oGmu/o8qwYEbWgIzK
         VM3BaZEcdY99PIgrVh1KBHYzhnMMyV7VeEr/uW6hLg/FhB9lAJY8XEnuaRAQTpO0UB7f
         iZ2pgGfIvxfVwf/eUoagdEtw2TLm2loFGAcpTnqnR5SkOC5uXF+808+cHSRYaD/9kE0g
         u/LvIhYzo+JpZsHptarAR+RBpEcWbZUXqhi6rPrKqbAQIfh8vAdcJZHQuN8pQ/YBXU+n
         0LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325237; x=1702930037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TliIQAhu/pCdffbMcTGtCdKTnFLxSs38Z+sDzdIobAQ=;
        b=ZRbmMhsfXyRRJ+7jxmrnmt3g8Gr7+wgGVFVV6UFLKdCzVtlJVet2ApXpYlcAMQHUaY
         8vbJLI6k6Zadah9ay6Xr7TZKjY9ccVU4kEkDpyEwOoF0k0h3WEUvTOl3X8gsVIeU/p8x
         ONhkJRsxNYWVtNGRPrxIaXzL7eG+jkDdrmcdPCpB48CH/p8aMznWFTjzuJRT+LBmmkBn
         ZNUmDIyizNMjQ0QiMuLQTFtEzF0DT5hszonPrxTeEd/RkXep4azI081fzlPHwx9NiIiq
         qrgbimgFKNOIlpees5gBrmySBssU/bjYJMDMOykwEQBnpX/X637+xq//U0dP6/6QlfE9
         Yv/Q==
X-Gm-Message-State: AOJu0YzA81Bebg/IpS0PUdCzSnUllTo8y3y+CAuErS6++LWNpQ9GCsPE
	+CFCYxrpox/A7uO4HEebY8i+PbQHt8jJmkfLKvnE0w==
X-Google-Smtp-Source: AGHT+IE2XNyXB9LN+CcM/yDOZ9FuUhcOtPVL3OAz+8cA46emfRDRZ3nlWO9zNWR6/KXXjiLP5hM7skukVbE5bgggYB4=
X-Received: by 2002:a05:6122:4a11:b0:4ac:2054:6a27 with SMTP id
 ez17-20020a0561224a1100b004ac20546a27mr4568671vkb.2.1702325237431; Mon, 11
 Dec 2023 12:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
 <20231206105419.27952-5-liangchen.linux@gmail.com> <CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
 <CAKhg4t+LpF=G0DBhbuRYtxKyTrMiR3pSc15sY42kc57iGQfPmw@mail.gmail.com>
 <CAHS8izPpWZvOSswHP0n-_nBiUMw8Ay2iM4yFE-HZenHv51iBHA@mail.gmail.com> <20231211113203.2ae8bccf@kernel.org>
In-Reply-To: <20231211113203.2ae8bccf@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 11 Dec 2023 12:07:06 -0800
Message-ID: <CAHS8izMPKJZz=n2CoEiQv+HsC_QKRLm3Wk4V-cq7Jvv=Vr=y9g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 10 Dec 2023 20:21:21 -0800 Mina Almasry wrote:
> > Is it possible/desirable to add a comment to skb_frag_ref() that it
> > should not be used with skb->pp_recycle? At least I was tripped by
> > this, but maybe it's considered obvious somehow.
> >
> > But I feel like this maybe needs to be fixed. Why does the page_pool
> > need a separate page->pp_ref_count? Why not use page->_refcount like
> > the rest of the code? Is there a history here behind this decision
> > that you can point me to? It seems to me that
> > incrementing/decrementing page->pp_ref_count may be equivalent to
> > doing the same on page->_refcount.
>
> Does reading the contents of the comment I proposed here:
> https://lore.kernel.org/all/20231208173816.2f32ad0f@kernel.org/
> elucidate it? The pp_ref_count means the holder is aware that
> they can't release the reference by calling put_page().
> Because (a) we may need to clean up the pp state, unmap DMA etc.
> and (b) one day it may not even be a real page (your work).
>

Thank you, that makes sense.

> TBH I'm partial to the rename from patch 1, so I wouldn't delay this
> work any more :) But you have a point that we should inspect the code
> and consider making the semantics of skb_frag_ref() stronger all by
> itself, without the need to add a new flavor of the helper..
> Are you okay with leaving that as a follow up or do you reckon it's
> easy enough we should push for it now?

I think the rename from pp_frag_count -> pp_ref_count is a huge
improvement, and I think the fact that the netstack has a way to
obtain a reference on a pp frag is also a huge improvement. Please go
ahead mearging this if you like, I was asking questions for my own
education/follow up work to consider.

--=20
Thanks,
Mina

