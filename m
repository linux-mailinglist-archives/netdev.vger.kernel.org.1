Return-Path: <netdev+bounces-19345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481C75A54D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 07:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CA5281C56
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25341C01;
	Thu, 20 Jul 2023 05:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93A17F4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:01:36 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE826AA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:01:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so133341cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689829292; x=1690434092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1r+7M+7iduJCuOH1Pptct5pU9CyBnmIFvAwXH3+btA=;
        b=Zw0jRu3YJyQog84YWvutJlhtz2wzjYGuxxSi7UhzbSeaZ52sLr7xaYAoprEUkuI7VO
         kgsjXA5OaR87TPg1oeGLaFnFm3Fr/sBLIV4r8JuPcn04ZTq3WJR0BFqZiiB3zDX8sk0Q
         vrhJxl4cgwS7OZHPp3KhsJVpgavJeg8DUJ2yFA3BQA/0wRSqvl4nQoPRHMJPqVKmKDiL
         g2biidjajRr0kPwYV1ln5R8p5e4OxlgBiUt8d5QWKstZNlgrmFNPXg4lmbuOqlK7s+Ji
         b0ilW2LIHxz5pXwdPdItqV7umH391Dr+mJb+ufpW1tPbEnOkl8m2QMkfUFgE6l4uawOQ
         G1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689829292; x=1690434092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1r+7M+7iduJCuOH1Pptct5pU9CyBnmIFvAwXH3+btA=;
        b=dgYL6W7/P3fOpvP/xT22VKb3vja5gCMMHCt8OobzdstRW+jfvTbhwVFOm9gdpdv0F0
         hqc7xbl8OIIOFG8DJrTXJWyXggcUE3aBGkffo+YkfOnW7IuOq4GVTb7IkPHjBdQSqb5F
         NNmNECERnkrKcBinJZ5cdCFTeSMhMw/vyk3E3yhleGPWqmwye3+dckLfnzg/84nrdURr
         mZ+/eEcEUjHPwdkX5WLxOEvi/Fnn3p0G6Uy/Tcw7/FwzLZos5AuciViRhW5SrKDE4fuZ
         BNYxt87T9tTv9VflXiZ7Yc6bUONf3+I2GGCBATmgt3yIAIHpqUtkmRVItwXNV0Cht7yF
         GtFQ==
X-Gm-Message-State: ABy/qLbkxCAOdBVHj7g8AxELAPAwaJq9jndPr1rhPbXX+2RyNDHsWkDE
	ImuS0APJxZQDGD6Pz26WHNufCRwS5cq8zfuCLolm2g==
X-Google-Smtp-Source: APBJJlGH0VQ+vUwSbKdi7EttuKPp+F8VLSMO8DSLKsRsQ4a45v/0GA7QlmPTSmnDgw7MT5JIWVzqOIucwkfO6SEmWuM=
X-Received: by 2002:a05:622a:1449:b0:403:58e8:2d96 with SMTP id
 v9-20020a05622a144900b0040358e82d96mr117408qtx.7.1689829291995; Wed, 19 Jul
 2023 22:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720005456.88770-1-kuniyu@amazon.com>
In-Reply-To: <20230720005456.88770-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 07:01:20 +0200
Message-ID: <CANn89iLmNtDp7gK2xo_znvh+9-JUyNAW7E2xieLkpBMth96DBw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 2:55=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3") started
> applying strict rules to standard string functions.
>
> It does not work well with conventional socket code around each protocol-
> specific struct sockaddr_XXX, which is cast from sockaddr_storage and has
> a bigger size than fortified functions expect.  (See Link)
>
> We must cast the protocol-specific address back to sockaddr_storage
> to call such functions.
>
> However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
> unclear as the buffer is defined by char[128] which is the same size as
> sockaddr_storage.
>
> Let's use sockaddr_storage implicitly.
>
> Link: https://lore.kernel.org/netdev/20230720004410.87588-1-kuniyu@amazon=
.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

