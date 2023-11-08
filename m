Return-Path: <netdev+bounces-46573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22C7E507D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 07:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4911F21699
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5281FBA;
	Wed,  8 Nov 2023 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr0+Nu0m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755622CA8
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 06:50:12 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F01BB
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 22:50:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso8727486e87.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 22:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699426210; x=1700031010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj1SjOxscHUBMRy7goeHFLsfnNjN3NgtJTfxJ1J60iw=;
        b=tr0+Nu0mKrg9QY/hwbfP27dtKg+dk6SGivrVnHukGP295NaNMzozQz32ypMAF5mnPj
         Szbnzt5bxUa/GW+EpZyCN7/60Owz0CK5VeUPPiPpgdxTZ56ZmeOPGGK10qo6qOejBnsG
         BHWHvveRAVhlAgOxZfXJBDQh+6uB5FbbxyJXCtNSHeECOhoBbTFZDF/ty6Q2csVdCwaN
         h+HzC0RDzVnW2UUpwPFYTRdUg+rwpRqrMr7a+2ozKocaBFbre8+YyVN2eApxw649i+wi
         DaIKkifOroQKgdWSydPHZii9u8MUiR8lNzzOLPuLb5prYXd9qyeNw/suM/Qs0Yy0+kKh
         J5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426210; x=1700031010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj1SjOxscHUBMRy7goeHFLsfnNjN3NgtJTfxJ1J60iw=;
        b=aov3VbMV4ilfOaGZUiSxAzOdk5G4lmHdXFvAhDEWGC585IbD4QZYoQB2+w33QmW9w3
         /ywv70s/eiND2P5otxPPFzHJHN8X8X+P0ZGBvzMjTzb4OpVx8A/9vaxX2Iuw2pOQi3xo
         3D8eWCMaYhVCVi4hW1+crkbU8lFSeOvxOWUlnF0qrQ7HKyH07g/s45vgICoogBEAvKTJ
         UXs8MzAk/jwIzEihCgHEbVuUK5NMbar49qXpY+cyMY3Lbj7ciA85fY/BnXwWpqtEBvP5
         EmqaXvEH7K0yD05TrDcP42wobnUaxWrvdGNMklLqa/NTOr5ttayHyHypFfSNWJbhP+Dp
         9sqg==
X-Gm-Message-State: AOJu0YwTeAU8E6psNHXXqVOmxnCA+Vnl/E1EApamtKnXXKuxA5IeS33i
	WCIq5T+iOy2RkLXZCvoIN2WcOGRNlN8kCazqJjacnQ==
X-Google-Smtp-Source: AGHT+IF/VM1khp0jlqPu7O5w8l7z9ZCehGcEObKp5Itl34eSe8oONj2aAIAYYWZz5PRH8db3FqYM64LJ7sABqUEYbXY=
X-Received: by 2002:a05:6512:3d1e:b0:507:a001:792e with SMTP id
 d30-20020a0565123d1e00b00507a001792emr595092lfv.46.1699426209850; Tue, 07 Nov
 2023 22:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107123825.61051-1-linyunsheng@huawei.com>
 <20231107094959.556ffe53@kernel.org> <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
In-Reply-To: <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Nov 2023 08:49:33 +0200
Message-ID: <CAC_iWjKbXeUxcTTS-iUX-vSprwTDCxNw1rTVZbkQGgKb_pxxzA@mail.gmail.com>
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in MAINTAINERS
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Wed, 8 Nov 2023 at 05:31, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/11/8 1:49, Jakub Kicinski wrote:
> > On Tue, 7 Nov 2023 20:38:24 +0800 Yunsheng Lin wrote:
> >> I have added frag support for page pool, made some improvement
> >> for it recently, and reviewed some related patches too.
> >>
> >> So add myself as reviewer so that future patch will be cc'ed
> >> to my email.
> >
> > Not sure what to do about this, it feels somewhat wrong to add
> > as a reviewer someone who seem to not follow our basic process
> > requirements:
> >
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> I reread the above doc in order not to miss anything obvious again:(
>
> I suppose basic process requirements mean:
> 1. designate your patch to a tree - [PATCH net] or [PATCH net-next]
> 2. don't repost your patches within one 24h period
>
> For 1, somehow I got the impression that changing to MAINTAINERS
> can be targetted to net branch, so that the change can flow to other
> main trees quickly, maybe I was wrong?
>
> For 2, yes, maybe I should stick to the rule even if it is a simple
> patch and obivous format error.
>
> Please correct me if there is anything else I missed.

FWIW Yunsheng has been helping a lot with patch reviews. So once the
procedural issues are resolved, I support having him as a designated
reviewer

Thanks
/Ilias
>
>
> >
> > :(
> >
> > .
> >

