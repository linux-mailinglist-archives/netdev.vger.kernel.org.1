Return-Path: <netdev+bounces-31092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92F78B671
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D9280E53
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC813AEF;
	Mon, 28 Aug 2023 17:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7513ADC
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 17:30:22 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4AEE1
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 10:30:21 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44d5a0d2d86so847457137.2
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693243820; x=1693848620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2WXMkuXavCrvB5E1bSmvUXIa9Xz7X0iJQJfaZFxRihk=;
        b=C8lvsFNOYMem0PLD28/tzEAE2qEIzHidIey+CQoeI/aBZ0YTVeFVWYombQUGViO2+t
         W+80eJyqOHVAhZryw0bNoYX3j/u3RqY/2VyNLWozWheCAXYLfsy/KIYqgCFnx1sFctD0
         p2186BC1f9D4So9WK6jNJQGqgNlb7+Lja2enTtdMHhCtoNj2eUKz2kLeO5be6yyyL+lF
         RdVmYG4sDir0f1W8QK+9BrR5dPRK+3o0W+LIVIpDg8HDpY+UqWCIMMxE45JqAlv43aCH
         +6F0q9p4NMRxZRB4hzh9Oe+sr5oOX9C5kkiVwlU2BIH1WtM4s3T9DgcxAVgrZzlRWRZT
         FmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243820; x=1693848620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WXMkuXavCrvB5E1bSmvUXIa9Xz7X0iJQJfaZFxRihk=;
        b=FDLP8i0LY0374A3u0CULqjxiNfXUrT0mRmnYSUhOhtON+qq4vNrqCiJOdMFPS6dVGI
         TaX4UaCYJ9mqhR3MZpgwUCfdrvyKT4Zc1aJRJjuWNyp2uGt5uebEZUf1xS2H5jh7FqUT
         T7SRzowGl5twRoPuOBeqS8S+sOHBZFjIwyaPzmfCtDqpZWCMIglZrTE5kUrxcPgsig0U
         BXSs6LG4X4j8mTTBcS87SAZpbgq5W6DbCU++MSPOlNlayF3AtwckzBsiyo8JtM/HS8n7
         2MFlO3b0CnYxd450UEql8tJCOC4G+cu4pmYvRjdf/RwZOas10FZr5Rxfy5EeCHZTdSDW
         L5GA==
X-Gm-Message-State: AOJu0YwbEN/L9KA25BkRdpODWnzjhsRccFTj5nSPCpiWoO21wHpWUXGj
	baUENGV6nthd/KnbbbDnyQjftg+kaFHu9FqpK6oK8w==
X-Google-Smtp-Source: AGHT+IGgcJ/msAlUq9iW+kDjKzwJiwE02t53bR7UOEBKquUn9g7lTmqYj/TpdAvPJIlxRJNe5bMBS4W5kuKO4v5LwKk=
X-Received: by 2002:a67:f8d5:0:b0:44e:9a71:27a1 with SMTP id
 c21-20020a67f8d5000000b0044e9a7127a1mr7609225vsp.17.1693243820627; Mon, 28
 Aug 2023 10:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
 <2023082853-ladylike-clanking-3dbb@gregkh>
In-Reply-To: <2023082853-ladylike-clanking-3dbb@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 28 Aug 2023 23:00:08 +0530
Message-ID: <CA+G9fYtS-Pe0L9PsjTdEjnysuX9Ax+04jgZSkJAFqsGHC1Xm=w@mail.gmail.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wfortify-source]
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: clang-built-linux <llvm@lists.linux.dev>, linux-stable <stable@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 28 Aug 2023 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 28, 2023 at 05:57:38PM +0530, Naresh Kamboju wrote:
> > [My two cents]
> >
> > stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
> > following warnings / errors.
> >
> > Build errors:
> > --------------
> > drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
> > will always be truncated; specified size is 16, but format string
> > expands to at least 18 [-Werror,-Wfortify-source]
> >  1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
> >       |                 ^
> > 1 error generated.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Is this also an issue in 6.5?

I see it on 6.5, Linux next-20230828 tag, stable 6.4 and 6.1.

- Naresh

