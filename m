Return-Path: <netdev+bounces-34220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B207A2DC6
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07041C20BEF
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D06130;
	Sat, 16 Sep 2023 03:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCA6134
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:37:56 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA90C7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:37:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-69042d398b1so1419803b3a.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694835473; x=1695440273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MamcEDvOme4a2UOw6srKCp4ogqANdQEsNNNirgmTbh4=;
        b=kcAaR/gXGi8eEoBS7ThrW6Ba3SVgdi1kvFkpwLwUviJAXPvQkRjdJu7QdL9+VVMGSq
         uLZgvrT49js/XYquUSKj13xxLbCVN1RmPw3G8S7a2+3CcsRDuc+x3V3lDAuxqXl0juJl
         T3bYbat4QK6i0uxT0+T5mPMb45lScQ8fuBYHx1jW6JqUucrLLT8npRChfmpBmBSIDky0
         eklbqG3kX+ZzgdClYw1+nh6FCbyRsM7qUG9GKFALc9dEXH+Et/veJ/ARdm3LbtrS/ATa
         0g4zuSzaHmALELtsLYDO4wiAWfLp1ugy4F8gejY22wi1+enB1TSL4EUUC2t20MOp/YfR
         XLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694835473; x=1695440273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MamcEDvOme4a2UOw6srKCp4ogqANdQEsNNNirgmTbh4=;
        b=N+qxz5Wi/V9RYFKJRqeFgLzhrnRReOsKPCCBE6G6Yt5F+FXLmRMfNwQmjQoSEYBF+6
         qBPNNKbSH2QNhWTcJJ6Y2Rxc/0s+FIT2T5TE+BFkHAKOBvLJhEDNe5NHWSp3VDlZb9Gp
         3IzQrXqA+cKZbFh/t6CoP3OSpXlyUdAa/Zt1RE5KAeJgUYtNYQggcXOHt5QDexePUGNY
         0mBGpoFlc7YulBFOZa5TIURzFYXb2N0awIalWS7e3oPRLDk0w+ZnJoPocAnMCqleFmYh
         gw8xtSPSwLfh3WUOWG0CSwSZxpvNUj9IfSEtuxCQEnu7+1TIL0CmrN3hP0GPbzpmafr/
         BZpw==
X-Gm-Message-State: AOJu0YyeaIgJWhl2RszUyvipNDvgJkS/1lUE5vsMIfBfbfP0pb4mA4iI
	Lc6Pdbvty0kuyvubpcLpd+KKK9BbBV99XQ==
X-Google-Smtp-Source: AGHT+IGn6S2xCOQh//vR4rS05z7qGzMvUp83sDyYD4Ok01CZ3JZk6tO6zadOMbgIsEAl7do7p0V73g==
X-Received: by 2002:a05:6a20:9703:b0:14d:446f:7212 with SMTP id hr3-20020a056a20970300b0014d446f7212mr3607639pzc.46.1694835472990;
        Fri, 15 Sep 2023 20:37:52 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001bdc8a5e96csm4225959plr.169.2023.09.15.20.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 20:37:52 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date: Sat, 16 Sep 2023 11:37:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander Aring <aahringo@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:05:06AM -0400, Alexander Aring wrote:
>
> My question is here? Is that allowed to do because a resize event may
> change the order how to iterate over a rhashtable.

Walking over an rhashtable should be a last resort.  There is
no guarantee of stability.

If you skip entries after a resize then you may miss entries.

If you want a stable walk, allocate an extra 8 bytes and use
a linked list.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

