Return-Path: <netdev+bounces-31407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16978D652
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8E21C2083B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364563BC;
	Wed, 30 Aug 2023 13:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8163AF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 13:49:32 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C4E8
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:49:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so7702482a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693403370; x=1694008170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EveZugbAyHXaF9qXTDApTq/+4nKeho781IKcvu6YLao=;
        b=wgXoxtrxRyyYi0xw7z1++f4aZnGb3I40QMLbWi9cWM4YdJB6G3NHp93RgeLUE569jN
         3CtBsBHoSVSmZuxpKLDNwZL/KB+uzkgXKRnKfzGWW33g/S57WrAqAUaEcq+t9YN/3BbJ
         Wuk5y0MujY5yRRZbbEOWBcZhVzKO7beBau4s068p073+Gnn2LHXYFsJ2Lc1ee7hXLO5W
         /PRS6ERbNzuSNEbH3fIz/0a2OEkzKzlMls2RHO5Bl2iUcCjpbBysEIx537TsNzG3o2NF
         Gt3Hb/krYWjqAohKnScWF/NYAIkFxvk3+YZr4NJROClRqrYKTEpLE/0qjIvX1dP1NDtu
         BgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403370; x=1694008170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EveZugbAyHXaF9qXTDApTq/+4nKeho781IKcvu6YLao=;
        b=ds8ubUwAlyHOcupDLcdWDaRPzKC3qUc2Y0MfVq1ypG7CQB3VbUqcroddlaqCb4fzhL
         GHcovMTvHHlrcZhSoFnRBZaclyQS6WGckCbkU7OLAYj2mgy8uJ8riQQUj+89i+l7ZXJf
         BiXcfDHep4TsVThKttfe56r5lXSkmUjBqqAtc92YbsDijhv3XvBDXbQNKSthbDfhEPza
         S8MkzLiaH9RmHXSpgCejzgSuSSbQU3eqRhBMfsbQlgeqmk6VVVXS2PF8mfzypP54DrbI
         zGIx4p9tqlq6jBYFp3x+ZEWLqsYTh0+LzBiOSc5+UJ3d/oJZPa/X39EOIs31h5io8UPh
         8CGA==
X-Gm-Message-State: AOJu0YytkPJgx80Di/3iHSfnDvvLA9Nyk3HkuKNFzy30b+q5xQ5vhUHL
	2ZnonHtwrcHxPDt1Ja03XMT9XQvZ8pk8+8/f/7Egew==
X-Google-Smtp-Source: AGHT+IEcTzOgogfok30Ls9E+P4NNNCftFC6Zfon4QcbNqGg85ozI4svJ8XlOjgT+g0+T5CAwfuyrTf0kWxhSlqmbACM=
X-Received: by 2002:a50:fa87:0:b0:523:5012:63d5 with SMTP id
 w7-20020a50fa87000000b00523501263d5mr1929522edr.16.1693403370357; Wed, 30 Aug
 2023 06:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 30 Aug 2023 15:48:53 +0200
Message-ID: <CAMZdPi_Pni06Y4ZLEQ+5FYyzXxKU+zYFhygEmyc7MmBih4ixMA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: haozhe chang <haozhe.chang@mediatek.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 28 Aug 2023 at 15:22, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
>
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

