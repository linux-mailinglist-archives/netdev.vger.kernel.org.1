Return-Path: <netdev+bounces-26767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DE778E5D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C1B1C21520
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9353B7499;
	Fri, 11 Aug 2023 11:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84849A46
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:56:49 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7C11F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:56:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so29518331fa.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691755007; x=1692359807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlIpcqu8wK8HTCtcfR+oK+3O6isNyxHSGr7uDqooWXM=;
        b=mopyDTmSVPh+h2HcngPoY2UTWTtLrSHmsw9pedYh+BmpsSm7J43EkcUttqudQ9Mdwk
         8isQIiepKZx/Ltg7nJ+y8TZ0iSJla8jBMG6hmVHO2FPRZ9dSJZ3ktR6RECfSQ5HPKnUs
         AXk8B5Ak7oGEPCKfsT3ZZYzd8sTYRwa8cgt3szeXHHQnMfWBRBzZ6yf8s2cLqe3COPFO
         8yDPcEZdCKjTObJWwOtFj+45PAgeovuQdwMv7rSav7AF6QwFN5Xp4Lfr05+tRrW/14dJ
         2ZDRIaUCZMARJf7Hnr03zYhd4BnjarIXL741vpu2sSFdUR/bvYxPMLhPXbXFmn+RTnRC
         rcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755007; x=1692359807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlIpcqu8wK8HTCtcfR+oK+3O6isNyxHSGr7uDqooWXM=;
        b=W4Ux73qt0s9KkMV8C84nxgV2vq3kNjxN+d4oOfv06Jm/ql0k2ckm79fjQKMeYeherP
         mBek4BaWFMtYM49Z2nBqzuU/9441SH5RMcW91V1vJEEZHs/H8sEsBziTBT4odvbHszRj
         VXz+jD0icRKdmmtKnJPNbAlkUTHo+V3Id/kILEPngDCXt3Myp0e6kAkSw16gtkNn7rk+
         7Qk4PmvcYFIDEK7s5mBubKYZaRe32zGqd42y+xAMPYw42S6zRji2ah6Y1UNEa3bWWCSS
         i6OSDvCpJfiYmV/9MqqGXR82yeFdZ0g+9AAMcaTNE6WBqajbtpRD216ECzygYQKwhl+v
         8AZA==
X-Gm-Message-State: AOJu0Yy+Zv8ZRlZseneG/LB6S6JtbehsVgMXlagt4SBbO0q/Rg+K6bG0
	ObXB+FeEBKx8rkbugghHwYfWBo/daQ8Z2NEtW7A=
X-Google-Smtp-Source: AGHT+IGSpUS9VvoMx7iXNHvYB/dvDFK6lvUiS35lyzkNojp7FuvV144hZJe1h9Kk8TFL2qMVv6NsbffM+yLr8TCKL2g=
X-Received: by 2002:a2e:9b8f:0:b0:2b9:eb0f:c733 with SMTP id
 z15-20020a2e9b8f000000b002b9eb0fc733mr1400941lji.35.1691755006457; Fri, 11
 Aug 2023 04:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com> <ZMj4CdJe7m25OlGj@kernel.org>
In-Reply-To: <ZMj4CdJe7m25OlGj@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 11 Aug 2023 19:56:34 +0800
Message-ID: <CAKhg4t+k62kNVMwdPo36bAK8eSc1MJrxsOQgMMMJ_TvKbLc+gQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linyunsheng@huawei.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, ast@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:18=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Aug 01, 2023 at 02:19:31PM +0800, Liang Chen wrote:
> > The failure handling procedure destroys page pools for all queues,
> > including those that haven't had their page pool created yet. this patc=
h
> > introduces necessary adjustments to prevent potential risks and
> > inconsistency with the error handling behavior.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
>
> I wonder if this should this have a fixes tag and be targeted at 'net' as=
 a
> bugfix?

It doesn't trigger a real bug at the moment as page_pool_destroy
handles NULL argument. So may not be suitable for a fix tag.

Thanks,
Liang

