Return-Path: <netdev+bounces-33772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE5E7A009E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69081F229AD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B72AB49;
	Thu, 14 Sep 2023 09:45:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF65224FF
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:45:53 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BFE3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:45:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68faf930054so595294b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694684752; x=1695289552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABHVfDC2iAbCwRgnkxRkxCO+/onKzfRGAhuwY8qhVa4=;
        b=JnGYhyhhB0F/tANdCfBpo7F7o8JH5gVW0i6wXG9iuZDkbJcOe/JSEyrfy03nhHF71B
         eOw/aqaMjQZYTNBv/nEThPrHGXS5fs2jUCxzoYlSeV6ElTX6S2S3CmLE7MwFgPu3W9vi
         ckvpceH6wPIqnLHBRvuW9EhJs+HxZUNf/nQSNvm/6uETXcDzfBjv/FfcCaKk2Zh71Vc0
         pBt4UC3dj/J32IZI/i+CGWZSR4F7RqDISnOEibdBlWRr1vYaSzkqWgdw2LB7QSIPRMjs
         VK3ZwoaZ8i8aIjYHphZS7O6HpFhvT5BMFu+OHqv/R3yPticay3BK3nymsLPj4AL+dMrF
         lg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684752; x=1695289552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABHVfDC2iAbCwRgnkxRkxCO+/onKzfRGAhuwY8qhVa4=;
        b=BimqtQtFD28Bfk9QiQejBc6j8bKFt9OGFXFFmb1wY61dzxY/bOpFEJi3S584CieeY1
         VD1uMCOMulVPlzdkHTgGjvQn6e2bswN+BKxp+1770AxxT6g7OlMEi9B6b5PxH1sGWqoa
         ARJYgYVeO3t8ZWV6TqSQqUr5IDlSNtr5HIC23lgnEVlyznkzPhoUNT5I/XsVHv6H6QhY
         n9pwtA6MF9kqd887eggSfT2VNVZ/dOdvp1lmEhvvIUknX1FZRp1s+qqYJaTqYFG4sG1i
         k5BQB/G1Rx6LQFdTO0OYXitDiHd/n9i012MSdzq6B6F3W1yQfeBoPOxEv7ajVUCoyuNC
         blMw==
X-Gm-Message-State: AOJu0YynvwUFEgyzj+rw/Zzo3k8Meg5IuzfiDbK4zFAy2nqA6YLxYKJN
	kfx9+UE2iaZy+jzTubBrWGkMAWbeJB1Ipw==
X-Google-Smtp-Source: AGHT+IEpXMqba98QystYW9Wn248wKxUfCrD/w/IvSbOKvSbGTSBGwRuVx61C0awQY4LGWjOUT347Ug==
X-Received: by 2002:a05:6a21:a582:b0:159:f884:4d6e with SMTP id gd2-20020a056a21a58200b00159f8844d6emr796118pzc.40.1694684752452;
        Thu, 14 Sep 2023 02:45:52 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78c44000000b0068fe76cdc62sm1000088pfd.93.2023.09.14.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:45:52 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date: Thu, 14 Sep 2023 17:45:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZQLWT19RMitSMoyr@gondor.apana.org.au>
References: <cover.1694018970.git.sd@queasysnail.net>
 <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
 <20230906204727.08a79e00@kernel.org>
 <ZPm__x5TcsmqagBH@hog>
 <ZPq51KxgmELpTgOs@gondor.apana.org.au>
 <ZPtACbUa9rQz0uFq@hog>
 <ZP/rS+NtSbJ3EuWc@gondor.apana.org.au>
 <ZQG4SXGaJpCtWX_k@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQG4SXGaJpCtWX_k@hog>

On Wed, Sep 13, 2023 at 03:25:29PM +0200, Sabrina Dubroca wrote:
>
> Does that still look unsafe to you?

You're right.  It does ssem to be safe but the use of a spin lock
as well as a completion looks a bit iffy.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

