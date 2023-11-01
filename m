Return-Path: <netdev+bounces-45514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094B7DDBF3
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 05:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88715280F8E
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5311390;
	Wed,  1 Nov 2023 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jHizBOY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31E10F2
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:51:20 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBACFC
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:51:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so4548a12.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698814276; x=1699419076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtCv4uG/OXM/B1BEBS+Fmutn+hm813UycnKuzQVP7jE=;
        b=3jHizBOYcML+9JVIgjk33Bvx200q9GecNc9xu3/5kB9w0rgjUWP2319hRbkd4QSpl8
         BIbE6eyq/HbcSBRZR+1433YqzntSkyp/WG53LdouhwnBWcthvM0ULoanZHuDmdp2vQzd
         LTHa8xWo/Y48cE8O3bz+qNsr6Ab742t1nYCgnjuOTjULJK2t1nY8cC5xVM2BkL+wEpRq
         bPiSKm6doGmDixaRdhqK7r1nqyIsOHO9Xic9r/3iNN7F/IdkF80kJF6wKrmxVQOgw0PE
         /zzbvSkRtUMKk73MquXSFgfME91ShNRvN6wHAzOTbOxhUrTVNjJEJ8qbRVc3/gaoSUTk
         1VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814276; x=1699419076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtCv4uG/OXM/B1BEBS+Fmutn+hm813UycnKuzQVP7jE=;
        b=VCal+oySWi4Wy0umUS7nrdj95EtwVKBqXmSwyDgYL1UAa4UU4slO7pNCa8dRKqUvBS
         J7yFzNjeTk0wFCmh8tpNbcYlAJE6eq49CCZRqLM9HUkiLpe3PH+nh6lq4Z7wwedAh/1G
         YHp612AJjxIYNnq/7vLQgIM07eodkOfxbFsulGJbej858BYjjzIWT324Tx6enTNfxBRf
         JqTfYf/+docvm3EmvSe7BrSH51NbQv+/8Xno5WzUD6+IIwQ9Qo53kdkiK4cxdQ0B8QCS
         2Vlm8/b0uyDJmdPsD/18pSEoXfKsttsKobdQDp7Mou0mWLonxJXWJpQ5zFCNkyhjdpov
         SiDQ==
X-Gm-Message-State: AOJu0Yzk3G7rQZs0ep3n9t6bjlqNaywdGTHJgM+IQHb2xDJs1o/7GhJ8
	fuKYtc1UTl7Ux7Jpe4nr8Jb+eKtG4WP31f8rT6y3Jg==
X-Google-Smtp-Source: AGHT+IG1a4+d2onDesPfbMcPoMuS3zsQ3O9VgdzWLfs5Oes0xMUVSoJdoFVmwMemPip99YH29m6tfyjIwu1s5dNiEs8=
X-Received: by 2002:a50:99cf:0:b0:543:6397:b46d with SMTP id
 n15-20020a5099cf000000b005436397b46dmr202885edb.2.1698814276242; Tue, 31 Oct
 2023 21:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
In-Reply-To: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Nov 2023 05:51:05 +0100
Message-ID: <CANn89i+_xggUyAc4F3vBuH=5PtkCfrLcF77poKJU2N1BMc_1MA@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp_sigpool: Fix some off by one bugs
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:51=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> The "cpool_populated" variable is the number of elements in the cpool[]
> array that have been populated.  It is incremented in
> tcp_sigpool_alloc_ahash() every time we populate a new element.
> Unpopulated elements are NULL but if we have populated every element then
> this code will read one element beyond the end of the array.
>
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis and review.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

